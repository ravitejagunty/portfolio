# Dockerfile (for React MFE)
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .


# 🚨 Build without any baseHref
RUN npm run build


EXPOSE 3003
CMD ["npx", "serve", "dist/mfe-blogs", "-l", "3003","-s"]