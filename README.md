# hello_http

Hello world with a webserver in C

## How to build

```docker build -t ubuntu_dev .```

## How to run

Service default port is 8080 inside docker container, in production, app runs on port 12344.

```docker run --name=hello -dp 127.0.0.1:12344:8080 ubuntu_dev```

## Access hello webserver

Once container is running, go to your browser and access the hello server
[http://127.0.0.1:12344/] or [http://localhost:12344/]

## Shutdown Container

When done, stop and delete the container

```sh
docker stop hello
docker rm hello
```
