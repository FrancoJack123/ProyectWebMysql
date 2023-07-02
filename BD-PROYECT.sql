CREATE DATABASE  IF NOT EXISTS PROYECTO_LP1;
USE PROYECTO_LP1;

DROP TABLE IF EXISTS CARGO;
CREATE TABLE CARGO 
(
COD_CARGO INT AUTO_INCREMENT PRIMARY KEY,
DESC_CARGO VARCHAR(20) NOT NULL
);

INSERT INTO CARGO (DESC_CARGO)
VALUES ('Administrador'), ('Empleado');

DROP TABLE IF EXISTS USUARIO;
CREATE TABLE USUARIO
(
  COD_USUARIO INT AUTO_INCREMENT PRIMARY KEY,
  NOMBRES VARCHAR(25) NOT NULL,
  APELLIDOS VARCHAR(25) NULL,
  TELEFONO VARCHAR(15) NULL,
  CORREO VARCHAR(60) NULL,
  NOMBRE_USUARIO VARCHAR(25) NOT NULL,
  CONTRASENA NVARCHAR(25) NOT NULL,
  COD_CARGO INT,
  ACTIVO BIT(1) NOT NULL,
  FECHA_REGISTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (COD_CARGO) REFERENCES CARGO(COD_CARGO)
);

INSERT INTO USUARIO (NOMBRES, APELLIDOS,TELEFONO,CORREO, NOMBRE_USUARIO, CONTRASENA, COD_CARGO, ACTIVO)
VALUES
    ('Jack','Moreno','+51 986968728','jackfra@gmail.com', 'jack_username', 'jack_password', 1, 1),
    ('Darwen','Tantalalena','+51 956856965','darweTa@gmail.com', 'darwen_username', 'darwen_password', 2, 1),
    ('Jheicer','Rodriguez','+51 965987956','jheiRo@gmail.com', 'jheicer_username', 'jheicer_password', 2, 1),
    ('Andree','Palomino','+51 952632523','andrePal@gmail.com', 'andree_username', 'andree_password', 2, 1),
    ('Angel','Mamane','+51 974956985','angelMama@gmail.com', 'angel_username', 'angel_password', 2, 0);

/* CONSULTA PARA EL INICIO DE SESION */
/*SELECT U.COD_USUARIO, U.NOMBRES, U.APELLIDOS, U.ACTIVO, C.COD_CARGO, C.DESC_CARGO
FROM USUARIO U
JOIN CARGO C ON U.COD_CARGO = C.COD_CARGO
WHERE U.NOMBRE_USUARIO = 'jack_username' AND U.CONTRASENA = 'jack_password';*/

/* ELIMININAMOS EL PROCEDIMIENTO ALMACENADO 'BuscarUsuarioInic' SI EXISTE */
DROP PROCEDURE IF EXISTS BuscarUsuarioInic;

/* CREAMOS EL PROCEDIMIENTO ALMACENADO 'BuscarUsuarioInic' PARA Q SOLO LISTE LOS ACTIVOS */
DELIMITER //
CREATE PROCEDURE BuscarUsuarioInic(
  IN inicial VARCHAR(50)
)
BEGIN
  SELECT U.*, C.DESC_CARGO
  FROM USUARIO U
  JOIN CARGO C ON U.COD_CARGO = C.COD_CARGO
  WHERE U.NOMBRES LIKE CONCAT(inicial, '%')
	AND U.ACTIVO = 1
  ORDER BY U.COD_USUARIO ASC;
END //
DELIMITER ;

/* METODO PARA LLAMARLO 'BuscarUsuarioInic' */
/*CALL BuscarUsuarioInic('');*/

/* ELIMININAMOS EL PROCEDIMIENTO ALMACENADO 'RegistrarUsuario' SI EXISTE */
DROP PROCEDURE IF EXISTS RegistrarUsuario;

