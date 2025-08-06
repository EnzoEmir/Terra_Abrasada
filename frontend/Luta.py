import os
import random
import inquirer

class Luta:
    
    def __init__(self, conn, estado, dados_inimigos):
        self.conn = conn
        self.estado = estado
        self.dados_inimigos = dados_inimigos
        self.opcoes_luta = {
        'Atacar': self.atacar_inimigo,
        'Item': self.usar_item,
        'Fugir': self.fugir_da_luta
        }
        
    def luta_turno_prota(self):
        while self.dados_inimigos:
            print(f'\nTurno do Protagonista\n\nVida atual: {self.estado.get_hp()[0]}/{self.estado.get_hp()[1]}\n\nInimigos:')
            for index, inimigo in enumerate(self.dados_inimigos,0):
                id_ser, id_inst, tipo, nome, hp_max, hp_atual, forca_atual, def_atual = inimigo
                print(f'{index} - {nome.strip()} - Vida: ({hp_atual}/{hp_max})\n')
            
            perguntas = [
                inquirer.List(
                    'acao',
                    message="O que deseja fazer?",
                    choices=list(self.opcoes_luta.keys())
                )
            ]

            resposta = inquirer.prompt(perguntas)
            if not resposta:
                continue  # caso o usuário cancele com Ctrl+C ou Enter

            acao = resposta['acao']
            
            resultado_opcao = self.opcoes_luta[acao]()
            
            if acao == 'Fugir':
                if resultado_opcao == "conseguiu_fugir":
                    return "conseguiu_fugir"
                
            if resultado_opcao == "voltar":
                continue
                
            if self.dados_inimigos:
                resultado = self.luta_turno_inimigos()
                if resultado == "derrota_protagonista":
                    return "derrota_protagonista"
                elif resultado == "turno_inimigo_finalizado":
                    os.system('cls' if os.name == 'nt' else 'clear')
                    continue
        
        if not self.dados_inimigos:
            print("Todos os inimigos foram derrotados! Você venceu a luta!\n")
            return "vitoria_protagonista"
        
    def luta_turno_inimigos(self):
        while self.dados_inimigos:
            print(f'Turno dos Inimigos\n\nVida atual: {self.estado.get_hp()[0]}/{self.estado.get_hp()[1]}\n\nInimigos:')

            # Turno dos inimigos
            for inimigo in self.dados_inimigos:
                id_ser, id_inst, tipo, nome, hp_max, hp_atual, forca_atual, def_atual = inimigo
                
                def_prota = self.estado.get_def()
                dano = max(0, (forca_atual - def_prota))
                new_hp = self.estado.get_hp()[0] - dano
                
                if new_hp > 0:
                    self.estado.set_hp(new_hp)
                    print(f'\nO {nome.strip()} atacou você e causou {dano} de dano!\n\nVida atual: {new_hp}/{self.estado.get_hp()[1]}\n')
                    
                    if tipo == 'N':
                        with self.conn.cursor() as cur:
                            # Busca dano de radiação do inimigo não-inteligente
                            cur.execute("SELECT Nivel_Rad FROM Nao_Inteligente WHERE ID_N_Int = %s", (id_ser,))
                            row = cur.fetchone()
                            nivel_rad_inimigo = row[0] if row else 0
                            
                            if nivel_rad_inimigo > 0:
                                rad_atual = self.estado.get_radiacao()
                                new_rad = rad_atual + nivel_rad_inimigo
                                self.estado.set_radiacao(new_rad)
                                print(f'O {nome.strip()} causou {nivel_rad_inimigo} de radiação!\n')
                            
                    input("Pressione Enter para continuar.")
                else:
                    return "derrota_protagonista"
                
            return "turno_inimigo_finalizado"  
                    
    def atacar_inimigo(self):
        self.estado.print_clr(f'Qual inimigo deseja atacar?\n')
        
        escolhas = []
        
        for index, inimigo in enumerate(self.dados_inimigos, 0):
            id_ser, id_inst, tipo, nome, hp_max, hp_atual, forca_atual, def_atual = inimigo
            linha = f'{index} - {nome.strip()}: {id_inst}'
            escolhas.append(linha)
        
        escolhas.append("Voltar")
        
        pergunta = [
            inquirer.List(
                'inimigo',
                message="Escolha um:",
                choices=escolhas
            )
        ]
        resposta = inquirer.prompt(pergunta)
        if not resposta or resposta['inimigo'] == "Voltar":
            return "voltar"
        
        entrada = resposta['inimigo'].split(':')[1]
        entrada2 = resposta['inimigo'].split(' - ')[0]
        index_inst = int(entrada2)
        id_inst_ser = int(entrada)
        
        str_prota = self.estado.get_str()
        hp_inimigo = self.dados_inimigos[index_inst][5] 
        
        def_inimigo = self.dados_inimigos[index_inst][7]  
        new_hp = hp_inimigo - max(0, (str_prota - def_inimigo))
        
        if new_hp > 0:
            self.set_hp_inimigo(new_hp, id_inst_ser)
            inimigo_lista = list(self.dados_inimigos[index_inst])
            inimigo_lista[5] = new_hp
            self.dados_inimigos[index_inst] = tuple(inimigo_lista)
            self.estado.print_clr(f'Vôce atacou o {self.dados_inimigos[index_inst][3].strip()} e deu {hp_inimigo - new_hp} de dano!')
        else:
            self.estado.print_clr(f'Vôce matou o {self.dados_inimigos[index_inst][3].strip()}!\n')
            self.inimigo_dropar(id_inst_ser)
            self.deletar_inst_npc(id_inst_ser)
            self.dados_inimigos.pop(index_inst)
        
    def usar_item(self):
        # Por enquanto só retorna voltar, precisa implementar sistema de inventário
        print("Sistema de inventário ainda não implementado.")
        input("Pressione Enter para continuar.")
        return "voltar"
        
    def fugir_da_luta(self):
        if self.estado.tentar_fuga():
            self.estado.print_clr(f'Vôce conseguiu fugir! Voltando para a base...\n')
            self.estado.set_localizacao(1)  
            self.estado.localAtual = 1
            return "conseguiu_fugir"
        self.estado.print_clr(f'Vôce falhou ao fugir! O combate continua!')
        return "falhou_fugir"

    def set_hp_inimigo(self, novo_hp, id_inst_npc):
        with self.conn.cursor() as cur:
            cur.execute("UPDATE Inst_NPC SET HP_Atual = %s WHERE ID_Inst = %s", (novo_hp, id_inst_npc))
            self.conn.commit()
            
    def inimigo_dropar(self, id_inst_npc):
        with self.conn.cursor() as cur:
            # Busca o id_ser do inimigo
            cur.execute("SELECT ID_Ser FROM Inst_NPC WHERE ID_Inst = %s", (id_inst_npc,))
            row = cur.fetchone()
            if row:
                id_ser = row[0]
                # Busca os itens que o inimigo pode dropar
                cur.execute("SELECT ID_Item FROM NPC_Dropa WHERE ID_NPC = %s", (id_ser,))
                drops = cur.fetchall()
                for (id_item,) in drops:
                    # Por enquanto só mostra o que droparia, sem sistema de inventário
                    nome_item = self.get_item_name(id_item)
                    print(f"O inimigo dropou: {nome_item}")
            self.conn.commit()

            
    def deletar_inst_npc(self, id_inst_npc):
        with self.conn.cursor() as cur:
            cur.execute("DELETE FROM Inst_NPC WHERE ID_Inst = %s", (id_inst_npc,))
            self.conn.commit()
            
    def get_item_name(self, id_item):
        with self.conn.cursor() as cur:
            cur.execute("SELECT Nome FROM Utilizavel WHERE ID_Uti = %s", (id_item,))
            row = cur.fetchone()
            if row:
                return row[0].strip()
            else:
                cur.execute("SELECT Nome FROM Equipavel WHERE ID_Equi = %s", (id_item,))
                row = cur.fetchone()
                if row:
                    return row[0].strip()
                else:
                    cur.execute("SELECT Nome FROM Material WHERE ID_Mat = %s", (id_item,))
                    row = cur.fetchone()
                    if row:
                        return row[0].strip()
        return "Item Desconhecido"
        
    def end(self):
        pass