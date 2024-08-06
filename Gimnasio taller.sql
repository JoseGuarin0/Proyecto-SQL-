CREATE DATABASE disparadores;
USE disparadores;

/*
dos de inserción
dos de eliminación
dos de actualización
cuatro con funciones
*/

CREATE TABLE ejercicio(
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    repeticiones INT NOT NULL,
    calorias_quemadas INT,
    fecha_inicio DATETIME,
    id_cliente INT,
	FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);

CREATE TABLE cliente(
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    peso FLOAT NOT NULL,
    altura FLOAT NOT NULL,
    estado VARCHAR(1) NOT NULL,
    id_gimansio INT,
	FOREIGN KEY (id_gimansio) REFERENCES gimnasio(id)
);

CREATE TABLE gimnasio(
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    subscripcion INT NOT NULL,
    ciudad VARCHAR(50) NOT NULL
);
CREATE TABLE registro_eliminacion_ejercicio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_ejercicio VARCHAR(50) NOT NULL,
    fecha_eliminacion DATETIME
);
CREATE TABLE registro_eliminacion_gimnasio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_gimnasio VARCHAR(100) NOT NULL,
    ciudad_gimnasio VARCHAR(100) NOT NULL,
    fecha_eliminacion DATETIME
);



-- Este trigger registra la eliminación de registros de ejercicios en la tabla ejercicio
-- Guardará información sobre el ejercicio eliminado, como su nombre y la fecha en que se eliminó.
DROP TRIGGER IF EXISTS Control_Ejercicio;
DELIMITER //
CREATE TRIGGER Control_Ejercicio AFTER DELETE ON ejercicio 
FOR EACH ROW
BEGIN
    INSERT INTO registro_eliminacion_ejercicio (nombre_ejercicio, fecha_eliminacion)
    VALUES (OLD.nombre, NOW());
END;
//
DELIMITER ;

-- Este trigger registra la eliminación de registros de gimnasios en la tabla gimnasio en un registro de auditoría llamado registro_eliminacion_gimnasio. 
-- Guardará información sobre el gimnasio eliminado, como su nombre y la ciudad en la que se encontraba.
DROP TRIGGER IF EXISTS control_gimnasio
DELIMITER //
CREATE TRIGGER control_gimnasio AFTER DELETE ON gimnasio
FOR EACH ROW
BEGIN
    INSERT INTO registro_eliminacion_gimnasio (nombre_gimnasio, ciudad_gimnasio, fecha_eliminacion)
    VALUES (OLD.nombre, OLD.ciudad, NOW());
END;
//
DELIMITER ;


-- ELIMINAR
DROP TRIGGER IF EXISTS eliminar_duplicados_cliente;
DELIMITER //
CREATE TRIGGER eliminar_duplicados_cliente
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
    DECLARE cliente_count INT;
    SET cliente_count = (SELECT COUNT(*) FROM cliente WHERE id = NEW.id OR id_gimansio = NEW.id_gimansio AND nombre = NEW.nombre AND apellido = NEW.apellido );
    IF cliente_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se permite insertar un cliente duplicado.';
    END IF;
END;
//
DELIMITER ;

INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (1,'JOSE','YOYU',22,58.29,1.62,'A',200 );
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (2,'LUCAS','MIA',18,90.69,1.42,'A',201 );
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (3,'YASMIN','BETA',60,67.99,1.72,'A',202);
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (4,'POLO','KARL',11,50.99,1.89,'A',202 );
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (5,'MMMM','NNNN',99,99.99,1.89,'I',202 );
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (6,'JOSE','GUARIN',22,58.29,1.62,'A',200 );
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (7,'JOSE','GUARIN',22,58.29,1.62,'A',200 );
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (8,'JOSE','GUARIN',22,58.29,1.62,'A',200 );
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (9,'LuLO','Maria',55,59.77,1.76,'A',201);
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (10,'LuO','Maia',53,21.37,2.76,'A',201);
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (11,'LuO','Maia',53,21.37,2.76,'A',201);
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (12,'Lux','lox',53,21.37,2.76,'A',201);
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (13,'Lux','lox',53,21.37,2.76,'A',201);
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (14,'Lux','lox',53,21.37,2.76,'A',201);
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (14,'Lux','lox',53,21.37,2.76,'A',201);
INSERT INTO cliente (id,nombre,apellido,edad,peso,altura,estado,id_gimansio) VALUES (15,'Luc','lox',53,21.37,2.76,'A',201);

INSERT INTO ejercicio (id,nombre,repeticiones,calorias_quemadas,fecha_inicio,id_cliente) VALUES (15,'Luc',20,2000,'2023-07-22',15);
INSERT INTO ejercicio (id,nombre,repeticiones,calorias_quemadas,fecha_inicio,id_cliente) VALUES (3,'YASMIN',20,2000,'2023-06-15',3);
INSERT INTO ejercicio (id,nombre,repeticiones,calorias_quemadas,fecha_inicio,id_cliente) VALUES (4,'POLO',20,2000,'2023-03-11',4);
INSERT INTO ejercicio (id,nombre,repeticiones,calorias_quemadas,fecha_inicio,id_cliente) VALUES (5,'MMMM',20,2000,'2023-03-30',5);
INSERT INTO ejercicio (id,nombre,repeticiones,calorias_quemadas,fecha_inicio,id_cliente) VALUES (6,'MMMM',20,2000,'2023-06-3',5);
INSERT INTO ejercicio (id,nombre,repeticiones,calorias_quemadas,fecha_inicio,id_cliente) VALUES (7,'MMMM',20,2000,'2023-07-11',5);



INSERT INTO gimnasio (id,nombre,subscripcion,ciudad) VALUES (202,'La sucursal',8990,'Bogota');
INSERT INTO gimnasio (id,nombre,subscripcion,ciudad) VALUES (201,'Gym',56000,'Medellin');