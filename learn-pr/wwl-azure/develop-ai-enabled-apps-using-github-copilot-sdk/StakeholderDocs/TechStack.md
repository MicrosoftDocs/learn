# ContosoShop E-commerce Support Portal – Technical Architecture and Stack

This document provides a technical overview of how the application's features (described in AppFeatures.md) are implemented. We outline the architecture, frameworks, and key components, and highlight how the design facilitates local development as well as future cloud migration.

## 1. Solution Architecture Overview

The project follows a **Blazor WebAssembly Hosted architecture**, which means it is split into a client and a server:

- **ContosoShop.Client (Blazor WebAssembly):** This is the front-end running in the browser. It's a single-page application (SPA) written in C# and HTML (Razor components). It contains the UI logic, forms, and calls the backend API via HttpClient. It was created as a standalone Blazor WASM project and later configured to work with the API. (In our solution, it's a separate project that can be deployed independently of the server if needed.)

- **ContosoShop.Server (ASP.NET Core Web API):** This is the back-end REST API built with ASP.NET Core 8 (running on .NET 8). It exposes endpoints under /api/ that the client calls. It also hosts the Blazor client's static files when run in a combined mode (for simplicity in local dev, we actually serve the Blazor app from the same domain via the ASP.NET project, using the ASP.NET Core Hosted template setup). The server contains all business logic – like querying the database or updating an order – and enforces rules (e.g., "don't return an order that isn't yours" in a real auth scenario).

- **ContosoShop.Shared (class library, if used):** We have a small library for shared code, primarily to share model definitions between Client and Server. For example, the Order and OrderItem classes are defined in Shared, so both the server (when producing JSON) and the client (when decoding JSON) use the same definitions, reducing duplication and errors. We also share any validation or enums this way. (If this were a combined solution template, the Shared project is optional, but our solution does include it to illustrate good practice for code sharing).

### Project Structure:

- **Client/Pages** – Razor components for pages (e.g., Orders.razor, OrderDetails.razor, Support.razor).
- **Client/Services** – Service classes for API calls (e.g., OrderService that calls the API endpoints, encapsulating HttpClient use).
- **Client/Shared** – Shared UI components (e.g., a MainLayout, NavMenu, and maybe smaller components like an OrderCard).
- **Server/Controllers** – Web API controllers (e.g., OrdersController, possibly SupportController). Each controller corresponds to a set of endpoints for a resource. Our OrdersController handles /api/orders routes. We might not need a separate SupportController yet, but will add an endpoint for the agent in the lab (perhaps under a new SupportAgentController).
- **Server/Data** – EF Core DbContext and Configuration. Contains ContosoContext (our EF Core DbContext) and the entity classes (Order, OrderItem, etc., if not in Shared). Also likely contains code for seeding initial data into the SQLite DB on first run.
- **Server/Services** – Classes that encapsulate business logic, used by controllers. For example, an OrderService in the backend might contain methods like GetOrdersForUser(userId), ProcessReturn(orderId), etc. The controller can call these, which in turn call the DbContext and other services like EmailService. This layering isn't strictly needed in a small app but demonstrates how to separate concerns (especially if some logic is complex or reused).
- **Server/Utilities** – Utility classes (e.g., an EmailService interface and an implementation EmailServiceDev that logs emails). Also, configuration classes or helpers for mapping data.
- **Shared/Models** – Definitions for data models (Order, OrderItem, possibly an OrderStatus enum).

This structured approach makes it easier to maintain and test the app. For instance, one could unit-test OrderService methods independently of the controllers.

## 2. Frameworks and Libraries

- **.NET 8:** The entire solution is on .NET 8. Using .NET 8 ensures we have the latest C# features and performance improvements, and it aligns with the timelines of modern Azure services and the GitHub Copilot SDK (which expects a recent .NET runtime). .NET 8 is required to run this project, so ensure your environment is updated accordingly.

- **Blazor WebAssembly:** Our client is a Blazor WASM app. It runs the UI and client logic in the browser on WebAssembly, using Mono/WASM to execute C#. This means the user gets a rich interactive experience without constant page reloads. The Blazor app has been configured to call the backend for data. In Program.cs of the client, we register an HttpClient with the base address pointing to the server's URL so that HttpClient calls automatically target the correct domain (during dev, likely https://localhost:5001 for the API). We use dependency injection to provide services (like OrderService) to our components. The UI is built with Razor (which mixes HTML and C#). We've opted for a clean, Bootstrap-based styling (the default Blazor template's Bootstrap is used, giving us a responsive layout out of the box). No JavaScript frameworks are needed; however, we could interop with JS for things like copy-to-clipboard or other niceties if required.

