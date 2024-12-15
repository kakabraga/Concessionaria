CREATE DATABASE db_concessionaria;
USE db_concessionaria;
DROP DATABASE db_concessionaria;
-- 1
CREATE TABLE tb_cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100)
);
-- 2
CREATE TABLE tb_telefone_cliente (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    telefone VARCHAR(15) NOT NULL,
    tipo VARCHAR(50), 
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
    -- Ex.: Residencial, Comercial, Celular   
);
-- 3
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
-- 4
CREATE TABLE tb_fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL,  
    email VARCHAR(100)
);
-- 5
CREATE TABLE tb_telefone_fornecedor (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    id_fornecedor INT,
    telefone VARCHAR(15) NOT NULL,
    tipo VARCHAR(50), 
    FOREIGN KEY (id_fornecedor) REFERENCES tb_fornecedor(id_fornecedor)-- Ex.: Comercial, Celular
    
);
-- 6
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
-- 7
CREATE TABLE tb_setor (
    id_setor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);
-- 8
CREATE TABLE tb_filial (
    id_filial INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    gerente VARCHAR(100)
    
);
-- 9
CREATE TABLE tb_telefone_filial (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    id_filial INT,
    telefone VARCHAR(15) NOT NULL,
    tipo ENUM('Comercial', 'Suporte', 'Atendimento'),
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)-- Exemplo: Comercial, Suporte, etc.
    
);
-- 10
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
-- 11
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
-- 12
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
-- 13
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
-- 14
CREATE TABLE tb_estoque_peca (
    id_peca INT  PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    fabricante VARCHAR(100),
    preco DECIMAL(10, 2),
    id_filial INT,
    quantidade INT DEFAULT 0,
    FOREIGN KEY (id_filial) REFERENCES tb_filial(id_filial)
);
-- 15
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
-- 16
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
-- 17
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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Query para saber o numero de tabelas existentes em um banco de dados.
SELECT COUNT(*) 
AS numero_de_tabelas
FROM information_schema.tables 
WHERE table_schema = 'db_concessionaria';
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------- Alimentando tabelas --------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_cliente (nome, cpf, email) VALUES
('Carla Oliveira', '12312312312', 'carla.oliveira@confiacar.com.br'),
('Vitor Almeida', '23423423423', 'vitor.almeida@confiacar.com.br'),
('Patrícia Lima', '34534534534', 'patricia.lima@confiacar.com.br'),
('Renato Costa', '45645645645', 'renato.costa@confiacar.com.br'),
('Luciana Santos', '56756756756', 'luciana.santos@confiacar.com.br'),
('Eduardo Martins', '67867867867', 'eduardo.martins@confiacar.com.br'),
('Mariana Rocha', '78978978978', 'mariana.rocha@confiacar.com.br'),
('Ricardo Pereira', '89089089089', 'ricardo.pereira@confiacar.com.br'),
('Gabriela Almeida', '90190190190', 'gabriela.almeida@confiacar.com.br'),
('Felipe Silva', '01201201201', 'felipe.silva@confiacar.com.br'),
('João Lima', '12345678900', 'joao.lima@confiacar.com.br'),
('Larissa Souza', '23456789001', 'larissa.souza@confiacar.com.br'),
('Cristiano Silva', '34567890102', 'cristiano.silva@confiacar.com.br'),
('Luciana Almeida', '45678901213', 'luciana.almeida@confiacar.com.br'),
('Paulo Costa', '56789012324', 'paulo.costa@confiacar.com.br'),
('Bruna Oliveira', '67890123435', 'bruna.oliveira@confiacar.com.br'),
('Marta Teixeira', '78901234546', 'marta.teixeira@confiacar.com.br'),
('Andreia Pereira', '89012345657', 'andreia.pereira@confiacar.com.br'),
('Carlos Souza', '90123456768', 'carlos.souza@confiacar.com.br'),
('Cláudia Rocha', '01234567879', 'claudia.rocha@confiacar.com.br'),
('Renato Alves', '12345678910', 'renato.alves@confiacar.com.br'),
('Fernanda Silva', '23456789021', 'fernanda.silva@confiacar.com.br'),
('Miguel Costa', '34567890132', 'miguel.costa@confiacar.com.br'),
('Sônia Lima', '45678901243', 'sonia.lima@confiacar.com.br'),
('Roberta Pereira', '56789012354', 'roberta.pereira@confiacar.com.br'),
('Gustavo Oliveira', '67890123465', 'gustavo.oliveira@confiacar.com.br'),
('Júlio Souza', '78901234576', 'julio.souza@confiacar.com.br'),
('Ricardo Ferreira', '89012345687', 'ricardo.ferreira@confiacar.com.br'),
('Daniela Rocha', '90123456798', 'daniela.rocha@confiacar.com.br'),
('Sérgio Almeida', '01234567809', 'sergio.almeida@confiacar.com.br'),
('Cintia Lima', '12345678911', 'cintia.lima@confiacar.com.br'),
('Tatiane Souza', '23456789022', 'tatiane.souza@confiacar.com.br'),
('Leandro Costa', '34567890133', 'leandro.costa@confiacar.com.br'),
('Tânia Oliveira', '45678901244', 'tania.oliveira@confiacar.com.br'),
('Raquel Silva', '56789012355', 'raquel.silva@confiacar.com.br'),
('Felipe Rocha', '67890123466', 'felipe.rocha@confiacar.com.br'),
('Joana Pereira', '78901234577', 'joana.pereira@confiacar.com.br'),
('Juliano Almeida', '89012345688', 'juliano.almeida@confiacar.com.br'),
('Danilo Costa', '90123456799', 'danilo.costa@confiacar.com.br'),
('Gisele Souza', '01234567810', 'gisele.souza@confiacar.com.br'),
('Renan Lima', '12345678912', 'renan.lima@confiacar.com.br'),
('Fábio Pereira', '23456789023', 'fabio.pereira@confiacar.com.br'),
('Bruno Rocha', '34567890134', 'bruno.rocha@confiacar.com.br'),
('Maurício Oliveira', '45678901245', 'mauricio.oliveira@confiacar.com.br'),
('Michele Costa', '56789012356', 'michele.costa@confiacar.com.br'),
('Rogério Silva', '67890123467', 'rogerio.silva@confiacar.com.br'),
('Patrícia Almeida', '78901234578', 'patricia.almeida@confiacar.com.br'),
('Thiago Lima', '89012345689', 'thiago.lima@confiacar.com.br'),
('Vanessa Souza', '90123456800', 'vanessa.souza@confiacar.com.br'),
('Ricardo Costa', '01234567811', 'ricardo.costa@confiacar.com.br'),
('Ana Oliveira', '12345678913', 'ana.oliveira@confiacar.com.br'),
('Marcio Almeida', '23456789024', 'marcio.almeida@confiacar.com.br'),
('Carla Costa', '34567890135', 'carla.costa@confiacar.com.br'),
('Fernando Rocha', '45678901246', 'fernando.rocha@confiacar.com.br'),
('Helena Pereira', '56789012357', 'helena.pereira@confiacar.com.br'),
('Renato Oliveira', '67890123468', 'renato.oliveira@confiacar.com.br'),
('Jéssica Souza', '78901234579', 'jessica.souza@confiacar.com.br'),
('Vera Lima', '89012345690', 'vera.lima@confiacar.com.br'),
('Samuel Almeida', '90123456801', 'samuel.almeida@confiacar.com.br'),
('Elaine Costa', '01234567812', 'elaine.costa@confiacar.com.br'),
('Tarcísio Pereira', '12345678914', 'tarcisio.pereira@confiacar.com.br'),
('Juliana Silva', '23456789025', 'juliana.silva@confiacar.com.br'),
('Pedro Rocha', '34567890136', 'pedro.rocha@confiacar.com.br'),
('Rita Oliveira', '45678901247', 'rita.oliveira@confiacar.com.br'),
('Silvana Costa', '56789012358', 'silvana.costa@confiacar.com.br'),
('Vânia Almeida', '67890123469', 'vania.almeida@confiacar.com.br'),
('Antonio Souza', '78901234580', 'antonio.souza@confiacar.com.br'),
('Mauro Pereira', '89012345691', 'mauro.pereira@confiacar.com.br'),
('Nelson Lima', '90123456802', 'nelson.lima@confiacar.com.br'),
('Lúcia Costa', '01234567813', 'lucia.costa@confiacar.com.br'),
('Kátia Rocha', '12345678915', 'katia.rocha@confiacar.com.br'),
('Lúcio Oliveira', '23456789026', 'lucio.oliveira@confiacar.com.br'),
('Sílvia Almeida', '34567890137', 'silvia.almeida@confiacar.com.br'),
('Julieta Souza', '45678901248', 'julieta.souza@confiacar.com.br'),
('José Rocha', '56789012359', 'jose.rocha@confiacar.com.br'),
('Gustavo Lima', '67890123470', 'gustavo.lima@confiacar.com.br'),
('Sandra Pereira', '78901234581', 'sandra.pereira@confiacar.com.br');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_telefone_cliente (id_cliente, telefone, tipo) VALUES
(1, '1234-5678', 'Residencial'),
(1, '2345-6789', 'Celular'),
(2, '3456-7890', 'Comercial'),
(2, '4567-8901', 'Residencial'),
(3, '5678-9012', 'Celular'),
(3, '6789-0123', 'Comercial'),
(4, '7890-1234', 'Residencial'),
(4, '8901-2345', 'Celular'),
(5, '9012-3456', 'Comercial'),
(5, '0123-4567', 'Residencial'),
(6, '1324-5768', 'Celular'),
(6, '2435-6879', 'Comercial'),
(7, '3546-7980', 'Residencial'),
(8, '4657-8091', 'Celular'),
(9, '5768-9012', 'Comercial'),
(9, '6879-0123', 'Residencial'),
(10, '7980-1234', 'Celular'),
(10, '8091-2345', 'Comercial'),
(11, '9123-3456', 'Residencial'),
(11, '0234-4567', 'Celular'),
(12, '1345-5678', 'Comercial'),
(13, '2456-6789', 'Residencial'),
(13, '3567-7890', 'Celular'),
(14, '4678-8901', 'Comercial'),
(15, '5789-9012', 'Residencial'),
(15, '6890-0123', 'Celular'),
(16, '7901-1234', 'Comercial'),
(17, '8012-2345', 'Residencial'),
(18, '9123-3456', 'Celular'),
(19, '0234-4567', 'Comercial'),
(20, '1345-5678', 'Residencial'),
(20, '2456-6789', 'Celular'),
(21, '3567-7890', 'Comercial'),
(22, '4678-8901', 'Residencial'),
(22, '5789-9012', 'Celular'),
(23, '6890-0123', 'Comercial'),
(24, '7901-1234', 'Residencial'),
(25, '8012-2345', 'Celular'),
(26, '9123-3456', 'Comercial'),
(27, '0234-4567', 'Residencial'),
(28, '1345-5678', 'Celular'),
(29, '2456-6789', 'Comercial'),
(30, '3567-7890', 'Residencial'),
(31, '4678-8901', 'Celular'),
(31, '5789-9012', 'Comercial'),
(32, '6890-0123', 'Residencial'),
(33, '7901-1234', 'Celular'),
(34, '8012-2345', 'Comercial'),
(35, '9123-3456', 'Residencial'),
(36, '0234-4567', 'Celular'),
(37, '1345-5678', 'Comercial'),
(38, '2456-6789', 'Residencial'),
(39, '3567-7890', 'Celular'),
(40, '4678-8901', 'Comercial'),
(41, '5789-9012', 'Residencial'),
(42, '6890-0123', 'Celular'),
(43, '7901-1234', 'Comercial'),
(44, '8012-2345', 'Residencial'),
(45, '9123-3456', 'Celular'),
(46, '0234-4567', 'Comercial'),
(47, '1345-5678', 'Residencial'),
(48, '2456-6789', 'Celular'),
(49, '3567-7890', 'Comercial'),
(50, '4678-8901', 'Residencial'),
(51, '5789-9012', 'Celular'),
(52, '6890-0123', 'Comercial'),
(53, '7901-1234', 'Residencial'),
(54, '8012-2345', 'Celular'),
(55, '9123-3456', 'Comercial'),
(56, '0234-4567', 'Residencial'),
(57, '1345-5678', 'Celular'),
(58, '2456-6789', 'Comercial'),
(59, '3567-7890', 'Residencial'),
(60, '4678-8901', 'Celular'),
(1, '5789-9012', 'Comercial'),
(2, '6890-0123', 'Residencial'),
(3, '7901-1234', 'Celular'),
(4, '8012-2345', 'Comercial'),
(5, '9123-3456', 'Residencial'),
(6, '0234-4567', 'Celular'),
(7, '1345-5678', 'Comercial'),
(8, '2456-6789', 'Residencial'),
(9, '3567-7890', 'Celular'),
(10, '4678-8901', 'Comercial');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
(40, 40, 'Avenida Rio de Janeiro', '3737', 'Galpão 3', 'Centro', 'Rio de Janeiro', 'RJ', '01234-567'),
(41, 41, 'Rua das Palmeiras', '3838', 'Apto 111', 'Jardim das Flores', 'Campinas', 'SP', '12345-678'),
(42, 42, 'Rua das Acácias', '3939', 'Casa', 'Centro', 'Salvador', 'BA', '23456-789'),
(43, 43, 'Avenida Rio Branco', '4040', 'Cobertura', 'Centro', 'Recife', 'PE', '34567-890'),
(44, 44, 'Avenida Ipiranga', '4141', 'Bloco C', 'Vila Progresso', 'São Paulo', 'SP', '45678-901'),
(45, 45, 'Rua das Flores', '4242', 'Loja 1', 'Jardim Tropical', 'Goiânia', 'GO', '56789-012'),
(46, 46, 'Avenida Brasil', '4343', 'Apto 707', 'Zona Sul', 'São Paulo', 'SP', '67890-123'),
(47, 47, 'Rua do Comércio', '4444', 'Casa', 'Bairro Leste', 'Porto Alegre', 'RS', '78901-234'),
(48, 48, 'Rua Amazonas', '4545', 'Bloco B', 'Centro', 'Curitiba', 'PR', '89012-345'),
(49, 49, 'Avenida das Américas', '4646', 'Loja 2', 'Zona Oeste', 'Rio de Janeiro', 'RJ', '90123-456'),
(50, 50, 'Rua das Laranjeiras', '4747', 'Casa', 'Centro', 'São Luís', 'MA', '01234-567'),
(51, 51, 'Rua Sete de Setembro', '4848', 'Cobertura', 'Zona Norte', 'Fortaleza', 'CE', '12345-678'),
(52, 52, 'Avenida Paulista', '4949', 'Bloco A', 'Centro', 'Belo Horizonte', 'MG', '23456-789'),
(53, 53, 'Rua Sergipe', '5050', 'Loja 1', 'Vila Nova', 'Recife', 'PE', '34567-890'),
(54, 54, 'Avenida Independência', '5151', 'Casa', 'Centro', 'Porto Alegre', 'RS', '45678-901'),
(55, 55, 'Rua das Azaleias', '5252', 'Bloco C', 'Zona Oeste', 'Manaus', 'AM', '56789-012'),
(56, 56, 'Avenida Boa Viagem', '5353', 'Apto 808', 'Zona Leste', 'Aracaju', 'SE', '67890-123'),
(57, 57, 'Rua das Bromélias', '5454', 'Loja 3', 'Centro', 'Teresina', 'PI', '78901-234'),
(58, 58, 'Rua das Magnólias', '5555', 'Apto 303', 'Centro', 'Goiânia', 'GO', '89012-345'),
(59, 59, 'Avenida Getúlio Vargas', '5656', 'Cobertura', 'Zona Sul', 'São Paulo', 'SP', '90123-456'),
(60, 60, 'Rua do Sol', '5757', 'Bloco A', 'Zona Norte', 'Rio de Janeiro', 'RJ', '01234-567'),
(61, 61, 'Rua dos Ipês', '5858', 'Loja 5', 'Bairro Jardim', 'Curitiba', 'PR', '12345-678'),
(62, 62, 'Avenida Rio de Janeiro', '5959', 'Apto 404', 'Centro', 'Salvador', 'BA', '23456-789'),
(63, 63, 'Rua dos Cravos', '6060', '', 'Vila Progresso', 'São Paulo', 'SP', '34567-890'),
(64, 64, 'Rua das Hortênsias', '6161', 'Apto 909', 'Zona Oeste', 'Belo Horizonte', 'MG', '45678-901'),
(65, 65, 'Avenida Paraná', '6262', 'Casa', 'Vila Nova', 'Rio de Janeiro', 'RJ', '56789-012'),
(66, 66, 'Avenida Santos Dumont', '6363', '', 'Bairro da Luz', 'Fortaleza', 'CE', '67890-123'),
(67, 67, 'Rua das Orquídeas', '6464', 'Bloco B', 'Zona Leste', 'Recife', 'PE', '78901-234'),
(68, 68, 'Rua Sete de Setembro', '6565', 'Casa', 'Centro', 'Teresina', 'PI', '89012-345'),
(69, 69, 'Rua do Comércio', '6666', 'Loja 6', 'Bairro Alto', 'Manaus', 'AM', '90123-456'),
(70, 70, 'Avenida Presidente Vargas', '6767', '', 'Centro', 'São Paulo', 'SP', '01234-567'),
(71, 71, 'Rua das Acácias', '6868', 'Cobertura', 'Zona Sul', 'Goiânia', 'GO', '12345-678'),
(72, 72, 'Avenida Ipiranga', '6969', 'Apto 808', 'Vila Nova', 'Recife', 'PE', '23456-789');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_filial (nome, gerente) VALUES 
('ConfiaCar Porto Alegre', 'Camila Coutinho'),
('ConfiaCar Salvador', 'Brad Pitt'),
('ConfiaCar Goiás', 'Beyoncé Knowles');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_setor (nome, descricao) VALUES 
('Vendas', 'Responsável pela comercialização de veículos e peças.'),
('Financiamento', 'Cuida das transações financeiras e dos processos de financiamento para clientes.'),
('Estoque de Veiculos', 'Gerencia o inventário de veículos disponíveis para venda.'),
('Estoque de Peças', 'Administra o inventário de peças e componentes para manutenção e reparo.'),
('Oficina', 'Realiza serviços de manutenção e reparo de veículos.');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_funcionario (nome, cpf, cargo, salario, data_admissao, id_filial, id_setor) VALUES 
('Camila Coutinho', '12345678901', 'Gerente', 8500.00, '2021-02-15', 1, 1),
('Anitta', '34567890123', 'Estagiário', 1400.00, '2021-11-01', 1, 3),
('Daniela Mercury', '11122233344', 'Assistente', 2800.00, '2020-12-10', 1, 1),
('Miley Cyrus', '44455566677', 'Analista', 4900.00, '2021-07-08', 1, 2),
('Johnny Depp', '33344455566', 'Analista', 4700.00, '2021-07-22', 1, 2),
('Snoop Dogg', '66677788899', 'Assistente', 3100.00, '2019-07-08', 1, 5),
('Beyoncé Knowles', '77788899900', 'Gerente', 9000.00, '2022-01-15', 1, 2),
('Rihanna', '11122233344', 'Analista', 4800.00, '2021-07-08', 1, 4),
('Rita Ora', '99900011122', 'Estagiário', 1500.00, '2021-04-19', 1, 1),
('Matt Damon', '88899900011', 'Assistente', 3100.00, '2022-01-30', 1, 5),
('Julia Roberts', '88899900011', 'Assistente', 2800.00, '2020-08-12', 1, 5),
('Chris Evans', '11122233344', 'Estagiário', 1500.00, '2020-07-28', 1, 4),
('Zendaya', '22233344455', 'Coordenador', 6200.00, '2022-01-12', 1, 5),
('Shakira', '77788899900', 'Coordenador', 6100.00, '2022-04-20', 1, 1),
('LeBron James', '55566677788', 'Analista', 4700.00, '2020-10-30', 1, 2),
('Katy Perry', '22233344455', 'Coordenador', 6200.00, '2020-06-01', 1, 3),
('Dwayne Johnson', '23456789012', 'Analista', 4500.00, '2020-03-10', 2, 1),
('Sabrina Sato', '45678901234', 'Coordenador', 6000.00, '2020-05-20', 2, 2),
('Gisele Bündchen', '78901234567', 'Gerente', 9000.00, '2019-01-20', 2, 5),
('Caio Castro', '01234567890', 'Analista', 4700.00, '2021-05-30', 2, 3),
('Kylie Jenner', '55566677788', 'Analista', 4800.00, '2020-06-25', 2, 1),
('Johnny Depp', '33344455566', 'Analista', 4700.00, '2021-07-22', 2, 3),
('Megan Fox', '66677788899', 'Analista', 4800.00, '2021-07-08', 2, 2),
('Tom Brady', '44455566677', 'Estagiário', 1400.00, '2021-06-05', 2, 1),
('Chris Hemsworth', '77788899900', 'Coordenador', 6000.00, '2020-07-13', 2, 4),
('Taylor Swift', '44455566677', 'Analista', 4500.00, '2020-04-01', 2, 4),
('Lady Gaga', '77788899900', 'Analista', 4900.00, '2019-10-01', 2, 2),
('Ricky Martin', '66677788899', 'Coordenador', 6000.00, '2020-07-13', 2, 4),
('Zac Efron', '66677788899', 'Estagiário', 1500.00, '2021-07-18', 2, 5),
('Ben Affleck', '44455566677', 'Analista', 4700.00, '2019-07-25', 2, 1),
('Brad Pitt', '99900011122', 'Gerente', 9000.00, '2022-02-15', 2, 4),
('Zac Efron', '66677788899', 'Estagiário', 1500.00, '2021-07-18', 2, 5),
('Camila Coutinho', '12345678901', 'Gerente', 8500.00, '2021-02-15', 3, 1),
('Shakira', '56789012345', 'Assistente', 3000.00, '2021-06-15', 3, 2),
('Will Smith', '67890123456', 'Analista', 4600.00, '2020-08-30', 3, 1),
('Juliana Paes', '89012345678', 'Estagiário', 1500.00, '2022-03-01', 3, 1),
('Tom Hanks', '00011122233', 'Coordenador', 6300.00, '2020-02-25', 3, 3),
('Chris Hemsworth', '77788899900', 'Gerente', 8800.00, '2021-01-05', 3, 1),
('Demi Lovato', '55566677788', 'Estagiário', 1500.00, '2021-03-30', 3, 4),
('Tom Holland', '10098765478', 'Estagiário', 1500.00, '2020-07-18', 3, 1),
('Robert Downey Jr.', '40321098745', 'Analista', 4700.00, '2020-10-15', 3, 2),
('Zendaya Coleman', '50432109834', 'Estagiário', 1400.00, '2021-08-22', 3, 2),
('Emma Watson', '90876543290', 'Analista', 4600.00, '2022-01-15', 3, 3),
('Sabrina Sato', '45678901234', 'Assistente', 3000.00, '2021-06-15', 3, 5),
('Beyoncé Knowles', '77788899900', 'Gerente', 9000.00, '2022-01-15', 3, 1),
('Chris Evans', '20109876567', 'Coordenador', 6300.00, '2021-02-25', 3, 4),
('Gisele Bündchen', '78901234567', 'Gerente', 9000.00, '2019-01-20', 3, 5),
('Rihanna Fenty', '21098765478', 'Estagiário', 1500.00, '2021-11-01', 3, 2),
('Caio Castro', '01234567890', 'Analista', 4700.00, '2021-05-30', 3, 4),
('Scarlett Johansson', '30210987656', 'Assistente', 3100.00, '2019-12-05', 3, 2),
('Rihanna', '11122233344', 'Analista', 4800.00, '2021-07-08', 3, 5),
('Will Smith', '67890123456', 'Analista', 4600.00, '2020-08-30', 3, 5);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_fornecedor (nome, cnpj, email) VALUES
('Bosch', '02997443000174', 'bosch@email.com'),
('ZF Friedrichshafen', '01093835000195', 'zf@email.com'),
('Valeo', '21047222000136', 'valeo@email.com'),
('Denso', '12092839000155', 'denso@email.com'),
('Magneti Marelli', '14498732000199', 'magnetimarelli@email.com'),
('Mahle', '11578413000182', 'mahle@email.com'),
('Delphi Technologies', '08058040000165', 'delphitechnologies@email.com'),
('Tenneco', '18776438000104', 'tenneco@email.com'),
('MANN+HUMMEL', '23765432000198', 'mannhummel@email.com'),
('SKF', '23487933000146', 'skf@email.com'),
('NGK Spark Plugs', '00342647000138', 'ngk@email.com'),
('Gates', '27201923000107', 'gates@email.com'),
('Federal-Mogul', '06965432100120', 'federalmogul@email.com'),
('Autoliv', '09651278000156', 'autoliv@email.com'),
('Bendix', '20698030000108', 'bendix@email.com'),
('Valeo Service', '20670044000121', 'valeoservice@email.com'),
('TRW Automotive', '16208937000147', 'trwautomotive@email.com'),
('Hella', '23187654000122', 'hella@email.com'),
('Lucas TVS', '13768594000198', 'lucastvs@email.com'),
('Roechling', '25063445000130', 'roechling@email.com'),
('Knorr-Bremse', '20457893000105', 'knorrbremse@email.com'),
('BorgWarner', '23645891000115', 'borgwarner@email.com'),
('Dorman Products', '00894329000177', 'dormanproducts@email.com'),
('Sachs', '05281937000183', 'sachs@email.com'),
('Eaton', '23168792000161', 'eaton@email.com'),
('Koyo Bearings', '20261847000121', 'koyobearings@email.com'),
('Dana Incorporated', '26153132000109', 'dana@email.com'),
('Mitsubishi Electric', '11897432000122', 'mitsubishielectric@email.com'),
('Sanden', '20134637000108', 'sanden@email.com'),
('Aisin Seiki', '20257896000199', 'aisin@email.com'),
('Continental Automotive', '00934678000144', 'continentalautomotive@email.com'),
('Motive', '11954687000189', 'motive@email.com');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_endereco_fornecedor (id_fornecedor, endereco, cidade, estado, cep, tipo) VALUES
(1, 'Rua das Indústrias, 123', 'São Bernardo do Campo', 'SP', '09823-200', 'Matriz'),
(2, 'Avenida São João, 456', 'Campinas', 'SP', '13025-350', 'Filial'),
(3, 'Rua das Laranjeiras, 789', 'São Paulo', 'SP', '01500-050', 'Matriz'),
(4, 'Rua dos Jasmins, 12', 'São José dos Campos', 'SP', '12245-380', 'Filial'),
(5, 'Avenida Brasil, 3500', 'Rio de Janeiro', 'RJ', '20021-270', 'Matriz'),
(6, 'Rua Belo Horizonte, 1500', 'Belo Horizonte', 'MG', '31270-010', 'Filial'),
(7, 'Rua das Flores, 456', 'Curitiba', 'PR', '80010-040', 'Matriz'),
(8, 'Avenida das Nações, 789', 'Porto Alegre', 'RS', '90420-050', 'Filial'),
(9, 'Rua do Comércio, 321', 'Fortaleza', 'CE', '60170-540', 'Matriz'),
(10, 'Avenida Paulista, 900', 'São Paulo', 'SP', '01310-100', 'Filial'),
(11, 'Rua das Orquídeas, 23', 'Salvador', 'BA', '40295-040', 'Matriz'),
(12, 'Avenida Rio Branco, 500', 'Florianópolis', 'SC', '88015-100', 'Filial'),
(13, 'Rua Sete de Setembro, 875', 'Recife', 'PE', '50010-100', 'Matriz'),
(14, 'Avenida Alberto Torres, 234', 'Goiânia', 'GO', '74080-010', 'Filial'),
(15, 'Rua Doze de Outubro, 600', 'Manaus', 'AM', '69010-180', 'Matriz'),
(16, 'Rua Piauí, 1023', 'Belém', 'PA', '66075-080', 'Filial'),
(17, 'Avenida Dom Pedro, 500', 'Campinas', 'SP', '13060-020', 'Matriz'),
(18, 'Rua Nove de Julho, 234', 'Vitória', 'ES', '29010-210', 'Filial'),
(19, 'Rua Benedito Valadares, 333', 'Rio de Janeiro', 'RJ', '20050-050', 'Matriz'),
(20, 'Avenida Rio de Janeiro, 1200', 'São Paulo', 'SP', '05070-090', 'Filial'),
(21, 'Rua Humberto de Campos, 900', 'São Bernardo do Campo', 'SP', '09890-050', 'Matriz'),
(22, 'Avenida Marechal Floriano, 470', 'Natal', 'RN', '59015-210', 'Filial'),
(23, 'Rua Campo Grande, 321', 'Macapá', 'AP', '68900-970', 'Matriz'),
(24, 'Avenida Guarani, 789', 'São José do Rio Preto', 'SP', '15025-020', 'Filial'),
(25, 'Rua Santa Catarina, 50', 'João Pessoa', 'PB', '58010-320', 'Matriz'),
(26, 'Rua Rio Grande do Sul, 300', 'Florianópolis', 'SC', '88035-150', 'Filial'),
(27, 'Rua Vila Velha, 210', 'Cuiabá', 'MT', '78010-080', 'Matriz'),
(28, 'Rua São Paulo, 555', 'São Caetano do Sul', 'SP', '09530-100', 'Filial'),
(29, 'Avenida Amazonas, 1200', 'Belo Horizonte', 'MG', '30510-190', 'Matriz'),
(30, 'Rua Pedro II, 234', 'Recife', 'PE', '50020-200', 'Filial');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_telefone_fornecedor (id_fornecedor, telefone, tipo) VALUES
(1, '(11) 98765-4321', 'Comercial'),
(2, '(19) 99876-5432', 'Comercial'),
(3, '(11) 97654-3210', 'Celular'),
(4, '(12) 99654-3210', 'Comercial'),
(5, '(21) 99543-2109', 'Celular'),
(6, '(31) 99432-1098', 'Comercial'),
(7, '(41) 99321-0987', 'Celular'),
(8, '(51) 99210-9876', 'Comercial'),
(9, '(85) 99109-8765', 'Comercial'),
(10, '(11) 99887-7654', 'Celular'),
(11, '(71) 99765-4321', 'Comercial'),
(12, '(48) 99654-3210', 'Celular'),
(13, '(81) 99543-2109', 'Comercial'),
(14, '(62) 99432-1098', 'Comercial'),
(15, '(92) 99321-0987', 'Celular'),
(16, '(11) 99123-4567', 'Comercial'),
(17, '(61) 99012-3456', 'Celular'),
(18, '(27) 98876-5432', 'Comercial'),
(19, '(35) 98765-4321', 'Celular'),
(20, '(63) 99654-3210', 'Comercial');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_estoque_peca (nome, fabricante, preco, id_filial, quantidade) VALUES
('Filtro de Combustível', 'Bosch', 35.00, 1, 20),
('Pneu 195/65 R15', 'Pirelli', 280.00, 1, 35),
('Cabo de Velas', 'NGK', 18.00, 1, 45),
('Bateria 70Ah', 'Moura', 550.00, 1, 15),
('Lâmpada de Farol', 'Philips', 15.00, 1, 50),
('Disco de Freio', 'Brembo', 200.00, 1, 25),
('Kit de Embreagem', 'Sachs', 350.00, 1, 30),
('Sensor de Estacionamento', 'Valeo', 250.00, 1, 10),
('Pastilha de Freio Traseira', 'TRW', 160.00, 1, 22),
('Correia Poly-V', 'Gates', 75.00, 1, 28),
('Amortecedor Dianteiro', 'Monroe', 180.00, 1, 17),
('Vela de Ignição Iridium', 'NGK', 35.00, 1, 12),
('Tampa de Óleo', 'Bosch', 30.00, 1, 18),
('Filtro de Ar Condicionado', 'Mann', 50.00, 1, 23),
('Interruptor de Luz', 'Schneider', 20.00, 1, 33),
('Corpo de Borboleta', 'Valeo', 500.00, 1, 10),
('Bico Injetor', 'Bosch', 120.00, 1, 40),
('Rodízio de Pneu', 'Michelin', 25.00, 1, 35),
('Mangueira de Radiador', 'Goodyear', 45.00, 1, 12),
('Filtro de Ar Condicionado', 'Mann', 50.00, 1, 15),
('Kit de Embreagem', 'Valeo', 380.00, 2, 28),
('Pneu 205/55 R16', 'Pirelli', 340.00, 2, 22),
('Bateria 80Ah', 'Heliar', 600.00, 2, 18),
('Filtro de Óleo', 'Bosch', 45.00, 2, 25),
('Amortecedor Traseiro', 'Monroe', 220.00, 2, 12),
('Pastilha de Freio Dianteira', 'Brembo', 160.00, 2, 40),
('Lâmpada de Farol LED', 'Philips', 25.00, 2, 30),
('Disco de Freio Traseiro', 'TRW', 210.00, 2, 35),
('Correia Dentada', 'Gates', 85.00, 2, 28),
('Radiador', 'Valeo', 650.00, 2, 8),
('Filtro de Combustível', 'Mann', 30.00, 2, 23),
('Vela de Ignição', 'NGK', 25.00, 2, 30),
('Amortecedor Dianteiro', 'Monroe', 190.00, 2, 15),
('Cabo de Vela', 'NGK', 20.00, 2, 38),
('Tampa de Óleo', 'Bosch', 33.00, 2, 20),
('Rodízio de Pneus', 'Michelin', 28.00, 2, 18),
('Sensor de Estacionamento', 'Valeo', 240.00, 2, 10),
('Corpo de Borboleta', 'Bosch', 480.00, 2, 12),
('Bico Injetor', 'Sachs', 130.00, 2, 18),
('Filtro de Ar', 'Mann', 40.00, 2, 33),
('Limpador de Parabrisa', 'Bosch', 40.00, 2, 25),
('Filtro de Combustível', 'Bosch', 40.00, 3, 35),
('Pneu 185/65 R14', 'Pirelli', 300.00, 3, 28),
('Bateria 55Ah', 'Moura', 500.00, 3, 20),
('Velas de Ignição', 'NGK', 25.00, 3, 12),
('Amortecedor Traseiro', 'Monroe', 210.00, 3, 28),
('Pastilha de Freio Traseira', 'Brembo', 150.00, 3, 30),
('Disco de Freio Dianteiro', 'TRW', 200.00, 3, 22),
('Kit de Embreagem', 'Valeo', 350.00, 3, 18),
('Correia Poly-V', 'Gates', 70.00, 3, 32),
('Radiador', 'Valeo', 620.00, 3, 10),
('Filtro de Ar Condicionado', 'Mann', 50.00, 3, 23),
('Amortecedor Dianteiro', 'Monroe', 180.00, 3, 40),
('Tampa de Óleo', 'Bosch', 28.00, 3, 20),
('Vela de Ignição Iridium', 'NGK', 35.00, 3, 15),
('Corpo de Borboleta', 'Valeo', 500.00, 3, 10),
('Rodízio de Pneus', 'Michelin', 30.00, 3, 25),
('Sensor de Estacionamento', 'Valeo', 220.00, 3, 18),
('Bico Injetor', 'Bosch', 110.00, 3, 22),
('Filtro de Ar', 'Mann', 40.00, 3, 35),
('Mangueira de Radiador', 'Goodyear', 45.00, 3, 12),
('Disco de Freio Traseiro', 'TRW', 210.00, 3, 15),
('Lâmpada de Farol', 'Philips', 20.00, 3, 30),
('Cabo de Velas', 'NGK', 18.00, 3, 40),
('Filtro de Óleo', 'Bosch', 45.00, 1, 30),
('Pneu 185/70 R14', 'Pirelli', 310.00, 1, 25),
('Pastilha de Freio Dianteira', 'Brembo', 170.00, 1, 32),
('Bateria 60Ah', 'Moura', 460.00, 1, 18),
('Velas de Ignição', 'NGK', 28.00, 1, 40),
('Filtro de Ar', 'Mann', 37.00, 1, 25),
('Correia Dentada', 'Gates', 90.00, 1, 20),
('Amortecedor', 'Monroe', 210.00, 1, 12),
('Parafuso de Rodas', 'Schulz', 12.00, 1, 300),
('Radiador', 'Valeo', 630.00, 1, 15),
('Tampa de Óleo', 'Bosch', 32.00, 1, 22),
('Lâmpada de Farol', 'Philips', 18.00, 1, 35),
('Cabo de Vela', 'NGK', 20.00, 1, 50),
('Filtro de Combustível', 'Mann', 30.00, 1, 38),
('Amortecedor Dianteiro', 'Monroe', 180.00, 1, 15),
('Vela de Ignição Iridium', 'NGK', 36.00, 1, 10),
('Corpo de Borboleta', 'Valeo', 510.00, 1, 8),
('Kit de Embreagem', 'Valeo', 360.00, 1, 20),
('Sensor de Estacionamento', 'Valeo', 250.00, 1, 30),
('Disco de Freio', 'TRW', 220.00, 1, 18),
('Filtro de Ar', 'Mann', 40.00, 2, 28),
('Pneu 195/70 R15', 'Pirelli', 325.00, 2, 22),
('Bateria 70Ah', 'Moura', 530.00, 2, 18),
('Amortecedor Traseiro', 'Monroe', 220.00, 2, 16),
('Pastilha de Freio Traseira', 'Brembo', 160.00, 2, 30),
('Lâmpada de Farol LED', 'Philips', 22.00, 2, 25),
('Cabo de Velas', 'NGK', 19.00, 2, 40),
('Bico Injetor', 'Bosch', 120.00, 2, 22),
('Kit de Embreagem', 'Sachs', 380.00, 2, 24),
('Radiador', 'Valeo', 640.00, 2, 20),
('Vela de Ignição', 'NGK', 24.00, 2, 30),
('Correia Poly-V', 'Gates', 75.00, 2, 25),
('Disco de Freio Dianteiro', 'TRW', 190.00, 2, 15),
('Amortecedor Dianteiro', 'Monroe', 210.00, 2, 20),
('Filtro de Combustível', 'Bosch', 35.00, 2, 33),
('Bateria 80Ah', 'Heliar', 620.00, 2, 10),
('Lâmpada de Farol', 'Philips', 17.00, 2, 38),
('Tampa de Óleo', 'Bosch', 35.00, 2, 12),
('Parafuso de Rodas', 'Schulz', 11.00, 2, 300),
('Sensor de Estacionamento', 'Valeo', 270.00, 2, 15),
('Filtro de Óleo', 'Bosch', 47.00, 3, 28),
('Pneu 175/65 R15', 'Michelin', 315.00, 3, 25),
('Pastilha de Freio Traseira', 'Brembo', 145.00, 3, 35),
('Bateria 55Ah', 'Moura', 490.00, 3, 20),
('Velas de Ignição', 'NGK', 26.00, 3, 30),
('Filtro de Ar', 'Mann', 36.00, 3, 22),
('Correia Dentada', 'Gates', 92.00, 3, 18),
('Amortecedor', 'Monroe', 200.00, 3, 12),
('Parafuso de Rodas', 'Schulz', 13.00, 3, 300),
('Radiador', 'Valeo', 620.00, 3, 10),
('Tampa de Óleo', 'Bosch', 34.00, 3, 20),
('Lâmpada de Farol', 'Philips', 19.00, 3, 28),
('Cabo de Vela', 'NGK', 21.00, 3, 38),
('Filtro de Combustível', 'Bosch', 36.00, 3, 33),
('Amortecedor Dianteiro', 'Monroe', 210.00, 3, 18),
('Vela de Ignição Iridium', 'NGK', 37.00, 3, 16),
('Corpo de Borboleta', 'Valeo', 520.00, 3, 12),
('Kit de Embreagem', 'Valeo', 370.00, 3, 20),
('Sensor de Estacionamento', 'Valeo', 230.00, 3, 25),
('Disco de Freio', 'TRW', 210.00, 3, 22),
('Filtro de Ar Condicionado', 'Mann', 50.00, 3, 28),
('Rodízio de Pneus', 'Michelin', 29.00, 3, 18),
('Mangueira de Radiador', 'Goodyear', 46.00, 3, 14),
('Bico Injetor', 'Bosch', 110.00, 3, 30),
('Limpador de Parabrisa', 'Bosch', 45.00, 3, 40),
('Disco de Freio Traseiro', 'TRW', 220.00, 3, 18),
('Cabo de Vela', 'NGK', 21.00, 3, 33),
('Pneu 205/55 R16', 'Pirelli', 335.00, 3, 23),
('Bateria 80Ah', 'Heliar', 630.00, 3, 10),
('Filtro de Óleo', 'Mann', 43.00, 3, 25),
('Amortecedor Traseiro', 'Monroe', 225.00, 3, 15),
('Correia Poly-V', 'Gates', 78.00, 3, 20),
('Velas de Ignição', 'NGK', 26.00, 3, 38),
('Sensor de Estacionamento', 'Valeo', 240.00, 3, 18),
('Tampa de Óleo', 'Bosch', 36.00, 3, 10),
('Rodízio de Pneus', 'Michelin', 28.00, 3, 32),
('Lâmpada de Farol', 'Philips', 16.00, 3, 35),
('Filtro de Combustível', 'Bosch', 37.00, 3, 22),
('Pastilha de Freio', 'Brembo', 155.00, 3, 40),
('Disco de Freio Dianteiro', 'TRW', 200.00, 3, 30),
('Amortecedor Dianteiro', 'Monroe', 190.00, 3, 28),
('Bico Injetor', 'Bosch', 125.00, 3, 20);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_estoque_veiculo (modelo, marca, cor, preco, id_filial, quantidade) VALUES
('Corolla', 'Toyota', 'Preto', 85000.00, 1, 4),
('Corolla', 'Toyota', 'Branco', 85000.00, 1, 5),
('Corolla', 'Toyota', 'Vermelho', 85000.00, 1, 3),
('Hilux', 'Toyota', 'Preto', 210000.00, 1, 3),
('Hilux', 'Toyota', 'Branco', 210000.00, 1, 2),
('Hilux', 'Toyota', 'Vermelho', 210000.00, 1, 4),
('RX 350', 'Lexus', 'Preto', 300000.00, 1, 2),
('RX 350', 'Lexus', 'Branco', 300000.00, 1, 3),
('RX 350', 'Lexus', 'Vermelho', 300000.00, 1, 1),
('Camry', 'Toyota', 'Preto', 95000.00, 1, 5),
('Camry', 'Toyota', 'Branco', 95000.00, 1, 4),
('Camry', 'Toyota', 'Vermelho', 95000.00, 1, 3),
('Corolla', 'Toyota', 'Preto', 85000.00, 2, 5),
('Corolla', 'Toyota', 'Branco', 85000.00, 2, 4),
('Corolla', 'Toyota', 'Vermelho', 85000.00, 2, 3),
('Hilux', 'Toyota', 'Preto', 210000.00, 2, 2),
('Hilux', 'Toyota', 'Branco', 210000.00, 2, 3),
('Hilux', 'Toyota', 'Vermelho', 210000.00, 2, 3),
('RX 350', 'Lexus', 'Preto', 300000.00, 2, 1),
('RX 350', 'Lexus', 'Branco', 300000.00, 2, 2),
('RX 350', 'Lexus', 'Vermelho', 300000.00, 2, 2),
('Camry', 'Toyota', 'Preto', 95000.00, 2, 4),
('Camry', 'Toyota', 'Branco', 95000.00, 2, 3),
('Camry', 'Toyota', 'Vermelho', 95000.00, 2, 2),
('Corolla', 'Toyota', 'Preto', 85000.00, 3, 4),
('Corolla', 'Toyota', 'Branco', 85000.00, 3, 5),
('Corolla', 'Toyota', 'Vermelho', 85000.00, 3, 3),
('Hilux', 'Toyota', 'Preto', 210000.00, 3, 4),
('Hilux', 'Toyota', 'Branco', 210000.00, 3, 3),
('Hilux', 'Toyota', 'Vermelho', 210000.00, 3, 5),
('RX 350', 'Lexus', 'Preto', 300000.00, 3, 2),
('RX 350', 'Lexus', 'Branco', 300000.00, 3, 4),
('RX 350', 'Lexus', 'Vermelho', 300000.00, 3, 2),
('Camry', 'Toyota', 'Preto', 95000.00, 3, 2),
('Camry', 'Toyota', 'Branco', 95000.00, 3, 3),
('Camry', 'Toyota', 'Vermelho', 95000.00, 3, 4);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_cadastro_veiculo (modelo, marca, ano, placa, cor, id_cliente, id_filial, quantidade) VALUES
('Civic', 'Honda', 2022, 'ABC1235', 'Preto', 21, 1, 1),
('Corolla', 'Toyota', 2021, 'DEF5679', 'Branco', 22, 1, 1),
('Model S', 'Tesla', 2023, 'GHI9102', 'Vermelho', 23, 1, 1),
('Mustang', 'Ford', 2020, 'JKL1123', 'Azul', 24, 1, 1),
('A4', 'Audi', 2022, 'MNO3345', 'Prata', 25, 1, 1),
('Wrangler', 'Jeep', 2021, 'PQR5567', 'Verde', 26, 1, 1),
('320i', 'BMW', 2023, 'STU7789', 'Preto', 27, 1, 1),
('Cayenne', 'Porsche', 2020, 'VWX9901', 'Cinza', 28, 1, 1),
('C3', 'Citroën', 2022, 'YZA1124', 'Azul', 29, 1, 1),
('Hilux', 'Toyota', 2021, 'BCD2346', 'Branco', 30, 1, 1),
('Compass', 'Jeep', 2020, 'EFG3457', 'Preto', 31, 1, 1),
('Gol', 'Volkswagen', 2019, 'HIJ4568', 'Prata', 32, 1, 1),
('Onix', 'Chevrolet', 2021, 'KLM5679', 'Branco', 33, 1, 1),
('HB20', 'Hyundai', 2022, 'NOP6790', 'Preto', 34, 1, 1),
('Sandero', 'Renault', 2023, 'QRS7891', 'Vermelho', 35, 1, 1),
('Kwid', 'Renault', 2020, 'TUV8902', 'Cinza', 36, 1, 1),
('Ranger', 'Ford', 2021, 'WXY9013', 'Azul', 37, 1, 1),
('Kicks', 'Nissan', 2022, 'ZAB0124', 'Verde', 38, 1, 1),
('Tiguan', 'Volkswagen', 2023, 'CDE1235', 'Preto', 39, 1, 1),
('Civic', 'Honda', 2021, 'FGH2346', 'Branco', 40, 1, 1),
('Civic', 'Honda', 2022, 'ABC1236', 'Preto', 41, 2, 1),
('Corolla', 'Toyota', 2021, 'DEF5680', 'Branco', 42, 2, 1),
('Model S', 'Tesla', 2023, 'GHI9103', 'Vermelho', 43, 2, 1),
('Mustang', 'Ford', 2020, 'JKL1124', 'Azul', 44, 2, 1),
('A4', 'Audi', 2022, 'MNO3346', 'Prata', 45, 2, 1),
('Wrangler', 'Jeep', 2021, 'PQR5568', 'Verde', 46, 2, 1),
('320i', 'BMW', 2023, 'STU7790', 'Preto', 47, 2, 1),
('Cayenne', 'Porsche', 2020, 'VWX9902', 'Cinza', 48, 2, 1),
('C3', 'Citroën', 2022, 'YZA1125', 'Azul', 49, 2, 1),
('Hilux', 'Toyota', 2021, 'BCD2347', 'Branco', 50, 2, 1),
('Compass', 'Jeep', 2020, 'EFG3458', 'Preto', 51, 2, 1),
('Gol', 'Volkswagen', 2019, 'HIJ4569', 'Prata', 52, 2, 1),
('Onix', 'Chevrolet', 2021, 'KLM5680', 'Branco', 53, 2, 1),
('HB20', 'Hyundai', 2022, 'NOP6791', 'Preto', 54, 2, 1),
('Sandero', 'Renault', 2023, 'QRS7892', 'Vermelho', 55, 2, 1),
('Kwid', 'Renault', 2020, 'TUV8903', 'Cinza', 56, 2, 1),
('Ranger', 'Ford', 2021, 'WXY9014', 'Azul', 57, 2, 1),
('Kicks', 'Nissan', 2022, 'ZAB0125', 'Verde', 58, 2, 1),
('Tiguan', 'Volkswagen', 2023, 'CDE1236', 'Preto', 59, 2, 1),
('Civic', 'Honda', 2021, 'FGH2347', 'Branco', 60, 2, 1),
('Civic', 'Honda', 2022, 'ABC1237', 'Preto', 1, 3, 1),
('Corolla', 'Toyota', 2021, 'DEF5681', 'Branco', 2, 3, 1),
('Model S', 'Tesla', 2023, 'GHI9104', 'Vermelho', 63, 3, 1),
('Mustang', 'Ford', 2020, 'JKL1125', 'Azul', 4, 3, 1),
('A4', 'Audi', 2022, 'MNO3347', 'Prata', 5, 3, 1),
('Wrangler', 'Jeep', 2021, 'PQR5569', 'Verde', 6, 3, 1),
('320i', 'BMW', 2023, 'STU7791', 'Preto', 7, 3, 1),
('Cayenne', 'Porsche', 2020, 'VWX9903', 'Cinza', 8, 3, 1),
('C3', 'Citroën', 2022, 'YZA1126', 'Azul', 9, 3, 1),
('Hilux', 'Toyota', 2021, 'BCD2348', 'Branco', 10, 3, 1),
('Compass', 'Jeep', 2020, 'EFG3459', 'Preto', 11, 3, 1),
('Gol', 'Volkswagen', 2019, 'HIJ4570', 'Prata', 12, 3, 1),
('Onix', 'Chevrolet', 2021, 'KLM5681', 'Branco', 13, 3, 1),
('HB20', 'Hyundai', 2022, 'NOP6792', 'Preto', 14, 3, 1),
('Sandero', 'Renault', 2023, 'QRS7893', 'Vermelho', 15, 3, 1),
('Kwid', 'Renault', 2020, 'TUV8904', 'Cinza', 16, 3, 1);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO tb_servico_prestado (descricao, id_veiculo, id_funcionario, id_cliente, id_filial, tipo_servico, data_servico, valor) VALUES
('Troca de óleo e filtro', 16, 4, 1, 1, 'Manutenção', '2024-01-25 09:30:00', 250.00),
('Vistoria pré-venda', 17, 5, 2, 1, 'Vistoria', '2024-02-12 11:00:00', 500.00),
('Limpeza completa', 18, 6, 3, 1, 'Limpeza', '2024-03-08 14:30:00', 150.00),
('Alinhamento e balanceamento', 19, 7, 4, 1, 'Manutenção', '2024-04-15 10:00:00', 300.00),
('Revisão de 10.000 km', 20, 8, 5, 1, 'Manutenção', '2024-05-10 13:00:00', 700.00),
('Troca de pneus', 21, 9, 6, 1, 'Manutenção', '2024-06-22 15:00:00', 1200.00),
('Vistoria de segurança', 22, 10, 7, 1, 'Vistoria', '2024-07-13 09:00:00', 400.00),
('Lavagem de motor', 23, 11, 8, 1, 'Limpeza', '2024-08-18 12:00:00', 200.00),
('Reparação de pintura', 24, 12, 9, 1, 'Manutenção', '2024-09-25 16:00:00', 1000.00),
('Vistoria para seguro', 25, 13, 10, 1, 'Vistoria', '2024-10-05 10:00:00', 600.00),
('Descontaminação de ar condicionado', 26, 14, 11, 1, 'Limpeza', '2024-11-03 14:00:00', 250.00),
('Troca de bateria', 27, 15, 12, 1, 'Manutenção', '2024-12-10 08:00:00', 450.00),
('Vistoria anual', 28, 16, 13, 1, 'Vistoria', '2024-01-15 11:00:00', 500.00),
('Limpeza interna detalhada', 29, 17, 14, 1, 'Limpeza', '2024-02-25 09:00:00', 300.00),
('Troca de amortecedores', 30, 18, 15, 1, 'Manutenção', '2024-03-20 15:00:00', 800.00),
('Troca de óleo e filtro', 31, 4, 16, 2, 'Manutenção', '2024-01-30 09:30:00', 250.00),
('Vistoria pré-venda', 32, 5, 17, 2, 'Vistoria', '2024-02-18 11:00:00', 500.00),
('Limpeza completa', 33, 6, 18, 2, 'Limpeza', '2024-03-05 14:30:00', 150.00),
('Alinhamento e balanceamento', 34, 7, 19, 2, 'Manutenção', '2024-04-10 10:00:00', 300.00),
('Revisão de 10.000 km', 35, 8, 20, 2, 'Manutenção', '2024-05-07 13:00:00', 700.00),
('Troca de pneus', 36, 9, 21, 2, 'Manutenção', '2024-06-18 15:00:00', 1200.00),
('Vistoria de segurança', 37, 10, 22, 2, 'Vistoria', '2024-07-10 09:00:00', 400.00),
('Lavagem de motor', 38, 11, 23, 2, 'Limpeza', '2024-08-20 12:00:00', 200.00),
('Reparação de pintura', 39, 12, 24, 2, 'Manutenção', '2024-09-30 16:00:00', 1000.00),
('Vistoria para seguro', 40, 13, 25, 2, 'Vistoria', '2024-10-15 10:00:00', 600.00),
('Descontaminação de ar condicionado', 41, 14, 26, 2, 'Limpeza', '2024-11-02 14:00:00', 250.00),
('Troca de bateria', 42, 15, 27, 2, 'Manutenção', '2024-12-05 08:00:00', 450.00),
('Vistoria anual', 43, 16, 28, 2, 'Vistoria', '2024-01-12 11:00:00', 500.00),
('Limpeza interna detalhada', 44, 17, 29, 2, 'Limpeza', '2024-02-18 09:00:00', 300.00),
('Troca de amortecedores', 45, 18, 30, 2, 'Manutenção', '2024-03-15 15:00:00', 800.00),
('Troca de óleo e filtro', 46, 4, 31, 3, 'Manutenção', '2024-01-28 09:30:00', 250.00),
('Vistoria pré-venda', 47, 5, 32, 3, 'Vistoria', '2024-02-22 11:00:00', 500.00),
('Limpeza completa', 48, 6, 33, 3, 'Limpeza', '2024-03-10 14:30:00', 150.00),
('Alinhamento e balanceamento', 49, 7, 34, 3, 'Manutenção', '2024-04-12 10:00:00', 300.00),
('Revisão de 10.000 km', 50, 8, 35, 3, 'Manutenção', '2024-05-12 13:00:00', 700.00),
('Troca de pneus', 51, 9, 36, 3, 'Manutenção', '2024-06-26 15:00:00', 1200.00),
('Vistoria de segurança', 52, 10, 37, 3, 'Vistoria', '2024-07-18 09:00:00', 400.00),
('Lavagem de motor', 53, 11, 38, 3, 'Limpeza', '2024-08-25 12:00:00', 200.00),
('Reparação de pintura', 54, 12, 39, 3, 'Manutenção', '2024-09-20 16:00:00', 1000.00),
('Vistoria para seguro', 55, 13, 40, 3, 'Vistoria', '2024-10-10 10:00:00', 600.00),
('Descontaminação de ar condicionado', 56, 14, 41, 3, 'Limpeza', '2024-11-15 14:00:00', 250.00),
('Troca de bateria', 55, 15, 42, 3, 'Manutenção', '2024-12-03 08:00:00', 450.00),
('Vistoria anual', 52, 16, 43, 3, 'Vistoria', '2024-01-08 11:00:00', 500.00),
('Limpeza interna detalhada', 39, 17, 44, 3, 'Limpeza', '2024-02-20 09:00:00', 300.00),
('Troca de amortecedores', 10, 18, 45, 3, 'Manutenção', '2024-03-10 15:00:00', 800.00),
('Troca de óleo e filtro', 21, 4, 46, 1, 'Manutenção', '2024-01-10 09:30:00', 250.00),
('Vistoria pré-venda', 42, 5, 47, 1, 'Vistoria', '2024-02-08 11:00:00', 500.00),
('Limpeza completa', 53, 6, 48, 1, 'Limpeza', '2024-03-02 14:30:00', 150.00),
('Alinhamento e balanceamento', 24, 7, 49, 1, 'Manutenção', '2024-04-05 10:00:00', 300.00),
('Revisão de 10.000 km', 25, 8, 50, 1, 'Manutenção', '2024-05-12 13:00:00', 700.00),
('Troca de pneus', 26, 9, 51, 1, 'Manutenção', '2024-06-10 15:00:00', 1200.00),
('Vistoria de segurança', 27, 10, 52, 1, 'Vistoria', '2024-07-01 09:00:00', 400.00),
('Lavagem de motor', 18, 11, 53, 1, 'Limpeza', '2024-08-12 12:00:00', 200.00),
('Reparação de pintura', 19, 12, 54, 1, 'Manutenção', '2024-09-10 16:00:00', 1000.00),
('Vistoria para seguro', 10, 13, 55, 1, 'Vistoria', '2024-10-15 10:00:00', 600.00),
('Descontaminação de ar condicionado', 11, 14, 56, 1, 'Limpeza', '2024-11-02 14:00:00', 250.00),
('Troca de bateria', 2, 15, 57, 1, 'Manutenção', '2024-12-18 08:00:00', 450.00),
('Vistoria anual', 3, 16, 58, 1, 'Vistoria', '2024-01-20 11:00:00', 500.00),
('Limpeza interna detalhada', 4, 17, 59, 1, 'Limpeza', '2024-02-28 09:00:00', 300.00),
('Troca de amortecedores', 5, 18, 60, 1, 'Manutenção', '2024-03-15 15:00:00', 800.00),
('Troca de óleo e filtro', 6, 4, 61, 2, 'Manutenção', '2024-01-18 09:30:00', 250.00),
('Vistoria pré-venda', 7, 5, 62, 2, 'Vistoria', '2024-02-25 11:00:00', 500.00),
('Limpeza completa',38, 6, 63, 2, 'Limpeza', '2024-03-15 14:30:00', 150.00),
('Alinhamento e balanceamento', 39, 7, 64, 2, 'Manutenção', '2024-04-18 10:00:00', 300.00),
('Revisão de 10.000 km', 40, 8, 65, 2, 'Manutenção', '2024-05-25 13:00:00', 700.00),
('Troca de pneus', 41, 9, 66, 2, 'Manutenção', '2024-06-22 15:00:00', 1200.00),
('Vistoria de segurança', 12, 10, 67, 2, 'Vistoria', '2024-07-18 09:00:00', 400.00),
('Lavagem de motor', 3, 11, 68, 2, 'Limpeza', '2024-08-21 12:00:00', 200.00);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Janeiro
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 1, 1, 1, '2023-01-01 10:00:00', 85000.00),
(2, 2, 1, 2, '2023-01-02 10:00:00', 95000.00),
(3, 3, 1, 3, '2023-01-03 10:00:00', 100000.00),
(4, 4, 1, 4, '2023-01-04 10:00:00', 105000.00),
(5, 5, 1, 5, '2023-01-05 10:00:00', 120000.00),
(6, 6, 1, 6, '2023-01-06 10:00:00', 130000.00),
(7, 7, 1, 7, '2023-01-07 10:00:00', 140000.00),
(8, 8, 1, 8, '2023-01-08 10:00:00', 150000.00),
(9, 9, 1, 9, '2023-01-09 10:00:00', 155000.00),
(10, 10, 1, 10, '2023-01-10 10:00:00', 160000.00);

