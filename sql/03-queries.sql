-- ============================================
-- PROJETO: Sistema de Banco de Dados para Oficina Mecânica
-- ARQUIVO: 03-queries.sql
-- DESCRIÇÃO: Consultas complexas para teste e análise
-- AUTOR: Leandro da Silva Stampini
-- LINKEDIN: https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/
-- DATA: Outubro 2025
-- ============================================

USE oficina_mecanica;

-- ============================================
-- CONSULTAS SIMPLES COM SELECT
-- ============================================

-- 1. Listar todos os clientes ordenados por nome
SELECT 
    ID_Cliente,
    Nome,
    CPF,
    Telefone,
    Email
FROM CLIENTE
ORDER BY Nome;

-- 2. Listar todos os veículos com informações do proprietário
SELECT 
    v.Placa,
    v.Marca,
    v.Modelo,
    v.Ano,
    v.Cor,
    c.Nome AS Proprietario,
    c.Telefone
FROM VEICULO v
INNER JOIN CLIENTE c ON v.ID_Cliente = c.ID_Cliente
ORDER BY v.Marca, v.Modelo;

-- 3. Listar funcionários e seus cargos
SELECT 
    Nome,
    Cargo,
    FORMAT(Salario, 2, 'pt_BR') AS Salario_Formatado,
    Data_Admissao
FROM FUNCIONARIO
ORDER BY Salario DESC;

-- ============================================
-- FILTROS COM WHERE
-- ============================================

-- 4. Veículos fabricados após 2019
SELECT 
    Placa,
    Marca,
    Modelo,
    Ano,
    Quilometragem
FROM VEICULO
WHERE Ano > 2019
ORDER BY Ano DESC, Marca;

-- 5. Clientes cadastrados nos últimos 30 dias
SELECT 
    Nome,
    CPF,
    Email,
    Data_Cadastro
FROM CLIENTE
WHERE Data_Cadastro >= DATE_SUB(NOW(), INTERVAL 30 DAY)
ORDER BY Data_Cadastro DESC;

-- 6. Peças com estoque baixo (abaixo do estoque mínimo)
SELECT 
    Nome_Peca,
    Estoque_Atual,
    Estoque_Minimo,
    Preco_Venda,
    (Estoque_Minimo - Estoque_Atual) AS Quantidade_Repor
FROM PECA
WHERE Estoque_Atual <= Estoque_Minimo
ORDER BY (Estoque_Minimo - Estoque_Atual) DESC;

-- ============================================
-- EXPRESSÕES PARA ATRIBUTOS DERIVADOS
-- ============================================

-- 7. Relatório financeiro de peças com margem de lucro
SELECT 
    Nome_Peca,
    Preco_Custo,
    Preco_Venda,
    (Preco_Venda - Preco_Custo) AS Lucro_Unitario,
    ROUND(((Preco_Venda - Preco_Custo) / Preco_Custo) * 100, 2) AS Margem_Percentual,
    Estoque_Atual,
    (Estoque_Atual * Preco_Custo) AS Valor_Estoque_Custo,
    (Estoque_Atual * Preco_Venda) AS Valor_Estoque_Venda
FROM PECA
WHERE Estoque_Atual > 0
ORDER BY Margem_Percentual DESC;

-- 8. Idade dos veículos e classificação
SELECT 
    Placa,
    Marca,
    Modelo,
    Ano,
    (YEAR(CURDATE()) - Ano) AS Idade_Anos,
    CASE 
        WHEN (YEAR(CURDATE()) - Ano) <= 3 THEN 'Novo'
        WHEN (YEAR(CURDATE()) - Ano) <= 7 THEN 'Seminovo'
        WHEN (YEAR(CURDATE()) - Ano) <= 15 THEN 'Usado'
        ELSE 'Antigo'
    END AS Classificacao_Idade,
    Quilometragem,
    ROUND(Quilometragem / (YEAR(CURDATE()) - Ano + 1), 0) AS KM_Por_Ano
