-- Função para criar acontecimento mundo
CREATE OR REPLACE FUNCTION criar_acontecimento_mundo(
    p_valor SMALLINT,
    p_texto VARCHAR,
    p_local SMALLINT,
    p_max_ocorrencia SMALLINT DEFAULT 1,
    p_prioridade CHAR(1) DEFAULT '1',
    p_probabilidade VARCHAR(3) DEFAULT '50'
)
RETURNS SMALLINT AS $criar_acontecimento$
DECLARE
    v_id_evento SMALLINT;
BEGIN
    -- Cria o evento do tipo ACONTECIMENTO MUNDO
    INSERT INTO Evento (Max_Ocorrencia, Prioridade, Probabilidade, Tipo)
    VALUES (p_max_ocorrencia, p_prioridade, p_probabilidade, 'ACONTECIMENTO MUNDO')
    RETURNING ID_Evento INTO v_id_evento;
    -- Cria o acontecimento_mundo vinculado ao evento
    INSERT INTO Acontecimento (ID_Evento, Valor, Texto)
    VALUES (v_id_evento, p_valor, p_texto);
    -- Relaciona o evento ao ponto de interesse
    INSERT INTO Ocorre (ID_Evento, ID_PI)
    VALUES (v_id_evento, p_local);
    RETURN v_id_evento;
END;
$criar_acontecimento$ LANGUAGE plpgsql;

-- Função para criar encontro com inimigos
CREATE OR REPLACE FUNCTION criar_encontro(
    p_id_inimigo INT,
    p_quantidade INT,
    p_local INT,
    p_max_ocorrencia INT DEFAULT 1,
    p_prioridade CHAR(1) DEFAULT '1',
    p_probabilidade CHAR(3) DEFAULT '50'
)
RETURNS INT AS $criar_encontro$
DECLARE
    v_id_evento INT;
BEGIN
    -- Cria o evento do tipo ENCONTRO
    INSERT INTO Evento (Max_Ocorrencia, Prioridade, Probabilidade, Tipo)
    VALUES (p_max_ocorrencia, p_prioridade, p_probabilidade, 'ENCONTRO')
    RETURNING ID_Evento INTO v_id_evento;
    -- Cria o encontro vinculado ao evento
    INSERT INTO Encontro (ID_Evento, ID_Inimigo, Quantidade)
    VALUES (v_id_evento, p_id_inimigo, p_quantidade);
    -- Relaciona o evento ao ponto de interesse
    INSERT INTO Ocorre (ID_Evento, ID_PI)
    VALUES (v_id_evento, p_local);
    RETURN v_id_evento;
END;
$criar_encontro$ LANGUAGE plpgsql;