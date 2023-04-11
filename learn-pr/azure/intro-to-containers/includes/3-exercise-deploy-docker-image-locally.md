A good starting point for building and running your own Docker images is to take an existing image from Docker Hub and run it locally on your computer.

As a proof-of-concept for the company's applications, you decide to try running a sample image from Docker Hub. The image you've selected implements a basic .NET Core ASP.NET web app. Once you've established a process for deploying a Docker image, you'll be able to run one of your company's own web apps using Docker.

In this exercise, you'll pull an image from Docker Hub and run it. You'll examine the local state of Docker to help understand the elements that are deployed. Finally, you'll remove the container and image from your computer.

> [!IMPORTANT]
> This exercise takes place on your computer, not in Azure. You need a local installation of Docker to proceed with the exercise. Download: https://hub.docker.com/editions/community/docker-ce-desktop-windows/

## Pull and run a sample application from Docker Hub

1. Start Docker on your computer.

1. Open a command prompt window on your local computer.

1. Enter the following code to pull the **ASP.NET Sample** app image from the Docker Hub registry. This image contains a sample web app developed by Microsoft, and is based on the default ASP.NET template available in Visual Studio.

    ```bash
    docker pull mcr.microsoft.com/dotnet/samples:aspnetapp
    ```

1. Enter the following code to verify that the image has been stored locally.

    ```bash
    docker image ls
    ```

    You should see a repository named *mcr.microsoft.com/dotnet/samples* with a tag of *aspnetapp*.

1. Enter the following code to start the sample app. The *-d* flag is to run it as a background, non-interactive app. The *-p* flag is to map port 80 in the container that's created to port 8080 locally. This setting is intended to avoid conflicts with any web apps already running on your computer. The command will respond with a lengthy hexadecimal identifier for the instance.

    ```bash
    docker run -d -p 8080:80 mcr.microsoft.com/dotnet/samples:aspnetapp
    ```

1. Open a web browser and enter the URL for the sample web app: `http://localhost:8080`. You should see a page that looks like the following screenshot:

    :::image type="content" source="../media/3-sample-web-app.png" alt-text="Screenshot of the sample web app running in a browser." loc-scope="other"::: <!--no-loc -->

## Examine the container in the local Docker registry

1. At the command prompt, run the following command to view the running containers in the local registry.

   ```bash
   docker ps
   ```

   The output should look similar to the following:

   ```console
   CONTAINER ID   IMAGE                                             COMMAND                  CREATED          STATUS          PORTS                  NAMES
   96c851831ade   mcr.microsoft.com/dotnet/samples:aspnetapp   "dotnet aspnetapp.dll"   22 minutes ago   Up 22 minutes   0.0.0.0:8080->80/tcp   eager_montalcini
   ```

   The **COMMAND** field shows the container started by running the command *dotnet aspnetapp.dll*. This command invokes the .NET Core runtime to start the code in the aspnetapp.dll (the code for the sample web app). The *PORTS* field indicates that port 80 in the image was mapped to port 8080 on your computer. The *STATUS* field shows the application is still running. Make a note of the container's *NAME*.

1. Run the following command to stop the Docker container, replacing the placeholder `<NAME>` with the output name from the previous command.

    ```bash
    docker container stop <NAME>
    ```

1. Run the following command to verify that the container is no longer running. The *-a* flag indicates that the command shows the status of all containers, not just the containers that are running. The output should show the STATUS of the container as *Exited*.

    ```bash
    docker ps -a
    ```

1. In your web browser, refresh the page for the sample web app (http://localhost:8080/). It should fail with a *Connection Refused* error.

## Remove the container and image from the local registry

1. Although the container has stopped, it's still loaded and can be restarted. Run the following command in the command prompt window to remove it, replacing `<NAME>` placeholder with the name of your container.

    ```bash
    docker container rm <NAME>
    ```

1. Verify that the container has been removed by running the following command. The command should no longer list the container.

    ```bash
    docker ps -a
    ```

1. List the images currently available on your computer. The output should show the samples repository.

    ```bash
    docker image ls
    ```

1. Remove the image from the registry.

    ```bash
    docker image rm mcr.microsoft.com/dotnet/samples:aspnetapp
    ```

1. The output should list numerous items have been untagged and deleted. Run the following command to list the images again and verify that the image for the *microsoft/dotnet-samples* web app has disappeared.

    ```bash
    docker image ls
    ```
