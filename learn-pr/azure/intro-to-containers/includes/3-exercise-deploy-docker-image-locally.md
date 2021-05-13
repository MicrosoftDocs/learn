A good starting point for building and running your own Docker images is to take an existing image from Docker Hub and run it locally on your computer.

As a proof-of-concept for the company's applications, you decide to try running a sample image from Docker Hub. The image you have selected implements a basic .NET Core ASP.NET web app. Once you've established a process for deploying a Docker image, you'll be able to run one of your company's own web apps using Docker.

In this exercise, you'll pull an image from Docker Hub and run it. You'll examine the local state of Docker to help understand the elements that are deployed. Finally, you'll remove the container and image from your computer.

> [!IMPORTANT]
> This exercise takes place on your computer, not in Azure. You need a local installation of Docker to proceed with the exercise. Download: https://hub.docker.com/editions/community/docker-ce-desktop-windows/

## Pull and run a sample application from Docker Hub

1. Open a command prompt window on your local computer.

2. Pull the **ASP.NET Sample** app image from the Docker Hub registry. This image contains a sample web app developed by Microsoft. It's based on the default ASP.NET template available in Visual Studio.

    ```bash
    docker pull mcr.microsoft.com/dotnet/core/samples:aspnetapp
    ```

3. Verify that the image has been stored locally.

    ```bash
    docker image list
    ```

    You should see a repository named *mcr.microsoft.com/dotnet/core/samples* with a tag of *aspnetapp*.

4. Start the sample app. Specify the *-d* flag to run it as a background, non-interactive app. Use the *-p* flag to map port 80 in the container that is created to port 8080 locally, to avoid conflicts with any web apps already running on your computer. The command will respond with a lengthy hexadecimal identifier for the instance.

    ```bash
    docker run -d -p 8080:80 mcr.microsoft.com/dotnet/core/samples:aspnetapp
    ```

5. Open a web browser, and navigate to the page for the sample web app at `http://localhost:8080`. The page looks like the following screenshot.

    :::image type="content" source="../media/3-sample-web-app.png" alt-text="Screenshot of the sample web app running in a browser." loc-scope="other"::: <!--no-loc -->

## Examine the container in the local Docker registry

1. At the command prompt, view the running containers in the local registry.

   ```bash
   docker ps
   ```

   The output should look similar to this.

   ```console
   CONTAINER ID        IMAGE                                COMMAND                  CREATED             STATUS              PORTS                  NAMES
   bffd59ae5c22        mcr.microsoft.com/dotnet/core/samples:aspnetapp   "dotnet aspnetapp.dll"   12 seconds ago      Up 11 seconds       0.0.0.0:8080->80/tcp   competent_hoover
   ```

   The **COMMAND** field shows the container started by running the command *dotnet aspnetapp.dll*. This command invokes the .NET Core runtime to start the code in the aspnetapp.dll (the code for the sample web app). The *PORTS* field indicates port 80 in the image was mapped to port 8080 on your computer. The *STATUS* field shows the application is still running. Make a note of the container's *NAME*.

1. Stop the Docker container. Specify the container name for the web app in the following command, in place of `<NAME>`.

    ```bash
    docker container stop <NAME>
    ```

1. Verify that the container is no longer running. Run the following command to show the status of the container as *Exited*. The *-a* flag indicates that the command shows the status of all containers, not just those that are still running.

    ```bash
    docker ps -a
    ```

1. Return to the web browser, and refresh the page for the sample web app. It should fail with a *Connection Refused* error.

## Remove the container and image from the local registry

1. Although the container has stopped, it's still loaded and can be restarted. Remove it by running the following command. As before, replace `<NAME>` with the name of your container.

    ```bash
    docker container rm <NAME>
    ```

1. Verify that the container has been removed by running the following command. The command should no longer list the container.

    ```bash
    docker ps -a
    ```

1. List the images currently available on your computer.

    ```bash
    docker image list
    ```

1. Remove the image from the registry.

    ```bash
    docker image rm mcr.microsoft.com/dotnet/core/samples:aspnetapp
    ```

1. List the images again to verify that the image for the *microsoft/dotnet-samples* web app has disappeared.

    ```bash
    docker image list
    ```
