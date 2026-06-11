# --- Etapa 1: Build ---
FROM node:20-alpine AS builder

WORKDIR /app

# Instalar dependencias de forma reproducible
COPY package.json package-lock.json ./
RUN npm ci

# Copiar el código fuente y compilar
COPY . .
RUN npm run build

# --- Etapa 2: Runner (producción) ---
FROM node:20-alpine AS runner

WORKDIR /app

# Configurar el entorno de ejecución para producción
ENV NODE_ENV=production

# Instalar solo las dependencias necesarias de producción
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Copiar los archivos compilados desde la etapa de build
COPY --from=builder /app/dist ./dist

# Comando de arranque para ejecutar la aplicación NestJS compilada
CMD ["node", "dist/main.js"]

# Puerto por defecto
EXPOSE 8080