- **ASP.NET Core Web API:** The server uses ASP.NET Core's minimal API/Controller approach. We created controllers with [ApiController] and routing attributes, returning strongly-typed models. For example, OrdersController.GetOrders() returns IEnumerable<Order> which ASP.NET Core automatically serializes to JSON. We rely on the default JSON (System.Text.Json) which is efficient and symmetric with Blazor's deserialization. CORS is configured to allow the Blazor client to call (when both run on same origin in dev, it's not an issue, but if separated, we allowed the client origin or used the fact it's hosted to avoid CORS issues).

- **Entity Framework Core (EF Core):** This is used for data access. The ContosoContext DbContext is configured with SQLite provider in development. We used code-first migrations to set up the database schema. The context has a DbSet<Order> and DbSet<OrderItem>, and possibly DbSet<User> if we had a user table (in our simplified case, user info might be minimal, but we can assume an in-memory user or a simple Users table with one entry). We run migrations on app startup (the app either ensures the SQLite DB exists or uses EnsureCreated in development). Entities have relationships (Order has a collection of OrderItems). EF Core tracking is used so when we update an Order's status and call SaveChanges(), it commits to the SQLite file.

  - **SQLite:** The connection string for SQLite is in appsettings.json (e.g., "ConnectionStrings": { "DefaultConnection": "Data Source=App_Data/ContosoShop.db" }). SQLite is chosen for local run because it requires no separate server installation and is lightweight. It is fully supported by EF Core. We included the .db file in the project so that it deploys if needed, and configured it to copy to output. In development mode, EF migrations are not automatically applied (we either ran them and checked in the DB, or we call context.Database.EnsureCreated() to auto-create tables for simplicity).

  - If we were to scale up or go to production, we would switch to Azure SQL. EF Core makes this easy: we'd change the UseSqlite to UseSqlServer with an Azure SQL connection string. Our code (repos, services) does not need to change. Migration to Azure SQL would involve deploying the migrations or generating a script—EF Core can handle differences in SQL dialects. Also, the app's repository pattern (if present) and service logic are database-agnostic beyond the configuration.

- **Logging and Configuration:** We use built-in .NET Logging (Microsoft.Extensions.Logging). In development, the default console logger is enabled so we see logs in the output. Configuration is done via the standard ASP.NET Core mechanism (appsettings files and environment variables). For example, the connection string and maybe a flag like "UseDevelopmentEmailService: true" are in appsettings.Development.json. In production (Azure), we'd likely override those with environment-specific values (Azure App Service application settings can directly override configuration keys). This means the app is prepared to accept config from Azure, such as a real SMTP server endpoint or an Azure Storage connection if we had one.

## 3. Backend: Key Components and Classes

**OrderController / OrderService:** This pair (or just controller, depending on how we structured it) is responsible for all order-related endpoints. Key methods include:

- **GET /api/orders** – calls something like _orderService.GetOrdersForUser(userId) which returns a list from the DbContext (e.g., context.Orders.Include(o=>o.Items).Where(o => o.UserId == userId)). If not using a separate service class, the controller might directly inject ContosoContext and query it. We decided to implement an OrderService to illustrate the pattern and to encapsulate logic like seeding or business rules (e.g., filtering by user, sorting orders by date). This service is registered in DI so the controller gets it.

