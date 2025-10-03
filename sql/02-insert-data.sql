-- ============================================
-- PROJETO: Sistema de Banco de Dados para Oficina Mecânica
-- ARQUIVO: 02-insert-data.sql
-- DESCRIÇÃO: Script para inserção de dados de teste
-- AUTOR: Leandro da Silva Stampini
-- LINKEDIN: https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/
-- DATA: Outubro 2025
-- ============================================

USE oficina_mecanica;

-- Desabilitar verificação de chaves estrangeiras temporariamente
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- INSERÇÃO DE DADOS - TABELAS PRINCIPAIS
-- ============================================

-- Inserção de CLIENTES
INSERT INTO CLIENTE (Nome, CPF, Telefone, Email, Endereco) VALUES
('João Silva Santos', '12345678901', '(11) 98765-4321', 'joao.silva@email.com', 'Rua das Flores, 123 - São Paulo, SP'),
('Maria Oliveira Costa', '23456789012', '(11) 97654-3210', 'maria.oliveira@email.com', 'Av. Paulista, 456 - São Paulo, SP'),
('Carlos Eduardo Lima', '34567890123', '(11) 96543-2109', 'carlos.lima@email.com', 'Rua Augusta, 789 - São Paulo, SP'),
('Ana Paula Ferreira', '45678901234', '(11) 95432-1098', 'ana.ferreira@email.com', 'Rua Oscar Freire, 321 - São Paulo, SP'),
('Roberto Almeida Souza', '56789012345', '(11) 94321-0987', 'roberto.souza@email.com', 'Av. Faria Lima, 654 - São Paulo, SP'),
('Fernanda Castro Silva', '67890123456', '(11) 93210-9876', 'fernanda.silva@email.com', 'Rua Consolação, 987 - São Paulo, SP'),
('Marcos Vinícius Rocha', '78901234567', '(11) 92109-8765', 'marcos.rocha@email.com', 'Av. Rebouças, 159 - São Paulo, SP'),
('Juliana Mendes Pereira', '89012345678', '(11) 91098-7654', 'juliana.pereira@email.com', 'Rua Teodoro Sampaio, 753 - São Paulo, SP'),
('Ricardo Barbosa Lima', '90123456789', '(11) 90987-6543', 'ricardo.lima@email.com', 'Av. Ibirapuera, 357 - São Paulo, SP'),
('Patrícia Gomes Santos', '01234567890', '(11) 89876-5432', 'patricia.santos@email.com', 'Rua Vila Madalena, 951 - São Paulo, SP');

-- Inserção de VEÍCULOS
INSERT INTO VEICULO (Placa, Marca, Modelo, Ano, Cor, Quilometragem, ID_Cliente) VALUES
('ABC1234', 'Toyota', 'Corolla', 2020, 'Prata', 35000, 1),
('DEF5678', 'Honda', 'Civic', 2019, 'Branco', 42000, 2),
('GHI9012', 'Volkswagen', 'Gol', 2018, 'Azul', 58000, 3),
('JKL3456', 'Chevrolet', 'Onix', 2021, 'Vermelho', 28000, 4),
('MNO7890', 'Ford', 'Ka', 2017, 'Preto', 65000, 5),
('PQR1234', 'Hyundai', 'HB20', 2020, 'Branco', 31000, 6),
('STU5678', 'Nissan', 'Versa', 2019, 'Prata', 39000, 7),
('VWX9012', 'Renault', 'Logan', 2018, 'Cinza', 47000, 8),
('YZA3456', 'Fiat', 'Uno', 2016, 'Azul', 72000, 9),
('BCD7890', 'Peugeot', '208', 2021, 'Branco', 22000, 10),
('EFG1111', 'Toyota', 'Hilux', 2022, 'Preto', 15000, 1),
('HIJ2222', 'Honda', 'HR-V', 2020, 'Vermelho', 33000, 3);