/* CREAMOS EL PROCEDIMIENTO ALMACENADO 'RegistrarUsuario' */
DELIMITER //
CREATE PROCEDURE RegistrarUsuario(
  IN nombres VARCHAR(25),
  IN apellidos VARCHAR(25),
  IN telefono VARCHAR(15),
  IN correo VARCHAR(60),
  IN nombre_usuario VARCHAR(25),
  IN contrasena NVARCHAR(25),
  IN cod_cargo INT
)
BEGIN
  DECLARE activo_val BIT(1) DEFAULT 1;

  INSERT INTO USUARIO (NOMBRES, APELLIDOS, TELEFONO, CORREO, NOMBRE_USUARIO, CONTRASENA, COD_CARGO, ACTIVO)
  VALUES (nombres, apellidos, telefono, correo, nombre_usuario, contrasena, cod_cargo, activo_val);
  
  SELECT LAST_INSERT_ID() AS COD_USUARIO;
END //
DELIMITER ;

/* METODO PARA LLAMARLO 'RegistrarUsuario' */
/*CALL RegistrarUsuario( ?, ?, ?, ?, ?, ?, ?);*/

/* ELIMININAMOS EL PROCEDIMIENTO ALMACENADO 'ActualizarUsuario' SI EXISTE */
DROP PROCEDURE IF EXISTS ActualizarUsuario;

/* CREAMOS EL PROCEDIMIENTO ALMACENADO 'ActualizarUsuario' */
DELIMITER //
CREATE PROCEDURE ActualizarUsuario(
    IN p_COD_USUARIO INT,
    IN p_NOMBRES VARCHAR(25),
    IN p_APELLIDOS VARCHAR(25),
    IN p_TELEFONO VARCHAR(15),
    IN p_CORREO VARCHAR(60),
    IN p_COD_CARGO INT
)
BEGIN
    UPDATE USUARIO
    SET NOMBRES = p_NOMBRES,
        APELLIDOS = p_APELLIDOS,
        TELEFONO = p_TELEFONO,
        CORREO = p_CORREO,
        COD_CARGO = p_COD_CARGO
    WHERE COD_USUARIO = p_COD_USUARIO;
END //
DELIMITER ;

/* METODO PARA LLAMARLO 'ActualizarUsuario' */
/*CALL ActualizarUsuario(?, ?, ?, ?, ?, ?);*/

/* ELIMININAMOS EL PROCEDIMIENTO ALMACENADO 'DesactivarUsuario' SI EXISTE */
DROP PROCEDURE IF EXISTS DesactivarUsuario;

/* CREAMOS EL PROCEDIMIENTO ALMACENADO 'DesactivarUsuario' */
DELIMITER //
CREATE PROCEDURE DesactivarUsuario(
    IN p_COD_USUARIO INT
)
BEGIN
    UPDATE USUARIO
    SET ACTIVO = 0
    WHERE COD_USUARIO = p_COD_USUARIO;
END //
DELIMITER ;

/* METODO PARA LLAMARLO 'DesactivarUsuario' */
/*CALL DesactivarUsuario(2);*/
/*UPDATE USUARIO SET ACTIVO = 1 WHERE COD_USUARIO = 6;*/

/* ELIMININAMOS EL PROCEDIMIENTO ALMACENADO 'ListarUsuariosInactivos' SI EXISTE */
DROP PROCEDURE IF EXISTS ListarUsuariosInactivos;

/* CREAMOS EL PROCEDIMIENTO ALMACENADO 'ListarUsuariosInactivos' */
DELIMITER //
CREATE PROCEDURE ListarUsuariosInactivos()
BEGIN
  SELECT U.*, C.DESC_CARGO
  FROM USUARIO U
  INNER JOIN CARGO C ON U.COD_CARGO = C.COD_CARGO
  WHERE U.ACTIVO = 0;
END //
DELIMITER ;

/* METODO PARA LLAMARLO 'ListarUsuariosInactivos' */
/*CALL ListarUsuariosInactivos();*/