-- Fevereiro
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(11, 11, 1, 11, '2023-02-01 10:00:00', 85000.00),
(12, 12, 1, 12, '2023-02-02 10:00:00', 90000.00),
(13, 13, 1, 13, '2023-02-03 10:00:00', 95000.00),
(14, 14, 1, 14, '2023-02-04 10:00:00', 100000.00),
(15, 15, 1, 15, '2023-02-05 10:00:00', 110000.00),
(16, 16, 1, 16, '2023-02-06 10:00:00', 115000.00),
(17, 17, 1, 17, '2023-02-07 10:00:00', 120000.00),
(18, 18, 1, 18, '2023-02-08 10:00:00', 125000.00),
(19, 19, 1, 19, '2023-02-09 10:00:00', 130000.00),
(20, 20, 1, 20, '2023-02-10 10:00:00', 135000.00);

-- Março
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(21, 21, 1, 21, '2023-03-01 10:00:00', 95000.00),
(22, 22, 1, 22, '2023-03-02 10:00:00', 100000.00),
(23, 23, 1, 23, '2023-03-03 10:00:00', 105000.00),
(24, 24, 1, 24, '2023-03-04 10:00:00', 110000.00),
(25, 25, 1, 25, '2023-03-05 10:00:00', 115000.00),
(26, 26, 1, 26, '2023-03-06 10:00:00', 120000.00),
(27, 27, 1, 27, '2023-03-07 10:00:00', 125000.00),
(28, 28, 1, 28, '2023-03-08 10:00:00', 130000.00),
(29, 29, 1, 29, '2023-03-09 10:00:00', 135000.00),
(30, 30, 1, 30, '2023-03-10 10:00:00', 140000.00);

