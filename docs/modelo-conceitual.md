# Modelo Conceitual - Oficina Mecânica

> **Autor:** Leandro da Silva Stampini  
> **LinkedIn:** [leandro-da-silva-stampini](https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/)  
> **Data:** Outubro 2025

## Visão Geral

O modelo conceitual para a oficina mecânica foi desenvolvido para atender às necessidades de gerenciamento de serviços automotivos, considerando as seguintes funcionalidades principais:

## Entidades Principais

### 1. CLIENTE
- **Descrição**: Representa os proprietários dos veículos atendidos na oficina
- **Atributos**:
  - ID_Cliente (Chave Primária)
  - Nome
  - CPF (Único)
  - Telefone
  - Email
  - Endereço
  - Data_Cadastro

### 2. VEÍCULO
- **Descrição**: Representa os automóveis atendidos na oficina
- **Atributos**:
  - ID_Veiculo (Chave Primária)
  - Placa (Único)
  - Marca
  - Modelo
  - Ano
  - Cor
  - Quilometragem
  - ID_Cliente (Chave Estrangeira)

### 3. FUNCIONÁRIO
- **Descrição**: Representa os funcionários da oficina (mecânicos, técnicos, etc.)
- **Atributos**:
  - ID_Funcionario (Chave Primária)
  - Nome
  - CPF (Único)
  - Cargo
  - Salario
  - Data_Admissao
  - Telefone

### 4. ESPECIALIDADE
- **Descrição**: Representa as áreas de especialização dos funcionários
- **Atributos**:
  - ID_Especialidade (Chave Primária)
  - Nome_Especialidade
  - Descricao

### 5. SERVIÇO
- **Descrição**: Representa os tipos de serviços oferecidos pela oficina
- **Atributos**:
  - ID_Servico (Chave Primária)
  - Nome_Servico
  - Descricao
  - Preco_Base
  - Tempo_Estimado

### 6. ORDEM_SERVICO
- **Descrição**: Representa uma ordem de serviço para um veículo
- **Atributos**:
  - ID_OS (Chave Primária)
  - Data_Abertura
  - Data_Conclusao
  - Status
  - Observacoes
  - Valor_Total
  - ID_Veiculo (Chave Estrangeira)
  - ID_Cliente (Chave Estrangeira)

### 7. ITEM_SERVICO
- **Descrição**: Representa os serviços específicos dentro de uma OS
- **Atributos**:
  - ID_Item (Chave Primária)
  - Quantidade
  - Preco_Unitario
  - Subtotal
  - ID_OS (Chave Estrangeira)
  - ID_Servico (Chave Estrangeira)
  - ID_Funcionario (Chave Estrangeira)

### 8. PEÇA
- **Descrição**: Representa as peças utilizadas nos serviços
- **Atributos**:
  - ID_Peca (Chave Primária)
  - Nome_Peca
  - Descricao
  - Preco_Custo
  - Preco_Venda
  - Estoque_Atual
  - Estoque_Minimo

### 9. FORNECEDOR
- **Descrição**: Representa os fornecedores de peças
- **Atributos**:
  - ID_Fornecedor (Chave Primária)
  - Nome_Empresa
  - CNPJ (Único)
  - Telefone
  - Email
  - Endereco

### 10. ITEM_PECA
- **Descrição**: Representa as peças utilizadas em cada item de serviço
- **Atributos**:
  - ID_Item_Peca (Chave Primária)
  - Quantidade_Utilizada
  - ID_Item (Chave Estrangeira)
  - ID_Peca (Chave Estrangeira)

## Relacionamentos

### 1. CLIENTE possui VEÍCULO (1:N)
- Um cliente pode ter vários veículos
- Um veículo pertence a apenas um cliente

### 2. FUNCIONÁRIO possui ESPECIALIDADE (N:M)
- Um funcionário pode ter várias especialidades
- Uma especialidade pode ser de vários funcionários
- Tabela associativa: FUNCIONARIO_ESPECIALIDADE

### 3. VEÍCULO gera ORDEM_SERVICO (1:N)
- Um veículo pode ter várias ordens de serviço
- Uma ordem de serviço é para um veículo específico

### 4. ORDEM_SERVICO contém ITEM_SERVICO (1:N)
- Uma OS pode ter vários itens de serviço
- Um item de serviço pertence a uma OS específica

### 5. SERVIÇO está em ITEM_SERVICO (1:N)
- Um serviço pode estar em vários itens
- Um item de serviço refere-se a um serviço específico

### 6. FUNCIONÁRIO executa ITEM_SERVICO (1:N)
- Um funcionário pode executar vários itens de serviço
- Um item de serviço é executado por um funcionário específico

### 7. ITEM_SERVICO utiliza PEÇA (N:M)
- Um item de serviço pode utilizar várias peças
- Uma peça pode ser utilizada em vários itens de serviço
- Tabela associativa: ITEM_PECA

### 8. FORNECEDOR fornece PEÇA (1:N)
- Um fornecedor pode fornecer várias peças
- Uma peça é fornecida por um fornecedor específico

## Regras de Negócio

1. Todo veículo deve ter um proprietário (cliente)
2. Uma ordem de serviço só pode ser criada para um veículo cadastrado
3. Um item de serviço deve ter pelo menos um funcionário responsável
4. O valor total da OS é calculado pela soma dos subtotais dos itens
5. O estoque de peças deve ser atualizado quando utilizado em serviços
6. Funcionários só podem executar serviços de suas especialidades
7. Uma OS só pode ser fechada quando todos os itens estiverem concluídos

## Considerações de Design

- Utilização de chaves primárias artificiais (IDs) para melhor performance
- Campos de auditoria (datas de criação/modificação) em entidades principais
- Separação entre dados do cliente e do veículo para flexibilidade
- Controle de estoque integrado ao sistema de serviços
- Rastreabilidade completa dos serviços executados
