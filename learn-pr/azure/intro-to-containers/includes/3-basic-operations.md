Now that you have a functioning container development environment, let's look at some common ways to run, list, and delete containers.

Here, you'll learn how to:

* Run basic containers.
* Download container images.
* Delete containers and their associated images.

## What's a container image?

A container _image_ includes the base operating system and any additional processes, applications, and configurations. Much like a virtual machine, a _container_ is a running instance of an image.

## Connect to your Linux VM

If you disconnected from the SSH session you created in the last part, you will need to log in. Here's a refresher.

1. Get the IP address.

    ```azurecli
    az vm show \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name DockerVM \
      --show-details \
      --query [publicIps] \
      --o tsv
    ```

1. SSH into the VM. Replace **ip-address** with yours.

    ```bash
    ssh azureuser@ip-address
    ```

## Create and run a basic container

Here you'll run a container that's based on Alpine Linux. Alpine Linux is popular because of its size &mdash; container images can be as small as 5 MB.

Run this `docker run` command to create a container based on Alpine Linux.

```bash
docker run alpine echo "Hello World"
```

You see output similar to this:

```output
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
8e3ba11ec2a2: Pull complete
Digest: sha256:7043076348bf5040220df6ad703798fd8593a0918d06d3ce30c6c93be117e430
Status: Downloaded newer image for alpine:latest
Hello World
```

The `docker run` command creates a container, runs the provided command, and then destroys the container.