-- Abril
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(11, 1, 1, 1, '2023-04-01 10:00:00', 150000.00),
(12, 2, 1, 2, '2023-04-02 10:00:00', 155000.00),
(13, 3, 1, 3, '2023-04-03 10:00:00', 160000.00),
(14, 4, 1, 4, '2023-04-04 10:00:00', 165000.00),
(15, 5, 1, 5, '2023-04-05 10:00:00', 170000.00),
(16, 6, 1, 6, '2023-04-06 10:00:00', 175000.00),
(17, 7, 1, 7, '2023-04-07 10:00:00', 180000.00),
(18, 8, 1, 8, '2023-04-08 10:00:00', 185000.00),
(19, 9, 1, 9, '2023-04-09 10:00:00', 190000.00),
(10, 10, 1, 10, '2023-04-10 10:00:00', 195000.00);

-- Maio
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 41, 1, 41, '2023-05-01 10:00:00', 200000.00),
(2, 42, 1, 42, '2023-05-02 10:00:00', 205000.00),
(3, 43, 1, 43, '2023-05-03 10:00:00', 210000.00),
(4, 44, 1, 44, '2023-05-04 10:00:00', 215000.00),
(5, 45, 1, 45, '2023-05-05 10:00:00', 220000.00),
(6, 46, 1, 46, '2023-05-06 10:00:00', 225000.00),
(7, 47, 1, 47, '2023-05-07 10:00:00', 230000.00),
(8, 48, 1, 48, '2023-05-08 10:00:00', 235000.00),
(9, 49, 1, 49, '2023-05-09 10:00:00', 240000.00),
(10, 50, 1, 50, '2023-05-10 10:00:00', 245000.00);

