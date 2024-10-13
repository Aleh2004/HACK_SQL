--HACK-1

create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);

create table users(
 id_users serial primary key,
 id_country integer not null,
 email varchar(100) not null,
 name varchar (50) not null,
 foreign key (id_country) references countries (id_country)   
);

--HACK-2

insert into countries (name) values ('argentina') , ('colombia'),('chile');
select * from countries;

insert into users (id_country, email, name) 
  values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 
select * from users;

delete from users where email = 'bar@bar.com';

update users set email = 'foo@foo.foo', name = 'fooz' where id_users = 1;
select * from users;

select * from users inner join  countries on users.id_country = countries.id_country;

select u.id_users as id, u.email, u.name as fullname, c.name 
  from users u inner join  countries c on u.id_country = c.id_country;
  
--HACK-3

CREATE TABLE priorities (
  id_priority SERIAL PRIMARY KEY,
  type_name VARCHAR(50) NOT NULL
);

CREATE TABLE contact_request (
  id_email SERIAL PRIMARY KEY,
  id_country INTEGER NOT NULL,
  id_priority INTEGER,
  name VARCHAR(50) NOT NULL,
  detail TEXT,
  physical_address VARCHAR(255),
  FOREIGN KEY (id_country) REFERENCES countries (id_country),
  FOREIGN KEY (id_priority) REFERENCES priorities (id_priority)
);


--HACK-4

INSERT INTO priorities (type_name) VALUES ('High'), ('Medium'), ('Low');

INSERT INTO countries (name) VALUES
  ('venezuela'),
  ('peru'),
  ('bolivia'),
  ('mexico'),
  ('ecuador');
  
INSERT INTO contact_request (id_country, id_priority, name, detail, physical_address) 
VALUES 
  (1, 1, 'Felipe M', 'Detalles Felipe', 'Av. Olivos 4109, Argentina'),
  (2, 2, 'Laura S', 'Detalles Laura', 'Avenida Calle 26 No 59-51, Colombia'),
  (3, 3, 'Mateo J', 'Detalles Mateo', 'Santa María 2670, Chile');
SELECT * FROM contact_request;

DELETE FROM users 
WHERE id_users = (SELECT MAX(id_users) FROM users);

--agregando usuarios de nuevo para poder actualizar
insert into users (id_country, email, name) 
  values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 
  
UPDATE users
SET email = 'nuevo@correo.com', 
    name = 'nuevo'
WHERE id_users = (SELECT MIN(id_users) FROM users);

--HACK-5

