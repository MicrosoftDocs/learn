A Dockerfile is a script that contains a series of instructions that are used to build a Docker image. Dockerfiles typically include the following information:

* The base or parent image we use to create the new image
* Commands to update the base OS and install other software
* Build artifacts to include, such as a developed application
* Services to expose, such a storage and network configuration
* Command to run when the container is launched

## Create a Dockerfile

The first step in creating a Dockerfile is choosing a base image that serves as the foundation for your application. For example, if you're building a .NET application, you might choose a Microsoft .NET image as your base.

```dockerfile
# Use the .NET 6 runtime as a base image
FROM mcr.microsoft.com/dotnet/runtime:6.0

# Set the working directory to /app
WORKDIR /app

# Copy the contents of the published app to the container's /app directory
COPY bin/Release/net6.0/publish/ .

# Expose port 80 to the outside world
EXPOSE 80

# Set the command to run when the container starts
CMD ["dotnet", "MyApp.dll"]
```

Let's go through each line to see what it does:

* **`FROM mcr.microsoft.com/dotnet/runtime:6.0`**: This command sets the base image to the .NET 6 runtime, which is needed to run .NET 6 apps.
* **`WORKDIR /app`**: Sets the working directory to `/app`, which is where app files are copied.
* **`COPY bin/Release/net6.0/publish/ .`**: Copies the contents of the published app to the container's `/app` directory. We assume that the .NET 6 app is built and published to the `bin/Release/net6.0/publish` directory.
* **`EXPOSE 80`**: Exposes port 80, which is the default HTTP port, to the outside world. Change this line accordingly if your app listens on a different port. 
* **`CMD ["dotnet", "MyApp.dll"]`**: The command to run when the container starts. In this case, we're running the dotnet command with the name of our app's DLL file (`MyApp.dll`). Change this line to match your apps name and entry point.

We're not going to cover the Dockerfile file specification. Visit the [Dockerfile reference](https://docs.docker.com/engine/reference/builder/) for more information. Each of these steps creates a cached container image as we build the final container image. These temporary images are layered on top of the previous and presented as single image once all steps complete.

## Resources

* Docker run reference (CLI)
    * [https://docs.docker.com/engine/reference/run/](https://docs.docker.com/engine/reference/run/)
* Docker build reference
    * [https://docs.docker.com/engine/reference/commandline/build/](https://docs.docker.com/engine/reference/commandline/build/)