-- Janeiro
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 1, 1, 1, '2024-01-01 10:00:00', 85000.00),
(2, 2, 1, 2, '2024-01-02 10:00:00', 95000.00),
(3, 3, 1, 3, '2024-01-03 10:00:00', 100000.00),
(4, 4, 1, 4, '2024-01-04 10:00:00', 105000.00),
(5, 5, 1, 5, '2024-01-05 10:00:00', 120000.00),
(6, 6, 1, 6, '2024-01-06 10:00:00', 130000.00),
(7, 7, 1, 7, '2024-01-07 10:00:00', 140000.00),
(8, 8, 1, 8, '2024-01-08 10:00:00', 150000.00),
(9, 9, 1, 9, '2024-01-09 10:00:00', 155000.00),
(10, 10, 1, 10, '2024-01-10 10:00:00', 160000.00);

-- Fevereiro
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(11, 11, 1, 11, '2024-02-01 10:00:00', 85000.00),
(12, 12, 1, 12, '2024-02-02 10:00:00', 90000.00),
(13, 13, 1, 13, '2024-02-03 10:00:00', 95000.00),
(14, 14, 1, 14, '2024-02-04 10:00:00', 100000.00),
(15, 15, 1, 15, '2024-02-05 10:00:00', 110000.00),
(16, 16, 1, 16, '2024-02-06 10:00:00', 115000.00),
(17, 17, 1, 17, '2024-02-07 10:00:00', 120000.00),
(18, 18, 1, 18, '2024-02-08 10:00:00', 125000.00),
(19, 19, 1, 19, '2024-02-09 10:00:00', 130000.00),
(20, 20, 1, 20, '2024-02-10 10:00:00', 135000.00);

