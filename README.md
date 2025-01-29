
# <center>Entrega de proyecto final</center>
Alumno: Bruno Alberstein

Comision: 72705

Tutor: Nicolás Maugeri 

Docente: Anderson Michel TORRES 


---

### **Consignas:**
- La base de datos debe contener al menos:
    * ~ 15 tablas, entre las cuales debe haber al menos 1 tabla de hechos,  2 tablas transaccionales.
    * ~ 5 vistas.
    * ~ 2 stored procedure.
    * ~ 2  trigger.
    * ~ 2 funciones
    
- El documento debe contener:
    - Introducción
    - Objetivo
    - Situación problemática
    - Modelo de negocio
    - Diagrama de entidad relació
    - Listado de tablas con descripción de estructura (columna,descripción, tipo de datos, tipo de clave)
    - Scripts de creación de cada objeto de la base de datos
    - Scripts de inserción de datos
    - Informes generados en base a la información de la base
    - Herramientas y tecnologías usadas



---

## Tematica del proyecto

**Descripción:** 
El proyecto consiste en el diseño de una base de datos para el Teatro Español Pigüé. El objetivo es gestionar la programación de espectáculos, funciones, usuarios y la venta de entradas. Esto permitirá una mejor organización, un seguimiento eficiente de las funciones programadas y una experiencia más fluida para los usuarios.

**Situación Problemática:**
El teatro enfrenta desafíos en la gestión manual de espectáculos, funciones y entradas. La implementación de esta base de datos solucionará problemas como la duplicidad de datos, falta de trazabilidad de ventas y errores en la asignación de funciones y salas.

## Modelo de negocio

**Modelo de Negocio:**
- Gestión de espectáculos por género y funciones específicas.
- Asignación de salas según la capacidad.
- Control de ventas y registro de entradas por función.

## Diagrama entidad relacion (DER)

Con Reverse Engineer:

<img src="./images/Reverse-Engineer.png">

## Listado de tablas y descripcion

### 1. **Tabla: GENEROS**
| Campo       | Tipo        | Clave | Descripción                    |
|-------------|-------------|-------|--------------------------------|
| id_genero   | INT         | PK    | Identificador único del género |
| genero      | VARCHAR(50) |       | Nombre del género              |

### 2. **Tabla: ESPECTÁCULOS**
| Campo          | Tipo         | Clave | Descripción                           |
|----------------|--------------|-------|---------------------------------------|
| id_espectaculo | INT          | PK    | Identificador único del espectáculo   |
| titulo         | VARCHAR(100) |       | Título del espectáculo                |
| fecha          | DATE         |       | Fecha del estreno                     |
| hora           | TIME         |       | Hora del estreno                      |
| duracion       | INT          |       | Duración del espectáculo (en minutos) |
| id_genero      | INT          | FK    | Relación con la tabla GENEROS         |

### 3. **Tabla: SALAS**
| Campo        | Tipo         | Clave | Descripción                     |
|--------------|--------------|-------|---------------------------------|
| id_sala      | INT          | PK    | Identificador único de la sala  |
| nombre_sala  | VARCHAR(100) |       | Nombre de la sala               |
| capacidad    | INT          |       | Capacidad de la sala en asientos|

### 4. **Tabla: FUNCIONES**
| Campo          | Tipo         | Clave | Descripción                           |
|----------------|--------------|-------|---------------------------------------|
| id_funcion     | INT          | PK    | Identificador único de la función     |
| id_espectaculo | INT          | FK    | Relación con la tabla ESPECTÁCULOS    |
| id_sala        | INT          | FK    | Relación con la tabla SALAS           |
| fecha_funcion  | DATE         |       | Fecha de la función                   |
| hora_funcion   | TIME         |       | Hora de la función                    |

### 5. **Tabla: USUARIOS**
| Campo        | Tipo         | Clave | Descripción                           |
|--------------|--------------|-------|---------------------------------------|
| id_usuario   | INT          | PK    | Identificador único del usuario       |
| nombre       | VARCHAR(50)  |       | Nombre del usuario                    |
| apellido     | VARCHAR(50)  |       | Apellido del usuario                  |
| email        | VARCHAR(100) |       | Correo electrónico del usuario        |
| telefono     | VARCHAR(20)  |       | Teléfono de contacto del usuario      |

### 6. **Tabla: ROLES**
| Campo        | Tipo         | Clave | Descripción                           |
|--------------|--------------|-------|---------------------------------------|
| id_rol       | INT          | PK    | Identificador único del rol           |
| nombre_rol   | VARCHAR(50)  |       | Nombre del rol                        |
| descripcion  | TEXT         |       | Descripción del rol                   |

### 7. **Tabla: USUARIOS_ROLES**
| Campo        | Tipo | Clave | Descripción                              |
|--------------|------|-------|------------------------------------------|
| id_usuario   | INT  | FK    | Relación con la tabla USUARIOS           |
| id_rol       | INT  | FK    | Relación con la tabla ROLES              |