DELIMITER //
CREATE PROCEDURE ActivarUsuario(
    IN p_COD_USUARIO INT
)
BEGIN
    UPDATE USUARIO
    SET ACTIVO = 1
    WHERE COD_USUARIO = p_COD_USUARIO;
END //
DELIMITER ;

/*CALL ActivarUsuario(1);*/

DROP PROCEDURE IF EXISTS ListarDashboard;

DELIMITER //
CREATE PROCEDURE ListarDashboard()
BEGIN
  SELECT
    (SELECT COUNT(*) FROM USUARIO) AS total_usuarios,
    (SELECT COUNT(*) FROM USUARIO WHERE DATE(NOW()) = DATE(FECHA_REGISTRO)) AS usuarios_registrados_hoy,
    (SELECT COUNT(*) FROM USUARIO WHERE ACTIVO = 0) AS usuarios_desactivados,
    (SELECT COUNT(*) FROM CLIENTE) AS total_clientes,
    (SELECT COUNT(*) FROM CLIENTE WHERE DATE(NOW()) = DATE(FECHA_REGISTRO)) AS clientes_registrados_hoy,
    (SELECT COUNT(*) FROM PRODUCTOS) AS total_productos,
    (SELECT COUNT(*) FROM PRODUCTOS WHERE DATE(NOW()) = DATE(FECHAREGISTRO)) AS productos_registrados_hoy,
    (SELECT COUNT(*) FROM PRODUCTOS WHERE ACTIVO = 0) AS productos_desactivados;
END //
DELIMITER ;
/*CALL ListarDashboard();*/



/* --------------------------------------------------------------------- */

