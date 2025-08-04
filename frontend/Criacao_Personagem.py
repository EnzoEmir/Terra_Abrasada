import inquirer
from rich.console import Console

console = Console()

def perguntar_historia():
    resposta = inquirer.prompt([
        inquirer.List(
            "ler_historia",
            message="Você deseja ler a história do mundo?",
            choices=["Sim", "Não"]
        )
    ])
    return resposta["ler_historia"] == "Sim"

def mostrar_historia():
    console.print("""
    [bold cyan]História do mundo[/bold cyan]

    No ano de 2074, a crise hídrica atingiu seu ápice. Rios secaram, aquíferos colapsaram e o acesso à água potável tornou-se privilégio de poucos. A diplomacia entre nações fracassou rapidamente — e o que começou como escassez virou conflito.

    As grandes potências entraram em guerra aberta, usando tecnologia e armamentos devastadores. Bombas nucleares caíram sobre os principais centros urbanos do planeta, dizimando populações e contaminando regiões inteiras com radiação.

    Por sorte, a área onde você vivia foi poupada dos piores ataques. Ainda assim, nada permaneceu ileso. Os governos caíram, as redes de abastecimento ruíram e o mundo como você conhecia deixou de existir.

    Agora, o que resta é sobreviver. A água é rara, a comida mais ainda. Mutações, facções armadas e zonas de radiação moldam um novo mundo — hostil, imprevisível e sem piedade para os fracos.

    [bold yellow]Você é um dos poucos que restaram. O que vai fazer com isso?[/bold yellow]
    """)

    console.input("\n[green]Pressione Enter para continuar...[/green]")

def escolher_save(conn):
    with conn.cursor() as cur:
        cur.execute("SELECT Save, Nome FROM Inst_Prota ORDER BY Save")
        saves = {row[0]: row[1] for row in cur.fetchall()}

    escolhas = []
    for i in range(3):
        status = f"Ocupado por {saves[i]}" if i in saves else "Vazio"
        escolhas.append(f"Slot {i} - {status}")

    resposta = inquirer.prompt([
        inquirer.List("slot", message="Escolha um slot de save", choices=escolhas)
    ])
    slot_escolhido = int(resposta["slot"].split()[1])

    # Verificar sobrescrita se necessário
    if slot_escolhido in saves:
        confirm = inquirer.prompt([
            inquirer.List("confirma", 
                           message=f"O slot {slot_escolhido} está ocupado por {saves[slot_escolhido]}. Deseja sobrescrever?",
                           choices=["Sim", "Não" , "Voltar"])
        ])
        if confirm["confirma"] == "Não":
            console.print("[yellow]Por hora finge que tá o resto do jogo aqui[/yellow]")
            exit(0)
        
        elif confirm["confirma"] == "Voltar":
            return escolher_save(conn)

        # Limpar slot
        with conn.cursor() as cur:
            cur.execute("DELETE FROM Inst_Prota WHERE Save = %s", (slot_escolhido,))
            conn.commit()
        console.print(f"[yellow]Slot {slot_escolhido} liberado.[/yellow]")

    return slot_escolhido

def escolher_classe_protagonista(conn):
    with conn.cursor() as cur:
        cur.execute("SELECT ID_Pro, Nome FROM Prota ORDER BY ID_Pro;")
        classes = cur.fetchall()

    if not classes:
        console.print("[red]Nenhuma classe encontrada na tabela Prota.[/red]")
        exit(1)

    opcoes_map = {nome: id_pro for id_pro, nome in classes}
    opcoes = list(opcoes_map.keys())
    
    resposta = inquirer.prompt([
        inquirer.List("classe", message="Escolha sua classe", choices=opcoes)
    ])
    nome_escolhido = resposta["classe"]
    return opcoes_map[nome_escolhido], nome_escolhido

def perguntar_nome_personagem():
    resposta = inquirer.prompt([
        inquirer.Text("nome", message="Digite o nome do seu personagem")
    ])
    return resposta["nome"]

def criar_instancia(conn, id_pro, nome_instancia, save):
    with conn.cursor() as cur:
        cur.execute("SELECT * FROM Prota WHERE ID_Pro = %s", (id_pro,))
        prota = cur.fetchone()
        if not prota:
            console.print("[red]Erro ao recuperar dados da classe.[/red]")
            exit(1)

        # Desempacotar dados da classe de forma mais clara
        _, nome_classe, hp_base, forca, defesa, niv_rad, alinhamento, fome, sede = prota

        # Inserir nova instância
        cur.execute("""
            INSERT INTO Inst_Prota (
                ID_Inst, ID_Ser, Nome, HP_Atual, Forca_Atual, Defesa_Atual, 
                Nivel_Rad_Atual, Alinhamento_Atual, Fome_Atual, Sede_Atual,
                Save, Localizacao
            ) VALUES (
                DEFAULT, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            )
        """, (id_pro, nome_instancia, hp_base, forca, defesa, niv_rad,
              alinhamento, fome, sede, save, 1))
        
        conn.commit()
        console.print(f"[green]Personagem '{nome_instancia}' criado com sucesso no slot {save}![/green]")
