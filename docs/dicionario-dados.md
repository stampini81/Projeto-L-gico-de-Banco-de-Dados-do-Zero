# Dicionário de Dados - Oficina Mecânica

> **Autor:** Leandro da Silva Stampini  
> **LinkedIn:** [leandro-da-silva-stampini](https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/)  
> **Data:** Outubro 2025

## Tabela: CLIENTE

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Cliente | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único do cliente |
| Nome | VARCHAR | 100 | NÃO | - | - | Nome completo do cliente |
| CPF | VARCHAR | 11 | NÃO | UK | - | CPF do cliente (apenas números) |
| Telefone | VARCHAR | 15 | SIM | - | - | Telefone de contato |
| Email | VARCHAR | 100 | SIM | - | - | Email do cliente |
| Endereco | VARCHAR | 200 | SIM | - | - | Endereço completo |
| Data_Cadastro | DATETIME | - | SIM | - | CURRENT_TIMESTAMP | Data de cadastro do cliente |

## Tabela: VEICULO

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Veiculo | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único do veículo |
| Placa | VARCHAR | 8 | NÃO | UK | - | Placa do veículo |
| Marca | VARCHAR | 50 | NÃO | - | - | Marca do veículo |
| Modelo | VARCHAR | 50 | NÃO | - | - | Modelo do veículo |
| Ano | INT | - | NÃO | - | - | Ano de fabricação |
| Cor | VARCHAR | 30 | SIM | - | - | Cor do veículo |
| Quilometragem | INT | - | SIM | - | 0 | Quilometragem atual |
| ID_Cliente | INT | - | NÃO | FK | - | Referência ao proprietário |

## Tabela: FUNCIONARIO

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Funcionario | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único do funcionário |
| Nome | VARCHAR | 100 | NÃO | - | - | Nome completo do funcionário |
| CPF | VARCHAR | 11 | NÃO | UK | - | CPF do funcionário |
| Cargo | VARCHAR | 50 | NÃO | - | - | Cargo/função do funcionário |
| Salario | DECIMAL | 10,2 | SIM | - | - | Salário do funcionário |
| Data_Admissao | DATE | - | NÃO | - | - | Data de admissão |
| Telefone | VARCHAR | 15 | SIM | - | - | Telefone de contato |

## Tabela: ESPECIALIDADE

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Especialidade | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único da especialidade |
| Nome_Especialidade | VARCHAR | 100 | NÃO | - | - | Nome da especialidade |
| Descricao | TEXT | - | SIM | - | - | Descrição detalhada |

## Tabela: FUNCIONARIO_ESPECIALIDADE

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Funcionario | INT | - | NÃO | PK/FK | - | Referência ao funcionário |
| ID_Especialidade | INT | - | NÃO | PK/FK | - | Referência à especialidade |
| Data_Certificacao | DATE | - | SIM | - | - | Data da certificação |
| Nivel_Experiencia | ENUM | - | SIM | - | - | Nível: Iniciante, Intermediário, Avançado |

## Tabela: SERVICO

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Servico | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único do serviço |
| Nome_Servico | VARCHAR | 100 | NÃO | - | - | Nome do serviço |
| Descricao | TEXT | - | SIM | - | - | Descrição do serviço |
| Preco_Base | DECIMAL | 10,2 | NÃO | - | - | Preço base do serviço |
| Tempo_Estimado | INT | - | SIM | - | - | Tempo estimado em minutos |

## Tabela: FORNECEDOR

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Fornecedor | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único do fornecedor |
| Nome_Empresa | VARCHAR | 100 | NÃO | - | - | Nome da empresa |
| CNPJ | VARCHAR | 14 | NÃO | UK | - | CNPJ da empresa |
| Telefone | VARCHAR | 15 | SIM | - | - | Telefone de contato |
| Email | VARCHAR | 100 | SIM | - | - | Email da empresa |
| Endereco | VARCHAR | 200 | SIM | - | - | Endereço da empresa |

## Tabela: PECA

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Peca | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único da peça |
| Nome_Peca | VARCHAR | 100 | NÃO | - | - | Nome da peça |
| Descricao | TEXT | - | SIM | - | - | Descrição da peça |
| Preco_Custo | DECIMAL | 10,2 | NÃO | - | - | Preço de custo |
| Preco_Venda | DECIMAL | 10,2 | NÃO | - | - | Preço de venda |
| Estoque_Atual | INT | - | SIM | - | 0 | Quantidade em estoque |
| Estoque_Minimo | INT | - | SIM | - | 0 | Estoque mínimo |
| ID_Fornecedor | INT | - | SIM | FK | - | Referência ao fornecedor |