FROM VEICULO
ORDER BY Idade_Anos, Quilometragem DESC;

-- 9. Tempo de empresa dos funcionários
SELECT 
    Nome,
    Cargo,
    Data_Admissao,
    DATEDIFF(CURDATE(), Data_Admissao) AS Dias_Empresa,
    ROUND(DATEDIFF(CURDATE(), Data_Admissao) / 365.25, 1) AS Anos_Empresa,
    CASE 
        WHEN DATEDIFF(CURDATE(), Data_Admissao) < 365 THEN 'Novo'
        WHEN DATEDIFF(CURDATE(), Data_Admissao) < 1095 THEN 'Experiente'
        ELSE 'Veterano'
    END AS Classificacao_Experiencia
FROM FUNCIONARIO
ORDER BY Data_Admissao;

-- ============================================
-- ORDENAÇÕES COM ORDER BY
-- ============================================

-- 10. Ranking de serviços mais executados
SELECT 
    s.Nome_Servico,
    s.Preco_Base,
    COUNT(iservico.ID_Item) AS Vezes_Executado,
    COALESCE(SUM(iservico.Subtotal), 0) AS Faturamento_Total,
    ROUND(AVG(iservico.Preco_Unitario), 2) AS Preco_Medio_Praticado
FROM SERVICO s
LEFT JOIN ITEM_SERVICO iservico ON s.ID_Servico = iservico.ID_Servico
GROUP BY s.ID_Servico, s.Nome_Servico, s.Preco_Base
ORDER BY Vezes_Executado DESC, Faturamento_Total DESC;

-- 11. Clientes com maior valor gasto em ordem decrescente
SELECT 
    c.Nome,
    c.CPF,
    c.Telefone,
    COUNT(DISTINCT os.ID_OS) AS Total_OS,
    COALESCE(SUM(os.Valor_Total), 0) AS Valor_Total_Gasto,
    ROUND(AVG(os.Valor_Total), 2) AS Valor_Medio_OS
FROM CLIENTE c
LEFT JOIN ORDEM_SERVICO os ON c.ID_Cliente = os.ID_Cliente
GROUP BY c.ID_Cliente, c.Nome, c.CPF, c.Telefone
ORDER BY Valor_Total_Gasto DESC, Total_OS DESC;

-- ============================================
-- CONDIÇÕES DE FILTRO COM HAVING
-- ============================================

-- 12. Funcionários com faturamento acima da média
SELECT 
    f.Nome,
    f.Cargo,
    COUNT(iservico.ID_Item) AS Servicos_Executados,
    COALESCE(SUM(iservico.Subtotal), 0) AS Faturamento_Gerado,
    ROUND(AVG(iservico.Subtotal), 2) AS Valor_Medio_Servico
FROM FUNCIONARIO f
LEFT JOIN ITEM_SERVICO iservico ON f.ID_Funcionario = iservico.ID_Funcionario
GROUP BY f.ID_Funcionario, f.Nome, f.Cargo
HAVING Faturamento_Gerado > (
    SELECT AVG(total_funcionario) 
    FROM (
        SELECT COALESCE(SUM(iservico2.Subtotal), 0) AS total_funcionario
        FROM FUNCIONARIO f2
        LEFT JOIN ITEM_SERVICO iservico2 ON f2.ID_Funcionario = iservico2.ID_Funcionario
        GROUP BY f2.ID_Funcionario
    ) AS subquery
)
ORDER BY Faturamento_Gerado DESC;

-- 13. Fornecedores com mais de 3 tipos de peças
SELECT 
    f.Nome_Empresa,
    f.CNPJ,
    f.Telefone,
    COUNT(p.ID_Peca) AS Quantidade_Pecas,
    ROUND(AVG(p.Preco_Venda), 2) AS Preco_Medio_Pecas,
    SUM(p.Estoque_Atual) AS Total_Pecas_Estoque
