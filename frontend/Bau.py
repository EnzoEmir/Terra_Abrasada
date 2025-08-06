def listar_bau_base(conn, save):
    # Lista os itens do baú da base do save específico
    with conn.cursor() as cur:
        cur.execute("""
            SELECT 
                bb.Pos_Bau,
                i.Tipo,
                COALESCE(u.Nome, e.Nome, m.Nome) AS Nome,
                bb.Quantidade
            FROM Bau_Base bb
            JOIN Inst_Item ii ON bb.ID_Inst_Item = ii.ID_Inst
            JOIN Item i ON ii.ID_Item = i.ID_Item
            LEFT JOIN Utilizavel u ON u.ID_Uti = i.ID_Item
            LEFT JOIN Equipavel e ON e.ID_Equi = i.ID_Item
            LEFT JOIN Material m ON m.ID_Mat = i.ID_Item
            WHERE ii.Save = %s
            ORDER BY bb.Pos_Bau;
        """, (save,))
        
        resultados = cur.fetchall()
        if resultados:
            print("\n=== BAÚ DA BASE ===")
            for pos, tipo, nome, qtd in resultados:
                print(f"Posição: {pos} | Tipo: {tipo} | Nome: {nome} | Quantidade: {qtd}")
        else:
            print("\n=== BAÚ DA BASE ===")
            print("\nO baú da base está vazio.")
