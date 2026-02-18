---
lab:
    title: 'Exercise - Integrate an AI Agent into existing apps using GitHub Copilot SDK'
    description: 'Learn how to integrate an AI Agent into existing applications using GitHub Copilot SDK to automate tasks and enhance functionality.'
    level: 300
    duration: 60 minutes
---

# Integrate an AI Agent into existing apps using GitHub Copilot SDK

The GitHub Copilot SDK exposes the same engine behind GitHub Copilot CLI as a programmable SDK. It allows you to embed agentic AI workflows in your applications, including custom tools that let the AI call your code.

In this exercise, you integrate an AI-powered customer support agent into the ContosoShop E-commerce Support Portal. By the end, the "Contact Support" page allows a user to ask questions (for example, "Where is my order?" or "I need to return an item") and receive helpful, automated answers from an AI agent. The agent uses backend tools (like checking order status or initiating a return) to resolve queries.

This exercise should take approximately **60** minutes to complete.

> **IMPORTANT**: To complete this exercise, you must provide your own GitHub account and GitHub Copilot subscription. If you don't have a GitHub account, you can <a href="https://github.com/" target="_blank">sign up</a> for a free individual account and use a GitHub Copilot Free plan to complete the exercise. If you have access to a GitHub Copilot Pro, GitHub Copilot Pro+, GitHub Copilot Business, or GitHub Copilot Enterprise subscription from within your lab environment, you can use your existing GitHub Copilot subscription to complete this exercise.

## Before you start

Your lab environment MUST include the following resources:

- Git 2.48 or later.
- The .NET SDK version 8.0 or later.
- Access to a GitHub account with GitHub Copilot enabled.
- Visual Studio Code with the C# Dev Kit and GitHub Copilot Chat extensions.
- GitHub Copilot CLI installed and authenticated with your GitHub account.

For help with configuring your lab environment, open the following link in a browser: <a href="https://go.microsoft.com/fwlink/?linkid=2352210" target="_blank">Configure your GitHub Copilot SDK lab environment</a>.

## Exercise scenario

You're a software developer working for a consulting firm. The firm developed the ContosoShop E-commerce Support Portal (a Blazor WebAssembly application with an ASP.NET Core backend) for a client. Application features enable a user to (manually) review their order history, track shipments, examine order details, and return items. The client asks you to add an AI-powered customer support agent to the "Contact Support" page. The agent needs to provide automated assistance for the customer, such as looking up order details and initiating returns. You decide to use the GitHub Copilot SDK to build a custom AI agent that can handle customer queries and perform actions on their behalf.

The ContosoShop E-commerce Support Portal application uses a three-project architecture:

- **ContosoShop.Server**: ASP.NET Core Web API with Entity Framework Core, Identity authentication, and SQLite.
- **ContosoShop.Client**: Blazor WebAssembly SPA that runs in the browser and calls the server API.
- **ContosoShop.Shared**: Shared class library containing models, DTOs, and enums.

For the purposes of this lab exercise, you can test the application using two user accounts (Mateo Gomez and Megan Bowen). A total of 20 customer orders are split between the two user accounts. The customer orders are in various tracking stages (Processing, Shipped, Delivered, Returned, and Partially Returned).

This exercise includes the following tasks:

1. Review features of the ContosoShop application.
1. Install the GitHub Copilot SDK components.
1. Create the agent tools service.
1. Configure the GitHub Copilot SDK agent and expose an API endpoint.
1. Update the Blazor frontend to interact with the agent.
1. Test the end-to-end AI agent experience.

## Review features of the ContosoShop application

Before developing the AI customer support agent, you need to become familiar with the existing application features.

Use the following steps to complete this task:

1. Open a browser window and navigate to GitHub.com.

    You can log in to your GitHub account using the following URL: <a href="https://github.com/login" target="_blank">GitHub login</a>.

1. Sign in to your GitHub account, and then open your repositories tab.

    You can open your repositories tab by clicking on your profile icon in the top-right corner, then selecting **Repositories**.

1. On the Repositories tab, select the **New** button.

1. Under the **Create a new repository** section, select **Import a repository**.

1. On the **Import your project to GitHub** page, under **Your source repository details**, enter the following URL for the source repository:

    ```plaintext
    https://github.com/MicrosoftLearning/github-copilot-sdk-starter-app
    ```

1. Under the **Your new repository details** section, in the **Owner** dropdown, select your GitHub username.

1. In the **Repository name** field, enter **ContosoShop**

    GitHub automatically checks the availability of the repository name. If this name is already taken, append a unique suffix (for example, your initials or a random number) to the repository name to make it unique.

1. To create a private repository, select **Private**, and then select **Begin import**.

    GitHub uses the import process to create the new repository in your account.

    > **NOTE**: It can take a minute or two for the import process to finish. Wait for the import process to complete.

    GitHub displays a progress indicator and notify you when the import is complete.

1. Once the import is complete, open your new repository.

    A link to your repository should be displayed. Your repository should be located at: `https://github.com/YOUR-USERNAME/ContosoShop`.

    You can create a local clone of your ContosoShop repository and then initialize GitHub Spec Kit within the project directory.

1. On your ContosoShop repository page, select the **Code** button, and then copy the HTTPS URL.

    The URL should be similar to: `https://github.com/YOUR-USERNAME/ContosoShop.git`

1. Open a terminal window in your development environment, and then navigate to the location where you want to create the local clone of the repository.

    For example:

    Open a terminal window (Command Prompt, PowerShell, or Terminal), and then run:

    ```powershell
    cd C:\TrainingProjects
    ```

    Replace `C:\TrainingProjects` with your preferred location. You can use any directory where you have write permissions, and you can create a new folder location if needed.

1. To clone your ContosoShop repository, enter the following command:

    Be sure to replace `YOUR-USERNAME` with your actual GitHub username before running the command.

    ```powershell
    git clone https://github.com/YOUR-USERNAME/ContosoShop.git
    ```

    You might be prompted to authenticate using your GitHub credentials during the clone operation. You can authenticate using your browser.

1. To navigate into your ContosoShop directory and open it in Visual Studio Code, enter the following commands:

    ```powershell
    cd ContosoShop
    code .
    ```

1. Take a moment to review the project structure.

    Use Visual Studio Code's EXPLORER view to expand the project folders. You should see a folder structure that's similar to the following example:

    ```plaintext
    github-copilot-sdk-starter-app (root)
    ├── ContosoShop.Client/               (Blazor WebAssembly frontend)
    │   ├── Layout/                       (MainLayout, NavMenu)
    │   ├── Pages/                        (Home, Login, Orders, OrderDetails, Support, Inventory)
    │   ├── Services/                     (OrderService, CookieAuthenticationStateProvider)
    │   └── Shared/                       (OrderStatusBadge)
    ├── ContosoShop.Server/               (ASP.NET Core backend)
    │   ├── App_Data/                     (used for the SQLite database file)
    │   ├── Controllers/                  (AuthController, OrdersController, InventoryController)
    │   ├── Data/                         (ContosoContext, DbInitializer, Migrations)
    │   ├── Services/                     (OrderService, InventoryService, EmailServiceDev)
    │   └── Program.cs                    (App configuration and middleware)
    ├── ContosoShop.Shared/               (Shared class library)
    │   ├── DTOs/                         (InventorySummary, ReturnItemRequest)
    │   └── Models/                       (Order, OrderItem, Product, User, etc.)
    └── ContosoShopSupportPortal.slnx     (Solution file)
    ```

1. Open the **ContosoShop.Server/Program.cs** file and review the application configuration.

    Notice the following key configuration areas:

    - Entity Framework Core with SQLite for data access
    - ASP.NET Core Identity for authentication with cookie-based sessions
    - Service registrations for `IEmailService`, `IInventoryService`, and `IOrderService`
    - Database seeding via `DbInitializer.InitializeAsync` at startup
    - CORS, rate limiting, cross-site request forgery (CSRF) protection, and security headers middleware

1. Open the **ContosoShop.Server/Controllers/OrdersController.cs** file and note the existing API endpoints.

    The orders controller provides the following endpoints for managing orders:

    - `GetOrders`: Gets all orders for the authenticated user
    - `GetOrder`: Gets a specific order with items (verifies ownership)
    - `ReturnOrderItems`: Processes item-level returns for a delivered order

1. Open the **ContosoShop.Server/Services/OrderService.cs** file and review the `ProcessItemReturnAsync` method.

    The ProcessItemReturnAsync method processes customer returns for order items. It performs several critical operations to ensure that returns are handled correctly while maintaining data integrity and providing a good customer experience.

    Key Operations:

    - Validates order exists and is returnable (Delivered/Returned/PartialReturn status)
    - Verifies return quantities don't exceed available amounts
    - Creates OrderItemReturn records with refund calculations
    - Restores inventory stock via _inventoryService
    - Updates order status (Returned or PartialReturn based on items)
    - Sends email confirmation with refund details

1. Open a terminal in the **ContosoShop.Server** directory and build the solution.

    ```powershell
    cd ContosoShop.Server
    dotnet build
    ```

    > **IMPORTANT**: The project uses .NET 8 by default. If you have the .NET 9 or .NET 10 SDK installed, but not .NET 8, you need to update the project to target the version of .NET that you have installed. For AI assistance with updating to a later version of .NET, open the GitHub Copilot Chat view and ask GitHub Copilot to update your project files to the version of .NET that you have installed in your environment. For example, you can ask: "I need to update this .NET 8 project to target .NET 10. Please: 1. Update all .csproj files to target net10.0; 2. Update all NuGet packages to .NET 10-compatible versions; 3. Update global.json (if present); 4. Address any breaking changes or deprecated APIs between .NET 8 and .NET 10; 5. Ensure ALL projects in the solution build successfully. Please explain any significant changes or potential issues I should be aware of." When you enter your prompt, the AI assistant should update your codebase and explain what was changed.

    The build should complete successfully without errors (there might be warnings).

1. Start the server application.

    ```powershell
    dotnet run
    ```

    > **NOTE**: The first time you run the application, it may take a little extra time to apply database migrations and seed the database with sample data. You should see console output indicating that the database has been initialized and seeded. You should also see a message that the server starts listening on `http://localhost:5266`.

1. Open a browser and navigate to `http://localhost:5266`.

    The application should open to the ContosoShop login page. If necessary, accept any certificate warnings for the localhost development certificate.

1. Sign in using the demo credentials.

    Enter `mateo@contoso.com` for the email and `Password123!` for the password, and then select **Login**.

1. Verify that the My Orders page displays a list of orders.

    You should see 10 orders for Mateo with various statuses (Processing, Shipped, Delivered, Returned).

1. On the My Orders page, select the **View Details** button for order #1004.

    The application should navigate to the order details page for the selected order. The page should display the order summary, including the order status, order date, total amount, and a list of items in the order.

1. Take a moment to review the order details, and then select the **Return Items** button.

    The page should update to display **Return** and **Return Qty** columns. The **Return** column contains checkboxes, and the **Return Qty** column contains input fields for specifying the quantity to return.

