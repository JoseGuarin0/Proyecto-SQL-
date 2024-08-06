USE Restaurant;

CREATE TABLE category (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    status ENUM ('A','I') NOT NULL
);

CREATE TABLE menu (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(20) NOT NULL,
    status ENUM ('A','I') NOT NULL
);

CREATE TABLE role (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    role VARCHAR (100) NOT NULL
);
CREATE TABLE category (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
	status ENUM('A','I') NOT NULL
);

CREATE TABLE user (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
image varchar(255) not null,
email varchar(255) not null unique,
password varchar(255),
status ENUM('A','I') NOT NULL,
role INT NOT NULL,
created_at DATETIME NOT NULL,
CONSTRAINT FK_user_role FOREIGN KEY (role)
	REFERENCES role (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE client (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    first_surname VARCHAR(255) NOT NULL,
    second_surname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL CHECK (email LIKE '%@%'),
    password VARCHAR(255) NOT NULL CHECK (LENGTH(password) > 8),
    city VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL CHECK (LENGTH(phone) = 10),
    birthday DATE NOT NULL,
    user INT NOT NULL,
    status ENUM('A','I') NOT NULL,
    UNIQUE INDEX id_UNIQUE (id ASC),
    UNIQUE INDEX email_UNIQUE (email ASC),
    CONSTRAINT FK_client_role FOREIGN KEY (user)
	REFERENCES user (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE reservation(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client INT NOT NULL,
    phone INT NOT NULL,
    people_count INT NOT NULL,
    date_time DATETIME NOT NULL, 
    time DATETIME NOT NULL,
    CONSTRAINT FK_Clientes_Reservacion FOREIGN KEY (client)
        REFERENCES client (id) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE ticket (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    total INT NOT NULL,
    date DATETIME NOT NULL,
    client INT NOT NULL,
    UNIQUE INDEX id_UNIQUE (id ASC),
    INDEX FK_Ticket_Client_idx (client ASC),
    CONSTRAINT FK_Client_Ticket FOREIGN KEY (client)
        REFERENCES client (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dish (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    description VARCHAR(300) NOT NULL,
    price INT NOT NULL CHECK(price >= 50),
    quantity INT NOT NULL CHECK(quantity >= 0),
    category INT NOT NULL,
    menu INT NOT NULL,
    imageUrl VARCHAR(1000),
    imageType CHAR(5),
    status ENUM ('A','I'),
    UNIQUE INDEX id_UNIQUE (id ASC),
    INDEX FK_Category_Dish_idx (category ASC),
    INDEX FK_Menu_Dish_idx (menu ASC),
    CONSTRAINT FK_Category_Dish FOREIGN KEY (category)
        REFERENCES category (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Menu_Dish FOREIGN KEY (menu)
        REFERENCES menu (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE admin_menu (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user INT NOT NULL,
    menu INT NOT NULL,
    status ENUM ('A','I'),
    INDEX FK_Menu_idx (menu ASC),
    INDEX FK_Admin_idx (admin ASC),
    CONSTRAINT FK_Menu FOREIGN KEY (menu)
        REFERENCES menu (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Admin FOREIGN KEY (user)
        REFERENCES user(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dishticket (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dish INT NOT NULL,
    ticket INT NOT NULL,
    quantity INT NOT NULL,
    status ENUM ('A','I'),
    INDEX FK_dish_idx (dish ASC),
    INDEX FK_Ticket_idx (ticket ASC),
    CONSTRAINT FK_dish FOREIGN KEY (dish)
        REFERENCES dish (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Ticket FOREIGN KEY (ticket)
        REFERENCES ticket (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
