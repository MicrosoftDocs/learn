The first step of this project is to walk through the existing starter application, ensure it builds successfully, and then run the application.

There are a few requirements in this exercise:

- Open the **CodeTour** within the application and walk through the entire tour
- Successfully build the application
- Run the application using the **Hot Reload** feature of .NET

After you complete this exercise, you'll have a general understanding of the project and its components.

## Walk through a tour of the code

This application uses [CodeTour](https://github.com/microsoft/codetour), a Visual Studio Code extension to walk you through a guided tour of the codebase. Here, you walk through the codebase and orient yourself to the application that you're working on through this project.

> [!IMPORTANT]
> This code tour is only available in the `start` branch of the repository. If you don't see the tour commands or files, please validate that you are using the correct branch.

1. Open the **Command Palette**, search for the **CodeTour** commands, and then select **CodeTour: Start Tour**.

    :::image type="content" source="../media/start-codetour-command-palette.png" alt-text="Screenshot of the Command Palette option to start the primary guided tour of the codebase.":::

1. Review the overview of the guided tour.

1. The guided tour of the codebase walks you through the following components of the application.

    - The `Message` and `Session` types in the `/Models` path
    - The Bicep template and various properties of the resources it deployed
    - The `CosmosDbService` and `OpenAiService` classes you modify as part of this project

1. Finally, review the final step of the guided tour and finish the tour.

## Build and run the application

Now it's time to make sure the application works as expected. In this step, build the application to verify that there's no issues before you start and run the application using the stubbed out implementations of the service methods.

1. Open a new terminal.

1. Start the application with hot reloads enabled using [`dotnet watch`](/dotnet/core/tools/dotnet-watch).

    ```bash
    dotnet watch run --non-interactive
    ```

1. Visual Studio Code launches an in-tool simple browser with the web application running. In the web application, create a new chat session with at least one message. The AI assistant responds with the prebaked string values that you observed during the guided tour of the project's code.

    :::image type="content" source="../media/starter-application.png" lightbox="../media/starter-application.png" alt-text="Screenshot of the application running without a connection to Azure OpenAI or Azure Cosmos DB.":::

1. Close the terminal.

    > [!IMPORTANT]
    > Closing the terminal releases the port so you can rebuild and run this application again later in this project. If you forget to close the terminal, you may run into issues with the application's port already being in use when debugging later in the project.
