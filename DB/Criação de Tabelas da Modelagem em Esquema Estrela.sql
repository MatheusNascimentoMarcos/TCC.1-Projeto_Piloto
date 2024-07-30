--Criação de Tabelas de dimensão

CREATE TABLE DM_Produto (
  ID varchar(255) NOT NULL,
  Categoria varchar(255) DEFAULT NULL,
  Peso int DEFAULT NULL,
  Comprimento int DEFAULT NULL,
  Altura int DEFAULT NULL,
  Largura int DEFAULT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE DM_Cliente (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ID_Cliente_Exclusivo INT,
    CEP VARCHAR(10),
    Cidade VARCHAR(100),
    UF CHAR(2),
    Data_Inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data_Fim DATE DEFAULT NULL,
    Ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE DM_Vendedor(
	ID INT PRIMARY KEY AUTO_INCREMENT,
	ID_VENDEDOR INT,
	CEP VARCHAR(10),
	Cidade VARCHAR(100),
	UF CHAR(2)
);

CREATE TABLE DM_Tempo(
	ID INT PRIMARY KEY AUTO_INCREMENT,
	Data DATE,
	Ano INT,
	Mes INT,
	Semana INT,
	Dia INT
);

--Criação de tabelas de fato

CREATE TABLE FT_Venda (
  QTD_Vendas INT DEFAULT NULL,
  Preco_unitario REAL DEFAULT NULL,
  ID_Produto VARCHAR(255) NOT NULL,
  ID_Vendedor INT NOT NULL,
  ID_Cliente INT NOT NULL,
  ID_Tempo INT NOT NULL,
  PRIMARY KEY (ID_Produto, ID_Vendedor, ID_Cliente, ID_Tempo),
  FOREIGN KEY (ID_Produto) REFERENCES DM_Produto (ID),
  FOREIGN KEY (ID_Vendedor) REFERENCES DM_Vendedor (ID),
  FOREIGN KEY (ID_Cliente) REFERENCES DM_Cliente (ID),
  FOREIGN KEY (ID_Tempo) REFERENCES DM_Tempo (ID)
);

CREATE TABLE FT_Avaliacao (
  Avaliacao INT DEFAULT NULL,
  Comentario VARCHAR(2000) NOT NULL,
  ID_Produto VARCHAR(255) NOT NULL,
  ID_Cliente INT NOT NULL,
  ID_Tempo INT NOT NULL,
  PRIMARY KEY (ID_Produto, ID_Cliente, ID_Tempo),
  FOREIGN KEY (ID_Produto) REFERENCES DM_Produto (ID),
  FOREIGN KEY (ID_Cliente) REFERENCES DM_Cliente (ID),
  FOREIGN KEY (ID_Tempo) REFERENCES DM_Tempo (ID)
);
