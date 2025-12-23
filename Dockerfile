FROM node:25

# Crear directorio de trabajo
RUN mkdir -p /home/app 

# Establecer directorio de trabajo
WORKDIR /home/app

# Copiar package.json primero (mejor para caché de Docker)
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto de los archivos
COPY . .

# Exponer puerto
EXPOSE 3000 

# Comando para ejecutar la aplicación
CMD ["node", "index.js"]