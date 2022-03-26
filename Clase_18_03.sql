--TABLAS
CREATE TABLE Pais(
	idPais SERIAL not null,
	denPais varchar(30),
	primary key(idPais)
);

CREATE TABLE Provincia(
	idProvincia SERIAL not null,
	denProvincia varchar(40),
	idPais int not null,
	primary key(idProvincia),
	foreign key(idPais) references Pais(idPais)
);

CREATE TABLE Localidad(
	idLocalidad SERIAL not null,
	denLocalidad varchar(50),
	cp varchar(10),
	idProvincia int not null,
	primary key(idLocalidad),
	foreign key(idProvincia) references Provincia(idProvincia)
);

CREATE TABLE Alumno(
	dni int not null,
	apellidos varchar(50),
	nombres varchar(50),
	fechaNacimiento date,
	mail varchar(60),
	celular varchar(12),
	idLocalidad int not null,
	primary key(dni),
	foreign key(idLocalidad) references Localidad(idLocalidad)
);

CREATE TABLE Pagos(
	PuntoVenta int not null,
	NroFactura int not null,
	dni int not null,
	fechaPago date,
	primary key(PuntoVenta,NroFactura),
	foreign key(dni) references Alumno(dni)
);

CREATE TABLE Concepto(
	idConcepto SERIAL not null,
	denConcepto varchar(40),
	primary key(idConcepto)
);

CREATE TABLE PagosDet(
	PuntoVenta int not null,
	NroFactura int not null,
	NroReglon SERIAL not null,
	idConcepto int not null, 
	ImporteUnitario float,
	cantidad int,
	primary key(PuntoVenta,NroFactura,NroReglon),
	foreign key(idConcepto) references Concepto(idConcepto),
	foreign key(PuntoVenta,NroFactura ) references Pagos(PuntoVenta,NroFactura)
);

--CARGA DE DATOS
insert into Pais (denPais) values('Argentina'),
('Brasil'),
('Colombia'),
('Chile');

insert into Provincia(denProvincia, idPais) values ('Misiones',1),
('Chubut',1),
('Buenos Aires',1),
('Neuquen',1),
('Huasco',4),
('Santiago',4);

insert into Localidad (denLocalidad,cp,idProvincia) values('Posadas','3300',1),
('San Ignacio', '3322', 1),
('Obera', '3327', 1),
('Iguazu', '3332', 1),
('Santa Ana', '3381', 1);

insert into alumno values(44560777,'Benitez','Alberto','12-07-2000','albertito23@gmail.com','3764194512',1),
(81474644,'Rivera','Maria Jose','28-09-1984','wattokuyesa-4466@yopmail.com','3764490917',3),
(64171619,'Olmos','Lorenzo','20-10-1991','zeitteuddeimeula-9218@yopmail.com','3764656293',3),
(13328483,'Rebollo','Miguel','19-01-1976','peiquoyeucrobau-1705@yopmail.com','3764659660',3),
(11434358,'Baeza','Jessica','09-07-2002','gameloyato-6070@yopmail.com','3764873032',1),
(28497438,'Portela','Elias','11-07-1977','kelluyiroufou-3134@yopmail.com','3764729219',4),
(87399518,'Riera','Margarita','29-11-1983','xurafraddeufeu-1704@yopmail.com','3764370926',2),
(44923210,'Herreros','Teresa','24-11-1957','yehauppehomi-4003@yopmail.com','3764202851',5),
(52022217,'Montes','Tania','05-08-1999','dugagrolouqui-4724@yopmail.com','3764212095',5),
(47727343,'Merchan','Matias','23-08-2003','brommummeissifrei-8608@yopmail.com','3764384103',4);

INSERT INTO  Concepto (denConcepto) values('Inscripcion'),
('Pago al contado'),
('Mensualidades'),
('Gastos de gestion');

INSERT INTO Pagos values (12,14583,81474644,'24-12-2021'),
(13,15582,81474644,'17-11-2021'),
(24,15487,81474644,'04-10-2021'),
(25,15486,11434358,'22-07-2021'),
(21,14557,11434358,'18-06-2021'),
(28,15138,44923210,'01-05-2021'),
(41,44032,52022217,'13-12-2021'),
(96,39947,28497438,'31-07-2021'),
(52,44788,52022217,'23-05-2021'),
(35,22060,87399518,'02-12-2021'),
(51,17840,13328483,'14-06-2021'),
(53,29206,13328483,'09-12-2021'),
(67,27428,64171619,'10-08-2021'),
(78,29987,64171619,'05-12-2021');

INSERT INTO PagosDet(PuntoVenta,NroFactura,idConcepto,importeUnitario,cantidad) values (24,15487,3,5040,2),
(24,15487,3,5040,3),
(24,15487,3,5040,4),
(51,17840,3,5040,2),
(67,27428,1,8004,1),
(67,27428,1,8004,4),
(67,27428,1,8004,5),
(67,27428,3,5040,2),
(52,44788,4,200,1),
(52,44788,4,500,2),
(78,29987,2,4522,1),
(78,29987,2,4522,2),
(78,29987,2,7000,3),
(21,14557,1,8955,1),
(53,29206,3,8744,1),
(53,29206,3,500,2),
(41,44032,2,9653,1),
(21,14557,2,100,1);

--CONSULTAS
SELECT * FROM Pais
SELECT * FROM Provincia
SELECT * FROM Localidad
SELECT * FROM Alumno
SELECT * FROM Pagos
SELECT * FROM Concepto
SELECT * FROM PagosDet


--EXERCISES

--EX_1
SELECT A.Apellidos, A.Nombres, A.dni, A.fechaNacimiento, A.mail 
FROM Alumno A
JOIN Localidad L
USING (idLocalidad)
WHERE L.denLocalidad = 'Obera'
ORDER BY A.Apellidos, A.Nombres;

--EX_2
SELECT P.NroFactura, P.PuntoVenta, P.fechaPago, A.Apellidos, A.Nombres 
FROM Pagos P
JOIN Alumno A
USING(dni)
WHERE EXTRACT(MONTH FROM P.fechaPago) = 12 AND EXTRACT(YEAR FROM P.fechaPago) = 2021
ORDER BY P.PuntoVenta, P.NroFactura;

----
CREATE VIEW  Importe_Total AS(
	SELECT P.NroFactura, P.PuntoVenta, SUM(Pd.Cantidad*Pd.importeUnitario) TotalFactura
	FROM Pagos P
	JOIN PagosDet Pd
	USING (NroFactura,PuntoVenta) 
	GROUP BY P.NroFactura, P.PuntoVenta
);
----

--EX_3
SELECT * FROM Importe_Total I
WHERE I.NroFactura = 15487 AND I.PuntoVenta = 24;

--EX_4
SELECT C.denConcepto, COUNT(Pd.idConcepto) Cantidad_Facturadas
FROM Concepto C
JOIN PagosDet Pd
USING(idConcepto)
GROUP BY C.denConcepto;

--EX_5
SELECT I.NroFactura, I.PuntoVenta, I.TotalFactura  Mayor_Importe 
FROM Importe_Total I
WHERE I.TotalFactura = (SELECT MAX(I.TotalFactura) FROM Importe_Total I);

--EX_6
CREATE VIEW Cuotas as(
	SELECT L.denLocalidad, COUNT(P.dni) CantCuotasP
	FROM Localidad L
	JOIN Alumno A USING(idLocalidad)
	JOIN Pagos P USING(dni)
	GROUP BY L.denLocalidad
);

SELECT C.denLocalidad, C.CantCuotasP FROM Cuotas C
WHERE  C.CantCuotasP = (SELECT MAX(C.CantCuotasP) FROM Cuotas C);

--Nurnberg Sofia 67111



