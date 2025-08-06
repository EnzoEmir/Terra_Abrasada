import os
import random
import inquirer
import psycopg
from frontend.Andar import andar
from frontend.Explorar import explorar
from frontend.Bau import listar_bau_base




class EstadoNormal:
    def __init__(self, grafo, save, db_params):
        self.G = grafo
        self.save = save
        self.db_params = db_params
        self.localAtual = self.get_localizacao_atual()
        self.opcoes = {
            'Andar para outro local': self.andar,
            'Abrir baú': self.base,
            'Explorar o local': self.explorar,
            'Retornar ao menu principal': self.end
        }
    
    def get_conn(self):
        return psycopg.connect(**self.db_params)

    def get_localizacao_atual(self):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("SELECT Localizacao FROM Inst_Prota WHERE Save = %s", (self.save,))
            row = cur.fetchone()
            return row[0] if row else 1  # Default para base (ID 1)

    def set_localizacao(self, novo_local):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("UPDATE Inst_Prota SET Localizacao = %s WHERE Save = %s", (novo_local, self.save))
            conn.commit()

    def get_hp(self):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("""
                SELECT ip.HP_Atual, p.HP_Base
                FROM Inst_Prota ip
                JOIN Prota p ON ip.ID_Ser = p.ID_Pro
                WHERE ip.Save = %s
            """, (self.save,))
            row = cur.fetchone()
            return (row[0], row[1]) if row else (0, 0)

    def set_hp(self, novo_hp):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("UPDATE Inst_Prota SET HP_Atual = %s WHERE Save = %s", (novo_hp, self.save))
            conn.commit()

    def get_sede(self):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("""
                SELECT ip.Sede_Atual, p.Sede_Base
                FROM Inst_Prota ip
                JOIN Prota p ON ip.ID_Ser = p.ID_Pro
                WHERE ip.Save = %s
            """, (self.save,))
            row = cur.fetchone()
            return (row[0], row[1]) if row else (0, 0)

    def set_sede(self, nova_sede):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("UPDATE Inst_Prota SET Sede_Atual = %s WHERE Save = %s", (nova_sede, self.save))
            conn.commit()

    def get_fome(self):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("""
                SELECT ip.Fome_Atual, p.Fome_Base
                FROM Inst_Prota ip
                JOIN Prota p ON ip.ID_Ser = p.ID_Pro
                WHERE ip.Save = %s
            """, (self.save,))
            row = cur.fetchone()
            return (row[0], row[1]) if row else (0, 0)

    def set_fome(self, nova_fome):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("UPDATE Inst_Prota SET Fome_Atual = %s WHERE Save = %s", (nova_fome, self.save))
            conn.commit()

    def get_radiacao(self):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("""
                SELECT ip.Nivel_Rad_Atual
                FROM Inst_Prota ip
                WHERE ip.Save = %s
            """, (self.save,))
            row = cur.fetchone()
            return (row[0]) if row else (0)

    def set_radiacao(self, nova_radiacao):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("UPDATE Inst_Prota SET Nivel_Rad_Atual = %s WHERE Save = %s", (nova_radiacao, self.save))
            conn.commit()

    def get_str(self):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("SELECT Forca_Atual FROM Inst_Prota WHERE Save = %s", (self.save,))
            row = cur.fetchone()
            return row[0] if row else 0

    def get_def(self):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("SELECT Defesa_Atual FROM Inst_Prota WHERE Save = %s", (self.save,))
            row = cur.fetchone()
            return row[0] if row else 0

    def get_nome(self):
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("SELECT Nome FROM Inst_Prota WHERE Save = %s", (self.save,))
            row = cur.fetchone()
            return row[0].strip() if row else ""

    def menu(self):
        while True:
            os.system('cls' if os.name == 'nt' else 'clear')
            nome = self.G.nodes[self.localAtual]["nome"]
            hp_atual, hp_max = self.get_hp()
            fome_atual, fome_max = self.get_fome()
            sede_atual, sede_max = self.get_sede()
            nivel_rad_atual = self.get_radiacao()
            nome_prota = self.get_nome()
            print(f'{nome_prota} se encontra no(a) {nome}.')
            print(f'Vida: {hp_atual}/{hp_max}')
            print(f'Fome: {fome_atual}/{fome_max}')
            print(f'Sede: {sede_atual}/{sede_max}')
            print(f'Nível de Radiação: {nivel_rad_atual}/500\n')

            opcoes_menu = list(self.opcoes.keys())
            

            perguntas = [
                inquirer.List(
                    'acao',
                    message="O que deseja fazer?",
                    choices=opcoes_menu
                )
            ]

            resposta = inquirer.prompt(perguntas)
            if not resposta:
                continue  # caso o usuário cancele com Ctrl+C ou Enter

            acao = resposta['acao']
            if acao == 'Retornar ao menu principal':
                print("\nRetornando ao menu principal...\n")
                break
            else:
                resultado_acao = self.opcoes[acao]()
                
                # Verifica se o protagonista morreu
                if resultado_acao == "derrota_protagonista":
                    print("\n=== GAME OVER ===")
                    print("Seu protagonista morreu e o save foi deletado.")
                    input("\nPressione Enter para retornar ao menu principal...")
                    break
    
    def andar(self):
        lol = andar(self)
        return lol

    def base(self):
        nome_local = self.G.nodes[self.localAtual]["nome"]

        if "base" in nome_local.lower():
            with self.get_conn() as conn:
                listar_bau_base(conn, self.save)
        else:
            print(f"\nVocê não está em uma base. Você está no(a) {nome_local}.\n") 

        input('Pressione Enter para continuar.')

        
    def print_clr(self, string):
        os.system('cls' if os.name == 'nt' else 'clear')
        print(string)
        

    def explorar(self):
        return explorar(self)
    
    def tentar_fuga(self):
        return random.random() < 0.5
    
    def iniciar_luta(self, inimigos):
        from frontend.Luta import Luta
        with self.get_conn() as conn:
            luta = Luta(conn, self, inimigos)
            return luta.luta_turno_prota()

    def deletar_protagonista(self):
        """Deleta a instância do protagonista quando ele morre"""
        with self.get_conn() as conn:
            cur = conn.cursor()
            cur.execute("DELETE FROM Inst_Prota WHERE Save = %s", (self.save,))
            conn.commit()

    def end(self):
        pass