-- Inserção de FUNCIONÁRIOS
INSERT INTO FUNCIONARIO (Nome, CPF, Cargo, Salario, Data_Admissao, Telefone) VALUES
('Pedro Henrique Machado', '11122233344', 'Mecânico Sênior', 4500.00, '2020-01-15', '(11) 99999-1111'),
('Lucas Fernandes Silva', '22233344455', 'Mecânico Júnior', 2800.00, '2021-03-10', '(11) 99999-2222'),
('Rafael Santos Costa', '33344455566', 'Eletricista Automotivo', 3200.00, '2020-06-20', '(11) 99999-3333'),
('Thiago Oliveira Lima', '44455566677', 'Funileiro', 3000.00, '2019-11-08', '(11) 99999-4444'),
('Gabriel Almeida Rocha', '55566677788', 'Pintor Automotivo', 2900.00, '2021-01-25', '(11) 99999-5555'),
('Bruno Carvalho Souza', '66677788899', 'Mecânico Pleno', 3800.00, '2020-09-12', '(11) 99999-6666'),
('André Pereira Santos', '77788899900', 'Atendente', 2200.00, '2022-02-01', '(11) 99999-7777'),
('Matheus Silva Barbosa', '88899900011', 'Supervisor', 5200.00, '2018-05-30', '(11) 99999-8888');

-- Inserção de ESPECIALIDADES
INSERT INTO ESPECIALIDADE (Nome_Especialidade, Descricao) VALUES
('Mecânica Geral', 'Manutenção e reparo de sistemas mecânicos gerais'),
('Sistema Elétrico', 'Diagnóstico e reparo de sistemas elétricos automotivos'),
('Sistema de Freios', 'Especialização em freios e sistemas de segurança'),
('Motor e Transmissão', 'Reparo e manutenção de motores e caixas de câmbio'),
('Suspensão e Direção', 'Sistemas de suspensão, amortecimento e direção'),
('Ar Condicionado', 'Sistema de climatização automotiva'),
('Injeção Eletrônica', 'Sistemas de injeção e gerenciamento do motor'),
('Funilaria', 'Reparo de lataria e estrutura do veículo'),
('Pintura Automotiva', 'Pintura e acabamento automotivo'),
('Pneus e Alinhamento', 'Serviços relacionados a pneus e geometria');

-- Inserção de FUNCIONARIO_ESPECIALIDADE
INSERT INTO FUNCIONARIO_ESPECIALIDADE (ID_Funcionario, ID_Especialidade, Data_Certificacao, Nivel_Experiencia) VALUES
(1, 1, '2020-02-01', 'Avançado'),
(1, 4, '2020-03-15', 'Avançado'),
(1, 5, '2020-04-10', 'Intermediário'),
(2, 1, '2021-04-01', 'Iniciante'),
(2, 10, '2021-05-15', 'Intermediário'),
(3, 2, '2020-07-01', 'Avançado'),
(3, 6, '2020-08-20', 'Intermediário'),
(3, 7, '2021-01-10', 'Intermediário'),
(4, 8, '2019-12-01', 'Avançado'),
(5, 9, '2021-02-15', 'Intermediário'),
(6, 1, '2020-10-01', 'Intermediário'),
(6, 3, '2020-11-15', 'Avançado'),
(6, 4, '2021-02-01', 'Intermediário');

