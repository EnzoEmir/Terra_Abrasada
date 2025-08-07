import os
import inquirer
import psycopg

def adicionar_ao_inventario(cur, id_inst_item, save):
    """Adiciona um item ao inventário"""
    # Verifica se já existe no inventário (para empilhar)
    cur.execute("""
        SELECT inv.Pos_Inv, inv.Quantidade 
        FROM Inventario inv
        JOIN Inst_Item ii ON inv.ID_Inst_Item = ii.ID_Inst
        WHERE inv.ID_Inst_Item = %s AND ii.Save = %s
    """, (id_inst_item, save))
    
    existing = cur.fetchone()
    
    if existing:
        # Item já existe, aumenta quantidade
        pos_inv, quantidade_atual = existing
        cur.execute("""
            UPDATE Inventario 
            SET Quantidade = Quantidade + 1 
            WHERE Pos_Inv = %s
        """, (pos_inv,))
    else:
        # Busca próximo slot disponível
        cur.execute("SELECT MAX(Pos_Inv) FROM Inventario")
        max_slot = cur.fetchone()[0] or 0
        novo_slot = max_slot + 1
        
        # Adiciona novo item ao inventário
        cur.execute("""
            INSERT INTO Inventario (Pos_Inv, ID_Inst_Item, Quantidade)
            VALUES (%s, %s, 1)
        """, (novo_slot, id_inst_item))
    
    # Remove o item do local 
    cur.execute("UPDATE Inst_Item SET Localizacao = NULL WHERE ID_Inst = %s", (id_inst_item,))

def listar_itens_no_local(conn, save, local):
    """Lista todos os itens disponíveis no local atual"""
    with conn.cursor() as cur:
        cur.execute("""
            SELECT ii.ID_Inst, ii.ID_Item, 
                   COALESCE(u.Nome, e.Nome, m.Nome) as Nome,
                   i.Tipo
            FROM Inst_Item ii
            JOIN Item i ON ii.ID_Item = i.ID_Item
            LEFT JOIN Utilizavel u ON u.ID_Uti = i.ID_Item
            LEFT JOIN Equipavel e ON e.ID_Equi = i.ID_Item
            LEFT JOIN Material m ON m.ID_Mat = i.ID_Item
            WHERE ii.Save = %s AND ii.Localizacao = %s
        """, (save, local))
        
        itens = cur.fetchall()
        
        if not itens:
            print(f"Não há itens neste local .")
            input("Pressione Enter para continuar.")
            return
            
        print(f"\n=== ITENS NO LOCAL ===")
        for i, (id_inst, id_item, nome, tipo) in enumerate(itens):
            print(f"{i} - {nome.strip()} ({tipo})")
        
        escolhas = [f"{i} - {nome.strip()}" for i, (_, _, nome, _) in enumerate(itens)]
        escolhas.append("Voltar")
        
        pergunta = [
            inquirer.List(
                'item',
                message="Qual item deseja coletar?",
                choices=escolhas
            )
        ]
        
        resposta = inquirer.prompt(pergunta)
        if resposta and resposta['item'] != "Voltar":
            index = int(resposta['item'].split(' - ')[0])
            id_inst_item = itens[index][0]
            nome_item = itens[index][2]
            
            # Adiciona o item ao inventário
            adicionar_ao_inventario(cur, id_inst_item, save)
            conn.commit()  
            print(f"Você coletou: {nome_item.strip()}")
            
            input("Pressione Enter para continuar.")

def visualizar_inventario(conn, save):
    """Visualiza o inventário do jogador"""
    with conn.cursor() as cur:
        cur.execute("""
            SELECT inv.Pos_Inv, inv.Quantidade, ii.ID_Inst, ii.ID_Item,
                   COALESCE(u.Nome, e.Nome, m.Nome) as Nome,
                   i.Tipo,
                   COALESCE(u.Atributo, e.Atributo, '') as Atributo,
                   COALESCE(u.Valor, e.Valor, 0) as Valor,
                   COALESCE(e.Parte_Corpo, '') as Parte_Corpo
            FROM Inventario inv
            JOIN Inst_Item ii ON inv.ID_Inst_Item = ii.ID_Inst
            JOIN Item i ON ii.ID_Item = i.ID_Item
            LEFT JOIN Utilizavel u ON u.ID_Uti = i.ID_Item
            LEFT JOIN Equipavel e ON e.ID_Equi = i.ID_Item
            LEFT JOIN Material m ON m.ID_Mat = i.ID_Item
            WHERE ii.Save = %s
            ORDER BY inv.Pos_Inv
        """, (save,))
        
        itens_inventario = cur.fetchall()
        
        os.system('cls' if os.name == 'nt' else 'clear')
        
        if not itens_inventario:
            print(f"\n=== INVENTÁRIO ===")
            print("Seu inventário está vazio.")
            input("\nPressione Enter para continuar.")
            return
            
        print(f"\n=== INVENTÁRIO ===\n")
        
        utilizaveis = []
        equipaveis = []
        materiais = []
        
        for item in itens_inventario:
            pos_inv, quantidade, id_inst, id_item, nome, tipo, atributo, valor, parte_corpo = item
            if tipo == 'Utilizável':
                utilizaveis.append((pos_inv, quantidade, nome, atributo, valor))
            elif tipo == 'Equipável':
                equipaveis.append((pos_inv, quantidade, nome, atributo, valor, parte_corpo))
            elif tipo == 'Material':
                materiais.append((pos_inv, quantidade, nome))
        
        if utilizaveis:
            print("ITENS UTILIZÁVEIS:")
            for pos_inv, quantidade, nome, atributo, valor in utilizaveis:
                efeito = f" ({atributo}: +{valor})" if atributo and valor != 0 else ""
                print(f"   Slot {pos_inv}: {nome.strip()}{efeito} x{quantidade}")
            print()
        
        if equipaveis:
            print("EQUIPAMENTOS:")
            for pos_inv, quantidade, nome, atributo, valor, parte_corpo in equipaveis:
                bonus = f" ({atributo}: +{valor})" if atributo and valor != 0 else ""
                parte = f" - {parte_corpo}" if parte_corpo else ""
                print(f"   Slot {pos_inv}: {nome.strip()}{bonus}{parte} x{quantidade}")
            print()
        
        if materiais:
            print("MATERIAIS:")
            for pos_inv, quantidade, nome in materiais:
                print(f"   Slot {pos_inv}: {nome.strip()} x{quantidade}")
            print()
        
        print(f"Total de slots ocupados: {len(itens_inventario)}")
        input("\nPressione Enter para continuar.")
