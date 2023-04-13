A Dockerfile contains the steps for building a custom Docker image.

You decide to deploy one of your organization's web apps using Docker. You select a simple web app that implements a web API for a hotel reservations website. The web API exposes HTTP POST and GET operations that create and retrieve customers' bookings.

> [!NOTE]
> In this version of the web app, the bookings aren't actually persisted, and queries return dummy data.

In this exercise, you'll create a Dockerfile for an app that doesn't have one. Then, you'll build the image and run it locally.

## Create a Dockerfile for the web app

1. If it's not already running, start Docker on your computer.

1. In a command prompt window on your local computer, run the following command to download the source code for the web app.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-hotel-reservation-system.git
    ```

1. Enter the following command to open the `src` directory.

    ```bash
    cd mslearn-hotel-reservation-system/src
    ```

1. In the `src` directory, enter the following commands to create a new file named `Dockerfile` and open it in Notepad:

    ```bash
    copy NUL Dockerfile
    notepad Dockerfile
    ```

    > [!NOTE]
    > By default the notepad command opens a text file. Make sure that you save it as file type *All Files* with no file extension. To verify, open the src folder in File Explorer, select View > Show> File name extensions. If necessary, rename the file and remove `.txt` from the file name.

1. Add the following code to the Dockerfile:

    ```Dockerfile
    FROM mcr.microsoft.com/dotnet/core/sdk:2.2
    WORKDIR /src
    COPY ["/HotelReservationSystem/HotelReservationSystem.csproj", "HotelReservationSystem/"]
    COPY ["/HotelReservationSystemTypes/HotelReservationSystemTypes.csproj", "HotelReservationSystemTypes/"]
    RUN dotnet restore "HotelReservationSystem/HotelReservationSystem.csproj"
    ```

    This code has commands to fetch an image containing the .NET Core Framework SDK. The project files for the web app (`HotelReservationSystem.csproj`) and the library project (`HotelReservationSystemTypes.csproj`) are copied to the /src folder in the container. The `dotnet restore` command downloads the dependencies required by these projects from NuGet.

1. Append the following code to the bottom of the Dockerfile:

    ```Dockerfile
    COPY . .
    WORKDIR "/src/HotelReservationSystem"
    RUN dotnet build "HotelReservationSystem.csproj" -c Release -o /app
    ```

    These commands copy the source code for the web app to the container, then run the dotnet build command to build the app. The resulting DLLs are written to the /app folder in the container.

1. Append the following command at the bottom of the Dockerfile.

    ```Dockerfile
    RUN dotnet publish "HotelReservationSystem.csproj" -c Release -o /app
    ```

    The `dotnet publish` command copies the executables for the website to a new folder and removes any interim files. The files in this folder can then be deployed to a website.

1. Append the following commands to the bottom of the Dockerfile.

    ```Dockerfile
    EXPOSE 80
    WORKDIR /app
    ENTRYPOINT ["dotnet", "HotelReservationSystem.dll"]
    ```

    The first command opens port 80 in the container. The second command moves to the `/app` folder containing the published version of the web app. The final command specifies that when the container runs it should execute the command `dotnet HotelReservationSystem.dll`. This library contains the compiled code for the web app.

1. Save the file and close your text editor. Make sure that you save it as file type *All Files* with no file extension.

## Build and deploy the image using the Dockerfile

1. At the command prompt, run the following command to build the image for the sample app using the Dockerfile. Don't forget the `.` at the end of the command. This command builds the image and stores it locally. The image is given the name `reservationsystem`. Verify that the image is built successfully. A warning about file and directory permissions will be displayed when the process completes. You can ignore these warnings for the purposes of this exercise. The image might take a moment to build.

    ```bash
    docker build -t reservationsystem .
    ```

1. Run the following command to verify that the image has been created and stored in the local registry:

    ```bash
    docker image list
    ```

    The image will have the name `reservationsystem`. You'll also have an image named *microsoft/dotnet*:

    ```console
    REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
    reservationsystem   latest              d2501f0f2ced        About a minute ago   1.76GB
    ```

## Test the web app

1. Enter the following code to run a container using the `reservationsystem` image. Docker will return a lengthy string of hex digits. The container runs in the background without any UI. Port 80 in the container is mapped to port 8080 on the host machine. The container is named `reservations`.

    ```bash
    docker run -p 8080:80 -d --name reservations reservationsystem
    ```

1. Start a web browser and navigate to `http://localhost:8080/api/reservations/1`. You should see a JSON object containing the data for reservation number 1 similar to the following output:

    :::image type="content" source="../media/5-hotel-web-app.png" alt-text="Screenshot of the hotel reservations system web app running in a browser.":::

    Replace the "1" at the end of the localhost URL with a different reservation number, like 2 or 20, to view the corresponding reservation details.

1. Run the following command to view the container's status:

    ```bash
    docker ps -a
    ```

    The output lists the following for all available containers:

    - CONTAINER ID
    - IMAGE
    - COMMAND
    - CREATED time
    - STATUS
    - PORTS
    - NAMES

    Verify that the container's `STATUS` is *Up*.

    ```console
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
    07b0d1de4db7        reservationsystem   "dotnet HotelReserva…"   5 minutes ago       Up 5 minutes        0.0.0.0:8080->80/tcp   reservations
    ```

1. Enter the following command to stop the *reservations* container:

    ```bash
    docker container stop reservations
    ```

1. Delete the *reservations* container from the local registry.

    ```bash
    docker rm reservations
    ```

1. Leave the *reservationsystem* in the local registry. You'll use this image in the next exercise.

Congratulations! You've created an image for your web app, and you've run it using a Docker container.