-- Inserção de SERVIÇOS
INSERT INTO SERVICO (Nome_Servico, Descricao, Preco_Base, Tempo_Estimado) VALUES
('Troca de Óleo', 'Troca de óleo do motor e filtro', 80.00, 30),
('Alinhamento e Balanceamento', 'Alinhamento da direção e balanceamento das rodas', 120.00, 60),
('Revisão dos Freios', 'Inspeção e manutenção do sistema de freios', 150.00, 90),
('Troca de Pastilhas de Freio', 'Substituição das pastilhas de freio dianteiras', 180.00, 120),
('Diagnóstico Eletrônico', 'Diagnóstico completo dos sistemas eletrônicos', 100.00, 45),
('Troca de Bateria', 'Substituição da bateria do veículo', 50.00, 20),
('Reparo do Sistema Elétrico', 'Diagnóstico e reparo de problemas elétricos', 200.00, 180),
('Manutenção do Ar Condicionado', 'Limpeza e recarga do sistema de ar condicionado', 180.00, 90),
('Troca de Amortecedores', 'Substituição dos amortecedores dianteiros ou traseiros', 350.00, 240),
('Reparo de Motor', 'Diagnóstico e reparo de problemas no motor', 500.00, 480),
('Funilaria Simples', 'Reparo de pequenos danos na lataria', 300.00, 360),
('Pintura Automotiva', 'Pintura completa ou parcial do veículo', 800.00, 720),
('Troca de Pneus', 'Montagem e balanceamento de pneus novos', 100.00, 45),
('Limpeza de Bicos Injetores', 'Limpeza e teste dos bicos injetores', 150.00, 120),
('Revisão Completa', 'Revisão geral de todos os sistemas do veículo', 400.00, 300);

-- Inserção de FORNECEDORES
INSERT INTO FORNECEDOR (Nome_Empresa, CNPJ, Telefone, Email, Endereco) VALUES
('Auto Peças SP Ltda', '12345678000191', '(11) 3333-1111', 'vendas@autopecassp.com.br', 'Rua das Peças, 100 - São Paulo, SP'),
('Distribuidora Central', '23456789000192', '(11) 3333-2222', 'comercial@distcentral.com.br', 'Av. Marginal, 200 - São Paulo, SP'),
('Peças Premium Auto', '34567890000193', '(11) 3333-3333', 'atendimento@pecaspremium.com.br', 'Rua do Comércio, 300 - São Paulo, SP'),
('Fornecedor Nacional', '45678901000194', '(11) 3333-4444', 'vendas@fornecedornacional.com.br', 'Av. Industrial, 400 - São Paulo, SP'),
('Auto Center Distribuidora', '56789012000195', '(11) 3333-5555', 'pedidos@autocenterdist.com.br', 'Rua da Distribuição, 500 - São Paulo, SP');

-- Inserção de PEÇAS
INSERT INTO PECA (Nome_Peca, Descricao, Preco_Custo, Preco_Venda, Estoque_Atual, Estoque_Minimo, ID_Fornecedor) VALUES
('Filtro de Óleo', 'Filtro de óleo para motores 1.0 a 2.0', 15.00, 25.00, 50, 10, 1),
('Óleo Motor 5W30', 'Óleo sintético 5W30 - 4 litros', 45.00, 75.00, 30, 5, 1),
('Pastilha de Freio Dianteira', 'Pastilha de freio dianteira - linha popular', 60.00, 100.00, 25, 5, 2),
('Pastilha de Freio Traseira', 'Pastilha de freio traseira - linha popular', 45.00, 75.00, 20, 5, 2),
('Bateria 60Ah', 'Bateria automotiva 60Ah', 180.00, 300.00, 15, 3, 3),
('Amortecedor Dianteiro', 'Amortecedor dianteiro - linha econômica', 120.00, 200.00, 12, 2, 4),
('Amortecedor Traseiro', 'Amortecedor traseiro - linha econômica', 110.00, 180.00, 10, 2, 4),
('Lâmpada H4', 'Lâmpada halógena H4 12V 60/55W', 8.00, 15.00, 40, 8, 5),
('Fusível 10A', 'Fusível automotivo 10A', 2.00, 5.00, 100, 20, 5),
('Correia Dentada', 'Correia dentada do motor', 80.00, 130.00, 8, 2, 1),
('Vela de Ignição', 'Vela de ignição padrão', 12.00, 20.00, 60, 12, 2),
('Filtro de Ar', 'Filtro de ar do motor', 20.00, 35.00, 35, 7, 3),
('Filtro de Combustível', 'Filtro de combustível', 25.00, 45.00, 28, 6, 3),
('Disco de Freio', 'Disco de freio dianteiro', 90.00, 150.00, 16, 4, 2),
('Fluido de Freio', 'Fluido de freio DOT 4 - 500ml', 18.00, 30.00, 45, 10, 4),
('Pneu 175/70 R13', 'Pneu aro 13 - linha econômica', 180.00, 280.00, 20, 4, 5),
('Pneu 185/60 R15', 'Pneu aro 15 - linha premium', 250.00, 380.00, 16, 4, 5);

