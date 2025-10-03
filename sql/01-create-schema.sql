-- ============================================
-- PROJETO: Sistema de Banco de Dados para Oficina Mecânica
-- ARQUIVO: 01-create-schema.sql
-- DESCRIÇÃO: Script para criação do schema completo
-- AUTOR: Leandro da Silva Stampini
-- LINKEDIN: https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/
-- DATA: Outubro 2025
-- ============================================

-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS oficina_mecanica;
USE oficina_mecanica;

-- Configuração de charset
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ============================================
-- CRIAÇÃO DAS TABELAS
-- ============================================

-- Tabela CLIENTE
CREATE TABLE CLIENTE (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    Endereco VARCHAR(200),
    Data_Cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT chk_cpf_cliente CHECK (LENGTH(CPF) = 11),
    CONSTRAINT chk_email_cliente CHECK (Email LIKE '%@%.%')
);

-- Tabela VEICULO
CREATE TABLE VEICULO (
    ID_Veiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa VARCHAR(8) UNIQUE NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Ano INT NOT NULL,
    Cor VARCHAR(30),
    Quilometragem INT DEFAULT 0,
    ID_Cliente INT NOT NULL,
    
    -- Constraints
    CONSTRAINT chk_ano_veiculo CHECK (Ano >= 1900 AND Ano <= YEAR(CURDATE())),
    CONSTRAINT chk_km_veiculo CHECK (Quilometragem >= 0),
    
    -- Chave estrangeira
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabela FUNCIONARIO
CREATE TABLE FUNCIONARIO (
    ID_Funcionario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    Salario DECIMAL(10,2),
    Data_Admissao DATE NOT NULL,
    Telefone VARCHAR(15),
    
    -- Constraints
    CONSTRAINT chk_cpf_funcionario CHECK (LENGTH(CPF) = 11),
    CONSTRAINT chk_salario CHECK (Salario > 0),
    CONSTRAINT chk_data_admissao CHECK (Data_Admissao <= CURDATE())
);

-- Tabela ESPECIALIDADE
CREATE TABLE ESPECIALIDADE (
    ID_Especialidade INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Especialidade VARCHAR(100) NOT NULL UNIQUE,
    Descricao TEXT
);

-- Tabela FUNCIONARIO_ESPECIALIDADE (Relacionamento N:M)
CREATE TABLE FUNCIONARIO_ESPECIALIDADE (
    ID_Funcionario INT,
    ID_Especialidade INT,
    Data_Certificacao DATE,
    Nivel_Experiencia ENUM('Iniciante', 'Intermediário', 'Avançado') DEFAULT 'Iniciante',
    
    -- Chave primária composta
    PRIMARY KEY (ID_Funcionario, ID_Especialidade),
    
    -- Chaves estrangeiras
    FOREIGN KEY (ID_Funcionario) REFERENCES FUNCIONARIO(ID_Funcionario)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Especialidade) REFERENCES ESPECIALIDADE(ID_Especialidade)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    -- Constraints
    CONSTRAINT chk_data_cert CHECK (Data_Certificacao <= CURDATE())
);

-- Tabela SERVICO
CREATE TABLE SERVICO (
    ID_Servico INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Servico VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco_Base DECIMAL(10,2) NOT NULL,
    Tempo_Estimado INT, -- em minutos
    
    -- Constraints
    CONSTRAINT chk_preco_servico CHECK (Preco_Base > 0),
    CONSTRAINT chk_tempo_estimado CHECK (Tempo_Estimado > 0)
);

-- Tabela FORNECEDOR
CREATE TABLE FORNECEDOR (
    ID_Fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Empresa VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(14) UNIQUE NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    Endereco VARCHAR(200),
    
    -- Constraints
    CONSTRAINT chk_cnpj CHECK (LENGTH(CNPJ) = 14),
    CONSTRAINT chk_email_fornecedor CHECK (Email LIKE '%@%.%')
);

