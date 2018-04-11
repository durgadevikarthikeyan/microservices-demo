FROM node:9.8.0-alpine
RUN apk upgrade && apk update && apk add mysql-client
COPY . /tmp/
WORKDIR /tmp/
RUN npm install
EXPOSE 3030
CMD ["npm","start"]
