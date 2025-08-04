### Legenda

- **PK**: Chave primária
- **FK**: Chave estrangeira
- **Nulo?**: Se a coluna aceita ou não valores nulos  
✔️ = Sim / ❌ = Não

###  Tabela: Mutacao

| Coluna        | Tipo de dado | PK | FK | Nulo? | Descrição                                                                 |
|---------------|--------------|----|----|--------|---------------------------------------------------------------------------|
| ID_Mutacao    | SMALLINT          | ✔️ |    | ❌     | Identificador único da mutação.                                          |
| Nome          | VARCHAR(50) |    |    | ❌     | Nome da mutação.                                                         |
| Atributo      | VARCHAR(20)  |    |    | ❌     | Atributo que a mutação afeta (ex: Força, Defesa, etc).                   |
| Valor         | SMALLINT          |    |    | ❌     | Valor numérico da modificação causada pela mutação.                      |
| Parte_Corpo   | VARCHAR(20)  |    |    | ❌     | Parte do corpo afetada pela mutação (Ex: Braço, Perna).                  |

---

###  Tabela: Inst_Prota

| Coluna             | Tipo de dado | PK | FK | Nulo? | Descrição                                                                 |
|--------------------|--------------|----|----|--------|---------------------------------------------------------------------------|
| ID_Inst             | SMALLINT          | ✔️ |    | ❌     | Identificador da instância do protagonista.                              |
| ID_Ser             | SMALLINT          |    | Ser(ID_Ser) | ❌     | Referência ao tipo base do ser (modelo do personagem).                   |
| Nome               | VARCHAR(100) |    |    | ❌     | Nome personalizado da instância.                                         |
| HP_Atual           | SMALLINT          |    |    | ❌     | Pontos de vida atuais.                                                   |
| Forca_Atual        | SMALLINT          |    |    | ❌     | Valor atual de força.                                                    |
| Defesa_Atual       | SMALLINT          |    |    | ❌     | Valor atual de defesa.                                                   |
| Nivel_Rad_Atual    | SMALLINT          |    |    | ❌     | Nível atual de radiação.                                                 |
| Alinhamento_Atual  | SMALLINT          |    | Faccao(ID_Faccao) | ❌     | Referência ao alinhamento/facção atual .              |
| Fome_Atual         | SMALLINT          |    |    | ❌     | Nível atual de fome.                                                     |
| Sede_Atual         | SMALLINT          |    |    | ❌     | Nível atual de sede.                                                     |
| Mut_Cab            | SMALLINT          |    | Mutacao(ID_Mutacao) | ❌     | FK para mutação aplicada à cabeça.                                       |
| Mut_Tronco         | SMALLINT          |    | Mutacao(ID_Mutacao) | ❌     | FK para mutação aplicada ao tronco.                                      |
| Mut_Braco          | SMALLINT          |    | Mutacao(ID_Mutacao) | ❌     | FK para mutação aplicada ao braço.                                       |
| Mut_Perna          | SMALLINT          |    | Mutacao(ID_Mutacao) | ❌     | FK para mutação aplicada à perna.                                        |
| Eq_Cab             | SMALLINT          |    | Inst_Item(ID_Inst) | ❌     | FK para equipamento usado na cabeça.                                     |
| Eq_Tronco          | SMALLINT          |    | Inst_Item(ID_Inst) | ❌     | FK para equipamento usado no tronco.                                     |
| Eq_Braco           | SMALLINT          |    | Inst_Item(ID_Inst) | ❌     | FK para equipamento usado no braço.                                      |
| Eq_Perna           | SMALLINT          |    | Inst_Item(ID_Inst) | ❌     | FK para equipamento usado na perna.                                      |
| Arma_Atual         | SMALLINT          |    | Inst_Item(ID_Inst) | ❌     | FK para arma atualmente equipada.                                        |
| Save               | SMALLINT          |    |  | ❌     | Save ao qual essa instância está associada.                  |
| Localizacao        | SMALLINT          |    | Ponto_Interesse(ID_PI) | ❌     | FK para a localização atual do personagem.                               |

---

###  Tabela: Inst_NPC

| Coluna        | Tipo de dado | PK | FK | Nulo? | Descrição                                                               |
|---------------|--------------|----|----|--------|-------------------------------------------------------------------------|
| ID_Inst       | SMALLINT          | ✔️ |    | ❌     | Identificador da instância do NPC.                                     |
| ID_Ser        | SMALLINT          |    | Ser(ID_Ser) | ❌     | Referência ao ser base que define o tipo e atributos do NPC.           |
| HP_Atual      | SMALLINT          |    |    | ❌     | Pontos de vida atuais do NPC.                                          |
| Forca_Atual   | SMALLINT          |    |    | ❌     | Força atual do NPC.                                                    |
| Defesa_Atual  | SMALLINT          |    |    | ❌     | Defesa atual do NPC.                                                   |
| Save          | SMALLINT          |    |  | ❌     | Save ao qual essa instância está associada.                            |
| Localizacao   | SMALLINT          |    | Ponto_Interesse(ID_PI) | ❌     | Localização atual do NPC no jogo.                                      |

---

###  Tabela: Ser

| Coluna   | Tipo de dado | PK | FK | Nulo? | Descrição                                              |
|----------|--------------|----|----|--------|--------------------------------------------------------|
| ID_Ser   | SMALLINT          | ✔️ |    | ❌     | Identificador único do ser base.                      |
| Tipo     | VARCHAR(20)  |    |    | ❌     | Tipo do ser (ex: Inteligente, Não_Inteligente, Prota).  |

---

###  Tabela: Nao_Inteligente

| Coluna     | Tipo de dado | PK | FK | Nulo? | Descrição                                       |
|------------|--------------|----|----|--------|-------------------------------------------------|
| ID_N_Int   | SMALLINT          | ✔️ |  Ser(ID_Ser)  | ❌     | Identificador único do ser não inteligente.     |
| Nome       | VARCHAR(50) |    |    | ❌     | Nome do ser.                                   |
| HP_Base    | SMALLINT          |    |    | ❌     | Pontos de vida base.                           |
| Forca_Base | SMALLINT          |    |    | ❌     | Força base do ser.                             |
| Defesa_Base| SMALLINT          |    |    | ❌     | Defesa base do ser.                            |
| Nivel_Rad  | SMALLINT          |    |    | ❌     | Nível de radiação associado ao ser.            |

---

###  Tabela: Inteligente

| Coluna     | Tipo de dado | PK | FK | Nulo? | Descrição                                       |
|------------|--------------|----|----|--------|-------------------------------------------------|
| ID_Int     | SMALLINT          | ✔️ |  Ser(ID_Ser)  | ❌     | Identificador único do ser inteligente.         |
| Nome       | VARCHAR(50) |    |    | ❌     | Nome do ser.                                   |
| HP_Base    | SMALLINT          |    |    | ❌     | Pontos de vida base.                           |
| Forca_Base | SMALLINT          |    |    | ❌     | Força base do ser.                             |
| Defesa_Base| SMALLINT          |    |    | ❌     | Defesa base do ser.                            |
| Nivel_Rad  | SMALLINT          |    |    | ❌     | Nível de radiação associado ao ser.            |
| Alinhamento| SMALLINT          |    | Faccao(ID_Faccao) | ❌     | Chave estrangeira para o alinhamento moral.    |

---
###  Tabela: Prota

| Coluna      | Tipo de dado | PK | FK | Nulo? | Descrição                                                   |
|-------------|--------------|----|----|--------|-------------------------------------------------------------|
| ID_Pro      | SMALLINT          | ✔️ |  Ser(ID_Ser)  | ❌     | Identificador único do protagonista base.                  |
| Nome        | VARCHAR(50) |    |    | ❌     | Nome do personagem jogável.                                |
| HP_Base     | SMALLINT          |    |    | ❌     | Pontos de vida base do protagonista.                       |
| Forca_Base  | SMALLINT          |    |    | ❌     | Força base do protagonista.                                |
| Defesa_Base | SMALLINT          |    |    | ❌     | Defesa base do protagonista.                               |
| Nivel_Rad   | SMALLINT          |    |    | ❌     | Nível de radiação base.                                    |
| Alinhamento | SMALLINT          |    | Faccao(ID_Faccao) | ❌     | FK para o alinhamento inicial do protagonista.             |
| Fome_Base   | SMALLINT          |    |    | ❌     | Nível de fome base.                                        |
| Sede_Base   | SMALLINT          |    |    | ❌     | Nível de sede base.                                        |

