/*CREATE DATABASE db_concessionaria;
USE db_concessionaria;
DROP DATABASE db_concessionaria;
-- 2

-- 10

CREATE TABLE tb_cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE tb_telefone_cliente (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    telefone VARCHAR(15) NOT NULL,
    tipo VARCHAR(50), 
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
    -- Ex.: Residencial, Comercial, Celular   
);

CREATE TABLE tb_endereco_cliente (
	id_endereco_cliente INT PRIMARY KEY,
    id_cliente INT,
    rua VARCHAR (50),
    numero VARCHAR (10),
    complemento VARCHAR(100),
    bairro VARCHAR(500),
    cidade VARCHAR(100),
    estado CHAR(2),
    CEP CHAR(9),
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
);
DESC tb_cliente;
-- 7

-- 11
CREATE TABLE tb_fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL,  
    email VARCHAR(100)
);
CREATE TABLE tb_telefone_fornecedor (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    id_fornecedor INT,
    telefone VARCHAR(15) NOT NULL,
    tipo VARCHAR(50), 
    FOREIGN KEY (id_fornecedor) REFERENCES tb_fornecedor(id_fornecedor)-- Ex.: Comercial, Celular
    
);
-- 13
CREATE TABLE tb_endereco_fornecedor(
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    id_fornecedor INT,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(100),
    estado VARCHAR(50),
    cep VARCHAR(10),
    tipo VARCHAR(50),
    FOREIGN KEY (id_fornecedor) REFERENCES tb_fornecedor(id_fornecedor)-- Ex.: Matriz, Filial
    
);
-- 9

-- 14
CREATE TABLE tb_setor (
    id_setor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE tb_filial (
    id_filial INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    gerente VARCHAR(100)
    
);

CREATE TABLE tb_telefone_filial (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    id_filial INT,
    telefone VARCHAR(15) NOT NULL,
    tipo ENUM('Comercial', 'Suporte', 'Atendimento'),
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)-- Exemplo: Comercial, Suporte, etc.
    
);
-- 15
CREATE TABLE tb_endereco_filial (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    id_filial INT,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(100),
    estado VARCHAR(50),
    cep VARCHAR(10),
    tipo VARCHAR(50),
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)-- Exemplo: Principal, Filial, Armazém, etc.
   
);
-- 1

/*ALTER TABLE tb_filial
ADD COLUMN gerente_responsavel INT,
ADD CONSTRAINT fk_gerente_responsavel FOREIGN KEY (gerente_responsavel) REFERENCES tb_funcionario(id_funcionario);


DROP TABLE tb_filial;
DROP TABLE tb_funcionario;
DESC tb_filial;
SHOW tables;
-- 3
CREATE TABLE tb_funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2),
    data_admissao DATE,
    id_filial INT,
    id_setor INT,
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial),
    FOREIGN KEY (id_setor) REFERENCES tb_setor(id_setor)
);
--
-- Adicionar a chave estrangeira após as tabelas estarem criadas
CREATE TABLE tb_estoque_veiculo (
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(25) NOT NULL,
    marca VARCHAR(25) NOT NULL,
    ano CHAR(4),
    cor VARCHAR(15),
    preco DECIMAL(10, 2),
    id_filial INT,
    quantidade INT DEFAULT 0,
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)
);

CREATE TABLE tb_cadastro_veiculo (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(100) NOT NULL,
    ano INT,
    placa CHAR(7),
    cor VARCHAR(50),
    id_cliente INT,
    id_filial INT,
    quantidade INT DEFAULT 0,
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial),
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
);
-- 5
CREATE TABLE tb_estoque_peca (
    id_peca INT  PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    fabricante VARCHAR(100),
    preco DECIMAL(10, 2),
    id_filial INT,
    quantidade INT DEFAULT 0,
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)
);

-- 8
CREATE TABLE tb_servico_prestado (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    id_veiculo INT,
    id_funcionario INT,
    id_cliente INT,
    id_filial INT,
    tipo_servico ENUM('Manutenção', 'Vistoria', 'Limpeza'),
    data_servico DATETIME,
    valor DECIMAL(10, 2),
    FOREIGN KEY (id_veiculo) REFERENCES tb_cadastro_veiculo(id_veiculo),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario(id_funcionario),
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente),
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)
);
-- 6
CREATE TABLE tb_venda_veiculo (
    id_venda_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    id_veiculo INT,
    id_funcionario INT,
    id_filial INT,
    id_cliente INT,
    data_venda DATETIME,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_veiculo) REFERENCES tb_estoque_veiculo(id_estoque),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario(id_funcionario),
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)
);
CREATE TABLE tb_venda_peca(
    id_venda_peca INT PRIMARY KEY AUTO_INCREMENT,
    id_peca INT,
    id_funcionario INT,
    id_filial INT,
    id_cliente INT,
    data_venda DATETIME,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_peca) REFERENCES tb_estoque_peca(id_peca),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario(id_funcionario),
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)
);

CREATE TABLE tb_auditoria(
	id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_funcionario INT,
    id_venda_peca INT,
	id_venda_veiculo INT,
    id_servico INT,
    id_filial INT,
    data_registro DATETIME,
    FOREIGN KEY (id_cliente)   REFERENCES tb_cliente (id_cliente),
    FOREIGN KEY (id_funcionario)   REFERENCES tb_funcionario (id_funcionario),
    FOREIGN KEY (id_venda_peca)   REFERENCES tb_venda_peca (id_venda_peca),
    FOREIGN KEY (id_venda_veiculo)    REFERENCES tb_venda_veiculo  (id_venda_veiculo),
    FOREIGN KEY (id_servico)   REFERENCES tb_servico_prestado(id_servico),
    FOREIGN KEY (id_filial)   REFERENCES tb_filial (id_filial)
    
);


SELECT * FROM tb_cliente;

-- Query para saber o numero de tabelas existentes em um banco de dados.
SELECT COUNT(*) 
AS numero_de_tabelas
FROM information_schema.tables 
WHERE table_schema = 'db_concessionaria';

INSERT INTO tb_cliente (nome, cpf, email) VALUES
('Maria Silva', '12345678901', 'maria.silva@example.com'),
('João Santos', '23456789012', 'joao.santos@example.com'),
('Ana Pereira', '34567890123', 'ana.pereira@example.com'),
('Carlos Lima', '45678901234', 'carlos.lima@example.com'),
('Beatriz Almeida', '56789012345', 'beatriz.almeida@example.com'),
('Fernanda Costa', '67890123456', 'fernanda.costa@example.com'),
('Rafael Rocha', '78901234567', 'rafael.rocha@example.com'),
('Juliana Melo', '89012345678', 'juliana.melo@example.com'),
('Gabriel Oliveira', '90123456789', 'gabriel.oliveira@example.com'),
('Patrícia Souza', '01234567890', 'patricia.souza@example.com'),
('Lucas Moreira', '11122233344', 'lucas.moreira@example.com'),
('Sofia Ribeiro', '22233344455', 'sofia.ribeiro@example.com'),
('Miguel Ferreira', '33344455566', 'miguel.ferreira@example.com'),
('Lara Azevedo', '44455566677', 'lara.azevedo@example.com'),
('Daniel Alves', '55566677788', 'daniel.alves@example.com'),
('Camila Pinto', '66677788899', 'camila.pinto@example.com'),
('Matheus Martins', '77788899900', 'matheus.martins@example.com'),
('Larissa Gomes', '88899900011', 'larissa.gomes@example.com'),
('André Oliveira', '99900011122', 'andre.oliveira@example.com'),
('Amanda Dias', '00011122233', 'amanda.dias@example.com'),
('Rodrigo Cardoso', '01020304050', 'rodrigo.cardoso@example.com'),
('Juliana Lima', '02030405060', 'juliana.lima@example.com'),
('Thiago Castro', '03040506070', 'thiago.castro@example.com'),
('Bárbara Souza', '04050607080', 'barbara.souza@example.com'),
('Rafael Nunes', '05060708090', 'rafael.nunes@example.com'),
('Isabela Teixeira', '06070809010', 'isabela.teixeira@example.com'),
('Felipe Mendes', '07080901020', 'felipe.mendes@example.com'),
('Gabriela Batista', '08091002030', 'gabriela.batista@example.com'),
('Leandro Torres', '09102030405', 'leandro.torres@example.com'),
('Mariana Lima', '10203040506', 'mariana.lima@example.com'),
('José Carvalho', '20304050607', 'jose.carvalho@example.com'),
('Renata Silva', '30405060708', 'renata.silva@example.com'),
('Diego Borges', '40506070809', 'diego.borges@example.com'),
('Paula Moreira', '50607080910', 'paula.moreira@example.com'),
('Bruno Oliveira', '60708091020', 'bruno.oliveira@example.com'),
('Tatiana Costa', '70809102030', 'tatiana.costa@example.com'),
('Eduardo Campos', '80910203040', 'eduardo.campos@example.com'),
('Alice Almeida', '91020304050', 'alice.almeida@example.com'),
('Caio Fernandes', '45678896', 'caio.fernandes@example.com'),
('Renata Matos', '10203040507', 'renata.matos@example.com');

INSERT INTO tb_telefone_cliente (id_cliente, telefone, tipo) VALUES
(1, '1234-5678', 'Residencial'),
(1, '2345-6789', 'Celular'),
(2, '3456-7890', 'Comercial'),
(3, '4567-8901', 'Residencial'),
(3, '5678-9012', 'Celular'),
(4, '6789-0123', 'Comercial'),
(5, '7890-1234', 'Residencial'),
(6, '8901-2345', 'Celular'),
(7, '9012-3456', 'Comercial'),
(8, '0123-4567', 'Residencial'),
(9, '1324-5768', 'Celular'),
(9, '2435-6879', 'Comercial'),
(10, '3546-7980', 'Residencial'),
(11, '4657-8091', 'Celular'),
(12, '5768-9012', 'Comercial'),
(13, '6879-0123', 'Residencial'),
(14, '7980-1234', 'Celular'),
(15, '8091-2345', 'Comercial'),
(16, '9123-3456', 'Residencial'),
(17, '0234-4567', 'Celular'),
(18, '1345-5678', 'Comercial'),
(18, '2456-6789', 'Residencial'),
(19, '3567-7890', 'Celular'),
(20, '4678-8901', 'Comercial'),
(21, '5789-9012', 'Residencial'),
(22, '6890-0123', 'Celular'),
(23, '7901-1234', 'Comercial'),
(24, '8012-2345', 'Residencial'),
(25, '9123-3456', 'Celular'),
(25, '0234-4567', 'Comercial'),
(26, '1345-5678', 'Residencial'),
(27, '2456-6789', 'Celular'),
(28, '3567-7890', 'Comercial'),
(29, '4678-8901', 'Residencial'),
(30, '5789-9012', 'Celular'),
(31, '6890-0123', 'Comercial'),
(32, '7901-1234', 'Residencial'),
(33, '8012-2345', 'Celular'),
(34, '9123-3456', 'Comercial'),
(35, '0234-4567', 'Residencial'),
(36, '1345-5678', 'Celular'),
(37, '2456-6789', 'Comercial'),
(38, '3567-7890', 'Residencial'),
(39, '4678-8901', 'Celular'),
(40, '5789-9012', 'Comercial');

INSERT INTO tb_endereco_cliente (id_endereco_cliente, id_cliente, rua, numero, complemento, bairro, cidade, estado, CEP) VALUES
(1, 1, 'Rua das Flores', '123', 'Apto 101', 'Jardim Primavera', 'São Paulo', 'SP', '12345-678'),
(2, 2, 'Avenida Paulista', '456', 'Bloco B', 'Bela Vista', 'São Paulo', 'SP', '23456-789'),
(3, 3, 'Rua das Acácias', '789', '', 'Centro', 'Rio de Janeiro', 'RJ', '34567-890'),
(4, 4, 'Praça da Liberdade', '101', 'Casa', 'Liberdade', 'Belo Horizonte', 'MG', '45678-901'),
(5, 5, 'Avenida Atlântica', '202', 'Cobertura', 'Copacabana', 'Rio de Janeiro', 'RJ', '56789-012'),
(6, 6, 'Rua dos Ipês', '303', 'Apto 202', 'Jardim Botânico', 'Curitiba', 'PR', '67890-123'),
(7, 7, 'Rua das Laranjeiras', '404', '', 'Flamengo', 'Rio de Janeiro', 'RJ', '78901-234'),
(8, 8, 'Avenida Goiás', '505', 'Loja 3', 'Setor Central', 'Goiânia', 'GO', '89012-345'),
(9, 9, 'Rua do Comércio', '606', 'Galpão 4', 'Distrito Industrial', 'Manaus', 'AM', '90123-456'),
(10, 10, 'Avenida Ipiranga', '707', '', 'Centro', 'Porto Alegre', 'RS', '01234-567'),
(11, 11, 'Rua das Palmeiras', '808', 'Casa 5', 'Vila Madalena', 'São Paulo', 'SP', '12345-678'),
(12, 12, 'Avenida Brasil', '909', 'Bloco A', 'Centro', 'Brasília', 'DF', '23456-789'),
(13, 13, 'Rua dos Cravos', '1001', '', 'Cidade Jardim', 'São Paulo', 'SP', '34567-890'),
(14, 14, 'Avenida Independência', '1111', 'Apto 303', 'República', 'Porto Alegre', 'RS', '45678-901'),
(15, 15, 'Rua das Orquídeas', '1212', '', 'Zona Sul', 'Salvador', 'BA', '56789-012'),
(16, 16, 'Avenida das Nações', '1313', 'Apto 404', 'Asa Sul', 'Brasília', 'DF', '67890-123'),
(17, 17, 'Rua das Hortênsias', '1414', 'Apto 505', 'Cidade Nova', 'Rio de Janeiro', 'RJ', '78901-234'),
(18, 18, 'Avenida Rio Branco', '1515', '', 'Centro', 'Curitiba', 'PR', '89012-345'),
(19, 19, 'Rua da Paz', '1616', 'Casa', 'Centro', 'Fortaleza', 'CE', '90123-456'),
(20, 20, 'Avenida Santos Dumont', '1717', 'Loja 6', 'Centro', 'Recife', 'PE', '01234-567'),
(21, 21, 'Rua das Azaleias', '1818', '', 'Centro', 'Belo Horizonte', 'MG', '12345-678'),
(22, 22, 'Avenida Boa Viagem', '1919', 'Cobertura', 'Boa Viagem', 'Recife', 'PE', '23456-789'),
(23, 23, 'Rua das Magnólias', '2020', 'Apto 707', 'Bairro Novo', 'Olinda', 'PE', '34567-890'),
(24, 24, 'Avenida Professor Luiz', '2121', '', 'Centro', 'Campinas', 'SP', '45678-901'),
(25, 25, 'Rua do Sol', '2222', 'Casa', 'Centro', 'São Luís', 'MA', '56789-012'),
(26, 26, 'Avenida das Américas', '2323', 'Bloco B', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', '67890-123'),
(27, 27, 'Rua das Bromélias', '2424', 'Apto 909', 'Jardim América', 'Fortaleza', 'CE', '78901-234'),
(28, 28, 'Avenida Presidente Vargas', '2525', '', 'Centro', 'Rio de Janeiro', 'RJ', '89012-345'),
(29, 29, 'Rua da Independência', '2626', '', 'Centro', 'Porto Alegre', 'RS', '90123-456'),
(30, 30, 'Avenida Getúlio Vargas', '2727', 'Cobertura', 'Centro', 'Belém', 'PA', '01234-567'),
(31, 31, 'Rua Sete de Setembro', '2828', 'Apto 606', 'Centro', 'Porto Velho', 'RO', '12345-678'),
(32, 32, 'Avenida Paulista', '2929', 'Apto 1010', 'Bela Vista', 'São Paulo', 'SP', '23456-789'),
(33, 33, 'Rua Quinze de Novembro', '3030', '', 'Centro', 'Manaus', 'AM', '34567-890'),
(34, 34, 'Avenida Raul Lopes', '3131', 'Casa', 'Centro', 'Teresina', 'PI', '45678-901'),
(35, 35, 'Rua Amazonas', '3232', 'Bloco A', 'Centro', 'Belo Horizonte', 'MG', '56789-012'),
(36, 36, 'Avenida Paraná', '3333', 'Apto 808', 'Centro', 'Curitiba', 'PR', '67890-123'),
(37, 37, 'Rua Acre', '3434', '', 'Centro', 'Porto Velho', 'RO', '78901-234'),
(38, 38, 'Avenida Maranhão', '3535', 'Apto 909', 'Centro', 'Teresina', 'PI', '89012-345'),
(39, 39, 'Rua Sergipe', '3636', 'Loja 2', 'Centro', 'Aracaju', 'SE', '90123-456'),
(40, 40, 'Avenida Rio de Janeiro', '3737', 'Galpão 3', 'Centro', 'Rio de Janeiro', 'RJ', '01234-567');

INSERT INTO tb_filial (nome, gerente) VALUES 
('ConfiaCar Porto Alegre', 'Carlos Lima'),
('ConfiaCar Salvador', 'Beatriz Almeida'),
('ConfiaCar Goiás', 'Daniel Alves');

INSERT INTO tb_setor (nome, descricao) VALUES 
('Vendas', 'Responsável pela comercialização de veículos e peças.'),
('Financiamento', 'Cuida das transações financeiras e dos processos de financiamento para clientes.'),
('Estoque de Veiculos', 'Gerencia o inventário de veículos disponíveis para venda.'),
('Estoque de Peças', 'Administra o inventário de peças e componentes para manutenção e reparo.'),
('Oficina', 'Realiza serviços de manutenção e reparo de veículos.');

INSERT INTO tb_funcionario (nome, cpf, cargo, salario, data_admissao, id_filial, id_setor) VALUES 
('Ana Souza', '12345678901', 'Gerente', 8000.00, '2021-01-15', 1, 1),
('Carlos Lima', '23456789012', 'Gerente', 8500.00, '2020-05-20', 1, 2),
('Beatriz Almeida', '34567890123', 'Gerente', 9000.00, '2019-07-10', 2, 3),
('Marcos Pereira', '45678901234', 'Analista', 4500.00, '2022-03-22', 2, 1),
('Fernanda Costa', '56789012345', 'Assistente', 3000.00, '2021-06-15', 3, 1),
('Rafael Rocha', '67890123456', 'Analista', 4700.00, '2020-08-30', 3, 2),
('Juliana Melo', '78901234567', 'Coordenador', 6000.00, '2019-02-25', 3, 3),
('Gabriel Oliveira', '89012345678', 'Estagiário', 1500.00, '2021-11-01', 3, 1),
('Patrícia Souza', '90123456789', 'Coordenador', 6100.00, '2020-09-05', 2, 2),
('Lucas Moreira', '01234567890', 'Analista', 4600.00, '2022-01-15', 2, 3),
('Sofia Ribeiro', '11122233344', 'Assistente', 2800.00, '2021-03-10', 1, 1),
('Miguel Ferreira', '22233344455', 'Analista', 4800.00, '2020-06-20', 1, 2),
('Lara Azevedo', '33344455566', 'Coordenador', 6200.00, '2019-04-18', 3, 3),
('Daniel Alves', '44455566677', 'Estagiário', 1400.00, '2021-08-22', 2, 1),
('Camila Pinto', '55566677788', 'Analista', 4700.00, '2020-10-15', 3, 2),
('Matheus Martins', '66677788899', 'Assistente', 3100.00, '2019-12-05', 2, 3),
('Larissa Gomes', '77788899900', 'Coordenador', 6300.00, '2021-02-25', 1, 1),
('André Oliveira', '88899900011', 'Estagiário', 1500.00, '2020-07-18', 1, 2),
('Amanda Dias', '99900011122', 'Analista', 4900.00, '2021-05-30', 3, 3),
('Rodrigo Cardoso', '00011122233', 'Assistente', 3200.00, '2022-03-12', 2, 1),
('Elon Musk', '98765432101', 'Gerente', 8000.00, '2021-01-15', 1, 1),
('Oprah Winfrey', '87654321012', 'Gerente', 8500.00, '2020-05-20', 1, 2),
('Jeff Bezos', '76543210923', 'Gerente', 9000.00, '2019-07-10', 2, 3),
('Mark Zuckerberg', '65432109834', 'Analista', 4500.00, '2022-03-22', 2, 1),
('Serena Williams', '54321098745', 'Assistente', 3000.00, '2021-06-15', 3, 1),
('Bill Gates', '43210987656', 'Analista', 4700.00, '2020-08-30', 3, 2),
('Taylor Swift', '32109876567', 'Coordenador', 6000.00, '2019-02-25', 2, 3),
('Rihanna Fenty', '21098765478', 'Estagiário', 1500.00, '2021-11-01', 3, 1),
('LeBron James', '10987654389', 'Coordenador', 6100.00, '2020-09-05', 1, 2),
('Emma Watson', '90876543290', 'Analista', 4600.00, '2022-01-15', 2, 3),
('Tom Hanks', '80765432101', 'Assistente', 2800.00, '2021-03-10', 3, 1),
('Beyoncé Knowles', '70654321012', 'Analista', 4800.00, '2020-06-20', 1, 2),
('Chris Hemsworth', '60543210923', 'Coordenador', 6200.00, '2019-04-18', 2, 3),
('Zendaya Coleman', '50432109834', 'Estagiário', 1400.00, '2021-08-22', 3, 1),
('Robert Downey Jr.', '40321098745', 'Analista', 4700.00, '2020-10-15', 1, 2),
('Scarlett Johansson', '30210987656', 'Assistente', 3100.00, '2019-12-05', 1, 3),
('Chris Evans', '20109876567', 'Coordenador', 6300.00, '2021-02-25', 2, 1),
('Tom Holland', '10098765478', 'Estagiário', 1500.00, '2020-07-18', 3, 2),
('Gal Gadot', '99087654389', 'Analista', 4900.00, '2021-05-30', 1, 3),
('Henry Cavill', '88076543290', 'Assistente', 3200.00, '2022-03-12', 2, 1),
('Morgan Freeman', '77065432101', 'Gerente', 8800.00, '2018-07-19', 1, 2);



INSERT INTO tb_estoque_peca (descricao, fabricante, preco, id_filial, quantidade) VALUES
('Filtro de Óleo', 'Bosch', 45.50, 1, 15),
('Pneu 175/65 R14', 'Michelin', 320.00, 2, 30),
('Pastilha de Freio', 'Brembo', 150.00, 1, 50),
('Bateria 60Ah', 'Moura', 450.00, 3, 20),
('Velas de Ignição', 'NGK', 25.00, 1, 100),
('Filtro de Ar', 'Mann', 35.00, 2, 25),
('Correia Dentada', 'Gates', 85.00, 3, 40),
('Amortecedor', 'Monroe', 200.00, 1, 12),
('Parafuso de Rodas', 'Schulz', 10.00, 2, 300),
('Radiador', 'Valeo', 600.00, 3, 5);

INSERT INTO tb_estoque_veiculo (modelo, marca, ano, cor, preco, id_filial, quantidade) VALUES
('Civic', 'Honda', '2022', 'Preto', 90000.00, 1, 5),
('Corolla', 'Toyota', '2021', 'Branco', 85000.00, 2, 3),
('Model S', 'Tesla', '2023', 'Vermelho', 350000.00, 3, 2),
('Mustang', 'Ford', '2020', 'Azul', 300000.00, 1, 4),
('A4', 'Audi', '2022', 'Prata', 220000.00, 2, 3),
('Wrangler', 'Jeep', '2021', 'Verde', 280000.00, 3, 2),
('320i', 'BMW', '2023', 'Preto', 250000.00, 1, 1),
('Cayenne', 'Porsche', '2020', 'Cinza', 400000.00, 2, 2),
('C3', 'Citroën', '2022', 'Azul', 75000.00, 3, 4),
('Hilux', 'Toyota', '2021', 'Branco', 210000.00, 1, 3),
('Fiesta', 'Ford', '2021', 'Vermelho', 60000.00, 1, 5),
('Camry', 'Toyota', '2022', 'Preto', 95000.00, 2, 3),
('A3', 'Audi', '2021', 'Branco', 180000.00, 3, 2),
('X1', 'BMW', '2023', 'Azul', 230000.00, 1, 1),
('Polo', 'Volkswagen', '2020', 'Cinza', 75000.00, 2, 2);


INSERT INTO tb_cadastro_veiculo (modelo, marca, ano, placa, cor, id_cliente, id_filial, quantidade) VALUES
('Civic', 'Honda', 2022, 'ABC1234', 'Preto', 1, 1, 1),
('Corolla', 'Toyota', 2021, 'DEF5678', 'Branco', 2, 2, 1),
('Model S', 'Tesla', 2023, 'GHI9101', 'Vermelho', 3, 3, 1),
('Mustang', 'Ford', 2020, 'JKL1122', 'Azul', 4, 1, 1),
('A4', 'Audi', 2022, 'MNO3344', 'Prata', 5, 2, 1),
('Wrangler', 'Jeep', 2021, 'PQR5566', 'Verde', 6, 3, 1),
('320i', 'BMW', 2023, 'STU7788', 'Preto', 7, 1, 1),
('Cayenne', 'Porsche', 2020, 'VWX9900', 'Cinza', 8, 2, 1),
('C3', 'Citroën', 2022, 'YZA1123', 'Azul', 9, 3, 1),
('Hilux', 'Toyota', 2021, 'BCD2345', 'Branco', 10, 1, 1),
('Compass', 'Jeep', 2020, 'EFG3456', 'Preto', 11, 2, 1),
('Gol', 'Volkswagen', 2019, 'HIJ4567', 'Prata', 12, 3, 1),
('Onix', 'Chevrolet', 2021, 'KLM5678', 'Branco', 13, 1, 1),
('HB20', 'Hyundai', 2022, 'NOP6789', 'Preto', 14, 2, 1),
('Sandero', 'Renault', 2023, 'QRS7890', 'Vermelho', 15, 3, 1),
('Kwid', 'Renault', 2020, 'TUV8901', 'Cinza', 16, 1, 1),
('Ranger', 'Ford', 2021, 'WXY9012', 'Azul', 17, 2, 1),
('Kicks', 'Nissan', 2022, 'ZAB0123', 'Verde', 18, 3, 1),
('Tiguan', 'Volkswagen', 2023, 'CDE1234', 'Preto', 19, 1, 1),
('Civic', 'Honda', 2021, 'FGH2345', 'Branco', 20, 2, 1);

INSERT INTO tb_servico_prestado (descricao, id_veiculo, id_funcionario, id_cliente, id_filial, tipo_servico, data_servico, valor) VALUES
('Troca de óleo e filtro', 1, 4, 1, 1, 'Manutenção', '2024-05-01 09:00:00', 250.00),
('Vistoria pré-venda', 2, 5, 2, 2, 'Vistoria', '2024-06-15 11:00:00', 500.00),
('Limpeza completa', 3, 6, 3, 3, 'Limpeza', '2024-07-20 14:00:00', 150.00),
('Alinhamento e balanceamento', 4, 7, 4, 1, 'Manutenção', '2024-08-10 10:00:00', 300.00),
('Revisão de 10.000 km', 5, 8, 5, 2, 'Manutenção', '2024-09-05 13:00:00', 700.00),
('Troca de pneus', 6, 9, 6, 3, 'Manutenção', '2024-10-18 15:00:00', 1200.00),
('Vistoria de segurança', 7, 10, 7, 1, 'Vistoria', '2024-11-25 09:00:00', 400.00),
('Lavagem de motor', 8, 11, 8, 2, 'Limpeza', '2024-12-01 12:00:00', 200.00),
('Reparação de pintura', 9, 12, 9, 3, 'Manutenção', '2024-04-22 16:00:00', 1000.00),
('Vistoria para seguro', 10, 13, 10, 1, 'Vistoria', '2024-03-15 10:00:00', 600.00),
('Descontaminação de ar condicionado', 11, 14, 11, 2, 'Limpeza', '2024-02-05 14:00:00', 250.00),
('Troca de bateria', 12, 15, 12, 3, 'Manutenção', '2024-01-20 08:00:00', 450.00),
('Vistoria anual', 13, 16, 13, 1, 'Vistoria', '2024-05-25 11:00:00', 500.00),
('Limpeza interna detalhada', 14, 17, 14, 2, 'Limpeza', '2024-06-10 09:00:00', 300.00),
('Troca de amortecedores', 15, 18, 15, 3, 'Manutenção', '2024-07-05 15:00:00', 800.00);

INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 4, 1, 1, '2024-01-15 10:00:00', 90000.00),
(2, 5, 2, 2, '2024-02-20 11:30:00', 85000.00),
(3, 6, 3, 3, '2024-03-25 14:45:00', 350000.00),
(4, 7, 1, 4, '2024-04-05 09:15:00', 300000.00),
(5, 8, 2, 5, '2024-05-18 13:00:00', 220000.00),
(6, 9, 3, 6, '2024-06-22 15:30:00', 280000.00),
(7, 10, 1, 7, '2024-07-10 08:00:00', 250000.00),
(8, 11, 2, 8, '2024-08-14 12:00:00', 400000.00),
(9, 12, 3, 9, '2024-09-20 14:00:00', 75000.00),
(10, 13, 1, 10, '2024-10-30 16:00:00', 210000.00),
(11, 14, 2, 11, '2024-11-05 09:30:00', 100000.00),
(12, 15, 3, 12, '2024-12-15 11:15:00', 95000.00),
(13, 16, 1, 13, '2024-01-12 10:30:00', 87000.00),
(14, 17, 2, 14, '2024-02-28 13:45:00', 115000.00),
(15, 18, 3, 15, '2024-03-14 15:50:00', 195000.00);

INSERT INTO tb_venda_peca (id_peca, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 4, 1, 1, '2024-01-15 10:00:00', 250.00),
(2, 5, 2, 2, '2024-02-20 11:30:00', 320.00),
(3, 6, 3, 3, '2024-03-25 14:45:00', 150.00),
(4, 7, 1, 4, '2024-04-05 09:15:00', 450.00),
(5, 8, 2, 5, '2024-05-18 13:00:00', 25.00),
(6, 9, 3, 6, '2024-06-22 15:30:00', 35.00),
(7, 10, 1, 7, '2024-07-10 08:00:00', 85.00),
(8, 11, 2, 8, '2024-08-14 12:00:00', 200.00),
(9, 12, 3, 9, '2024-09-20 14:00:00', 10.00),
(10, 13, 1, 10, '2024-10-30 16:00:00', 600.00),
(1, 14, 2, 11, '2024-11-05 09:30:00', 320.00),
(2, 15, 3, 12, '2024-12-15 11:15:00', 25.00),
(3, 16, 1, 13, '2024-01-12 10:30:00', 450.00),
(4, 17, 2, 14, '2024-02-28 13:45:00', 600.00),
(5, 18, 3, 15, '2024-03-14 15:50:00', 25.00),
(6, 4, 1, 1, '2024-04-05 09:15:00', 35.00),
(7, 5, 2, 2, '2024-05-18 13:00:00', 85.00),
(8, 6, 3, 3, '2024-06-22 15:30:00', 200.00),
(9, 7, 1, 4, '2024-07-10 08:00:00', 10.00),
(10, 8, 2, 5, '2024-08-14 12:00:00', 600.00);

INSERT INTO tb_auditoria (id_cliente, id_funcionario, id_venda_peca, id_venda_veiculo, id_servico, id_filial, data_registro) VALUES
(1, 4, 1, 1, 1, 1, CURDATE()),
(2, 5, 2, 2, 2, 2, '2024-02-20 11:30:00'),
(3, 6, 3, 3, 3, 3, '2024-03-25 14:45:00'),
(4, 7, 4, 4, 4, 1, '2024-04-05 09:15:00'),
(5, 8, 5, 5, 5, 2, '2024-05-18 13:00:00'),
(6, 9, 6, 6, 6, 3, '2024-06-22 15:30:00'),
(7, 10, 7, 7, 7, 1, '2024-07-10 08:00:00'),
(8, 11, 8, 8, 8, 2, '2024-08-14 12:00:00'),
(9, 12, 9, 9, 9, 3, '2024-09-20 14:00:00'),
(10, 13, 10, 10, 10, 1, '2024-10-30 16:00:00');

*/
# PROCEDURE
DELIMITER $$
CREATE PROCEDURE cadastra_funcionario(
    IN f_nome VARCHAR(100),
    IN f_cpf VARCHAR(11),
    IN f_cargo VARCHAR(50),
    IN f_salario DECIMAL(10,2),
    IN f_data_admissao DATE,
    IN f_id_filial INT,
    IN f_id_setor INT
)
BEGIN 
    INSERT INTO tb_funcionario (nome, cpf, cargo, salario, data_admissao, id_filial, id_setor) 
    VALUES (f_nome, f_cpf, f_cargo, f_salario, f_data_admissao, f_id_filial, f_id_setor);

    SELECT * FROM tb_funcionario 
    ORDER BY id_funcionario DESC
    LIMIT 1;