Here, Docker downloads the [alpine](https://hub.docker.com/_/alpine?azure-portal=true) image from Docker Hub, starts the container, and then prints "Hello World" to the console.

In this case, the `echo` command runs briefly and then exits. In the previous part, Nginx runs in the foreground and therefore keeps your container alive until you stop the container or stop the Nginx service.

## Get container images

Container images are stored in a container image registry. In the previous example, Docker pulls the **alpine** image from Docker Hub, Docker's public container registry.

Run `docker images` to see a list of images that have been downloaded to your system.

```bash
docker images
```

You see two images &mdash; **alpine** and **nginx**.

```output
REPOSITORY          TAG                 IMAGE ID            CREATEDSIZE
alpine              latest              196d12cf6ab1        8 days ago4.41MB
nginx               latest              06144b287844        2 weeks ago109MB
```

To search for a container image, use the `docker search` command. For example, run the following to list all container images that include `nginx` in their names.

```bash
docker search nginx --limit 5
```

The `--limit` argument in this example restricts the search operation to the first five results.

You see something similar to this.

```output
NAME                                     DESCRIPTION         STARS               OFFICIAL            AUTOMATED
nginx                                    Official build of Nginx.         9672                [OK]
jwilder/nginx-proxy                      Automated Nginx reverse proxy for docker con…   1415                                    [OK]
richarvey/nginx-php-fpm                  Container running Nginx + PHP-FPM capable of…   615                                     [OK]
jrcs/letsencrypt-nginx-proxy-companion   LetsEncrypt container to use with nginx as p…   411                                     [OK]
bitnami/nginx                            Bitnami nginx Docker Image         58                                      [OK]
```

Commands like `docker run` pull down the image for you if you don't have it locally. But it's common to download an image before you use it. This ensures you have the latest version.

To do so, you use the `docker pull` command. Run the following to pull the latest **nginx** image from Docker Hub.

```bash
docker pull nginx
```

This example shows that you have the latest version of the **nginx** image.

```output
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:24a0c4b4a4c0eb97a1aabb8e29f18e917d05abfe1b7a7c07857230879ce7d3d3
Status: Image is up to date for nginx:latest
```

## Run and list a container

In the previous part, you used the `docker run` command to bring up Nginx. Let's run that command a second time and take a closer look into what's happening.

1. From your SSH connection, run this command to bring up a container running Nginx.

    ```bash
    docker run -d -p 8080:80 nginx
    ```

    * The `-d` argument specifies that the container will run in a detached mode, which means the container runs in the background. If the Nginx process stops or crashes, the container itself is also stopped.
    * The `-p` argument specifies that network traffic arriving to port 8080 on the container host, your Linux VM in this case, is forwarded to port 80 on the container. You used this argument in the previous part to access the web server from your browser.
    * The `nginx` argument is the name of the container image to run.

    Later, you can explore the complete list of `docker run` options in the [docker run reference](https://docs.docker.com/engine/reference/run?azure-portal=true).

    The `docker run` command displays a unique identifier for the container. For example:

    ```output
    9d7327e3121200cfe2dccb627544db1442a4e02ed3151f30681db4e538ef9466
    ```

1. Run `docker ps` to list the running containers on your system.

    ```bash
    docker ps
    ```

    You see the Nginx container you just started. Notice that the container has both an ID and a name. You can use either one of these values to manage the container. Note the container ID. You'll use it later.

    ```output
    CONTAINER ID        IMAGE               COMMAND                  CREATED     STATUS              PORTS                  NAMES
    9d7327e31212        nginx               "nginx -g 'daemon of…"   4 minutes ago     Up 4 minutes        0.0.0.0:8080->80/tcp   compassionate_allen
    ```

1. As you did previously, you can navigate to your VM's IP address in a browser to see the running web server. Don't forget to specify port 8080 as part of the URL.

    ![The web site running in a browser](../media/2-nginx-browser.png)

## Delete containers

You use the `docker rm` command to delete a container. You can specify the container by its name or ID.

1. Try running `docker rm` to delete your container running Nginx. Run `docker ps` if you need to find the ID. Here's an example.

    ```bash
    docker rm 9d7327e31212
    ```

    You see that the container can't be removed because it's in the running state.

    ```output
    Error response from daemon: You cannot remove a running container 9d7327e3121200cfe2dccb627544db1442a4e02ed3151f30681db4e538ef9466. Stop the container before attempting removal or force remove
    ```

1. Run `docker stop` to stop the container. Here's an example.

    ```bash
    docker stop 9d7327e31212
    ```
    
1. Run `docker ps` to verify that the container is no longer running.

    ```bash
    docker ps
    ```

    You see this.

    ```output
    CONTAINER ID        IMAGE               COMMAND             CREATEDSTATUS              PORTS               NAMES
    ```

1. Run `docker ps` a second time, but this time provide th `-a` flag. This lists all containers, even those that are stopped.

    ```bash
    docker ps -a
    ```

    You see output similar to this:

    ```output
    CONTAINER ID        IMAGE               COMMAND                  CREATED     STATUS                          PORTS               NAMES
    9d7327e31212        nginx               "nginx -g 'daemon of…"   11 minutes ago     Exited (0) About a minute ago                       compassionate_allen
    df8aeea0320f        alpine              "echo 'Hello World'"     About an hour ago   Exited (0) About an hour ago                        objective_payne
    3a7efb75c288        nginx               "nginx -g 'daemon of…"   About an hour ago   Exited (0) About an hour ago                        nginx
    ```

    The output includes the Nginx container you just stopped as well as the other containers you ran prior.

1. Run `docker rm` a second time. Replace the ID shown with one of yours.

    ```bash
    docker rm 9d7327e31212
    ```

1. Run the following `docker rm` command to delete _all_ active containers.

    ```bash
    docker rm $(docker ps -aq)
    ```

1. Run `docker ps -a` again and you see that there are no active containers running or stopped.

    ```bash
    docker ps -a
    ```

## Delete a container image

You use the `docker rmi` command to delete a container image.

You can only delete an image if no container started from that image, running or stopped, is active. However, the `-f` argument forces the removal of all associated containers and will then remove the container image.

1. Run `docker rmi nginx` to remove the Nginx image from your Linux VM.

    ```bash
    docker rmi nginx
    ```

    The output you see resembles this:

    ```output
    Untagged: nginx:latest
    Untagged: nginx@sha256:24a0c4b4a4c0eb97a1aabb8e29f18e917d05abfe1b7a7c07857230879ce7d3d3
    Deleted: sha256:06144b2878448774e55577ae7d66b5f43a87c2e44322b3884e4e6c70d070b262
    Deleted: sha256:824a442ee3c96744d75be3737a22cc6a47aebad1b30be67f3c2f8f29cb0aa879
    Deleted: sha256:8e3d1e9e4945f930c93c30617512998437f6edafd86676770d29b1581f2520bb
    Deleted: sha256:8b15606a9e3e430cb7ba739fde2fbb3734a19f8a59a825ffa877f9be49059817
    ```

1. Run `docker images` to list the images on your VM. 

    ```bash
    docker images
    ```

    You see the **alpine** image.

    ```output
    REPOSITORY          TAG                 IMAGE ID            CREATEDSIZE
    alpine              latest              196d12cf6ab1        8 days ago4.41MB
    ```

1. Run the following `docker rmi` command to delete _all_ images from your VM.

    ```bash
    docker rmi $(docker images -q)
    ```

1. Run `docker images` again and you see that there are no images on the VM.

    ```bash
    docker images
    ```
