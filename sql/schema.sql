CREATE DATABASE helpdesk;
USE helpdesk;

CREATE TABLE tecnicos (
    id_Tecnicos INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    Funcao VARCHAR(50) NOT NULL
);

CREATE TABLE Funcionarios (
    id_Funcionarios INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Departamento VARCHAR(100) NOT NULL
);

CREATE TABLE equipamentos (
    id_Equipamento INT AUTO_INCREMENT PRIMARY KEY,
    patrimonio INT NOT NULL UNIQUE,
    tipo VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    numero_serie VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE chamados (
    Id_Chamado INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    status VARCHAR(20) NOT NULL,
    prioridade INT NOT NULL,
    data_abertura DATE NOT NULL,
    data_fechamento DATE NULL,

    Funcionarios_id_Funcionarios INT NOT NULL,
    equipamentos_id_Equipamento INT NOT NULL,

    CONSTRAINT fk_chamado_funcionario
        FOREIGN KEY (Funcionarios_id_Funcionarios)
        REFERENCES Funcionarios(id_Funcionarios),

    CONSTRAINT fk_chamado_equipamento
        FOREIGN KEY (equipamentos_id_Equipamento)
        REFERENCES equipamentos(id_Equipamento),

    CONSTRAINT chk_prioridade
        CHECK (prioridade BETWEEN 1 AND 4)
);

CREATE TABLE acompanhamento_chamados (
    id_Acompanhamento INT AUTO_INCREMENT PRIMARY KEY,
    chamados_Id_Chamado INT NOT NULL,
    tecnicos_id_Tecnicos INT NOT NULL,
    Data_Hora DATETIME NOT NULL,
    Descricao VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL,

    CONSTRAINT fk_acompanhamento_chamado
        FOREIGN KEY (chamados_Id_Chamado)
        REFERENCES chamados(Id_Chamado),

    CONSTRAINT fk_acompanhamento_tecnico
        FOREIGN KEY (tecnicos_id_Tecnicos)
        REFERENCES tecnicos(id_Tecnicos)
);

USE helpdesk;

INSERT INTO tecnicos (Nome, email, Funcao) VALUES
('Carlos Mendes', 'carlos.mendes@empresa.com', 'Analista de Suporte'),
('Juliana Alves', 'juliana.alves@empresa.com', 'Analista de Redes'),
('Rafael Souza', 'rafael.souza@empresa.com', 'Técnico de Informática'),
('Marina Costa', 'marina.costa@empresa.com', 'Analista de Sistemas'),
('Lucas Ferreira', 'lucas.ferreira@empresa.com', 'Técnico de Suporte'),
('Amanda Lima', 'amanda.lima@empresa.com', 'Analista de Suporte'),
('Pedro Santos', 'pedro.santos@empresa.com', 'Administrador de Redes'),
('Beatriz Oliveira', 'beatriz.oliveira@empresa.com', 'Técnica de Informática'),
('Diego Rocha', 'diego.rocha@empresa.com', 'Analista de Suporte'),
('Camila Martins', 'camila.martins@empresa.com', 'Analista de Sistemas');

INSERT INTO Funcionarios (Nome, Email, Departamento) VALUES
('Ana Silva', 'ana.silva@empresa.com', 'Recursos Humanos'),
('Bruno Oliveira', 'bruno.oliveira@empresa.com', 'Financeiro'),
('Carla Mendes', 'carla.mendes@empresa.com', 'Marketing'),
('Daniel Souza', 'daniel.souza@empresa.com', 'Administrativo'),
('Eduarda Costa', 'eduarda.costa@empresa.com', 'Recursos Humanos'),
('Felipe Santos', 'felipe.santos@empresa.com', 'Financeiro'),
('Gabriela Lima', 'gabriela.lima@empresa.com', 'Marketing'),
('Henrique Alves', 'henrique.alves@empresa.com', 'Vendas'),
('Isabela Rocha', 'isabela.rocha@empresa.com', 'Administrativo'),
('João Martins', 'joao.martins@empresa.com', 'Vendas'),
('Larissa Ferreira', 'larissa.ferreira@empresa.com', 'Financeiro'),
('Marcelo Gomes', 'marcelo.gomes@empresa.com', 'Marketing');

INSERT INTO equipamentos
(patrimonio, tipo, modelo, numero_serie) VALUES
(1001, 'Notebook', 'Dell Inspiron 15', 'SN-DELL-001'),
(1002, 'Notebook', 'Lenovo ThinkPad E14', 'SN-LEN-002'),
(1003, 'Desktop', 'Dell OptiPlex 3080', 'SN-DELL-003'),
(1004, 'Monitor', 'Samsung 24', 'SN-SAM-004'),
(1005, 'Notebook', 'Acer Aspire 5', 'SN-ACE-005'),
(1006, 'Desktop', 'HP ProDesk 400', 'SN-HP-006'),
(1007, 'Impressora', 'HP LaserJet Pro', 'SN-HP-007'),
(1008, 'Notebook', 'Dell Latitude 5420', 'SN-DELL-008'),
(1009, 'Monitor', 'LG UltraWide', 'SN-LG-009'),
(1010, 'Desktop', 'Lenovo ThinkCentre', 'SN-LEN-010'),
(1011, 'Notebook', 'Samsung Book', 'SN-SAM-011'),
(1012, 'Impressora', 'Epson EcoTank', 'SN-EPS-012');

INSERT INTO chamados
(titulo, descricao, status, prioridade, data_abertura,
data_fechamento, Funcionarios_id_Funcionarios,
equipamentos_id_Equipamento)
VALUES
('Notebook não liga',
 'Equipamento não apresenta sinal de energia.',
 'Aberto', 4, '2026-08-20', NULL, 1, 1),

('Internet lenta',
 'Acesso à internet apresenta lentidão.',
 'Em andamento', 3, '2026-08-20', NULL, 2, 2),

('Monitor sem imagem',
 'Monitor liga mas não apresenta imagem.',
 'Concluído', 2, '2026-08-21', '2026-08-21', 3, 4),

('Sistema travando',
 'Computador apresenta travamentos frequentes.',
 'Aberto', 3, '2026-08-21', NULL, 4, 3),

('Impressora não imprime',
 'Impressora não está realizando impressões.',
 'Em andamento', 3, '2026-08-22', NULL, 5, 7),

('Teclado com defeito',
 'Algumas teclas não estão funcionando.',
 'Concluído', 2, '2026-08-22', '2026-08-23', 6, 5),

('Tela azul',
 'Notebook apresenta erro de tela azul.',
 'Aberto', 4, '2026-08-23', NULL, 7, 8),

('Computador lento',
 'Sistema operacional apresenta lentidão.',
 'Em andamento', 2, '2026-08-24', NULL, 8, 6),

('Problema no Wi-Fi',
 'Notebook não consegue conectar à rede sem fio.',
 'Concluído', 3, '2026-08-24', '2026-08-25', 9, 11),

('Mouse não funciona',
 'Mouse deixou de responder aos comandos.',
 'Concluído', 1, '2026-08-25', '2026-08-25', 10, 10),

('Sistema sem acesso',
 'Funcionário não consegue acessar o sistema interno.',
 'Aberto', 4, '2026-08-26', NULL, 11, 12),

('Impressão com falhas',
 'Documento apresenta falhas durante impressão.',
 'Em andamento', 2, '2026-08-26', NULL, 12, 7);
 
SELECT * FROM tecnicos;
SELECT * FROM Funcionarios;
SELECT * FROM equipamentos;
SELECT * FROM chamados;
SELECT * FROM acompanhamento_chamados;