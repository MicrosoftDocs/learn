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

You then specify that the `python` container image is used, and that the process to run inside of the container is `bash`.

```bash
docker run --name python-demo -ti python bash
```

One the command has been run, your terminal session should switch to the containers psudo-terminal. This can be seen by the terminal prompt, which should have changed to something similar to the following.

```bash
root@d8ccada9c61e:/#
```

At this point, you are working inside of the container. You shoudl find that working inside of a container is very much like working inside of a virtual or physical system. For instance you can list, create, and delete files, install software, and make configuration changes. For this simple example, a Python based hello world script is created. This can be done with the following command.

```bash
echo 'print("Hello World!")' > hello.py
```

To test the script while still in the container runs the following.

```
python hello.py
```

This will produce the following output.

```bash
Hello World!
```

Satisfied that the script functions as expected, exit out of the container by typing `exit`.

```bash
exit
```

Back in the terminal of your local system, use the `docker ps` command to list all running containers.

```bash
docker ps
```

Notice that nothing is running. When you typed `exit` in the running container, the bash process completed, which then stopped the container. This is the expected behavior and is ok.

```bash
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

Use `docker ps` again, however add the `-a` argument. This command will return a list of all container regardless if they are running.

```bash
docker ps -a
```

Notice that a container with the name `python-demo` has a status of `Exited`. This is the stopped instance of the container you created.

```bash
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
cf6ac8e06fd9        python              "bash"              27 seconds ago      Exited (0) 12 seconds ago                       python-demo
```

To create a new container image from this container, use the `docker commit` command. The following example instructs `docker commit` to create an image named `python-custom` from the `python-demo` containers.

```bash
docker commit python-demo python-custom
```

Once complete, you should see output similar to the following.

```bash
sha256:91a0cf9aa9857bebcd7ebec3418970f97f043e31987fd4a257c8ac8c8418dc38
```

Now run `docker images` to see a list of container images.

```bash
docker images
```

You should now see the custom python image.

```bash
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
python-custom       latest              1f231e7127a1        6 seconds ago       922MB
python              latest              638817465c7d        24 hours ago        922MB
alpine              latest              11cd0b38bc3c        2 weeks ago         4.41MB
```

Run a contianer from the new image. You also need to specify what command / process to run inside of the container. With this example, run `python hello.py`.


```bash
docker run python-custom python hello.py
```

The container will start nand output the hello world message. The python process has then completed and the container stops.

```bash
Hello World!
```

## Automated image creation

Create a file named `Dockerfile` and enter the following text.

```bash
FROM python

WORKDIR ./app

RUN echo 'print("Hello World!")' > hello.py

CMD python hello.py
```

Use the `docker build` command to create a new container image using the instructions specified in the Dockerfile.

```bash
docker build -t python-dockerfile .
```

You should see output similar to the following.

```bash
Sending build context to Docker daemon  2.048kB
Step 1/4 : FROM python
 ---> 638817465c7d
Step 2/4 : WORKDIR ./app
 ---> Running in 990d17e86466
Removing intermediate container 990d17e86466
 ---> 59a074a092cc
Step 3/4 : RUN echo 'print("Hello World!")' > hello.py
 ---> Running in aed707c53bc5
Removing intermediate container aed707c53bc5
 ---> d7f55a9d0e85
Step 4/4 : CMD python hello.py
 ---> Running in e87ec55a8d36
Removing intermediate container e87ec55a8d36
 ---> 98c39b91770f
Successfully built 98c39b91770f
Successfully tagged python-dockerfile:latest
```

Use the `docker images` command to return a list of container images.


```bash
docker images
```

You should now see the custom image.

```bash
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
python-dockerfile   latest              98c39b91770f        About a minute ago   922MB
python              latest              638817465c7d        26 hours ago         922MB
alpine              latest              11cd0b38bc3c        2 weeks ago          4.41MB
```

Use the `docker run` command to run a container from the custom image. Notice here that no arguments have been provided to the `docker run` command. Unlike when manually creating a container image, a Dockerfile allows you to include a command to be run when the container starts. In this case, the specified command is `python hello.py`, which causes the container to run the Python script, which outputs `Hello World!`. Also notice, once the command has run, the container stops.


```bash
docker run python-dockerfile
```

After running the command, you should see the container output.

```bash
Hello World!
```
