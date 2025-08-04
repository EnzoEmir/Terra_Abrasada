CREATE TABLE Mutacao (
    ID_Mutacao SMALLINT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Atributo VARCHAR(20) NOT NULL,
    Valor SMALLINT NOT NULL,
    Parte_Corpo VARCHAR(20) NOT NULL
);

CREATE TABLE Faccao (
    ID_Faccao SMALLINT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL
);

CREATE TABLE Ser (
    ID_Ser SMALLINT PRIMARY KEY,
    Tipo VARCHAR(20) NOT NULL
);

CREATE TABLE Nao_Inteligente (
    ID_N_Int SMALLINT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    HP_Base SMALLINT NOT NULL,
    Forca_Base SMALLINT NOT NULL,
    Defesa_Base SMALLINT NOT NULL,
    Nivel_Rad SMALLINT NOT NULL,
    FOREIGN KEY (ID_N_Int) REFERENCES Ser(ID_Ser)
);

CREATE TABLE Inteligente (
    ID_Int SMALLINT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    HP_Base SMALLINT NOT NULL,
    Forca_Base SMALLINT NOT NULL,
    Defesa_Base SMALLINT NOT NULL,
    Nivel_Rad SMALLINT NOT NULL,
    Alinhamento SMALLINT NOT NULL,
    FOREIGN KEY (ID_Int) REFERENCES Ser(ID_Ser),
    FOREIGN KEY (Alinhamento) REFERENCES Faccao(ID_Faccao)
);

CREATE TABLE Prota (
    ID_Pro SMALLINT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    HP_Base SMALLINT NOT NULL,
    Forca_Base SMALLINT NOT NULL,
    Defesa_Base SMALLINT NOT NULL,
    Nivel_Rad SMALLINT NOT NULL,
    Alinhamento SMALLINT NOT NULL,
    Fome_Base SMALLINT NOT NULL,
    Sede_Base SMALLINT NOT NULL,
    FOREIGN KEY (ID_Pro) REFERENCES Ser(ID_Ser),
    FOREIGN KEY (Alinhamento) REFERENCES Faccao(ID_Faccao)
);

CREATE TABLE Ponto_Interesse (
    ID_PI SMALLINT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Niv_Rad SMALLINT NOT NULL
);

CREATE TABLE Item (
    ID_Item SMALLINT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Utilizavel (
    ID_Uti SMALLINT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Atributo VARCHAR(20) NOT NULL,
    Valor SMALLINT NOT NULL,
    FOREIGN KEY (ID_Uti) REFERENCES Item(ID_Item)
);

CREATE TABLE Material (
    ID_Mat SMALLINT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_Mat) REFERENCES Item(ID_Item)
);

CREATE TABLE Equipavel (
    ID_Equi SMALLINT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Atributo VARCHAR(20) NOT NULL,
    Valor SMALLINT NOT NULL,
    Parte_Corpo VARCHAR(15) NOT NULL,
    FOREIGN KEY (ID_Equi) REFERENCES Item(ID_Item)
);

CREATE TABLE Itens_Loja (
    ID_Item_Loja SMALLINT PRIMARY KEY,
    Preco SMALLINT NOT NULL,
    FOREIGN KEY (ID_Item_Loja) REFERENCES Item(ID_Item)
);

CREATE TABLE Inst_Item (
    ID_Inst SMALLINT PRIMARY KEY,
    ID_Item SMALLINT NOT NULL,
    Save SMALLINT NOT NULL,
    Localizacao SMALLINT,
    FOREIGN KEY (ID_Item) REFERENCES Item(ID_Item),
    FOREIGN KEY (Localizacao) REFERENCES Ponto_Interesse(ID_PI)
);

CREATE TABLE Inst_Prota (
    ID_Inst SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Ser SMALLINT NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    HP_Atual SMALLINT NOT NULL,
    Forca_Atual SMALLINT NOT NULL,
    Defesa_Atual SMALLINT NOT NULL,
    Nivel_Rad_Atual SMALLINT NOT NULL,
    Alinhamento_Atual SMALLINT NOT NULL,
    Fome_Atual SMALLINT NOT NULL,
    Sede_Atual SMALLINT NOT NULL,
    Mut_Cab SMALLINT ,
    Mut_Tronco SMALLINT ,
    Mut_Braco SMALLINT ,
    Mut_Perna SMALLINT ,
    Eq_Cab SMALLINT ,
    Eq_Tronco SMALLINT ,
    Eq_Braco SMALLINT ,
    Eq_Perna SMALLINT ,
    Arma_Atual SMALLINT ,
    Save SMALLINT NOT NULL,
    Localizacao SMALLINT NOT NULL,
    FOREIGN KEY (ID_Ser) REFERENCES Ser(ID_Ser),
    FOREIGN KEY (Alinhamento_Atual) REFERENCES Faccao(ID_Faccao),
    FOREIGN KEY (Mut_Cab) REFERENCES Mutacao(ID_Mutacao),
    FOREIGN KEY (Mut_Tronco) REFERENCES Mutacao(ID_Mutacao),
    FOREIGN KEY (Mut_Braco) REFERENCES Mutacao(ID_Mutacao),
    FOREIGN KEY (Mut_Perna) REFERENCES Mutacao(ID_Mutacao),
    FOREIGN KEY (Eq_Cab) REFERENCES Inst_Item(ID_Inst),
    FOREIGN KEY (Eq_Tronco) REFERENCES Inst_Item(ID_Inst),
    FOREIGN KEY (Eq_Braco) REFERENCES Inst_Item(ID_Inst),
    FOREIGN KEY (Eq_Perna) REFERENCES Inst_Item(ID_Inst),
    FOREIGN KEY (Arma_Atual) REFERENCES Inst_Item(ID_Inst),
    FOREIGN KEY (Localizacao) REFERENCES Ponto_Interesse(ID_PI)
);

