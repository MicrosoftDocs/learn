# TechStack.md

This document provides a comprehensive technical overview of the ContosoShop E-commerce Support Portal's architecture, frameworks, and design decisions. Understanding the tech stack is essential for working with the application and extending it with new features (such as integrating the GitHub Copilot SDK).

## 1. Solution Architecture Overview

The ContosoShop application follows a modern **full-stack .NET architecture** with a clear separation between client and server:

- **Frontend (Client)**: Built with **Blazor WebAssembly (WASM)**, a single-page application (SPA) framework that runs .NET code in the browser via WebAssembly. This allows for rich, interactive UI experiences using C# and Razor syntax, all without requiring JavaScript (though interop is available if needed).

- **Backend (Server)**: Built with **ASP.NET Core**, providing a RESTful Web API. The server handles business logic, data access, email services, and any backend operations. It exposes HTTP endpoints that the Blazor client calls to fetch or manipulate data.

- **Data Layer**: Uses **Entity Framework Core (EF Core)** for object-relational mapping (ORM) against a **SQLite database**. SQLite is used for local development simplicity (no separate database server needed), but the architecture supports switching to SQL Server or Azure SQL for production.

This architecture is often described as a "Blazor hosted" model during development (the ASP.NET Core server hosts the Blazor WASM static files) or as separate deployments in production (Blazor WASM on a CDN and the API on an app service).

### High-Level Interaction Flow

1. User accesses the application in a browser.
2. Blazor WASM app is downloaded and runs in the browser.
3. User navigates to pages (e.g., Orders or Contact Support).
4. Blazor components call backend APIs (e.g., GET /api/orders) using HttpClient.
5. ASP.NET Core API processes the request, interacts with the database via EF Core, and returns data as JSON.
6. Blazor components render the data in the UI.
7. For actions (e.g., initiating a return), the client sends a POST request; the server updates the database and potentially triggers side effects (like sending an email).

## 2. Frameworks and Libraries

### .NET 8

- **Target Framework**: .NET 8 (Long-Term Support release, as of late 2023).
- **Why .NET 8?** It provides the latest performance improvements, C# 12 language features, and first-class support for Blazor and ASP.NET Core. It's the recommended version for new projects.
- **Benefits**: Built-in support for HTTP/3, improved JSON serialization (System.Text.Json), enhanced minimal APIs, and better cloud-native capabilities.

### Blazor WebAssembly (Client)

- **Purpose**: Provides the interactive UI. The entire client-side application logic runs in the browser via WebAssembly, which is a binary instruction format that allows near-native performance.
- **Component Model**: Uses Razor components (.razor files) that combine HTML markup with C# code. Components are similar to React or Vue components—they encapsulate UI logic and can be nested and reused.
- **Data Binding**: Two-way data binding using `@bind` syntax (e.g., `<input @bind="model.Value" />`).
- **Routing**: Blazor's built-in router handles navigation (e.g., `@page "/orders/{id:int}"`).
- **State Management**: For this application, state is primarily managed within individual components or via scoped services (like OrderService on the client). For more complex apps, patterns like Fluxor (Redux-like) could be used.
- **HttpClient**: Blazor WASM includes a pre-configured HttpClient that can make AJAX calls to the server. It's registered via dependency injection and uses the base URI automatically.

### ASP.NET Core (Server)

- **Purpose**: Hosts the Web API and serves as the backend for all business logic and data operations.
- **Minimal API vs Controllers**: We use **Controllers** (`[ApiController]` attribute) for API endpoints, providing a structured MVC-style approach. This is suitable for applications with multiple endpoints and business logic layers.
- **Middleware Pipeline**: Configured in Program.cs (or Startup.cs in older templates). The pipeline includes:
  - CORS (Cross-Origin Resource Sharing) for allowing the Blazor client to call the API (if hosted on different origins).
  - Routing (`app.MapControllers()` to route requests to controller actions).
  - Static file serving (`app.UseBlazorFrameworkFiles()` to serve the Blazor WASM client files).
  - Exception handling and logging middleware.
