--***************************** EXERCISE 1 ********************************
CREATE or REPLACE FUNCTION cantidadItems(numObra int)
	RETURNS  bigint AS $$
	
DECLARE
vIdObra int;
vCantItems bigint;

BEGIN

SELECT idObra INTO vIdObra FROM Obra O
WHERE O.numObra = numObra;

SELECT COUNT(*) INTO vCantItems
FROM Item I
INNER JOIN Obra O
ON I.idObra = vIdObra;

RETURN vCantItems;
END;
$$ LANGUAGE plpgsql;

--------

SELECT cantidadItems(O.numObra) CantItems FROM Obra O

--***************************** EXERCISE 2 ******************************** (ARREGLAR)
CREATE or REPLACE FUNCTION calcularValor(idObra int, idItem int, idRedeterminacion int)
	RETURNS float AS $$
	
DECLARE
totalItem float;
BEGIN

SELECT SUM((Ic.costo*(O.PorFlete/100))+Ic.costo+(Ic.costo*(O.PorGastos/100))+Ic.costo+(Ic.costo*(O.PorUti/100))+Ic.costo) INTO totalItem
FROM ItemCosto Ic 
INNER JOIN OBRA O ON O.IDOBRA = idObra
WHERE  Ic.IDITEM = idItem AND Ic.IDREDETERMINACION = idRedeterminacion;

RETURN totalItem;
END;
$$ LANGUAGE plpgsql;
--------
CREATE or REPLACE FUNCTION determinarValor(idObra int, idItem int, idRedeterminacion int)
	RETURNS float AS $$
	
DECLARE
totalItem float;

BEGIN
-- 1- vivienda / 2-infraestructura
SELECT calcularValor(idObra , idItem, idRedeterminacion) INTO totalItem FROM ITEM I;

SELECT I.IDTIPOITEM,
CASE I.IDTIPOITEM
		WHEN 1 THEN totalItem := (totalItem*(O.ivaViv/100)+ totalItem) 
     	WHEN 2 THEN totalItem := (totalItem*(O.ivaInfra/100)+ totalItem) 
END 
FROM ITEM I
INNER JOIN OBRA O ON O.IDOBRA = idObra;

RETURN totalItem;
END;
$$ LANGUAGE plpgsql;
------

SELECT calcularValor(I.idObra , I.idItem, 0) valorTotal FROM ITEM I

--***************************** EXERCISE 3 ********************************
CREATE or REPLACE FUNCTION intervaloFecha(numObra int)
	RETURNS text AS $$
	
DECLARE
intFecha text;
BEGIN

SELECT ('Fecha de inicio: '||O.FECINICIO||' - Fin de Obra: '||(O.FECINICIO + interval 'O.PLAZO_MES month')) INTO intFecha FROM OBRA O
WHERE O.NUMOBRA = numObra;

RETURN intFecha;
END;
$$ LANGUAGE plpgsql;
-----
SELECT O.IDOBRA, O.NOMOBRA Obra, intervaloFecha(O.numObra) intervaloFechas  FROM OBRA O

--***************************** EXERCISE 4 ********************************
--mismo ejercicio que el 2

