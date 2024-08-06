
use Restaurante; 
CREATE TABLE img(
Img_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Ruta VARCHAR(1000),
Tipo CHAR(5)
);
CREATE TABLE categorias (
    Cat_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Cat_Nombre VARCHAR(20) NOT NULL,
    Cat_Estado ENUM ('A','I') NOT NULL
);

CREATE TABLE menus (
    Menu_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Menu_Tipo VARCHAR(20) NOT NULL,
    Menu_Estado ENUM ('A','I') NOT NULL
);
CREATE TABLE reservacion(
Res_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Res_Nombre INT NOT NULL,
Res_Phone INT NOT NULL,
Res_Personas INT NOT NULL,
Res_Fecha DATETIME NOT NULL, 
Res_Hora DATETIME NOT NULL,
CONSTRAINT FK_Clientes_Reservacion FOREIGN KEY (Res_Nombre)
	REFERENCES clientes (Cli_Id) ON DELETE CASCADE ON UPDATE CASCADE 
);
CREATE TABLE clientes (
    Cli_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Cli_Name VARCHAR(20) NOT NULL,
    Cli_First_Surname VARCHAR(20) NOT NULL,
    Cli_Second_Surname VARCHAR(20) NOT NULL,
    Cli_Email VARCHAR(50) NOT NULL CHECK (Cli_Email LIKE '%@%'),
    Cli_Password VARCHAR(20) NOT NULL CHECK (LENGTH(Cli_Password) > 8),
    Cli_City VARCHAR(50) NOT NULL,
    Cli_Direccion VARCHAR(100) NOT NULL,
    Cli_Phone VARCHAR(15) NOT NULL CHECK (LENGTH(Cli_Phone) = 10),
    Cli_Birthday DATE NOT NULL,
    Cli_Estado ENUM ('A','I') NOT NULL,
    UNIQUE INDEX Cli_Id_UNIQUE (Cli_Id ASC),
    UNIQUE INDEX Cli_Email_UNIQUE (Cli_Email ASC)
);


CREATE TABLE tickets (
    Tic_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Tic_Total INT NOT NULL,
    Tic_Fecha DATETIME NOT NULL,
    Tic_Cliente_Id INT NOT NULL,
    UNIQUE INDEX Tic_Id_UNIQUE (Tic_Id ASC),
    INDEX FK_Ticket_Cliente_idx (Tic_Cliente_Id ASC),
    CONSTRAINT FK_Cliente_Tickets FOREIGN KEY (Tic_Cliente_Id)
        REFERENCES clientes (Cli_Id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE platillos (
    Pla_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Pla_Nombre VARCHAR(40) NOT NULL,
    Pla_Descripcion VARCHAR(300) NOT NULL,
    Pla_Precio INT NOT NULL CHECK(Pla_Precio >= 50),
    Pla_Cantidad INT NOT NULL CHECK(Pla_Cantidad >= 0),
    Pla_Categoria_Id INT NOT NULL,
    Pla_Menu_Id INT NOT NULL,
    Pla_Imagen INT NOT NULL,
    Pla_Estado ENUM ('A','I'),
    UNIQUE INDEX Pla_Id_UNIQUE (Pla_Id ASC),
    INDEX FK_Categoria_Platillo_idx (Pla_Categoria_Id ASC),
    INDEX FK_Menu_Platillo_idx (Pla_Menu_Id ASC),
    CONSTRAINT FK_Categoria_Platillo FOREIGN KEY (Pla_Categoria_Id)
        REFERENCES categorias (Cat_Id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Menu_Platillo FOREIGN KEY (Pla_Menu_Id)
        REFERENCES menus (Menu_Id)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINt FK_Imagen_Platillo FOREIGN KEY (Pla_Imagen)
		REFERENCES img (Img_Id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE admin_menu (
    AM_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    AM_Admin_Id INT NOT NULL,
    AM_Menu_Id INT NOT NULL,
    AM_Estado ENUM ('A','I'),
    INDEX FK_Menus_idx (AM_Menu_Id ASC),
    INDEX FK_Admin_idx (AM_Admin_Id ASC),
    CONSTRAINT FK_Menus FOREIGN KEY (AM_Menu_Id)
        REFERENCES menus (Menu_Id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Admin FOREIGN KEY (AM_Admin_Id)
        REFERENCES clientes(Cli_Id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE platillo_ticket (
    PT_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    PT_Platillo_Id INT NOT NULL,
    PT_Ticket_Id INT NOT NULL,
    Cantidad_Platillo INT NOT NULL,
    INDEX FK_platillo_idx (PT_Platillo_Id ASC),
    INDEX FK_Ticket_idx (PT_Ticket_Id ASC),
    CONSTRAINT FK_platillo FOREIGN KEY (PT_Platillo_Id)
        REFERENCES platillos (Pla_Id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Ticket FOREIGN KEY (PT_Ticket_Id)
        REFERENCES tickets (Tic_Id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ticketsBorrados (
    TicB_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    TicB_Total INT NOT NULL,
    TicB_Fecha DATETIME NOT NULL,
    TicB_Cliente_Id INT NOT NULL,
    UNIQUE INDEX TicB_Id_UNIQUE (TicB_Id ASC),
    INDEX FK_TicketB_Cliente_idx (TicB_Cliente_Id ASC),
    CONSTRAINT FK_ClienteB_Tickets FOREIGN KEY (TicB_Cliente_Id)
        REFERENCES clientes (Cli_Id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE user (
    User_Id INT AUTO_INCREMENT PRIMARY KEY,
    User_Name VARCHAR(255) NOT NULL,
	User_Email VARCHAR(255) NOT NULL,
    User_Password VARCHAR(10) NOT NULL,
    User_Estado ENUM('A','I') NOT NULL,
	CONSTRAINT FK_Clientes_Id FOREIGN KEY (User_Id) REFERENCES clientes (Cli_Id) ON DELETE CASCADE ON UPDATE CASCADE
);
