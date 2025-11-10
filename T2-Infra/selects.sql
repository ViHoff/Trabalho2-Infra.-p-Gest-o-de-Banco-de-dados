--CONSULTA Q1
SET HEADING OFF;
SET FEEDBACK OFF;
SET PAGESIZE 0;

SPOOL "C:\Users\Viceh\OneDrive\Área de Trabalho\T2-Infra\q1.cql"
SELECT 
  'INSERT INTO passenger_queries.passenger_lastname (lastname, passenger_id, first_name, email, phone) VALUES (' ||
  '''' || REPLACE(p.lastname, '''', '''''') || ''',' ||
  '''' || TRIM(p.passenger_id) || ''',' || 
  '''' || REPLACE(p.firstname, '''', '''''') || ''',' ||
  '''' || REPLACE(pd.emailaddress, '''', '''''') || ''',' ||
  '''' || REPLACE(pd.telephoneno, '''', '''''') || ''');'
FROM 
  ARRUDA.AIR_PASSENGERS p
  JOIN ARRUDA.AIR_PASSENGERS_DETAILS pd ON p.passenger_id = pd.passenger_id;
SPOOL OFF;



--CONSULTA Q2

SET HEADING OFF;
SET FEEDBACK OFF;
SET PAGESIZE 0;

SPOOL "C:\Users\Viceh\OneDrive\Área de Trabalho\T2-Infra\q2.cql"
SELECT 
  'INSERT INTO passenger_queries.bookings_by_passenger (passenger_id, flight_departure, flightno, booking_id, seat, origin_airport, destination_airport) VALUES (' ||
  '''' || TRIM(b.passenger_id) || ''',' ||
  '''' || TO_CHAR(f.departure, 'YYYY-MM-DD HH24:MI:SS') || ''',' ||
  '''' || TRIM(f.flightno) || ''',' ||
  b.booking_id || ',' ||
  '''' || TRIM(b.seat) || ''',' ||
  '''' || TRIM(orig.iata) || ''',' ||
  '''' || TRIM(dest.iata) || ''');'
FROM 
  ARRUDA.AIR_BOOKINGS b
  JOIN ARRUDA.AIR_FLIGHTS f ON b.flight_id = f.flight_id
  JOIN ARRUDA.AIR_AIRPORTS orig ON f.from_airport_id = orig.airport_id
  JOIN ARRUDA.AIR_AIRPORTS dest ON f.to_airport_id = dest.airport_id;
SPOOL OFF;


--CONSULTA Q3
SET HEADING OFF;
SET FEEDBACK OFF;
SET PAGESIZE 0;

SPOOL "C:\Users\Viceh\OneDrive\Área de Trabalho\T2-Infra\q3.cql"

SELECT 
  'INSERT INTO airport_operations.flights_by_airport_date (origin_airport, flight_date, flight_departure, flightno, destination_airport, airline_name) VALUES (' ||
  '''' || TRIM(orig.iata) || ''',' ||
  '''' || TO_CHAR(f.departure, 'YYYY-MM-DD') || ''',' || 
  '''' || TO_CHAR(f.departure, 'YYYY-MM-DD HH24:MI:SS') || ''',' ||
  '''' || TRIM(f.flightno) || ''',' ||
  '''' || TRIM(dest.iata) || ''',' ||
  '''' || REPLACE(al.airline_name, '''', '''''') || ''');' -- Coluna/Valor de arrival_time removidos
FROM 
  ARRUDA.AIR_FLIGHTS f
  JOIN ARRUDA.AIR_AIRPORTS orig ON f.from_airport_id = orig.airport_id
  JOIN ARRUDA.AIR_AIRPORTS dest ON f.to_airport_id = dest.airport_id
  JOIN ARRUDA.AIR_FLIGHTS_SCHEDULES fs ON f.flightno = fs.flightno
  JOIN ARRUDA.AIR_AIRLINES al ON fs.airline_id = al.airline_id;
  
SPOOL OFF;

--CONSULTA Q4
SET HEADING OFF;
SET FEEDBACK OFF;
SET PAGESIZE 0;

SPOOL "C:\Users\Viceh\OneDrive\Área de Trabalho\T2-Infra\q4.cql"
SELECT 
  'INSERT INTO airport_operations.passengers_by_flight (flightno, flight_date, seat, passenger_id, lastname, booking_id) VALUES (' ||
  '''' || TRIM(fs.flightno) || ''',' ||
  '''' || TO_CHAR(f.departure, 'YYYY-MM-DD') || ''',' ||
  '''' || TRIM(b.seat) || ''',' ||
  '''' || TRIM(p.passenger_id) || ''',' ||
  '''' || REPLACE(p.lastname, '''', '''''') || ''',' ||
  b.booking_id || ');' -- Coluna/Valor de first_name removidos
FROM 
  ARRUDA.AIR_BOOKINGS b
  JOIN ARRUDA.AIR_PASSENGERS p ON b.passenger_id = p.passenger_id
  JOIN ARRUDA.AIR_FLIGHTS f ON b.flight_id = f.flight_id
  JOIN ARRUDA.AIR_FLIGHTS_SCHEDULES fs ON f.flightno = fs.flightno;
SPOOL OFF;