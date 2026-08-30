# Sistema Helpdesk

Sistema de gerenciamento de chamados de suporte técnico desenvolvido como projeto final da disciplina de Banco de Dados I. O projeto utiliza MySQL para armazenamento dos dados e Python para realizar a conexão e as operações no banco.

## Equipe

* Adna Cecília
* Fernando Carvalho
* Mário Rocha
* Nathiara Santos
* Saul

## Tema escolhido

O tema escolhido foi **Central de Chamados de Suporte Técnico (Helpdesk)**.

O sistema foi desenvolvido para representar o atendimento de problemas relacionados a equipamentos de informática dentro de uma empresa. Os funcionários podem ter chamados registrados para seus equipamentos, enquanto os técnicos realizam acompanhamentos e atualizam o andamento dos chamados.

O objetivo é manter organizadas as informações dos funcionários, equipamentos, técnicos, chamados e acompanhamentos realizados durante o atendimento.

## Modelagem do banco

O banco de dados possui cinco entidades:

* **Funcionarios:** armazena os funcionários que podem abrir chamados.
* **equipamentos:** armazena os equipamentos utilizados na empresa.
* **tecnicos:** armazena os técnicos responsáveis pelo suporte.
* **chamados:** armazena os chamados registrados pelos funcionários.
* **acompanhamento_chamados:** registra os acompanhamentos realizados pelos técnicos.

Existe um relacionamento 1:N entre funcionários e chamados, pois um funcionário pode possuir vários chamados.

Também existe um relacionamento 1:N entre equipamentos e chamados, pois um equipamento pode estar relacionado a vários chamados ao longo do tempo.

O relacionamento entre técnicos e chamados é N:N. Para resolver esse relacionamento foi criada a entidade **acompanhamento_chamados**, que possui uma chave primária própria (`id_Acompanhamento`) e armazena informações como data, descrição e status do acompanhamento.

A estrutura foi organizada buscando manter a normalização das tabelas, evitando informações repetidas e dependências desnecessárias entre os dados.

## DER

O modelo foi desenvolvido utilizando a notação **Crow's Foot (Pé de Galinha)**.

![DER do projeto](der/der_helpdesk.png)

## Banco de dados

O banco foi desenvolvido em MySQL e possui as tabelas necessárias para o funcionamento do sistema.

O arquivo `sql/schema.sql` contém:

* criação do banco de dados;
* criação das tabelas;
* chaves primárias e estrangeiras;
* restrições `NOT NULL`, `UNIQUE` e `CHECK`;
* inserção dos dados utilizados nos testes.

## Aplicação Python

A aplicação foi desenvolvida em Python utilizando o `mysql-connector-python`.

O sistema possui um menu no terminal com as seguintes opções:

1. Listar todos os chamados;
2. Listar chamados abertos;
3. Listar chamados com funcionário e equipamento;
4. Abrir novo chamado;
5. Atualizar chamado;
6. Remover chamado;
7. Sair.

As consultas utilizam `SELECT`, incluindo consultas com `WHERE` e `JOIN`. As operações de inserção, atualização e remoção utilizam parâmetros (`%s`) para enviar os valores ao banco.

Também foi utilizado tratamento de erros com `try/except/finally`, com fechamento do cursor e da conexão ao final da execução.

## Como executar

### Pré-requisitos

* Python 3.8 ou superior;
* MySQL Server;
* mysql-connector-python.

### Instalação do conector

```bash
pip install mysql-connector-python
```

### Criar o banco

Execute o arquivo:

```text
sql/schema.sql
```

no MySQL Workbench.

### Executar a aplicação

Na pasta do projeto, execute:

```bash
python python/helpdesk_app.py
```

## Estrutura do projeto

```text
BD_IFCE_MPE/
├── README.md
├── .gitignore
├── sql/
│   └── schema.sql
├── python/
│   └── helpdesk_app.py
├── der/
│   └── der_helpdesk.png
├── SUPORTE TECNICO - BDTF.mwb
└── Scheme Helpdesk.mwb
```
