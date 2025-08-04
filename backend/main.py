import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import psycopg
from rich.console import Console
from dotenv import load_dotenv

from frontend.Criacao_Personagem import (
    perguntar_historia,
    mostrar_historia,
    escolher_save,
    escolher_classe_protagonista,
    perguntar_nome_personagem,
    criar_instancia
)

load_dotenv()

DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")

console = Console()

def conectar_bd():
    try:
        return psycopg.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT
        )
    except Exception as e:
        console.print(f"[red]Erro ao conectar ao banco de dados:[/red] {e}")
        sys.exit(1)

def main():
    try:
        conn = conectar_bd()
        
        if perguntar_historia():
            mostrar_historia()

        save = escolher_save(conn)
        id_pro, nome_classe = escolher_classe_protagonista(conn)
        nome_instancia = perguntar_nome_personagem()
        criar_instancia(conn, id_pro, nome_instancia, save)
        
    except KeyboardInterrupt:
        console.print("\n[yellow]Operação cancelada pelo usuário.[/yellow]")
    except Exception as e:
        console.print(f"[red]Erro inesperado:[/red] {e}")
    finally:
        if 'conn' in locals():
            conn.close()

if __name__ == "__main__":
    main()
