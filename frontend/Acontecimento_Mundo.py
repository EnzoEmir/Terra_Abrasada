import random

def buscar_acontecimentos(conn, id_pi):
    with conn.cursor() as cur:
        cur.execute('''
            SELECT e.ID_Evento, a.Valor, a.Texto, e.Probabilidade
            FROM Ocorre o
            JOIN Evento e ON o.ID_Evento = e.ID_Evento
            JOIN Acontecimento a ON a.ID_Evento = e.ID_Evento
            WHERE o.ID_PI = %s
        ''', (id_pi,))
        return cur.fetchall()


def processar_acontecimentos(conn, id_pi, estado):
    acontecimentos = buscar_acontecimentos(conn, id_pi)
    ativados = []
    for id_evento, valor, texto, probabilidade in acontecimentos:
        prob = int(probabilidade)
        if random.randint(1, 100) <= prob:
            ativados.append((id_evento, valor, texto))
    if not ativados:
        return False

    id_evento, valor, texto = max(ativados, key=lambda x: x[1])
    print(f"\n{texto}")
    if 'vida' in texto:
        hp = estado.get_hp()
        if hp:
            hp_atual, hp_max = hp
            novo_hp = max(0, min(hp_max, hp_atual + valor))
            estado.set_hp(novo_hp)
    elif 'fome' in texto:
        fome = estado.get_fome()
        if fome:
            fome_atual, fome_max = fome
            novo_fome = max(0, min(fome_max, fome_atual + valor))
            estado.set_fome(novo_fome)
    elif 'sede' in texto:
        sede = estado.get_sede()
        if sede:
            sede_atual, sede_max = sede
            novo_sede = max(0, min(sede_max, sede_atual + valor))
            estado.set_sede(novo_sede)
    elif 'radiação' in texto or 'radiacao' in texto:
        rad = estado.get_radiacao()
        
        rad_atual = rad
        rad_max = 500  # valor padrão 
        novo_rad = max(0, min(rad_max, rad_atual + valor))
        estado.set_radiacao(novo_rad)
    input('Pressione Enter para continuar.')
    return True