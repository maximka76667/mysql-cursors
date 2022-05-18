CREATE PROCEDURE `new_procedure` (p_num_departamento int)
BEGIN

	DECLARE fin int default false;

	DECLARE cursorComerciales cursor for
		select num_empleado
        from empleados
        where num_departamento = p_num_departamento
        and puesto = "COMERCIAL"
        ORDER by salario
        LIMIT 3;
        
	DECLARE continue handler for not found set fin = true;
    
    updateSalario: LOOP
		
    end LOOP updateSalario;
END
