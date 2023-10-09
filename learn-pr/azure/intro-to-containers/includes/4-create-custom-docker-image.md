Docker Hub is an excellent source of images to get you started building your own containerized apps. You can download an image that provides the basic functionality you require, then *layer* your own application on top of it to create a new custom image. You can automate the steps for this process by writing a Dockerfile.

In the online clothing store scenario, the company decided that Docker is the way forward. The next step is to determine the best way to containerize your web applications. The company plans to build many of the apps using ASP.NET Core. You've noticed that Docker Hub contains a base image that includes this framework. As a proof of concept, you want to start with this base image and add the code for one of the web apps to create a new custom image. You also want this process to be easily repeatable, so it can be automated whenever you release a new version of the web app.

In this unit, you'll learn how to create a custom Docker image and how you can automate the process by writing a Dockerfile.

## Create a custom image with a Dockerfile

To create a Docker image containing your application, you'll typically begin by identifying a *base image* to which you add files and configuration information. The process of identifying a suitable base image usually starts with an image search on Docker Hub. You want an image that already contains an application framework and all the utilities and tools of a Linux distribution, like Ubuntu or Alpine. For example, if you have an ASP.NET Core application that you want to package into a container, Microsoft publishes an image called `mcr.microsoft.com/dotnet/core/aspnet` that already contains the ASP.NET Core runtime.

You can customize an image by starting a container with the base image and making changes to it. Changes usually involve activities such as copying files into the container from the local filesystem and running various tools and utilities to compile code. When you're finished, you use the `docker commit` command to save the changes to a new image.

Manually completing the above process is time-consuming and error-prone. You could script it with a script language like Bash, but Docker provides a more effective way of automating image creation via a *Dockerfile*.

A Dockerfile is a plain-text file containing all the commands needed to build an image. Dockerfiles are written in a minimal scripting language designed for building and configuring images. They document the operations required to build an image, starting with a base image.

The following example shows a Dockerfile that builds a .NET Core 2.2 application and packages it into a new image.

```Dockerfile
FROM mcr.microsoft.com/dotnet/core/sdk:2.2
WORKDIR /app
COPY myapp_code .
RUN dotnet build -c Release -o /rel
EXPOSE 80
WORKDIR /rel
ENTRYPOINT ["dotnet", "myapp.dll"]
```

In this file, the following operations take place:

| Command | Action |
| --- | --- |
| FROM | Downloads the specified image and creates a new container based on this image. |
| WORKDIR | Sets the current working directory in the container, used by the subsequent commands. |
| COPY | Copies files from the host computer to the container. The first argument (`myapp_code`) is a file or folder on the host computer. The second argument (`.`) specifies the name of the file or folder to act as the destination in the container. In this case, the destination is the current working directory (`/app`). |
| RUN | Executes a command in the container. Arguments to the RUN command are command-line commands. |
| EXPOSE | Creates a configuration in the new image that specifies which ports to open when the container runs. If the container is running a web app, it's common to EXPOSE port 80. |
| ENTRYPOINT | Specifies the operation the container should run when it starts. In this example, it runs the newly built app. You specify the command you want to run and each of its arguments as a string array. |

By convention, applications meant to be packaged as Docker images typically have a Dockerfile located in the root of their source code, and it's almost always named `Dockerfile`.

The `docker build` command creates a new image by running a Dockerfile. This command's syntax has several parameters:

- The *-f* flag indicates the name of the Dockerfile to use.
- The *-t* flag specifies the name of the image to be created; in this example, *myapp:v1*. 
- The final parameter, *.*, provides the *build context* for the source files for the **COPY** command: the set of files on the host computer needed during the build process.

```bash
docker build -t myapp:v1 .
```

Behind the scenes, the `docker build` command creates a container, runs commands in it, then commits the changes to a new image.
