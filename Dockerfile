FROM node:9.8.0-alpine
RUN apk upgrade && apk update && apk add mysql-client
COPY . /tmp/
WORKDIR /tmp/rest-crud/
RUN npm install
EXPOSE 3000
CMD ["mysql", "-u root -pmy-secret-pw test -h userapp_userappdb < t_user.sql"]
CMD ["npm", "start"]
