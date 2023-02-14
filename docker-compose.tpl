version: "3.2"
services:
  dev_php_82:
    container_name: dev_phpfpm_82
    build: './php8.2/'
    networks:
      - backend
    restart: always
    volumes:
      - "/home/__CURRENT_USER__/html:/var/www/html"
  dev_php_81:
    container_name: dev_phpfpm_81
    build: './php8.1/'
    networks:
      - backend
    restart: always
    volumes:
      - "/home/__CURRENT_USER__/html:/var/www/html"
  dev_apache:
    container_name: dev_apache
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
    container_name: dev_mysql
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
    container_name: dev_postgres
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
    container_name: dev_mongo
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
    container_name: dev_mongo_express
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
    container_name: dev_memcached
    image: memcached
    networks:
      - backend
    restart: always
    ports:
      - 11211:11211
  dev_redis:
    container_name: dev_redis
    image: redis:7.0.5-alpine
    restart: always
    ports:
      - '6379:6379'
    command: redis-server --save 20 1 --loglevel warning --requirepass password
networks:
  frontend:
  backend:
