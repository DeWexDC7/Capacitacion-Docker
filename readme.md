# 🐳 Comandos Más Utilizados en Docker

## 📋 Tabla de Contenidos
- [Comandos de Imágenes](#comandos-de-imágenes)
- [Comandos de Contenedores](#comandos-de-contenedores)
- [Comandos de Redes](#comandos-de-redes)
- [Comandos de Docker Compose](#comandos-de-docker-compose)
- [Dockerfile](#dockerfile)
- [Ejemplo Práctico](#ejemplo-práctico)

---

## 🖼️ Comandos de Imágenes

### Ver imágenes descargadas
```bash
docker images
```
**Descripción:** Muestra todas las imágenes Docker descargadas en tu sistema local. Muestra: Repository, TAG, IMAGE ID, CREATED, SIZE.

### Descargar una imagen
```bash
docker pull <nombre-imagen>
```
**Descripción:** Descarga una imagen desde Docker Hub u otro registro de contenedores.

**Ejemplos:**
```bash
# Descargar la última versión de Node.js
docker pull node

# Descargar una versión específica
docker pull node:18

# Otras imágenes comunes
docker pull mongo
docker pull postgres
docker pull python
docker pull mysql
```

### Eliminar una imagen
```bash
docker image rm <nombre-imagen>:<tag>
```
**Descripción:** Elimina una imagen específica de tu sistema local.

**Ejemplo:**
```bash
docker image rm node:18
```

### Construir una imagen desde Dockerfile
```bash
docker build -t <nombre>:<tag> <directorio>
```
**Descripción:** Crea una imagen personalizada a partir de un archivo Dockerfile. El flag `-t` permite asignar un nombre y etiqueta.

**Ejemplo:**
```bash
docker build -t miapp:latest .
```

---

## 📦 Comandos de Contenedores

### Crear un contenedor
```bash
docker create <nombre-imagen>
```
**Descripción:** Crea un contenedor a partir de una imagen, pero NO lo inicia. Retorna un ID del contenedor creado.

**Ejemplo básico:**
```bash
docker create mongo
```

### Crear contenedor con nombre personalizado
```bash
docker create --name <nombre-contenedor> <imagen>
```
**Descripción:** Crea un contenedor asignándole un nombre específico para facilitar su gestión.

**Ejemplo:**
```bash
docker create --name monguito mongo
```

### Crear contenedor con mapeo de puertos
```bash
docker create -p <puerto-host>:<puerto-contenedor> --name <nombre> <imagen>
```
**Descripción:** Crea un contenedor mapeando un puerto del host a un puerto del contenedor. Esto permite acceder al servicio desde fuera del contenedor.

**Ejemplo:**
```bash
# Mapear puerto 27017 del host al puerto 27017 del contenedor
docker create -p27017:27017 --name monguito mongo
```

### Crear contenedor con variables de entorno
```bash
docker create -p<puerto-host>:<puerto-contenedor> --name <nombre> -e <VARIABLE>=<valor> <imagen>
```
**Descripción:** Crea un contenedor pasándole variables de entorno necesarias para su configuración.

**Ejemplo:**
```bash
docker create -p27017:27017 --name monguito \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=pass \
  mongo
```

### Crear contenedor con red personalizada
```bash
docker create -p<puerto>:<puerto> --name <nombre> --network <red> <imagen>
```
**Descripción:** Crea un contenedor y lo conecta a una red específica de Docker, permitiendo comunicación entre contenedores.

**Ejemplo:**
```bash
docker create -p27017:27017 --name monguito --network mired \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=pass \
  mongo
```

### Iniciar un contenedor
```bash
docker start <id-o-nombre>
```
**Descripción:** Inicia un contenedor previamente creado o detenido.

**Ejemplo:**
```bash
docker start monguito
```

### Detener un contenedor
```bash
docker stop <id-o-nombre>
```
**Descripción:** Detiene un contenedor en ejecución de manera ordenada.

**Ejemplo:**
```bash
docker stop monguito
```

### Ver contenedores en ejecución
```bash
docker ps
```
**Descripción:** Muestra todos los contenedores que están actualmente en ejecución.

### Ver todos los contenedores (incluyendo detenidos)
```bash
docker ps -a
```
**Descripción:** Muestra todos los contenedores, estén en ejecución o detenidos.

### Eliminar un contenedor
```bash
docker rm <id-o-nombre>
```
**Descripción:** Elimina permanentemente un contenedor detenido.

**Ejemplo:**
```bash
docker rm monguito
```

### Ver logs de un contenedor
```bash
docker logs <nombre-contenedor>
```
**Descripción:** Muestra los logs generados por un contenedor.

**Ejemplo:**
```bash
docker logs monguito
```

### Ver logs en tiempo real
```bash
docker logs --follow <nombre-contenedor>
```
**Descripción:** Muestra los logs en tiempo real (modo seguimiento).

**Ejemplo:**
```bash
docker logs --follow monguito
```

### Ejecutar, crear e iniciar en un solo comando
```bash
docker run <imagen>
```
**Descripción:** Busca la imagen (si no existe la descarga), crea el contenedor y lo inicia, todo en un solo comando.

**Ejemplo:**
```bash
docker run mongo
```

### Ejecutar en modo detached (segundo plano)
```bash
docker run -d <imagen>
```
**Descripción:** Ejecuta el contenedor en segundo plano, liberando la terminal. El flag `-d` significa "detached mode".

**Ejemplo:**
```bash
docker run -d mongo
```

### Ejecutar con todas las opciones
```bash
docker run -d -p<puerto>:<puerto> --name <nombre> --network <red> -e <VAR>=<valor> <imagen>
```
**Descripción:** Comando completo para ejecutar un contenedor con todas las configuraciones.

**Ejemplo:**
```bash
docker run -d -p3000:3000 --name chanchito --network mired miapp:latest
```

---

## 🌐 Comandos de Redes

### Listar redes
```bash
docker network ls
```
**Descripción:** Muestra todas las redes Docker disponibles en el sistema.

### Crear una red personalizada
```bash
docker network create <nombre-red>
```
**Descripción:** Crea una red personalizada para permitir comunicación entre contenedores por nombre en lugar de IP.

**Ejemplo:**
```bash
docker network create mired
```

**¿Por qué usar redes personalizadas?**
- Permite que los contenedores se comuniquen entre sí usando nombres en lugar de IPs
- Aísla los contenedores de otras redes
- Facilita la configuración de aplicaciones multi-contenedor

---

## 🐳 Dockerfile

El **Dockerfile** es un archivo de texto que contiene instrucciones para construir una imagen Docker personalizada.

### Estructura básica de un Dockerfile

```dockerfile
# Imagen base - Especifica la imagen desde la cual construir
FROM node:18

# Crear directorio de trabajo dentro del contenedor
RUN mkdir -p /home/app

# Copiar archivos del host al contenedor
COPY . /home/app

# Establecer directorio de trabajo
WORKDIR /home/app

# Instalar dependencias
RUN npm install

# Exponer puerto en el que la aplicación escuchará
EXPOSE 3000

# Comando que se ejecuta al iniciar el contenedor
CMD ["node", "index.js"]
```

### Explicación de las instrucciones:

- **FROM**: Define la imagen base. En este caso, Node.js versión 18.
- **RUN**: Ejecuta comandos durante la construcción de la imagen (ej: crear directorios, instalar paquetes).
- **COPY**: Copia archivos/directorios desde el host al sistema de archivos del contenedor.
- **WORKDIR**: Establece el directorio de trabajo para las instrucciones siguientes.
- **EXPOSE**: Documenta qué puerto usa la aplicación (informativo, no abre el puerto automáticamente).
- **CMD**: Define el comando predeterminado que se ejecuta cuando el contenedor inicia.

---

## 🎼 Docker Compose

**Docker Compose** es una herramienta para definir y ejecutar aplicaciones Docker multi-contenedor. Usa un archivo YAML para configurar los servicios de la aplicación.

### Archivo docker-compose.yml

```yaml
version: "3.9"

services:
  app:
    build: .
    container_name: prueba
    ports:
      - "3000:3000"
    depends_on:
      - monguito
    networks:
      - mired

  monguito:
    image: mongo
    container_name: monguito
    ports:
      - "27017:27017"
    environment:
      - MONGO_INITDB_ROOT_USERNAME=daniel
      - MONGO_INITDB_ROOT_PASSWORD=password
    networks:
      - mired
    volumes:
      - mongo-data:/data/db

networks:
  mired:
    driver: bridge

volumes:
  mongo-data:
```

### Explicación de las secciones:

- **version**: Versión del formato de Docker Compose
- **services**: Define cada contenedor que formará parte de la aplicación
- **image**: Imagen a usar (o `build` para construir desde Dockerfile)
- **container_name**: Nombre del contenedor
- **ports**: Mapeo de puertos (host:contenedor)
- **environment**: Variables de entorno
- **networks**: Redes a las que se conecta el contenedor
- **volumes**: Volúmenes para persistencia de datos
- **depends_on**: Define dependencias entre servicios (orden de inicio)

### Comandos de Docker Compose

#### Iniciar todos los servicios
```bash
docker-compose up
```
**Descripción:** Crea y inicia todos los servicios definidos en docker-compose.yml

#### Iniciar en modo detached
```bash
docker-compose up -d
```
**Descripción:** Inicia todos los servicios en segundo plano

#### Detener todos los servicios
```bash
docker-compose down
```
**Descripción:** Detiene y elimina todos los contenedores, redes creadas por up

#### Ver logs de todos los servicios
```bash
docker-compose logs
```
**Descripción:** Muestra los logs de todos los servicios

#### Ver logs de un servicio específico
```bash
docker-compose logs <nombre-servicio>
```
**Descripción:** Muestra los logs de un servicio en particular

#### Reconstruir servicios
```bash
docker-compose build
```
**Descripción:** Reconstruye las imágenes de los servicios que usan `build`

#### Iniciar servicios reconstruyéndolos
```bash
docker-compose up --build
```
**Descripción:** Reconstruye las imágenes y luego inicia los servicios

---

## 💡 Ejemplo Práctico: Aplicación Node.js con MongoDB

### Estructura del proyecto
```
mi-proyecto/
├── index.js
├── package.json
├── Dockerfile
└── docker-compose.yml
```

### index.js
```javascript
import express from 'express'
import mongoose from 'mongoose'

// Definir modelo de datos
const Animal = mongoose.model('Animal', new mongoose.Schema({
  tipo: String,
  estado: String,
}))

const app = express()

// Conectar a MongoDB usando el nombre del contenedor
mongoose.connect('mongodb://daniel:password@monguito:27017/miapp?authSource=admin')

// Ruta para listar animales
app.get('/', async (_req, res) => {
  console.log('listando... chanchitos...')
  const animales = await Animal.find();
  return res.send(animales)
})

// Ruta para crear un animal
app.get('/crear', async (_req, res) => {
  console.log('creando...')
  await Animal.create({ tipo: 'Chanchito', estado: 'Feliz' })
  return res.send('ok')
})

app.listen(3000, () => console.log('listening...'))
```

### Pasos para ejecutar:

#### Opción 1: Sin Docker Compose
```bash
# 1. Crear red
docker network create mired

# 2. Crear y ejecutar MongoDB
docker create -p27017:27017 --name monguito --network mired \
  -e MONGO_INITDB_ROOT_USERNAME=daniel \
  -e MONGO_INITDB_ROOT_PASSWORD=password \
  mongo

docker start monguito

# 3. Construir imagen de la aplicación
docker build -t miapp:practica .

# 4. Crear y ejecutar aplicación
docker create -p3000:3000 --name prueba --network mired miapp:practica

docker start prueba
```

#### Opción 2: Con Docker Compose (Recomendado)
```bash
# Iniciar todo con un solo comando
docker-compose up -d

# Ver logs
docker-compose logs -f

# Detener todo
docker-compose down
```

---

## 📊 Resumen de Conceptos

### ¿Qué es un Contenedor?
Un contenedor es una unidad de software que empaqueta código y todas sus dependencias para que la aplicación se ejecute de manera rápida y confiable en diferentes entornos de computación.

**Ventajas:**
- ✅ **Portabilidad**: Funciona igual en cualquier sistema
- ✅ **Aislamiento**: Cada contenedor está aislado de los demás
- ✅ **Ligereza**: Comparten el kernel del host, son más ligeros que VMs
- ✅ **Consistencia**: Mismo entorno en desarrollo, pruebas y producción

### Imagen vs Contenedor
- **Imagen**: Plantilla de solo lectura con las instrucciones para crear un contenedor. Incluye código, dependencias y configuraciones.
- **Contenedor**: Instancia ejecutable de una imagen. Es el proceso en ejecución.

### Docker Hub
Repositorio público donde se almacenan imágenes de contenedores oficiales:
- Node.js
- MongoDB
- PostgreSQL
- MySQL
- Python
- Golang
- Y miles más...

---

## 🎯 Comandos Esenciales - Cheat Sheet

```bash
# IMÁGENES
docker images                    # Listar imágenes
docker pull <imagen>             # Descargar imagen
docker build -t <nombre> .       # Construir imagen
docker image rm <imagen>         # Eliminar imagen

# CONTENEDORES
docker ps                        # Contenedores activos
docker ps -a                     # Todos los contenedores
docker create <imagen>           # Crear contenedor
docker start <nombre>            # Iniciar contenedor
docker stop <nombre>             # Detener contenedor
docker rm <nombre>               # Eliminar contenedor
docker run -d <imagen>           # Crear e iniciar
docker logs <nombre>             # Ver logs
docker logs --follow <nombre>    # Ver logs en tiempo real

# REDES
docker network ls                # Listar redes
docker network create <nombre>   # Crear red

# COMPOSE
docker-compose up                # Iniciar servicios
docker-compose up -d             # Iniciar en background
docker-compose down              # Detener servicios
docker-compose logs              # Ver logs
docker-compose build             # Construir imágenes
```

---

## 🚀 Flujo de Trabajo Típico

1. **Descargar imagen** → `docker pull <imagen>`
2. **Crear red** → `docker network create <red>`
3. **Crear contenedor** → `docker create` con puertos, nombre, variables de entorno, red
4. **Iniciar contenedor** → `docker start <nombre>`
5. **Verificar estado** → `docker ps`
6. **Ver logs** → `docker logs <nombre>`

O simplemente usar **Docker Compose** para gestionar todo con un solo comando. 🎉