DROP TABLE IF EXISTS CLIENTE;
CREATE TABLE CLIENTE
(
  COD_CLIENTE INT AUTO_INCREMENT PRIMARY KEY,
  NOMBRES VARCHAR(50) NOT NULL,
  APELLIDOS VARCHAR(50) NOT NULL,
  DNI VARCHAR(9) NOT NULL,
  TELEFONO VARCHAR(15) NOT NULL,
  CORREO VARCHAR(100),
  DIRECCION VARCHAR(100) NULL,
  FECHA_REGISTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE CLIENTE
ADD UNIQUE (DNI);

SELECT * FROM CLIENTE WHERE DNI = '56789012';

INSERT INTO CLIENTE (NOMBRES, APELLIDOS, DNI, TELEFONO, CORREO, DIRECCION)
VALUES
('Juan', 'Perez', '12345678', '987654321', 'juan.perez@example.com', 'Calle 123'),
('Maria', 'Gomez', '87654321', '123456789', 'maria.gomez@example.com', 'Avenida 456'),
('Pedro', 'Lopez', '56789012', '987654321', 'pedro.lopez@example.com', 'Calle 789'),
('Laura', 'Rodriguez', '23456789', '123456789', 'laura.rodriguez@example.com', 'Avenida 123'),
('Carlos', 'Martinez', '90123456', '987654321', 'carlos.martinez@example.com', 'Calle 456'),
('Ana', 'Sanchez', '34567890', '123456789', 'ana.sanchez@example.com', 'Avenida 789'),
('Luis', 'Gonzalez', '67890123', '987654321', 'luis.gonzalez@example.com', 'Calle 123'),
('Elena', 'Torres', '01234567', '123456789', 'elena.torres@example.com', 'Avenida 456'),
('Mario', 'Rios', '45678901', '987654321', 'mario.rios@example.com', 'Calle 789'),
('Sofia', 'Fernandez', '89012345', '123456789', 'sofia.fernandez@example.com', 'Avenida 123');

SELECT * FROM CLIENTE;

DROP PROCEDURE IF EXISTS BuscarClientePorInicial;

DELIMITER //
CREATE PROCEDURE BuscarClientePorInicial(IN inicial VARCHAR(50))
BEGIN
  SELECT *
  FROM CLIENTE
  WHERE NOMBRES LIKE CONCAT(inicial, '%');
END //
DELIMITER ;

/*CALL BuscarClientePorInicial('Jua');*/


DELIMITER //
CREATE PROCEDURE AgregarCliente(
  IN pNombres VARCHAR(50),
  IN pApellidos VARCHAR(50),
  IN pDNI VARCHAR(9),
  IN pTelefono VARCHAR(15),
  IN pCorreo VARCHAR(100),
  IN pDireccion VARCHAR(100)
)
BEGIN
  INSERT INTO CLIENTE (NOMBRES, APELLIDOS, DNI, TELEFONO, CORREO, DIRECCION)
  VALUES (pNombres, pApellidos, pDNI, pTelefono, pCorreo, pDireccion);
END //
DELIMITER ;

/*CALL AgregarCliente(?, ?, ?, ?, ?, ?);*/

DELIMITER //
CREATE PROCEDURE ActualizarCliente(
  IN pCodCliente INT,
  IN pNombres VARCHAR(50),
  IN pApellidos VARCHAR(50),
  IN pDNI VARCHAR(9),
  IN pTelefono VARCHAR(15),
  IN pCorreo VARCHAR(100),
  IN pDireccion VARCHAR(100)
)
BEGIN
  UPDATE CLIENTE
  SET NOMBRES = pNombres,
      APELLIDOS = pApellidos,
      DNI = pDNI,
      TELEFONO = pTelefono,
      CORREO = pCorreo,
      DIRECCION = pDireccion
  WHERE COD_CLIENTE = pCodCliente;
END //
DELIMITER ;

/*CALL ActualizarCliente(?, ?, ?, ?, ?, ?, ?);*/

-- drop procedure ObtenerClientesRegistradosPorDia;
DELIMITER //
CREATE PROCEDURE ObtenerClientesRegistradosPorDia()
BEGIN
  SELECT
    SUM(CASE WHEN DAYOFWEEK(FECHA_REGISTRO) = 2 THEN 1 ELSE 0 END) AS 'LUNES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_REGISTRO) = 3 THEN 1 ELSE 0 END) AS 'MARTES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_REGISTRO) = 4 THEN 1 ELSE 0 END) AS 'MIERCOLES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_REGISTRO) = 5 THEN 1 ELSE 0 END) AS 'JUEVES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_REGISTRO) = 6 THEN 1 ELSE 0 END) AS 'VIERNES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_REGISTRO) = 7 THEN 1 ELSE 0 END) AS 'SABADO',
    SUM(CASE WHEN DAYOFWEEK(FECHA_REGISTRO) = 1 THEN 1 ELSE 0 END) AS 'DOMINGO'
  FROM CLIENTE
  WHERE YEARWEEK(FECHA_REGISTRO) = YEARWEEK(NOW())
  ORDER BY DAYOFWEEK(FECHA_REGISTRO);
END //
DELIMITER ;

-- call ObtenerClientesRegistradosPorDia();


/* --------------------------------------------------------------------- */

DROP TABLE IF EXISTS CATEGORIA;
CREATE TABLE CATEGORIA 
(
COD_CATEGORIA INT AUTO_INCREMENT PRIMARY KEY,
NOMBRE_CATEGORIA VARCHAR(60) NOT NULL
);

INSERT INTO CATEGORIA (NOMBRE_CATEGORIA)
VALUES
('Pollo a la Brasa'),
('Bebidas'),
('Ensaladas'),
('Acompañamientos'),
('Postres'),
('Parrillas'),
('Sopas'),
('Tragos'),
('Carnes'),
('Mariscos');

-- SELECT * FROM CATEGORIA;

/* AGREGAMOS CATEGORIA */
/*INSERT INTO CATEGORIA (NOMBRE_CATEGORIA) VALUES (?);*/

/* ACTUALIZAMOS CATEGORIA */
/*UPDATE CATEGORIA SET NOMBRE_CATEGORIA =? WHERE COD_CATEGORIA =?;*/


