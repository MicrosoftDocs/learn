# Creating custom container images

In the last unit, you worked with pre-created container images to perform some basic Docker operations. In this unit you will create custom container images, push these images to a public container registry, and run containers from these images.

Container images can be created by hand or using what is called a Dockerfile to automate the process. The preferred method is using a Dockerfile, however this unit will demonstrate both. The intention is that having an understanding of the manual process will help you better understand what is occourign when using a Dockerfile for automaton.

## Manual image creation

When manually creating a container image, the following actions are taken:

- Start an instance of a container
- Establish a terminal session with the container
- Modify the container by installing software and making configuration changes
- Capturing the container into a new image using the `docker capture` command

In this first example, you start an instance of a container running NGINX, modify the default HTML page, and then capture the new image.

First, run a container from the NGINX image. This command looks a bit different than the commands run in the previous unit. Because you want to establish a terminal session with the running container, the `-t` and `-i` arguments are provided. Together these arguments instruct Docker to allocate a pseudo terminal that will remain in a runnings state. Or in other words `-t` and `-i` create am omteractve session with the running containers.

You then specify that the `nginx` container image is used, and that the process to run inside of the container is `bash`.

```bash
docker run -t -i nginx bash
```

One the command has been run, your terminal session should switch to the containers psudo-terminal. This can be seen by the terminal prompt, which should have changed to something similar to the following.

```bash
root@d8ccada9c61e:/#
```

```bash
<update the default page>
```

```bash
docker ls -a
```

```bash
docker capture <container> nginx-custom
```

```bash
docker images
```

```bash
docker run -d -p 8080 nginx-custom
```

## Automated image creation

Create a file named `Dockerfile` and enter the following text.

```bash
FROM nginx

RUN

ETC..
```

```bash
docker build -t nginx-custom-dockerfile
```

```bash
docker images
```

```bash
docker run -d -p 8080 nginx-custom-dockerfile
```