### 8. **Tabla: ENTRADAS**
| Campo         | Tipo         | Clave | Descripción                           |
|---------------|--------------|-------|---------------------------------------|
| id_entrada    | INT          | PK    | Identificador único de la entrada     |
| id_funcion    | INT          | FK    | Relación con la tabla FUNCIONES       |
| id_usuario    | INT          | FK    | Relación con la tabla USUARIOS        |
| precio        | DECIMAL(10,2)|       | Precio de la entrada                  |
| fecha_compra  | DATETIME     |       | Fecha de la compra                    |

### 9. **Tabla: MÉTODOS_DE_PAGO**
| Campo       | Tipo         | Clave | Descripción                           |
|-------------|--------------|-------|---------------------------------------|
| id_metodo   | INT          | PK    | Identificador único del método de pago|
| metodo_pago | VARCHAR(50)  |       | Nombre del método de pago             |

### 10. **Tabla: PAGOS**
| Campo          | Tipo         | Clave | Descripción                              |
|----------------|--------------|-------|------------------------------------------|
| id_pago        | INT          | PK    | Identificador único del pago             |
| id_entrada     | INT          | FK    | Relación con la tabla ENTRADAS           |
| monto          | DECIMAL(10,2)|       | Monto del pago                           |
| fecha_pago     | DATETIME     |       | Fecha del pago                           |
| id_metodo_pago | INT          | FK    | Relación con la tabla MÉTODOS_DE_PAGO    |

### 11. **Tabla: HISTORIAL_FUNCIONES**
| Campo        | Tipo         | Clave | Descripción                              |
|--------------|--------------|-------|------------------------------------------|
| id_historial | INT          | PK    | Identificador único del historial        |
| id_funcion   | INT          | FK    | Relación con la tabla FUNCIONES          |
| accion       | VARCHAR(255) |       | Descripción de la acción realizada       |
| fecha_accion | DATETIME     |       | Fecha y hora de la acción                |

### 12. **Tabla: HISTORIAL_ENTRADAS**
| Campo        | Tipo         | Clave | Descripción                              |
|--------------|--------------|-------|------------------------------------------|
| id_historial | INT          | PK    | Identificador único del historial        |
| id_entrada   | INT          | FK    | Relación con la tabla ENTRADAS           |
| accion       | VARCHAR(255) |       | Descripción de la acción realizada       |
| fecha_accion | DATETIME     |       | Fecha y hora de la acción                |

### 13. **Tabla: FACTURAS**
| Campo         | Tipo         | Clave | Descripción                              |
|---------------|--------------|-------|------------------------------------------|
| id_factura    | INT          | PK    | Identificador único de la factura        |
| id_entrada    | INT          | FK    | Relación con la tabla ENTRADAS           |
| fecha_factura | DATETIME     |       | Fecha de emisión de la factura           |
| monto         | DECIMAL(10,2)|       | Monto total de la factura                |

### 14. **Tabla: TICKETS**
| Campo       | Tipo     | Clave | Descripción                          |
|-------------|----------|-------|--------------------------------------|
| id_ticket   | INT      | PK    | Identificador único del ticket       |
| id_entrada  | INT      | FK    | Relación con la tabla ENTRADAS       |
| estado      | ENUM     |       | Estado del ticket (pendiente/validado) |

### 15. **Tabla: VALORACIONES**
| Campo          | Tipo         | Clave | Descripción                              |
|----------------|--------------|-------|------------------------------------------|
| id_valoracion  | INT          | PK    | Identificador único de la valoración     |
| id_funcion     | INT          | FK    | Relación con la tabla FUNCIONES          |
| id_usuario     | INT          | FK    | Relación con la tabla USUARIOS           |
| puntuacion     | INT          |       | Puntuación del usuario (1-5)             |
| comentario     | TEXT         |       | Comentario del usuario                   |
| fecha_valoracion | DATETIME   |       | Fecha de la valoración                   |


## Estructura e ingesta de datos

Se realiza un population inicial con información básica y luego se realiza ingesta de datos relacionados a los usuarios mediante importación del archivo 'usuarios_teatro.csv' generado con Mockaroo

## Objetos de la base de datos

**Objetivo:**
Implementar una base de datos relacional para administrar la información de espectáculos, funciones, salas y usuarios. El sistema permitirá:
- Registrar espectáculos, funciones y géneros asociados.
- Gestionar la venta de entradas asociada a funciones específicas.
- Mantener un registro detallado de usuarios y sus compras.

## Roles y permisos

- Administrador: Acceso total a todos los recursos y configuraciones.
- Usuario: Acceso limitado a funciones básicas.
- Premium: Acceso a funciones avanzadas y contenido exclusivo

## Back up de la base de datos

[Acceder al Backup](backups/backup_28enero2025.sql) 



## Herramientas y tecnologias usadas

* Visual Studio Code
* MySQL Workbench
* GitHub
* Mockaroo
* DeepSeek
