# ABD – Administración de Base de Datos

Este repositorio contiene una aplicación desarrollada en **Java** (Maven) con una pequeña interfaz web en **HTML, CSS y JavaScript**.  
El objetivo del proyecto es practicar el desarrollo de aplicaciones basadas en datos: manejo de entidades, lógica de negocio y capa de presentación web para Fundación Telefónica Perú.

---

## 🧰 Tecnologías

- Java (JDK 17 o superior recomendado)
- Maven (se incluye **maven wrapper**: `mvnw` / `mvnw.cmd`)
- HTML, CSS, JavaScript

---

## 📂 Estructura del proyecto

Estructura típica del código:

- `src/main/java` – Código fuente Java (lógica de negocio / controladores).
- `src/main/resources` – Recursos de la aplicación (configuración, plantillas, estáticos si aplica).
- `src/test/java` – Pruebas unitarias (si se añaden).
- `pom.xml` – Configuración de Maven y dependencias.

> La organización exacta de paquetes puede variar según cómo se haya creado el proyecto, pero la forma de compilar y ejecutar se mantiene igual.

---

## ✅ Requisitos previos

Antes de ejecutar el proyecto, asegúrate de tener:

- **Java JDK** 17+ instalado y configurado en el `PATH`.
- **Maven 3.8+** instalado
- Toda la base de datos ejecutada en Oracle Database (versión 21c en adelante), estos archivos se encuentran en la carpeta Data)
  *(opcional, también puedes usar el wrapper `./mvnw` que viene en el repo).*

---

## ▶️ Cómo ejecutar el proyecto

### 1. Clonar el repositorio

git clone https://github.com/JP-Mej/ABD.git
cd ABD

### 2. Compilar el proyecto
Usando Maven instalado:

mvn clean package
o usando el Maven Wrapper incluido:

./mvnw clean package       # Linux / macOS
mvnw.cmd clean package     # Windows
Esto generará un archivo JAR dentro de la carpeta target/.

### 3. Ejecutar la aplicación

java -jar target/NOMBRE_DEL_JAR_GENERADO.jar
