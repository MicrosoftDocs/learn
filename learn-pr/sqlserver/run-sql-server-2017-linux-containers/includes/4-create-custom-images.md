Containers are created from images, which are templates for a virtual environment.

You've chosen to use containers to deploy a SQL Server 2019 image to the test environments for your photo sharing application. You want the same sample database, which contains test data, to be deployed for each integration testing cycle. Now you're going to plan the image that will deploy the container.

In this unit, you'll learn how to create customized images in Docker by using a **Dockerfile**.

## What is a Dockerfile?

An image is a template for a container. In Docker, the contents of the image are fixed by a text file named Dockerfile. In this file, there are one or more lines of text. Each line is an instruction that Docker follows as it builds a container from the image.

## Common Dockerfile commands

A Dockerfile is a text file. Each line of the file is either a comment or an instruction.

Comments start with a `#` and usually contain text that describes the image or an instruction to other administrators or developers.

Instructions consist of the name of the command and its arguments. Although Dockerfile syntax isn't case-sensitive, the name is usually in uppercase to make it easier to distinguish it from the arguments.

Every Dockerfile must have a `FROM` instruction that determines the base image. It can be an image in your local registry or from any registry that Docker is configured to access.

Other common instructions in Dockerfile include:

- `COPY`. This instruction copies a file from the source you specify into the container at the destination you specify.
- `CMD`. This instruction provides the default executable for the container. There can only be one `CMD` instruction in each Dockerfile.
- `ENV`. This instruction sets a value for an environment variable in the container.
- `EXPOSE`. This instruction informs Docker that the container listens on a specific TCP or UDP port.
- `RUN`. This instruction executes a command in a new layer on the current image and commits the results to the new image.
- `WORKDIR`. This instruction sets the working directory within the container for `CMD`, `RUN`, and any other instruction that executes commands.

## How to write a Dockerfile for SQL Server containers

To create an image that includes a functional database server, start by basing the image on one that includes SQL Server 2019. For example, the **mcr.microsoft.com/mssql/server:2019-latest** image in the Microsoft registry.

Then, use the CMD instruction to specify the **sqlservr** executable as the default for the image.

You might also want to copy a database backup file into the image. The file contains the default data that you want in the deployed database.

The following code is an example Dockerfile with those instructions:

```Dockerfile
FROM microsoft/mssql-server-linux:latest
COPY containers/mssql-custom-image-example/PhotoSharing.bak /var/opt/mssql/data/PhotoSharing.bak
CMD ["/opt/mssql/bin/sqlservr"]
```

## How to build an image from a Dockerfile

To build a container from a Dockerfile, use the **docker build** command. You must have elevated privileges to execute this command so, on Linux, use it with the **sudo** tool. Use the `-t` option to fix a name for the new container:

```bash
sudo docker build . -t photo-sharing-sql-server
```