1. In the **Return** column, select the checkbox for the **Monitor** item, and then enter **1** in the corresponding **Return Qty** field.

    This selection indicates that you want to return one monitor item from the order.

1. Select the **Submit Return (1 item)** button.

    The application should process the return request, display a success message, and update the order status to "Partial Return". The order details for the monitor item should show a "Returned 1 of 3" badge, and a Returned column should show that one monitor item was returned.

1. To open a page that displays Contoso's product inventory, select **View Inventory** on the navigation menu.

    > **NOTE**: The Inventory Management page is included for lab purposes only, so that you can verify that a return has been processed correctly. The page should display a list of products with their available stock.

1. Verify that the stock for the Monitor product has been replenished by one unit after processing the return in the previous steps.

    The **Returned** column for the  **Monitor** product (Item Number: ITM-003) should show that one item has been returned. When an item is returned, the stock is replenished by the returned quantity.

1. To open the Customer Support page, select **Contact Support** on the navigation menu.

    You should see contact information and a message that states "Interactive AI Chat Support Coming Soon". You'll update this Customer Support page in upcoming tasks. The corresponding project file is: **ContosoShop.Client/Pages/Support.razor**.

1. To log out from the application, select **Logout** on the navigation menu.

    The application should log you out and navigate back to the Login page.

1. To stop the application, return to the Visual Studio Code integrated terminal where the server is running, and then press **Ctrl+C**.

    > **NOTE**: You can leave the terminal open for the next task.

## Install the GitHub Copilot SDK components

In this task, you add the GitHub Copilot SDK NuGet package and the Microsoft.Extensions.AI package to the server project. The GitHub Copilot SDK provides the core components for building AI agents, while Microsoft.Extensions.AI provides types for defining custom tools that the agent can call.

Use the following steps to complete this task:

1. Ensure that you have Visual Studio Code's integrated terminal open and that you're located in the **ContosoShop.Server** directory.

1. In terminal, to verify that the GitHub Copilot CLI is installed and authenticated, enter the following command:

    ```powershell
    copilot --version
    ```

    You should see a version number (for example, `0.0.407`). If the command isn't found, use the following instructions to finish preparing the lab environment <a href="https://go.microsoft.com/fwlink/?linkid=2352210" target="_blank">Configure your GitHub Copilot SDK lab environment</a>.

    > **NOTE**: The GitHub Copilot SDK communicates with the Copilot CLI in server mode. The SDK manages the CLI process lifecycle automatically, but the CLI must be installed and accessible in your PATH.

1. To configure the GitHub Copilot SDK NuGet package to your project, enter the following command:

    ```powershell
    dotnet add package GitHub.Copilot.SDK --prerelease
    ```

    This command installs the latest preview version of the SDK. The SDK provides `CopilotClient`, `CopilotSession`, and related types for building AI agents.

    > **NOTE**: While the GitHub Copilot SDK is in Technical Preview, the `--prerelease` flag is required to install it.

1. To add the `Microsoft.Extensions.AI` package to your project, enter the following command:

    ```powershell
    dotnet add package Microsoft.Extensions.AI
    ```

    The GitHub Copilot SDK uses `Microsoft.Extensions.AI` for defining custom tools. This package provides the `AIFunctionFactory` and related types for creating tools that the AI agent can call.

1. To verify the packages installed correctly, build the project:

    ```powershell
    dotnet build
    ```

    The build should succeed without errors.

## Create the agent tools service

In this task, you create a new service class in the server project that implements the tools the AI agent uses to look up orders and process returns. This service will be registered in dependency injection and called by the AI agent when handling user queries.

Use the following steps to complete this task:

1. In Visual Studio Code's EXPLORER view, right-click the **ContosoShop.Server/Services** folder, and then select **New File**.

    You'll use this file to create the SupportAgentTools service class.

1. Name the file **SupportAgentTools.cs**.

1. Add the following code to the **SupportAgentTools.cs** file:

    ```csharp
    using ContosoShop.Server.Data;
    using ContosoShop.Shared.Models;
    using ContosoShop.Shared.DTOs;
    using Microsoft.EntityFrameworkCore;

    namespace ContosoShop.Server.Services;

    /// <summary>
    /// Provides tool functions that the AI support agent can invoke
    /// to look up order information and process returns.
    /// </summary>
    public class SupportAgentTools
    {
        private readonly ContosoContext _context;
        private readonly IOrderService _orderService;
        private readonly IEmailService _emailService;
        private readonly ILogger<SupportAgentTools> _logger;

        public SupportAgentTools(
            ContosoContext context,
            IOrderService orderService,
            IEmailService emailService,
            ILogger<SupportAgentTools> logger)
        {
            _context = context;
            _orderService = orderService;
            _emailService = emailService;
            _logger = logger;
        }

        // add the `GetOrderDetailsAsync` method here


        // add the `GetUserOrdersSummaryAsync` method here


        // add the `ProcessReturnAsync` method here


        // add the `SendCustomerEmailAsync` method here

    }
    ```

    This code sets up the class skeleton with dependency injection. The constructor receives four dependencies:

    - `ContosoContext`: the Entity Framework Core database context for querying orders and users directly.
    - `IOrderService`: the existing service that handles return processing logic, inventory updates, and email confirmations.
    - `IEmailService`: the service used to send follow-up emails to customers.
    - `ILogger<SupportAgentTools>`: a logger for recording each tool invocation, which is useful for debugging and monitoring agent behavior.

    These dependencies allow the tools to access real data and use existing business logic rather than duplicating it.

