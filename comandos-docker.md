# Comandos Docker - Capacitación

## Comandos Docker Imágenes
- `docker images` - Devuelve una lista de todas las imágenes
- `docker rmi` - Eliminar una imagen
- `docker image rm nombredelaimagen` - Eliminar imagen por nombre
- `docker pull (image)` - Descarga una imagen

## Comando para crear un contenedor
### Crear una imagen
- `docker create mongo` - Se crea el contenedor en base de la imagen y se genera un id

### Ejecutar el contenedor
- `docker start id` - Inicia el contenedor
- `docker ps` - Ver los contenedores que se están ejecutando
- `docker ps -a` - Ver todos los contenedores
- `docker stop id` - Detener contenedor

### Eliminar contenedor
- `docker rm nombre o id` - Para eliminar el contenedor (debe estar stop primero)

### Asignar nombre al contenedor
- `docker create --name monguito mongo`

### Asignar puerto físico (port mapping)
- `docker create -p27017:27017 --name monguito mongo`

### Ver logs
- `docker logs monguito`
- `docker logs --follow monguito`

## Hacer una combinación de todo (imagen, contenedor)
Encuentra la imagen, si no está la descarga, crea el contenedor e inicia:
- `docker run mongo`
- `docker run -d mongo` - Con esto crea imagen y contenedor en background
- `docker run --name monguito -p27017:27017 -d mongo`

## Variables de entorno para usuario y contraseña
```bash
docker create -p27017:27017 --name monguito -e MONGO_INITDB_ROOT_USERNAME=daniel -e MONGO_INITDB_ROOT_PASSWORD=password mongo
```

## Redes Docker
**OJO: AL TENER DOS CONTENEDORES INDEPENDIENTES SE DEBERÁN AGRUPAR MEDIANTE UNA RED INTERNA**

### Ver nuestras redes
- `docker network ls`

### Crear una nueva red
- `docker network create mired`

### Eliminar red
- `docker network rm mired`

## Pasos para desplegar la aplicación con Docker

### 1. Crear la red
```bash
docker network create mired
```

### 2. Crear contenedor de MongoDB en la red
```bash
docker create -p27017:27017 --name monguito --network mired -e MONGO_INITDB_ROOT_USERNAME=daniel -e MONGO_INITDB_ROOT_PASSWORD=password mongo
```

### 3. Iniciar MongoDB
```bash
docker start monguito
```

### 4. Crear imagen de la aplicación
```bash
docker build -t miapp:practica .
```

### 5. Crear el contenedor de la aplicación
```bash
docker create -p3000:3000 --name prueba --network mired miapp:practica
```

### 6. Iniciar la aplicación
```bash
docker start prueba
```

### 7. Verificar que todo esté corriendo
```bash
docker ps
```

### 8. Probar la aplicación
- Listar: http://localhost:3000/
- Crear: http://localhost:3000/crear

### 9. Ver logs
```bash
docker logs --follow prueba
```

## Comandos para limpiar y reiniciar

```bash
# Detener contenedores
docker stop prueba monguito

# Eliminar contenedores
docker rm prueba monguito

# Eliminar imagen de la aplicación
docker rmi miapp:practica

# Eliminar red
docker network rm mired
```
