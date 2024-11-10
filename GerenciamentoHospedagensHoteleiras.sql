-- ------------------------------------------ BÁRBARA CARVALHO - RA 22287023-5 --------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------

-- -------------------------------------------- MAPA - BANCO DE DADOS II -----------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
-- 1. Crie o esquema de banco de dados para o sistema de gerenciamento e hospedagens hoteleiras nomeado “hospedar_db”.
DROP SCHEMA IF EXISTS hospedar_db;
CREATE SCHEMA hospedar_db;

-- DROP SCHEMA IF EXISTS hospedar_db;

-- Seleção do schema
USE hospedar_db;

-- 2. Crie as tabelas "Hotel", "Quarto", "Cliente" e "Hospedagem" com as colunas especificadas anteriormente.
-- Criação da tabela "Hotel"
CREATE TABLE Hotel (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY, -- hotel_id (Chave primária, INT): Identificador único do hotel.
    nome VARCHAR(100) NOT NULL, -- nome (VARCHAR, não nulo): Nome do hotel.
    cidade VARCHAR(100) NOT NULL, -- cidade (VARCHAR, não nulo): Cidade onde o hotel está localizado.
    uf VARCHAR(2) NOT NULL, -- uf (VARCHAR, não nulo): Estado onde o hotel está localizado, com dois dígitos.
    classificacao INT NOT NULL CHECK (classificacao BETWEEN 1 AND 5) -- classificacao (INT, não nulo): Classificação do hotel em estrelas (1 até 5).
);

-- Criação da tabela "Quarto"
CREATE TABLE Quarto (
    ID_Quarto INT AUTO_INCREMENT PRIMARY KEY, -- ID_Quarto (Chave primária, INT): Identificador único do quarto.
    hotel_id INT NOT NULL, -- hotel_id (Chave estrangeira não nula para "Hotel"): Identificador do hotel ao qual o quarto pertence.
    numero INT NOT NULL, -- número (INT, não nulo): Número do quarto.
    tipo VARCHAR(50) NOT NULL, -- tipo (VARCHAR, não nulo): Tipo de quarto (por exemplo, "Standard", "Deluxe", "Suíte").
    preco_diaria DECIMAL(10, 2) NOT NULL, -- preco_diaria (DECIMAL, não nulo): Preço da diária do quarto.
    CONSTRAINT fk_hotel
        FOREIGN KEY (hotel_id)
        REFERENCES Hotel(hotel_id)
        ON DELETE CASCADE
);

-- Criação da tabela "Cliente"
CREATE TABLE Cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY, -- cliente_id (Chave primária, INT): Identificador único do cliente.
    nome VARCHAR(100) NOT NULL, -- nome (VARCHAR, não nulo): Nome do cliente.
    email VARCHAR(100) NOT NULL UNIQUE, -- email (VARCHAR, não nulo e único): Endereço de e-mail do cliente.
    telefone VARCHAR(15) NOT NULL, -- telefone (VARCHAR, não nulo): Número de telefone do cliente.
    cpf VARCHAR(11) NOT NULL UNIQUE -- cpf (VARCHAR, não nulo e único): Número de CPF do cliente.
);