FROM FORNECEDOR f
INNER JOIN PECA p ON f.ID_Fornecedor = p.ID_Fornecedor
GROUP BY f.ID_Fornecedor, f.Nome_Empresa, f.CNPJ, f.Telefone
HAVING COUNT(p.ID_Peca) > 3
ORDER BY Quantidade_Pecas DESC;

-- 14. Meses com faturamento superior a R$ 1000
SELECT 
    YEAR(os.Data_Abertura) AS Ano,
    MONTH(os.Data_Abertura) AS Mes,
    MONTHNAME(os.Data_Abertura) AS Nome_Mes,
    COUNT(os.ID_OS) AS Total_OS,
    COALESCE(SUM(os.Valor_Total), 0) AS Faturamento_Mensal,
    ROUND(AVG(os.Valor_Total), 2) AS Ticket_Medio
FROM ORDEM_SERVICO os
WHERE os.Status = 'Concluída'
GROUP BY YEAR(os.Data_Abertura), MONTH(os.Data_Abertura), MONTHNAME(os.Data_Abertura)
HAVING Faturamento_Mensal > 1000
ORDER BY Ano DESC, Mes DESC;

-- ============================================
-- JUNÇÕES COMPLEXAS ENTRE TABELAS
-- ============================================

-- 15. Relatório completo de OS com todos os detalhes
SELECT 
    os.ID_OS,
    os.Data_Abertura,
    os.Data_Conclusao,
    os.Status AS Status_OS,
    c.Nome AS Cliente,
    c.CPF AS CPF_Cliente,
    c.Telefone AS Tel_Cliente,
    v.Placa,
    v.Marca,
    v.Modelo,
    v.Ano,
    s.Nome_Servico,
    iservico.Quantidade AS Qty_Servico,
    iservico.Preco_Unitario,
    iservico.Subtotal AS Subtotal_Servico,
    f.Nome AS Funcionario_Responsavel,
    f.Cargo,
    os.Valor_Total AS Total_OS
FROM ORDEM_SERVICO os
INNER JOIN CLIENTE c ON os.ID_Cliente = c.ID_Cliente
INNER JOIN VEICULO v ON os.ID_Veiculo = v.ID_Veiculo
LEFT JOIN ITEM_SERVICO iservico ON os.ID_OS = iservico.ID_OS
LEFT JOIN SERVICO s ON iservico.ID_Servico = s.ID_Servico
LEFT JOIN FUNCIONARIO f ON iservico.ID_Funcionario = f.ID_Funcionario
ORDER BY os.ID_OS, iservico.ID_Item;

-- 16. Análise detalhada de peças utilizadas por serviço
SELECT 
    os.ID_OS,
    c.Nome AS Cliente,
    v.Placa,
    s.Nome_Servico,
    f.Nome AS Funcionario,
    p.Nome_Peca,
    ip.Quantidade_Utilizada,
    ip.Preco_Unitario_Peca,
    ip.Subtotal_Peca,
    p.Estoque_Atual,
    fornec.Nome_Empresa AS Fornecedor
FROM ORDEM_SERVICO os
INNER JOIN CLIENTE c ON os.ID_Cliente = c.ID_Cliente
INNER JOIN VEICULO v ON os.ID_Veiculo = v.ID_Veiculo
INNER JOIN ITEM_SERVICO iservico ON os.ID_OS = iservico.ID_OS
INNER JOIN SERVICO s ON iservico.ID_Servico = s.ID_Servico
INNER JOIN FUNCIONARIO f ON iservico.ID_Funcionario = f.ID_Funcionario
INNER JOIN ITEM_PECA ip ON iservico.ID_Item = ip.ID_Item
INNER JOIN PECA p ON ip.ID_Peca = p.ID_Peca
LEFT JOIN FORNECEDOR fornec ON p.ID_Fornecedor = fornec.ID_Fornecedor
ORDER BY os.ID_OS, s.Nome_Servico, p.Nome_Peca;