## Tabela: ORDEM_SERVICO

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_OS | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único da OS |
| Data_Abertura | DATETIME | - | SIM | - | CURRENT_TIMESTAMP | Data de abertura |
| Data_Conclusao | DATETIME | - | SIM | - | - | Data de conclusão |
| Status | ENUM | - | SIM | - | 'Aberta' | Status: Aberta, Em Andamento, Concluída, Cancelada |
| Observacoes | TEXT | - | SIM | - | - | Observações gerais |
| Valor_Total | DECIMAL | 10,2 | SIM | - | 0 | Valor total da OS |
| ID_Veiculo | INT | - | NÃO | FK | - | Referência ao veículo |
| ID_Cliente | INT | - | NÃO | FK | - | Referência ao cliente |

## Tabela: ITEM_SERVICO

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Item | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único do item |
| Quantidade | INT | - | SIM | - | 1 | Quantidade do serviço |
| Preco_Unitario | DECIMAL | 10,2 | NÃO | - | - | Preço unitário |
| Subtotal | DECIMAL | 10,2 | NÃO | - | - | Subtotal do item |
| Status_Item | ENUM | - | SIM | - | 'Pendente' | Status: Pendente, Em Execução, Concluído |
| Data_Inicio | DATETIME | - | SIM | - | - | Data de início |
| Data_Fim | DATETIME | - | SIM | - | - | Data de conclusão |
| ID_OS | INT | - | NÃO | FK | - | Referência à OS |
| ID_Servico | INT | - | NÃO | FK | - | Referência ao serviço |
| ID_Funcionario | INT | - | NÃO | FK | - | Referência ao funcionário |

## Tabela: ITEM_PECA

| Campo | Tipo | Tamanho | Nulo | Chave | Default | Descrição |
|-------|------|---------|------|-------|---------|-----------|
| ID_Item_Peca | INT | - | NÃO | PK | AUTO_INCREMENT | Identificador único |
| Quantidade_Utilizada | INT | - | NÃO | - | - | Quantidade utilizada |
| Preco_Unitario_Peca | DECIMAL | 10,2 | NÃO | - | - | Preço unitário da peça |
| Subtotal_Peca | DECIMAL | 10,2 | NÃO | - | - | Subtotal das peças |
| ID_Item | INT | - | NÃO | FK | - | Referência ao item de serviço |
| ID_Peca | INT | - | NÃO | FK | - | Referência à peça |

## Convenções Utilizadas

### Nomenclatura
- **Tabelas**: MAIÚSCULAS com underscore para separar palavras
- **Campos**: CamelCase com primeira letra maiúscula
- **Chaves Primárias**: ID_NomeTabela
- **Chaves Estrangeiras**: Mesmo nome da chave primária referenciada

### Tipos de Dados
- **INT**: Números inteiros
- **VARCHAR(n)**: Texto variável com tamanho máximo n
- **TEXT**: Texto longo sem limite específico
- **DECIMAL(m,n)**: Números decimais com m dígitos totais e n decimais
- **DATE**: Data no formato YYYY-MM-DD
- **DATETIME**: Data e hora no formato YYYY-MM-DD HH:MM:SS
- **ENUM**: Lista de valores predefinidos

### Constraints
- **PK**: Primary Key (Chave Primária)
- **FK**: Foreign Key (Chave Estrangeira)
- **UK**: Unique Key (Chave Única)
- **NOT NULL**: Campo obrigatório
- **DEFAULT**: Valor padrão

### Domínios de Dados

#### Status da Ordem de Serviço
- **Aberta**: OS criada, aguardando início
- **Em Andamento**: Pelo menos um item em execução
- **Concluída**: Todos os itens concluídos
- **Cancelada**: OS cancelada

#### Status do Item de Serviço
- **Pendente**: Item não iniciado
- **Em Execução**: Item sendo executado
- **Concluído**: Item finalizado

#### Nível de Experiência
- **Iniciante**: 0-2 anos de experiência
- **Intermediário**: 2-5 anos de experiência
- **Avançado**: Mais de 5 anos de experiência