DROP TABLE IF EXISTS PRODUCTOS;
CREATE TABLE PRODUCTOS(
COD_PRODUCTO INT AUTO_INCREMENT PRIMARY KEY,
COD_CATEGORIA INT,
NOMBRE_PRODUCTO VARCHAR(60) NOT NULL,
STOCK INT NOT NULL,
FECHA_VENCIMIENTO DATE NULL,
PRECIO DOUBLE NOT NULL,
ACTIVO BIT(1) NOT NULL,
FECHAREGISTRO DATE DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (COD_CATEGORIA) REFERENCES CATEGORIA(COD_CATEGORIA)
);
-- SELECT * FROM PRODUCTOS 
INSERT INTO PRODUCTOS (COD_CATEGORIA, NOMBRE_PRODUCTO, STOCK, FECHA_VENCIMIENTO, PRECIO, ACTIVO)
VALUES
(1, '1/4 de Pollo a la Brasa', 50, '2023-09-05', 15.99, 1),
(1, '1/2 de Pollo a la Brasa', 30, '2023-09-18', 21.99, 1),
(1, 'Pollo Entero a la Brasa', 20, '2023-09-30', 39.99, 1),
(2, 'Gaseosa Coca-Cola', 100, '2023-08-07', 2.99, 1),
(2, 'Gaseosa Inca Kola', 100, '2023-08-20', 2.99, 1),
(2, 'Jugo de Naranja', 50, '2023-08-25', 3.99, 1),
(3, 'Ensalada Mixta', 40, '2023-08-10', 6.99, 1),
(3, 'Ensalada Caesar', 30, '2023-08-22', 7.99, 1),
(3, 'Ensalada Griega', 35, '2023-09-02', 8.99, 1),
(4, 'Papas Fritas', 80, '2023-08-14', 3.99, 1),
(4, 'Yuca Frita', 60, '2023-08-28', 4.99, 1),
(4, 'Tostones', 70, '2023-09-06', 4.99, 1),
(5, 'Torta de Chocolate', 25, '2023-08-16', 9.99, 1),
(5, 'Cheesecake de Fresa', 20, '2023-08-29', 8.99, 1),
(5, 'Arroz con Leche', 30, '2023-09-10', 6.99, 1),
(6, 'Parrillada Mixta', 15, '2023-08-20', 24.99, 1),
(6, 'Choripán', 40, '2023-08-31', 6.99, 1),
(6, 'Matambre', 30, '2023-09-12', 19.99, 1),
(7, 'Sopa de Pollo', 50, '2023-08-24', 5.99, 1),
(7, 'Chupe de Camarones', 20, '2023-09-04', 12.99, 1),
(7, 'Locro de Gallina', 25, '2023-09-15', 10.99, 1),
(8, 'Pisco Sour', 100, '2023-08-28', 7.99, 1),
(8, 'Margarita', 80, '2023-09-08', 7.99, 1),
(8, 'Chilcano de Pisco', 60, '2023-09-18', 8.99, 1),
(9, 'Lomo Saltado', 35, '2023-08-30', 16.99, 1),
(9, 'Tallarín Saltado', 40, '2023-09-10', 14.99, 1),
(9, 'Seco de Res', 30, '2023-09-22', 17.99, 1),
(10, 'Ceviche Mixto', 30, '2023-09-01', 13.99, 1),
(10, 'Arroz con Mariscos', 25, '2023-09-12', 15.99, 1),
(10, 'Jalea Mixta', 20, '2023-09-23', 17.99, 1),
(1, '1/4 de Pollo a la Parrilla', 40, '2023-09-07', 14.99, 1),
(2, 'Agua Mineral', 60, '2023-08-12', 1.99, 1),
(3, 'Ensalada Caprese', 25, '2023-08-25', 9.99, 1),
(4, 'Camote Frito', 40, '2023-09-08', 4.99, 1),
(5, 'Mazamorra Morada', 30, '2023-09-19', 5.99, 1),
(6, 'Costillitas BBQ', 20, '2023-08-24', 18.99, 1),
(7, 'Sopa Criolla', 35, '2023-09-05', 6.99, 1),
(8, 'Mojito', 70, '2023-09-15', 8.99, 1),
(9, 'Ají de Gallina', 30, '2023-09-26', 13.99, 1),
(10, 'Causa Rellena', 40, '2023-08-31', 11.99, 1),
(1, '1/2 de Pollo a la Parrilla', 25, '2023-09-10', 19.99, 1),
(2, 'Gaseosa Sprite', 80, '2023-09-21', 2.99, 1),
(3, 'Ensalada Waldorf', 30, '2023-09-02', 7.99, 1),
(4, 'Plátano Frito', 45, '2023-09-13', 3.99, 1),
(5, 'Suspiro Limeño', 15, '2023-09-24', 10.99, 1),
(6, 'Chuleta de Cerdo', 20, '2023-09-05', 16.99, 1),
(7, 'Chupe de Pollo', 25, '2023-09-16', 11.99, 1),
(8, 'Caipirinha', 50, '2023-09-27', 7.99, 1),
(9, 'Causa de Pollo', 35, '2023-08-31', 9.99, 1),
(10, 'Leche de Tigre', 40, '2023-09-11', 6.99, 1),
(1, 'Pollo a la Broaster', 30, '2023-09-14', 17.99, 1),
(2, 'Agua con Gas', 60, '2023-08-19', 1.99, 1),
(3, 'Ensalada de Palta', 20, '2023-09-01', 8.99, 1),
(4, 'Taro Frito', 35, '2023-09-12', 4.99, 1),
(5, 'Picarones', 40, '2023-09-23', 5.99, 1),
(6, 'Bondiola de Cerdo', 15, '2023-08-28', 21.99, 1),
(7, 'Sopa de Quinua', 25, '2023-09-08', 7.99, 1),
(8, 'Daiquiri', 70, '2023-09-18', 8.99, 1),
(9, 'Arroz Chaufa', 30, '2023-09-29', 12.99, 1),
(10, 'Chupe de Mariscos', 20, '2023-08-31', 14.99, 1);

