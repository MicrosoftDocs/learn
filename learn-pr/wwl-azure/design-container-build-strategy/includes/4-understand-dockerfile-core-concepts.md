Dockerfiles are text-based instruction files that define how to build container images. They contain a series of commands that Docker executes sequentially to create layered images.

Example Dockerfile structure:

```
FROM ubuntu
LABEL maintainer="johndoe@contoso.com"
ADD appsetup /
RUN /bin/bash -c 'source $HOME/.bashrc; \
echo $HOME'
CMD ["echo", "Hello World from within the container"]
```

## Key Dockerfile Instructions

**FROM** - Specifies the base image for the new container image. Most images inherit from existing base images; use `FROM scratch` for base images without parents.

**LABEL** - Adds metadata to images, including maintainer information. This instruction replaced the deprecated MAINTAINER command.

**ADD** - Copies files, directories, or URLs from the build context into the image filesystem. Can extract compressed archives automatically.

**RUN** - Executes commands during image build time to install packages, create directories, or configure the environment. Use backslashes for multi-line commands:

```
RUN /bin/bash -c 'source $HOME/.bashrc; echo $HOME'

```

**CMD** - Defines the default command executed when starting a container from the image. Unlike RUN commands that execute during build time, CMD executes at container runtime.

For more information, you can see:

[Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