-- Março
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(21, 21, 1, 21, '2024-03-01 10:00:00', 95000.00),
(22, 22, 1, 22, '2024-03-02 10:00:00', 100000.00),
(23, 23, 1, 23, '2024-03-03 10:00:00', 105000.00),
(24, 24, 1, 24, '2024-03-04 10:00:00', 110000.00),
(25, 25, 1, 25, '2024-03-05 10:00:00', 115000.00),
(26, 26, 1, 26, '2024-03-06 10:00:00', 120000.00),
(27, 27, 1, 27, '2024-03-07 10:00:00', 125000.00),
(28, 28, 1, 28, '2024-03-08 10:00:00', 130000.00),
(29, 29, 1, 29, '2024-03-09 10:00:00', 135000.00),
(30, 30, 1, 30, '2024-03-10 10:00:00', 140000.00);

-- Abril
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 31, 1, 31, '2024-04-01 10:00:00', 150000.00),
(2, 32, 1, 32, '2024-04-02 10:00:00', 155000.00),
(3, 33, 1, 33, '2024-04-03 10:00:00', 160000.00),
(14, 34, 1, 34, '2024-04-04 10:00:00', 165000.00),
(15, 35, 1, 35, '2024-04-05 10:00:00', 170000.00),
(16, 36, 1, 36, '2024-04-06 10:00:00', 175000.00),
(16, 37, 1, 37, '2024-04-07 10:00:00', 180000.00),
(18, 38, 1, 38, '2024-04-08 10:00:00', 185000.00),
(18, 39, 1, 39, '2024-04-09 10:00:00', 190000.00),
(4, 40, 1, 40, '2024-04-10 10:00:00', 195000.00);

