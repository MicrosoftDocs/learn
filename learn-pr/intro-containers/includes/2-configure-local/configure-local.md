# Configure a local container development system

Before running a container or container-integrated application in Azure, you will mostly likely work in a local development environment such as your laptop. This unit help you prepare your system for container development.

## Docker for Windows and Mac

Docker inc. has made available two applications that quickly install and configure a local container development environment. Esentially, each prepares your development system with Docker tooling such as the necessary CLI and automation tools, creates a virtual machine to host a the Docker platform and provide isolation, and configures the environment so that Docker commands are passed through to the virtual machine. Each of the applications is similar in features and functionality and includes the following:

- Docker platform - the core componente necisary to create and run containers.
- Dokcer CLI - command line interface for inneracrting with Docker containers
- Docker Compose - automation tooling for defining and running multi-contianer applications.

To install Docker on your system, follow the link that matched your operating system.

Docker for Windows - https://www.docker.com/docker-windows
Docker for Mac - https://www.docker.com/docker-mac

## Docker on Linux

If you are working on a Linux-based system, the Docker server components and CLI tools can be manually installed. Follow the instructions found on [About Dokcer CE](https://docs.docker.com/install/#server) for your specific Linux distribution [About Dokcer CE](https://docs.docker.com/install/#server)

## Validate configuration

To validate that Docker has been sucessfully installed and configured, run the following command.

```
docker search nginx
```

If you see output similar to the following, your environment is read for the next unit.

```
AME                                                   DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
nginx                                                  Official build of Nginx.                        9034                [OK]
jwilder/nginx-proxy                                    Automated Nginx reverse proxy for docker con…   1362                                    [OK]
richarvey/nginx-php-fpm                                Container running Nginx + PHP-FPM capable of…   589                                     [OK]
jrcs/letsencrypt-nginx-proxy-companion                 LetsEncrypt container to use with nginx as p…   390                                     [OK]
kong                                                   Open-source Microservice & API Management la…   204                 [OK]
webdevops/php-nginx                                    Nginx with PHP-FPM                              106                                     [OK]
kitematic/hello-world-nginx                            A light-weight nginx container that demonstr…   102
zabbix/zabbix-web-nginx-mysql                          Zabbix frontend based on Nginx web-server wi…   59                                      [OK]
bitnami/nginx                                          Bitnami nginx Docker Image                      54                                      [OK]
linuxserver/nginx                                      An Nginx container, brought to you by LinuxS…   37
1and1internet/ubuntu-16-nginx-php-phpmyadmin-mysql-5   ubuntu-16-nginx-php-phpmyadmin-mysql-5          36                                      [OK]
tobi312/rpi-nginx                                      NGINX on Raspberry Pi / armhf                   20                                      [OK]
nginxdemos/nginx-ingress                               NGINX Ingress Controller for Kubernetes . Th…   11
wodby/drupal-nginx                                     Nginx for Drupal container image                9                                       [OK]
blacklabelops/nginx                                    Dockerized Nginx Reverse Proxy Server.          9                                       [OK]
webdevops/nginx                                        Nginx container                                 8                                       [OK]
nginxdemos/hello                                       NGINX webserver that serves a simple page co…   7                                       [OK]
centos/nginx-18-centos7                                Platform for running nginx 1.8 or building n…   6
1science/nginx                                         Nginx Docker images that include Consul Temp…   4                                       [OK]
centos/nginx-112-centos7                               Platform for running nginx 1.12 or building …   3
pebbletech/nginx-proxy                                 nginx-proxy sets up a container running ngin…   2                                       [OK]
toccoag/openshift-nginx                                Nginx reverse proxy for Nice running on same…   1                                       [OK]
travix/nginx                                           NGinx reverse proxy                             1                                       [OK]
ansibleplaybookbundle/nginx-apb                        An APB to deploy NGINX                          0                                       [OK]
mailu/nginx                                            Mailu nginx frontend                            0                                       [OK]
```