- **Dependency Injection (DI)**: Services (like IEmailService, OrderService, DbContext) are registered in the DI container (via `builder.Services.AddScoped<>()` or similar). Controllers receive these dependencies via constructor injection.

### Entity Framework Core (EF Core)

- **Purpose**: ORM for data access. Maps C# classes (Order, OrderItem entities) to database tables. Simplifies CRUD operations and migrations.
- **Provider**: Uses **Microsoft.EntityFrameworkCore.Sqlite** for local SQLite database. The connection string typically points to a local .db file (e.g., `Data Source=ContosoShop.db`).
- **DbContext**: `ContosoContext` is the main context class. It:
  - Defines `DbSet<Order>` and `DbSet<OrderItem>` representing tables.
  - Includes configuration in `OnModelCreating` for entity relationships (e.g., Order has many OrderItems).
  - Provides a method to query and save data.
- **Migrations**: EF Core migrations manage schema changes. You run `dotnet ef migrations add InitialCreate` to create migration files, and `dotnet ef database update` to apply them to the database. Migrations are code-based, allowing version control and repeatable deployments.
- **Seeding**: Sample data (orders) is seeded in `OnModelCreating` or a separate initializer. This ensures that on first run, the database has realistic data for testing and demos.

### SQLite Database

- **Why SQLite?** It's a file-based database that requires no separate server process. Perfect for local development and demos. The database is stored as a single file (e.g., `ContosoShop.db`), making it easy to reset or copy.
- **Limitations**: SQLite lacks some advanced features of SQL Server (like full-text search, stored procedures, and certain concurrency features), but for a demo with a few orders, it's more than sufficient.
- **Migration to Cloud**: For production, you would switch to Azure SQL Database. The code change is minimal:
  - Replace `UseSqlite(connectionString)` with `UseSqlServer(connectionString)`.
  - Update the connection string in appsettings.json to point to Azure SQL.
  - Run migrations against the cloud database.

## 3. Backend Components in Detail

### Controllers

- **OrderController (or OrdersController)**: Handles HTTP requests related to orders.
  - `GET /api/orders` → Returns a list of orders for the user.
  - `GET /api/orders/{id}` → Returns details of a specific order (including items).
  - `POST /api/orders/{id}/return` → Initiates a return for a delivered order.
  - Uses dependency injection to access `ContosoContext` and `IEmailService`.
  - Implements error handling and validation (e.g., checking if order exists before returning).

### Services

- **OrderService**: Encapsulates order-related business logic. Could include methods like:
  - `GetOrders()` → Queries database for all orders.
  - `GetOrderById(int id)` → Retrieves a single order with its items.
  - `ProcessReturn(int orderId)` → Changes order status to Returned, logs the return date, and triggers email.
  - This separation allows for cleaner controllers (they just call service methods) and testability (services can be unit tested independently).

- **IEmailService / EmailService**: Interface for sending emails. In development, it's a stub that logs to console. For production, you'd implement it with:
  - **SendGrid**: Cloud email service. Requires an API key and uses HTTP requests to send emails.
  - **SMTP**: Use `System.Net.Mail.SmtpClient` to send via an SMTP server.
  - **Azure Communication Services**: Microsoft's email/SMS service for Azure.

### Data Models (Shared)

- **Shared Project**: Contains data transfer objects (DTOs) or entity models used by both client and server. For example, the `Order` class:
  ```csharp
  public class Order
  {
      public int Id { get; set; }
      public int UserId { get; set; } // Or string if using GUIDs
      public DateTime OrderDate { get; set; }
      public OrderStatus Status { get; set; } // enum: Processing, Shipped, Delivered, Returned
      public decimal TotalAmount { get; set; }
      public DateTime? DeliveryDate { get; set; }
      public DateTime? ShipDate { get; set; }
      public DateTime? ReturnDate { get; set; }
      public string? UserEmail { get; set; }
      public List<OrderItem> Items { get; set; } = new();
  }

  public class OrderItem
  {
      public int Id { get; set; }
      public int OrderId { get; set; }
      public string ProductName { get; set; } = string.Empty;
      public int Quantity { get; set; }
      public decimal Price { get; set; }
  }

  public enum OrderStatus
  {
      Processing,
      Shipped,
      Delivered,
      Returned
  }
  ```