---

###  Tabela: Faccao

| Coluna      | Tipo de dado | PK | FK | Nulo? | Descrição                                   |
|-------------|--------------|----|----|--------|---------------------------------------------|
| ID_Faccao   | SMALLINT          | ✔️ |    | ❌     | Identificador único da facção.              |
| Nome        | VARCHAR(50) |    |    | ❌     | Nome da facção (grupo, organização, etc).   |

---
###  Tabela: NPC_Dropa

| Coluna   | Tipo de dado | PK | FK | Nulo? | Descrição                                                       |
|----------|--------------|----|----|--------|-----------------------------------------------------------------|
| ID_NPC   | SMALLINT          | ✔️ | Ser(ID_Ser) | ❌     | FK para o NPC que pode dropar o item.                          |
| ID_Item  | SMALLINT          | ✔️ | Inst_Item(ID_Inst) | ❌     | FK para o item que pode ser dropado por esse NPC.              |

---

###  Tabela: Inst_Item

| Coluna      | Tipo de dado | PK | FK | Nulo? | Descrição                                                  |
|-------------|--------------|----|----|--------|------------------------------------------------------------|
| ID_Inst     | SMALLINT          | ✔️ |    | ❌     | Identificador único da instância do item.                  |
| ID_Item     | SMALLINT          |    | Item(Id_Item) | ❌     | FK para a base do item.                               |
| Save        | SMALLINT          |    |  | ❌     | Save ao qual essa instância está associada.                    |
| Localizacao | SMALLINT          |    | Ponto_Interesse(ID_PI) | ✔️     | FK para a localização atual do item no mundo do jogo.      |

---

###  Tabela: Item

| Coluna    | Tipo de dado | PK | FK | Nulo? | Descrição                                 |
|-----------|--------------|----|----|--------|-------------------------------------------|
| ID_Item   | SMALLINT          | ✔️ |    | ❌     | Identificador único do item.      |
| Tipo      | VARCHAR(50)  |    |    | ❌     | Tipo do item (Utilizável, Material, Equipável). |

---

###  Tabela: Utilizavel

| Coluna    | Tipo de dado | PK | FK | Nulo? | Descrição                                               |
|-----------|--------------|----|----|--------|---------------------------------------------------------|
| ID_Uti    | SMALLINT          | ✔️ |  Item(Id_Item)   | ❌     | Identificador único do item utilizável.                |
| Nome      | VARCHAR(50) |    |    | ❌     | Nome do item.                                           |
| Atributo  | VARCHAR(20)  |    |    | ❌     | Atributo afetado pelo uso do item.                      |
| Valor     | SMALLINT          |    |    | ❌     | Valor da alteração aplicada pelo item ao atributo.      |

---

###  Tabela: Material

| Coluna   | Tipo de dado | PK | FK | Nulo? | Descrição                             |
|----------|--------------|----|----|--------|-----------------------------------------|
| ID_Mat   | SMALLINT          | ✔️ |  Item(Id_Item)   | ❌     | Identificador único do material.       |
| Nome     | VARCHAR(50) |    |    | ❌     | Nome do material.                      |

---

###  Tabela: Equipavel

| Coluna      | Tipo de dado | PK | FK | Nulo? | Descrição                                               |
|-------------|--------------|----|----|--------|---------------------------------------------------------|
| ID_Equi     | SMALLINT          | ✔️ |  Item(Id_Item)   | ❌     | Identificador único do item equipável.                 |
| Nome        | VARCHAR(50) |    |    | ❌     | Nome do item.                                          |
| Atributo    | VARCHAR(20)  |    |    | ❌     | Atributo afetado pelo equipamento.                     |
| Valor       | SMALLINT          |    |    | ❌     | Valor da modificação no atributo.                      |
| Parte_Corpo | VARCHAR(15)  |    |    | ❌     | Parte do corpo onde o item é equipado.                 |

