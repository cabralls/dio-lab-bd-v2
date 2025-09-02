# Projeto Banco de Dados - Oficina Mecânica - Wagner Cabral

## Descrição do Projeto
Este projeto tem como objetivo criar um **banco de dados para uma oficina mecânica** utilizando o modelo relacional, seguindo as etapas de modelagem conceitual (ER) e lógica. 

O banco de dados permite gerenciar:
- Clientes e seus veículos;
- Funcionários e cargos;
- Peças e serviços disponíveis;
- Ordens de serviço, relacionando veículos, funcionários, peças e serviços.

O projeto foi implementado em **MySQL** e inclui:
- Criação das tabelas com relacionamentos e integridade referencial;
- Inserção de dados de teste;
- Queries de recuperação simples e complexas;
- Filtros, ordenações, atributos derivados e junções entre tabelas.

## Estrutura das Tabelas

- **Cliente**: Armazena informações de clientes da oficina.
- **Veiculo**: Veículos de cada cliente.
- **Funcionario**: Funcionários da oficina.
- **Peca**: Peças utilizadas nos serviços.
- **Servico**: Tipos de serviços oferecidos.
- **OrdemServico**: Registro das ordens de serviço realizadas.
- **OrdemPeca**: Peças utilizadas em cada ordem.
- **OrdemServicoDetalhe**: Serviços realizados em cada ordem.

## Queries de Exemplo

1. Seleção simples:

SELECT * FROM Cliente;
