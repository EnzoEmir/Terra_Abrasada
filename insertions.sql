INSERT INTO Ser (ID_Ser, Tipo) VALUES
(1, 'Prota'),
(2, 'Prota'),
(3, 'Prota');

INSERT INTO Faccao (ID_Faccao, Nome) VALUES
(0, 'Neutro'),
(1, 'Pisa-Poeira'),
(2, 'Tecnocratas');

INSERT INTO Prota (ID_Pro, Nome, HP_Base, Forca_Base, Defesa_Base, Nivel_Rad, Alinhamento, Fome_Base, Sede_Base) VALUES
(1, 'Brutamontes', 120, 20, 15, 5, 1, 70, 70),
(2, 'Sobrevivente', 100, 15, 15, 3, 0, 100, 100),
(3, 'Maromba', 110, 25, 10, 4, 1, 60, 70);

INSERT INTO Ponto_Interesse (ID_PI, Nome, Niv_Rad) VALUES
(1, 'Base', 1),
(2, 'Refúgio Subterrâneo', 2),
(3, 'Zona Quente', 7);