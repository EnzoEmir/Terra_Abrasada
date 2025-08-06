import random
import inquirer


def buscar_encontros(conn, id_pi):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT e.ID_Evento, en.ID_Inimigo, en.Quantidade, s.Tipo, e.Probabilidade, e.Prioridade
            FROM Ocorre o
            JOIN Evento e ON o.ID_evento = e.ID_Evento
            JOIN Encontro en ON en.ID_Evento = e.ID_Evento
            JOIN Ser s ON en.ID_Inimigo = s.ID_Ser
            WHERE o.ID_PI = %s
        """, (id_pi,))
        return cur.fetchall()

def criar_instancia_inimigo(conn, id_inimigo, local, quantidade, save):
    with conn.cursor() as cur:
        # Verifica o tipo do inimigo
        cur.execute("SELECT tipo FROM Ser WHERE ID_Ser = %s", (id_inimigo,))
        res = cur.fetchone()
        if not res:
            raise ValueError(f"Inimigo com ID {id_inimigo} não encontrado na tabela Ser.")
        tipo = res[0]

        # Busca os atributos base conforme o tipo
        if tipo == 'N':
            cur.execute("""
                SELECT HP_Base, Forca_Base, Defesa_Base
                FROM Nao_Inteligente
                WHERE ID_N_Int = %s
            """, (id_inimigo,))
        else:
            cur.execute("""
                SELECT HP_Base, Forca_Base, Defesa_Base
                FROM Inteligente
                WHERE ID_Int = %s
            """, (id_inimigo,))

        row = cur.fetchone()
        if not row:
            raise ValueError(f"Atributos base não encontrados para inimigo {id_inimigo} do tipo {tipo}.")

        HP_Base, Forca_Base, Defesa_Base = row

        # Criação das instâncias associadas ao save
        for _ in range(quantidade):
            cur.execute("""
                INSERT INTO Inst_NPC (ID_Ser, HP_Atual, Forca_Atual, Defesa_Atual, Save, Localizacao)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (id_inimigo, HP_Base, Forca_Base, Defesa_Base, save, local))

        conn.commit()

   
def processar_encontros(conn, id_pi, local, save):
    encontros = buscar_encontros(conn, id_pi)
    ativados = []
    for encontro in encontros:
        id_evento, id_inimigo, quantidade, tipo, probabilidade, prioridade = encontro
        prob = int(probabilidade)
        if random.randint(1, 100) <= prob:
            ativados.append(encontro)
    if not ativados:
        return False

    encontro_escolhido = max(ativados, key=lambda x: x[5]) 
    id_evento, id_inimigo, quantidade, tipo, probabilidade, prioridade = encontro_escolhido

    # Buscar nome do inimigo
    with conn.cursor() as cur:
        cur.execute("""
            SELECT COALESCE(n.nome, intel.nome)
            FROM Ser s
            LEFT JOIN Nao_Inteligente n ON n.ID_N_Int = s.ID_Ser
            LEFT JOIN Inteligente intel ON intel.ID_Int = s.ID_Ser
            WHERE s.ID_Ser = %s
        """, (id_inimigo,))
        nome = cur.fetchone()[0] if cur.rowcount else 'Desconhecido'

    print(f"\nQuantidade: {quantidade} | Inimigo: {nome.strip() if nome else 'Desconhecido'}")

    # Chamar com o save correto
    criar_instancia_inimigo(conn, id_inimigo, local, quantidade, save)
    return True



def inimigos_ativos_no_local(conn, id_pi, save):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT i.ID_Ser, i.ID_Inst, s.Tipo,
                   COALESCE(n.Nome, intel.Nome) AS Nome,
                   COALESCE(n.HP_Base, intel.HP_Base) AS HP_Base, 
                   i.HP_Atual, i.Forca_Atual, i.Defesa_Atual
            FROM Inst_NPC i
            JOIN Ser s ON i.ID_Ser = s.ID_Ser
            LEFT JOIN Nao_Inteligente n ON n.ID_N_Int = i.ID_Ser
            LEFT JOIN Inteligente intel ON intel.ID_Int = i.ID_Ser
            WHERE i.Localizacao = %s AND i.Save = %s
        """, (id_pi, save))
        return cur.fetchall()


def lidar_com_inimigos_ativos(conn, id_pi, estado):
    inimigos = inimigos_ativos_no_local(conn, id_pi, estado.save)
    if inimigos:
        print("\nInimigos:")
        for inimigo in inimigos:
            id_ser, id_inst, tipo, nome, hp_max, hp_atual, forca_atual, def_atual = inimigo
            print(f"{nome.strip() if nome else 'Desconhecido'} (Vida: {hp_atual})")


        pergunta = [
            inquirer.List(
                'acao',
                message="O que deseja fazer?",
                choices=["Lutar", "Fugir"]
            )
        ]
        resposta = inquirer.prompt(pergunta)
        if not resposta:
            print("Nenhuma ação escolhida. Encerrando o jogo.")
            exit()

        if resposta['acao'] == "Fugir":
            if estado.tentar_fuga():
                print("Você conseguiu fugir!")
                estado.set_localizacao(1)  #Volta para base
                estado.localAtual = 1
                input("Pressione Enter para continuar.")
                
                return "conseguiu_fugir"
            else:
                estado.print_clr("Você falhou ao fugir! O combate começa!")
                resultado_luta = estado.iniciar_luta(inimigos)
                
                if resultado_luta == "derrota_protagonista":
                    estado.deletar_protagonista()
                    return "derrota_protagonista"
                elif resultado_luta == "conseguiu_fugir":
                    return "conseguiu_fugir"
                elif resultado_luta == "vitoria_protagonista":
                    return "vitoria_protagonista"

        estado.print_clr("Você decidiu enfrentar o inimigo!")
        resultado_luta = estado.iniciar_luta(inimigos)
        
        if resultado_luta == "derrota_protagonista":
            estado.deletar_protagonista()
            return "derrota_protagonista"
        elif resultado_luta == "conseguiu_fugir":
            return "conseguiu_fugir"
        elif resultado_luta == "vitoria_protagonista":
            return "vitoria_protagonista"
    
    return "sem_inimigos_ativos"