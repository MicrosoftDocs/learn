
Dockerfiles are text files that contain the commands needed by **docker build** to assemble an image.

Here's an example of a basic Dockerfile:

```
FROM ubuntu
LABEL maintainer="johndoe@contoso.com"
ADD appsetup /
RUN /bin/bash -c 'source $HOME/.bashrc; \
echo $HOME'
CMD ["echo", "Hello World from within the container"]
```

The first line refers to the parent image based on which this new image will be based.

Generally, all images will be based on another existing image. In this case, the Ubuntu image would be retrieved from either a local cache or from DockerHub.

An image that doesn't have a parent is called a **base** image. In that rare case, the FROM line can be omitted, or **FROM scratch** can be used instead.

The second line indicates the email address of the person who maintains this file. Previously, there was a MAINTAINER command, but that has been deprecated and replaced by a label.

The third line adds a file to the root folder of the image. It can also add an executable.

The fourth and fifth lines are part of a RUN command. Note the use of the backslash to continue the fourth line onto the fifth line for readability. It's equivalent to having written it instead:

```
RUN /bin/bash -c 'source $HOME/.bashrc; echo $HOME'

```

The RUN command is run when the docker build creates the image. It's used to configure items within the image.

By comparison, the last line represents a command that will be executed when a new container is created from the image; it's run after container creation.

For more information, you can see:

[Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
