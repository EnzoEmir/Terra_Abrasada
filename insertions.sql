-- =======================================
-- 1. PONTOS DE INTERESSE
-- =======================================
INSERT INTO Ponto_Interesse (ID_PI, Nome, Niv_Rad) VALUES
(1, 'Base', 0),                             -- ID: 1
(2, 'Travessia da Poeira', 1),              -- ID: 2
(3, 'Posto de Vigia Abandonado', 1),        -- ID: 3
(4, 'Cidade Fantasma', 2),                  -- ID: 4
(5, 'Terra Chamuscada', 1),                 -- ID: 5
(6, 'Subúrbio dos Esquecidos', 2),          -- ID: 6
(7, 'Base dos Pisa Poeira', 0),             -- ID: 7
(8, 'Escola Amanhecer Dourado', 1),         -- ID: 8
(9, 'Cemitério das Máquinas', 3),           -- ID: 9
(10, 'Colinas Negras', 3),                   -- ID: 10
(11, 'Mercabunker', 0),                      -- ID: 11
(12, 'Poço de água', 0),                     -- ID: 12
(13, 'Hospital Subterrâneo', 4),             -- ID: 13
(14, 'Aeroporto Militar', 5),                -- ID: 14
(15, 'Pátio do Ferro-Velho', 1),             -- ID: 15
(16, 'Lugar Algum', 0),                      -- ID: 16
(17, 'Mêtro do Surfista', 0),                -- ID: 17
(18, 'Estação de Tratamento de Água', 2),    -- ID: 18

-- Rota dos Nigrum Sanguinem
(19, 'Portão Esquecido', 10),                -- ID: 19
(20, 'Vales da Praga', 10),                  -- ID: 20
(21, 'Santuário da Desfiguração', 20),       -- ID: 21
(22, 'Coração de Sanguinem', 30),            -- ID: 22

-- Rota da Hidra de Carne
(23, 'Brejo Mórbido', 5),                    -- ID: 23
(24, 'Trilho Encharcado', 15),               -- ID: 24
(25, 'Covil da Hidra de Carne', 30),         -- ID: 25

-- ROTA da Omni-Mente

(26, 'Túnel de Rastro Químico', 10),         -- ID: 26
(27, 'Ninho de Operárias', 15),              -- ID: 27
(28, 'Centro de Comando Feromon', 20),       -- ID: 28
(29, 'Trono da Omni-Mente', 35);             -- ID: 29

-- =======================================
-- 2. SERES
-- =======================================
INSERT INTO Ser (ID_Ser, Tipo) VALUES
(1, 'Prota'),
(2, 'Prota'),
(3, 'Prota'),

-- Inimigos Não Inteligentes Fáceis
(101, 'N'), (102, 'N'), (103, 'N'), (104, 'N'), (105, 'N'), (106, 'N'),

-- Inimigos Não Inteligentes Médios
(201, 'N'), (202, 'N'), (203, 'N'),

-- Inimigos Não Inteligentes Difíceis
(301, 'N'), (302, 'N'), (303, 'N'),

-- Hidra de Carne (Lagartos Mutados)
(501, 'N'), (502, 'N'), (503, 'N'),

-- Omni-Mente (Formigas Mutadas)
(601, 'N'), (602, 'N'), (603, 'N'),

-- Bosses Não Inteligentes
(997, 'N'), (998, 'N'),

-- Inimigos Inteligentes Fáceis
(107, 'I'), (108, 'I'),

-- Inimigos Inteligentes Médios
(204, 'I'), (205, 'I'),

-- Inimigos Inteligentes Difíceis
(304, 'I'), (305, 'I'),

-- Nigrum Sanguinem (hierarquia)
(401, 'I'), (402, 'I'), (403, 'I'), (404, 'I'),

-- Boss Inteligente
(999, 'I');

-- =======================================
-- 1A. FACCOES (necessário para alinhamento de inteligentes)
-- =======================================
INSERT INTO Faccao (ID_Faccao, Nome) VALUES
(0, 'Nada'),
(1, 'Neutro'),
(2, 'Nigrum Sanguinem'),
(3, 'Hostil'),
(4, 'Pisa-Poeira');

-- =======================================
-- 4. PROTAS
-- =======================================
INSERT INTO Prota (ID_Pro, Nome, HP_Base, Forca_Base, Defesa_Base, Nivel_Rad, Alinhamento, Fome_Base, Sede_Base) VALUES
(1, 'Brutamontes', 120, 20, 15, 0, 1, 70, 70),
(2, 'Sobrevivente', 100, 15, 15, 0, 0, 100, 100),
(3, 'Maromba', 110, 25, 10, 0, 1, 60, 70);