---

###  Tabela: Itens_Loja

| Coluna        | Tipo de dado | PK | FK | Nulo? | Descrição                                  |
|---------------|--------------|----|----|--------|--------------------------------------------|
| ID_Item_Loja  | SMALLINT          | ✔️ |  Item(Id_Item)   | ❌     | Identificador único do item disponível na loja. |
| Preco         | SMALLINT          |    |    | ❌     | Preço de venda do item na loja.            |

---

###  Tabela: Inventario

| Coluna         | Tipo de dado | PK | FK | Nulo? | Descrição                                              |
|----------------|--------------|----|----|--------|--------------------------------------------------------|
| Pos_Inv        | SMALLINT          | ✔️ |    | ❌     | Identificador da posição no inventário.               |
| ID_Inst_Item   | SMALLINT          |    | Inst_Item(ID_Inst) | ❌     | FK para a instância do item armazenado.               |
| Quantidade     | SMALLINT          |    |    | ❌     | Quantidade de itens presentes na posição do inventário.|

---
###  Tabela: Ocorre

| Coluna     | Tipo de dado | PK | FK | Nulo? | Descrição                                                       |
|------------|--------------|----|----|--------|-----------------------------------------------------------------|
| ID_Evento  | SMALLINT          | ✔️ | Evento(ID_Evento) | ❌     | FK para o evento que ocorre no ponto de interesse.              |
| ID_PI      | SMALLINT          | ✔️ | Ponto_Interesse(ID_PI) | ❌     | FK para o ponto de interesse onde o evento ocorre.              |

---

###  Tabela: Ponto_Interesse

| Coluna   | Tipo de dado | PK | FK | Nulo? | Descrição                                               |
|----------|--------------|----|----|--------|-----------------------------------------------------------|
| ID_PI    | SMALLINT          | ✔️ |    | ❌     | Identificador único do ponto de interesse.              |
| Nome     | VARCHAR(50) |    |    | ❌     | Nome do ponto. |
| Niv_Rad  | SMALLINT          |    |    | ❌     | Nível de radiação presente no local.                    |

---

###  Tabela: Conexao

| Coluna   | Tipo de dado | PK | FK | Nulo? | Descrição                                                |
|----------|--------------|----|----|--------|------------------------------------------------------------|
| Origem   | SMALLINT          | ✔️ | Ponto_Interesse(ID_PI)  | ❌     | FK para o ponto de origem da conexão.                    |
| Destino  | SMALLINT          | ✔️ | Ponto_Interesse(ID_PI)  | ❌     | FK para o ponto de destino da conexão.                   |
| Custo    | SMALLINT          |    |    | ❌     | Custo da movimentação entre os dois pontos. |

---

###  Tabela: Base

| Coluna   | Tipo de dado | PK | FK | Nulo? | Descrição                                           |
|----------|--------------|----|----|--------|-------------------------------------------------------|
| ID_PI    | SMALLINT          |  | Ponto_Interesse(ID_PI)  | ❌     | FK para o ponto de interesse onde a base está situada. |
| Nome     | VARCHAR(30) |    |    | ❌     | Nome da base.                                       |
| Nivel    | SMALLINT          |  ✔️  |    | ❌     | Nível da base. |

---

###  Tabela: Base_Atual

| Coluna     | Tipo de dado | PK | FK | Nulo? | Descrição                                                             |
|------------|--------------|----|----|--------|-------------------------------------------------------------------------|
| ID_Save    | SMALLINT          | ✔️ | ❌ | ❌     | Identificador único do save.                                               |
| Nivel_Base | SMALLINT          |    | Base(Nivel) | ❌     | FK para o nível da base atual associada ao save.                      |

###  Tabela: Bau_Base

| Coluna         | Tipo de dado | PK | FK | Nulo? | Descrição                                              |
|----------------|--------------|----|----|--------|--------------------------------------------------------|
| Pos_Bau        | SMALLINT          | ✔️ |    | ❌     | Identificador da posição no baú.               |
| ID_Inst_Item   | SMALLINT          |    | Inst_Item(ID_Inst) | ❌     | FK para a instância do item armazenado.               |
| Quantidade     | SMALLINT          |    |    | ❌     | Quantidade de itens presentes na posição do inventário.|  

---
###  Tabela: Evento

| Coluna         | Tipo de dado | PK | FK | Nulo? | Descrição                                                        |
|----------------|--------------|----|----|--------|------------------------------------------------------------------|
| ID_Evento      | SMALLINT          | ✔️ |    | ❌     | Identificador único do evento.                                  |
| Max_Ocorrencia | SMALLINT          |    |    | ❌     | Número máximo de vezes que o evento pode ocorrer.               |

---

###  Tabela: Missao

| Coluna      | Tipo de dado | PK | FK | Nulo? | Descrição                                                            |
|-------------|--------------|----|----|--------|----------------------------------------------------------------------|
| ID_Evento   | SMALLINT          | ✔️ | Evento(ID_Evento) | ❌     | FK para o evento associado à missão.                                |
| ID_Requisito| SMALLINT          |    | Requisito(ID_Requisito) | ❌     | FK para o requisito da missão.                                      |
| Recompensa  | SMALLINT |    | Item(ID_Item)   | ❌     | Recompensa atribuída ao completar a missão.                         |
| Prox        | SMALLINT          |    | Evento(ID_Evento) | ✔️     | FK para a próxima missão (se for uma sequência de missões).         |

---

###  Tabela: Requisito

| Coluna      | Tipo de dado | PK | FK | Nulo? | Descrição                                                       |
|-------------|--------------|----|----|--------|-----------------------------------------------------------------|
| ID_Requisito| SMALLINT          | ✔️ |    | ❌     | Identificador único do requisito.                              |
| Tipo        | VARCHAR(50)  |    |    | ❌     | Tipo de objetivo exigido. |
| Alvo        | VARCHAR(50) |    |    | ❌     | Alvo do requisito (ex: tipo de inimigo, item).    |
| Quantidade  | SMALLINT          |    |    | ❌     | Quantidade necessária para completar o requisito.              |

---

###  Tabela: Status_Missao

| Coluna       | Tipo de dado | PK | FK | Nulo? | Descrição                                                    |
|--------------|--------------|----|----|--------|--------------------------------------------------------------|
| ID_Save      | SMALLINT          | ✔️ |  | ❌     | Save associado ao status da missão.                |
| ID_Missao    | SMALLINT          | ✔️ | Missao(ID_Missao) | ❌     | FK para a missão.                            |
| Progresso_Atual | SMALLINT       |    |    | ❌     | Progresso da missão no save.  |

---

###  Tabela: Acontecimento

| Coluna    | Tipo de dado | PK | FK | Nulo? | Descrição                                                  |
|-----------|--------------|----|----|--------|------------------------------------------------------------|
| ID_Evento | SMALLINT          | ✔️ | Evento(ID_Evento) | ❌     | FK para o evento onde o acontecimento ocorre.             |
| Atributo  | VARCHAR(20)  |    |    | ❌     | Atributo afetado (ex: HP, Força, etc).                    |
| Valor     | SMALLINT          |    |    | ❌     | Quantidade de modificação no atributo.                    |
| Texto     | SMALLINT         |    |    | ❌     | Descrição textual do evento .     |

---

###  Tabela: Encontro

| Coluna     | Tipo de dado | PK | FK | Nulo? | Descrição                                                  |
|------------|--------------|----|----|--------|------------------------------------------------------------|
| ID_Evento  | SMALLINT          | ✔️ | Evento(ID_Evento) | ❌     | FK para o evento que gerou o encontro.                    |
| ID_Inimigo | SMALLINT          | ✔️ | Inst_NPC(ID_Inst) | ❌     | FK para o inimigo que participa do encontro.              |
| Quantidade | SMALLINT          |    |    | ❌     | Quantidade de inimigos envolvidos no encontro.            |

---


