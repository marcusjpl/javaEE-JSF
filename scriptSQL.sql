create user prova identified by root;

grant connect, resource to prova;


-- Table LOGIN
CREATE TABLE PROVA.LOGIN
(
  NOM_LOGIN   VARCHAR2(20) PRIMARY KEY,
  TXT_NOME    VARCHAR2(80)
);

COMMENT ON TABLE PROVA.LOGIN IS 'Tabela onde ficam registrados os usuarios do sistema';
COMMENT ON COLUMN PROVA.LOGIN.NOM_LOGIN IS 'Login do usuario do Sistema';
COMMENT ON COLUMN PROVA.LOGIN.TXT_NOME IS 'Nome do usuario do Sistema';


-- Table ITEM
CREATE TABLE PROVA.ITEM
(
  COD_ITEM    NUMBER PRIMARY KEY,
  DSC_TITULO    VARCHAR2(50) NOT NULL,
  TXT_DESCRICAO VARCHAR2(500) NOT NULL
);

COMMENT ON TABLE PROVA.ITEM IS 'Registra os itens liberados na versao';
COMMENT ON COLUMN PROVA.ITEM.COD_ITEM IS 'Login do usuario do Sistema';
COMMENT ON COLUMN PROVA.ITEM.DSC_TITULO IS 'Descricao do titulo';
COMMENT ON COLUMN PROVA.ITEM.TXT_DESCRICAO IS 'Texto do item';

CREATE SEQUENCE PROVA.SQ_ITEM 
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

-- Table VERSAO
CREATE TABLE PROVA.VERSAO
(
  COD_VERSAO    NUMBER PRIMARY KEY,
  NRO_VERSAO    VARCHAR2(10) NOT NULL,
  DAT_VERSAO    DATE,
  IND_LIBERADO  CHAR(1) NOT NULL,
  IND_SITUACAO  CHAR(1) NOT NULL
);

COMMENT ON TABLE PROVA.VERSAO IS 'Registra informacoes basicas da versao';
COMMENT ON COLUMN PROVA.VERSAO.COD_VERSAO IS 'Codigo sequencial da versao (SQ_VERSAO)';
COMMENT ON COLUMN PROVA.VERSAO.NRO_VERSAO IS 'Numero da versao alfanumerico';
COMMENT ON COLUMN PROVA.VERSAO.DAT_VERSAO IS 'Data da Liberacao da versao';
COMMENT ON COLUMN PROVA.VERSAO.IND_LIBERADO IS 'Liberado ? S im / N ao';
COMMENT ON COLUMN PROVA.VERSAO.IND_SITUACAO IS 'A tivo / C ancelado';

CREATE SEQUENCE PROVA.SQ_VERSAO
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;


-- Table VERSAO_ITEM
CREATE TABLE PROVA.VERSAO_ITEM
(
  COD_VERSAO    NUMBER NOT NULL,
  COD_ITEM        NUMBER NOT NULL,
  PRIMARY KEY (COD_VERSAO,COD_ITEM),
  CONSTRAINT FK_VERSAO_ITEM_CV FOREIGN KEY (COD_VERSAO) REFERENCES PROVA.VERSAO(COD_VERSAO),
  CONSTRAINT FK_VERSAO_ITEM_CI FOREIGN KEY (COD_ITEM) REFERENCES PROVA.ITEM(COD_ITEM)
);


-- Table AUD_VERSAO
CREATE TABLE PROVA.AUD_VERSAO
(
  COD_AUD_VERSAO    NUMBER PRIMARY KEY,
  COD_VERSAO        NUMBER NOT NULL,
  NOM_COLUNA        VARCHAR2(20),
  CONTEUDO_ANTIGO   VARCHAR2(1001),
  CONTEUDO_NOVO     VARCHAR2(1001),
  NOM_LOGIN         VARCHAR2(20)
  --CONSTRAINT FK_COD_VERSAO FOREIGN KEY (COD_VERSAO) REFERENCES PROVA.VERSAO(COD_VERSAO),
  --CONSTRAINT FK_NOM_LOGIN FOREIGN KEY (NOM_LOGIN) REFERENCES PROVA.LOGIN(NOM_LOGIN)
);

COMMENT ON TABLE PROVA.AUD_VERSAO IS 'Tabela de Auditoria da tabela VERSAO';
COMMENT ON COLUMN PROVA.AUD_VERSAO.COD_AUD_VERSAO IS 'Codigo Sequencial (SQ_AUD_VERSAO)';
COMMENT ON COLUMN PROVA.AUD_VERSAO.COD_VERSAO IS 'FK da tabela versao';
COMMENT ON COLUMN PROVA.AUD_VERSAO.NOM_COLUNA IS 'Nome da coluna que está sofrendo alteracao';
COMMENT ON COLUMN PROVA.AUD_VERSAO.CONTEUDO_ANTIGO IS 'Conteudo Antigo da coluna que esta sendo alterada';
COMMENT ON COLUMN PROVA.AUD_VERSAO.CONTEUDO_NOVO IS 'Conteudo NOVO da coluna que esta sendo alterada';
COMMENT ON COLUMN PROVA.AUD_VERSAO.NOM_LOGIN IS 'Login de quem esta alterando';

CREATE SEQUENCE PROVA.SQ_AUD_VERSAO
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;


-- Inclusao de um usuario com login admin
INSERT INTO PROVA.LOGIN(NOM_LOGIN,TXT_NOME) VALUES('admin','admin');