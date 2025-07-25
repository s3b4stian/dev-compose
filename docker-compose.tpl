services:
  dev_php_84:
    container_name: dev_phpfpm_84
    hostname: php84-dev-container
    build: './php8.4/'
    networks:
      - backend
    restart: always
    volumes:
      - "/home/__CURRENT_USER__/html:/var/www/html"
  dev_php_83:
    container_name: dev_phpfpm_83
    hostname: php83-dev-container
    build: './php8.3/'
    networks:
      - backend
    restart: always
    volumes:
      - "/home/__CURRENT_USER__/html:/var/www/html"
  dev_apache:
    container_name: dev_apache
    hostname: apache-dev-container
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
    hostname: mysql-dev-container
    image: mysql:9
#    command: --default-authentication-plugin=mysql_native_password
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
    hostname: postgres-dev-container
    image: postgres:17
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
    hostname: mongo-dev-container
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
    hostname: mongo-express-dev-container
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
    hostname: memcached-dev-container
    image: memcached
    networks:
      - backend
    restart: always
    ports:
      - 11211:11211
  dev_redis:
    container_name: dev_redis
    image: redis:7.4-alpine
    networks:
      - backend
    restart: always
    ports:
      - '6379:6379'
    command: redis-server --save 20 1 --loglevel warning --requirepass password
networks:
  frontend:
  backend:
