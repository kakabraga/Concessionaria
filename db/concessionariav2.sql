CREATE DATABASE db_concessionaria;
USE db_concessionaria;


-- 2
CREATE TABLE tb_setor (
    id_setor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);
-- 10
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
CREATE TABLE tb_cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100)
);

-- 11
CREATE TABLE tb_telefone_fornecedor (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    id_fornecedor INT NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    tipo VARCHAR(50) -- Ex.: Comercial, Celular
    
);
-- 13
CREATE TABLE tb_endereco_fornecedor(
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(100),
    estado VARCHAR(50),
    cep VARCHAR(10),
    tipo VARCHAR(50) -- Ex.: Matriz, Filial
    
);
-- 9
CREATE TABLE tb_fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL,  
    email VARCHAR(100),
    id_telefone_fornecedor INT,
    id_endereco_fornecedor INT,
    FOREIGN KEY (id_telefone_fornecedor) REFERENCES tb_telefone_fornecedor(id_telefone),
    FOREIGN KEY (id_endereco_fornecedor) REFERENCES tb_endereco_fornecedor(id_endereco)
    
);
-- 14
CREATE TABLE tb_telefone_filial (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    telefone VARCHAR(15) NOT NULL,
    tipo ENUM('Comercial', 'Suporte', 'Atendimento')-- Exemplo: Comercial, Suporte, etc.
    
);
DROP TABLE tb_telefone_filial;
-- 15
CREATE TABLE tb_endereco_filial (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(100),
    estado VARCHAR(50),
    cep VARCHAR(10),
    tipo VARCHAR(50) -- Exemplo: Principal, Filial, Armazém, etc.
   
);
-- 1
CREATE TABLE tb_filial (
    id_filial INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    id_endereco INT, -- Referência para um endereço principal
    id_telefone INT, -- Referência para um telefone principal
    FOREIGN KEY (id_endereco) REFERENCES tb_endereco_filial(id_endereco),
    FOREIGN KEY (id_telefone) REFERENCES tb_telefone_filial(id_telefone)
);

DROP TABLE tb_filial;
DROP TABLE tb_funcionario;

-- 3
CREATE TABLE tb_funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2),
    id_filial INT,
    id_setor INT,
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial),
    FOREIGN KEY (id_setor) REFERENCES tb_setor(id_setor)
);

-- Adicionar a chave estrangeira após as tabelas estarem criadas
ALTER TABLE tb_filial
ADD COLUMN gerente_responsavel INT,
ADD CONSTRAINT fk_gerente_responsavel FOREIGN KEY (gerente_responsavel) REFERENCES tb_funcionario(id_funcionario);

-- 4
CREATE TABLE tb_estoque_veiculo (
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(100) NOT NULL,
    ano INT,
    cor VARCHAR(50),
    preco DECIMAL(10, 2),
    id_filial INT,
    quantidade INT DEFAULT 0,
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)
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
CREATE TABLE tb_servico (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    id_veiculo INT,
    id_funcionario INT,
    id_cliente INT,
    id_filial INT,
    data_servico DATE,
    valor DECIMAL(10, 2),
    FOREIGN KEY (id_veiculo) REFERENCES tb_estoque_veiculo(id_estoque),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario(id_funcionario),
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente),
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)
);

-- 6
CREATE TABLE tb_venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_veiculo INT,
    id_funcionario INT,
    id_filial INT,
    id_cliente INT,
    data_venda DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_veiculo) REFERENCES tb_estoque_veiculo(id_estoque),
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario(id_funcionario),
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)
);
SELECT * FROM tb_cliente;

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


SELECT  c.nome, t.telefone, t.tipo FROM tb_cliente as c
RIGHT JOIN tb_telefone_cliente as t 
ON c.id_cliente = t.id_cliente;

SELECT c.nome, e.* FROM tb_cliente as c
INNER JOIN tb_endereco_cliente as e
ON c.id_cliente = e.id_cliente;


