CREATE DEFINER=`root`@`localhost` PROCEDURE `salario`(p_num_departamento int)
BEGIN
    DECLARE p_num_empleado int;
  DECLARE finished int default false;

  DECLARE multiplicador double default 1.08;
  DECLARE contador int default 1;

  DECLARE cursorSalario cursor for 
	select num_empleado 
      from empleados 
      where num_departamento = p_num_departamento 
      order by salario 
      limit 5;
  declare continue handler for not found set finished = true;
    
  open cursorSalario;
    
	updateSalario: LOOP
		FETCH cursorSalario into p_num_empleado;
		if finished then
			leave updateSalario;
		end if;
    
		if contador = 2 then set multiplicador = 1.06;
		elseif contador = 3 then set multiplicador = 1.03;
		elseif contador = 4 then set multiplicador = 1.02;
		elseif contador = 5 then set multiplicador = 1.01;
		end if;

		UPDATE empleados 
        SET salario = salario * multiplicador 
        WHERE num_empleado = p_num_empleado;
        
		set contador = contador + 1;
	end loop updateSalario;
    
  close cursorSalario;
END