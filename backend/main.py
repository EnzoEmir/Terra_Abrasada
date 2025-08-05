import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import psycopg
from rich.console import Console
import networkx as nx
from dotenv import load_dotenv

from frontend.EstadoNormal import EstadoNormal
from frontend.Criacao_Personagem import *

# Carrega variáveis do .env
load_dotenv()

DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")

db_params = {
    "dbname": DB_NAME,
    "user": DB_USER,
    "password": DB_PASSWORD,
    "host": DB_HOST,
    "port": DB_PORT
}

console = Console()

def conectar_bd():
    try:
        return psycopg.connect(**db_params)
    except Exception as e:
        console.print(f"[red]Erro ao conectar ao banco de dados:[/red] {e}")
        sys.exit(1)

def construir_grafo(cur):
    # Consulta os pontos de interesse
    cur.execute("SELECT ID_PI, Nome, Niv_Rad FROM Ponto_Interesse")
    pontos = cur.fetchall()

    # Cria grafo e adiciona nós com atributos
    G = nx.Graph()
    G.add_nodes_from([
        (id_pi, {"nome": nome, "nivel_rad": int(float(nivel_rad))})
        for (id_pi, nome, nivel_rad) in pontos
    ])

    # Consulta conexões
    cur.execute("SELECT Origem, Destino, Custo FROM Conexao")
    conexoes = cur.fetchall()

    for origem, destino, custo in conexoes:
        G.add_edge(origem, destino, weight=custo)
        G.add_edge(destino, origem, weight=custo)  # Garante bidirecionalidade

    return G

def main():
    try:
        conn = conectar_bd()
        cur = conn.cursor()

        if perguntar_historia():
            mostrar_historia()

        save = escolher_save(conn)
        
        # Verificar se já existe um protagonista neste save
        cur.execute("SELECT ID_Inst, Nome FROM Inst_Prota WHERE Save = %s", (save,))
        protagonista_existente = cur.fetchone()
        
        if protagonista_existente:
            console.print(f"[green]Carregando personagem existente: {protagonista_existente[1]}[/green]")
        else:
            # Criar novo protagonista
            id_pro, nome_classe = escolher_classe_protagonista(conn)
            nome_instancia = perguntar_nome_personagem()
            criar_instancia(conn, id_pro, nome_instancia, save)

        G = construir_grafo(cur)

        cur.close()
        conn.close()

        EN = EstadoNormal(G, save, db_params)
        EN.menu()

    except KeyboardInterrupt:
        console.print("\n[yellow]Operação cancelada pelo usuário.[/yellow]")
    except Exception as e:
        console.print(f"[red]Erro inesperado:[/red] {e}")
        if 'conn' in locals():
            conn.close()

if __name__ == "__main__":
    main()
