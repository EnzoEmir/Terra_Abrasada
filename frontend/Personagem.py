import os
import psycopg

class Personagem:
    def __init__(self, estado):
        self.estado = estado  # EstadoNormal

    def get_conn(self):
        return psycopg.connect(**self.estado.db_params)

    def visualizar_status_personagem(self):
        os.system('cls' if os.name == 'nt' else 'clear')
        with self.get_conn() as conn:
            cur = conn.cursor()
            
            # Busca todos os dados do protagonista
            cur.execute('''
                SELECT ip.Nome, ip.HP_Atual, ip.Forca_Atual, ip.Defesa_Atual, 
                       ip.Nivel_Rad_Atual, ip.Fome_Atual, ip.Sede_Atual,
                       ip.Mut_Cab, ip.Mut_Tronco, ip.Mut_Braco, ip.Mut_Perna,
                       ip.Eq_Cab, ip.Eq_Tronco, ip.Eq_Braco, ip.Eq_Perna, ip.Arma_Atual,
                       f.Nome as Faccao_Nome, p.HP_Base, p.Forca_Base, p.Defesa_Base,
                       p.Fome_Base, p.Sede_Base
                FROM Inst_Prota ip
                JOIN Prota p ON ip.ID_Ser = p.ID_Pro
                JOIN Faccao f ON ip.Alinhamento_Atual = f.ID_Faccao
                WHERE ip.Save = %s
            ''', (self.estado.save,))
            
            row = cur.fetchone()
            if not row:
                print("Erro: Personagem não encontrado!")
                input('Pressione Enter para continuar.')
                return
                
            (nome, hp_atual, forca_atual, defesa_atual, nivel_rad_atual, 
             fome_atual, sede_atual, mut_cab, mut_tronco, mut_braco, mut_perna,
             eq_cab, eq_tronco, eq_braco, eq_perna, arma_atual,
             faccao_nome, hp_base, forca_base, defesa_base, fome_base, sede_base) = row
            
            print(f"\n=== STATUS DE {nome.upper()} ===\n")
            
            # Calcula bônus dos equipamentos
            bonus_forca = self.estado.calcular_bonus_equipamento('Forca_Atual')
            bonus_defesa = self.estado.calcular_bonus_equipamento('Defesa_Atual')
            
            # Status Básicos
            print("ATRIBUTOS BÁSICOS:")
            print(f"   HP: {hp_atual}/{hp_base}")
            
            # Mostra força com bônus se houver
            if bonus_forca > 0:
                print(f"   Força: {forca_atual + bonus_forca} ({forca_atual} + {bonus_forca}) (Base: {forca_base})")
            else:
                print(f"   Força: {forca_atual} (Base: {forca_base})")
            
            # Mostra defesa com bônus se houver  
            if bonus_defesa > 0:
                print(f"   Defesa: {defesa_atual + bonus_defesa} ({defesa_atual} + {bonus_defesa}) (Base: {defesa_base})")
            else:
                print(f"   Defesa: {defesa_atual} (Base: {defesa_base})")
                
            print(f"   Radiação: {nivel_rad_atual}")
            print(f"   Fome: {fome_atual}/{fome_base}")
            print(f"   Sede: {sede_atual}/{sede_base}")
            print(f"   Facção: {faccao_nome.strip()}")
            
            # Mutações
            print("\nMUTAÇÕES:")
            mutacoes = {
                'Cabeça': mut_cab,
                'Tronco': mut_tronco, 
                'Braço': mut_braco,
                'Perna': mut_perna
            }
            
            for parte, id_mut in mutacoes.items():
                if id_mut:
                    cur.execute('SELECT Nome FROM Mutacao WHERE ID_Mutacao = %s', (id_mut,))
                    mut_row = cur.fetchone()
                    nome_mut = mut_row[0].strip() if mut_row else 'Desconhecida'
                    print(f"   {parte}: {nome_mut}")
                else:
                    print(f"   {parte}: Nenhuma")
            
            # Equipamentos
            print("\nEQUIPAMENTOS:")
            equipamentos = {
                'Cabeça': eq_cab,
                'Tronco': eq_tronco,
                'Braço': eq_braco, 
                'Perna': eq_perna,
                'Arma': arma_atual
            }
            
            for parte, id_eq in equipamentos.items():
                if id_eq:
                    # Busca o nome e bônus do equipamento
                    cur.execute('''
                        SELECT COALESCE(e.Nome, u.Nome, m.Nome) as Nome,
                               COALESCE(e.Atributo, '') as Atributo,
                               COALESCE(e.Valor, 0) as Valor
                        FROM Inst_Item ii
                        JOIN Item i ON ii.ID_Item = i.ID_Item
                        LEFT JOIN Equipavel e ON e.ID_Equi = i.ID_Item
                        LEFT JOIN Utilizavel u ON u.ID_Uti = i.ID_Item
                        LEFT JOIN Material m ON m.ID_Mat = i.ID_Item
                        WHERE ii.ID_Inst = %s
                    ''', (id_eq,))
                    eq_row = cur.fetchone()
                    if eq_row:
                        nome_eq, atributo, valor = eq_row
                        bonus = f" (+{valor} {atributo})" if atributo and valor > 0 else ""
                        print(f"   {parte}: {nome_eq.strip()}{bonus}")
                    else:
                        print(f"   {parte}: Desconhecido")
                else:
                    print(f"   {parte}: Nenhum")
            
            # Calcula e mostra bônus total dos equipamentos
            print(f"\nBÔNUS TOTAL DOS EQUIPAMENTOS:")
            self.calcular_e_mostrar_bonus_total(cur)
        
        input('\nPressione Enter para continuar.')
    
    def calcular_e_mostrar_bonus_total(self, cur):
        """Calcula e mostra o bônus total dos equipamentos"""
        # Busca todos os equipamentos atuais
        cur.execute("""
            SELECT ip.Eq_Cab, ip.Eq_Tronco, ip.Eq_Braco, ip.Eq_Perna, ip.Arma_Atual
            FROM Inst_Prota ip
            WHERE ip.Save = %s
        """, (self.estado.save,))
        
        equipamentos = cur.fetchone()
        if not equipamentos:
            print("   Nenhum equipamento encontrado")
            return
        
        bonus_forca = 0
        bonus_defesa = 0
        bonus_hp = 0
        
        # Para cada equipamento, soma os bônus
        for eq_id in equipamentos:
            if eq_id:
                cur.execute("""
                    SELECT e.Atributo, e.Valor
                    FROM Inst_Item ii
                    JOIN Equipavel e ON e.ID_Equi = ii.ID_Item
                    WHERE ii.ID_Inst = %s
                """, (eq_id,))
                eq_data = cur.fetchone()
                if eq_data:
                    atributo, valor = eq_data
                    if atributo == 'Forca_Atual':
                        bonus_forca += valor
                    elif atributo == 'Defesa_Atual':
                        bonus_defesa += valor
                    elif atributo == 'HP_Atual':
                        bonus_hp += valor
        
        # Mostra os bônus totais
        if bonus_forca > 0:
            print(f"   Força: +{bonus_forca}")
        if bonus_defesa > 0:
            print(f"   Defesa: +{bonus_defesa}")
        if bonus_hp > 0:
            print(f"   HP: +{bonus_hp}")
            
        if bonus_forca == 0 and bonus_defesa == 0 and bonus_hp == 0:
            print("   Nenhum bônus ativo")

    def visualizar_mutacoes_atuais(self):
        # Método antigo mantido para compatibilidade, mas chama o novo
        self.visualizar_status_personagem()