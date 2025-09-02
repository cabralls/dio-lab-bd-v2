-- ==========================================
-- Script SQL para o banco de dados da Oficina
-- ==========================================

-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS OficinaDB;
USE OficinaDB;

-- ================================
-- Tabelas
-- ================================

-- Tabela de Clientes
CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100)
);

-- Tabela de Veículos
CREATE TABLE Veiculo (
    ID_Veiculo INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Ano INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela de Funcionários
CREATE TABLE Funcionario (
    ID_Funcionario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50),
    Salario DECIMAL(10,2)
);

-- Tabela de Peças
CREATE TABLE Peca (
    ID_Peca INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Preco DECIMAL(10,2)
);

-- Tabela de Serviços
CREATE TABLE Servico (
    ID_Servico INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Preco DECIMAL(10,2)
);

-- Tabela de Ordem de Serviço
CREATE TABLE OrdemServico (
    ID_Ordem INT AUTO_INCREMENT PRIMARY KEY,
    ID_Veiculo INT NOT NULL,
    ID_Funcionario INT NOT NULL,
    DataServico DATE NOT NULL,
    FOREIGN KEY (ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionario(ID_Funcionario)
);

-- Tabela intermediária para Peças usadas em cada Ordem
CREATE TABLE OrdemPeca (
    ID_Ordem INT NOT NULL,
    ID_Peca INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY(ID_Ordem, ID_Peca),
    FOREIGN KEY (ID_Ordem) REFERENCES OrdemServico(ID_Ordem),
    FOREIGN KEY (ID_Peca) REFERENCES Peca(ID_Peca)
);

-- Tabela intermediária para Serviços realizados em cada Ordem
CREATE TABLE OrdemServicoDetalhe (
    ID_Ordem INT NOT NULL,
    ID_Servico INT NOT NULL,
    PRIMARY KEY(ID_Ordem, ID_Servico),
    FOREIGN KEY (ID_Ordem) REFERENCES OrdemServico(ID_Ordem),
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico)
);

-- ================================
-- Inserção de dados de teste
-- ================================

INSERT INTO Cliente (Nome, CPF, Telefone, Email) VALUES
('João Silva','123.456.789-00','11999990000','joao@email.com'),
('Maria Souza','987.654.321-00','11988880000','maria@email.com');

INSERT INTO Veiculo (ID_Cliente, Placa, Modelo, Marca, Ano) VALUES
(1,'ABC-1234','Civic','Honda',2015),
(2,'XYZ-9876','Corolla','Toyota',2018);

INSERT INTO Funcionario (Nome, Cargo, Salario) VALUES
('Carlos Mendes','Mecânico',3000.00),
('Ana Pereira','Eletricista',3500.00);

INSERT INTO Peca (Nome, Preco) VALUES
('Filtro de Óleo',50.00),
('Pastilha de Freio',120.00);

INSERT INTO Servico (Descricao, Preco) VALUES
('Troca de Óleo',100.00),
('Troca de Pastilha de Freio',200.00);

INSERT INTO OrdemServico (ID_Veiculo, ID_Funcionario, DataServico) VALUES
(1,1,'2025-09-01'),
(2,2,'2025-09-02');

INSERT INTO OrdemPeca (ID_Ordem, ID_Peca, Quantidade) VALUES
(1,1,1),
(2,2,2);

INSERT INTO OrdemServicoDetalhe (ID_Ordem, ID_Servico) VALUES
(1,1),
(2,2);

-- ================================
-- Queries de exemplo
-- ================================

-- 1. Recuperação simples
SELECT * FROM Cliente;

-- 2. Filtro com WHERE
SELECT Nome, Placa FROM Veiculo WHERE Ano > 2016;

-- 3. Atributo derivado (valor total de peças por ordem)
SELECT o.ID_Ordem, SUM(p.Preco * op.Quantidade) AS ValorTotalPecas
FROM OrdemPeca op
JOIN Peca p ON op.ID_Peca = p.ID_Peca
JOIN OrdemServico o ON o.ID_Ordem = op.ID_Ordem
GROUP BY o.ID_Ordem;

-- 4. Ordenação dos dados
SELECT Nome, Salario FROM Funcionario ORDER BY Salario DESC;

-- 5. Condições de filtros em grupo com HAVING
SELECT ID_Veiculo, COUNT(*) AS TotalServicos
FROM OrdemServico
GROUP BY ID_Veiculo
HAVING COUNT(*) > 0;

-- 6. Junções complexas
SELECT c.Nome AS Cliente, v.Modelo, v.Marca, f.Nome AS Funcionario, s.Descricao AS Servico, os.DataServico
FROM OrdemServico os
JOIN Veiculo v ON os.ID_Veiculo = v.ID_Veiculo
JOIN Cliente c ON v.ID_Cliente = c.ID_Cliente
JOIN Funcionario f ON os.ID_Funcionario = f.ID_Funcionario
JOIN OrdemServicoDetalhe osd ON os.ID_Ordem = osd.ID_Ordem
JOIN Servico s ON osd.ID_Servico = s.ID_Servico
ORDER BY os.DataServico DESC;
