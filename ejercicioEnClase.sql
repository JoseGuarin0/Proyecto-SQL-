/*Imprimir en pantalla los numeros del 10 al 20*/
DELIMITER //
CREATE PROCEDURE CONDICIONA()
BEGIN 
DECLARE i DOUBLE;
    SET i = 10;
    WHILE i <= 20 DO
		SELECT i;
        SET i = i+1;
	END WHILE;
END //
DELIMITER ;

/*Imprimir en Pantalla los numeros Impares del 10 al 20 */
DELIMITER //
CREATE PROCEDURE Impar()
BEGIN
DECLARE i DOUBLE;
SET i = 10;
    WHILE i <= 20 DO
		IF i % 2 <> 0 
        THEN
			SELECT i;
		END IF;
		SET i = i +1;
	END WHILE ; 
END //
DELIMITER ;
/*Imprimir en Pantalla los numeros PARES del 10 al 20 */
DELIMITER //
CREATE PROCEDURE Par()
BEGIN
DECLARE i DOUBLE;
SET i = 10;
    WHILE i <= 20 DO
		IF i % 2 = 0 
        THEN
			SELECT i;
		END IF;
		SET i = i +1;
	END WHILE ; 
END //
DELIMITER ;
/*Calcular Factorial de un Numero*/
DELIMITER //
CREATE PROCEDURE Factorial(IN FACTORIAL INT)
BEGIN
    DECLARE resultado BIGINT;
    DECLARE i INT;
    SET resultado = 1;
    SET i = 1;
    WHILE i <= FACTORIAL DO
        SET resultado = resultado * i;
        SET i = i + 1;
    END WHILE;
    SELECT resultado;
END //
DELIMITER ;
/* Suma los numeros del 1 al 10 y almacenar el resultado en una tabla*/
CREATE TABLE resultado_suma (
    id INT AUTO_INCREMENT PRIMARY KEY,
    suma_total INT
);
DELIMITER //
CREATE PROCEDURE Calcular_Suma_Rango()
BEGIN
    DECLARE suma INT;
    DECLARE i INT;
    SET suma = 0;
    SET i = 1;
    WHILE i <= 10 DO
        SET suma = suma + i;
        SET i = i + 1;
    END WHILE;
    INSERT INTO resultado_suma (suma_total) VALUES (suma);
END //
DELIMITER ;