DROP PROCEDURE IF EXISTS BuscarProductoPorInicial;

DELIMITER //
CREATE PROCEDURE BuscarProductoPorInicial(IN inicial VARCHAR(50))
BEGIN
  SELECT P.*, C.NOMBRE_CATEGORIA
  FROM PRODUCTOS P
  INNER JOIN CATEGORIA C ON P.COD_CATEGORIA = C.COD_CATEGORIA
  WHERE P.NOMBRE_PRODUCTO LIKE CONCAT(inicial, '%') AND P.ACTIVO = 1;
END //
DELIMITER ;

CALL BuscarProductoPorInicial('');


DELIMITER //
CREATE PROCEDURE BuscarProductoInactivos()
BEGIN
  SELECT P.*, C.NOMBRE_CATEGORIA
  FROM PRODUCTOS P
  INNER JOIN CATEGORIA C ON P.COD_CATEGORIA = C.COD_CATEGORIA
  WHERE P.ACTIVO = 0;
END //
DELIMITER ;

CALL BuscarProductoInactivos();

DROP PROCEDURE IF EXISTS ActivarProducto;

DELIMITER //
CREATE PROCEDURE ActivarProducto(
  IN pCodProducto INT,
  IN pStock INT
)
BEGIN
  IF pStock > 0 THEN
    UPDATE PRODUCTOS
    SET ACTIVO = 1, STOCK = pStock
    WHERE COD_PRODUCTO = pCodProducto;
  ELSE
    UPDATE PRODUCTOS
    SET ACTIVO = 0, STOCK = pStock
    WHERE COD_PRODUCTO = pCodProducto;
  END IF;
END //
DELIMITER ;

/*CALL ActivarProducto(?, ?);*/