- Shared models ensure consistency between frontend and backend (same classes deserialized from JSON).

### Database Context (ContosoContext)

- **Purpose**: Manages database connections and entity sets.
- **Configuration**: 
  - It's configured in Program.cs (Server) with something like:
    ```csharp
    builder.Services.AddDbContext<ContosoContext>(options =>
        options.UseSqlite(builder.Configuration.GetConnectionString("DefaultConnection")));
    ```
  - In a cloud scenario, DefaultConnection can be changed to a SQL Server connection string and the code simply switched to `UseSqlServer`.
- **Migrations**: We created a migration for the initial model (and any subsequent changes). In development, we ensure the SQLite DB has this schema. The solution includes the migration files under Server/Migrations/ for reference. For example, you might see `20231201010101_InitialCreate.cs` which EF generated, showing the Orders and OrderItems tables creation.
- **Order Entity**: Fields like Id (int, primary key), UserId (could be int or GUID), OrderDate, Status (we use an OrderStatus enum in code but store as string or int in DB), TotalAmount (decimal). We might also have a DeliveryDate. The relationship: `public List<OrderItem> Items` to collect items. Using EF's [ForeignKey] or by naming convention, OrderItem has OrderId.
- **OrderItem Entity**: Fields: Id (pk), OrderId (foreign key), ProductName (string), Quantity (int), Price (decimal). For simplicity, we denormalize product data into OrderItem (no separate Product table in this small demo).
- **Data Seeder**: The data seeder (perhaps in Context.OnModelCreating or separate initializer) creates a few orders for our demo user. For example, Order #1001 (Id=1001) with two items (Product "Wireless Mouse", qty 1, price $25; "Keyboard", qty 1, price $34.99, making total $59.99), status Delivered, delivered date last week. Order #1002, one item ("HDMI Cable", $15), status Shipped. Etc. This gives us realistic content to test the agent on.
- **File-Based Storage**: Because SQLite is file-based, when running the app, the DB file (ContosoShop.db) gets created in Server/App_Data/ or similar folder. This file persists data between runs unless deleted. The lab instructions ensure this is set up so that you don't need to manually do any seeding — it's automatic on first run.

### HTTP API Security and CORS

- In Program.cs of Server, we enable the controllers (`app.MapControllers()`) and probably allow any origin for simplicity in development (or specifically allow the Blazor client origin if running on a different port). Since in dev we likely use the hosted model, the Blazor files are served by the same server on a subpath, so CORS issues are minimal. For cloud, we would set up proper CORS or use the same domain.

## 4. Frontend: Key Components and Interaction with Backend

### State Management

- Blazor WASM allows us to use in-memory state for the current user's data. However, since our data is small, we fetch fresh data when needed rather than store it in a complex client-side state. For example:
  - The Orders page, on initialization (`OnInitializedAsync`), calls `OrderService.GetOrdersAsync()` which GETs from the server and populates a local list `orders`. Blazor then renders the list. This retrieval happens each time the user navigates to Orders page (which ensures updated data if something changed). We could optimize by caching the result in a state container if needed, but not necessary for a few orders.
  - The Order Details page likely receives an order ID via query parameter or route parameter (`@page "/orders/{id:int}"`). It then calls `OrderService.GetOrderDetailsAsync(id)` to retrieve the full order (or the Orders page might have passed the order in memory to avoid second call — but to keep it simple we do an API call here too, which would hit the DB again).
  - After calling a return, we might refresh the data or at least update the bound objects to reflect new status. For instance, our `OrderService.ReturnOrderAsync(id)` calls the POST API. If it succeeds, we can either manually set the current order's status to Returned in the UI model (so the UI updates immediately) and perhaps even update the Orders list cached in memory (if we have it) so the list page is consistent. In our base flow, we simply navigate the user back to the orders list after a return and call the API again to load updated data — a simple and consistent approach.