-- ============================================
-- INSERÇÃO DE DADOS - ORDENS DE SERVIÇO
-- ============================================

-- Inserção de ORDENS DE SERVIÇO
INSERT INTO ORDEM_SERVICO (Data_Abertura, Data_Conclusao, Status, Observacoes, ID_Veiculo, ID_Cliente) VALUES
('2024-01-15 08:30:00', '2024-01-15 17:00:00', 'Concluída', 'Revisão preventiva conforme manual', 1, 1),
('2024-01-20 09:00:00', '2024-01-22 16:30:00', 'Concluída', 'Problemas nos freios resolvidos', 2, 2),
('2024-02-01 10:15:00', '2024-02-01 15:45:00', 'Concluída', 'Troca de óleo e filtros', 3, 3),
('2024-02-10 08:00:00', '2024-02-12 18:00:00', 'Concluída', 'Reparo elétrico e troca de bateria', 4, 4),
('2024-02-20 14:20:00', NULL, 'Em Andamento', 'Aguardando peças para motor', 5, 5),
('2024-03-01 07:45:00', '2024-03-05 17:30:00', 'Concluída', 'Funilaria e pintura completa', 6, 6),
('2024-03-10 09:30:00', '2024-03-10 12:00:00', 'Concluída', 'Alinhamento e balanceamento', 7, 7),
('2024-03-15 13:00:00', NULL, 'Aberta', 'Aguardando aprovação do orçamento', 8, 8),
('2024-03-20 08:15:00', '2024-03-20 16:45:00', 'Concluída', 'Manutenção do ar condicionado', 9, 9),
('2024-03-25 11:00:00', NULL, 'Em Andamento', 'Troca de amortecedores em andamento', 10, 10);

-- Inserção de ITENS DE SERVIÇO
INSERT INTO ITEM_SERVICO (Quantidade, Preco_Unitario, Data_Inicio, Data_Fim, Status_Item, ID_OS, ID_Servico, ID_Funcionario) VALUES
-- OS 1 (Revisão preventiva)
(1, 80.00, '2024-01-15 08:30:00', '2024-01-15 09:00:00', 'Concluído', 1, 1, 1),
(1, 100.00, '2024-01-15 09:30:00', '2024-01-15 10:15:00', 'Concluído', 1, 5, 3),
(1, 150.00, '2024-01-15 11:00:00', '2024-01-15 13:00:00', 'Concluído', 1, 14, 1),

-- OS 2 (Problemas nos freios)
(1, 150.00, '2024-01-20 09:00:00', '2024-01-20 10:30:00', 'Concluído', 2, 3, 6),
(1, 180.00, '2024-01-20 14:00:00', '2024-01-22 16:30:00', 'Concluído', 2, 4, 6),

-- OS 3 (Troca de óleo)
(1, 80.00, '2024-02-01 10:15:00', '2024-02-01 10:45:00', 'Concluído', 3, 1, 2),
(1, 120.00, '2024-02-01 14:00:00', '2024-02-01 15:45:00', 'Concluído', 3, 2, 2),

-- OS 4 (Reparo elétrico)
(1, 200.00, '2024-02-10 08:00:00', '2024-02-11 17:00:00', 'Concluído', 4, 7, 3),
(1, 50.00, '2024-02-12 09:00:00', '2024-02-12 09:20:00', 'Concluído', 4, 6, 3),

-- OS 5 (Reparo de motor - em andamento)
(1, 500.00, '2024-02-20 14:20:00', NULL, 'Em Execução', 5, 10, 1),

-- OS 6 (Funilaria e pintura)
(1, 300.00, '2024-03-01 07:45:00', '2024-03-03 18:00:00', 'Concluído', 6, 11, 4),
(1, 800.00, '2024-03-04 08:00:00', '2024-03-05 17:30:00', 'Concluído', 6, 12, 5),

