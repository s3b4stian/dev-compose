version: "3.2"
services:
  dev_php:
    build: './php8.1/'
    networks:
      - backend
    restart: always
    volumes:
      - "/home/__CURRENT_USER__/html:/var/www/html"
  dev_apache:
    build: './www/'
    networks:
      - frontend
      - backend
    restart: always
    volumes:
      - "/home/__CURRENT_USER__/html:/var/www/html"
    ports:
      - 80:80
      - 443:443
  dev_mysql:
    image: mysql:latest
    command: --default-authentication-plugin=mysql_native_password
    networks:
      - backend
    restart: always
    volumes:
      - "/home/__CURRENT_USER__/data/mysql:/var/lib/mysql"
    environment:
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_ROOT_HOST=%
    ports:
      - 3306:3306
  dev_pgsql:
    image: postgres
    networks:
      - backend
    restart: always
    volumes:
      - "/home/__CURRENT_USER__/data/postgresql:/var/lib/postgresql/data"
    environment:
      - POSTGRES_PASSWORD=password
    ports:
      - 5432:5432
  dev_mongo:
    image: mongo
    networks:
      - backend
    restart: always
    environment:
      - MONGO_INITDB_ROOT_USERNAME=root
      - MONGO_INITDB_ROOT_PASSWORD=password
    ports:
      - 27017:27017
  dev_mongo_express:
    image: mongo-express
    networks:
      - backend
      - frontend
    restart: always
    ports:
      - 8081:8081
    environment:
      - ME_CONFIG_MONGODB_ADMINUSERNAME=root
      - ME_CONFIG_MONGODB_ADMINPASSWORD=password
      - ME_CONFIG_MONGODB_SERVER=dev_mongo
  dev_memcached:
    image: memcached
    networks:
      - backend
    restart: always
    ports:
      - 11211:11211
networks:
  frontend:
  backend:
