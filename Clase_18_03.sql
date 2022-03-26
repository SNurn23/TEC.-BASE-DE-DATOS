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
	NroReglon int not null,
	idConcepto int not null, 
	ImporteUnitario float,
	cantidad int,
	primary key(PuntoVenta,NroFactura,NroReglon),
	foreign key(idConcepto) references Concepto(idConcepto)
);

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

select * from provincia
inner join pais
using(idPais)
where denPais = 'Argentina'

insert into Localidad (denLocalidad,cp,idProvincia) values('Posadas','3300',1),
('San Ignacio', '3322', 1),
('Obera', '3327', 1),
('Iguazu', '3332', 1),
('Santa Ana', '3381', 1);