-- Tabela PECA
CREATE TABLE PECA (
    ID_Peca INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Peca VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco_Custo DECIMAL(10,2) NOT NULL,
    Preco_Venda DECIMAL(10,2) NOT NULL,
    Estoque_Atual INT DEFAULT 0,
    Estoque_Minimo INT DEFAULT 0,
    ID_Fornecedor INT,
    
    -- Constraints
    CONSTRAINT chk_preco_custo CHECK (Preco_Custo > 0),
    CONSTRAINT chk_preco_venda CHECK (Preco_Venda > 0),
    CONSTRAINT chk_margem CHECK (Preco_Venda > Preco_Custo),
    CONSTRAINT chk_estoque_atual CHECK (Estoque_Atual >= 0),
    CONSTRAINT chk_estoque_minimo CHECK (Estoque_Minimo >= 0),
    
    -- Chave estrangeira
    FOREIGN KEY (ID_Fornecedor) REFERENCES FORNECEDOR(ID_Fornecedor)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabela ORDEM_SERVICO
CREATE TABLE ORDEM_SERVICO (
    ID_OS INT AUTO_INCREMENT PRIMARY KEY,
    Data_Abertura DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Conclusao DATETIME,
    Status ENUM('Aberta', 'Em Andamento', 'Concluída', 'Cancelada') DEFAULT 'Aberta',
    Observacoes TEXT,
    Valor_Total DECIMAL(10,2) DEFAULT 0,
    ID_Veiculo INT NOT NULL,
    ID_Cliente INT NOT NULL,
    
    -- Constraints
    CONSTRAINT chk_data_conclusao CHECK (Data_Conclusao IS NULL OR Data_Conclusao >= Data_Abertura),
    CONSTRAINT chk_valor_total CHECK (Valor_Total >= 0),
    
    -- Chaves estrangeiras
    FOREIGN KEY (ID_Veiculo) REFERENCES VEICULO(ID_Veiculo)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabela ITEM_SERVICO
CREATE TABLE ITEM_SERVICO (
    ID_Item INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade INT DEFAULT 1,
    Preco_Unitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    Status_Item ENUM('Pendente', 'Em Execução', 'Concluído') DEFAULT 'Pendente',
    Data_Inicio DATETIME,
    Data_Fim DATETIME,
    ID_OS INT NOT NULL,
    ID_Servico INT NOT NULL,
    ID_Funcionario INT NOT NULL,
    
    -- Constraints
    CONSTRAINT chk_quantidade_item CHECK (Quantidade > 0),
    CONSTRAINT chk_preco_unitario_item CHECK (Preco_Unitario > 0),
    CONSTRAINT chk_subtotal_item CHECK (Subtotal > 0),
    CONSTRAINT chk_data_item CHECK (Data_Fim IS NULL OR Data_Fim >= Data_Inicio),
    
    -- Chaves estrangeiras
    FOREIGN KEY (ID_OS) REFERENCES ORDEM_SERVICO(ID_OS)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Servico) REFERENCES SERVICO(ID_Servico)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_Funcionario) REFERENCES FUNCIONARIO(ID_Funcionario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabela ITEM_PECA (Relacionamento N:M entre ITEM_SERVICO e PECA)
CREATE TABLE ITEM_PECA (
    ID_Item_Peca INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade_Utilizada INT NOT NULL,
    Preco_Unitario_Peca DECIMAL(10,2) NOT NULL,
    Subtotal_Peca DECIMAL(10,2) NOT NULL,
    ID_Item INT NOT NULL,
    ID_Peca INT NOT NULL,
    
    -- Constraints
    CONSTRAINT chk_quantidade_peca CHECK (Quantidade_Utilizada > 0),
    CONSTRAINT chk_preco_unitario_peca CHECK (Preco_Unitario_Peca > 0),
    CONSTRAINT chk_subtotal_peca CHECK (Subtotal_Peca > 0),
    
    -- Chaves estrangeiras
    FOREIGN KEY (ID_Item) REFERENCES ITEM_SERVICO(ID_Item)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Peca) REFERENCES PECA(ID_Peca)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ============================================
-- CRIAÇÃO DE ÍNDICES
-- ============================================

-- Índices em chaves estrangeiras para performance
CREATE INDEX idx_veiculo_cliente ON VEICULO(ID_Cliente);
CREATE INDEX idx_os_veiculo ON ORDEM_SERVICO(ID_Veiculo);
CREATE INDEX idx_os_cliente ON ORDEM_SERVICO(ID_Cliente);
CREATE INDEX idx_item_os ON ITEM_SERVICO(ID_OS);
CREATE INDEX idx_item_servico ON ITEM_SERVICO(ID_Servico);
CREATE INDEX idx_item_funcionario ON ITEM_SERVICO(ID_Funcionario);
CREATE INDEX idx_peca_fornecedor ON PECA(ID_Fornecedor);
CREATE INDEX idx_item_peca_item ON ITEM_PECA(ID_Item);
CREATE INDEX idx_item_peca_peca ON ITEM_PECA(ID_Peca);

-- Índices para consultas frequentes
CREATE INDEX idx_cliente_cpf ON CLIENTE(CPF);
CREATE INDEX idx_veiculo_placa ON VEICULO(Placa);
CREATE INDEX idx_funcionario_cpf ON FUNCIONARIO(CPF);
CREATE INDEX idx_fornecedor_cnpj ON FORNECEDOR(CNPJ);
CREATE INDEX idx_os_data_abertura ON ORDEM_SERVICO(Data_Abertura);
CREATE INDEX idx_os_status ON ORDEM_SERVICO(Status);
CREATE INDEX idx_item_status ON ITEM_SERVICO(Status_Item);
CREATE INDEX idx_peca_nome ON PECA(Nome_Peca);

-- ============================================
-- CRIAÇÃO DE VIEWS
-- ============================================

-- View para relatório completo de OS
CREATE VIEW vw_relatorio_os AS
SELECT 
    os.ID_OS,
    os.Data_Abertura,
    os.Data_Conclusao,
    os.Status,
    os.Valor_Total,
    c.Nome AS Cliente,
    c.CPF AS CPF_Cliente,
    c.Telefone AS Tel_Cliente,
    v.Placa,
    v.Marca,
    v.Modelo,
    v.Ano,
    v.Cor,
    v.Quilometragem,
    os.Observacoes
FROM ORDEM_SERVICO os
INNER JOIN CLIENTE c ON os.ID_Cliente = c.ID_Cliente
INNER JOIN VEICULO v ON os.ID_Veiculo = v.ID_Veiculo;

-- View para controle de estoque
CREATE VIEW vw_controle_estoque AS
SELECT 
    p.ID_Peca,
    p.Nome_Peca,
    p.Descricao,
    p.Estoque_Atual,
    p.Estoque_Minimo,
    p.Preco_Custo,
    p.Preco_Venda,
    ROUND(((p.Preco_Venda - p.Preco_Custo) / p.Preco_Custo) * 100, 2) AS Margem_Lucro_Perc,
    CASE 
        WHEN p.Estoque_Atual = 0 THEN 'SEM ESTOQUE'
        WHEN p.Estoque_Atual <= p.Estoque_Minimo THEN 'CRÍTICO'
        WHEN p.Estoque_Atual <= (p.Estoque_Minimo * 1.5) THEN 'BAIXO'
        ELSE 'NORMAL'
    END AS Status_Estoque,
    f.Nome_Empresa AS Fornecedor,
    f.Telefone AS Tel_Fornecedor
FROM PECA p
LEFT JOIN FORNECEDOR f ON p.ID_Fornecedor = f.ID_Fornecedor;

-- View para produtividade dos funcionários
CREATE VIEW vw_produtividade_funcionario AS
SELECT 
    f.ID_Funcionario,
    f.Nome AS Funcionario,
    f.Cargo,
    COUNT(DISTINCT iservico.ID_Item) AS Total_Servicos_Executados,
    COUNT(DISTINCT iservico.ID_OS) AS Total_OS_Participou,
    COALESCE(SUM(iservico.Subtotal), 0) AS Valor_Total_Servicos,
    ROUND(AVG(iservico.Subtotal), 2) AS Valor_Medio_Servico
FROM FUNCIONARIO f
LEFT JOIN ITEM_SERVICO iservico ON f.ID_Funcionario = iservico.ID_Funcionario
GROUP BY f.ID_Funcionario, f.Nome, f.Cargo;

-- View para ranking de serviços
CREATE VIEW vw_ranking_servicos AS
SELECT 
    s.ID_Servico,
    s.Nome_Servico,
    s.Preco_Base,
    COUNT(iservico.ID_Item) AS Quantidade_Executada,
    COALESCE(SUM(iservico.Subtotal), 0) AS Faturamento_Total,
    ROUND(AVG(iservico.Preco_Unitario), 2) AS Preco_Medio_Praticado
FROM SERVICO s
LEFT JOIN ITEM_SERVICO iservico ON s.ID_Servico = iservico.ID_Servico
GROUP BY s.ID_Servico, s.Nome_Servico, s.Preco_Base
ORDER BY Quantidade_Executada DESC;

-- ============================================
-- CRIAÇÃO DE TRIGGERS
-- ============================================

-- Trigger para calcular subtotal do item de serviço
DELIMITER //
CREATE TRIGGER tr_calcula_subtotal_servico
BEFORE INSERT ON ITEM_SERVICO
FOR EACH ROW
BEGIN
    SET NEW.Subtotal = NEW.Quantidade * NEW.Preco_Unitario;
END//
DELIMITER ;

-- Trigger para calcular subtotal da peça
DELIMITER //
CREATE TRIGGER tr_calcula_subtotal_peca
BEFORE INSERT ON ITEM_PECA
FOR EACH ROW
BEGIN
    SET NEW.Subtotal_Peca = NEW.Quantidade_Utilizada * NEW.Preco_Unitario_Peca;
END//
DELIMITER ;

-- Trigger para atualizar valor total da OS ao inserir item de serviço
DELIMITER //
CREATE TRIGGER tr_atualiza_valor_os_insert
AFTER INSERT ON ITEM_SERVICO
FOR EACH ROW
BEGIN
    CALL sp_atualiza_valor_total_os(NEW.ID_OS);
END//
DELIMITER ;

-- Trigger para atualizar valor total da OS ao atualizar item de serviço
DELIMITER //
CREATE TRIGGER tr_atualiza_valor_os_update
AFTER UPDATE ON ITEM_SERVICO
FOR EACH ROW
BEGIN
    CALL sp_atualiza_valor_total_os(NEW.ID_OS);
END//
DELIMITER ;

-- Trigger para atualizar valor total da OS ao deletar item de serviço
DELIMITER //
CREATE TRIGGER tr_atualiza_valor_os_delete
AFTER DELETE ON ITEM_SERVICO
FOR EACH ROW
BEGIN
    CALL sp_atualiza_valor_total_os(OLD.ID_OS);
END//
DELIMITER ;

-- Trigger para atualizar estoque ao inserir item de peça
DELIMITER //
CREATE TRIGGER tr_atualiza_estoque_insert
AFTER INSERT ON ITEM_PECA
FOR EACH ROW
BEGIN
    UPDATE PECA 
    SET Estoque_Atual = Estoque_Atual - NEW.Quantidade_Utilizada
    WHERE ID_Peca = NEW.ID_Peca;
    
    -- Verifica se o estoque ficou negativo
    IF (SELECT Estoque_Atual FROM PECA WHERE ID_Peca = NEW.ID_Peca) < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Estoque insuficiente para a operação';
    END IF;
END//
DELIMITER ;

-- ============================================
-- CRIAÇÃO DE STORED PROCEDURES
-- ============================================

-- Procedure para atualizar valor total da OS
DELIMITER //
CREATE PROCEDURE sp_atualiza_valor_total_os(IN p_id_os INT)
BEGIN
    DECLARE total_servicos DECIMAL(10,2) DEFAULT 0;
    DECLARE total_pecas DECIMAL(10,2) DEFAULT 0;
    
    -- Calcula total dos serviços
    SELECT COALESCE(SUM(Subtotal), 0) INTO total_servicos
    FROM ITEM_SERVICO 
    WHERE ID_OS = p_id_os;
    
    -- Calcula total das peças
    SELECT COALESCE(SUM(ip.Subtotal_Peca), 0) INTO total_pecas
    FROM ITEM_PECA ip
    INNER JOIN ITEM_SERVICO iservico ON ip.ID_Item = iservico.ID_Item
    WHERE iservico.ID_OS = p_id_os;
    
    -- Atualiza valor total da OS
    UPDATE ORDEM_SERVICO 
    SET Valor_Total = total_servicos + total_pecas
    WHERE ID_OS = p_id_os;
END//
DELIMITER ;

-- Procedure para finalizar uma OS
DELIMITER //
CREATE PROCEDURE sp_finaliza_os(IN p_id_os INT)
BEGIN
    DECLARE itens_pendentes INT DEFAULT 0;
    
    -- Verifica se há itens pendentes
    SELECT COUNT(*) INTO itens_pendentes
    FROM ITEM_SERVICO
    WHERE ID_OS = p_id_os AND Status_Item != 'Concluído';
    
    IF itens_pendentes > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não é possível finalizar OS com itens pendentes';
    ELSE
        UPDATE ORDEM_SERVICO 
        SET Status = 'Concluída', Data_Conclusao = NOW()
        WHERE ID_OS = p_id_os;
    END IF;
END//
DELIMITER ;

-- ============================================
-- MENSAGEM DE CONCLUSÃO
-- ============================================

SELECT 'Schema da Oficina Mecânica criado com sucesso!' AS Mensagem;