- **GET /api/orders/{id}** – returns a single order with items. Internally ensures the order belongs to the authenticating user (in our simplified case, we skip that or assume it's correct). Returns NotFound if not found.

- **POST /api/orders/{id}/return** – the endpoint to initiate a return (used when "Return Order" is clicked). This likely calls _orderService.ProcessReturn(orderId, userId). That method will:
  - Load the order from DB, check status and maybe date.
  - If invalid (e.g., status != Delivered), throw or return an error.
  - If valid, update the order's Status = Returned, and set a ReturnDate or similar.
  - Save changes.
  - Then call an Email service to send confirmation (we'll discuss Email service next).
  - Possibly log an audit entry or return details about the refund.
  - Return a result (maybe the updated order or a simple success response).
  - Our base implementation might actually simply return 204 NoContent on success, and the client then knows to update UI.

- The use of a service class here means we can reuse ProcessReturn logic if, for example, an AI agent or an admin console also needs to trigger a return. In fact, that's exactly what we'll do in the lab: the AI agent's "ProcessRefund" tool will essentially call the same logic that the API endpoint uses (we might directly call _orderService.ProcessReturn inside the tool implementation). This avoids duplicating refund logic in multiple places.

**EmailService (Dev):** As mentioned, we have an abstraction IEmailService with a method like SendEmail(to, subject, body). In Startup (or builder.Services setup), we register EmailServiceDev as the implementation for IEmailService. This EmailServiceDev doesn't actually send anything; it logs the email content to console or a file for debugging. For example, calling SendEmail("john@example.com", "Your refund was processed", "We have refunded $X to your card...") will result in a log entry that looks like an email. This pattern ensures that our business logic (like the OrderService) is unaware of the specifics of email sending – it just calls emailService.SendEmail(...) and trusts it works. In a cloud deployment, we could have another implementation EmailServiceSendGrid that uses SendGrid API, and swap the registration to that (likely via config or environment detection). None of the controller/service code changes when we do that – a benefit of the DI architecture.

**Database Context and Entities:** We use EF Core code-first:

- **ContosoContext : DbContext** defines DbSet<Order> Orders and DbSet<OrderItem> OrderItems. Perhaps a DbSet<User> Users if needed (in our lab, not heavily used).

- It's configured in Program.cs (Server) with something like:
  ```csharp
  builder.Services.AddDbContext<ContosoContext>(options =>
      options.UseSqlite(builder.Configuration.GetConnectionString("DefaultConnection")));
  ```

- In a cloud scenario, DefaultConnection can be changed to a SQL Server connection string and the code simply switched to UseSqlServer.

- We created a migration for the initial model (and any subsequent changes). In development, we ensure the SQLite DB has this schema. The solution includes the migration files under Server/Migrations/ for reference. For example, you might see 20231201010101_InitialCreate.cs which EF generated, showing the Orders and OrderItems tables creation.

- **Order Entity:** fields like Id (int, primary key), UserId (could be int or GUID), OrderDate, Status (we use an OrderStatus enum in code but store as string or int in DB), TotalAmount (decimal). We might also have a DeliveryDate. The relationship: public List<OrderItem> Items to collect items. Using EF's [ForeignKey] or by naming convention, OrderItem has OrderId.

- **OrderItem Entity:** fields: Id (pk), OrderId (foreign key), ProductName (string), Quantity (int), Price (decimal). For simplicity, we denormalize product data into OrderItem (no separate Product table in this small demo).

- The data seeder (perhaps in Context.OnModelCreating or separate initializer) creates a few orders for our demo user. For example, Order #1001 (Id=1001) with two items (Product "Wireless Mouse", qty 1, price $25; "Keyboard", qty 1, price $34.99, making total $59.99), status Delivered, delivered date last week. Order #1002, one item ("HDMI Cable", $15), status Shipped. Etc. This gives us realistic content to test the agent on.

- Because SQLite is file-based, when running the app, the DB file (ContosoShop.db) gets created in Server/App_Data/ or similar folder. This file persists data between runs unless deleted. The lab instructions ensure this is set up so that you don't need to manually do any seeding – it's automatic on first run.

**HTTP API security and CORS:** In Program.cs of Server, we enable the controllers (app.MapControllers()) and probably allow any origin for simplicity in development (or specifically allow the Blazor client origin if running on a different port). Since in dev we likely use the hosted model, the Blazor files are served by the same server on a subpath, so CORS issues are minimal. For cloud, we would set up proper CORS or use the same domain.

## 4. Frontend: Key Components and Interaction with Backend

**State Management:** Blazor WASM allows us to use in-memory state for the current user's data. However, since our data is small, we fetch fresh data when needed rather than store it in a complex client-side state. For example:

- The Orders page, on initialization (OnInitializedAsync), calls OrderService.GetOrdersAsync() which GETs from the server and populates a local list orders. Blazor then renders the list. This retrieval happens each time the user navigates to Orders page (which ensures updated data if something changed). We could optimize by caching the result in a state container if needed, but not necessary for a few orders.

- The Order Details page likely receives an order ID via query parameter or route parameter (@page "/orders/{id:int}"). It then calls OrderService.GetOrderDetailsAsync(id) to retrieve the full order (or the Orders page might have passed the order in memory to avoid second call – but to keep it simple we do an API call here too, which would hit the DB again).

- After calling a return, we might refresh the data or at least update the bound objects to reflect new status. For instance, our OrderService.ReturnOrderAsync(id) calls the POST API. If it succeeds, we can either manually set the current order's status to Returned in the UI model (so the UI updates immediately) and perhaps even update the Orders list cached in memory (if we have it) so the list page is consistent. In our base flow, we simply navigate the user back to the orders list after a return and call the API again to load updated data – a simple and consistent approach.

**OrderService (Client side):** An Angular or React app would use a service or hook for API calls; similarly, in Blazor we created an OrderService class. This is registered via builder.Services.AddScoped<IOrderService, OrderService>() in Program.cs (Client). It wraps HttpClient calls:

- **GetOrdersAsync()** does `return await http.GetFromJsonAsync<List<Order>>("api/orders");`. Blazor's HttpClient is configured with base URI, so "api/orders" goes to the backend. The Shared models ensure the JSON maps to the Order class properly.

- **GetOrderDetailsAsync(id)** might call `http.GetFromJsonAsync<Order>($"api/orders/{id}")`.

- **ReturnOrderAsync(id)** would likely do `var response = await http.PostAsync($"api/orders/{id}/return", null); response.EnsureSuccessStatusCode();`. We didn't need to send a body, as the act of hitting the endpoint is enough. Alternatively, we could use PostAsJsonAsync if we needed to send data with the request (like a return reason). In base, not required.

- The service abstracts away those calls so our Razor components don't have to write boilerplate. In the component, we just do `await OrderService.ReturnOrderAsync(order.Id)` and handle exceptions if any.

**Razor Components:**

- **Orders.razor:** loops through orders and displays each in a table or list. Each item has a link (perhaps using `<NavLink href="@($"orders/{order.Id}")">View Details</NavLink>`). It might also show a status badge (we can color-code statuses, e.g., Delivered = green badge, Shipped = blue, etc., using a bit of conditional logic with Bootstrap classes).

- **OrderDetails.razor:** displays details of a single order. Possibly uses a child component for item list (or just loops inside). If order.Status == OrderStatus.Delivered, show the Return button. Also, maybe show a delivery address or any other info if we had it (we assume minimal details here). If the Return button is clicked, it calls a method that invokes the service to do the return.

- **Support.razor:** currently might have something like a simple form where the user can type questions. The lab will significantly change this by wiring it up to the Copilot SDK agent. The base UI is ready to display a response from the agent. We intentionally keep the design minimal here so it's easy to integrate the dynamic behavior in the lab.

**User Experience considerations:** We used Bootstrap for quick styling. The nav menu on the left (in NavMenu.razor) has links to "Orders" and "Contact Support". The main layout provides a header maybe saying "ContosoShop Support Portal" for context. The app is responsive (Bootstrap ensures the layout works on mobile; e.g., the nav collapses to a hamburger). This is not a major focus, but it means the support agent UI we add will also be mobile-friendly out of the box.

## 5. Design for Local vs Cloud Environments

We've emphasized that the app is cloud-ready. Here are specific ways it's designed for easy migration:

**Separation of Concerns & Loose Coupling:** The clear split between front-end and back-end means we could scale them independently. In Azure, you could host the API on an App Service and the Blazor WASM on a CDN or Static Web App; they'd communicate over HTTPS. This separation follows the backend-for-frontend pattern and allows using Azure's best services for each (e.g., Azure CDN for static content, Azure App Service for the API logic). During local dev we combine them for convenience (the hosted Blazor model serving the static files), which is configurable via a flag. For instance, in Program.cs we might use app.UseBlazorFrameworkFiles() and app.MapFallbackToFile("index.html") on the server to serve the client app. This is active in dev; in a separate deployment, we could turn that off and deploy separately.

**Configuration and Secrets:** No secrets are needed for local run (we're not calling external APIs in base). But we have the infrastructure to introduce secrets via user secrets or environment variables if needed. For example, if using SendGrid, we'd store the API key in Azure's config and load it via Configuration["SendGridApiKey"]. The code might be ready to consume such config even if in base it's not set. In appsettings.json we keep sensitive things out (or in dev json only if not sensitive like a local filepath). This means pushing to Azure is just a matter of setting configurations appropriately.

**Database Migration Path:** Using SQLite in development is convenient, but for an Azure production, one would typically use Azure SQL. The EF Core migrations and model are fully compatible with SQL Server. The team could do one of:

- Use `dotnet ef database update` pointing to the Azure SQL connection to create schema.
- Or use EF Core's ability to generate a differential script and run that on Azure SQL.
- Also consider using Azure DevOps or GitHub Actions pipeline to apply migrations during deployment (ensuring zero downtime strategies, etc.). The code doesn't need changes - it's devops process.
- The codebase includes some conditional logic if needed (like maybe a compiler directive or config flag to choose UseSqlServer vs UseSqlite). More simply, we might rely on the connection string format to determine provider; but in practice, we can let the lab environment always use SQLite. Documenting the path: "Switching to Azure SQL involves adding the Microsoft.EntityFrameworkCore.SqlServer NuGet package and changing one line in Program.cs (UseSqlServer). Then update the DefaultConnection string to the Azure SQL connection string in production settings. That's it." This highlights ease of migration.

**Scalability and Performance:** For a local lab, performance is a non-issue. But the use of EF Core (with appropriate indexing if needed) and streaming of data in Web API (we're returning all orders at once, which is fine for small numbers; pagination could be added for very large histories), and the efficient static content loading from Blazor's published output all mean the app can handle typical load. On Azure, enabling response compression, and using Azure Front Door or CDN for static files could vastly improve global performance. None of these require code changes, just configuration and Azure toggles. For instance, ASP.NET Core by default has gzip compression (if enabled in config) for API responses; we can ensure it's on in production.

**Azure Integration Points:** We considered possible Azure services:

- **Azure App Service:** Ideal for hosting the ASP.NET Core API (and even the Blazor client). We ensure the app writes logs to console (which App Service can capture) and doesn't write to disk (except the SQLite DB which is in the content folder; on App Service that's fine but in production we'd use Azure SQL to avoid file write).

- **Azure Static Web Apps:** If splitting client, this could host the Blazor WASM and provide an auto CI/CD from a GitHub repo. Meanwhile, an Azure Function or App Service could host the API. We'd then configure CORS accordingly. The code would not change except possibly the base addresses.

- **Azure Monitor/Application Insights:** We can add Application Insights SDK to monitor server performance and track requests, which is straightforward with one line addition in Program (builder.Services.AddApplicationInsightsTelemetry()). We have not included it in base (to avoid extra setup for lab) but it's an easy add that doesn't alter our logic.

- **Azure OpenAI:** When scaling the AI agent portion, instead of relying on GitHub's Copilot service (which is convenient for development), a production system might use Azure OpenAI Service with models like GPT-4. The Copilot SDK integration we'll do is abstracted enough that we could replace the behind-the-scenes calls with Azure OpenAI's API plus our own orchestration logic (though that would require building something similar to Copilot's planner). Since this is cutting-edge, we mention it as a path if an enterprise has concerns about data or customization – they can swap to their controlled AI endpoint.

In summary, the tech stack is contemporary and robust: C# full-stack (Blazor + ASP.NET Core) with EF Core for ORM, targeting .NET 8 for best performance and features. All these choices align directly with Microsoft's cloud offerings, making the journey from a local SQLite/VS Code experience to an Azure-deployed, scalable solution very smooth. We've enforced clean separation and used interfaces/DI for things like email and data access to ensure that improving or changing implementations (like switching to Azure services) is just a matter of configuration or adding new classes, not rewriting core features.

With the base application's architecture understood, we can proceed to the Lab Exercise where you'll integrate the GitHub Copilot SDK into this app. The lab will guide you through adding an AI agent on the backend (within the ASP.NET Core server) and creating a user interface in the Blazor client to converse with it, leveraging the structures described here (like OrderService and EmailService) so the agent can do useful work (check orders, process returns) securely and effectively.
