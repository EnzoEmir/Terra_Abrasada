import os
import inquirer
import psycopg

def gerenciar_equipamentos(conn, save):
    """Menu principal para gerenciar equipamentos"""
    while True:
        os.system('cls' if os.name == 'nt' else 'clear')
        print("=== GERENCIAR EQUIPAMENTOS ===\n")
        
        opcoes = [
            "Equipar item do inventário", 
            "Desequipar item",
            "Voltar"
        ]
        
        pergunta = [
            inquirer.List(
                'acao',
                message="O que deseja fazer?",
                choices=opcoes
            )
        ]
        
        resposta = inquirer.prompt(pergunta)
        if not resposta or resposta['acao'] == "Voltar":
            break
            
        if resposta['acao'] == "Equipar item do inventário":
            equipar_item_do_inventario(conn, save)
        elif resposta['acao'] == "Desequipar item":
            desequipar_item(conn, save)

def equipar_item_do_inventario(conn, save):
    """Permite equipar um item equipável do inventário"""
    with conn.cursor() as cur:
        # Busca itens equipáveis no inventário
        cur.execute("""
            SELECT inv.Pos_Inv, ii.ID_Inst, e.Nome, e.Parte_Corpo, e.Atributo, e.Valor
            FROM Inventario inv
            JOIN Inst_Item ii ON inv.ID_Inst_Item = ii.ID_Inst
            JOIN Item i ON ii.ID_Item = i.ID_Item
            JOIN Equipavel e ON e.ID_Equi = i.ID_Item
            WHERE ii.Save = %s
            ORDER BY e.Parte_Corpo, e.Nome
        """, (save,))
        
        itens_equipaveis = cur.fetchall()
        
        if not itens_equipaveis:
            print("Você não possui itens equipáveis no inventário.")
            input("Pressione Enter para continuar.")
            return
        
        print("📦 ITENS EQUIPÁVEIS NO INVENTÁRIO:\n")
        escolhas = []
        
        for i, (pos_inv, id_inst, nome, parte_corpo, atributo, valor) in enumerate(itens_equipaveis):
            bonus = f" (+{valor} {atributo})" if atributo and valor > 0 else ""
            linha = f"{i} - {nome.strip()} - {parte_corpo}{bonus}"
            escolhas.append(linha)
            print(f"{i} - {nome.strip()} - {parte_corpo}{bonus}")
        
        escolhas.append("Voltar")
        print(f"{len(escolhas)-1} - Voltar")
        
        pergunta = [
            inquirer.List(
                'item',
                message="\nQual item deseja equipar?",
                choices=escolhas
            )
        ]
        
        resposta = inquirer.prompt(pergunta)
        if not resposta or resposta['item'] == "Voltar":
            return
        
        index = int(resposta['item'].split(' - ')[0])
        pos_inv, id_inst, nome, parte_corpo, atributo, valor = itens_equipaveis[index]
        
        # Determina qual slot será atualizado
        slots = {
            'Cabeça': 'Eq_Cab',
            'Tronco': 'Eq_Tronco', 
            'Braço': 'Eq_Braco',
            'Perna': 'Eq_Perna',
            'Arma': 'Arma_Atual'
        }
        
        slot_campo = slots.get(parte_corpo)
        if not slot_campo:
            print(f"Erro: Parte do corpo '{parte_corpo}' não reconhecida!")
            input("Pressione Enter para continuar.")
            return
        
        # Verifica se já há algo equipado nesse slot
        cur.execute(f"""
            SELECT {slot_campo} FROM Inst_Prota WHERE Save = %s
        """, (save,))
        item_atual = cur.fetchone()[0]
        
        if item_atual:
            # Desequipa o item atual (volta para inventário)
            desequipar_slot_especifico(cur, save, slot_campo)
        
        # Equipa o novo item
        cur.execute(f"""
            UPDATE Inst_Prota 
            SET {slot_campo} = %s 
            WHERE Save = %s
        """, (id_inst, save))
        
        # Remove do inventário
        cur.execute("DELETE FROM Inventario WHERE Pos_Inv = %s", (pos_inv,))
        
        conn.commit()
        print(f"\n✅ {nome.strip()} equipado na {parte_corpo}!")
        input("Pressione Enter para continuar.")