-- =======================================
-- 5. CONEXÕES
-- =======================================
INSERT INTO conexao(
    origem,destino,custo
) VALUES
(1,5,5),         -- Base → Terra Chamuscada
(1,3,5),         -- Base → Posto de Vigia Abandonado
(1,4,5),         -- Base → Cidade Fantasma
(1,2,7),         -- Base → Travessia da Poeira
(2,15,9),        -- Travessia da Poeira → Pátio do Ferro-Velho 
(3,6,8),         -- Posto de Vigia Abandonado → Subúrbio dos Esquecidos
(4,12,7),        -- Cidade Fantasma → Poço de água 
(5,9,7),        -- Terra Chamuscada → Cemitério das Máquinas
(5,10,8),        -- Terra Chamuscada → Colinas Negras
(5,11,7),        -- Terra Chamuscada → Mercabunker
(10,18,10),      -- Colinas Negras → Estação de Tratamento de Água
(12,16,9),       -- Poço de água → Lugar Algum
(12,13,20),      -- Poço de água → Hospital Subterrâneo
(13,14,30),      -- Hospital Subterrâneo → Aeroporto Militar
(15,7,20),       -- Pátio do Ferro-Velho → Base dos Pisa Poeira
(15,8,30),       -- Pátio do Ferro-Velho → Escola Amanhecer Dourado
(18,17,8),         -- Estação de Tratamento de Água → Mêtro do Surfista
(17,9,10),        -- Mêtro do Surfista → Cemitério das Máquinas

-- Rota dos Nigrum Sanguinem
(3, 19, 10),         -- Posto de Vigia Abandonado → Portão Esquecido
(19, 20, 12),         -- Portão Esquecido → Vales da Praga
(20, 21, 15),        -- Vales da Praga → Santuário da Desfiguração
(21, 22, 20),        -- Santuário da Desfiguração → Coração de Sanguinem

-- Rota da Hidra de Carne
(12, 23, 15),         -- Poço de Água → Brejo Mórbido
(13, 23, 12),         -- Hospital Subterrâneo → Brejo Mórbido
(23, 24, 20),        -- Brejo Mórbido → Trilho Encharcado
(24, 25, 20),        -- Trilho Encharcado → Covil da Hidra de Carne

-- Rota da Omni-Mente
(10, 26, 10),         -- Colinas Negras → Túnel de Rastro Químico
(26, 27, 10),         -- Túnel de Rastro Químico → Ninho de Operárias
(27, 28, 15),        -- Ninho de Operárias → Centro de Comando Feromon
(28, 29, 20),        -- Centro de Comando Feromon → Trono da Omni-Mente
(26, 28, 15);         -- Túnel de Rastro Químico → Centro de Comando Feromon 


-- =======================================
-- 6. ACONTECIMENTOS DE MUNDO
-- =======================================

