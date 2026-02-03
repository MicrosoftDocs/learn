# ContosoShop E-commerce Support Portal (Local Edition)

**Project Name:** ContosoShop E-commerce Support Portal (Local Edition)

## Overview

ContosoShop E-commerce Support Portal is a sample web application that simulates an online store's customer support interface. It allows a user to view their orders, check order status, and initiate returns/refunds through a self-service portal. The project is designed as a production-ready application that runs locally (using a lightweight SQLite database and local email logging) while being architecturally ready to migrate to cloud services (such as Azure SQL Database, Azure App Service, and Azure email services). In a companion lab exercise, we will enhance this application by integrating an AI-powered support agent using the GitHub Copilot SDK, enabling intelligent automated assistance for customer service scenarios.

## Key Features

- **Order History & Details:** Users can view a list of their past orders and see detailed information for each order (order items, status, dates).

- **Order Status Tracking:** The application shows the current status of each order (e.g., *Processing*, *Shipped*, *Delivered*, *Returned*). This data is stored in a local SQLite database for easy setup and can be migrated to Azure SQL for production.

- **Initiate Returns/Refunds:** For delivered orders, users can initiate a return. In the base application, this updates the order status to *Returned* and (simulated) triggers a refund process. The logic is contained in the backend API and designed to be expanded or connected to real payment systems later.

- **Contact Support (to be enhanced):** The application includes a "Contact Support" page. Initially, this page provides guidance on how to reach customer service (and may allow submitting a support request form). In the lab, this page will be transformed into an interactive AI chat interface where the GitHub Copilot SDK agent will handle user queries about orders.

- **Blazor WebAssembly Frontend:** A rich client-side UI built with Blazor WebAssembly provides a responsive single-page application experience. The UI is implemented with production best practices (e.g., responsive layout, error handling, loading indicators) and communicates with the backend via HTTP API calls.

- **ASP.NET Core Web API Backend:** A robust backend powered by ASP.NET Core Web API (.NET 8) handles all business logic and data access. It exposes RESTful endpoints for retrieving orders, updating order status, and other operations. This separation ensures the frontend and backend are decoupled and can scale independently (or even be replaced by other client apps).

- **Local Development Friendly:** The app uses EF Core with a local SQLite database file for easy setup – no external dependencies needed to run locally. The database is seeded with sample data (e.g., a demo user account and a few orders) so the app works out-of-the-box. For emailing (e.g., sending a confirmation when a refund is processed), the base app simply logs the email content to the console, avoiding external email service requirements during development.

- **Cloud-Ready Architecture:** Although running locally, the app's architecture aligns with cloud deployment practices. Configuration is managed via appsettings.json (with override support for environment-specific settings), making it easy to switch connection strings or service URLs for cloud environments. The application is divided into projects (Client and Server, plus shared models) similar to the Blazor WASM Hosted model, facilitating deployment to Azure App Service (for the API) and Azure Static Web Apps or Azure Storage (for the Blazor client). The EF Core data access layer can point to Azure SQL by changing a connection string, and the email service can be swapped with an actual email provider (like SendGrid) without changing the core logic.

## Running the App Locally

1. **Prerequisites:** .NET 8 SDK or later is required (the project targets .NET 8). You'll also need a recent version of Node.js if using any build steps for front-end (Blazor WASM doesn't require Node for standard use). Visual Studio 2022 or VS Code with the C# extension is recommended for editing and running the project.

2. **Clone the Repository:** Retrieve the project source code (the exact steps depend on how the lab provides the code – typically by downloading or cloning a GitHub repository).

3. **Database Setup:** The project includes a SQLite database file (App_Data/ContosoShop.db for example) with seed data. EF Core Migrations have been run and the database is up-to-date. There's no additional setup needed; the database will be copied on build if not present.

4. **Configure (optional):** By default, the app uses the included SQLite DB and defaults to development settings. No modification is necessary for the lab scenario. If you want to test using a different database (e.g., SQL Server), update the connection string in appsettings.json and ensure the database is reachable.

5. **Build and Run:** Open the solution in Visual Studio and press **F5** (or use dotnet run on the API project and a static file server for the Blazor client, if running manually). The backend API will start (e.g., on https://localhost:5001) and the Blazor client will be served (e.g., on https://localhost:5002 or via the same server depending on configuration). By default, the solution is set up to run both projects together.

6. **Using the App:** In your browser, navigate to the provided URL (usually https://localhost:5002 for the Blazor app). You should see the ContosoShop portal homepage. From there, you can click "Orders" to view sample orders. Clicking an order will show its details. If an order is delivered and eligible for return, a "Return Item" button will be visible. The Contact Support page is also accessible (it currently shows contact info or a placeholder – which the lab will turn into an AI chat).

7. **Observe Logs:** The backend API will output console logs for key events. For example, if you initiate a return, the backend might log a message that a refund email was "sent" (simulated). These logs appear in the output window of VS or the console where dotnet run was executed.

## Next Steps – Integrating AI Agent

This base application sets the stage for integrating an AI-powered support agent. In the following lab exercises, you will add an AI agent to the Contact Support page using the GitHub Copilot SDK. The agent will be capable of understanding user questions (e.g., "Where is my order?" or "I want to return my last order") and will use the application's backend capabilities (via new API tools you'll implement) to perform actions like checking order status, initiating a return, and confirming outcomes to the user – all through a conversational interface. The modular design of ContosoShop's backend (with clearly defined services for orders and returns) will make it straightforward to expose these operations to the AI agent in a controlled manner.

## Cloud Deployment Path

While this lab runs everything locally for simplicity, the app is prepared for cloud deployment. To deploy to Azure, you could:

- Host the ASP.NET Core Web API on **Azure App Service** (or Azure Container Apps). Simply publish the Server project, and switch the EF Core provider to Azure SQL by updating the connection string to point to an Azure SQL Database. The same EF Core migrations apply – you can run them on Azure or generate SQL scripts to set up the schema in the cloud.

- Host the Blazor WASM client on **Azure Static Web Apps** or as part of the App Service. In a production scenario, you might combine the deployment so that the API and Blazor UI are served from the same domain for simplicity. The project structure supports this (the Blazor app can be published into the API's wwwroot if desired for a single deployment unit, or deployed separately as a static site).

- Integrate **Azure Services** as needed: e.g., swap out the email logger with an **Azure SendGrid** or **Microsoft Graph Mail** integration to send real emails, plug in **Application Insights** for monitoring and diagnostics, and consider using **Azure OpenAI Service** to host the AI model behind the Copilot SDK (if you want full control of the AI in production rather than relying on the GitHub Copilot service).

This README provides a high-level orientation. For more details on what the app does and how it's built, see the **AppFeatures** and **TechStack** documentation below. Happy coding!