-- Maio
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(11, 41, 1, 41, '2024-05-01 10:00:00', 200000.00),
(22, 42, 1, 42, '2024-05-02 10:00:00', 205000.00),
(13, 43, 1, 43, '2024-05-03 10:00:00', 210000.00),
(4, 44, 1, 44, '2024-05-04 10:00:00', 215000.00),
(5, 45, 1, 45, '2024-05-05 10:00:00', 220000.00),
(6, 46, 1, 46, '2024-05-06 10:00:00', 225000.00),
(1, 47, 1, 47, '2024-05-07 10:00:00', 230000.00),
(2, 48, 1, 48, '2024-05-08 10:00:00', 235000.00),
(3, 49, 1, 49, '2024-05-09 10:00:00', 240000.00),
(1, 50, 1, 50, '2024-05-10 10:00:00', 245000.00);

-- Junho
INSERT INTO tb_venda_veiculo (id_veiculo, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 1, 1, 51, '2024-06-01 10:00:00', 85000.00),
(2, 2, 1, 52, '2024-06-02 10:00:00', 90000.00),
(1, 3, 1, 53, '2024-06-03 10:00:00', 95000.00),
(1, 4, 1, 54, '2024-06-04 10:00:00', 100000.00),
(1, 5, 1, 55, '2024-06-05 10:00:00', 105000.00),
(1, 6, 1, 56, '2024-06-06 10:00:00', 110000.00),
(1, 7, 1, 57, '2024-06-07 10:00:00', 115000.00),
(2, 8, 1, 58, '2024-06-08 10:00:00', 120000.00),
(1, 9, 1, 59, '2024-06-09 10:00:00', 125000.00),
(1, 10, 1, 60, '2024-06-10 10:00:00', 130000.00);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