### OrderService (Client side)

- An Angular or React app would use a service or hook for API calls; similarly, in Blazor we created an `OrderService` class. This is registered via `builder.Services.AddScoped<IOrderService, OrderService>()` in Program.cs (Client). It wraps HttpClient calls:
  - `GetOrdersAsync()` does `return await http.GetFromJsonAsync<List<Order>>("api/orders");`. Blazor's HttpClient is configured with base URI, so "api/orders" goes to the backend. The Shared models ensure the JSON maps to the Order class properly.
  - `GetOrderDetailsAsync(id)` might call `http.GetFromJsonAsync<Order>($"api/orders/{id}")`.
  - `ReturnOrderAsync(id)` would likely do `var response = await http.PostAsync($"api/orders/{id}/return", null); response.EnsureSuccessStatusCode();`. We didn't need to send a body, as the act of hitting the endpoint is enough. Alternatively, we could use PostAsJsonAsync if we needed to send data with the request (like a return reason). In base, not required.
  - The service abstracts away those calls so our Razor components don't have to write boilerplate. In the component, we just do `await OrderService.ReturnOrderAsync(order.Id)` and handle exceptions if any.

### Razor Components

- **Orders.razor**: Loops through orders and displays each in a table or list. Each item has a link (perhaps using `<NavLink href="@($"orders/{order.Id}")">View Details</NavLink>`). It might also show a status badge (we can color-code statuses, e.g., Delivered = green badge, Shipped = blue, etc., using a bit of conditional logic with Bootstrap classes).
- **OrderDetails.razor**: Displays details of a single order. Possibly uses a child component for item list (or just loops inside). If `order.Status == OrderStatus.Delivered`, show the Return button. Also, maybe show a delivery address or any other info if we had it (we assume minimal details here). If the Return button is clicked, it calls a method that invokes the service to do the return.
- We might include a JavaScript confirm dialog (as shown) to confirm the action. In the base app, error handling sets `errorMessage`, and the component's view checks if `errorMessage` is not null to display an alert.
- **Support.razor**: Currently might have something like a placeholder message or maybe a simple form with a Question field and response area. The lab will significantly change this by wiring it up to the Copilot SDK agent (so SubmitQuery will call an API that gets AI response instead). The base UI is ready to display a `responseMessage` from the agent. We intentionally keep the design minimal here so it's easy to integrate the dynamic behavior in the lab.

### User Experience Considerations

- We used Bootstrap for quick styling. The nav menu on the left (in NavMenu.razor) has links to "Orders" and "Contact Support". The main layout provides a header maybe saying "ContosoShop Support Portal" for context. The app is responsive (Bootstrap ensures the layout works on mobile; e.g., the nav collapses to a hamburger). This is not a major focus, but it means the support agent UI we add will also be mobile-friendly out of the box.

## 5. Design for Local vs Cloud Environments

We've emphasized that the app is *cloud-ready*. Here are specific ways it's designed for easy migration:

### Separation of Concerns & Loose Coupling

- The clear split between front-end and back-end means we could scale them independently. In Azure, you could host the API on an App Service and the Blazor WASM on a CDN or Static Web App; they'd communicate over HTTPS. This separation follows the backend-for-frontend pattern and allows using Azure's best services for each (e.g., Azure CDN for static content, Azure App Service for the API logic). During local dev we combine them for convenience (the hosted Blazor model serving the static files), which is configurable via a flag. For instance, in Program.cs we might use `app.UseBlazorFrameworkFiles()` and `app.MapFallbackToFile("index.html")` on the server to serve the client app. This is active in dev; in a separate deployment, we could turn that off and deploy separately.

### Configuration and Secrets

