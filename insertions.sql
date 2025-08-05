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
(3, 'Prota');

-- =======================================
-- 3. FACÇÕES
-- =======================================
INSERT INTO Faccao (ID_Faccao, Nome) VALUES
(0, 'Neutro'),
(1, 'Pisa-Poeira'),
(2, 'Tecnocratas');

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