INSERT INTO tb_venda_peca (id_peca, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 4, 1, 16, '2024-01-16 10:30:00', 270.00),
(2, 5, 2, 17, '2024-02-21 12:00:00', 330.00),
(3, 6, 3, 18, '2024-03-26 13:00:00', 180.00),
(4, 7, 1, 19, '2024-04-06 10:00:00', 460.00),
(5, 8, 2, 20, '2024-05-19 11:15:00', 50.00),
(6, 9, 3, 21, '2024-06-23 16:00:00', 45.00),
(7, 10, 1, 22, '2024-07-11 08:30:00', 95.00),
(8, 11, 2, 23, '2024-08-15 13:00:00', 210.00),
(9, 12, 3, 24, '2024-09-21 15:00:00', 12.00),
(10, 13, 1, 25, '2024-10-31 17:00:00', 620.00),
(1, 14, 2, 26, '2024-11-06 09:45:00', 330.00),
(2, 15, 3, 27, '2024-12-16 12:00:00', 30.00),
(3, 16, 1, 28, '2024-01-13 11:30:00', 460.00),
(4, 17, 2, 29, '2024-02-29 14:00:00', 610.00),
(5, 18, 3, 30, '2024-03-15 16:30:00', 35.00),
(6, 4, 1, 31, '2024-04-06 10:45:00', 40.00),
(7, 5, 2, 32, '2024-05-19 12:15:00', 90.00),
(8, 6, 3, 33, '2024-06-23 17:00:00', 220.00),
(9, 7, 1, 34, '2024-07-11 09:30:00', 15.00),
(10, 8, 2, 35, '2024-08-15 14:00:00', 610.00),
(1, 9, 3, 36, '2024-09-22 15:15:00', 330.00),
(2, 10, 1, 37, '2024-10-01 11:00:00', 250.00),
(3, 11, 2, 38, '2024-11-01 13:30:00', 320.00),
(4, 12, 3, 39, '2024-12-05 10:45:00', 25.00),
(5, 13, 1, 40, '2024-01-07 10:15:00', 180.00),
(6, 14, 2, 41, '2024-02-12 12:30:00', 150.00),
(7, 15, 3, 42, '2024-03-20 15:00:00', 100.00),
(8, 16, 1, 43, '2024-04-03 09:30:00', 40.00),
(9, 17, 2, 44, '2024-05-08 13:15:00', 200.00),
(10, 18, 3, 45, '2024-06-18 14:30:00', 85.00),
(1, 4, 1, 46, '2024-07-04 11:00:00', 45.00),
(2, 5, 2, 47, '2024-08-13 09:00:00', 170.00),
(3, 6, 3, 48, '2024-09-18 16:30:00', 30.00),
(4, 7, 1, 49, '2024-10-14 10:15:00', 200.00),
(5, 8, 2, 50, '2024-11-21 13:30:00', 80.00),
(6, 9, 3, 51, '2024-12-23 15:00:00', 250.00),
(7, 10, 1, 52, '2024-01-02 09:30:00', 30.00),
(8, 11, 2, 53, '2024-02-10 12:00:00', 500.00),
(9, 12, 3, 54, '2024-03-22 14:30:00', 70.00),
(10, 13, 1, 55, '2024-04-09 11:45:00', 550.00),
(1, 14, 2, 56, '2024-05-11 13:30:00', 200.00),
(2, 15, 3, 57, '2024-06-30 17:00:00', 50.00),
(3, 16, 1, 58, '2024-07-18 15:15:00', 100.00),
(4, 17, 2, 59, '2024-08-06 10:00:00', 25.00),
(5, 18, 3, 60, '2024-09-14 12:45:00', 450.00),
(6, 4, 1, 61, '2024-10-22 09:30:00', 75.00),
(7, 5, 2, 62, '2024-11-18 10:00:00', 400.00),
(8, 6, 3, 63, '2024-12-10 14:15:00', 100.00),
(9, 7, 1, 64, '2024-01-03 16:30:00', 350.00),
(10, 8, 2, 65, '2024-02-25 13:15:00', 50.00),
(1, 9, 3, 66, '2024-03-05 14:00:00', 150.00),
(2, 10, 1, 67, '2024-04-11 12:00:00', 380.00),
(3, 11, 2, 68, '2024-05-02 16:00:00', 120.00),
(4, 12, 3, 69, '2024-06-26 10:30:00', 60.00),
(5, 13, 1, 70, '2024-07-16 09:45:00', 500.00),
(6, 14, 2, 71, '2024-08-24 13:00:00', 80.00),
(7, 15, 3, 72, '2024-09-12 14:30:00', 550.00);

INSERT INTO tb_venda_peca (id_peca, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 4, 1, 1, '2023-01-02 10:30:00', 200.00),
(2, 5, 2, 2, '2023-01-10 14:00:00', 150.00),
(3, 6, 3, 3, '2023-01-15 16:30:00', 300.00),
(4, 7, 1, 4, '2023-01-22 09:45:00', 180.00),
(5, 8, 2, 5, '2023-01-29 12:30:00', 250.00),
(6, 9, 3, 6, '2023-02-05 11:15:00', 100.00),
(7, 10, 1, 7, '2023-02-12 13:00:00', 450.00),
(8, 11, 2, 8, '2023-02-20 14:30:00', 50.00),
(9, 12, 3, 9, '2023-02-28 16:00:00', 120.00),
(10, 13, 1, 10, '2023-03-03 09:00:00', 550.00),
(1, 14, 2, 11, '2023-03-07 11:30:00', 210.00),
(2, 15, 3, 12, '2023-03-15 10:45:00', 270.00),
(3, 16, 1, 13, '2023-03-21 12:00:00', 380.00),
(4, 17, 2, 14, '2023-03-29 13:30:00', 150.00),
(5, 18, 3, 15, '2023-04-05 10:30:00', 90.00),
(6, 4, 1, 16, '2023-04-12 14:00:00', 60.00),
(7, 5, 2, 17, '2023-04-18 12:00:00', 500.00),
(8, 6, 3, 18, '2023-04-25 15:00:00', 70.00),
(9, 7, 1, 19, '2023-05-02 11:30:00', 180.00),
(10, 8, 2, 20, '2023-05-09 13:30:00', 220.00),
(1, 9, 3, 21, '2023-05-17 14:00:00', 300.00),
(2, 10, 1, 22, '2023-05-23 10:45:00', 400.00),
(3, 11, 2, 23, '2023-06-02 16:30:00', 80.00),
(4, 12, 3, 24, '2023-06-08 15:00:00', 500.00),
(5, 13, 1, 25, '2023-06-14 10:30:00', 250.00),
(6, 14, 2, 26, '2023-06-21 13:00:00', 130.00),
(7, 15, 3, 27, '2023-06-29 14:45:00', 450.00),
(8, 16, 1, 28, '2023-07-05 11:00:00', 55.00),
(9, 17, 2, 29, '2023-07-12 12:30:00', 250.00),
(10, 18, 3, 30, '2023-07-19 10:00:00', 370.00),
(1, 4, 1, 31, '2023-07-25 16:00:00', 80.00),
(2, 5, 2, 32, '2023-08-01 13:30:00', 150.00),
(3, 6, 3, 33, '2023-08-06 11:15:00', 230.00),
(4, 7, 1, 34, '2023-08-14 09:30:00', 300.00),
(5, 8, 2, 35, '2023-08-20 12:00:00', 90.00),
(6, 9, 3, 36, '2023-08-28 14:30:00', 120.00),
(7, 10, 1, 37, '2023-09-05 11:45:00', 350.00),
(8, 11, 2, 38, '2023-09-11 15:00:00', 450.00),
(9, 12, 3, 39, '2023-09-17 13:30:00', 200.00),
(10, 13, 1, 40, '2023-09-24 12:15:00', 80.00),
(1, 14, 2, 41, '2023-10-01 10:00:00', 150.00),
(2, 15, 3, 42, '2023-10-09 16:30:00', 500.00),
(3, 16, 1, 43, '2023-10-15 14:00:00', 200.00),
(4, 17, 2, 44, '2023-10-23 12:30:00', 100.00),
(5, 18, 3, 45, '2023-11-01 10:15:00', 250.00),
(6, 4, 1, 46, '2023-11-07 13:00:00', 170.00),
(7, 5, 2, 47, '2023-11-14 15:30:00', 300.00),
(8, 6, 3, 48, '2023-11-22 11:30:00', 80.00),
(9, 7, 1, 49, '2023-11-28 14:00:00', 550.00),
(10, 8, 2, 50, '2023-12-05 10:00:00', 250.00);

INSERT INTO tb_venda_peca (id_peca, id_funcionario, id_filial, id_cliente, data_venda, valor_total) VALUES
(1, 4, 1, 51, '2023-12-12 10:30:00', 450.00),
(2, 5, 2, 52, '2023-12-15 12:00:00', 200.00),
(3, 6, 3, 53, '2023-12-18 14:00:00', 300.00),
(4, 7, 1, 54, '2023-12-20 16:30:00', 100.00),
(5, 8, 2, 55, '2023-12-22 13:30:00', 180.00),
(6, 9, 3, 56, '2023-12-24 12:00:00', 350.00),
(7, 10, 1, 57, '2023-12-27 14:00:00', 120.00),
(8, 11, 2, 58, '2023-12-29 11:00:00', 220.00),
(9, 12, 3, 59, '2023-12-30 15:30:00', 550.00),
(10, 13, 1, 60, '2023-12-31 16:00:00', 80.00),
(1, 14, 2, 61, '2023-11-04 10:15:00', 200.00),
(2, 15, 3, 62, '2023-11-08 13:00:00', 250.00),
(3, 16, 1, 63, '2023-11-12 16:00:00', 300.00),
(4, 17, 2, 64, '2023-11-14 12:30:00', 150.00),
(5, 18, 3, 65, '2023-11-17 11:45:00', 120.00),
(6, 4, 1, 66, '2023-11-21 14:30:00', 450.00),
(7, 5, 2, 67, '2023-11-25 15:00:00', 250.00),
(8, 6, 3, 68, '2023-11-27 10:00:00', 100.00),
(9, 7, 1, 69, '2023-10-02 13:00:00', 200.00),
(10, 8, 2, 70, '2023-10-05 12:30:00', 150.00),
(1, 9, 3, 71, '2023-10-07 14:15:00', 300.00),
(2, 10, 1, 72, '2023-10-09 10:45:00', 450.00),
(3, 11, 2, 73, '2023-10-12 16:00:00', 180.00),
(4, 12, 3, 74, '2023-10-15 13:30:00', 500.00),
(5, 13, 1, 75, '2023-10-18 12:00:00', 70.00),
(6, 14, 2, 76, '2023-10-20 11:00:00', 120.00),
(7, 15, 3, 77, '2023-10-23 14:30:00', 250.00),
(8, 16, 1, 78, '2023-10-25 13:00:00', 80.00),
(9, 17, 2, 79, '2023-09-02 11:15:00', 100.00),
(10, 18, 3, 80, '2023-09-04 12:30:00', 200.00),
(1, 4, 1, 81, '2023-09-06 13:45:00', 300.00),
(2, 5, 2, 82, '2023-09-08 10:00:00', 150.00),
(3, 6, 3, 83, '2023-09-10 15:30:00', 200.00),
(4, 7, 1, 84, '2023-09-13 12:30:00', 500.00),
(5, 8, 2, 85, '2023-09-15 14:00:00', 250.00),
(6, 9, 3, 86, '2023-09-17 16:30:00', 350.00),
(7, 10, 1, 87, '2023-09-19 10:00:00', 80.00),
(8, 11, 2, 88, '2023-09-22 11:30:00', 300.00),
(9, 12, 3, 89, '2023-09-24 13:00:00', 220.00),
(10, 13, 1, 90, '2023-09-26 14:00:00', 120.00),
(1, 14, 2, 91, '2023-08-01 12:15:00', 200.00),
(2, 15, 3, 92, '2023-08-03 13:45:00', 100.00),
(3, 16, 1, 93, '2023-08-05 14:00:00', 400.00),
(4, 17, 2, 94, '2023-08-08 15:30:00', 450.00),
(5, 18, 3, 95, '2023-08-12 12:30:00', 200.00),
(6, 4, 1, 96, '2023-08-15 13:00:00', 150.00),
(7, 5, 2, 97, '2023-08-18 14:00:00', 300.00),
(8, 6, 3, 98, '2023-08-21 11:30:00', 80.00),
(9, 7, 1, 99, '2023-08-25 10:15:00', 500.00),
(10, 8, 2, 100, '2023-08-29 12:45:00', 120.00);
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE historico_salario(
	id_historico INT PRIMARY KEY AUTO_INCREMENT,
    id_funcionario INT,
    salario_antigo DECIMAL(10,2),
    salario_novo DECIMAL(10,2),
    data_alteracao DATETIME,
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario(id_funcionario)
);