SELECT criar_acontecimento_mundo( 10::SMALLINT, 'Você encontrou uma fogueira com comida, ele pegou um pouco... e recuperou 10 de fome!', 3::SMALLINT, 1::SMALLINT, '1', '25');  -- PI 3: Fogueira (recupera fome)
SELECT criar_acontecimento_mundo( 10::SMALLINT, 'Você encontrou uma fogueira com comida, recuperou 10 de fome!', 3::SMALLINT, 1::SMALLINT, '1', '25');
SELECT criar_acontecimento_mundo( 8::SMALLINT, 'Achou uma garrafa d''água esquecida, recuperou 8 de sede!', 3::SMALLINT, 1::SMALLINT, '1', '20');
SELECT criar_acontecimento_mundo( 12::SMALLINT, 'Você tropeçou em destroços e se feriu, perdeu 12 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '15');
SELECT criar_acontecimento_mundo( 5::SMALLINT, 'Passou por uma área contaminada, ganhou 5 de radiação.', 2::SMALLINT, 1::SMALLINT, '1', '10');
SELECT criar_acontecimento_mundo( -7::SMALLINT, 'Ratos roubaram parte da sua comida, perdeu 7 de fome.', 2::SMALLINT, 1::SMALLINT, '1', '10');
SELECT criar_acontecimento_mundo( -6::SMALLINT, 'Derramou sua água, perdeu 6 de sede.', 2::SMALLINT, 1::SMALLINT, '1', '10');
SELECT criar_acontecimento_mundo( 15::SMALLINT, 'Descansou em um abrigo seguro, recuperou 15 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '10');
SELECT criar_acontecimento_mundo( -4::SMALLINT, 'Encontrou um antídoto, perdeu 4 de radiação.', 2::SMALLINT, 1::SMALLINT, '1', '10');
SELECT criar_acontecimento_mundo( 20::SMALLINT, 'Banquete improvisado! Recuperou 20 de fome.', 1::SMALLINT, 1::SMALLINT, '1', '5');
SELECT criar_acontecimento_mundo( 10::SMALLINT, 'Chuva inesperada, recuperou 10 de sede.', 1::SMALLINT, 1::SMALLINT, '1', '5');
SELECT criar_acontecimento_mundo( 7::SMALLINT, 'Você encontrou frutas silvestres e recuperou 7 de fome.', 2::SMALLINT, 1::SMALLINT, '2', '18');
SELECT criar_acontecimento_mundo( 5::SMALLINT, 'Bebeu água de uma poça, recuperou 5 de sede, mas sente-se estranho.', 2::SMALLINT, 1::SMALLINT, '2', '15');
SELECT criar_acontecimento_mundo( -8::SMALLINT, 'Sua comida estragou, perdeu 8 de fome.', 2::SMALLINT, 1::SMALLINT, '2', '10');
SELECT criar_acontecimento_mundo( 6::SMALLINT, 'Descansou sob uma sombra, recuperou 6 de vida.', 2::SMALLINT, 1::SMALLINT, '2', '12');
SELECT criar_acontecimento_mundo( 3::SMALLINT, 'Achou um cantil velho, recuperou 3 de sede.', 2::SMALLINT, 1::SMALLINT, '3', '10');
SELECT criar_acontecimento_mundo( 4::SMALLINT, 'Encontrou cogumelos comestíveis, recuperou 4 de fome.', 2::SMALLINT, 1::SMALLINT, '3', '10');
SELECT criar_acontecimento_mundo( -5::SMALLINT, 'Foi atacado por insetos, perdeu 5 de vida.', 2::SMALLINT, 1::SMALLINT, '3', '8');
SELECT criar_acontecimento_mundo( 2::SMALLINT, 'Choveu, recuperou 2 de sede.', 2::SMALLINT, 1::SMALLINT, '1', '7');
SELECT criar_acontecimento_mundo( 8::SMALLINT, 'Encontrou um abrigo improvisado, recuperou 8 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( -3::SMALLINT, 'Perdeu parte da água ao atravessar destroços, perdeu 3 de sede.', 2::SMALLINT, 1::SMALLINT, '1', '8');
SELECT criar_acontecimento_mundo( 6::SMALLINT, 'Achou um pacote de biscoitos, recuperou 6 de fome.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( 5::SMALLINT, 'Bebeu água de chuva, recuperou 5 de sede.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( -4::SMALLINT, 'Foi picado por um animal, perdeu 4 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '8');
SELECT criar_acontecimento_mundo( 3::SMALLINT, 'Encontrou um pouco de comida enlatada, recuperou 3 de fome.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( 2::SMALLINT, 'Achou um pouco de água, recuperou 2 de sede.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( -2::SMALLINT, 'Teve um pesadelo, perdeu 2 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '7');
SELECT criar_acontecimento_mundo( 9::SMALLINT, 'Descansou em um banco, recuperou 9 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( -6::SMALLINT, 'Foi surpreendido por um ladrão, perdeu 6 de fome.', 2::SMALLINT, 1::SMALLINT, '1', '8');
SELECT criar_acontecimento_mundo( 4::SMALLINT, 'Achou um filtro de água, recuperou 4 de sede.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( 7::SMALLINT, 'Encontrou um esconderijo com comida, recuperou 7 de fome.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( -5::SMALLINT, 'Foi exposto à radiação, ganhou 5 de radiação.', 2::SMALLINT, 1::SMALLINT, '1', '8');
SELECT criar_acontecimento_mundo( 6::SMALLINT, 'Achou um kit de primeiros socorros, recuperou 6 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( 3::SMALLINT, 'Encontrou uma fonte limpa, recuperou 3 de sede.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( -4::SMALLINT, 'Teve um mal-estar, perdeu 4 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '8');
SELECT criar_acontecimento_mundo( 5::SMALLINT, 'Achou um saco de arroz, recuperou 5 de fome.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( 2::SMALLINT, 'Bebeu água de um poço, recuperou 2 de sede.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( -3::SMALLINT, 'Foi atacado por um animal selvagem, perdeu 3 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '8');
SELECT criar_acontecimento_mundo( 8::SMALLINT, 'Encontrou um refúgio seguro, recuperou 8 de vida.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( -7::SMALLINT, 'Foi roubado durante a noite, perdeu 7 de fome.', 2::SMALLINT, 1::SMALLINT, '1', '8');
SELECT criar_acontecimento_mundo( 4::SMALLINT, 'Achou um galão de água, recuperou 4 de sede.', 2::SMALLINT, 1::SMALLINT, '1', '1');
SELECT criar_acontecimento_mundo( 10::SMALLINT, 'Banquete inesperado! Recuperou 10 de fome.', 2::SMALLINT, 1::SMALLINT, '1', '1');


-- =======================================
-- 7. INIMIGOS NÃO INTELIGENTES
-- =======================================
INSERT INTO Nao_Inteligente (ID_N_Int, Nome, HP_Base, Forca_Base, Defesa_Base, Nivel_Rad) VALUES

-- Inimigos Fáceis
(101, 'Barata Mutante',      20,  4, 0,  0),
(102, 'Cachorro Faminto',    40,  7, 1,  0),
(103, 'Rato Carniceiro',     25,  6, 0,  0),
(104, 'Corvo Mutante',       30,  5, 1,  0),
(105, 'Pombo Radioativo',    22,  3, 1,  2),
(106, 'Cururu Mutante',      20,  4, 0,  0),


-- Inimigos Médios
(201, 'Cachorro Mutante',    75, 12, 3,  5),
(202, 'Robô de Segurança',  110, 15, 6,  0),
(203, 'Jacaré Mutante',      90, 16, 4,  7),


-- Inimigos Difíceis
(301, 'Brutamontes Mutante',180, 20,10, 20),
(302, 'Ecohorror',          140, 18, 4, 15),
(303, 'Urubu de Aço',       130, 14, 3, 10),


-- Hidra de Carne (Lagartos Mutados)
(501, 'Lagarto Mutante',     60, 12, 2,  5),
(502, 'Lagarto Putrefato',   90, 16, 4, 10),
(503, 'Lagarto Espinhoso',   75, 14, 3,  8),


-- Omni-Mente (Formigas Mutadas)
(601, 'Formiga Operária',    25,  6, 0,  3),
(602, 'Formiga Soldado',     55, 12, 2,  7),
(603, 'Formiga Anciã',       90, 15, 4, 12),


-- BOSSES Não Inteligente
(998, 'Hidra de Carne',     320, 28, 9, 25),
(997, 'Omni-mente',         280, 22, 6, 30);



-- =======================================
-- 8. INIMIGOS INTELIGENTES
-- =======================================

INSERT INTO Inteligente (ID_Int, Nome, HP_Base, Forca_Base, Defesa_Base, Nivel_Rad, Alinhamento) VALUES

-- Inimigos Inteligentes Fáceis
(107, 'Catador', 55, 7, 1, 0, 4),
(108, 'Fanático Desconhecido', 50, 6, 2, 1, 2),

-- Inimigos Médios
(204, 'Sobrevivente Hostil', 90, 11, 2, 1, 3),
(205, 'Canibal', 85, 13, 4, 2, 3),

-- Inimigos Difíceis
(304, 'Pessoa Mutante', 130, 16, 6, 5, 3),
(305, 'Ex-Militar Enlouquecido', 160, 18, 6, 4, 3),


-- Nigrum Sanguinem: Hierarquia com nomes próprios
(401, 'Discípulo da Luz Verde', 60, 9, 1, 1, 2),
(402, 'Portador da Chama', 75, 12, 2, 2, 2),
(403, 'Sacerdote da Mutação', 95, 14, 3, 2, 2),
(404, 'Profeta Isótopo', 140, 17, 4, 3, 2),


-- BOSSES Inteligentes
(999, 'Avatar do Núcleo', 300, 25, 10, 8, 2);



-- =======================================
-- 9. ENCONTROS COM INIMIGOS 
-- =======================================

SELECT criar_encontro(103, 1, 2, NULL::INT, '1', '50');
-- ENCONTROS INICIAIS FÁCEIS (PI 2, 3, 4, 5)

-- ENCONTROS INICIAIS FÁCEIS (PI 2, 3, 4, 5)

-- PI 2: Travessia da Poeira
SELECT criar_encontro(101, 2, 2, NULL::INT, '1', '30');  -- 2 Baratas Mutantes
SELECT criar_encontro(107, 1, 2, NULL::INT, '1', '60');  -- 1 Catador

-- PI 3: Posto de Vigia Abandonado
SELECT criar_encontro(103, 2, 3, NULL::INT, '1', '35');  -- 2 Ratos Carniceiros

-- PI 4: Cidade Fantasma
SELECT criar_encontro(105, 3, 4, NULL::INT, '1', '25');  -- 3 Pombos Radioativos
SELECT criar_encontro(107, 1, 4, NULL::INT, '1', '60');  -- 1 Catador

-- PI 5: Terra Chamuscada
SELECT criar_encontro(106, 2, 5, NULL::INT, '1', '30');  -- 2 Cururus Mutantes

-- PI 6: Subúrbio dos Esquecidos
SELECT criar_encontro(103, 2, 6, NULL::INT, '1', '30'); -- 2 Ratos Carniceiros
SELECT criar_encontro(107, 1, 6, NULL::INT, '1', '25'); -- 1 Catador
SELECT criar_encontro(102, 1, 6, NULL::INT, '1', '15'); -- 1 Cachorro Faminto

-- PI 7: Base dos Pisa Poeira
SELECT criar_encontro(107, 1, 7, NULL::INT, '1', '20'); -- 1 Catador

-- PI 8: Escola Amanhecer Dourado
SELECT criar_encontro(103, 2, 8, NULL::INT, '1', '25'); -- 2 Ratos Carniceiros
SELECT criar_encontro(107, 1, 8, NULL::INT, '1', '20'); -- 1 Catador

-- PI 9: Cemitério das Máquinas
SELECT criar_encontro(202, 1, 9, NULL::INT, '2', '20'); -- 1 Robô de Segurança
SELECT criar_encontro(303, 1, 9, NULL::INT, '3', '10'); -- 1 Urubu de Aço
SELECT criar_encontro(107, 1, 9, NULL::INT, '1', '10'); -- 1 Catador

-- PI 10: Colinas Negras
SELECT criar_encontro(104, 2, 10, NULL::INT, '1', '25'); -- 2 Corvos Mutantes
SELECT criar_encontro(105, 2, 10, NULL::INT, '2', '15'); -- 2 Pombos Radioativos
SELECT criar_encontro(301, 1, 10, NULL::INT, '3', '10'); -- 1 Brutamontes Mutante

-- PI 11: Mercabunker
SELECT criar_encontro(107, 1, 11, NULL::INT, '1', '20'); -- 1 Catador

-- PI 12: Poço de água
SELECT criar_encontro(106, 2, 12, NULL::INT, '1', '25'); -- 2 Cururus Mutantes
SELECT criar_encontro(103, 2, 12, NULL::INT, '1', '15'); -- 2 Ratos Carniceiros

-- PI 13: Hospital Subterrâneo
SELECT criar_encontro(301, 1, 13, NULL::INT, '3', '20'); -- 1 Brutamontes Mutante
SELECT criar_encontro(302, 1, 13, NULL::INT, '4', '10'); -- 1 Ecohorror
SELECT criar_encontro(304, 1, 13, NULL::INT, '4', '10'); -- 1 Pessoa Mutante

-- PI 14: Aeroporto Militar
SELECT criar_encontro(302, 1, 14, NULL::INT, '3', '20'); -- 1 Ecohorror
SELECT criar_encontro(305, 1, 14, NULL::INT, '4', '10'); -- 1 Ex-Militar Enlouquecido
SELECT criar_encontro(304, 1, 14, NULL::INT, '4', '10'); -- 1 Pessoa Mutante

-- PI 15: Pátio do Ferro-Velho
SELECT criar_encontro(202, 1, 15, NULL::INT, '2', '20'); -- 1 Robô de Segurança
SELECT criar_encontro(303, 1, 15, NULL::INT, '3', '10'); -- 1 Urubu de Aço
SELECT criar_encontro(107, 1, 15, NULL::INT, '1', '10'); -- 1 Catador

-- PI 16: Lugar Algum
SELECT criar_encontro(103, 1, 16, NULL::INT, '1', '10'); -- 1 Rato Carniceiro

-- PI 17: Mêtro do Surfista
SELECT criar_encontro(103, 2, 17, NULL::INT, '1', '20'); -- 2 Ratos Carniceiros
SELECT criar_encontro(105, 2, 17, NULL::INT, '1', '10'); -- 2 Pombos Radioativos

-- PI 18: Estação de Tratamento de Água
SELECT criar_encontro(106, 2, 18, NULL::INT, '1', '20'); -- 2 Cururus Mutantes
SELECT criar_encontro(203, 1, 18, NULL::INT, '2', '10'); -- 1 Jacaré Mutante

-- =======================================
-- ENCONTROS TEMÁTICOS COM LAGARTOS MUTADOS DA HIDRA DE CARNE
-- =======================================

-- PI 23: Brejo Mórbido (encontros fáceis)
SELECT criar_encontro(501, 1, 23, NULL::INT, '1', '30'); -- 1 Lagarto Mutante
SELECT criar_encontro(501, 2, 23, NULL::INT, '1', '25'); -- 2 Lagartos Mutantes
SELECT criar_encontro(502, 1, 23, NULL::INT, '2', '10'); -- 1 Lagarto Putrefato
SELECT criar_encontro(501, 2, 23, NULL::INT, '2', '10'); -- 2 Lagartos Mutantes
SELECT criar_encontro(501, 1, 23, NULL::INT, '2', '10'); -- 1 Lagarto Mutante

-- PI 24: Trilho Encharcado (encontros intermediários)
SELECT criar_encontro(501, 2, 24, NULL::INT, '2', '25'); -- 2 Lagartos Mutantes
SELECT criar_encontro(502, 1, 24, NULL::INT, '2', '25'); -- 1 Lagarto Putrefato
SELECT criar_encontro(503, 1, 24, NULL::INT, '3', '20'); -- 1 Lagarto Espinhoso
SELECT criar_encontro(502, 2, 24, NULL::INT, '3', '15'); -- 2 Lagartos Putrefatos
SELECT criar_encontro(503, 2, 24, NULL::INT, '3', '10'); -- 2 Lagartos Espinhosos
SELECT criar_encontro(502, 1, 24, NULL::INT, '3', '10'); -- 1 Lagarto Putrefato
SELECT criar_encontro(503, 1, 24, NULL::INT, '3', '10'); -- 1 Lagarto Espinhoso

-- Encontro com a Hidra de Carne

-- PI 25: Covil da Hidra de Carne (boss)
SELECT criar_encontro(998, 1, 25, 1, '5', '100'); -- 1 Hidra de Carne (boss)

-- =======================================
-- ENCONTROS TEMÁTICOS COM FORMIGAS MUTADAS DA OMNI-MENTE
-- =======================================

-- PI 26: Túnel de Rastro Químico (encontros fáceis)
SELECT criar_encontro(601, 2, 26, NULL::INT, '1', '30'); -- 2 Formigas Operárias
SELECT criar_encontro(601, 3, 26, NULL::INT, '1', '20'); -- 3 Formigas Operárias
SELECT criar_encontro(601, 1, 26, NULL::INT, '2', '15'); -- 1 Formiga Operária

-- PI 27: Ninho de Operárias (encontros intermediários)
SELECT criar_encontro(601, 2, 27, NULL::INT, '2', '25'); -- 2 Formigas Operárias
SELECT criar_encontro(602, 1, 27, NULL::INT, '2', '25'); -- 1 Formiga Soldado
SELECT criar_encontro(601, 1, 27, NULL::INT, '2', '20'); -- 1 Formiga Operária
SELECT criar_encontro(602, 2, 27, NULL::INT, '3', '15'); -- 2 Formigas Soldado
SELECT criar_encontro(601, 1, 27, NULL::INT, '3', '10'); -- 1 Formiga Operária
SELECT criar_encontro(602, 1, 27, NULL::INT, '3', '10'); -- 1 Formiga Soldado

-- PI 28: Centro de Comando Feromon (encontros difíceis)
SELECT criar_encontro(602, 2, 28, NULL::INT, '3', '20'); -- 2 Formigas Soldado
SELECT criar_encontro(603, 1, 28, NULL::INT, '3', '20'); -- 1 Formiga Anciã
SELECT criar_encontro(602, 1, 28, NULL::INT, '4', '15'); -- 1 Formiga Soldado
SELECT criar_encontro(603, 2, 28, NULL::INT, '4', '10'); -- 2 Formigas Anciã
SELECT criar_encontro(602, 1, 28, NULL::INT, '4', '10'); -- 1 Formiga Soldado
SELECT criar_encontro(603, 1, 28, NULL::INT, '4', '10'); -- 1 Formiga Anciã

-- PI 29: Trono da Omni-Mente (boss)
SELECT criar_encontro(997, 1, 29, 1, '5', '100'); -- 1 Omni-Mente (boss)

-- =======================================
-- ENCONTROS TEMÁTICOS COM O CULTO
-- =======================================

-- PI 19: Portão Esquecido (encontros fáceis)
SELECT criar_encontro(401, 1, 19, NULL::INT, '1', '30'); -- 1 Discípulo da Luz Verde
SELECT criar_encontro(401, 2, 19, NULL::INT, '1', '25'); -- 2 Discípulos da Luz Verde
SELECT criar_encontro(402, 1, 19, NULL::INT, '2', '15'); -- 1 Portador da Chama
SELECT criar_encontro(401, 2, 19, NULL::INT, '2', '10'); -- 2 Discípulos da Luz Verde
SELECT criar_encontro(402, 1, 19, NULL::INT, '2', '10'); -- 1 Portador da Chama

-- PI 20: Vales da Praga (encontros intermediários)
SELECT criar_encontro(402, 2, 20, NULL::INT, '2', '25'); -- 2 Portadores da Chama
SELECT criar_encontro(403, 1, 20, NULL::INT, '2', '25'); -- 1 Sacerdote da Mutação
SELECT criar_encontro(402, 1, 20, NULL::INT, '3', '20'); -- 1 Portador da Chama
SELECT criar_encontro(403, 1, 20, NULL::INT, '3', '15'); -- 1 Sacerdote da Mutação
SELECT criar_encontro(402, 2, 20, NULL::INT, '3', '10'); -- 2 Portadores da Chama
SELECT criar_encontro(403, 1, 20, NULL::INT, '3', '10'); -- 1 Sacerdote da Mutação

-- PI 21: Santuário da Desfiguração (encontros difíceis)
SELECT criar_encontro(403, 2, 21, NULL::INT, '3', '25'); -- 2 Sacerdotes da Mutação
SELECT criar_encontro(404, 1, 21, NULL::INT, '3', '25'); -- 1 Profeta Isótopo
SELECT criar_encontro(403, 1, 21, NULL::INT, '4', '20'); -- 1 Sacerdote da Mutação
SELECT criar_encontro(404, 1, 21, NULL::INT, '4', '15'); -- 1 Profeta Isótopo
SELECT criar_encontro(403, 2, 21, NULL::INT, '4', '10'); -- 2 Sacerdotes da Mutação
SELECT criar_encontro(404, 1, 21, NULL::INT, '4', '10'); -- 1 Profeta Isótopo

-- PI 22: Coração de Sanguinem (boss)
SELECT criar_encontro(999, 1, 22, 1, '5', '100'); -- 1 Avatar do Núcleo (boss)

-- =======================================
-- 10. ITENS
-- ======================================= 

INSERT INTO Item (ID_Item, Tipo) VALUES
(1001, 'Utilizável'),  -- Carne Mutante Crua
(1002, 'Utilizável'),  -- Água Contaminada
(1003, 'Utilizável'),  -- Estimulante de Sobrevivência
(1004, 'Utilizável'),  -- Soro Anti-Rad
(1005, 'Utilizável'),  -- Comida Enlatada Antiga
(1006, 'Utilizável'),  -- Garrafa de Água Limpa

(2001, 'Equipável'),  -- Capacete Enferrujado
(2002, 'Equipável'),  -- Colete de Couro Cru
(2003, 'Equipável'),  -- Luvas de Borracha
(2004, 'Equipável'),  -- Bota Improvisada
(2005, 'Equipável'),  -- Pé-de-Cabra Enferrujado
(2006, 'Equipável'),  -- Armadura de Sucata
(2007, 'Equipável'),  -- Espinhos de Lagarto
(2008, 'Equipável'),  -- Capacete Tático Antigo
(2009, 'Equipável'),  -- Mão Robótica Quebrada
(2010, 'Equipável'),  -- Espingarda Improvisada

(3001, 'Material'),  -- Circuito Danificado
(3002, 'Material'),  -- Pedaço de Metal
(3003, 'Material'),  -- Glândula Mutante
(3004, 'Material'),  -- Fragmento de Osso
(3005, 'Material'),  -- Óleo Radioativo

(4001, 'Equipável'), -- Lâmina do Profeta Isótopo
(4002, 'Equipável'), -- Armadura de Quitina
(4003, 'Equipável'); -- Crânio da Hidra de Carne


INSERT INTO Utilizavel (ID_Uti, Nome, Atributo, Valor) VALUES
(1001, 'Carne Mutante Crua', 'Fome_Atual', -10), -- dá fome e pode causar efeito ruim
(1002, 'Água Contaminada', 'Sede_Atual', -5),
(1003, 'Estimulante de Sobrevivência', 'HP_Atual', 30),
(1004, 'Soro Anti-Rad', 'Nivel_Rad_Atual', -15),
(1005, 'Comida Enlatada Antiga', 'Fome_Atual', 25),
(1006, 'Garrafa de Água Limpa', 'Sede_Atual', 30);

INSERT INTO Equipavel (ID_Equi, Nome, Atributo, Valor, Parte_Corpo) VALUES
(2001, 'Capacete Enferrujado', 'Defesa_Atual', 2, 'Cabeça'),
(2002, 'Colete de Couro Cru', 'Defesa_Atual', 4, 'Tronco'),
(2003, 'Luvas de Borracha', 'Defesa_Atual', 1, 'Braço'),
(2004, 'Bota Improvisada', 'Defesa_Atual', 2, 'Perna'),
(2005, 'Pé-de-Cabra Enferrujado', 'Forca_Atual', 5, 'Arma'),
(2006, 'Armadura de Sucata', 'Defesa_Atual', 6, 'Tronco'),
(2007, 'Espinhos de Lagarto', 'Forca_Atual', 4, 'Braço'),
(2008, 'Capacete Tático Antigo', 'Defesa_Atual', 3, 'Cabeça'),
(2009, 'Mão Robótica Quebrada', 'Forca_Atual', 6, 'Braço'),
(2010, 'Espingarda Improvisada', 'Forca_Atual', 10, 'Arma'),
(2011, 'Lança do Profeta Isótopo', 'Forca_Atual', 10, 'Arma'),
(4001, 'Lâmina do Profeta Isótopo', 'Forca_Atual', 15, 'Arma'),
(4002, 'Armadura de Quitina', 'Defesa_Atual', 12, 'Tronco'),
(4003, 'Crânio da Hidra de Carne', 'Defesa_Atual', 14, 'Cabeça');

INSERT INTO Material (ID_Mat, Nome) VALUES
(3001, 'Circuito Danificado'),
(3002, 'Pedaço de Metal'),
(3003, 'Glândula Mutante'),
(3004, 'Fragmento de Osso'),
(3005, 'Óleo Radioativo');


-- =======================================
-- 8. DROPS
-- =======================================

-- Barata Mutante
INSERT INTO NPC_Dropa VALUES
(101, 1001, 40),  -- Carne Mutante Crua
(101, 3004, 30);  -- Fragmento de Osso

-- Cachorro Faminto
INSERT INTO NPC_Dropa VALUES
(102, 1001, 50),  -- Carne Mutante Crua
(102, 3002, 30);  -- Pedaço de Metal

-- Rato Carniceiro
INSERT INTO NPC_Dropa VALUES
(103, 1001, 35),
(103, 3004, 30);

-- Corvo Mutante
INSERT INTO NPC_Dropa VALUES
(104, 1001, 30),
(104, 3005, 25);  -- Óleo Radioativo

-- Pombo Radioativo
INSERT INTO NPC_Dropa VALUES
(105, 1002, 40),  -- Água Contaminada
(105, 3005, 20);

-- Cururu Mutante
INSERT INTO NPC_Dropa VALUES
(106, 1001, 35),
(106, 3003, 25);  -- Glândula Mutante

-- Cachorro Mutante
INSERT INTO NPC_Dropa VALUES
(201, 1005, 50),  -- Comida Enlatada Antiga
(201, 3003, 40);

-- Robô de Segurança
INSERT INTO NPC_Dropa VALUES
(202, 3001, 60),  -- Circuito Danificado
(202, 2009, 50);  -- Mão Robótica Quebrada

-- Jacaré Mutante
INSERT INTO NPC_Dropa VALUES
(203, 1001, 50),
(203, 2007, 45);  -- Espinhos de Lagarto

-- Brutamontes Mutante
INSERT INTO NPC_Dropa VALUES
(301, 2006, 60),  -- Armadura de Sucata
(301, 1003, 40);  -- Estimulante

-- Ecohorror
INSERT INTO NPC_Dropa VALUES
(302, 1004, 50),  -- Soro Anti-Rad
(302, 3005, 60);  -- Óleo Radioativo

-- Urubu de Aço
INSERT INTO NPC_Dropa VALUES
(303, 3001, 55),
(303, 2008, 45);  -- Capacete Tático Antigo

-- Lagarto Mutante
INSERT INTO NPC_Dropa VALUES
(501, 2007, 40),  -- Espinhos de Lagarto
(501, 3003, 35);

-- Lagarto Putrefato
INSERT INTO NPC_Dropa VALUES
(502, 2002, 50),  -- Colete de Couro Cru
(502, 1001, 40);

-- Lagarto Espinhoso
INSERT INTO NPC_Dropa VALUES
(503, 2003, 50),  -- Luvas de Borracha
(503, 3004, 40);

-- Formiga Operária
INSERT INTO NPC_Dropa VALUES
(601, 3003, 30),
(601, 1001, 30);

-- Formiga Soldado
INSERT INTO NPC_Dropa VALUES
(602, 2003, 40),  -- Luvas
(602, 3005, 40);

-- Formiga Anciã
INSERT INTO NPC_Dropa VALUES
(603, 2002, 50),  -- Colete
(603, 3003, 50);

-- Catador
INSERT INTO NPC_Dropa VALUES
(107, 1002, 30),
(107, 3002, 40);

-- Fanático Desconhecido
INSERT INTO NPC_Dropa VALUES
(108, 1004, 30),
(108, 3005, 30);

-- Sobrevivente Hostil
INSERT INTO NPC_Dropa VALUES
(204, 1005, 50),
(204, 2005, 40);  -- Pé-de-Cabra

-- Canibal
INSERT INTO NPC_Dropa VALUES
(205, 1001, 60),
(205, 2004, 40);  -- Bota Improvisada

-- Pessoa Mutante
INSERT INTO NPC_Dropa VALUES
(304, 1003, 50),
(304, 2006, 50);

-- Ex-Militar Enlouquecido
INSERT INTO NPC_Dropa VALUES
(305, 2008, 50),
(305, 2010, 50);  -- Espingarda Improvisada

-- Nigrum Sanguinem (hierarquia)
INSERT INTO NPC_Dropa VALUES
(401, 1002, 30),
(402, 1004, 40),
(403, 2001, 50),
(404, 2011, 70);


-- Bosses
INSERT INTO NPC_Dropa VALUES
(997, 4002, 100),  -- Omni-Mente → Peitoral
(998, 4003, 100),  -- Hidra de Carne → Capacete
(999, 4001, 100);  -- Hidra de Carne → Capacete