def desequipar_item(conn, save):
    """Menu para desequipar itens"""
    with conn.cursor() as cur:
        cur.execute("""
            SELECT ip.Eq_Cab, ip.Eq_Tronco, ip.Eq_Braco, ip.Eq_Perna, ip.Arma_Atual
            FROM Inst_Prota ip
            WHERE ip.Save = %s
        """, (save,))
        
        equipamentos = cur.fetchone()
        if not equipamentos:
            print("Erro: Protagonista não encontrado!")
            input("Pressione Enter para continuar.")
            return
        
        eq_cab, eq_tronco, eq_braco, eq_perna, arma_atual = equipamentos
        
        # Lista slots com equipamentos
        slots_ocupados = []
        nomes_slots = ['Cabeça', 'Tronco', 'Braço', 'Perna', 'Arma']
        campos_slots = ['Eq_Cab', 'Eq_Tronco', 'Eq_Braco', 'Eq_Perna', 'Arma_Atual']
        
        for i, (nome_slot, eq_id, campo) in enumerate(zip(nomes_slots, equipamentos, campos_slots)):
            if eq_id:
                # Busca nome do item
                cur.execute("""
                    SELECT COALESCE(e.Nome, u.Nome, m.Nome) as Nome
                    FROM Inst_Item ii
                    JOIN Item i ON ii.ID_Item = i.ID_Item
                    LEFT JOIN Equipavel e ON e.ID_Equi = i.ID_Item
                    LEFT JOIN Utilizavel u ON u.ID_Uti = i.ID_Item
                    LEFT JOIN Material m ON m.ID_Mat = i.ID_Item
                    WHERE ii.ID_Inst = %s
                """, (eq_id,))
                nome_item = cur.fetchone()
                if nome_item:
                    slots_ocupados.append((i, nome_slot, nome_item[0].strip(), campo))
        
        if not slots_ocupados:
            print("Você não possui itens equipados para desequipar.")
            input("Pressione Enter para continuar.")
            return
        
        print("⚔️ ITENS EQUIPADOS:\n")
        escolhas = []
        
        for i, (index, nome_slot, nome_item, campo) in enumerate(slots_ocupados):
            linha = f"{i} - {nome_slot}: {nome_item}"
            escolhas.append(linha)
            print(f"{i} - {nome_slot}: {nome_item}")
        
        escolhas.append("Voltar")
        print(f"{len(escolhas)-1} - Voltar")
        
        pergunta = [
            inquirer.List(
                'item',
                message="\nQual item deseja desequipar?",
                choices=escolhas
            )
        ]
        
        resposta = inquirer.prompt(pergunta)
        if not resposta or resposta['item'] == "Voltar":
            return
        
        index_escolhido = int(resposta['item'].split(' - ')[0])
        _, nome_slot, nome_item, campo = slots_ocupados[index_escolhido]
        
        # Desequipa o item
        desequipar_slot_especifico(cur, save, campo)
        conn.commit()
        
        print(f"\n✅ {nome_item} desequipado da {nome_slot} e retornou ao inventário!")
        input("Pressione Enter para continuar.")

def desequipar_slot_especifico(cur, save, slot_campo):
    """Desequipa um item de um slot específico e retorna ao inventário"""
    # Busca o ID do item atualmente equipado
    cur.execute(f"""
        SELECT {slot_campo} FROM Inst_Prota WHERE Save = %s
    """, (save,))
    id_inst_equipado = cur.fetchone()[0]
    
    if id_inst_equipado:
        # Adiciona de volta ao inventário
        cur.execute("SELECT MAX(Pos_Inv) FROM Inventario")
        max_slot = cur.fetchone()[0] or 0
        novo_slot = max_slot + 1
        
        cur.execute("""
            INSERT INTO Inventario (Pos_Inv, ID_Inst_Item, Quantidade)
            VALUES (%s, %s, 1)
        """, (novo_slot, id_inst_equipado))
        
        # Remove do slot de equipamento
        cur.execute(f"""
            UPDATE Inst_Prota 
            SET {slot_campo} = NULL 
            WHERE Save = %s
        """, (save,))
