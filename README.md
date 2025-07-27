# Dev Compose

### Environment

Docker Compose development environment for PHP.

- Apache 2
- PHP 8.3 via php-fpm
- PHP 8.4 via php-fpm
- Mysql 9
- Postgresql 17
- Mongodb + Express
- Memcached
- Redis

The environment mounts the `~/html` directory in container's `/var/www/html`, also the `.gitconfig` file and `.ssh` directory from the user's home.

### PHP tools

Inside the container are installed

- phpstan
- PHP CS Fixer
- Composer
- PhpUnit
- Infection
- phpDocumentor

All tools above are available from every location in filesystem. phpDocumentor is named `php-doc`.

### Use the stack

```bash
git clone https://github.com/s3b4stian/dev-compose.git
```

Before all need to build the environment
```bash
./build.sh
```

And finally start all
```bash
./up.sh
```

To enter in development environment
```bash
./exec.sh
```

To stop all containers
```bash
./down.sh
```