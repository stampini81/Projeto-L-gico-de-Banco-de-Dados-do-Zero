# Modelo Lógico - Oficina Mecânica

> **Autor:** Leandro da Silva Stampini  
> **LinkedIn:** [leandro-da-silva-stampini](https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/)  
> **Data:** Outubro 2025

## Estrutura das Tabelas

### 1. CLIENTE
```sql
CLIENTE (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    Endereco VARCHAR(200),
    Data_Cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
)
```

### 2. VEICULO
```sql
VEICULO (
    ID_Veiculo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(8) UNIQUE NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Ano INT NOT NULL,
    Cor VARCHAR(30),
    Quilometragem INT DEFAULT 0,
    ID_Cliente INT NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente)
)
```

### 3. FUNCIONARIO
```sql
FUNCIONARIO (
    ID_Funcionario INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    Salario DECIMAL(10,2),
    Data_Admissao DATE NOT NULL,
    Telefone VARCHAR(15)
)
```

### 4. ESPECIALIDADE
```sql
ESPECIALIDADE (
    ID_Especialidade INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Especialidade VARCHAR(100) NOT NULL,
    Descricao TEXT
)
```

### 5. FUNCIONARIO_ESPECIALIDADE (Tabela Associativa)
```sql
FUNCIONARIO_ESPECIALIDADE (
    ID_Funcionario INT,
    ID_Especialidade INT,
    Data_Certificacao DATE,
    Nivel_Experiencia ENUM('Iniciante', 'Intermediário', 'Avançado'),
    PRIMARY KEY (ID_Funcionario, ID_Especialidade),
    FOREIGN KEY (ID_Funcionario) REFERENCES FUNCIONARIO(ID_Funcionario),
    FOREIGN KEY (ID_Especialidade) REFERENCES ESPECIALIDADE(ID_Especialidade)
)
```

### 6. SERVICO
```sql
SERVICO (
    ID_Servico INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Servico VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco_Base DECIMAL(10,2) NOT NULL,
    Tempo_Estimado INT -- em minutos
)
```

### 7. FORNECEDOR
```sql
FORNECEDOR (
    ID_Fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Empresa VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(14) UNIQUE NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    Endereco VARCHAR(200)
)
```

### 8. PECA
```sql
PECA (
    ID_Peca INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Peca VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco_Custo DECIMAL(10,2) NOT NULL,
    Preco_Venda DECIMAL(10,2) NOT NULL,
    Estoque_Atual INT DEFAULT 0,
    Estoque_Minimo INT DEFAULT 0,
    ID_Fornecedor INT,
    FOREIGN KEY (ID_Fornecedor) REFERENCES FORNECEDOR(ID_Fornecedor)
)
```

### 9. ORDEM_SERVICO
```sql
ORDEM_SERVICO (
    ID_OS INT PRIMARY KEY AUTO_INCREMENT,
    Data_Abertura DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Conclusao DATETIME,
    Status ENUM('Aberta', 'Em Andamento', 'Concluída', 'Cancelada') DEFAULT 'Aberta',
    Observacoes TEXT,
    Valor_Total DECIMAL(10,2) DEFAULT 0,
    ID_Veiculo INT NOT NULL,
    ID_Cliente INT NOT NULL,
    FOREIGN KEY (ID_Veiculo) REFERENCES VEICULO(ID_Veiculo),
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente)
)
```

### 10. ITEM_SERVICO
```sql
ITEM_SERVICO (
    ID_Item INT PRIMARY KEY AUTO_INCREMENT,
    Quantidade INT DEFAULT 1,
    Preco_Unitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    Status_Item ENUM('Pendente', 'Em Execução', 'Concluído') DEFAULT 'Pendente',
    Data_Inicio DATETIME,
    Data_Fim DATETIME,
    ID_OS INT NOT NULL,
    ID_Servico INT NOT NULL,
    ID_Funcionario INT NOT NULL,
    FOREIGN KEY (ID_OS) REFERENCES ORDEM_SERVICO(ID_OS),
    FOREIGN KEY (ID_Servico) REFERENCES SERVICO(ID_Servico),
    FOREIGN KEY (ID_Funcionario) REFERENCES FUNCIONARIO(ID_Funcionario)
)
```

### 11. ITEM_PECA (Tabela Associativa)
```sql
ITEM_PECA (
    ID_Item_Peca INT PRIMARY KEY AUTO_INCREMENT,
    Quantidade_Utilizada INT NOT NULL,
    Preco_Unitario_Peca DECIMAL(10,2) NOT NULL,
    Subtotal_Peca DECIMAL(10,2) NOT NULL,
    ID_Item INT NOT NULL,
    ID_Peca INT NOT NULL,
    FOREIGN KEY (ID_Item) REFERENCES ITEM_SERVICO(ID_Item),
    FOREIGN KEY (ID_Peca) REFERENCES PECA(ID_Peca)
)
```

## Índices Recomendados