CREATE TABLE COUNTRIES (
    id_country SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE ROLES (
    id_role SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE TAXES (
    id_tax SERIAL PRIMARY KEY,
    percentage DECIMAL(5, 2) NOT NULL
);

CREATE TABLE OFFERS (
    id_offer SERIAL PRIMARY KEY,
    status VARCHAR(255) NOT NULL
);

CREATE TABLE DISCOUNTS (
    id_discount SERIAL PRIMARY KEY,
    status VARCHAR(255) NOT NULL,
    percentage DECIMAL(5, 2) NOT NULL
);

CREATE TABLE PAYMENTS (
    id_payment SERIAL PRIMARY KEY,
    type VARCHAR(255) NOT NULL
);

CREATE TABLE CUSTOMERS (
    id_customer SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    id_country INT REFERENCES COUNTRIES(id_country),
    id_role INT REFERENCES ROLES(id_role),
    name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 0),
    password VARCHAR(255) NOT NULL,
    physical_address TEXT
);

CREATE TABLE INVOICE_STATUS (
    id_invoice_status SERIAL PRIMARY KEY,
    status VARCHAR(255) NOT NULL
);

CREATE TABLE PRODUCTS (
    id_product SERIAL PRIMARY KEY,
    id_discount INT REFERENCES DISCOUNTS(id_discount),
    id_offer INT REFERENCES OFFERS(id_offer),
    id_tax INT REFERENCES TAXES(id_tax),
    name VARCHAR(255) NOT NULL,
    details TEXT,
    minimum_stock INT CHECK (minimum_stock >= 0),
    maximum_stock INT CHECK (maximum_stock >= 0),
    current_stock INT CHECK (current_stock >= 0),
    price DECIMAL(10, 2) NOT NULL,
    price_with_tax DECIMAL(10, 2) NOT NULL
);

CREATE TABLE PRODUCTS_CUSTOMERS (
    id_product INT REFERENCES PRODUCTS(id_product),
    id_customer INT REFERENCES CUSTOMERS(id_customer),
    PRIMARY KEY (id_product, id_customer)
);

CREATE TABLE INVOICES (
    id_invoice SERIAL PRIMARY KEY,
    id_customer INT REFERENCES CUSTOMERS(id_customer),
    id_payment INT REFERENCES PAYMENTS(id_payment),
    id_invoice_status INT REFERENCES INVOICE_STATUS(id_invoice_status),
    date DATE NOT NULL,
    total_to_pay DECIMAL(10, 2) NOT NULL
);

CREATE TABLE ORDERS (
    id_order SERIAL PRIMARY KEY,
    id_invoice INT REFERENCES INVOICES(id_invoice),
    id_product INT REFERENCES PRODUCTS(id_product),
    detail TEXT,
    amount INT CHECK (amount > 0),
    price DECIMAL(10, 2) NOT NULL
);


--HACK-6


INSERT INTO COUNTRIES (name) VALUES
('Venezuela'),
('Argentina'),
('Mexico');


INSERT INTO ROLES (name) VALUES
('Admin'),
('Customer'),
('Vendor');


INSERT INTO TAXES (percentage) VALUES
(5.00),
(10.00),
(15.00);


INSERT INTO OFFERS (status) VALUES
('Activo'),
('Expirado'),
('Proximo');


INSERT INTO DISCOUNTS (status, percentage) VALUES
('Activo', 10.00),
('Inactivo', 0.00),
('Estacionales', 20.00);


INSERT INTO PAYMENTS (type) VALUES
('Tarjeta de Credito o Debito'),
('PayPal'),
('Transferencia Bancaria');


INSERT INTO CUSTOMERS (email, id_country, id_role, name, age, password, physical_address) VALUES
('ejemplo1@ejemplo.com', 1, 1, 'Maria M', 30, 'pass123', 'Av. Los Libertadores, Venezuela'), 
('ejemplo2@ejemplo.com', 2, 2, 'Juana S', 25, 'pass456', 'Av. Olivos 4109, Argentina'), 
('ejemplo3@ejemplo.com', 3, 3, 'Pedro L', 28, 'pass789', 'Calle Melchor Ocampo, Mexico');


INSERT INTO INVOICE_STATUS (status) VALUES
('Pendiente'),
('Pagado'),
('Cancelado');


INSERT INTO PRODUCTS (id_discount, id_offer, id_tax, name, details, minimum_stock, maximum_stock, current_stock, price, price_with_tax) VALUES
(1, 1, 1, 'Producto A', 'Detalles de Producto A', 10, 100, 50, 100.00, 105.00), 
(2, 2, 2, 'Producto B', 'Detalles de Producto B', 5, 50, 25, 200.00, 220.00), 
(3, 3, 3, 'Producto C', 'Detalles de Producto C', 20, 200, 100, 300.00, 345.00);


INSERT INTO PRODUCTS_CUSTOMERS (id_product, id_customer) VALUES
(1, 1),
(2, 2),
(3, 3);


INSERT INTO INVOICES (id_customer, id_payment, id_invoice_status, date, total_to_pay) VALUES
(1, 1, 1, '2024-07-11', 100.00),
(2, 2, 2, '2024-07-20', 200.00),
(3, 3, 3, '2024-08-01', 300.00);


INSERT INTO ORDERS (id_invoice, id_product, detail, amount, price) VALUES
(1, 1, 'Orden Producto A', 1, 100.00),
(2, 2, 'Orden Producto B', 2, 200.00),
(3, 3, 'Orden Producto C', 3, 300.00);



DELETE FROM PRODUCTS_CUSTOMERS WHERE id_customer = (SELECT MIN(id_customer) FROM CUSTOMERS);

DELETE FROM ORDERS
WHERE id_invoice IN (SELECT id_invoice FROM INVOICES WHERE id_customer = (SELECT MIN(id_customer) FROM CUSTOMERS));

DELETE FROM INVOICES
WHERE id_customer = (SELECT MIN(id_customer) FROM CUSTOMERS);

DELETE FROM CUSTOMERS
WHERE id_customer = (SELECT MIN(id_customer) FROM CUSTOMERS);





SELECT MAX(id_customer) FROM CUSTOMERS;
UPDATE CUSTOMERS
SET name = 'Pepito M', email = 'nuevocorreo@ejemplo.com', age = 40
WHERE id_customer = (SELECT MAX(id_customer) FROM CUSTOMERS);

UPDATE TAXES
SET percentage = percentage + 2.00;

UPDATE PRODUCTS
SET price = price * 1.05,
    price_with_tax = price_with_tax * 1.05;