DROP PROCEDURE IF EXISTS AgregarProducto;

DELIMITER //
CREATE PROCEDURE AgregarProducto(
    IN categoria INT,
    IN nombre VARCHAR(60),
    IN stock INT,
    IN fechaVencimiento DATE,
    IN precio DOUBLE
)
BEGIN
    DECLARE activo BIT(1);
    SET activo = 1;
    
    INSERT INTO PRODUCTOS (COD_CATEGORIA, NOMBRE_PRODUCTO, STOCK, FECHA_VENCIMIENTO, PRECIO, ACTIVO, FECHAREGISTRO)
    VALUES (categoria, nombre, stock, fechaVencimiento, precio, activo, CURRENT_DATE());
END //
DELIMITER ;

CALL AgregarProducto(?, ?, ?, ?, ?);

DELIMITER //
CREATE PROCEDURE ActualizarProducto(
    IN codigo INT,
    IN categoria INT,
    IN nombre VARCHAR(60),
    IN stock INT,
    IN fechaVencimiento DATE,
    IN precio DOUBLE
)
BEGIN
    UPDATE PRODUCTOS
    SET COD_CATEGORIA = categoria,
        NOMBRE_PRODUCTO = nombre,
        STOCK = stock,
        FECHA_VENCIMIENTO = fechaVencimiento,
        PRECIO = precio
    WHERE COD_PRODUCTO = codigo;
END //
DELIMITER ;

CALL ActualizarProducto(?, ?, ?, ?, ?, ?);

DELIMITER //
CREATE PROCEDURE DesactivarProducto(
    IN codigo INT
)
BEGIN
    UPDATE PRODUCTOS
    SET ACTIVO = 0,
        STOCK = 0
    WHERE COD_PRODUCTO = codigo;
END //
DELIMITER ;

CALL DesactivarProducto(?);

DROP TABLE IF EXISTS ESTADO;
CREATE TABLE ESTADO
(
COD_ESTADO CHAR(3) PRIMARY KEY,
NOMBRE VARCHAR(50) NOT NULL
);

INSERT INTO ESTADO (COD_ESTADO, NOMBRE)
VALUES
  ('CAN', 'CANCELADO'),
  ('FIN', 'FINALIZADO'),
  ('EMI', 'EMITIDO');
  

DROP TABLE IF EXISTS PEDIDOS;
CREATE TABLE PEDIDOS
(
COD_PEDIDO INT AUTO_INCREMENT PRIMARY KEY,
COD_CLIENTE INT NOT NULL,
COD_USUARIO INT NULL,
FECHA_PEDIDO DATE DEFAULT CURRENT_TIMESTAMP,
MONTO DOUBLE NOT NULL,
COD_ESTADO CHAR(3) NOT NULL,
FOREIGN KEY (COD_ESTADO) REFERENCES ESTADO(COD_ESTADO),
FOREIGN KEY (COD_CLIENTE) REFERENCES CLIENTE(COD_CLIENTE),
FOREIGN KEY (COD_USUARIO) REFERENCES USUARIO(COD_USUARIO)
);
select * from PEDIDOS;

/* LISTAR PARA LOS PEDIDOS POR SEMANA*/
-- drop procedure ObtenerPedidosRegistradosPorDia;

DELIMITER //
CREATE PROCEDURE ObtenerPedidosRegistradosPorDia()
BEGIN
  SELECT
    SUM(CASE WHEN DAYOFWEEK(FECHA_PEDIDO) = 2 THEN 1 ELSE 0 END) AS 'LUNES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_PEDIDO) = 3 THEN 1 ELSE 0 END) AS 'MARTES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_PEDIDO) = 4 THEN 1 ELSE 0 END) AS 'MIERCOLES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_PEDIDO) = 5 THEN 1 ELSE 0 END) AS 'JUEVES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_PEDIDO) = 6 THEN 1 ELSE 0 END) AS 'VIERNES',
    SUM(CASE WHEN DAYOFWEEK(FECHA_PEDIDO) = 7 THEN 1 ELSE 0 END) AS 'SABADO',
    SUM(CASE WHEN DAYOFWEEK(FECHA_PEDIDO) = 1 THEN 1 ELSE 0 END) AS 'DOMINGO'
  FROM PEDIDOS
  WHERE YEARWEEK(FECHA_PEDIDO) = YEARWEEK(NOW())
  ORDER BY DAYOFWEEK(FECHA_PEDIDO);