CREATE TABLE Inst_NPC (
    ID_Inst SMALLINT PRIMARY KEY,
    ID_Ser SMALLINT NOT NULL,
    HP_Atual SMALLINT NOT NULL,
    Forca_Atual SMALLINT NOT NULL,
    Defesa_Atual SMALLINT NOT NULL,
    Save SMALLINT NOT NULL,
    Localizacao SMALLINT NOT NULL,
    FOREIGN KEY (ID_Ser) REFERENCES Ser(ID_Ser),
    FOREIGN KEY (Localizacao) REFERENCES Ponto_Interesse(ID_PI)
);

CREATE TABLE NPC_Dropa (
    ID_NPC SMALLINT,
    ID_Item SMALLINT,
    PRIMARY KEY (ID_NPC, ID_Item),
    FOREIGN KEY (ID_NPC) REFERENCES Ser(ID_Ser),
    FOREIGN KEY (ID_Item) REFERENCES Inst_Item(ID_Inst)
);

CREATE TABLE Inventario (
    Pos_Inv SMALLINT PRIMARY KEY,
    ID_Inst_Item SMALLINT NOT NULL,
    Quantidade SMALLINT NOT NULL,
    FOREIGN KEY (ID_Inst_Item) REFERENCES Inst_Item(ID_Inst)
);

CREATE TABLE Conexao (
    Origem SMALLINT,
    Destino SMALLINT,
    Custo SMALLINT NOT NULL,
    PRIMARY KEY (Origem, Destino),
    FOREIGN KEY (Origem) REFERENCES Ponto_Interesse(ID_PI),
    FOREIGN KEY (Destino) REFERENCES Ponto_Interesse(ID_PI)
);

CREATE TABLE Base (
    Nivel SMALLINT PRIMARY KEY,
    ID_PI SMALLINT UNIQUE NOT NULL,
    Nome VARCHAR(30) NOT NULL,
    FOREIGN KEY (ID_PI) REFERENCES Ponto_Interesse(ID_PI)
);


CREATE TABLE Base_Atual (
    ID_Save SMALLINT PRIMARY KEY,
    Nivel_Base SMALLINT NOT NULL,
    FOREIGN KEY (Nivel_Base) REFERENCES Base(Nivel)
);

CREATE TABLE Bau_Base (
    Pos_Bau SMALLINT PRIMARY KEY,
    ID_Inst_Item SMALLINT NOT NULL,
    Quantidade SMALLINT NOT NULL,
    FOREIGN KEY (ID_Inst_Item) REFERENCES Inst_Item(ID_Inst)
);

CREATE TABLE Evento (
    ID_Evento SMALLINT PRIMARY KEY,
    Max_Ocorrencia SMALLINT NOT NULL
);

CREATE TABLE Ocorre (
    ID_Evento SMALLINT,
    ID_PI SMALLINT,
    PRIMARY KEY (ID_Evento, ID_PI),
    FOREIGN KEY (ID_Evento) REFERENCES Evento(ID_Evento),
    FOREIGN KEY (ID_PI) REFERENCES Ponto_Interesse(ID_PI)
);

CREATE TABLE Requisito (
    ID_Requisito SMALLINT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL,
    Alvo VARCHAR(50) NOT NULL,
    Quantidade SMALLINT NOT NULL
);

CREATE TABLE Missao (
    ID_Evento SMALLINT PRIMARY KEY,
    ID_Requisito SMALLINT NOT NULL,
    Recompensa SMALLINT NOT NULL,
    Prox SMALLINT,
    FOREIGN KEY (ID_Evento) REFERENCES Evento(ID_Evento),
    FOREIGN KEY (ID_Requisito) REFERENCES Requisito(ID_Requisito),
    FOREIGN KEY (Recompensa) REFERENCES Item(ID_Item),
    FOREIGN KEY (Prox) REFERENCES Evento(ID_Evento)
);

CREATE TABLE Status_Missao (
    ID_Save SMALLINT NOT NULL,
    ID_Missao SMALLINT NOT NULL,
    PRIMARY KEY (ID_Save, ID_Missao),
    Progresso_Atual SMALLINT NOT NULL
);

CREATE TABLE Acontecimento (
    ID_Evento SMALLINT PRIMARY KEY,
    Atributo  SMALLINT NOT NULL,
    Valor SMALLINT NOT NULL,
    Texto SMALLINT NOT NULL,
    FOREIGN KEY (ID_Evento) REFERENCES Evento(ID_Evento)
);

CREATE TABLE Encontro(
    ID_Evento SMALLINT,
    ID_Inimigo SMALLINT,
    Quantidade SMALLINT NOT NULL,
    PRIMARY KEY (ID_Evento, ID_Inimigo),
    FOREIGN KEY (ID_Evento) REFERENCES Evento(ID_Evento),
    FOREIGN KEY (ID_Inimigo) REFERENCES Ser(ID_Ser)
);

