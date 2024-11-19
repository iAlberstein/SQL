# SQL

**Descripción:** 
El proyecto consiste en el diseño de una base de datos para el Teatro Español Pigüé. El objetivo es gestionar la programación de espectáculos, funciones, usuarios y la venta de entradas. Esto permitirá una mejor organización, un seguimiento eficiente de las funciones programadas y una experiencia más fluida para los usuarios.

**Objetivo:**
Implementar una base de datos relacional para administrar la información de espectáculos, funciones, salas y usuarios. El sistema permitirá:
- Registrar espectáculos, funciones y géneros asociados.
- Gestionar la venta de entradas asociada a funciones específicas.
- Mantener un registro detallado de usuarios y sus compras.

**Situación Problemática:**
El teatro enfrenta desafíos en la gestión manual de espectáculos, funciones y entradas. La implementación de esta base de datos solucionará problemas como la duplicidad de datos, falta de trazabilidad de ventas y errores en la asignación de funciones y salas.

**Modelo de Negocio:**
- Gestión de espectáculos por género y funciones específicas.
- Asignación de salas según la capacidad.
- Control de ventas y registro de entradas por función.

---
# Listado de Tablas

## Tabla: GENEROS
| Campo       | Tipo       | Clave | Descripción                    |
|-------------|------------|-------|--------------------------------|
| id_género   | INT        | PK    | Identificador único del género |
| género      | VARCHAR(50)|       | Nombre del género              |

---

## Tabla: ESPECTÁCULOS
| Campo          | Tipo       | Clave | Descripción                           |
|----------------|------------|-------|---------------------------------------|
| id_espectáculo | INT        | PK    | Identificador único del espectáculo   |
| título         | VARCHAR(100)|      | Título del espectáculo                |
| fecha          | DATE       |       | Fecha del estreno                     |
| hora           | TIME       |       | Hora del estreno                      |
| duración       | TIME       |       | Duración del espectáculo              |
| id_género      | INT        | FK    | Relación con la tabla `GENEROS`       |

---

## Tabla: FUNCIONES
| Campo          | Tipo       | Clave | Descripción                           |
|----------------|------------|-------|---------------------------------------|
| id_función     | INT        | PK    | Identificador único de la función     |
| id_espectáculo | INT        | FK    | Relación con la tabla `ESPECTÁCULOS`  |
| id_sala        | INT        | FK    | Relación con la tabla `SALAS`         |
| fecha_función  | DATE       |       | Fecha de la función                   |
| hora_función   | TIME       |       | Hora de la función                    |

---

## Tabla: SALAS
| Campo        | Tipo       | Clave | Descripción                     |
|--------------|------------|-------|---------------------------------|
| id_sala      | INT        | PK    | Identificador único de la sala  |
| nombre_sala  | VARCHAR(100)|      | Nombre de la sala               |
| capacidad    | INT        |       | Capacidad de la sala en asientos|

---

## Tabla: ENTRADAS
| Campo         | Tipo         | Clave | Descripción                           |
|---------------|--------------|-------|---------------------------------------|
| id_entrada    | INT          | PK    | Identificador único de la entrada     |
| id_función    | INT          | FK    | Relación con la tabla `FUNCIONES`     |
| id_usuario    | INT          | FK    | Relación con la tabla `USUARIOS`      |
| precio        | DECIMAL(10,2)|       | Precio de la entrada                  |
| fecha_compra  | DATE         |       | Fecha de la compra                    |

---

## Tabla: USUARIOS
| Campo        | Tipo       | Clave | Descripción                           |
|--------------|------------|-------|---------------------------------------|
| id_usuario   | INT        | PK    | Identificador único del usuario       |
| nombre       | VARCHAR(100)|      | Nombre del usuario                    |
| apellido     | VARCHAR(100)|      | Apellido del usuario                  |
| email        | VARCHAR(100)|      | Correo electrónico del usuario        |
| teléfono     | VARCHAR(15) |      | Teléfono de contacto del usuario      |

---



## Diagrama E-R:
<img src="./images/DER.png">

## Reverse Engineer:
<img src="./images/Reverse-Engineer.png">