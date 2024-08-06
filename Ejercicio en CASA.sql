/*Crear una tabla personas*/
CREATE TABLE personas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    edad INT,
    ciudad_residencia VARCHAR(100)
);
/*Crea un procedimiento almacenado que tome como parámetros el nombre y la edad de una persona, e inserte un nuevo registro en una tabla llamada "personas".*/
DELIMITER //
CREATE PROCEDURE Insertar_Persona(IN nombre VARCHAR(255),IN edad INT)
BEGIN
	INSERT INTO personas(nombre, edad) VALUES (nombre, edad);
END //
DELIMITER ;
/*Crea un procedimiento almacenado que tome como parámetros el ID de una persona y su nueva edad, y actualice el registro correspondiente en la tabla "personas".*/
 DELIMITER //
 CREATE PROCEDURE Actualizar_Edad_Persona(IN personas_id INT, IN nueva_edad INT)
 BEGIN 
	UPDATE personas SET edad = nueva_edad WHERE id = persona_id;
 END //
 DELIMITER ;
/*Crea un procedimiento almacenado que tome como parámetro el ID de una persona y elimine el registro correspondiente de la tabla "personas".*/
DELIMITER //
CREATE PROCEDURE Eliminar_ID_Persona(IN persona_id INT)
BEGIN
	DELETE FROM personas WHERE id = persona_id;
END //
DELIMITER ;
/*Crea un procedimiento almacenado que tome como parámetro el nombre de una ciudad y devuelva todos los registros de personas que viven en esa ciudad desde la tabla "personas".*/
DELIMITER //
CREATE PROCEDURE Obtener_Persona_PorCiudad(IN ciudad VARCHAR(255))
BEGIN
	SELECT * FROM personas WHERE ciudad = ciudad;
END //
DELIMITER ;
/*Crea un procedimiento almacenado que tome como parámetro una edad y devuelva todas las personas de la tabla "personas" que tengan esa edad o superior.*/
DELIMITER //
CREATE PROCEDURE Obtener_Personas_PorEdad(IN edad INT) 
BEGIN 
	SELECT * FROM personas WHERE edad>=edad;
END //
DELIMITER ;