END //
DELIMITER ;

-- CALL ObtenerPedidosRegistradosPorDia();

/* */

DELIMITER //
CREATE PROCEDURE RegistrarPedido(
    IN cliente_id INT,
    IN usuario_id INT,
    IN monto DOUBLE
)
BEGIN
    DECLARE estado_id CHAR(3);
    
    SELECT COD_ESTADO INTO estado_id FROM ESTADO WHERE NOMBRE = 'EMITIDO';
    
    INSERT INTO PEDIDOS (COD_CLIENTE, COD_USUARIO, MONTO, COD_ESTADO)
    VALUES (cliente_id, usuario_id, monto, estado_id);
    
    SELECT LAST_INSERT_ID() AS COD_PEDIDO;
END //
DELIMITER ;

-- CALL RegistrarPedido(1, 1, 100.0);

DROP TABLE IF EXISTS DETALLE_PEDIDO;
CREATE TABLE DETALLE_PEDIDO
(
COD_DETALLE INT AUTO_INCREMENT PRIMARY KEY,
COD_PEDIDO INT,
COD_PRODUCTO INT,
CANTIDAD INT NOT NULL,
PRECIO_VENTA DOUBLE NOT NULL,
FOREIGN KEY (COD_PEDIDO) REFERENCES PEDIDOS(COD_PEDIDO),
FOREIGN KEY (COD_PRODUCTO) REFERENCES PRODUCTOS(COD_PRODUCTO)
);

DELIMITER //
CREATE PROCEDURE CrearDetallePedido(
    IN pedido_id INT,
    IN producto_id INT,
    IN cantidad INT,
    IN precio_venta DOUBLE
)
BEGIN
    INSERT INTO DETALLE_PEDIDO (COD_PEDIDO, COD_PRODUCTO, CANTIDAD, PRECIO_VENTA)
    VALUES (pedido_id, producto_id, cantidad, precio_venta);
END //
DELIMITER ;

-- CALL CrearDetallePedido(5, 2, 5, 10.0);

-- select * from DETALLE_PEDIDO


DELIMITER //
CREATE PROCEDURE ListarPedidosPorCliente(IN inicial VARCHAR(50))
BEGIN
    SELECT p.COD_PEDIDO, p.COD_CLIENTE, c.NOMBRES AS NOMBRE_CLIENTE, p.COD_USUARIO, p.MONTO, p.COD_ESTADO
    FROM PEDIDOS p
    INNER JOIN CLIENTE c ON p.COD_CLIENTE = c.COD_CLIENTE
    WHERE c.NOMBRES LIKE CONCAT(inicial, '%');
END //
DELIMITER ;
-- CALL ListarPedidosPorCliente("jo");

DELIMITER //
CREATE PROCEDURE CambiarEstadoCancelar(IN pedidoId INT)
BEGIN
    UPDATE PEDIDOS
    SET COD_ESTADO = 'CAN'
    WHERE COD_PEDIDO = pedidoId;
END //
DELIMITER ;

-- CALL CambiarEstadoCancelar(1);
-- drop procedure CambiarEstadoCancelar;

DELIMITER //
CREATE PROCEDURE CambiarEstadoFinalizado(IN pedidoId INT)
BEGIN
    UPDATE PEDIDOS
    SET COD_ESTADO = 'FIN'
    WHERE COD_PEDIDO = pedidoId;
END //
DELIMITER ;

-- CALL CambiarEstadoFinalizado(1);
