--***************************** EXERCISE 1 ********************************
CREATE or REPLACE FUNCTION cantidadObras(nombre varchar(40))
	RETURNS  bigint AS $$
	
DECLARE
vIdLocalidad int;
vCantObras bigint;

BEGIN

SELECT COUNT(L.idLocalidad) INTO vCantObras
FROM (SELECT idLocalidad FROM Localidad WHERE nomLoc = nombre) as L;

RETURN vCantObras;
END;
$$ LANGUAGE plpgsql;

--------
SELECT L.idlocalidad, L.nomLoc, cantidadObras(L.nomLoc) CantObras FROM Localidad L
--***************************** EXERCISE 2 ********************************