-- Criação da tabela "Hospedagem"
CREATE TABLE Hospedagem (
    hospedagem_id INT AUTO_INCREMENT PRIMARY KEY, -- hospedagem_id (Chave primária, INT): Identificador único da hospedagem.
    cliente_id INT NOT NULL, -- cliente_id (Chave estrangeira não nula para "Cliente"): Identificador do cliente que fez a reserva.
    ID_Quarto INT NOT NULL, -- ID_Quarto (Chave estrangeira não nula para "Quarto"): Identificador do quarto reservado.
    dt_checkin DATE NOT NULL, -- dt_checkin (DATE): Data de check-in da hospedagem (não nula).
    dt_checkout DATE NOT NULL, -- dt_checkout (DATE): Data de check-out da hospedagem (não nula).
    valor_total_hosp FLOAT NOT NULL, -- Valor_total_hosp(FLOAT, não nulo): Custo total da hospedagem, calculado quando a hospedagem é finalizada.
    status_hosp VARCHAR(20) NOT NULL CHECK (status_hosp IN ('reserva', 'finalizada', 'hospedado', 'cancelada')), -- status_hosp (VARCHAR, não nulo): status_hosp da hospedagem, podendo receber os seguintes valores: “reserva”, reservado pelo cliente; “finalizada”, hospedagem concluida; “hospedado”, o cliente está atualmente hospedado no hotel; “cancelada”, a hospedagem (reserva) foi cancelada.
    CONSTRAINT fk_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES Cliente(cliente_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_quarto
        FOREIGN KEY (ID_Quarto)
        REFERENCES Quarto(ID_Quarto)
        ON DELETE CASCADE
);

-- 3. Insira dados artificiais nas tabelas "Hotel" (2 hotéis), "Quarto"(5 para cada hotel), "Cliente"(3 clientes) e "Hospedagem" (20 hospedagens, 5 para cada um dos “Status_hosp”) para simular hotéis, quartos, clientes e hospedagens
-- Inserção de dados na tabela Hotel
INSERT INTO 
	Hotel (nome, cidade, uf, classificacao) 
VALUES
	('Hotel Ibis - Jundiaí', 'Jundiaí', 'SP', 3),
	('Hotel Five Star', 'Rio Verde', 'GO', 5);

-- Inserção de dados na tabela Quarto para o Hotel Ibis - Jundiaí
INSERT INTO 
	Quarto (hotel_id, numero, tipo, preco_diaria) 
VALUES
	(1, 101, 'Standard', 100.00),
	(1, 102, 'Standard', 200.00),
	(1, 201, 'Deluxe', 300.00),
	(1, 202, 'Deluxe', 400.00),
	(1, 301, 'Suíte', 500.00);

-- Inserção de dados na tabela Quarto para o Hotel Five Star
INSERT INTO 
	Quarto (hotel_id, numero, tipo, preco_diaria) 
VALUES
	(2, 101, 'Standard', 150.00),
	(2, 102, 'Deluxe', 250.00),
	(2, 201, 'Deluxe', 350.00),
	(2, 202, 'Deluxe', 450.00),
	(2, 301, 'Suíte', 550.00);

-- Inserção de dados na tabela Cliente
INSERT INTO 
	Cliente (nome, email, telefone, cpf) 
VALUES
	('David Rocha', 'dlr@gmail.com', '21965478569', '12000000001'),
	('Arthur Souza', 'a.souza@hotmail.com.br', '35974856235', '12000000002'),
	('Ana Luísa Roque', 'aaninha@outlook.com', '11965874596', '12000000003');

-- Inserção de dados na tabela Hospedagem
-- Hospedagens com status 'reserva'
INSERT INTO 
	Hospedagem (cliente_id, ID_Quarto, dt_checkin, dt_checkout, valor_total_hosp, status_hosp) 
VALUES
	(3, 1, '2023-01-01', '2023-01-04', 300.00, 'reserva'),
	(1, 3, '2023-02-10', '2023-02-20', 3000.00, 'reserva'),
	(3, 5, '2023-03-05', '2023-03-08', 1500.00, 'reserva'),
	(2, 7, '2023-04-20', '2023-04-30', 2500.00, 'reserva'),
	(3, 9, '2023-05-15', '2023-05-18', 1350.00, 'reserva');

-- Hospedagens com status 'finalizada'
INSERT INTO 
	Hospedagem (cliente_id, ID_Quarto, dt_checkin, dt_checkout, valor_total_hosp, status_hosp) 
VALUES
	(2, 2, '2023-06-01', '2023-06-11', 2000.00, 'finalizada'),
	(1, 6, '2023-07-10', '2023-07-13', 450.00, 'finalizada'),
	(1, 10, '2023-08-05', '2023-08-15', 5500.00, 'finalizada'),
	(2, 2, '2023-09-20', '2023-09-23', 600.00, 'finalizada'),
	(3, 10, '2023-10-15', '2023-10-25', 5500.00, 'finalizada');

-- Hospedagens com status 'hospedado'
INSERT INTO 
	Hospedagem (cliente_id, ID_Quarto, dt_checkin, dt_checkout, valor_total_hosp, status_hosp) 
VALUES
	(2, 1, '2023-11-01', '2023-11-06', 500.00, 'hospedado'),
	(3, 3, '2023-12-10', '2023-12-15', 1500.00, 'hospedado'),
	(1, 9, '2023-01-05', '2023-01-11', 2700.00, 'hospedado'),
	(2, 7, '2023-02-20', '2023-02-25', 1250.00, 'hospedado'),
	(3, 8, '2023-03-15', '2023-03-21', 2100.00, 'hospedado');

-- Hospedagens com status 'cancelada'
INSERT INTO 
	Hospedagem (cliente_id, ID_Quarto, dt_checkin, dt_checkout, valor_total_hosp, status_hosp)
VALUES
	(1, 9, '2023-04-01', '2023-04-11', 4500.00, 'cancelada'),
	(2, 7, '2023-05-10', '2023-05-15', 1250.00, 'cancelada'),
	(3, 2, '2023-06-05', '2023-06-08', 600.00, 'cancelada'),
	(2, 2, '2023-07-20', '2023-07-25', 1000.00, 'cancelada'),
	(3, 10, '2023-08-15', '2023-08-18', 1650.00, 'cancelada');

-- 4. Escreva as seguintes consultas e comandos SQL:
-- a. Listar todos os hotéis e seus respectivos quartos, apresentando os seguintes campos: para hotel, nome e cidade; para quarto, tipo e preco_diaria:
SELECT 
    h.nome AS Nome_Hotel,
    h.cidade AS Cidade_Hotel,
    q.tipo AS Tipo_Quarto,
    q.preco_diaria AS Preço_Diária_Quarto
FROM 
    Hotel h
JOIN 
    Quarto q ON h.hotel_id = q.hotel_id;

-- b. ​Listar todos os clientes que já realizaram hospedagens (status_hosp igual á “finalizada”), e os respectivos quartos e hotéis:
SELECT 
    c.nome AS Nome_Cliente,
    q.numero AS Número_Quarto,
    q.tipo AS Tipo_Quarto,
    h.nome AS Nome_Hotel,
    h.cidade AS Cidade_Hotel,
	hosp.status_hosp AS Status_Hospedagem
FROM 
    Hospedagem hosp
JOIN 
    Cliente c ON hosp.cliente_id = c.cliente_id
JOIN 
    Quarto q ON hosp.id_quarto = q.id_quarto
JOIN 
    Hotel h ON q.hotel_id = h.hotel_id
WHERE 
    hosp.status_hosp = 'finalizada';

-- c. ​Mostrar o histórico de hospedagens em ordem cronológica de um determinado cliente:
SELECT 
	c.nome AS Nome_Cliente,
    hosp.dt_checkin AS Checkin,
    hosp.dt_checkout AS Checkout,
	hosp.hospedagem_id AS ID_Hospedagem,
    hosp.valor_total_hosp  AS Valor_Total,
    q.numero AS Número_Quarto,
    q.tipo AS Tipo_Quarto,
    h.nome AS Nome_Hotel,
    h.cidade AS Cidade_Hotel,
	hosp.status_hosp AS Status_Hospedagem
FROM 
    Hospedagem hosp
JOIN 
    Cliente c ON hosp.cliente_id = c.cliente_id
JOIN 
    Quarto q ON hosp.id_quarto = q.id_quarto
JOIN 
    Hotel h ON q.hotel_id = h.hotel_id
WHERE 
    c.cliente_id = 2 -- ID do determinado cliente, neste caso escolhi o Cliente 2 = Arthur Souza
ORDER BY 
    hosp.dt_checkin;

-- d. ​Apresentar o cliente com maior número de hospedagens (não importando o tempo em que ficou hospedado):
SELECT 
    c.cliente_id,
    c.nome AS Nome_Cliente,
    COUNT(*) AS Total_Hospedagens
FROM 
    Cliente c
JOIN 
    Hospedagem hosp ON c.cliente_id = hosp.cliente_id
GROUP BY 
    c.cliente_id, c.nome
ORDER BY 
    total_hospedagens DESC
LIMIT 1;

-- e. ​Apresentar clientes que tiveram hospedagem “cancelada”, os respectivos quartos e hotéis:
SELECT 
    c.nome AS Nome_Cliente,
    c.email AS Email_Cliente,
    hosp.status_hosp,
    q.tipo AS Tipo_Quarto,
    h.nome AS Nome_Hotel,
    h.cidade AS Cidade_Hotel
FROM 
    Hospedagem hosp
JOIN 
    Cliente c ON hosp.cliente_id = c.cliente_id
JOIN 
    Quarto q ON hosp.id_quarto = q.id_quarto
JOIN 
    Hotel h ON q.hotel_id = h.hotel_id
WHERE 
    hosp.status_hosp = 'cancelada';

-- f. ​Calcular a receita de todos os hotéis (hospedagem com status_hosp igual a “finalizada”), ordenado de forma decrescente:
SELECT 
    h.nome AS Nome_Hotel,
    h.cidade AS Cidade_Hotel,
    SUM(hosp.valor_total_hosp) AS Receita_Total
FROM 
    Hospedagem hosp
JOIN 
    Quarto q ON hosp.id_quarto = q.id_quarto
JOIN 
    Hotel h ON q.hotel_id = h.hotel_id
WHERE 
    hosp.status_hosp = 'finalizada'
GROUP BY 
    h.hotel_id, h.nome, h.cidade
ORDER BY 
    receita_total DESC;

-- g. ​Listar todos os clientes que já fizeram uma reserva em um hotel específico:
SELECT 
	c.nome AS Nome_Cliente, hosp.status_hosp AS Status_Reserva, h.nome AS Nome_Hotel
FROM 
	Cliente c
JOIN 
	Hospedagem hosp ON c.cliente_id = hosp.cliente_id
JOIN 
	Quarto q ON hosp.id_quarto = q.id_quarto
JOIN 
	Hotel h ON q.hotel_id = h.hotel_id
WHERE 
	q.hotel_id = 1; -- -- ID do determinado hotel, no caso da minha escolha ID 01 = Hotel Ibis - Jundiaí

-- h. Listar o quanto cada cliente gastou em hospedagens:
SELECT 
	c.nome AS Nome_Cliente,
    SUM(hosp.valor_total_hosp) AS Total_Gasto
FROM 
	Hospedagem hosp
JOIN 
	Cliente c ON hosp.cliente_id = c.cliente_id
WHERE 
	hosp.status_hosp = 'finalizada'
GROUP BY 
	c.nome
ORDER BY 
	total_gasto DESC;

-- i. ​Listar todos os quartos que ainda não receberam hóspedes.
SELECT 
    q.id_quarto AS ID_Quarto, 
    q.numero AS Número_Quarto, 
    h.nome AS Nome_Hotel
FROM 
    Quarto q
JOIN 
    Hotel h ON q.hotel_id = h.hotel_id
LEFT JOIN
    Hospedagem hosp ON q.id_quarto = hosp.id_quarto
WHERE 
    hosp.hospedagem_id IS NULL;

-- j. Apresentar a média de preços de diárias em todos os hotéis, por tipos de quarto:
SELECT 
    h.nome AS Nome_Hotel,
    q.tipo AS Tipo_Quarto,
    AVG(q.preco_diaria) AS Média_Preço_Diária
FROM 
    Quarto q
JOIN 
    Hotel h ON q.hotel_id = h.hotel_id
GROUP BY 
    h.nome, q.tipo;

-- l. ​Criar a coluna checkin_realizado do tipo booleano na tabela Hospedagem (via código). E atribuir verdadeiro para as Hospedagens com status_hosp “finalizada” e “hospedado”, e como falso para Hospedagens com status_hosp “reserva” e “cancelada”:
-- Adicionar a coluna checkin_realizado à tabela Hospedagem
ALTER TABLE Hospedagem
ADD COLUMN checkin_realizado BOOLEAN;

-- Atualizar os valores da coluna checkin_realizado com base no status_hosp
UPDATE Hospedagem
SET checkin_realizado = CASE 
                            WHEN status_hosp IN ('finalizada', 'hospedado') THEN TRUE
                            WHEN status_hosp IN ('reserva', 'cancelada') THEN FALSE
                         END
WHERE hospedagem_id > 0;
-- Selecionar todos os registros da tabela Hospedagem para verificar os valores da coluna checkin_realizado
SELECT * FROM Hospedagem
	
-- m. Mudar o nome da coluna “classificacao” da tabela Hotel para “ratting”:
-- Alterar o nome da coluna
ALTER TABLE Hotel
CHANGE COLUMN classificacao ratting INT NOT NULL;

-- Adicionar a restrição CHECK
ALTER TABLE Hotel
ADD CHECK (ratting BETWEEN 1 AND 5);

-- Selecionar todos os registros da tabela Hotel para verificar os valores da coluna ratting
SELECT * FROM Hotel;

-- 5. Efetue a criação dos seguintes procedimentos usando PL/MySQL:
-- a. Criar uma procedure chamada "RegistrarCheckIn" que aceita hospedagem_id e data_checkin como parâmetros. A procedure deve atualizar a data de check-in na tabela "Hospedagem" e mudar o status_hosp para "hospedado".​
DELIMITER //

CREATE PROCEDURE RegistrarCheckIn (
    IN hospedagem_id_param INT,
    IN data_checkin_param DATE
)
BEGIN
    UPDATE Hospedagem
    SET dt_checkin = data_checkin_param,
        status_hosp = 'hospedado'
    WHERE hospedagem_id = hospedagem_id_param;
END //

DELIMITER ;

-- b. Criar uma procedure chamada "CalcularTotalHospedagem" que aceita hospedagem_id como parâmetro. A procedure deve calcular o valor total da hospedagem com base na diferença de dias entre check-in e check-out e o preço da diária do quarto reservado. O valor deve ser atualizado na coluna valor_total_hosp.​
DELIMITER //

CREATE PROCEDURE CalcularTotalHospedagem (
    IN hospedagem_id_param INT
)
BEGIN
    DECLARE preco_diaria DECIMAL(10, 2);
    DECLARE dt_checkin DATE;
    DECLARE dt_checkout DATE;
    DECLARE diferenca_dias INT;
    DECLARE total_valor DECIMAL(10, 2);

    -- Obtendo o preço da diária e as datas de check-in e check-out da hospedagem
    SELECT preco_diaria, dt_checkin, dt_checkout
    INTO preco_diaria, dt_checkin, dt_checkout
    FROM Hospedagem
    WHERE hospedagem_id = hospedagem_id_param;

    -- Calculando a diferença de dias entre check-in e check-out
    SET diferenca_dias = DATEDIFF(dt_checkout, dt_checkin);

    -- Calculando o valor total da hospedagem
    SET total_valor = preco_diaria * diferenca_dias;

    -- Atualizando o valor total da hospedagem na tabela Hospedagem
    UPDATE Hospedagem
    SET valor_total_hosp = total_valor
    WHERE hospedagem_id = hospedagem_id_param;
END //

DELIMITER ;

-- c. Criar uma procedure chamada "RegistrarCheckout" que aceita hospedagem_id e data_checkout como parâmetros. A procedure deve atualizar a data de check-out na tabela "Hospedagem" e mudar o status_hosp para "finalizada".​
DELIMITER //

CREATE PROCEDURE RegistrarCheckout (
    IN hospedagem_id_param INT,
    IN data_checkout_param DATE
)
BEGIN
    -- Atualizando a data de check-out e o status da hospedagem
    UPDATE Hospedagem
    SET dt_checkout = data_checkout_param,
        status_hosp = 'finalizada'
    WHERE hospedagem_id = hospedagem_id_param;
END //

DELIMITER ;

-- 6. Efetue a criação das seguintes funções utilizando PL/MySQL:
-- a. Criar uma function chamada "TotalHospedagensHotel" que aceita hotel_id como parâmetro. A função deve retornar o número total de hospedagens realizadas em um determinado hotel.​
DELIMITER //

CREATE FUNCTION TotalHospedagensHotel (
    hotel_id_param INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_hospedagens INT;
    
    -- Calculando o total de hospedagens para o hotel especificado
    SELECT COUNT(*)
    INTO total_hospedagens
    FROM Hospedagem h
    JOIN Quarto q ON h.id_quarto = q.id_quarto
    WHERE q.hotel_id = hotel_id_param;
    
    RETURN Total_Hospedagens;
END //

DELIMITER ;

-- b. Criar uma function chamada "ValorMedioDiariasHotel" que aceita hotel_id como parâmetro. A função deve calcular e retornar o valor médio das diárias dos quartos deste hotel.
DELIMITER //

CREATE FUNCTION ValorMedioDiariasHotel (
    hotel_id_param INT
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE valor_medio_diarias DECIMAL(10, 2);
    
    -- Calculando o valor médio das diárias para o hotel especificado
    SELECT AVG(preco_diaria)
    INTO valor_medio_diarias
    FROM Quarto
    WHERE hotel_id = hotel_id_param;
    
    RETURN valor_medio_diarias;
END //

DELIMITER ;

-- c. Criar uma function chamada "VerificarDisponibilidadeQuarto" que aceita ID_Quarto e data como parâmetros. A função deve retornar um valor booleano indicando se o quarto está disponível ou não para reserva na data especificada.​
DELIMITER //

CREATE FUNCTION VerificarDisponibilidadeQuarto (
    id_quarto_param INT,
    data_param DATE
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE disponivel BOOLEAN;
    
    -- Verifica se há alguma hospedagem agendada para o quarto na data especificada
    SELECT COUNT(*) INTO disponivel
    FROM Hospedagem
    WHERE id_quarto = id_quarto_param
    AND data_param BETWEEN dt_checkin AND dt_checkout;
    
    -- Retorna verdadeiro se o quarto estiver disponível na data especificada
    RETURN NOT disponivel;
END //

DELIMITER ;

-- 7. Efetue a criação das seguintes triggers utilizando PL/MySQL:

-- a. Criar um trigger chamado "AntesDeInserirHospedagem" que é acionado antes de uma inserção na tabela "Hospedagem". O trigger deve verificar se o quarto está disponível na data de check-in. Se não estiver, a inserção deve ser cancelada.
DELIMITER //

CREATE TRIGGER AntesDeInserirHospedagem
BEFORE INSERT ON Hospedagem
FOR EACH ROW
BEGIN
    DECLARE disponibilidade INT;

    -- Verifica a disponibilidade do quarto na data de check-in
    SELECT COUNT(*)
    INTO disponibilidade
    FROM Hospedagem
    WHERE id_quarto = NEW.id_quarto
    AND status_hosp = 'hospedado'
    AND NEW.dt_checkin BETWEEN dt_checkin AND dt_checkout;

    -- Se o quarto não estiver disponível, cancela a inserção
    IF disponibilidade > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quarto não está disponível na data selecionada para realizar o check-in';
    END IF;
END //

DELIMITER ;

-- b. Cria um trigger chamado "AposDeletarCliente" que é acionado após a exclusão de um cliente na tabela "Cliente". O trigger deve registrar a exclusão em uma tabela de log.​
DELIMITER //

CREATE TRIGGER AposDeletarCliente
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO Log_Exclusao_Cliente (cliente_id, nome, data_exclusao)
    VALUES (OLD.cliente_id, OLD.nome, NOW());
END //

DELIMITER ;

-- ---------------------------------------------------------------------------------------------------------------------
