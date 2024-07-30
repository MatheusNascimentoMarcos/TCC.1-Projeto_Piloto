--Criação de Tabelas de dimensão

CREATE TABLE `DM_Produto` (
  `ID` varchar(255) NOT NULL,
  `Categoria` varchar(255) DEFAULT NULL,
  `Peso` int DEFAULT NULL,
  `Comprimento` int DEFAULT NULL,
  `Altura` int DEFAULT NULL,
  `Largura` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

CREATE TABLE `DM_Cliente` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Cliente_Exclusivo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `CEP` varchar(10) DEFAULT NULL,
  `Cidade` varchar(100) DEFAULT NULL,
  `UF` char(2) DEFAULT NULL,
  `Data_Inicio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Data_Fim` date DEFAULT NULL,
  `Ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`ID`)
);

CREATE TABLE `DM_Vendedor` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Vendedor` varchar(200) DEFAULT NULL,
  `CEP` varchar(10) DEFAULT NULL,
  `Cidade` varchar(100) DEFAULT NULL,
  `UF` char(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

CREATE TABLE `DM_Tempo` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Data` date DEFAULT NULL,
  `Ano` int DEFAULT NULL,
  `Mes` int DEFAULT NULL,
  `Semana` int DEFAULT NULL,
  `Dia` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

--Criação de tabelas de fato

CREATE TABLE `FT_Venda` (
  `QTD_Vendas` int DEFAULT NULL,
  `Preco_unitario` double DEFAULT NULL,
  `ID_Produto` varchar(255) NOT NULL,
  `ID_Vendedor` int NOT NULL,
  `ID_Cliente` int NOT NULL,
  `ID_Tempo` int NOT NULL,
  PRIMARY KEY (`ID_Produto`,`ID_Vendedor`,`ID_Cliente`,`ID_Tempo`),
  KEY `ID_Vendedor` (`ID_Vendedor`),
  KEY `ID_Cliente` (`ID_Cliente`),
  KEY `ID_Tempo` (`ID_Tempo`),
  CONSTRAINT `FT_Venda_ibfk_1` FOREIGN KEY (`ID_Produto`) REFERENCES `DM_Produto` (`ID`),
  CONSTRAINT `FT_Venda_ibfk_2` FOREIGN KEY (`ID_Vendedor`) REFERENCES `DM_Vendedor` (`ID`),
  CONSTRAINT `FT_Venda_ibfk_3` FOREIGN KEY (`ID_Cliente`) REFERENCES `DM_Cliente` (`ID`),
  CONSTRAINT `FT_Venda_ibfk_4` FOREIGN KEY (`ID_Tempo`) REFERENCES `DM_Tempo` (`ID`)
);

CREATE TABLE `FT_Avaliacao` (
  `Avaliacao` int DEFAULT NULL,
  `Comentario` varchar(2000) NOT NULL,
  `ID_Produto` varchar(255) NOT NULL,
  `ID_Cliente` int NOT NULL,
  `ID_Tempo` int NOT NULL,
  PRIMARY KEY (`ID_Produto`,`ID_Cliente`,`ID_Tempo`),
  KEY `ID_Cliente` (`ID_Cliente`),
  KEY `ID_Tempo` (`ID_Tempo`),
  CONSTRAINT `FT_Avaliacao_ibfk_1` FOREIGN KEY (`ID_Produto`) REFERENCES `DM_Produto` (`ID`),
  CONSTRAINT `FT_Avaliacao_ibfk_2` FOREIGN KEY (`ID_Cliente`) REFERENCES `DM_Cliente` (`ID`),
  CONSTRAINT `FT_Avaliacao_ibfk_3` FOREIGN KEY (`ID_Tempo`) REFERENCES `DM_Tempo` (`ID`)
);