1. Inside the SupportAgentTools class (after the constructor's closing brace), add the following GetOrderDetailsAsync method:

    ```csharp
    /// <summary>
    /// Gets the status and details of a specific order by order ID.
    /// The AI agent calls this tool when a user asks about their order status.
    /// </summary>
    public async Task<string> GetOrderDetailsAsync(int orderId, int userId)
    {
        _logger.LogInformation("Agent tool invoked: GetOrderDetails for orderId {OrderId}, userId {UserId}", orderId, userId);

        var order = await _context.Orders
            .Include(o => o.Items)
            .FirstOrDefaultAsync(o => o.Id == orderId && o.UserId == userId);

        if (order == null)
        {
            return $"I could not find order #{orderId} associated with your account. Please double-check the order number.";
        }

        var statusMessage = order.Status switch
        {
            OrderStatus.Processing => "is currently being processed and has not shipped yet",
            OrderStatus.Shipped => order.ShipDate.HasValue
                ? $"was shipped on {order.ShipDate.Value:MMMM dd, yyyy} and is on its way"
                : "has been shipped and is on its way",
            OrderStatus.Delivered => order.DeliveryDate.HasValue
                ? $"was delivered on {order.DeliveryDate.Value:MMMM dd, yyyy}"
                : "has been delivered",
            OrderStatus.PartialReturn => "has been partially returned (some items have been returned, others are still with you)",
            OrderStatus.Returned => "has been fully returned and a refund was issued",
            _ => "has an unknown status"
        };

        var itemSummary = string.Join(", ", order.Items.Select(i =>
        {
            var itemInfo = $"{i.ProductName} (Id: {i.Id}, qty: {i.Quantity}, ${i.Price:F2} each";
            if (i.ReturnedQuantity > 0)
            {
                itemInfo += $", {i.ReturnedQuantity} returned, {i.RemainingQuantity} remaining";
            }
            itemInfo += ")";
            return itemInfo;
        }));

        return $"Order #{order.Id} {statusMessage}. " +
                $"Order date: {order.OrderDate:MMMM dd, yyyy}. " +
                $"Total: ${order.TotalAmount:F2}. " +
                $"Items: {itemSummary}.";
    }
    ```

1. Take a minute to review the GetOrderDetailsAsync method.

    This code snippet is the first agent tool. The AI agent calls this method when a customer asks about a specific order. The method queries the database for the order (including its items), verifies that the order belongs to the authenticated user via `userId`, and builds a natural language response. A C# `switch` expression translates the `OrderStatus` enum into human-readable phrases, including `PartialReturn` for orders where some items have been returned. The item summary lists each product with its database `Id`, quantity, and price; items that have been partially returned also show their `ReturnedQuantity` and `RemainingQuantity`. Including the item `Id` in the output is critical because the AI agent uses it when calling the `process_return` tool for partial returns. If the order isn't found, the method returns a friendly error message rather than throwing an exception, which is important because the AI agent presents the return value directly to the customer.

1. On a code line below the GetOrderDetailsAsync method, add the following GetUserOrdersSummaryAsync method:

    ```csharp
    /// <summary>
    /// Gets a summary of all orders for a given user.
    /// The AI agent calls this tool when a user asks about their orders
    /// without specifying a particular order number.
    /// </summary>
    public async Task<string> GetUserOrdersSummaryAsync(int userId)
    {
        _logger.LogInformation("Agent tool invoked: GetUserOrdersSummary for userId {UserId}", userId);

        var orders = await _context.Orders
            .Where(o => o.UserId == userId)
            .OrderByDescending(o => o.OrderDate)
            .ToListAsync();

        if (!orders.Any())
        {
            return "You don't have any orders on file.";
        }

        var summaries = orders.Select(o =>
        {
            var status = o.Status switch
            {
                OrderStatus.Processing => "Processing",
                OrderStatus.Shipped => "Shipped",
                OrderStatus.Delivered => "Delivered",
                OrderStatus.PartialReturn => "Partial Return",
                OrderStatus.Returned => "Returned",
                _ => "Unknown"
            };
            return $"Order #{o.Id} - {status} - ${o.TotalAmount:F2} - Placed {o.OrderDate:MMM dd, yyyy}";
        });

        return $"You have {orders.Count} orders:\n" + string.Join("\n", summaries);
    }
    ```

1. Take a minute to review the GetUserOrdersSummaryAsync method.

    This tool complements `GetOrderDetailsAsync` by handling cases where the customer asks about their orders without specifying a particular order number (for example, "What are my recent orders?"). It retrieves all orders for the user, sorted by date in descending order, and formats each one as a concise summary line showing the order number, status, total, and date. The AI agent uses this overview to help the customer identify the order they're interested in.

1. On a code line below the GetUserOrdersSummaryAsync method, add the following ProcessReturnAsync method:

    ```csharp
    /// <summary>
    /// Processes a return for specific items in a delivered order.
    /// The AI agent calls this tool when a user wants to return items.
    /// Supports returning all items, specific items by ID, or specific quantities.
    /// </summary>
    /// <param name="orderId">The order ID to process returns for</param>
    /// <param name="userId">The authenticated user ID</param>
    /// <param name="orderItemIds">Optional: Specific order item IDs to return (comma-separated, e.g., "123,456"). If empty, returns all unreturned items.</param>
    /// <param name="quantities">Optional: Quantities for each item (comma-separated, e.g., "1,2" for items 123 and 456). Must match orderItemIds length. If empty, returns full remaining quantity for each item.</param>
    /// <param name="reason">Optional: Reason for the return</param>
    public async Task<string> ProcessReturnAsync(
        int orderId, 
        int userId, 
        string orderItemIds = "", 
        string quantities = "",
        string reason = "Customer requested return via AI support agent")
    {
        _logger.LogInformation("Agent tool invoked: ProcessReturn for orderId {OrderId}, userId {UserId}, items: {Items}", 
            orderId, userId, string.IsNullOrEmpty(orderItemIds) ? "all" : orderItemIds);

        var order = await _context.Orders
            .Include(o => o.Items)
            .FirstOrDefaultAsync(o => o.Id == orderId && o.UserId == userId);

        if (order == null)
        {
            return $"I could not find order #{orderId} associated with your account.";
        }

        if (order.Status != OrderStatus.Delivered && order.Status != OrderStatus.Returned && order.Status != OrderStatus.PartialReturn)
        {
            return order.Status switch
            {
                OrderStatus.Processing => $"Order #{orderId} is still being processed and cannot be returned yet. It must be delivered first.",
                OrderStatus.Shipped => $"Order #{orderId} is currently in transit and cannot be returned until it has been delivered.",
                _ => $"Order #{orderId} has a status of {order.Status} and cannot be returned."
            };
        }

        List<ReturnItem> returnItems;

        // Parse specific items if provided
        if (!string.IsNullOrWhiteSpace(orderItemIds))
        {
            var itemIdStrings = orderItemIds.Split(',', StringSplitOptions.RemoveEmptyEntries);
            var itemIds = new List<int>();
            
            foreach (var idStr in itemIdStrings)
            {
                if (int.TryParse(idStr.Trim(), out int itemId))
                {
                    itemIds.Add(itemId);
                }
                else
                {
                    return $"Invalid item ID format: '{idStr}'. Please provide valid item IDs.";
                }
            }

            // Parse quantities if provided
            var itemQuantities = new List<int>();
            if (!string.IsNullOrWhiteSpace(quantities))
            {
                var quantityStrings = quantities.Split(',', StringSplitOptions.RemoveEmptyEntries);
                foreach (var qtyStr in quantityStrings)
                {
                    if (int.TryParse(qtyStr.Trim(), out int qty) && qty > 0)
                    {
                        itemQuantities.Add(qty);
                    }
                    else
                    {
                        return $"Invalid quantity format: '{qtyStr}'. Quantities must be positive numbers.";
                    }
                }

                if (itemQuantities.Count != itemIds.Count)
                {
                    return "The number of quantities must match the number of items.";
                }
            }

            // Build return items for specific items
            returnItems = new List<ReturnItem>();
            for (int i = 0; i < itemIds.Count; i++)
            {
                var orderItem = order.Items.FirstOrDefault(item => item.Id == itemIds[i]);
                if (orderItem == null)
                {
                    return $"Item ID {itemIds[i]} was not found in order #{orderId}.";
                }

                if (orderItem.RemainingQuantity <= 0)
                {
                    return $"{orderItem.ProductName} has already been fully returned.";
                }

                var quantityToReturn = itemQuantities.Count > 0 ? itemQuantities[i] : orderItem.RemainingQuantity;
                
                if (quantityToReturn > orderItem.RemainingQuantity)
                {
                    return $"Cannot return {quantityToReturn} of {orderItem.ProductName}. Only {orderItem.RemainingQuantity} available to return.";
                }

                returnItems.Add(new ReturnItem
                {
                    OrderItemId = orderItem.Id,
                    Quantity = quantityToReturn,
                    Reason = reason
                });
            }
        }
        else
        {
            // Return all unreturned items (original behavior)
            returnItems = order.Items
                .Where(i => i.RemainingQuantity > 0)
                .Select(i => new ReturnItem
                {
                    OrderItemId = i.Id,
                    Quantity = i.RemainingQuantity,
                    Reason = reason
                })
                .ToList();
        }

        if (!returnItems.Any())
        {
            return $"All items in order #{orderId} have already been returned.";
        }

        var success = await _orderService.ProcessItemReturnAsync(orderId, returnItems);

        if (!success)
        {
            _logger.LogError("Failed to process return for orderId {OrderId}, userId {UserId}", orderId, userId);
            return $"I was unable to process the return for order #{orderId}. Please contact our support team for assistance.";
        }

        _logger.LogInformation("Successfully processed return for orderId {OrderId}, userId {UserId}, items: {ItemCount}", 
            orderId, userId, returnItems.Count);

        // Calculate refund amount for the items being returned
        var refundAmount = returnItems.Sum(ri =>
        {
            var item = order.Items.First(i => i.Id == ri.OrderItemId);
            return item.Price * ri.Quantity;
        });

        // Build response message
        var itemsSummary = string.Join(", ", returnItems.Select(ri =>
        {
            var item = order.Items.First(i => i.Id == ri.OrderItemId);
            return $"{item.ProductName} (qty: {ri.Quantity})";
        }));

        return $"I've successfully processed the return for the following items from order #{orderId}: {itemsSummary}. " +
                $"A refund of ${refundAmount:F2} will be issued to your original payment method within 5-7 business days. " +
                $"You will receive a confirmation email shortly. " +
                $"To view the updated return status, please visit the Order Details page for order #{orderId}.";
    }
    ```

1. Take a minute to review the ProcessReturnAsync method.

    This code snippet is the most complex tool because it performs a state-changing operation with support for both full and partial returns. The method accepts three optional parameters: `orderItemIds` (comma-separated item IDs to return), `quantities` (comma-separated quantities for each item), and `reason`. When `orderItemIds` is empty, it returns all unreturned items (the default behavior). When specific item IDs are provided, it parses them and optionally their quantities, validates each item exists in the order and has remaining quantity, and builds targeted `ReturnItem` objects. The method includes several validation layers: it verifies the order exists and belongs to the user, checks that the order status is `Delivered`, `PartialReturn`, or `Returned`, validates item IDs and quantity formats, and confirms items haven't already been fully returned. If validation passes, it delegates the actual return processing to the existing `IOrderService.ProcessItemReturnAsync` method. The method calculates the refund amount based on the specific items being returned and includes a summary of returned items in the response. Each validation failure returns a specific, helpful message explaining why the return can't be processed.

1. On a code line below the ProcessReturnAsync method, add the following SendCustomerEmailAsync method:

    ```csharp
    /// <summary>
    /// Sends a follow-up email to the customer regarding their order.
    /// The AI agent calls this tool to send additional information by email.
    /// </summary>
    public async Task<string> SendCustomerEmailAsync(int orderId, int userId, string message)
    {
        _logger.LogInformation("Agent tool invoked: SendCustomerEmail for orderId {OrderId}", orderId);

        var order = await _context.Orders
            .FirstOrDefaultAsync(o => o.Id == orderId && o.UserId == userId);

        if (order == null)
        {
            return $"Could not find order #{orderId} to send an email about.";
        }

        // Get the user's email from Identity
        var user = await _context.Users.FindAsync(userId);
        var email = user?.Email ?? "customer@contoso.com";

        await _emailService.SendEmailAsync(email, $"Regarding your order #{orderId}", message);

        return $"I've sent an email to {email} with the details about order #{orderId}.";
    }
    ```

    This tool enables the AI agent to send follow-up emails to customers. The method verifies that the order exists and belongs to the user, retrieves the user's email address from the Identity system, and sends the email using `IEmailService`. The `message` parameter is generated by the AI agent itself, allowing it to compose context-appropriate email content based on the conversation. A fallback email address is provided in case the user's email can't be retrieved.

1. Your completed SupportAgentTools.cs file should look similar to the following code:

    ```csharp
    using ContosoShop.Server.Data;
    using ContosoShop.Shared.Models;
    using ContosoShop.Shared.DTOs;
    using Microsoft.EntityFrameworkCore;
    
    namespace ContosoShop.Server.Services;
    
    /// <summary>
    /// Provides tool functions that the AI support agent can invoke
    /// to look up order information and process returns.
    /// </summary>
    public class SupportAgentTools
    {
        private readonly ContosoContext _context;
        private readonly IOrderService _orderService;
        private readonly IEmailService _emailService;
        private readonly ILogger<SupportAgentTools> _logger;
    
        public SupportAgentTools(
            ContosoContext context,
            IOrderService orderService,
            IEmailService emailService,
            ILogger<SupportAgentTools> logger)
        {
            _context = context;
            _orderService = orderService;
            _emailService = emailService;
            _logger = logger;
        }
    
        // add the `GetOrderDetailsAsync` method here
        /// <summary>
        /// Gets the status and details of a specific order by order ID.
        /// The AI agent calls this tool when a user asks about their order status.
        /// </summary>
        public async Task<string> GetOrderDetailsAsync(int orderId, int userId)
        {
            _logger.LogInformation("Agent tool invoked: GetOrderDetails for orderId {OrderId}, userId {UserId}", orderId, userId);
    
            var order = await _context.Orders
                .Include(o => o.Items)
                .FirstOrDefaultAsync(o => o.Id == orderId && o.UserId == userId);
    
            if (order == null)
            {
                return $"I could not find order #{orderId} associated with your account. Please double-check the order number.";
            }
    
            var statusMessage = order.Status switch
            {
                OrderStatus.Processing => "is currently being processed and has not shipped yet",
                OrderStatus.Shipped => order.ShipDate.HasValue
                    ? $"was shipped on {order.ShipDate.Value:MMMM dd, yyyy} and is on its way"
                    : "has been shipped and is on its way",
                OrderStatus.Delivered => order.DeliveryDate.HasValue
                    ? $"was delivered on {order.DeliveryDate.Value:MMMM dd, yyyy}"
                    : "has been delivered",
                OrderStatus.PartialReturn => "has been partially returned (some items have been returned, others are still with you)",
                OrderStatus.Returned => "has been fully returned and a refund was issued",
                _ => "has an unknown status"
            };
    
            var itemSummary = string.Join(", ", order.Items.Select(i =>
            {
                var itemInfo = $"{i.ProductName} (Id: {i.Id}, qty: {i.Quantity}, ${i.Price:F2} each";
                if (i.ReturnedQuantity > 0)
                {
                    itemInfo += $", {i.ReturnedQuantity} returned, {i.RemainingQuantity} remaining";
                }
                itemInfo += ")";
                return itemInfo;
            }));
    
            return $"Order #{order.Id} {statusMessage}. " +
                    $"Order date: {order.OrderDate:MMMM dd, yyyy}. " +
                    $"Total: ${order.TotalAmount:F2}. " +
                    $"Items: {itemSummary}.";
        }
    
        // add the `GetUserOrdersSummaryAsync` method here
        /// <summary>
        /// Gets a summary of all orders for a given user.
        /// The AI agent calls this tool when a user asks about their orders
        /// without specifying a particular order number.
        /// </summary>
        public async Task<string> GetUserOrdersSummaryAsync(int userId)
        {
            _logger.LogInformation("Agent tool invoked: GetUserOrdersSummary for userId {UserId}", userId);
    
            var orders = await _context.Orders
                .Where(o => o.UserId == userId)
                .OrderByDescending(o => o.OrderDate)
                .ToListAsync();
    
            if (!orders.Any())
            {
                return "You don't have any orders on file.";
            }
    
            var summaries = orders.Select(o =>
            {
                var status = o.Status switch
                {
                    OrderStatus.Processing => "Processing",
                    OrderStatus.Shipped => "Shipped",
                    OrderStatus.Delivered => "Delivered",
                    OrderStatus.PartialReturn => "Partial Return",
                    OrderStatus.Returned => "Returned",
                    _ => "Unknown"
                };
                return $"Order #{o.Id} - {status} - ${o.TotalAmount:F2} - Placed {o.OrderDate:MMM dd, yyyy}";
            });
    
            return $"You have {orders.Count} orders:\n" + string.Join("\n", summaries);
        }
    
        // add the `ProcessReturnAsync` method here
        /// <summary>
        /// Processes a return for specific items in a delivered order.
        /// The AI agent calls this tool when a user wants to return items.
        /// Supports returning all items, specific items by ID, or specific quantities.
        /// </summary>
        /// <param name="orderId">The order ID to process returns for</param>
        /// <param name="userId">The authenticated user ID</param>
        /// <param name="orderItemIds">Optional: Specific order item IDs to return (comma-separated, e.g., "123,456"). If empty, returns all unreturned items.</param>
        /// <param name="quantities">Optional: Quantities for each item (comma-separated, e.g., "1,2" for items 123 and 456). Must match orderItemIds length. If empty, returns full remaining quantity for each item.</param>
        /// <param name="reason">Optional: Reason for the return</param>
        public async Task<string> ProcessReturnAsync(
            int orderId, 
            int userId, 
            string orderItemIds = "", 
            string quantities = "",
            string reason = "Customer requested return via AI support agent")
        {
            _logger.LogInformation("Agent tool invoked: ProcessReturn for orderId {OrderId}, userId {UserId}, items: {Items}", 
                orderId, userId, string.IsNullOrEmpty(orderItemIds) ? "all" : orderItemIds);
    
            var order = await _context.Orders
                .Include(o => o.Items)
                .FirstOrDefaultAsync(o => o.Id == orderId && o.UserId == userId);
    
            if (order == null)
            {
                return $"I could not find order #{orderId} associated with your account.";
            }
    
            if (order.Status != OrderStatus.Delivered && order.Status != OrderStatus.Returned && order.Status != OrderStatus.PartialReturn)
            {
                return order.Status switch
                {
                    OrderStatus.Processing => $"Order #{orderId} is still being processed and cannot be returned yet. It must be delivered first.",
                    OrderStatus.Shipped => $"Order #{orderId} is currently in transit and cannot be returned until it has been delivered.",
                    _ => $"Order #{orderId} has a status of {order.Status} and cannot be returned."
                };
            }
    
            List<ReturnItem> returnItems;
    
            // Parse specific items if provided
            if (!string.IsNullOrWhiteSpace(orderItemIds))
            {
                var itemIdStrings = orderItemIds.Split(',', StringSplitOptions.RemoveEmptyEntries);
                var itemIds = new List<int>();
                
                foreach (var idStr in itemIdStrings)
                {
                    if (int.TryParse(idStr.Trim(), out int itemId))
                    {
                        itemIds.Add(itemId);
                    }
                    else
                    {
                        return $"Invalid item ID format: '{idStr}'. Please provide valid item IDs.";
                    }
                }
    
                // Parse quantities if provided
                var itemQuantities = new List<int>();
                if (!string.IsNullOrWhiteSpace(quantities))
                {
                    var quantityStrings = quantities.Split(',', StringSplitOptions.RemoveEmptyEntries);
                    foreach (var qtyStr in quantityStrings)
                    {
                        if (int.TryParse(qtyStr.Trim(), out int qty) && qty > 0)
                        {
                            itemQuantities.Add(qty);
                        }
                        else
                        {
                            return $"Invalid quantity format: '{qtyStr}'. Quantities must be positive numbers.";
                        }
                    }
    
                    if (itemQuantities.Count != itemIds.Count)
                    {
                        return "The number of quantities must match the number of items.";
                    }
                }
    
                // Build return items for specific items
                returnItems = new List<ReturnItem>();
                for (int i = 0; i < itemIds.Count; i++)
                {
                    var orderItem = order.Items.FirstOrDefault(item => item.Id == itemIds[i]);
                    if (orderItem == null)
                    {
                        return $"Item ID {itemIds[i]} was not found in order #{orderId}.";
                    }
    
                    if (orderItem.RemainingQuantity <= 0)
                    {
                        return $"{orderItem.ProductName} has already been fully returned.";
                    }
    
                    var quantityToReturn = itemQuantities.Count > 0 ? itemQuantities[i] : orderItem.RemainingQuantity;
                    
                    if (quantityToReturn > orderItem.RemainingQuantity)
                    {
                        return $"Cannot return {quantityToReturn} of {orderItem.ProductName}. Only {orderItem.RemainingQuantity} available to return.";
                    }
    
                    returnItems.Add(new ReturnItem
                    {
                        OrderItemId = orderItem.Id,
                        Quantity = quantityToReturn,
                        Reason = reason
                    });
                }
            }
            else
            {
                // Return all unreturned items (original behavior)
                returnItems = order.Items
                    .Where(i => i.RemainingQuantity > 0)
                    .Select(i => new ReturnItem
                    {
                        OrderItemId = i.Id,
                        Quantity = i.RemainingQuantity,
                        Reason = reason
                    })
                    .ToList();
            }
    
            if (!returnItems.Any())
            {
                return $"All items in order #{orderId} have already been returned.";
            }
    
            var success = await _orderService.ProcessItemReturnAsync(orderId, returnItems);
    
            if (!success)
            {
                _logger.LogError("Failed to process return for orderId {OrderId}, userId {UserId}", orderId, userId);
                return $"I was unable to process the return for order #{orderId}. Please contact our support team for assistance.";
            }
    
            _logger.LogInformation("Successfully processed return for orderId {OrderId}, userId {UserId}, items: {ItemCount}", 
                orderId, userId, returnItems.Count);
    
            // Calculate refund amount for the items being returned
            var refundAmount = returnItems.Sum(ri =>
            {
                var item = order.Items.First(i => i.Id == ri.OrderItemId);
                return item.Price * ri.Quantity;
            });
    
            // Build response message
            var itemsSummary = string.Join(", ", returnItems.Select(ri =>
            {
                var item = order.Items.First(i => i.Id == ri.OrderItemId);
                return $"{item.ProductName} (qty: {ri.Quantity})";
            }));
    
            return $"I've successfully processed the return for the following items from order #{orderId}: {itemsSummary}. " +
                    $"A refund of ${refundAmount:F2} will be issued to your original payment method within 5-7 business days. " +
                    $"You will receive a confirmation email shortly. " +
                    $"To view the updated return status, please visit the Order Details page for order #{orderId}.";
        }
    
        // add the `SendCustomerEmailAsync` method here
        /// <summary>
        /// Sends a follow-up email to the customer regarding their order.
        /// The AI agent calls this tool to send additional information by email.
        /// </summary>
        public async Task<string> SendCustomerEmailAsync(int orderId, int userId, string message)
        {
            _logger.LogInformation("Agent tool invoked: SendCustomerEmail for orderId {OrderId}", orderId);
    
            var order = await _context.Orders
                .FirstOrDefaultAsync(o => o.Id == orderId && o.UserId == userId);
    
            if (order == null)
            {
                return $"Could not find order #{orderId} to send an email about.";
            }
    
            // Get the user's email from Identity
            var user = await _context.Users.FindAsync(userId);
            var email = user?.Email ?? "customer@contoso.com";
    
            await _emailService.SendEmailAsync(email, $"Regarding your order #{orderId}", message);
    
            return $"I've sent an email to {email} with the details about order #{orderId}.";
        }
    }
    ```

    The completed **SupportAgentTools.cs** file has the following structure:

    - The `using` statements, namespace, and class declaration at the top
    - The constructor with four injected dependencies
    - Four public methods: `GetOrderDetailsAsync`, `GetUserOrdersSummaryAsync`, `ProcessReturnAsync`, and `SendCustomerEmailAsync`

    All four methods follow a consistent design pattern: they accept a `userId` parameter for security verification, log the tool invocation, query the database, perform validation, and return human-readable strings that the AI agent presents directly to the customer.

1. Open the **ContosoShop.Server/Program.cs** file.

    You'll use the Program.cs file to register SupportAgentTools in dependency injection.

1. Scroll down to locate the service registration section.

    You can search for the following code comment: `// Register order business logic service`.

1. Create a blank line after the code used to register the `OrderService`.

1. To register the `SupportAgentTools` service, add the following code:

    ```csharp
    // Register AI agent tools service
    builder.Services.AddScoped<SupportAgentTools>();
    ```

1. Save your updated files.

1. Build the ContosoShop.Server project and verify that there are no errors.

    For example, you can build the project by entering the following command in the terminal:

    ```powershell
    dotnet build
    ```

    The build should succeed. If there are errors, ensure that your code matches the example code shown above. Review the SupportAgentTools.cs file to ensure all `using` statements and references are correct. Keep in mind that the GitHub Copilot SDK is in a Technical Preview phase that includes periodic updates. If necessary, you can point GitHub Copilot to the GitHub Copilot SDK repository (`https://github.com/github/copilot-sdk`) and ask the AI assistant to help you debug the issues.

## Configure the GitHub Copilot SDK agent and expose an API endpoint

In this task, you create a `CopilotClient` singleton, register it in dependency injection, and create a new API controller that accepts user questions and returns the AI agent's responses.

Use the following steps to complete this task:

1. Open the **ContosoShop.Server/Program.cs** file.

    You'll use the Program.cs file to register CopilotClient as a singleton in dependency injection.

1. Add the following `using` statement at the top of the file, after the existing `using` statements:

    ```csharp
    using GitHub.Copilot.SDK;
    ```

1. Locate the service registration section.

    You can search for the code comment that you added earlier: `// Register AI agent tools service`.

1. Create a blank line after the code used to register the SupportAgentTools service.

    This location is where you'll add the code to register the `CopilotClient` singleton.

1. To create and register a CopilotClient singleton, add the following code:

    ```csharp
    // Register GitHub Copilot SDK client as a singleton
    builder.Services.AddSingleton<CopilotClient>(sp =>
    {
        var logger = sp.GetRequiredService<ILogger<CopilotClient>>();
        return new CopilotClient(new CopilotClientOptions
        {
            AutoStart = true,
            LogLevel = "info"
        });
    });
    ```

    The `CopilotClient` manages the Copilot CLI process lifecycle. Setting `AutoStart = true` means the CLI server starts automatically when the first session is created.

1. Scroll down to locate the following code line:

    ```csharp
    var app = builder.Build();
    ```

1. Create a blank code line between `var app = builder.Build();` and the database initialization block.

1. To initialize and start the GitHub Copilot SDK client, add the following code:

    ```csharp
    // Ensure CopilotClient is started
    var copilotClient = app.Services.GetRequiredService<CopilotClient>();
    await copilotClient.StartAsync();
    ```

    In addition to initializing and starting the CopilotClient, this code also ensures that it's properly disposed when the application shuts down.

1. Save the file.

1. In Visual Studio Code's EXPLORER view, right-click the **ContosoShop.Shared/Models** folder, and then select **New File**.

1. Name the file **SupportQuery.cs**.

1. Add the following code to the **SupportQuery.cs** file:

    ```csharp
    using System.ComponentModel.DataAnnotations;

    namespace ContosoShop.Shared.Models;

    /// <summary>
    /// Represents a support question submitted by the user to the AI agent.
    /// </summary>
    public class SupportQuery
    {
        /// <summary>
        /// The user's question or message for the AI support agent.
        /// </summary>
        [Required]
        [StringLength(1000, MinimumLength = 1)]
        public string Question { get; set; } = string.Empty;
    }

    /// <summary>
    /// Represents the AI agent's response to a support query.
    /// </summary>
    public class SupportResponse
    {
        /// <summary>
        /// The AI agent's answer to the user's question.
        /// </summary>
        public string Answer { get; set; } = string.Empty;
    }
    ```

1. Take a minute to review the **SupportQuery** and **SupportResponse** models.

    This file defines data transfer models for AI support agent communication:

    **SupportQuery**

    - Represents customer questions sent to the AI support agent
    - Contains a Question property with validation: required, 1-1000 characters
    - Used as the request payload from client to server

    **SupportResponse**

    - Represents AI agent responses back to the customer
    - Contains an Answer property with the agent's reply
    - Used as the response payload from server to client

    These models are lightweight DTOs for the support chat interface, enabling structured communication between the Blazor client and the AI-powered support endpoint. The simple design focuses on text-based question-and-answer exchanges with basic input validation.

1. In Visual Studio Code's EXPLORER view, right-click the **ContosoShop.Server/Controllers** folder, and then select **New File**.

1. Name the file **SupportAgentController.cs**.

1. Add the following code to the **SupportAgentController.cs** file:

    ```csharp
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.AI;
    using GitHub.Copilot.SDK;
    using ContosoShop.Server.Services;
    using ContosoShop.Shared.Models;
    using System.ComponentModel;
    using System.Security.Claims;

    namespace ContosoShop.Server.Controllers;

    /// <summary>
    /// API controller that handles AI support agent queries.
    /// Accepts user questions, creates a Copilot SDK session with custom tools,
    /// and returns the agent's response.
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class SupportAgentController : ControllerBase
    {
        private readonly CopilotClient _copilotClient;
        private readonly SupportAgentTools _agentTools;
        private readonly ILogger<SupportAgentController> _logger;

        public SupportAgentController(
            CopilotClient copilotClient,
            SupportAgentTools agentTools,
            ILogger<SupportAgentController> logger)
        {
            _copilotClient = copilotClient;
            _agentTools = agentTools;
            _logger = logger;
        }

        /// <summary>
        /// Accepts a support question from the user and returns the AI agent's response.
        /// POST /api/supportagent/ask
        /// </summary>
        [HttpPost("ask")]
        public async Task<IActionResult> AskQuestion([FromBody] SupportQuery query)
        {
            if (query == null || string.IsNullOrWhiteSpace(query.Question))
            {
                return BadRequest(new SupportResponse { Answer = "Please enter a question." });
            }

            // Get the authenticated user's ID from claims
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (!int.TryParse(userIdClaim, out int userId))
            {
                return Unauthorized(new SupportResponse { Answer = "Unable to identify user." });
            }

            _logger.LogInformation("Support agent query from user {UserId}: {Question}", userId, query.Question);
        }
    }

    ```

1. Take a minute to review the SupportAgentController code.

    This code establishes the controller skeleton. Key design decisions in this code:

    - The `[Authorize]` attribute ensures only authenticated users can reach the endpoint, which is critical since the agent accesses user-specific order data.
    - The `[ApiController]` and `[Route("api/[controller]")]` attributes configure the endpoint at `POST /api/supportagent/ask`.
    - The constructor injects three dependencies: `CopilotClient` (the SDK client for creating AI sessions), `SupportAgentTools` (the tools service you created earlier), and `ILogger` for diagnostics.
    - The method starts by validating the input and extracting the authenticated user's ID from the claims. The `userId` is extracted once and then passed to each tool call. This process ensures the agent can only access the current user's data, preventing cross-user data leaks.

1. Inside the `AskQuestion` method, after the logging statement, add the following code:

    > **NOTE**: The following code doesn't include the entire `try` block — you will add more code in the following steps.

    ```csharp

    try
    {
        // Define the tools the AI agent can use
        var tools = new[]
        {
            AIFunctionFactory.Create(
                async ([Description("The order ID number")] int orderId) =>
                    await _agentTools.GetOrderDetailsAsync(orderId, userId),
                "get_order_details",
                "Look up the status and details of a specific order by its order number. Returns order status, items, dates, and total amount."),

            AIFunctionFactory.Create(
                async () =>
                    await _agentTools.GetUserOrdersSummaryAsync(userId),
                "get_user_orders",
                "Get a summary list of all orders for the current user. Use this when the user asks about their orders without specifying an order number."),

            AIFunctionFactory.Create(
                async (
                    [Description("The order ID number")] int orderId,
                    [Description("Optional: Specific order item IDs to return (comma-separated, e.g. '123,456'). Leave empty to return all items.")] string orderItemIds = "",
                    [Description("Optional: Quantities for each item (comma-separated, e.g. '1,2'). Must match orderItemIds count. Leave empty to return full quantity.")] string quantities = "",
                    [Description("Optional: Reason for return")] string reason = "Customer requested return via AI support agent") =>
                    await _agentTools.ProcessReturnAsync(orderId, userId, orderItemIds, quantities, reason),
                "process_return",
                "Process a return for specific items from a delivered order. Can return all items, specific items by ID, or specific quantities of items. Accepts comma-separated item IDs and quantities. Works for orders with Delivered, PartialReturn, or Returned status."),

            AIFunctionFactory.Create(
                async (
                    [Description("The order ID number")] int orderId,
                    [Description("The email message content")] string message) =>
                    await _agentTools.SendCustomerEmailAsync(orderId, userId, message),
                "send_customer_email",
                "Send a follow-up email to the customer with additional information about their order.")
        };

    ```

1. Take a minute to review the tool definitions that you just added.

    This code snippet is where the AI agent's capabilities are defined. The code uses `AIFunctionFactory` from `Microsoft.Extensions.AI` to wrap each `SupportAgentTools` method as a callable AI tool. Each call to `AIFunctionFactory.Create` wraps a `SupportAgentTools` method as a tool the AI model can invoke. For each tool, you provide:

    - A **lambda delegate** that calls the corresponding method. Notice that `userId` is captured from the outer scope so the AI model never needs to know or guess the user's identity.
    - A **tool name** (like `"get_order_details"`) that the model uses when deciding which tool to call.
    - A **description** that helps the model understand when and how to use the tool.
    - `[Description]` attributes on parameters that tell the model what values to provide.

    The `get_user_orders` tool takes no parameters from the model (the `userId` is captured automatically). The `process_return` tool has three optional parameters (`orderItemIds`, `quantities`, and `reason`) that enable partial returns by specifying which items and quantities to return (omitting them returns all items). The `send_customer_email` tool takes two model-provided parameters (`orderId` and `message`). This design keeps the user context secure while giving the model flexibility to handle various return scenarios and compose email content.

1. Just below the tool definitions, to create a Copilot SDK session with a system prompt and tools, add the following code:

    ```csharp

    // Create a Copilot session with the system prompt and tools
    await using var session = await _copilotClient.CreateSessionAsync(new SessionConfig
    {
        Model = "gpt-4.1",
        SystemMessage = new SystemMessageConfig
        {
            Mode = SystemMessageMode.Replace,
            Content = @"You are ContosoShop's AI customer support assistant. Your role is to help customers with their order inquiries.
            
                CAPABILITIES:
                - Look up order status and details using the get_order_details tool
                - List all customer orders using the get_user_orders tool
                - Process returns for delivered orders using the process_return tool (supports full or partial returns)
                - Send follow-up emails using the send_customer_email tool

                RETURN PROCESSING WORKFLOW:
                1. When customer wants to return an item, first call get_order_details to see items and their IDs
                2. Parse the customer's request carefully:
                   - Extract the product name they mentioned (e.g., 'Headphones', 'Desk Lamp', 'Monitor')
                   - Check if they specified a quantity (e.g., '1 Desk Lamp', '2 monitors', 'one laptop')
                   - Number words: 'one'=1, 'two'=2, 'three'=3, etc.
                3. From the order details returned by get_order_details, find the item(s) that match the product name:
                   - Match by ProductName field (case-insensitive, partial match is OK)
                   - AUTOMATICALLY extract the Id field from the matching OrderItem - this is the item ID you need
                   - NEVER ask the customer for an item ID - they don't have this information
                4. Determine the return quantity:
                   - If customer specified quantity in their request: use that quantity
                   - Else if remaining quantity is 1: automatically return that 1 item
                   - Else if remaining quantity is more than 1 and no quantity specified: ask how many they want to return
                5. Call process_return with the extracted item ID and quantity:
                   - Pass orderItemIds as the Id value from the OrderItem (e.g., '456')
                   - Pass quantities as the number to return (e.g., '1')
                6. After successful return, tell customer to view Order Details page to see the updated status
                
                IMPORTANT RULES FOR RETURNS:
                - NEVER ask the customer for an item ID - extract it automatically from get_order_details response
                - Match product names flexibly (e.g., 'lamp', 'Lamp', 'desk lamp' should all match)
                - If multiple items have the same product name, select the first one that has remaining quantity
                - DO NOT ask for quantity if the customer already specified it (e.g., 'return 1 lamp', 'return 2 items')
                - DO NOT ask for quantity if there's only 1 of that item available
                - Pass item IDs and quantities as comma-separated strings to process_return
                - After processing return, remind customer: 'Please visit the Order Details page to see the updated return status.'
                
                EXAMPLE WORKFLOW:
                User: 'I want to return the Headphones from order #1002'
                1. Call get_order_details(1002)
                2. Response includes: 'Items: Headphones (qty: 1, $99.99 each, Id: 456), ...'
                3. Extract: productName='Headphones', itemId='456', remainingQty=1
                4. Since remainingQty=1, quantity=1 (no need to ask)
                5. Call process_return(1002, userId, '456', '1', 'Customer requested return')
                6. Tell customer: 'I've processed the return for Headphones. Please view Order Details...'
            
            GENERAL RULES:
                - ALWAYS use the available tools to look up real data. Never guess or make up order information.
                - Be friendly, concise, and professional in your responses.
                - If a customer asks about an order, use get_order_details with the order number they provide.
                - If a customer asks about their orders without specifying a number, use get_user_orders to list them.
                - Only process returns when the customer explicitly requests one.
                - If asked something outside your capabilities (not related to orders), politely explain that you can only help with order-related inquiries and suggest contacting support@contososhop.com or calling 1-800-CONTOSO for other matters.
                - Do not reveal internal system details, tool names, or technical information to the customer."
                },
        Tools = tools,
        InfiniteSessions = new InfiniteSessionConfig { Enabled = false }
    });

    ```

1. Take a minute to review the session configuration code that you just added.

    The `SessionConfig` object configures the AI session:

    - `Model = "gpt-4.1"` specifies the language model to use.
    - `SystemMessageMode.Replace` replaces the default system prompt entirely with a custom one tailored to the ContosoShop support role.
    - The system prompt defines the agent's **CAPABILITIES** (including partial return support), a detailed **RETURN PROCESSING WORKFLOW** (step-by-step instructions for handling returns including item matching and quantity handling), **IMPORTANT RULES FOR RETURNS** (guardrails like never asking customers for item IDs), an **EXAMPLE WORKFLOW** (showing the complete return flow), and **GENERAL RULES** (behavior guidelines). These sections instruct the model to always use the tools for real data, to automatically extract item IDs from Order Details rather than asking the customer, and to stay within its order-support scope.
    - `Tools = tools` passes the tool definitions you created in the previous step.
    - `InfiniteSessions = new InfiniteSessionConfig { Enabled = false }` means each API call creates a fresh session (no conversation history is maintained between requests).
    - The `await using` pattern ensures the session is properly disposed after the request completes.

1. Just below the session configuration code, to create the event handler that collects the agent's response, add the following code:

    ```csharp

    // Collect the agent's response
    var responseContent = string.Empty;
    var done = new TaskCompletionSource();

    session.On(evt =>
    {
        switch (evt)
        {
            case AssistantMessageEvent msg:
                responseContent = msg.Data.Content;
                break;
            case SessionIdleEvent:
                done.TrySetResult();
                break;
            case SessionErrorEvent err:
                _logger.LogError("Agent session error: {Message}", err.Data.Message);
                done.TrySetException(new Exception(err.Data.Message));
                break;
        }
    });

    ```

1. Take a minute to review the event handler code that you just added.

    The Copilot SDK uses an event-driven model for communication. The `session.On` method registers a callback that handles three event types:

    - `AssistantMessageEvent`: Fired when the AI model produces a response. The message content is captured in `responseContent`.
    - `SessionIdleEvent`: Fired when the session is finished processing (including any tool calls). This signals that the response is complete by resolving the `TaskCompletionSource`.
    - `SessionErrorEvent`: Fired if something goes wrong during the session. The error is logged and propagated as an exception via `done.TrySetException`.

    The `TaskCompletionSource` pattern converts the event-driven flow into an awaitable task, allowing the controller to wait for the agent to finish before returning the HTTP response.

1. Just below the event handler code, to send the user's question, wait for the response with a timeout, and return the result, add the following code:

    ```csharp

    // Send the user's question
    await session.SendAsync(new MessageOptions { Prompt = query.Question });

    // Wait for the response with a timeout
    var timeoutTask = Task.Delay(TimeSpan.FromSeconds(30));
    var completedTask = await Task.WhenAny(done.Task, timeoutTask);

    if (completedTask == timeoutTask)
    {
        _logger.LogWarning("Agent session timed out for user {UserId}", userId);
        return Ok(new SupportResponse
        {
            Answer = "I'm sorry, the request took too long. Please try again or contact our support team."
        });
    }

    // Rethrow if the task faulted
    await done.Task;

    _logger.LogInformation("Agent response for user {UserId}: {Answer}", userId, responseContent);

    return Ok(new SupportResponse { Answer = responseContent });

    ```

1. Take a minute to review the code that manages communication with the AI agent.

    This code sends the customer's question and handles the asynchronous response:

    - `session.SendAsync` dispatches the user's question to the AI model, which may invoke zero or more tools before composing a final response.
    - A **30-second timeout** protects against long-running requests. If the agent takes too long (for example, due to multiple tool calls or network delays), the user gets a friendly timeout message rather than the request hanging indefinitely.
    - `Task.WhenAny` races the agent's completion against the timeout. If the `done.Task` completes first, `await done.Task` is called again to propagate any exception that might have been set by `SessionErrorEvent`.
    - The successful response is wrapped in a `SupportResponse` DTO and returned as HTTP 200.

1. Just below the code that manages communication with the AI agent, to complete the `try-catch` block, add the following code:

    ```csharp

    }

    catch (Exception ex)
    {
        _logger.LogError(ex, "Error processing support agent query for user {UserId}", userId);
        return StatusCode(500, new SupportResponse
        {
            Answer = "I'm sorry, I encountered an error processing your request. Please try again or contact our support team at support@contososhop.com."
        });
    }

    ```

1. Take a minute to review the error handling code in the `catch` block.

    The `catch` block provides a safety net for any unhandled exceptions—including errors from the Copilot SDK, tool execution failures, or network issues. Rather than exposing a raw error to the customer, it logs the full exception for debugging and returns a friendly error message with a fallback contact option. This error handling ensures the API always returns a valid `SupportResponse` regardless of what goes wrong internally.

1. Your completed **SupportAgentController.cs** file should look like the following code:

    ```csharp
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.AI;
    using GitHub.Copilot.SDK;
    using ContosoShop.Server.Services;
    using ContosoShop.Shared.Models;
    using System.ComponentModel;
    using System.Security.Claims;
    
    namespace ContosoShop.Server.Controllers;
    
    /// <summary>
    /// API controller that handles AI support agent queries.
    /// Accepts user questions, creates a Copilot SDK session with custom tools,
    /// and returns the agent's response.
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class SupportAgentController : ControllerBase
    {
        private readonly CopilotClient _copilotClient;
        private readonly SupportAgentTools _agentTools;
        private readonly ILogger<SupportAgentController> _logger;
    
        public SupportAgentController(
            CopilotClient copilotClient,
            SupportAgentTools agentTools,
            ILogger<SupportAgentController> logger)
        {
            _copilotClient = copilotClient;
            _agentTools = agentTools;
            _logger = logger;
        }
    
        /// <summary>
        /// Accepts a support question from the user and returns the AI agent's response.
        /// POST /api/supportagent/ask
        /// </summary>
        [HttpPost("ask")]
        public async Task<IActionResult> AskQuestion([FromBody] SupportQuery query)
        {
            if (query == null || string.IsNullOrWhiteSpace(query.Question))
            {
                return BadRequest(new SupportResponse { Answer = "Please enter a question." });
            }
    
            // Get the authenticated user's ID from claims
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (!int.TryParse(userIdClaim, out int userId))
            {
                return Unauthorized(new SupportResponse { Answer = "Unable to identify user." });
            }
    
            _logger.LogInformation("Support agent query from user {UserId}: {Question}", userId, query.Question);
    
            try
            {
                // Define the tools the AI agent can use
                var tools = new[]
                {
                AIFunctionFactory.Create(
                    async ([Description("The order ID number")] int orderId) =>
                        await _agentTools.GetOrderDetailsAsync(orderId, userId),
                    "get_order_details",
                    "Look up the status and details of a specific order by its order number. Returns order status, items, dates, and total amount."),
    
                AIFunctionFactory.Create(
                    async () =>
                        await _agentTools.GetUserOrdersSummaryAsync(userId),
                    "get_user_orders",
                    "Get a summary list of all orders for the current user. Use this when the user asks about their orders without specifying an order number."),
    
                AIFunctionFactory.Create(
                    async (
                        [Description("The order ID number")] int orderId,
                        [Description("Optional: Specific order item IDs to return (comma-separated, e.g. '123,456'). Leave empty to return all items.")] string orderItemIds = "",
                        [Description("Optional: Quantities for each item (comma-separated, e.g. '1,2'). Must match orderItemIds count. Leave empty to return full quantity.")] string quantities = "",
                        [Description("Optional: Reason for return")] string reason = "Customer requested return via AI support agent") =>
                        await _agentTools.ProcessReturnAsync(orderId, userId, orderItemIds, quantities, reason),
                    "process_return",
                    "Process a return for specific items from a delivered order. Can return all items, specific items by ID, or specific quantities of items. Accepts comma-separated item IDs and quantities. Works for orders with Delivered, PartialReturn, or Returned status."),

    
                AIFunctionFactory.Create(
                    async (
                        [Description("The order ID number")] int orderId,
                        [Description("The email message content")] string message) =>
                        await _agentTools.SendCustomerEmailAsync(orderId, userId, message),
                    "send_customer_email",
                    "Send a follow-up email to the customer with additional information about their order.")
            };
    
                // Create a Copilot session with the system prompt and tools
                await using var session = await _copilotClient.CreateSessionAsync(new SessionConfig
                {
                    Model = "gpt-4.1",
                    SystemMessage = new SystemMessageConfig
                    {
                        Mode = SystemMessageMode.Replace,
                        Content = @"You are ContosoShop's AI customer support assistant. Your role is to help customers with their order inquiries.
                
                    CAPABILITIES:
                    - Look up order status and details using the get_order_details tool
                    - List all customer orders using the get_user_orders tool
                    - Process returns for delivered orders using the process_return tool (supports full or partial returns)
                    - Send follow-up emails using the send_customer_email tool

                    RETURN PROCESSING WORKFLOW:
                    1. When customer wants to return an item, first call get_order_details to see items and their IDs
                    2. Parse the customer's request carefully:
                       - Extract the product name they mentioned (e.g., 'Headphones', 'Desk Lamp', 'Monitor')
                       - Check if they specified a quantity (e.g., '1 Desk Lamp', '2 monitors', 'one laptop')
                       - Number words: 'one'=1, 'two'=2, 'three'=3, etc.
                    3. From the order details returned by get_order_details, find the item(s) that match the product name:
                       - Match by ProductName field (case-insensitive, partial match is OK)
                       - AUTOMATICALLY extract the Id field from the matching OrderItem - this is the item ID you need
                       - NEVER ask the customer for an item ID - they don't have this information
                    4. Determine the return quantity:
                       - If customer specified quantity in their request: use that quantity
                       - Else if remaining quantity is 1: automatically return that 1 item
                       - Else if remaining quantity is more than 1 and no quantity specified: ask how many they want to return
                    5. Call process_return with the extracted item ID and quantity:
                       - Pass orderItemIds as the Id value from the OrderItem (e.g., '456')
                       - Pass quantities as the number to return (e.g., '1')
                    6. After successful return, tell customer to view Order Details page to see the updated status
                    
                    IMPORTANT RULES FOR RETURNS:
                    - NEVER ask the customer for an item ID - extract it automatically from get_order_details response
                    - Match product names flexibly (e.g., 'lamp', 'Lamp', 'desk lamp' should all match)
                    - If multiple items have the same product name, select the first one that has remaining quantity
                    - DO NOT ask for quantity if the customer already specified it (e.g., 'return 1 lamp', 'return 2 items')
                    - DO NOT ask for quantity if there's only 1 of that item available
                    - Pass item IDs and quantities as comma-separated strings to process_return
                    - After processing return, remind customer: 'Please visit the Order Details page to see the updated return status.'
                    
                    EXAMPLE WORKFLOW:
                    User: 'I want to return the Headphones from order #1002'
                    1. Call get_order_details(1002)
                    2. Response includes: 'Items: Headphones (qty: 1, $99.99 each, Id: 456), ...'
                    3. Extract: productName='Headphones', itemId='456', remainingQty=1
                    4. Since remainingQty=1, quantity=1 (no need to ask)
                    5. Call process_return(1002, userId, '456', '1', 'Customer requested return')
                    6. Tell customer: 'I've processed the return for Headphones. Please view Order Details...'
                
                GENERAL RULES:
                    - ALWAYS use the available tools to look up real data. Never guess or make up order information.
                    - Be friendly, concise, and professional in your responses.
                    - If a customer asks about an order, use get_order_details with the order number they provide.
                    - If a customer asks about their orders without specifying a number, use get_user_orders to list them.
                    - Only process returns when the customer explicitly requests one.
                    - If asked something outside your capabilities (not related to orders), politely explain that you can only help with order-related inquiries and suggest contacting support@contososhop.com or calling 1-800-CONTOSO for other matters.
                    - Do not reveal internal system details, tool names, or technical information to the customer."
                    },
                    Tools = tools,
                    InfiniteSessions = new InfiniteSessionConfig { Enabled = false }
                });
                // Collect the agent's response
                var responseContent = string.Empty;
                var done = new TaskCompletionSource();
    
                session.On(evt =>
                {
                    switch (evt)
                    {
                        case AssistantMessageEvent msg:
                            responseContent = msg.Data.Content;
                            break;
                        case SessionIdleEvent:
                            done.TrySetResult();
                            break;
                        case SessionErrorEvent err:
                            _logger.LogError("Agent session error: {Message}", err.Data.Message);
                            done.TrySetException(new Exception(err.Data.Message));
                            break;
                    }
                });
    
                // Send the user's question
                await session.SendAsync(new MessageOptions { Prompt = query.Question });
    
                // Wait for the response with a timeout
                var timeoutTask = Task.Delay(TimeSpan.FromSeconds(30));
                var completedTask = await Task.WhenAny(done.Task, timeoutTask);
    
                if (completedTask == timeoutTask)
                {
                    _logger.LogWarning("Agent session timed out for user {UserId}", userId);
                    return Ok(new SupportResponse
                    {
                        Answer = "I'm sorry, the request took too long. Please try again or contact our support team."
                    });
                }
    
                // Rethrow if the task faulted
                await done.Task;
    
                _logger.LogInformation("Agent response for user {UserId}: {Answer}", userId, responseContent);
    
                return Ok(new SupportResponse { Answer = responseContent });
    
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error processing support agent query for user {UserId}", userId);
                return StatusCode(500, new SupportResponse
                {
                    Answer = "I'm sorry, I encountered an error processing your request. Please try again or contact our support team at support@contososhop.com."
                });
            }
        }
    }
    ```

    Your completed **SupportAgentController.cs** file has the following structure:

    - The `using` statements and namespace at the top
    - The `SupportAgentController` class with `[ApiController]`, `[Route]`, and `[Authorize]` attributes
    - A constructor injecting `CopilotClient`, `SupportAgentTools`, and `ILogger`
    - A single `AskQuestion` action method (`[HttpPost("ask")]`) that:
      - Validates the input and extracts the user ID
      - Defines four AI tools using `AIFunctionFactory.Create`
      - Creates a Copilot session with a system prompt and tools
      - Registers event handlers for response, idle, and error events
      - Sends the question and awaits the response with a 30-second timeout
      - Returns the response or appropriate error messages

1. Open the **ContosoShop.Server/Program.cs** file.

1. Locate the code that configures CORS policies.

    You can search for the following code comment: `// Configure CORS`.

1. Notice that the CORS configuration section allows the `GET` and `POST` methods required by the API endpoint you just created.

   The existing configuration allows `GET` and `POST` methods, which is sufficient.

    ```csharp
    .WithMethods("GET", "POST") // Only required methods
    ```

1. To build the project, enter the following command in the terminal:

    ```powershell
    dotnet build
    ```

    The build should succeed without errors. If you see errors related to `GitHub.Copilot.SDK` types, verify that the NuGet package was installed correctly.

## Update the Blazor frontend to interact with the agent

In this task, you create a client-side service to call the agent API and update the Support.razor page with an interactive chat interface.

Use the following steps to complete this task:

1. In Visual Studio Code's EXPLORER view, right-click the **ContosoShop.Client/Services** folder, and then select **New File**.

1. Name the file **SupportAgentService.cs**.

1. Add the following code:

    ```csharp
    using System.Net.Http.Json;
    using ContosoShop.Shared.Models;

    namespace ContosoShop.Client.Services;

    /// <summary>
    /// Client-side service for communicating with the AI support agent API.
    /// </summary>
    public class SupportAgentService
    {
        private readonly HttpClient _http;

        public SupportAgentService(HttpClient http)
        {
            _http = http;
        }

        /// <summary>
        /// Sends a question to the AI support agent and returns the response.
        /// </summary>
        /// <param name="question">The user's question</param>
        /// <returns>The agent's response text</returns>
        public async Task<string> AskAsync(string question)
        {
            var query = new SupportQuery { Question = question };

            var response = await _http.PostAsJsonAsync("api/supportagent/ask", query);

            if (!response.IsSuccessStatusCode)
            {
                var errorText = await response.Content.ReadAsStringAsync();
                throw new HttpRequestException(
                    $"Support agent returned {response.StatusCode}: {errorText}");
            }

            var result = await response.Content.ReadFromJsonAsync<SupportResponse>();
            return result?.Answer ?? "I'm sorry, I didn't receive a response. Please try again.";
        }
    }
    ```

1. Take a minute to review the `SupportAgentService` code.

    This code snippet is a client-side HTTP service that interfaces with the AI support agent backend. Key features:

    Simple API Wrapper:

    - Single method AskAsync(string question) - sends user questions to the support agent API endpoint
    - Posts to POST /api/supportagent/ask on the server

    Communication Handling:

    - Wraps the question in a SupportQuery DTO
    - Uses HttpClient.PostAsJsonAsync for automatic JSON serialization
    - Deserializes the response into a SupportResponse object

    Error Management:

    - Checks HTTP status codes for failures
    - Throws HttpRequestException with detailed error information on nonsuccess responses
    - Provides fallback message if response parsing fails

    Design Pattern:

    - Thin client wrapper following the service layer pattern
    - Injected HttpClient for testability and proper lifetime management
    - Used by Blazor components (like Support.razor) to interact with the AI agent without handling HTTP details directly

    This service abstracts away the HTTP communication complexity, providing a clean interface for Blazor components to ask questions to the AI support agent.

1. Open the **ContosoShop.Client/Program.cs** file.

1. Locate the service registration section of the file.

    You can search for `// Register application services`

1. Create a blank code line below the existing service registrations, and then add the following code:

    ```csharp

    // Register AI support agent service
    builder.Services.AddScoped<SupportAgentService>(sp =>
        new SupportAgentService(sp.GetRequiredService<HttpClient>()));

    ```

    This code registers the `SupportAgentService` as a scoped service in Blazor's dependency injection container, allowing it to be injected into components. The `HttpClient` is injected into the service constructor, ensuring proper lifetime management and configuration. The `using ContosoShop.Client.Services;` statement should already be present at the top of the file.

1. Save the file.

1. Open the **ContosoShop.Client/Pages/Support.razor** file.

    You replace the existing content of this file to create a new support chat interface that interacts with the AI agent.

1. Select and then delete the existing content of the file.

1. To begin the construction of the new file, add the following code:

    > **NOTE**: You'll build the Support.razor file in stages. Don't autoformat (Format Document) the file until you've added all the code snippets.

    ```cshtml
    @page "/support"
    @using ContosoShop.Shared.Models
    @using ContosoShop.Client.Services
    @attribute [Microsoft.AspNetCore.Authorization.Authorize]
    @inject SupportAgentService AgentService

    <PageTitle>Contact Support - ContosoShop Support Portal</PageTitle>

    <div class="container mt-4">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <h2 class="mb-4">Contact Support</h2>

                <!-- AI Chat Card -->
                <div class="card mb-4 border-info">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">
                            <i class="bi bi-robot me-2"></i>AI Chat Support
                        </h5>
                    </div>
                    <div class="card-body">
                        <!-- Chat Messages Area -->
                        <div class="border rounded p-3 mb-3" style="min-height: 300px; max-height: 500px; overflow-y: auto;" id="chatMessages">
                            @if (!conversations.Any())
                            {
                                <div class="text-center text-muted py-4">
                                    <i class="bi bi-chat-dots display-4 mb-2"></i>
                                    <p>Ask me about your orders! For example:</p>
                                    <ul class="list-unstyled">
                                        <li><em>"What is the status of order #1001?"</em></li>
                                        <li><em>"Show me all my orders"</em></li>
                                        <li><em>"I want to return order #1005"</em></li>
                                    </ul>
                                </div>
                            }
                            @foreach (var entry in conversations)
                            {
                                <div class="mb-3">
                                    <div class="d-flex align-items-start mb-1">
                                        <span class="badge bg-primary me-2">You</span>
                                        <span>@entry.Question</span>
                                    </div>
                                    @if (!string.IsNullOrEmpty(entry.Answer))
                                    {
                                        <div class="d-flex align-items-start ms-2">
                                            <span class="badge bg-info me-2">Agent</span>
                                            <span style="white-space: pre-line;">@entry.Answer</span>
                                        </div>
                                    }
                                </div>
                            }
                            @if (isLoading)
                            {
                                <div class="d-flex align-items-start ms-2">
                                    <span class="badge bg-info me-2">Agent</span>
                                    <span class="text-muted"><em>Thinking...</em></span>
                                </div>
                            }
                        </div>

    ```

1. Take a minute to review the HTML code that you just added.

    This first section establishes the page structure:

    - The `@page "/support"` directive maps this component to the `/support` URL route.
    - The `@attribute [Authorize]` ensures only authenticated users can access the page.
    - The `@inject SupportAgentService AgentService` injects the client-side service you created in the previous step, giving the page access to the AI agent API.
    - The chat messages area is a scrollable `div` (300-500px height) that displays the conversation history. When there are no messages yet, it shows helpful example prompts to guide the user. Each conversation entry shows the user's question with a "You" badge and the agent's response with an "Agent" badge. The `white-space: pre-line` style preserves line breaks in the agent's responses (for example, when listing multiple orders). A "Thinking..." indicator appears while the agent is processing a request.

1. After the chat messages area `</div>`, to add the input area and close the AI Chat card, enter the following code:

    ```cshtml

            <!-- Input Area -->
            <div class="input-group">
                <input type="text"
                        class="form-control"
                        placeholder="Type your question..."
                        @bind="currentQuestion"
                        @bind:event="oninput"
                        @onkeydown="HandleKeyDown"
                        disabled="@isLoading" />
                <button class="btn btn-info text-white"
                        @onclick="SubmitQuestion"
                        disabled="@(isLoading || string.IsNullOrWhiteSpace(currentQuestion))">
                    <i class="bi bi-send me-1"></i>Send
                </button>
            </div>

            @if (!string.IsNullOrEmpty(errorMessage))
            {
                <div class="alert alert-danger mt-2 mb-0">
                    <i class="bi bi-exclamation-triangle me-1"></i>@errorMessage
                </div>
            }
        </div>
    </div>

    ```

1. Take a minute to review the input area code that you just added.

    The input area uses Bootstrap's `input-group` for a clean text field with attached send button. Key interaction details:

    - `@bind="currentQuestion"` with `@bind:event="oninput"` provides real-time two-way binding — the `currentQuestion` variable updates as the user types (not just on blur).
    - `@onkeydown="HandleKeyDown"` enables the Enter key shortcut for submitting questions.
    - Both the input and button are disabled while `isLoading` is true, preventing duplicate submissions during agent processing.
    - The button is also disabled when the input is empty (`string.IsNullOrWhiteSpace(currentQuestion)`).
    - An error alert conditionally appears below the input when `errorMessage` is set, providing user-friendly feedback if something goes wrong.

1. After the AI Chat card, to add the Contact Information card, enter the following code:

    ```cshtml

    <!-- Contact Information Card -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">
                <i class="bi bi-headset me-2"></i>Get in Touch
            </h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <h6 class="text-muted">Email Support</h6>
                    <p class="mb-0">
                        <i class="bi bi-envelope me-2"></i>
                        <a href="mailto:support@contososhop.com">support@contososhop.com</a>
                    </p>
                    <small class="text-muted">Response time: 24-48 hours</small>
                </div>
                <div class="col-md-6 mb-3">
                    <h6 class="text-muted">Phone Support</h6>
                    <p class="mb-0">
                        <i class="bi bi-telephone me-2"></i>
                        <a href="tel:1-800-266-8676">1-800-CONTOSO</a>
                    </p>
                    <small class="text-muted">Mon-Fri 9AM-5PM EST</small>
                </div>
            </div>
        </div>
    </div>

    ```

1. Take a minute to review the Contact Information card code that you just added.

    This card provides traditional contact methods as a fallback when the AI agent can't fully resolve a customer's issue. The two-column layout (using Bootstrap's grid) shows email and phone support side by side on medium+ screens, each with response time expectations. This is consistent with the system prompt you configured earlier, which tells the AI agent to direct customers to `support@contososhop.com` or `1-800-CONTOSO` for nonorder matters.

1. After the Contact Information card, to add the Quick Links card and the closing `</div>` tags for the page layout, enter the following code:

    ```cshtml

                <!-- Quick Links -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="bi bi-question-circle me-2"></i>Need Help With Your Order?
                        </h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mb-0">
                            <li class="mb-2">
                                <a href="/orders" class="text-decoration-none">
                                    <i class="bi bi-box-seam me-2"></i>View Your Orders
                                </a>
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-arrow-return-left me-2"></i>
                                <span>Return a delivered order from the Order Details page</span>
                            </li>
                            <li class="mb-0">
                                <i class="bi bi-info-circle me-2"></i>
                                <span>Track shipment status and delivery updates</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    ```

1. Take a minute to review the Quick Links card code that you just added.

    The Quick Links card provides navigation shortcuts to other parts of the application. The "View Your Orders" link navigates to the `/orders` page where customers can see their full order list. The remaining items describe self-service actions available elsewhere in the app. The three closing `</div>` tags close the `col-lg-8`, `row`, and `container` elements that wrap the entire page layout.

1. On a line below the HTML code, to add the `@code` block that contains the component's state management and event handling logic, enter the following code:

    ```cshtml

    @code {
        private class ConversationEntry
        {
            public string Question { get; set; } = string.Empty;
            public string Answer { get; set; } = string.Empty;
        }

        private List<ConversationEntry> conversations = new();
        private string currentQuestion = string.Empty;
        private bool isLoading = false;
        private string errorMessage = string.Empty;

        private async Task HandleKeyDown(KeyboardEventArgs e)
        {
            if (e.Key == "Enter" && !isLoading && !string.IsNullOrWhiteSpace(currentQuestion))
            {
                await SubmitQuestion();
            }
        }

        private async Task SubmitQuestion()
        {
            if (string.IsNullOrWhiteSpace(currentQuestion) || isLoading)
                return;

            errorMessage = string.Empty;
            var question = currentQuestion.Trim();
            currentQuestion = string.Empty;

            var entry = new ConversationEntry { Question = question };
            conversations.Add(entry);

            try
            {
                isLoading = true;
                StateHasChanged();

                var answer = await AgentService.AskAsync(question);
                entry.Answer = answer;
            }
            catch (Exception ex)
            {
                errorMessage = "Sorry, something went wrong. Please try again or contact our support team.";
                Console.Error.WriteLine($"Agent error: {ex.Message}");
            }
            finally
            {
                isLoading = false;
                StateHasChanged();
            }
        }
    }
    ```

1. Take a minute to review the `@code` block you just added.

    The `@code` block contains all of the component's logic:

    - `ConversationEntry` is a simple inner class that pairs each user question with the agent's answer, forming the chat history.
    - The component state consists of four fields: `conversations` (the full chat history), `currentQuestion` (the text input binding), `isLoading` (prevents duplicate submissions and shows the "Thinking..." indicator), and `errorMessage` (displays errors below the input).
    - `HandleKeyDown` enables submitting questions by pressing Enter—it checks the same guards as the send button (not loading, not empty).
    - `SubmitQuestion` orchestrates the full send flow: it clears the error state, captures and clears the input text, adds a new conversation entry immediately (so the user's question appears right away), then calls `AgentService.AskAsync` to get the agent's response. The `StateHasChanged()` calls force Blazor to re-render the UI—once when "Thinking..." appears and again when the response arrives or an error occurs. The `try/finally` pattern ensures `isLoading` is always reset, even if the API call fails.

1. Verify that your completed **Support.razor** file has the following structure:

    - Page directives (`@page`, `@using`, `@attribute`, `@inject`) at the top
    - A container layout with a centered column
    - Three cards: AI Chat Support (with messages area, input area, and error display), Contact Information (email and phone), and Quick Links (navigation shortcuts)
    - An `@code` block with `ConversationEntry` class, state fields, `HandleKeyDown`, and `SubmitQuestion` methods

1. Open the ContosoShop.Server directory in the terminal, and then enter the following command:

    ```powershell
    dotnet build
    ```

    The build should succeed without errors.

## Test the end-to-end AI agent experience

In this task, you run the application and test the AI agent with various support queries to verify it functions correctly.

Use the following steps to complete this task:

1. To start the server application from the terminal, enter the following command:

    ```powershell
    dotnet run
    ```

    Watch the console output for any errors during startup. You should see the application listening on an HTTP port.

    If you see errors, verify that you completed each step in the previous tasks and that you entered the code correctly. If you still have errors after verifying your code, you can point GitHub Copilot to the GitHub Copilot SDK repository (`https://github.com/github/copilot-sdk`) and ask the AI assistant to help you debug the issues.

1. Open a browser and navigate to the specified HTML port.

    For example, you might see output like `Now listening on: http://localhost:5266`. In that case, open `http://localhost:5266` in a browser window. You should see the ContosoShop E-commerce Support Portal login page.

1. Log in with the demo credentials for Mateo.

    Enter `mateo@contoso.com` for the email and `Password123!` for the password, and then select **Login**.

1. Navigate to the **Contact Support** page.

1. Take a moment to review the page.

    You should now see the interactive AI Chat Support interface instead of the "Coming Soon" placeholder. The chat area displays example prompts to help you get started.

1. To test the agent's ability to **Check order status**, enter the following prompt and select **Send** (or press Enter):

    ```plaintext
    What's the status of order #1001?
    ```

    The agent should respond with details about order #1001, such as the delivery date and the items delivered. The response should reflect the actual data in the database.

    Verify the response matches what you see on the Orders page for order #1001.

1. To test the agent's ability to **List all orders**, enter the following prompt:

    ```plaintext
    Show me all my orders
    ```

    The agent should use the `get_user_orders` tool and return a summary list of all 10 of Mateo's orders with their statuses and amounts.

1. To test the agent's ability to **Process a return**, enter the following prompt:

    ```plaintext
    I want to return order #1008
    ```

    The agent should process the return for order #1008 (which was Delivered) and confirm the refund amount.

    After the AI response is displayed:

    - Navigate to the **Orders** page and verify that order #1008 now shows a "Returned" status.

1. To test the agent's ability to **Process a return for a single item within an order**, enter the following prompt:

    ```plaintext
    I want to return 1 Desk Lamp from order #1005
    ```

    The agent should process the return for the specified item within order #1005 and confirm the refund amount.

    After the AI response is displayed:

    - Navigate to the **Orders** page and verify that order #1005 now shows a "Partial Return" status.
    - Open the order details for order #1005 and verify that a "Returned" status is shown for one Desk Lamp.

1. To test the agent's ability to **Handle an order that can't be returned**, enter the following prompt:

    ```plaintext
    I want to return order #1010.
    ```

    Order #1010 has "Processing" status and can't be returned. The agent should explain that the order must be delivered before it can be returned.

1. To test the agent's ability to **Handle a non-existent order**, enter the following prompt:

    ```plaintext
    Where is my order #9999?
    ```

    The agent should respond that it couldn't find order #9999 associated with the user's account.

1. To test the agent's ability to **Handle an off-topic question**, enter the following prompt:

    ```plaintext
    What's the weather like today?
    ```

    The agent should politely explain that it can only help with order-related inquiries and suggest contacting support through other channels.

1. When you're done testing, return to the terminal and press **Ctrl+C** to stop the application.

## Summary

In this exercise, you successfully integrated an AI-powered customer support agent into the ContosoShop E-commerce Support Portal using the GitHub Copilot SDK. You:

- **Created backend tools** (`SupportAgentTools`) that the AI agent can invoke to look up orders and process returns, using the existing application services.
- **Configured the Copilot SDK** with a `CopilotClient` singleton and created sessions with a custom system prompt and tool definitions using `AIFunctionFactory.Create`.
- **Built an API endpoint** (`SupportAgentController`) that accepts user questions, creates agent sessions, and returns AI-generated responses.
- **Updated the Blazor frontend** with an interactive chat interface on the Support page.
- **Tested the integration** with real-world scenarios including order lookups, returns, error handling, and off-topic deflection.

This pattern—defining business logic as tools, registering them with an AI agent runtime, and exposing the agent via an API—is applicable to many domains beyond e-commerce support. You can apply the same approach to IT helpdesk automation, CRM assistants, or any scenario where an AI agent needs to take actions on behalf of users.

## Clean up

Now that you've finished the exercise, take a minute to clean up your environment:

- Stop the server application if it's still running (press **Ctrl+C** in the terminal).
- Ensure that you haven't made changes to your GitHub account or GitHub Copilot subscription that you don't want to keep.
- Optionally archive or delete the local clone of the repository.
