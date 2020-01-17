# Prepare for session 1: "Choose the best hosting option and deploy the app"

In session one, we move the VanArsdel Ltd real estate application into an Azure App Service. Before we get there, we want to make sure the app is running locally.

In this session, you will:

- Choose an appropriate hosting model
- Deploy the application to Azure

> [!NOTE]
> Mac users: You cannot run the app locally and have it display data. Although our application is based on .NET Core and can be deployed to Linux and macOS, it is using "Microsoft SQL Server Express Local DB" which is not available for macOS. In our second session, we migrate the database into the cloud. When this is done you will be able to follow along with Visual Studio Code or Visual Studio 2019 for macOS. If you run the initial solution on macOS, it will show you a warning about a missing database.

## App information

The app is built with ASP.NET Core MVC. Please follow the instructions below to execute the applications locally on your development machine.

## Prepare your environment

- Fork our repository if not already done ([fork now](https://github.com/MicrosoftDocs/mslearn-live-migrating-to-the-cloud/fork))
- Clone the repository to your PC
- Open the starter solution under "src/1 - Starter" (you can use Visual Studio 2019 or Visual Studio Code)
- Build and run the app
- It will open the browser and show an error about a missing database migration
- Click the button shown to start the migration (alternatively, you can run `dotnet ef database` update on the command line)
- When the migration has completed, refresh the page

## Resources

- Architecture Reference Center: [docs.microsoft.com/en-us/azure/architecture/](https://docs.microsoft.com/en-us/azure/architecture/)
- Learn Live Sandbox: [aka.ms/learnlivesandbox](https://aka.ms/learnlivesandbox)
- Azure Naming Conventions: [docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions](https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions)