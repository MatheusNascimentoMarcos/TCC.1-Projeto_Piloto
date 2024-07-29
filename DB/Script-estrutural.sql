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

CREATE TABLE Teste_Load (
  ID_Cliente_Exclusivo varchar(255) NOT NULL,
  CEP varchar(8) DEFAULT NULL,
  Cidade varchar(255) DEFAULT NULL,
  UF varchar(2) DEFAULT NULL,
  PRIMARY KEY (ID_Cliente_Exclusivo)
);

CREATE TABLE Tabela_Data_de_Carga (
  ID int NOT NULL AUTO_INCREMENT,
  Data date DEFAULT NULL,
  PRIMARY KEY (ID)
);

CREATE DEFINER=admin@% PROCEDURE Staging Area.GETDATEs()
BEGIN
    DECLARE Data_Inicial DATE;
    DECLARE Data_Final DATE;

    -- Criar a tabela Datas se não existir
    CREATE TABLE IF NOT EXISTS Datas (
        data DATE NOT NULL
    );

    -- Limpar a tabela Datas para evitar duplicações
    TRUNCATE TABLE Datas;

    -- Definir variáveis
    SET Data_Inicial = (SELECT MAX(DATA) FROM Tabela_Data_de_Carga WHERE DATA NOT IN (SELECT MAX(DATA) FROM Tabela_Data_de_Carga));
    SET Data_Final = (SELECT MAX(DATA) FROM Tabela_Data_de_Carga);

    -- Selecionar os dados usando a variável definida
    WHILE Data_Inicial <= Data_Final DO
        INSERT INTO Datas (data) VALUES (Data_Inicial);
        SET Data_Inicial = DATE_ADD(Data_Inicial, INTERVAL 1 DAY);
    END WHILE;
END

