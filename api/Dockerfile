FROM node:18.7-alpine
WORKDIR /app
COPY package*.json .
RUN npm install --production
COPY . .
EXPOSE 3300
CMD ["npm", "start"]