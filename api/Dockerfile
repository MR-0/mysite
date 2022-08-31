FROM node:18.7-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
EXPOSE 80
CMD ["npm", "start"]