--DROP DATABASE IF EXISTS Reserva_voos;

--CREATE DATABASE Reserva_Voos; 
--GO

DROP TABLE IF EXISTS SEAT, FARE, CAN_LAND, LEG_INSTANCE, FLIGHT_LEG,AIRPLANE,AIRPLANE_TYPE, AIRPORT,FLIGHT

CREATE TABLE AIRPORT(
	Airport_code char(5) not null primary key, --considerando que o oódigo é composto por 5 caracteres
	City varchar(50) not null,
	Name varchar(50) not null
)

CREATE TABLE AIRPLANE_TYPE( 
	Type_name_ varchar(50) not null primary key,
	Max_seats int not null,
	Company varchar(50) not null
)

CREATE TABLE AIRPLANE(
	Airplane_id char(5) not null primary key, --considerando que o id é composto por 5 caracteres
	Total_no_seats int not null,
	Airplane_type varchar(50) not null REFERENCES AIRPLANE_TYPE(Type_name_)
)


CREATE TABLE FLIGHT(
	Number char(5) not null primary key, --considerando que o número é composto por 5 caracteres
	Airline varchar(30) not null,
	Weekdays varchar(10) not null --TENHO DÚVIDAS SOBRE ESTE
)

CREATE TABLE FLIGHT_LEG(
	Leg_no int not null primary key,
	Flight_number char(5) not null REFERENCES FLIGHT(Number),
	Depart_airport char(5) not null REFERENCES AIRPORT(Airport_code),
	Arrival_airport char(5) not null	REFERENCES AIRPORT(Airport_code),
	Scheduled_arr_time time not null,
	Scheduled_dep_time timestamp not null
)


CREATE TABLE LEG_INSTANCE(
	Date_ date not null primary key,
	No_avail_seats int not null,
	Airplane_id char(5) not null REFERENCES AIRPLANE(Airplane_id),
	Dep_time time not null,
	Arr_time time not null, 
	Depart_airport char(5) not null REFERENCES AIRPORT(Airport_code),
	Arrival_airpot char(5) not null	REFERENCES AIRPORT(Airport_code),
	Leg_no int not null REFERENCES FLIGHT_LEG(Leg_no),
	Flight_number char(5) not null REFERENCES FLIGHT(Number)
)

CREATE TABLE SEAT(
	Seat_no int not null primary key,
	Customer_name varchar(30) not null,
	Cphone char(9) not null,
	Date_ date not null REFERENCES LEG_INSTANCE(Date_)
)

CREATE TABLE FARE(
	Code char(5) not null primary key, --considerando que o código é composto por 5 caracteres
	Amount int not null,
	Restrictions varchar(500) not null,
	Flight_number char(5) not null REFERENCES FLIGHT(Number)
)

CREATE TABLE CAN_LAND (
	Airport_code char(5) not null REFERENCES AIRPORT(Airport_code),
	Airplane_type varchar(50) not null REFERENCES AIRPLANE_TYPE(Type_name_)

	primary key (Airport_code, Airplane_type)
)