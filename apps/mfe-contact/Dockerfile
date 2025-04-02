# Dockerfile (for React MFE)
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

EXPOSE 3005
CMD ["npx", "serve", "dist", "-l", "3005"]