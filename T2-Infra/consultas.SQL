
-- KEYSPACE passenger_queries;
----------------------------------------------------------------------------------------------------

--Consulta Q1: Encontrar passageiros por sobrenome
-- Busca passageiros com um sobrenome específico.

SELECT * FROM passenger_lastname WHERE lastname = 'Jones';

-- Consulta Q2: Listar o histórico de reservas de um passageiro
-- Pega um passenger_id da Q1 e lista seu histórico de voos.

SELECT * FROM bookings_by_passenger  WHERE passenger_id = '6517';

----------------------------------------------------------------------------------------------------




--KEYSPACE airport_operations;
----------------------------------------------------------------------------------------------------

--Consulta Q3: Listar voos de um aeroporto em uma data
--Descrição: Busca voos de um aeroporto e data específicos.

SELECT * FROM flights_by_airport_date  WHERE origin_airport = 'MRX' AND flight_date = '2023-06-16';

-- Consulta Q4: Listar os passageiros de um voo específico
-- Descrição: Pega um voo da Q3 e lista seus passageiros.

SELECT * FROM passengers_by_flight  WHERE flightno = 'KO1618' AND flight_date = '2023-09-10';