END;

DELIMITER $$
CREATE PROCEDURE cadastra_peca(
    IN p_descricao VARCHAR(255),
    IN  p_fabricante VARCHAR(100),
    IN p_preco DECIMAL(10,2),
    IN p_id_filial INT,
    IN p_quantidade INT
)
BEGIN 
    INSERT INTO tb_estoque_peca (descricao, fabricante, preco, id_filial, quantidade) 
    VALUES (p_descricao, p_fabricante, p_preco, p_id_filial, p_quantidade);

    SELECT * FROM tb_estoque_peca 
    ORDER BY id_peca DESC
    LIMIT 1;
END;
DELIMITER ;
CALL cadastra_peca('Chave Philipis', 'Bosch', 15.00, 1, 15);



SELECT * FROM tb_estoque_peca;
SELECT * FROM tb_estoque_peca 
    ORDER BY id_peca DESC
    LIMIT 1;

SELECT * FROM tb_funcionario;

SELECT * 
SELECT * FROM tb_venda_veiculo;

DESC tb_setor;
SELECT  c.nome, t.telefone, t.tipo FROM tb_cliente as c
RIGHT JOIN tb_telefone_cliente as t 
ON c.id_cliente = t.id_cliente;

SELECT c.nome, e.* FROM tb_cliente as c
INNER JOIN tb_endereco_cliente as e
ON c.id_cliente = e.id_cliente;

SELECT * FROM tb_cliente;
SELECT * FROM tb_telefone_cliente;
SELECT * FROM tb_endereco_cliente;
SELECT * FROM tb_filial;
SELECT * FROM tb_endereco_filial;
    SELECT * FROM tb_funcionario 
    ORDER BY id_funcionario DESC
    LIMIT 1;
SELECT c.nome, t.telefone, t.tipo, e.bairro FROM tb_cliente as c
LEFT JOIN tb_telefone_cliente as t
ON c.id_cliente = t.id_cliente
INNER JOIN tb_endereco_cliente as e
ON c.id_cliente = e.id_cliente;
SHOW TABLES;

SELECT * FROM tb_funcionario;
DESC tb_telefone_funcionario;
DROP TABLE tb_funcionario;