### Índices para Performance
```sql
-- Índices em chaves estrangeiras
CREATE INDEX idx_veiculo_cliente ON VEICULO(ID_Cliente);
CREATE INDEX idx_os_veiculo ON ORDEM_SERVICO(ID_Veiculo);
CREATE INDEX idx_os_cliente ON ORDEM_SERVICO(ID_Cliente);
CREATE INDEX idx_item_os ON ITEM_SERVICO(ID_OS);
CREATE INDEX idx_item_servico ON ITEM_SERVICO(ID_Servico);
CREATE INDEX idx_item_funcionario ON ITEM_SERVICO(ID_Funcionario);
CREATE INDEX idx_peca_fornecedor ON PECA(ID_Fornecedor);

-- Índices para consultas frequentes
CREATE INDEX idx_cliente_cpf ON CLIENTE(CPF);
CREATE INDEX idx_veiculo_placa ON VEICULO(Placa);
CREATE INDEX idx_funcionario_cpf ON FUNCIONARIO(CPF);
CREATE INDEX idx_fornecedor_cnpj ON FORNECEDOR(CNPJ);
CREATE INDEX idx_os_data_abertura ON ORDEM_SERVICO(Data_Abertura);
CREATE INDEX idx_os_status ON ORDEM_SERVICO(Status);
```

## Triggers e Procedures

### Trigger para Atualizar Valor Total da OS
```sql
DELIMITER //
CREATE TRIGGER tr_atualiza_valor_os
AFTER INSERT ON ITEM_SERVICO
FOR EACH ROW
BEGIN
    DECLARE total_servicos DECIMAL(10,2);
    DECLARE total_pecas DECIMAL(10,2);
    
    -- Calcula total dos serviços
    SELECT COALESCE(SUM(Subtotal), 0) INTO total_servicos
    FROM ITEM_SERVICO 
    WHERE ID_OS = NEW.ID_OS;
    
    -- Calcula total das peças
    SELECT COALESCE(SUM(ip.Subtotal_Peca), 0) INTO total_pecas
    FROM ITEM_PECA ip
    INNER JOIN ITEM_SERVICO iservico ON ip.ID_Item = iservico.ID_Item
    WHERE iservico.ID_OS = NEW.ID_OS;
    
    -- Atualiza valor total da OS
    UPDATE ORDEM_SERVICO 
    SET Valor_Total = total_servicos + total_pecas
    WHERE ID_OS = NEW.ID_OS;
END//
DELIMITER ;
```

### Trigger para Controle de Estoque
```sql
DELIMITER //
CREATE TRIGGER tr_atualiza_estoque
AFTER INSERT ON ITEM_PECA
FOR EACH ROW
BEGIN
    UPDATE PECA 
    SET Estoque_Atual = Estoque_Atual - NEW.Quantidade_Utilizada
    WHERE ID_Peca = NEW.ID_Peca;
END//
DELIMITER ;
```

## Views Úteis

### View para Relatório de OS
```sql
CREATE VIEW vw_relatorio_os AS
SELECT 
    os.ID_OS,
    os.Data_Abertura,
    os.Data_Conclusao,
    os.Status,
    c.Nome AS Cliente,
    c.Telefone AS Tel_Cliente,
    v.Placa,
    v.Marca,
    v.Modelo,
    v.Ano,
    os.Valor_Total
FROM ORDEM_SERVICO os
INNER JOIN CLIENTE c ON os.ID_Cliente = c.ID_Cliente
INNER JOIN VEICULO v ON os.ID_Veiculo = v.ID_Veiculo;
```

### View para Controle de Estoque
```sql
CREATE VIEW vw_controle_estoque AS
SELECT 
    p.ID_Peca,
    p.Nome_Peca,
    p.Estoque_Atual,
    p.Estoque_Minimo,
    CASE 
        WHEN p.Estoque_Atual <= p.Estoque_Minimo THEN 'CRÍTICO'
        WHEN p.Estoque_Atual <= (p.Estoque_Minimo * 1.5) THEN 'BAIXO'
        ELSE 'NORMAL'
    END AS Status_Estoque,
    f.Nome_Empresa AS Fornecedor
FROM PECA p
LEFT JOIN FORNECEDOR f ON p.ID_Fornecedor = f.ID_Fornecedor;
```

## Considerações de Normalização

O modelo está na 3ª Forma Normal (3FN):

1. **1FN**: Todos os atributos são atômicos
2. **2FN**: Não há dependências parciais das chaves primárias
3. **3FN**: Não há dependências transitivas

### Justificativas de Design

- **Chaves Artificiais**: Utilizadas para melhor performance e flexibilidade
- **Campos Calculados**: Valor_Total e Subtotal são armazenados para performance, mas mantidos consistentes via triggers
- **Status Enumerados**: Utilizados para garantir integridade e facilitar consultas
- **Separação Cliente/Veículo**: Permite que um cliente tenha múltiplos veículos
- **Tabelas Associativas**: Para relacionamentos N:M com atributos adicionais
