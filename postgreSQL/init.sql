-- Tabla de Clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100),
    pais VARCHAR(50)
);

-- Tabla de Productos
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    categoria VARCHAR(50),
    precio DECIMAL
);

-- Tabla de Empleados
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    departamento VARCHAR(50),
    fecha_ingreso DATE
);

-- Tabla de Regiones
CREATE TABLE regiones (
    id SERIAL PRIMARY KEY,
    region_nombre VARCHAR(50),
    pais VARCHAR(50)
);

-- Tabla de Ventas
CREATE TABLE ventas (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    producto_id INT REFERENCES productos(id),
    empleado_id INT REFERENCES empleados(id),
    region_id INT REFERENCES regiones(id),
    cantidad INT,
    total DECIMAL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO clientes (nombre, correo, pais) VALUES
('Juan Pérez', 'juanperez@gmail.com', 'España'),
('Ana López', 'ana.lopez@hotmail.com', 'México'),
('Carlos García', 'carlos.garcia@yahoo.com', 'Argentina'),
('Laura Fernández', 'laura.fernandez@gmail.com', 'Chile'),
('Pedro Gómez', 'pedro.gomez@outlook.com', 'Colombia');


INSERT INTO productos (nombre, categoria, precio) VALUES
('Laptop', 'Electrónica', 1200),
('Smartphone', 'Electrónica', 800),
('Tablet', 'Electrónica', 600),
('Auriculares', 'Accesorios', 150),
('Monitor', 'Electrónica', 300);


INSERT INTO empleados (nombre, departamento, fecha_ingreso) VALUES
('Luis Torres', 'Ventas', '2020-05-01'),
('Marta Sánchez', 'Marketing', '2019-03-15'),
('José Ruiz', 'Ventas', '2021-07-10'),
('Lucía Morales', 'Soporte', '2018-11-20'),
('Andrés Díaz', 'Ventas', '2022-01-05');


INSERT INTO regiones (region_nombre, pais) VALUES
('Europa Occidental', 'España'),
('Latinoamérica Norte', 'México'),
('Latinoamérica Sur', 'Argentina'),
('Cono Sur', 'Chile'),
('Andina', 'Colombia');


DO $$
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO ventas (cliente_id, producto_id, empleado_id, region_id, cantidad, total, fecha)
        VALUES (
            (SELECT id FROM clientes ORDER BY RANDOM() LIMIT 1),
            (SELECT id FROM productos ORDER BY RANDOM() LIMIT 1),
            (SELECT id FROM empleados ORDER BY RANDOM() LIMIT 1),
            (SELECT id FROM regiones ORDER BY RANDOM() LIMIT 1),
            FLOOR(RANDOM() * 5 + 1),
            FLOOR(RANDOM() * 1000 + 100),
            NOW() - (INTERVAL '1 day' * FLOOR(RANDOM() * 365))
        );
    END LOOP;
END $$;