-- -------------------------------------------------- PROCEDURE'S -------------------------------------------------------------------------------
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
END $$
DELIMITER ;
CALL cadastra_funcionario('Igor', '15154', 'ewdd', 4554, '2024-04-05', 1, 1);
 SELECT * FROM tb_funcionario;

DELIMITER $$
CREATE PROCEDURE cadastra_peca(
    IN p_nome VARCHAR(255),
    IN  p_fabricante VARCHAR(100),
    IN p_preco DECIMAL(10,2),
    IN p_id_filial INT,
    IN p_quantidade INT
)
BEGIN 
    INSERT INTO tb_estoque_peca (nome, fabricante, preco, id_filial, quantidade) 
    VALUES (p_nome, p_fabricante, p_preco, p_id_filial, p_quantidade);

    SELECT * FROM tb_estoque_peca 
    ORDER BY id_peca DESC
    LIMIT 1;
END $$
DELIMITER ;

CALL cadastra_peca('Chave ', 'Bosch', 15.00, 1, 15);

DELIMITER $$
CREATE PROCEDURE aumentarsalario(
	a_id INT, 
    a_aumento DECIMAL(10,2))
BEGIN
	DECLARE f_salario_antigo DECIMAL(10,2);
    DECLARE f_salario_novo DECIMAL(10,2);
    
    SELECT salario INTO f_salario_antigo FROM tb_funcionario
    WHERE id_funcionario = a_id;
  
    SET f_salario_novo = f_salario_antigo * (1 + (a_aumento/100));
    
    UPDATE tb_funcionario
    SET salario = f_salario_novo
    WHERE id_funcionario = a_id;
    
    INSERT INTO historico_salario
    (id_funcionario,salario_antigo,salario_novo,data_alteracao)
    VALUES
    (a_id,f_salario_antigo,f_salario_novo,curdate());
    SELECT f.nome, CONCAT('R$ ', FORMAT(salario_antigo,2,'de_DE')) as salario_antigo, CONCAT('R$ ', FORMAT(salario_novo,2,'de_DE')) as salario_novo FROM tb_funcionario as f
	INNER JOIN historico_salario as h ON f.id_funcionario = h.id_funcionario;
    
END $$
DELIMITER ;

CALL aumentarsalario(5, 15);

DELIMITER $$
CREATE FUNCTION calculadesconto(preco DECIMAL(10,2),desconto DEC(10,2))
RETURNS DEC(10,2) DETERMINISTIC
BEGIN
	RETURN preco - (preco*(desconto/100));
END $$
DELIMITER ;
-- ------------------------------------------------------------------------------ PROCEDIMENTOS -------------------------------------------------------------------------------------------------------------
# INICIO DA FUNÇÃO
-- ------------------------------------------------------------------------------- FUNÇÃO --------------------------------------------------------------------------------------------------------------------
SELECT modelo, marca, CONCAT('R$ ', FORMAT(preco,2, 'de_DE')) as preco_antigo, CONCAT('R$ ', FORMAT(calculadesconto(preco,20),2, 'de_DE')) as preco_desconto FROM tb_estoque_veiculo;
-- ------------------------------------------------------------------------------- FUNÇÃO -------------------------------------------------------------------------------------------------------------------
# FIM DA FUNÇÃO
-- -------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------- Consultas ---------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------

-- 01 Exibir todos os clientes cadastrados com seus telefones e endereços:

SELECT c.nome, c.cpf, t.telefone, e.rua, e.numero, e.bairro, e.cidade, e.estado, e.cep
FROM tb_cliente c
LEFT JOIN tb_telefone_cliente t ON c.id_cliente = t.id_cliente
LEFT JOIN tb_endereco_cliente e ON c.id_cliente = e.id_cliente;

-- 02 Obter todos os fornecedores com seus telefones:

SELECT f.nome, f.cnpj, t.telefone
FROM tb_fornecedor f
LEFT JOIN tb_telefone_fornecedor t ON f.id_fornecedor = t.id_fornecedor;

-- 03 Listar todos os funcionários e seus respectivos setores e filiais:

SELECT f.nome, f.cargo, s.nome AS setor, fi.nome AS filial
FROM tb_funcionario f
JOIN tb_setor s ON f.id_setor = s.id_setor
JOIN tb_filial fi ON f.id_filial = fi.id_filial;

-- 04 Contar a quantidade de veículos em estoque em cada filial:

SELECT fi.nome AS filial, COUNT(ev.id_estoque) AS quantidade_veiculos
FROM tb_estoque_veiculo ev
JOIN tb_filial fi ON ev.id_filial = fi.id_filial
GROUP BY fi.id_filial;

-- 05 Exibir os veículos vendidos e o valor total da venda:

SELECT v.id_venda_veiculo, ve.modelo, ve.marca, v.valor_total, v.data_venda
FROM tb_venda_veiculo v
JOIN tb_estoque_veiculo ev ON v.id_veiculo = ev.id_estoque
JOIN tb_cadastro_veiculo ve ON ev.id_estoque = ve.id_veiculo;

-- 06 Consultar o histórico de serviços prestados a um veículo:
-- *******
SELECT s.descricao, s.tipo_servico, s.valor, s.data_servico
FROM tb_servico_prestado s
JOIN tb_cadastro_veiculo v ON s.id_veiculo = v.id_veiculo
WHERE v.id_veiculo = 2; -- Substitua por um id de veículo válido

-- 07 Exibir o total de vendas de peças por cliente:

SELECT c.nome, SUM(vp.valor_total) AS total_vendas_peca
FROM tb_venda_peca vp
JOIN tb_cliente c ON vp.id_cliente = c.id_cliente
GROUP BY c.id_cliente;

-- 08 Exibir a quantidade de peças em estoque por filial:

SELECT fi.nome AS filial, COUNT(ep.id_peca) AS quantidade_pecas
FROM tb_estoque_peca ep
JOIN tb_filial fi ON ep.id_filial = fi.id_filial
GROUP BY fi.id_filial;

-- 09 Exibir o total de vendas de veículos por filial:
-- /*/*/*/*/*/
SELECT fi.nome AS filial, SUM(vv.valor_total) AS total_vendas_veiculo
FROM tb_venda_veiculo vv
JOIN tb_filial fi ON vv.id_filial = fi.id_filial
GROUP BY fi.nome;

-- 10 Exibir todos os funcionários e os veículos vendidos por eles:

SELECT f.nome AS funcionario, vv.id_venda_veiculo, ve.modelo, ve.marca, vv.valor_total
FROM tb_venda_veiculo vv
JOIN tb_funcionario f ON vv.id_funcionario = f.id_funcionario
JOIN tb_estoque_veiculo ev ON vv.id_veiculo = ev.id_estoque
JOIN tb_cadastro_veiculo ve ON ev.id_estoque = ve.id_veiculo
ORDER BY 1;

-- 11 Exibir o total de serviços prestados por tipo de serviço (Manutenção, Vistoria, Limpeza):

SELECT s.tipo_servico, COUNT(s.id_servico) AS total_servicos
FROM tb_servico_prestado s
GROUP BY s.tipo_servico;

-- 12 Exibir os fornecedores com mais de um telefone registrado:

SELECT f.nome, COUNT(t.id_telefone) AS total_telefones
FROM tb_fornecedor f
JOIN tb_telefone_fornecedor t ON f.id_fornecedor = t.id_fornecedor
GROUP BY f.id_fornecedor
HAVING COUNT(t.id_telefone) > 1;

-- 13 Exibir a quantidade de veículos vendidos por cliente:

SELECT c.nome, COUNT(vv.id_venda_veiculo) AS quantidade_veiculos_vendidos
FROM tb_venda_veiculo vv
JOIN tb_cliente c ON vv.id_cliente = c.id_cliente
GROUP BY c.id_cliente;

-- 14 Consultar os clientes que não possuem nenhum telefone registrado:

SELECT c.nome, c.cpf
FROM tb_cliente c
LEFT JOIN tb_telefone_cliente t ON c.id_cliente = t.id_cliente
WHERE t.id_telefone IS NULL;
 -- 15 Exibir o total de vendas de peças e veículos por filial:

SELECT fi.nome AS filial, 
       SUM(vp.valor_total) AS total_vendas_peca,
       SUM(vv.valor_total) AS total_vendas_veiculo
FROM tb_venda_peca vp
JOIN tb_filial fi ON vp.id_filial = fi.id_filial
LEFT JOIN tb_venda_veiculo vv ON vp.id_filial = vv.id_filial
GROUP BY fi.id_filial;

-- 16 Exibir todos os clientes e as compras de peças feitas por eles:
-- */*/*/
SELECT c.nome, ep.descricao AS peca, vp.valor_total, vp.data_venda
FROM tb_venda_peca vp
JOIN tb_cliente c ON vp.id_cliente = c.id_cliente
JOIN tb_estoque_peca ep ON vp.id_peca = ep.id_peca;

-- 17 Exibir os detalhes da venda de veículos, incluindo o funcionário responsável e a filial:

SELECT vv.id_venda_veiculo, ve.modelo, ve.marca, vv.valor_total, vv.data_venda, f.nome AS funcionario, fi.nome AS filial
FROM tb_venda_veiculo vv
JOIN tb_funcionario f ON vv.id_funcionario = f.id_funcionario
JOIN tb_filial fi ON vv.id_filial = fi.id_filial
JOIN tb_estoque_veiculo ev ON vv.id_veiculo = ev.id_estoque
JOIN tb_cadastro_veiculo ve ON ev.id_estoque = ve.id_veiculo;

-- 18 Exibir os setores e a quantidade de funcionários em cada setor:

SELECT s.nome AS setor, COUNT(f.id_funcionario) AS total_funcionarios
FROM tb_setor s
LEFT JOIN tb_funcionario f ON s.id_setor = f.id_setor
GROUP BY s.id_setor;

---------------------------------------------------------------------------------------------------------------------------------------------
