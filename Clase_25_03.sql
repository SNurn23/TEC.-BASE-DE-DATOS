--Exercise 1
--Funcion
CREATE or REPLACE cantidadItems(o.numObra Obra.numObra.Type)
	RETURN int;
	
IS
vIdObra Obra.IdObra.TYPE;
vCantItems int;

BEGIN

SELECT idObra INTO vIdObra FROM Obra
WHERE NumObra = p.NumObra;

SELECT COUNT(*) INTO vCantItems FROM Item I
INNER JOIN Obra O
ON I.idObra = vIdObra;


RETURN vCantItems;
END;
--Fin Funcion

SELECT cantidadItems(O.numObra) CantItems FROM Obra

--Exercise 2


--Exercise 3
CREATE or REPLACE devolverFechas(o.numObra Obra.numObra.Type)
	return text;
IS 
fechaFin date;
Fechaform text;
BEGIN

SELECT add.months

--Exercise 4


