-- VISTAS 
CREATE VIEW traerPlatillos 
AS
	SELECT * FROM platillos 
		INNER JOIN menus ON menus.Menu_Id = platillos.Pla_Menu_Id
        INNER JOIN categorias ON categorias.Cat_Id = platillos.Pla_Categoria_Id
        ORDER BY Pla_Id ASC;

CREATE VIEW PlatillosActivos
AS
	SELECT * FROM platillos
    INNER JOIN menus ON menus.Menu_Id = platillos.Pla_Menu_Id
    INNER JOIN categorias ON categorias.Cat_Id = platillos.Pla_Categoria_Id
         WHERE Pla_Estado = 'A'
         ORDER BY Pla_Id ASC;
   

CREATE VIEW IdDeTicket
AS
	SELECT MAX(Tic_Id) AS MaxId FROM tickets;
-- TRIGGERS

DELIMITER $$
CREATE TRIGGER Triggertickesborrados BEFORE DELETE ON tickets
 FOR EACH ROW
 BEGIN
    INSERT INTO ticketsborrados
        SELECT *  FROM tickets WHERE tickets.Tic_Id= old.Tic_Id;

 END;
 
-- PROCEDIMIENTOS
CREATE PROCEDURE ObtenerClienteConId (IN id_cliente INT)
	SELECT * FROM clientes
    WHERE Cli_Id = id_cliente;
    
CREATE PROCEDURE ObtenerClienteConApellidos(IN A_Paterno VARCHAR(20), IN A_Materno VARCHAR(20))
	SELECT * FROM clientes
		WHERE Cli_First_Surname = A_Paterno AND Cli_Second_Surname = A_Materno;


CREATE PROCEDURE LoginCliente(IN Correo VARCHAR(50), IN Pass VARCHAR(50))
	SELECT * FROM clientes
		WHERE Cli_Email = Correo AND Cli_Password = Pass;
        
-- REVISAR ESTE PROCEDIMIENTO ANTES DE EJECUTARLO 
CREATE PROCEDURE LoginAdmin(IN Correo VARCHAR(50), IN Pass VARCHAR(50))
	SELECT * FROM user
    INNER JOIN Cli_Name ON clientes.Cli_Id = user.User_Id
		WHERE Cli_Correo = Correo AND Cli_Password = Pass AND Cli_Nombre = 4;
        

DROP PROCEDURE ActualizarClienteConCorreo;
CREATE PROCEDURE ActualizarClienteConCorreo(IN IdCliente INT,IN Direccion VARCHAR(50), IN City VARCHAR(50), IN Pass VARCHAR(50),IN Telefono VARCHAR(15),In Correo VARCHAR(50))
    UPDATE clientes
        SET Cli_Direccion = Direccion,
            Cli_City = City,
            Cli_Password = Pass,
            Cli_Phone = Telefono,
            Cli_Email = Correo
        WHERE Cli_Id = IdCliente;
        
CREATE PROCEDURE AgregarTicket(IN IdTicket INT, IN Total INT, IN Fecha DATE, IN Cliente INT)
	INSERT INTO tickets (Tic_Id, Tic_Total,Tic_Fecha, Tic_Cliente_Id) 
		VALUES
		(IdTicket,Total,Fecha,Cliente);
        
CREATE PROCEDURE AgregarTicketPlatillos(IN IdTicket INT, IN IdPlatillo INT, IN Cantidad INT)
	INSERT INTO platillo_ticket (PT_Ticket_Id, PT_Platillo_Id, Cantidad_Platillo) 
		VALUES
		(IdTicket,IdPlatillo, Cantidad);
        
CREATE PROCEDURE TicketsDeCliente(IN IdCliente INT)
	SELECT * FROM tickets
		WHERE Tic_Cliente_Id = IdCliente;
        
CREATE PROCEDURE PlatillosDeTickets(IN IdTicket INT)
	SELECT * FROM platillo_ticket
    INNER JOIN platillos ON Pla_Id = PT_Platillo_Id
		WHERE PT_Ticket_Id = IdTicket; 
    
CREATE PROCEDURE RestarCantidad(IN Cantidad INT, IN IdPlatillo INT)
	UPDATE platillos
    SET Pla_Cantidad = Cantidad
		WHERE  Pla_Id = IdPlatillo;
	
    