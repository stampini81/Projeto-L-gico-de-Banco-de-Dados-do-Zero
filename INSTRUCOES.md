# Instruções de Execução - Projeto Oficina Mecânica

## Pré-requisitos

- MySQL 8.0+ ou MariaDB 10.5+
- Cliente MySQL (MySQL Workbench, phpMyAdmin, ou linha de comando)
- Acesso administrativo para criação de banco de dados

## Passo a Passo para Execução

### 1. Preparação do Ambiente

```sql
-- Conecte-se ao MySQL como administrador
mysql -u root -p
```

### 2. Criação do Schema

Execute o arquivo `sql/01-create-schema.sql`:

```bash
# Via linha de comando
mysql -u root -p < sql/01-create-schema.sql

# Ou via MySQL Workbench
# Abra o arquivo e execute todo o script
```

Este script irá:
- Criar o banco de dados `oficina_mecanica`
- Criar todas as 11 tabelas do sistema
- Adicionar constraints e relacionamentos
- Criar índices para otimização
- Criar views para relatórios
- Criar triggers para automação
- Criar stored procedures

### 3. Inserção dos Dados de Teste

Execute o arquivo `sql/02-insert-data.sql`:

```bash
# Via linha de comando
mysql -u root -p oficina_mecanica < sql/02-insert-data.sql
```

Este script irá inserir:
- 10 clientes
- 12 veículos
- 8 funcionários
- 10 especialidades
- 15 tipos de serviços
- 5 fornecedores
- 17 peças em estoque
- 10 ordens de serviço
- 14 itens de serviço
- 15 itens de peças utilizadas

### 4. Execução das Consultas

Execute o arquivo `sql/03-queries.sql` para testar o sistema:

```bash
# Via linha de comando
mysql -u root -p oficina_mecanica < sql/03-queries.sql
```

## Estrutura do Banco de Dados

### Tabelas Principais
1. **CLIENTE** - Dados dos clientes
2. **VEICULO** - Veículos dos clientes
3. **FUNCIONARIO** - Funcionários da oficina
4. **ESPECIALIDADE** - Especialidades técnicas
5. **SERVICO** - Tipos de serviços oferecidos
6. **FORNECEDOR** - Fornecedores de peças
7. **PECA** - Peças em estoque
8. **ORDEM_SERVICO** - Ordens de serviço
9. **ITEM_SERVICO** - Itens de cada OS
10. **ITEM_PECA** - Peças utilizadas nos serviços
11. **FUNCIONARIO_ESPECIALIDADE** - Relacionamento N:M

### Views Criadas
- `vw_relatorio_os` - Relatório completo de OS
- `vw_controle_estoque` - Controle de estoque
- `vw_produtividade_funcionario` - Produtividade
- `vw_ranking_servicos` - Ranking de serviços

### Stored Procedures
- `sp_atualiza_valor_total_os()` - Atualiza total da OS
- `sp_finaliza_os()` - Finaliza uma OS

## Consultas de Exemplo

### Consultas Simples
```sql
-- Listar todos os clientes
SELECT * FROM CLIENTE ORDER BY Nome;

-- Veículos por marca
SELECT Marca, COUNT(*) as Total 
FROM VEICULO 
GROUP BY Marca 
ORDER BY Total DESC;
```

### Consultas com Junções
```sql
-- Relatório de OS com detalhes
SELECT * FROM vw_relatorio_os 
WHERE Status = 'Concluída' 
ORDER BY Data_Abertura DESC;

-- Funcionários e suas especialidades
SELECT f.Nome, GROUP_CONCAT(e.Nome_Especialidade) as Especialidades
FROM FUNCIONARIO f
JOIN FUNCIONARIO_ESPECIALIDADE fe ON f.ID_Funcionario = fe.ID_Funcionario
JOIN ESPECIALIDADE e ON fe.ID_Especialidade = e.ID_Especialidade
GROUP BY f.ID_Funcionario, f.Nome;
```

### Consultas Analíticas
```sql
-- Top 5 clientes por valor gasto
SELECT c.Nome, SUM(os.Valor_Total) as Total_Gasto
FROM CLIENTE c
JOIN ORDEM_SERVICO os ON c.ID_Cliente = os.ID_Cliente
WHERE os.Status = 'Concluída'
GROUP BY c.ID_Cliente, c.Nome
ORDER BY Total_Gasto DESC
LIMIT 5;

-- Análise de estoque crítico
SELECT * FROM vw_controle_estoque 
WHERE Status_Estoque IN ('CRÍTICO', 'SEM ESTOQUE')
ORDER BY Estoque_Atual;
```

## Funcionalidades Implementadas

### ✅ Requisitos Atendidos

1. **Recuperações simples com SELECT** - ✅
   - Consultas 1, 2, 3 no arquivo de queries

2. **Filtros com WHERE** - ✅
   - Consultas 4, 5, 6 com diversos filtros

3. **Atributos derivados** - ✅
   - Consultas 7, 8, 9 com cálculos e expressões

4. **Ordenações com ORDER BY** - ✅
   - Consultas 10, 11 com ordenações complexas

5. **Filtros em grupos com HAVING** - ✅
   - Consultas 12, 13, 14 com condições em grupos

6. **Junções entre tabelas** - ✅
   - Consultas 15, 16, 17, 18 com múltiplas junções

### 🔧 Funcionalidades Avançadas

- **Triggers automáticos** para cálculos
- **Views** para facilitar consultas
- **Stored Procedures** para operações complexas
- **Índices** para otimização de performance
- **Constraints** para integridade de dados
- **Controle de estoque** automático
- **Relatórios gerenciais** prontos

## Troubleshooting

### Problemas Comuns

1. **Erro de permissão:**
   ```sql
   GRANT ALL PRIVILEGES ON oficina_mecanica.* TO 'usuario'@'localhost';
   FLUSH PRIVILEGES;
   ```

2. **Charset UTF-8:**
   ```sql
   ALTER DATABASE oficina_mecanica CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

3. **Verificar se dados foram inseridos:**
   ```sql
   SELECT COUNT(*) FROM CLIENTE;
   SELECT COUNT(*) FROM ORDEM_SERVICO;
   ```

## Próximos Passos

1. **Interface Web:** Desenvolver uma aplicação web
2. **Relatórios:** Criar dashboards com gráficos
3. **API REST:** Criar endpoints para integração
4. **Mobile:** Aplicativo móvel para funcionários
5. **BI:** Implementar Business Intelligence

## 👨‍💻 Autor

**Leandro da Silva Stampini**
- 💼 LinkedIn: [leandro-da-silva-stampini](https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/)
- 📧 Especialista em Banco de Dados
- 🎓 Este projeto foi desenvolvido como parte do desafio acadêmico de Banco de Dados.

---
**Data:** Outubro 2025  
**Versão:** 1.0  
**Status:** Completo