-- 17. Funcionários, suas especialidades e performance
SELECT 
    f.Nome AS Funcionario,
    f.Cargo,
    f.Salario,
    GROUP_CONCAT(DISTINCT e.Nome_Especialidade ORDER BY e.Nome_Especialidade SEPARATOR ', ') AS Especialidades,
    COUNT(DISTINCT iservico.ID_Item) AS Servicos_Executados,
    COUNT(DISTINCT iservico.ID_OS) AS OS_Participou,
    COALESCE(SUM(iservico.Subtotal), 0) AS Faturamento_Gerado,
    ROUND(COALESCE(SUM(iservico.Subtotal), 0) / f.Salario, 2) AS ROI_Funcionario
FROM FUNCIONARIO f
LEFT JOIN FUNCIONARIO_ESPECIALIDADE fe ON f.ID_Funcionario = fe.ID_Funcionario
LEFT JOIN ESPECIALIDADE e ON fe.ID_Especialidade = e.ID_Especialidade
LEFT JOIN ITEM_SERVICO iservico ON f.ID_Funcionario = iservico.ID_Funcionario
GROUP BY f.ID_Funcionario, f.Nome, f.Cargo, f.Salario
ORDER BY ROI_Funcionario DESC;

-- 18. Análise de veículos por marca e serviços realizados
SELECT 
    v.Marca,
    COUNT(DISTINCT v.ID_Veiculo) AS Total_Veiculos_Marca,
    COUNT(DISTINCT os.ID_OS) AS Total_OS_Marca,
    COALESCE(SUM(os.Valor_Total), 0) AS Faturamento_Por_Marca,
    ROUND(AVG(os.Valor_Total), 2) AS Ticket_Medio_Marca,
    ROUND(AVG(v.Quilometragem), 0) AS KM_Medio_Marca,
    ROUND(AVG(YEAR(CURDATE()) - v.Ano), 1) AS Idade_Media_Frota
FROM VEICULO v
LEFT JOIN ORDEM_SERVICO os ON v.ID_Veiculo = os.ID_Veiculo
GROUP BY v.Marca
HAVING COUNT(DISTINCT v.ID_Veiculo) > 0
ORDER BY Faturamento_Por_Marca DESC;

-- ============================================
-- CONSULTAS ANALÍTICAS AVANÇADAS
-- ============================================

-- 19. Dashboard executivo - Métricas principais
SELECT 
    'Total Clientes' AS Metrica,
    COUNT(*) AS Valor,
    '-' AS Observacao
FROM CLIENTE

UNION ALL

SELECT 
    'Total Veículos' AS Metrica,
    COUNT(*) AS Valor,
    '-' AS Observacao
FROM VEICULO

UNION ALL

SELECT 
    'OS Abertas' AS Metrica,
    COUNT(*) AS Valor,
    'Necessitam atenção' AS Observacao
FROM ORDEM_SERVICO 
WHERE Status IN ('Aberta', 'Em Andamento')

UNION ALL

SELECT 
    'Faturamento Total' AS Metrica,
    ROUND(COALESCE(SUM(Valor_Total), 0), 2) AS Valor,
    'OS Concluídas' AS Observacao
FROM ORDEM_SERVICO 
WHERE Status = 'Concluída'

UNION ALL

SELECT 
    'Ticket Médio' AS Metrica,
    ROUND(AVG(Valor_Total), 2) AS Valor,
    'Valor médio por OS' AS Observacao
FROM ORDEM_SERVICO 
WHERE Status = 'Concluída' AND Valor_Total > 0

UNION ALL

SELECT 
    'Peças em Estoque Crítico' AS Metrica,
    COUNT(*) AS Valor,
    'Abaixo do mínimo' AS Observacao
FROM PECA 
WHERE Estoque_Atual <= Estoque_Minimo;

-- 20. Análise temporal de faturamento
SELECT 
    DATE_FORMAT(os.Data_Abertura, '%Y-%m') AS Ano_Mes,
    COUNT(os.ID_OS) AS Total_OS,
    COUNT(CASE WHEN os.Status = 'Concluída' THEN 1 END) AS OS_Concluidas,
    ROUND((COUNT(CASE WHEN os.Status = 'Concluída' THEN 1 END) / COUNT(os.ID_OS)) * 100, 2) AS Taxa_Conclusao,
    COALESCE(SUM(CASE WHEN os.Status = 'Concluída' THEN os.Valor_Total ELSE 0 END), 0) AS Faturamento,
    ROUND(AVG(CASE WHEN os.Status = 'Concluída' THEN os.Valor_Total END), 2) AS Ticket_Medio
FROM ORDEM_SERVICO os
GROUP BY DATE_FORMAT(os.Data_Abertura, '%Y-%m')
ORDER BY Ano_Mes DESC;

-- ============================================
-- CONSULTAS PARA TOMADA DE DECISÃO
-- ============================================

-- 21. Relatório de rentabilidade por tipo de serviço
SELECT 
    s.Nome_Servico,
    s.Preco_Base,
    COUNT(iservico.ID_Item) AS Frequencia,
    ROUND(AVG(iservico.Preco_Unitario), 2) AS Preco_Medio_Praticado,
    ROUND(((AVG(iservico.Preco_Unitario) - s.Preco_Base) / s.Preco_Base) * 100, 2) AS Variacao_Preco_Perc,
    COALESCE(SUM(iservico.Subtotal), 0) AS Receita_Total,
    -- Estimativa de custo de peças por serviço
    COALESCE(SUM(ip.Subtotal_Peca), 0) AS Custo_Pecas,
    COALESCE(SUM(iservico.Subtotal), 0) - COALESCE(SUM(ip.Subtotal_Peca), 0) AS Margem_Bruta
FROM SERVICO s
LEFT JOIN ITEM_SERVICO iservico ON s.ID_Servico = iservico.ID_Servico
LEFT JOIN ITEM_PECA ip ON iservico.ID_Item = ip.ID_Item
GROUP BY s.ID_Servico, s.Nome_Servico, s.Preco_Base
HAVING COUNT(iservico.ID_Item) > 0
ORDER BY Margem_Bruta DESC;

-- 22. Análise de sazonalidade e tendências
SELECT 
    MONTHNAME(os.Data_Abertura) AS Mes,
    COUNT(os.ID_OS) AS Total_OS,
    COALESCE(SUM(os.Valor_Total), 0) AS Faturamento,
    COUNT(DISTINCT os.ID_Cliente) AS Clientes_Unicos,
    ROUND(AVG(os.Valor_Total), 2) AS Ticket_Medio,
    -- Tipo de serviço mais comum no mês
    (SELECT s.Nome_Servico 
     FROM ITEM_SERVICO iservico2 
     INNER JOIN SERVICO s ON iservico2.ID_Servico = s.ID_Servico
     INNER JOIN ORDEM_SERVICO os2 ON iservico2.ID_OS = os2.ID_OS
     WHERE MONTH(os2.Data_Abertura) = MONTH(os.Data_Abertura)
     GROUP BY s.ID_Servico, s.Nome_Servico
     ORDER BY COUNT(*) DESC
     LIMIT 1
    ) AS Servico_Mais_Comum
FROM ORDEM_SERVICO os
WHERE os.Status = 'Concluída'
GROUP BY MONTH(os.Data_Abertura), MONTHNAME(os.Data_Abertura)
ORDER BY MONTH(os.Data_Abertura);

-- ============================================
-- VERIFICAÇÃO FINAL
-- ============================================

SELECT 'Consultas executadas com sucesso!' AS Mensagem,
       NOW() AS Data_Execucao;
