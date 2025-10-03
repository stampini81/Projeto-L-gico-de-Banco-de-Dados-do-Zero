# Projeto Lógico de Banco de Dados - Oficina Mecânica

## 🎯 Descrição do Projeto

Este projeto apresenta o desenvolvimento completo de um **sistema de banco de dados para uma oficina mecânica**, desde a modelagem conceitual até a implementação e testes com consultas complexas. O sistema foi projetado para gerenciar de forma eficiente todas as operações de uma oficina automotiva.

## 🚗 Contexto do Negócio

A oficina mecânica precisa de um sistema para:
- ✅ Cadastrar e gerenciar **clientes** e seus **veículos**
- ✅ Controlar **funcionários** e suas **especialidades**
- ✅ Registrar **serviços** oferecidos e seus preços
- ✅ Gerenciar **ordens de serviço** e seus itens
- ✅ Controlar **estoque de peças**
- ✅ Gerar **relatórios gerenciais**

## 📊 Modelo Conceitual

O modelo conceitual foi desenvolvido com base nas seguintes **entidades principais**:

| Entidade | Descrição | Relacionamentos |
|----------|-----------|-----------------|
| **Cliente** | Proprietários dos veículos | 1:N com Veículo |
| **Veículo** | Automóveis atendidos | N:1 com Cliente, 1:N com OS |
| **Funcionário** | Mecânicos e técnicos | N:M com Especialidade |
| **Especialidade** | Áreas de expertise | N:M with Funcionário |
| **Serviço** | Tipos de serviços | 1:N com Item_Serviço |
| **Ordem de Serviço** | Registros de atendimento | 1:N com Item_Serviço |
| **Peça** | Componentes para reparos | N:M com Item_Serviço |
| **Fornecedor** | Fornecedores de peças | 1:N com Peça |

## 📁 Estrutura do Projeto

```
📂 Projeto Lógico de Banco de Dados do Zero/
├── 📁 docs/               # Documentação completa
│   ├── 📄 modelo-conceitual.md     # Modelo conceitual detalhado
│   ├── 📄 modelo-logico.md         # Esquema lógico com tabelas
│   └── 📄 dicionario-dados.md      # Dicionário de dados
├── 📁 sql/                # Scripts SQL
│   ├── 📄 01-create-schema.sql     # Criação do banco
│   ├── 📄 02-insert-data.sql       # Dados de teste
│   └── 📄 03-queries.sql           # Consultas complexas
├── 📁 data/               # Dados de exemplo
│   └── 📄 sample-data.json         # Dados em formato JSON
├── 📄 README.md           # Este arquivo
└── 📄 INSTRUCOES.md       # Guia de execução
```

## 🛠️ Implementação Técnica

### Tecnologias Utilizadas
- **MySQL 8.0+** / PostgreSQL / SQL Server
- **SQL ANSI** padrão
- **Triggers** para automação
- **Views** para relatórios
- **Stored Procedures** para operações complexas
- **Índices** para otimização

### Características do Sistema
- **11 tabelas** inter-relacionadas
- **4 views** para relatórios
- **5 triggers** para automação
- **2 stored procedures** para operações
- **15+ índices** para performance
- **Constraints** para integridade

## 📈 Consultas Implementadas

### ✅ Requisitos Atendidos pelo Desafio

| Requisito | Implementação | Localização |
|-----------|---------------|-------------|
| **SELECT simples** | Consultas básicas de listagem | Queries 1-3 |
| **Filtros WHERE** | Filtros por data, valor, status | Queries 4-6 |
| **Atributos derivados** | Cálculos de margem, idade, ROI | Queries 7-9 |
| **ORDER BY** | Ordenações complexas | Queries 10-11 |
| **HAVING** | Filtros em grupos agregados | Queries 12-14 |
| **Junções** | JOINs entre múltiplas tabelas | Queries 15-18 |

### 🔍 Exemplos de Consultas Complexas

**1. Dashboard Executivo:**
```sql
-- Métricas principais do negócio
SELECT 'Total Clientes' AS Metrica, COUNT(*) AS Valor FROM CLIENTE
UNION ALL
SELECT 'Faturamento Total', SUM(Valor_Total) FROM ORDEM_SERVICO WHERE Status = 'Concluída';
```

**2. Análise de Rentabilidade:**
```sql
-- ROI por funcionário
SELECT f.Nome, SUM(i.Subtotal) / f.Salario AS ROI_Funcionario
FROM FUNCIONARIO f
JOIN ITEM_SERVICO i ON f.ID_Funcionario = i.ID_Funcionario
GROUP BY f.ID_Funcionario;
```

**3. Controle de Estoque:**
```sql
-- Peças em estoque crítico
SELECT * FROM vw_controle_estoque 
WHERE Status_Estoque = 'CRÍTICO'
ORDER BY Estoque_Atual;
```

## 🚀 Como Executar

### Passo 1: Criar o Schema
```bash
mysql -u root -p < sql/01-create-schema.sql
```

### Passo 2: Inserir Dados de Teste
```bash
mysql -u root -p oficina_mecanica < sql/02-insert-data.sql
```

### Passo 3: Executar Consultas
```bash
mysql -u root -p oficina_mecanica < sql/03-queries.sql
```

Consulte o arquivo `INSTRUCOES.md` para detalhes completos.

## 📊 Dados de Teste

O sistema inclui dados realistas para teste:
- **10 clientes** com informações completas
- **12 veículos** de marcas variadas
- **8 funcionários** com especialidades
- **17 peças** em estoque
- **10 ordens de serviço** em diferentes status
- **22 consultas** de exemplo prontas

## 🎓 Objetivos Acadêmicos Alcançados

### ✅ Modelagem Conceitual
- Identificação de entidades e relacionamentos
- Definição de cardinalidades
- Normalização até a 3ª forma normal

### ✅ Esquema Lógico
- Criação de tabelas com constraints
- Definição de chaves primárias e estrangeiras
- Implementação de regras de negócio

### ✅ Implementação Física
- Scripts SQL otimizados
- Índices para performance
- Triggers e procedures

### ✅ Consultas Complexas
- Todas as cláusulas solicitadas implementadas
- Relatórios gerenciais funcionais
- Análises de negócio prontas

## 🔮 Próximos Passos

1. **Interface Web** - Desenvolvimento de aplicação web
2. **API REST** - Criação de endpoints
3. **Dashboard BI** - Relatórios visuais
4. **App Mobile** - Aplicativo para funcionários
5. **Integração** - APIs de terceiros

## 🏆 Resultados

Este projeto demonstra o **domínio completo** do ciclo de desenvolvimento de banco de dados:
- **Análise** de requisitos ✅
- **Modelagem** conceitual e lógica ✅
- **Implementação** física ✅
- **Testes** e validação ✅
- **Documentação** completa ✅

---

## �‍💻 Autor

**Leandro da Silva Stampini**
- 💼 LinkedIn: [leandro-da-silva-stampini](https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/)
- 📧 Desenvolvedor de Banco de Dados
- 🎓 Projeto acadêmico - Desafio de Banco de Dados

## �📝 Licença

Este projeto é desenvolvido para **fins educacionais** como parte do desafio do módulo de Banco de Dados.

**Data:** Outubro 2025  
**Status:** ✅ Completo