- No secrets are needed for local run (we're not calling external APIs in base). But we have the infrastructure to introduce secrets via user secrets or environment variables if needed. For example, if using SendGrid, we'd store the API key in Azure's config and load it via `Configuration["SendGridApiKey"]`. The code might be ready to consume such config even if in base it's not set. In appsettings.json we keep sensitive things out (or in dev json only if not sensitive like a local filepath). This means pushing to Azure is just a matter of setting configurations appropriately.

### Database Migration Path

- Using SQLite in development is convenient, but for an Azure production, one would typically use Azure SQL. The EF Core migrations and model are fully compatible with SQL Server. The team could do one of:
  - Use `dotnet ef database update` pointing to the Azure SQL connection to create schema.
  - Or use EF Core's ability to generate a differential script and run that on Azure SQL.
  - Also consider using Azure DevOps or GitHub Actions pipeline to apply migrations during deployment (ensuring zero downtime strategies, etc.). The code doesn't need changes - it's devops process.
  - The codebase includes some conditional logic if needed (like maybe a compiler directive or config flag to choose UseSqlServer vs UseSqlite). More simply, we might rely on the connection string format to determine provider; but in practice, we can let the lab environment always use SQLite. Documenting the path: "Switching to Azure SQL involves adding the Microsoft.EntityFrameworkCore.SqlServer NuGet package and changing one line in Program.cs (UseSqlServer). Then update the DefaultConnection string to the Azure SQL connection string in production settings. That's it." This highlights ease of migration.

### Scalability and Performance

- For a local lab, performance is a non-issue. But the use of EF Core (with appropriate indexing if needed) and streaming of data in Web API (we're returning all orders at once, which is fine for small numbers; pagination could be added for very large histories), and the efficient static content loading from Blazor's published output all mean the app can handle typical load. On Azure, enabling response compression, and using Azure Front Door or CDN for static files could vastly improve global performance. None of these require code changes, just configuration and Azure toggles. For instance, ASP.NET Core by default has gzip compression (if enabled in config) for API responses; we can ensure it's on in production.

### Azure Integration Points

We considered possible Azure services:

- **Azure App Service**: Ideal for hosting the ASP.NET Core API (and even the Blazor client). We ensure the app writes logs to console (which App Service can capture) and doesn't write to disk (except the SQLite DB which is in the content folder; on App Service that's fine but in production we'd use Azure SQL to avoid file write).
- **Azure Static Web Apps**: If splitting client, this could host the Blazor WASM and provide an auto CI/CD from a GitHub repo. Meanwhile, an Azure Function or App Service could host the API. We'd then configure CORS accordingly. The code would not change except possibly the base addresses.
- **Azure Monitor/Application Insights**: We can add Application Insights SDK to monitor server performance and track requests, which is straightforward with one line addition in Program (`builder.Services.AddApplicationInsightsTelemetry()`). We have not included it in base (to avoid extra setup for lab) but it's an easy add that doesn't alter our logic.
- **Azure OpenAI**: When scaling the AI agent portion, instead of relying on GitHub's Copilot service (which is convenient for development), a production system might use Azure OpenAI Service with models like GPT-4. The Copilot SDK integration we'll do is abstracted enough that we could replace the behind-the-scenes calls with Azure OpenAI's API plus our own orchestration logic (though that would require building something similar to Copilot's planner). Since this is cutting-edge, we mention it as a path if an enterprise has concerns about data or customization — they can swap to their controlled AI endpoint.

In summary, the tech stack is contemporary and robust: **C# full-stack** (Blazor + ASP.NET Core) with **EF Core** for ORM, targeting **.NET 8** for best performance and features. All these choices align directly with Microsoft's cloud offerings, making the journey from a local SQLite/VS Code experience to an Azure-deployed, scalable solution very smooth. We've enforced clean separation and used interfaces/DI for things like email and data access to ensure that improving or changing implementations (like switching to Azure services) is just a matter of configuration or adding new classes, not rewriting core features.

With the base application's architecture understood, we can proceed to the **Lab Exercise** where you'll integrate the GitHub Copilot SDK into this app. The lab will guide you through adding an AI agent on the backend (within the ASP.NET Core server) and creating a user interface in the Blazor client to converse with it, leveraging the structures described here (like OrderService and EmailService) so the agent can do useful work (check orders, process returns) securely and effectively.