-- OS 7 (Alinhamento)
(1, 120.00, '2024-03-10 09:30:00', '2024-03-10 12:00:00', 'Concluído', 7, 2, 2),

-- OS 8 (Aguardando aprovação)
(1, 180.00, NULL, NULL, 'Pendente', 8, 9, 1),

-- OS 9 (Ar condicionado)
(1, 180.00, '2024-03-20 08:15:00', '2024-03-20 16:45:00', 'Concluído', 9, 8, 3),

-- OS 10 (Amortecedores - em andamento)
(2, 350.00, '2024-03-25 11:00:00', NULL, 'Em Execução', 10, 9, 6);

-- Inserção de ITENS DE PEÇA
INSERT INTO ITEM_PECA (Quantidade_Utilizada, Preco_Unitario_Peca, ID_Item, ID_Peca) VALUES
-- Itens da OS 1
(1, 25.00, 1, 1), -- Filtro de óleo
(4, 75.00, 1, 2), -- Óleo motor
(1, 35.00, 3, 12), -- Filtro de ar
(4, 20.00, 3, 11), -- Velas de ignição

-- Itens da OS 2
(1, 100.00, 4, 3), -- Pastilha dianteira
(1, 75.00, 5, 4), -- Pastilha traseira
(2, 150.00, 5, 14), -- Discos de freio
(1, 30.00, 5, 15), -- Fluido de freio

-- Itens da OS 3
(1, 25.00, 6, 1), -- Filtro de óleo
(4, 75.00, 6, 2), -- Óleo motor

-- Itens da OS 4
(1, 300.00, 8, 5), -- Bateria
(2, 15.00, 8, 8), -- Lâmpadas
(3, 5.00, 8, 9), -- Fusíveis

-- Itens da OS 5 (em andamento)
(1, 130.00, 9, 10), -- Correia dentada
(4, 20.00, 9, 11), -- Velas

-- Itens da OS 9
(1, 35.00, 13, 12), -- Filtro de ar

-- Itens da OS 10
(2, 200.00, 14, 6), -- Amortecedores dianteiros
(2, 180.00, 14, 7); -- Amortecedores traseiros

-- Reabilitar verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;

-- Atualizar valores totais das OS (chamando a procedure)
CALL sp_atualiza_valor_total_os(1);
CALL sp_atualiza_valor_total_os(2);
CALL sp_atualiza_valor_total_os(3);
CALL sp_atualiza_valor_total_os(4);
CALL sp_atualiza_valor_total_os(5);
CALL sp_atualiza_valor_total_os(6);
CALL sp_atualiza_valor_total_os(7);
CALL sp_atualiza_valor_total_os(8);
CALL sp_atualiza_valor_total_os(9);
CALL sp_atualiza_valor_total_os(10);

-- ============================================
-- VERIFICAÇÃO DOS DADOS INSERIDOS
-- ============================================

SELECT 'Dados inseridos com sucesso!' AS Mensagem;

-- Estatísticas dos dados inseridos
SELECT 
    'CLIENTE' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM CLIENTE

UNION ALL

SELECT 
    'VEICULO' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM VEICULO

UNION ALL

SELECT 
    'FUNCIONARIO' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM FUNCIONARIO

UNION ALL

SELECT 
    'ESPECIALIDADE' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM ESPECIALIDADE

UNION ALL

SELECT 
    'SERVICO' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM SERVICO

UNION ALL

SELECT 
    'FORNECEDOR' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM FORNECEDOR

UNION ALL

SELECT 
    'PECA' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM PECA

UNION ALL

SELECT 
    'ORDEM_SERVICO' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM ORDEM_SERVICO

UNION ALL

SELECT 
    'ITEM_SERVICO' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM ITEM_SERVICO

UNION ALL

SELECT 
    'ITEM_PECA' AS Tabela, 
    COUNT(*) AS Total_Registros 
FROM ITEM_PECA;
