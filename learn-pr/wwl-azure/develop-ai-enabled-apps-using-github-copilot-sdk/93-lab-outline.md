# Lab Exercise: Integrate an AI Agent into the E-commerce Support Portal

## Lab Title: Intelligent Customer Support Agent Integration with GitHub Copilot SDK

### Lab Objective

In this lab, you will enhance the ContosoShop E-commerce Support Portal by integrating an AI-powered support agent using the GitHub Copilot SDK. By the end, the "Contact Support" page will allow a user to ask questions (e.g., "Where is my order?" or "I need to return my order") and receive helpful, automated answers or actions from an AI agent. The agent will use the backend's capabilities (like checking order status or initiating a return) to resolve queries. This will give you hands-on experience in defining AI agent skills (tools), using the Copilot SDK in an ASP.NET Core environment, and updating a Blazor UI to interact with the agent.

The lab is broken into sequential tasks, each building on the previous:

1. Project Setup & Prerequisites – Ensure the base app runs and required tools are installed.
2. Define the AI Agent's Role and Tools – Decide what the agent should do and identify the functions (tools) needed (planning stage).
3. Implement Backend Tools for the Agent – Create the functions in the Web API that will serve as the agent's actions (GetOrderDetails, ProcessRefund, SendCustomerEmail).
4. Register and Configure the Copilot SDK Agent – Initialize the Copilot SDK in the backend, define the agent's persona/goal, and register the functions from step 3 as tools available to the agent.
5. Expose an Agent API Endpoint – Create a new API endpoint that the frontend can call, which sends the user's query to the Copilot agent and returns the agent's response.
6. Update the Blazor Frontend for Agent Chat – Build a simple chat interface on the Contact Support page for users to submit questions and view the AI agent's answers in real-time.
7. Test the End-to-End Experience – Run the application, try various support queries, and observe the agent performing tasks (like checking order status or processing a return).
8. (Optional) Add Logging and Telemetry – Implement logging for agent interactions and discuss how this would be monitored in a production environment (optional but good practice).

Throughout the lab, we will highlight why each step is done and how it leverages the base app's design. By the end, you'll not only have a working AI agent in the app, but also a clear understanding of the underlying integration pattern which you can apply to other use cases.

## Before You Begin – Prerequisites & Setup

**Azure Simulator & Credentials:** This lab does not require an Azure subscription; everything runs locally. However, you do need access to the GitHub Copilot SDK (Technical Preview) and a GitHub account with Copilot access. Ensure you have:

- GitHub Copilot enabled on your account and the GitHub Copilot CLI/SDK technical preview access. (Sign up was through GitHub – if you have access, you can use the github-copilot-cli or SDK packages.)
- Node.js 16+ if using the Copilot CLI daemon (for the SDK to work locally). But in .NET, the SDK can connect directly; we will use the NuGet package approach.

**Development Environment:** Make sure you have .NET 8 SDK installed. Use `dotnet --version` to confirm (should be 8.x). You will be working in Visual Studio Code or Visual Studio 2022 – either is fine. VS Code with the C# extension is lightweight and works well, and if you installed the GitHub Copilot VSCode extension, that's fine but not required for the SDK usage. Also, ensure the solution is open and you can run the base app (as verified in previous steps). If not already done, run the application and verify that you can view the Orders and Support page without errors.

**GitHub Copilot SDK Package:** The .NET SDK is provided as a NuGet package (for example, GitHub.Copilot.SDK). In this lab, you'll add this package to the Server project. (You do not need it on the Client project, since the agent runs on the server side.) Important: The Copilot SDK might be in a private NuGet feed (depending on the preview distribution). If so, instructions will be provided on how to authenticate and install it. For our lab scenario, assume you have a way to add it – either by a provided local package or a feed. The package version we use is the latest preview (for example, "0.5.0-preview" – actual version may vary).

**Familiarity Recap:** This lab will involve writing C# code in the backend and frontend. Familiarize with where things are:

- Open OrderController.cs (or OrderService.cs) to recall how returns are handled.
- Open Support.razor to see the placeholder for contact support.
- You'll be adding new files (possibly for agent configuration) and modifying existing ones. It's a good idea to create a new git branch or backup before proceeding, so you can compare changes later.

Now, let's dive into the tasks.

## Task 1: Define the Agent's Role and Tools (Planning)

Before coding, it's crucial to plan what tasks the AI agent will handle and what backend capabilities (tools) it needs to accomplish them. From the scenario and the base features, we identify the following:

**Agent's Role (Persona):** The agent will act as an automated customer support assistant for ContosoShop. It should be able to answer questions about order status and perform order-related actions (like initiating a return). It will communicate in a friendly, concise manner as a customer service representative. We will encode this role in the agent's system prompt.

**Common User Queries to Support:**

a. "Where is my order [#]?" – The user wants to know the status of a specific order (maybe they provide an order number or whether it's shipped/delivered). The agent should fetch the latest status and respond, e.g., "Your order #1002 was shipped on March 1 and is in transit. Expected delivery: March 5."

b. "I want to return my [item/order]." – The user received an order and wants to return it. The agent should confirm eligibility (is it delivered? within allowed window), then process the return (update status, and confirm refund initiation), and respond with confirmation: "I've processed a return for order #1001. You will receive a refund of $59.99 to your card within 5-7 days."

c. General question like "How do I contact support?" – The agent can handle or deflect these (in this case, it is the support, so it might say "You can ask me any question about your orders, or email support@contososhop.com for other inquiries.").

d. If asked something outside its scope (e.g., "Can I buy a new laptop from you?" which is a sales question not support, or "Tell me a joke"), the agent should politely say it's focused on support issues – we will include instructions to handle unsupported queries by deflecting (or maybe a simple "I'm here to help with order issues.").

**Tools Needed:** Based on the above queries, the agent will need to perform actions on the server:

a. **GetOrderDetails (Order Lookup)** – Given an order ID (or perhaps if user doesn't specify, the agent could assume the latest order), retrieve the order status and key info (delivery date, etc.). This maps to functionality already in the app (OrderService can get order by ID). We will implement a tool function GetOrderDetails(orderId) that returns a summary of the order's status. It might return a text like "Order 1002 is shipped (expected March 5)." or a structured object we can format.

b. **ProcessRefund (Initiate Return)** – Given an order ID, mark it returned and log the refund. The app already has an API endpoint for this; we can call the same logic. We'll implement a tool ProcessRefund(orderId) that wraps the existing return functionality but tailored for agent use (it might directly call OrderService.ProcessReturn and EmailService). It should return a confirmation message or data for the agent to tell the user.

c. **SendCustomerEmail (Email Confirmation)** – Although the ProcessRefund logic already triggers an email via EmailService, we might want a tool that explicitly allows the agent to send a follow-up email. However, since the agent is conversing directly, it may not need to send a separate email in this context (the user gets immediate answer). We might use this tool if we wanted the agent to be able to send transcripts or additional info by email. For completeness (as originally planned), we will create a SendCustomerEmail(orderId, message) tool. In this lab, the agent might not call it spontaneously, but we include it to demonstrate multi-step capabilities (e.g., agent could confirm "I have emailed you the return shipping label." if we had that use-case).

d. Potentially, **LookupLatestOrder** – If a user asks "Where is my order?" without specifying which, the agent could check if the user has any pending orders and respond about the latest. We can handle this within GetOrderDetails by some convention (like if orderId not provided, use latest). For simplicity, we assume queries will mention an order number or the agent will ask which order if ambiguous. We won't implement a separate tool; we'll just note this scenario.

**Agent Knowledge and Context:** The agent can get order info via tools, but it also needs to know the user's identity or which orders to search. Since our app currently operates in a single-user context, the agent can assume it's always dealing with John Doe's orders (no need to distinguish user ID). We will ensure the tools fetch data for the demo user. In a multi-user scenario, we'd pass the user's ID to the agent's context securely (not done here due to single-user assumption).

**Safety and Bounds:** The agent should not do anything outside these tools (we won't give it database write access except through ProcessRefund, and that has checks). We will explicitly restrict it to only the tools we define. The Copilot SDK ensures the agent can't call arbitrary code – it can only invoke registered functions. We'll reinforce in the prompt that it should stick to order questions. This covers our bases so it doesn't attempt something weird (like "delete order" – we aren't giving it such a tool).

We have our plan: the primary tools to implement are **GetOrderDetails**, **ProcessRefund**, and possibly **SendCustomerEmail** for completeness.

Before moving on: Open the Server project in your IDE. You will be adding these as methods. One approach is to create a dedicated class for agent tools, e.g., SupportAgentService. But since some logic is in OrderService, you could also integrate there. To keep things organized, we'll make a new class SupportAgent (or similar) that hosts these tool methods as static or instance methods. The Copilot SDK will need either delegate functions or methods to call; we'll register them in Program or Startup.

Now let's proceed to implement.

## Task 2: Implement Backend Tools (GetOrderDetails, ProcessRefund, SendCustomerEmail)

In this task, you create the functions on the server that the AI agent will invoke. These correspond to the "tools" we identified. We will implement them in C# and ensure they can be called independently of the web API endpoints (though internally they might use the same services).

### Step 2.1: Add the Copilot SDK NuGet Package

First, add the GitHub Copilot SDK to the Server project:

- Using the CLI: run `dotnet add ContosoShop.Server package GitHub.Copilot.SDK --prerelease`. (If a specific version or feed is needed, follow those instructions).
- Or using Visual Studio's NuGet Manager, search for "GitHub.Copilot.SDK" and install the latest preview.
- After installation, build the solution to ensure it restores and compiles. This gives you access to types like CopilotClient, etc.

### Step 2.2: Create the SupportAgentService class

In Server/Services (or a new folder "AI" if you prefer), add a class `SupportAgentService.cs`. This class will encapsulate our tool implementations and possibly hold the Copilot session (though we might manage session in Controller or a separate class). For clarity, we'll focus here on tool methods:

```csharp
using ContosoShop.Server.Data;  // for ContosoContext
using ContosoShop.Shared.Models; // for Order, OrderStatus
using System.Text;               // for building messages

public class SupportAgentService
{
    private readonly ContosoContext _context;
    private readonly IEmailService _emailService;
    private readonly OrderService _orderService;

    public SupportAgentService(ContosoContext context, IEmailService emailService, OrderService orderService)
    {
        _context = context;
        _emailService = emailService;
        _orderService = orderService;
    }

    // Tool 1: Get order details/status summary
    public string GetOrderDetails(int orderId)
    {
        // Fetch the order (including items)
        var order = _orderService.GetOrderById(orderId);
        if (order == null)
        {
            return $"I'm sorry, I cannot find an order with ID {orderId}.";
        }
        // Build a status message
        string statusMsg = order.Status switch
        {
            OrderStatus.Processing => "is still being processed.",
            OrderStatus.Shipped => $"was shipped on {order.ShipDate:MMM dd, yyyy} and is on its way.",
            OrderStatus.Delivered => $"was delivered on {order.DeliveryDate:MMM dd, yyyy}.",
            OrderStatus.Returned => $"was returned on {order.ReturnDate:MMM dd, yyyy} and refunded.",
            _ => "has an unknown status."
        };
        string result = $"Order {order.Id} {statusMsg}";
        return result;
    }

    // Tool 2: Process a refund (return order)
    public string ProcessRefund(int orderId)
    {
        var order = _orderService.GetOrderById(orderId);
        if (order == null)
        {
            return $"Order {orderId} not found. I cannot process a return.";
        }
        if (order.Status != OrderStatus.Delivered)
        {
            return $"Order {orderId} is not delivered yet (current status: {order.Status}). It cannot be returned at this time.";
        }
        // Process the return
        order.Status = OrderStatus.Returned;
        order.ReturnDate = DateTime.Now;
        _context.SaveChanges();  // persist the status change
        // Send confirmation email (using dev email service)
        string emailBody = $"We have initiated a return for your Order #{order.Id}. You will be refunded {order.TotalAmount:C} to your original payment method within 5-7 business days.";
        _emailService.SendEmail(order.UserEmail, $"Return processed for Order {order.Id}", emailBody);
        // Return a confirmation message for the agent to use
        return $"I've processed the return for order {order.Id}. You will receive a refund of {order.TotalAmount:C} within a week.";
    }

    // Tool 3: Send an email to customer (if the agent wants to send additional info)
    public string SendCustomerEmail(int orderId, string message)
    {
        var order = _orderService.GetOrderById(orderId);
        string email = order?.UserEmail ?? "customer";
        // In our demo, we have a single user whose email we can assume (or we stored on Order.UserEmail).
        _emailService.SendEmail(email, $"Message regarding Order {orderId}", message);
        return $"I've sent an email to the customer with the details.";
    }
}
```

**Explanation:**

- We inject ContosoContext, IEmailService, and OrderService. We assume OrderService.GetOrderById returns an Order including status and key dates. If OrderService doesn't exist, we could query _context.Orders.Include(i=>i.Items) directly. But leveraging existing logic (like any business rules in OrderService) is better.

- **GetOrderDetails(int orderId):**
  - If no such order, return an apologetic message (the agent will convey this to user).
  - If found, we build a friendly status message. We use a switch expression on the status. For Shipped/Delivered, we include dates (assuming Order has ShipDate, DeliveryDate, etc., which we might have in data; if not, we adjust the message to just say "delivered.").
  - We form a sentence like "Order 1002 was shipped on Mar 01, 2026 and is on its way." The language is user-friendly.
  - We return this string. (The Copilot SDK will have the agent capture this return and incorporate into its overall answer).

- **ProcessRefund(int orderId):**
  - Verify order exists and status is Delivered.
  - If not delivered, return a message like "cannot return yet." (The agent will tell the user this).
  - If delivered, perform the return:
    - Set status to Returned, set ReturnDate.
    - Save to DB.
    - Use EmailService to send a refund confirmation email. We use order.UserEmail (we assume Order or related User object has email; in our seeded data, we can fill it or default to a constant email for demo).
    - The email content is defined. (In a real scenario, this might include return instructions, etc. For now, we confirm refund amount and timeline).
  - Return a confirmation message that the agent can speak: "return processed, refund X amount."

- **SendCustomerEmail(int orderId, string message):**
  - We find the order (mostly to get an email or verify existence).
  - Use EmailService to send the provided message as an email to the user (with a subject referencing the order).
  - Return a confirmation string for the agent. The idea: if the agent wants to send a longer explanation or a return label link via email, it could call this tool after telling the user it will do so.
  - In practice, our agent might not call this on its own unless we prompt it to. But having it demonstrates how multi-tool usage could work (like agent answers briefly then says "I've emailed you more details," after using this tool).

### Step 2.3: Register SupportAgentService in DI

Open `Program.cs` (or Startup.cs if using older style). Add:

```csharp
builder.Services.AddScoped<SupportAgentService>();
```

This ensures our controllers (or wherever we use it) can get an instance with the needed dependencies injected.

### Step 2.4: Update OrderService or Data to support these functions

If you have an OrderService.GetOrderById(int), ensure it includes related data and likely gets the user's email. Possibly, we need to add UserEmail to Order (for simplicity we might have stored the user's email on the order). If not, we could store a constant or retrieve from a User table. Since our scenario is one user, we might have hardcoded it. For now, if not already present, add a property UserEmail to the Order model and fill it in seeding (e.g., "john@contoso.com"). This makes the EmailService call easier.

(If time, you can do: in OnModelCreating, when seeding an Order, set UserEmail = "john@example.com". Or skip and in EmailService, just always send to a fixed address from config.)

Also, ensure Order has fields like ShipDate, DeliveryDate, ReturnDate (DateTime?). If not, you can simulate:

- For a Delivered order, maybe store DeliveryDate in the DB or compute (like OrderDate + some days).
- For Return, you set ReturnDate in code as above.

These fields are not strictly required for functionality, but they make responses richer. If not already in the model, you can add them and update the DB (since this is a dev db, manually adding is okay). But if you skip, you could respond with simpler messages (just not including dates).

Assume we have them or at least DeliveryDate.

### Step 2.5: (Optional) Test these methods outside agent

It's often wise to test the tool logic in isolation to ensure they do what we expect:

- You could write a quick debug snippet or unit test calling SupportAgentService.GetOrderDetails on a known order ID and check the string.
- Or temporarily expose them via a test controller endpoints for manual hitting. (For brevity, you might skip this, but in a dev scenario, it's useful.)

At this point, we have the core actions implemented. Next, we'll incorporate the Copilot SDK to use these actions.

## Task 3: Register and Configure the GitHub Copilot SDK Agent

Now we connect our tool functions to the AI agent runtime. We'll use the GitHub Copilot SDK to create an agent, give it a prompt, and allow it to call our C# methods.

### Step 3.1: Initialize CopilotClient and Session

We will add logic to set up the Copilot agent in our application. There are a couple of ways to architect this:

- You can create a singleton agent for the whole application, loaded at startup, that handles all user queries (one at a time).
- Or create a new agent session for each incoming request (stateless approach).

Since our support queries are likely short-lived and not multi-turn across long periods, we can create a new session per API call (which is simpler and avoids memory buildup). The Copilot SDK is relatively lightweight in spawning sessions, and it ensures fresh context each time unless we choose to keep it.

We'll implement the latter for simplicity: the API endpoint (that we'll create in Task 4) will instantiate a Copilot session, run the query through it, and dispose.

However, we do need to register the tools with the Copilot SDK so the agent can call them. That means we have to tell Copilot about GetOrderDetails, etc., and provide delegates for those.

We will do this registration ideally once (not on every call, to save overhead). We can do it at service startup: create a CopilotClient, define the tools, and keep it ready.

### Step 3.2: Create SupportAgentController (API for AI)

Add a new controller, `SupportAgentController.cs`, in Server/Controllers:

```csharp
using Microsoft.AspNetCore.Mvc;
using GitHub.Copilot.SDK;  // assume this is the correct namespace for Copilot classes

[ApiController]
[Route("api/agent")]
public class SupportAgentController : ControllerBase
{
    private readonly SupportAgentService _agentService;
    private readonly CopilotClient _copilotClient;

    public SupportAgentController(SupportAgentService agentService, CopilotClient copilotClient)
    {
        _agentService = agentService;
        _copilotClient = copilotClient;
    }

    [HttpPost("ask")]
    public async Task<IActionResult> AskQuestion([FromBody] SupportQuery query)
    {
        if (query == null || string.IsNullOrWhiteSpace(query.Question))
            return BadRequest("Query cannot be empty.");

        // Create a session for this query
        var session = await _copilotClient.CreateSessionAsync(new SessionOptions { Model = "gpt-4" });
        
        // Register tools (functions)
        session.RegisterFunction(
            "get_order_details",
            "Get status of an order by order ID. Parameter: order_id (int).",
            (int order_id) => _agentService.GetOrderDetails(order_id)
        );
        session.RegisterFunction(
            "process_refund",
            "Initiate a return/refund for an order by ID. Parameter: order_id (int).",
            (int order_id) => _agentService.ProcessRefund(order_id)
        );
        session.RegisterFunction(
            "send_email",
            "Send an email to customer with a message. Parameters: order_id (int), message (string).",
            (int order_id, string message) => _agentService.SendCustomerEmail(order_id, message)
        );

        // Craft system prompt
        string systemPrompt = 
            "You are ContosoShop's virtual assistant. " +
            "You can help the customer with order inquiries. " +
            "You have tools to lookup order details (use get_order_details) and process returns (use process_refund). " +
            "Always use the tools for factual information or to perform actions. " +
            "Respond in a friendly tone. " +
            "If question is unrelated to orders or you cannot help, politely refer them to human support.";
        
        // Initialize conversation
        await session.SendMessageAsync(new Message(Role.System, systemPrompt));
        await session.SendMessageAsync(new Message(Role.User, query.Question));

        // Get response (the SDK may handle tool use internally when generating this)
        Message assistantReply = await session.GetResponseAsync();
        string answer = assistantReply.Content;
        
        // Optionally, you might also accumulate the conversation or ensure tools invoked
        // For now, assume the answer is final.

        // End the session (optional, as disposing session or client can be done at controller dispose)
        await session.DisposeAsync();

        // Return the assistant's answer
        return Ok(new { answer });
    }
}

public class SupportQuery
{
    public string Question { get; set; }
}
```

**Key points and assumptions:**

- We injected CopilotClient. We need to have a singleton CopilotClient available via DI as well. We will create it in Program.cs separately. Possibly register it as a singleton after starting it.

- In the AskQuestion action:
  - We accept a SupportQuery in the body. The Blazor client will send JSON {"question": "...user's question..."}.
  - We create a session with GPT-4. (If GPT-4 is not available, we could use "model: gpt-3.5-turbo". But we assume GPT-4 since we want better quality. In practice, ensure your Copilot subscription allows GPT-4 requests.)
  - RegisterFunction is a hypothetical API; actual SDK might use a slightly different method signature. We assume it can take a C# delegate (lambda). We map exactly our _agentService methods. Notice for send_email, we show two parameters (int, string).
  - System prompt is given as first message (Role.System).
  - We then Send the user's question as a User message.
  - Then GetResponseAsync() should process the conversation and tools: The Copilot SDK's agent will analyze the user question and possibly output a call to one of our functions. The SDK will intercept, invoke our C# function, get result, feed it back to the model, which then produces either more function calls or a final answer. This loop is handled internally by the Copilot SDK's session (very similar to how OpenAI function calling works but with multi-step).
  - The final assistant response is captured in assistantReply.
  - We dispose the session to free any resources.
  - Return the answer as JSON (the Blazor client will get it and display).

- Error cases: If the question is empty, we 400. If something goes wrong in the agent call (exception, etc.), in a robust app we'd catch and handle (maybe return 500 with error message "Agent error"). For brevity, not shown above, but you may wrap the core logic in try-catch and return BadRequest or StatusCode(500) with a message if needed.

### Step 3.3: Register CopilotClient Singleton in Program.cs

Open `Program.cs` in the Server project. After building services, do:

```csharp
// Create and start CopilotClient as a singleton
var copilotClient = new CopilotClient();
copilotClient.StartAsync().GetAwaiter().GetResult();  // synchronous start during startup
builder.Services.AddSingleton(copilotClient);
```

Place this before `var app = builder.Build();`. This ensures when the controller is constructed, it gets the same running CopilotClient.

Also ensure `builder.Services.AddControllers();` is called (if not, add it so our new controller is recognized, but likely it's already there from template).

Now, consider that the Copilot SDK might require configuration, like authentication:

- Possibly using your GitHub account credentials or relying on a logged-in Copilot CLI agent. The preview might pick up your GitHub auth from environment (e.g., if you ran github-copilot-cli auth). If additional steps are needed (like setting an environment variable or calling copilotClient.Login(token)), you'd do it here. Check Copilot SDK docs – since this is a managed environment, we assume it can connect since Copilot is tied to your GitHub account (maybe it pops a login on first run or uses an existing VS Code login).
- In this lab scenario, we assume you have Copilot access and the SDK takes care of auth (some previews required running a local CLI daemon evalai, but GitHub's one might not. If it did, we would have to ensure that's running).

For a Microsoft Learn lab, possibly they'll have a pre-provisioned environment where Copilot SDK works or they emulate it. The instructions might note to run github-copilot-cli in the background. We'll assume smooth operation.

### Step 3.4: Verify Tools Registration Syntax

The code as written is not tested against actual SDK (since it's hypothetical in our environment). In case the SDK uses a slightly different API, adjust accordingly:

- For example, it might not have RegisterFunction but instead, the Session might expose something like session.RegisterTool(new FunctionDefinition("name", ...), delegate).
- Or maybe we use copilotClient.RegisterFunctionGlobally and then session knows them.
- Because we don't have the exact library details here, if this were a real lab, we'd refer to documentation. The logic remains: we tie a textual command to a C# method.

### Step 3.5: (Optional) Logging within Tools

It might be helpful to log when a tool is invoked and what it returned, for debugging:

- e.g., in GetOrderDetails, do `_logger.LogInformation("Agent invoked GetOrderDetails for order {orderId}", orderId);`.
- This requires injecting ILogger in that service. If time, you could add that – it's good for telemetry to see usage of functions.
- Also log in the controller the user question and final answer from agent for audit: `logger.LogInformation("Q: {q} -> A: {a}", query.Question, answer);`

This logging can later be connected to Azure App Insights for monitoring agent performance and identifying false info if any.

We have now set up the agent. The next step is to connect the front-end to use this new API endpoint.

## Task 4: Update Blazor Frontend for Agent Query UI

We will modify the Support.razor page to allow the user to input a question and see the answer from the agent.

### Step 4.1: Create a service proxy for the agent API

In the Client project, create a new service class, e.g., `SupportAgentServiceClient.cs`:

```csharp
public class SupportAgentServiceClient
{
    private readonly HttpClient _http;
    public SupportAgentServiceClient(HttpClient http) { _http = http; }

    public async Task<string> AskAgentAsync(string question)
    {
        var payload = new { question = question };
        var response = await _http.PostAsJsonAsync("api/agent/ask", payload);
        if (!response.IsSuccessStatusCode)
        {
            // You could read error and throw or handle
            string error = await response.Content.ReadAsStringAsync();
            throw new Exception($"Agent API error: {response.StatusCode} - {error}");
        }
        // The response is expected to be { answer: "text" }
        var result = await response.Content.ReadFromJsonAsync<AgentAnswer>();
        return result?.Answer ?? string.Empty;
    }
}

public class AgentAnswer
{
    public string Answer { get; set; }
}
```

This service uses HttpClient to call our POST /api/agent/ask. We defined it to return a JSON with property answer. We map that into a small AgentAnswer class.

Register this in `Program.cs` (Client):

```csharp
builder.Services.AddScoped<SupportAgentServiceClient>();
```

(This is similar to how OrderService was registered.)

### Step 4.2: Update Support.razor UI

Open Support.razor. We will create a simple chat-like interface:

- A multiline textbox or list to show conversation (to start, we might just show one question and answer).
- An input box and send button for new question.

Since our scenario currently doesn't involve multi-turn (the agent treats each question independently), we might not maintain a whole chat history. But we could, just to present a chat UI. Let's maintain a list of Q&A pairs in the component state for UX.

Modify the component code:

```razor
@page "/support"
@inject SupportAgentServiceClient SupportAgentClient

<h3>Contact Support</h3>

<div class="mb-3">
    <p>You can ask our virtual support assistant about your orders.</p>
</div>

<div class="card p-3" style="min-height: 200px;">
    @if(conversations.Count == 0)
    {
        <p class="text-muted">Ask a question about your order to get started.</p>
    }
    @foreach(var entry in conversations)
    {
        <div class="mb-2">
            <strong>You:</strong> @entry.Question
            <br />
            <strong>Assistant:</strong> @entry.Answer
        </div>
    }
    @if(isLoading)
    {
        <div class="mb-2"><em>Assistant is typing...</em></div>
    }
</div>

<EditForm Model="@queryModel" OnValidSubmit="@SubmitQuestion">
    <div class="mb-2">
        <InputText @bind-Value="queryModel.Question" 
                   class="form-control" placeholder="Type your question..." />
    </div>
    <button type="submit" class="btn btn-primary" disabled="@isLoading">Send</button>
    @if(!string.IsNullOrEmpty(errorMessage))
    {
        <div class="text-danger mt-2">@errorMessage</div>
    }
</EditForm>

@code {
    class ConversationEntry { public string Question { get; set; } public string Answer { get; set; } }

    private SupportQueryModel queryModel = new SupportQueryModel();
    private List<ConversationEntry> conversations = new();
    private bool isLoading = false;
    private string errorMessage;

    async Task SubmitQuestion()
    {
        errorMessage = string.Empty;
        if(string.IsNullOrWhiteSpace(queryModel.Question)) return;
        var userQuestion = queryModel.Question;
        conversations.Add(new ConversationEntry { Question = userQuestion, Answer = "" });
        var entryIndex = conversations.Count - 1; // index of this question in list
        try
        {
            isLoading = true;
            // Call the agent service
            string answer = await SupportAgentClient.AskAgentAsync(userQuestion);
            conversations[entryIndex].Answer = answer;
        }
        catch(Exception ex)
        {
            conversations[entryIndex].Answer = ""; // ensure it's empty since we got no answer
            errorMessage = "Sorry, something went wrong. Please try again later.";
            Console.Error.WriteLine($"Agent error: {ex.Message}");
        }
        finally
        {
            isLoading = false;
        }
        queryModel.Question = string.Empty;
        StateHasChanged();
    }

    class SupportQueryModel { public string Question { get; set; } = ""; }
}
```

Let's explain what we did:

- We replaced the static support info with an interactive UI.
- conversations list keeps track of each Q&A. Initially empty.
- When user submits, we take their question, add a new ConversationEntry with that question and empty answer (so that "You: question" appears and a placeholder for answer).
- We mark isLoading=true to show "Assistant is typing..." feedback.
- Call SupportAgentClient.AskAgentAsync(userQuestion) which calls the server.
- If successful, we set the Answer in the conversation entry.
- If error, we display a general error message (not directly the exception detail to user). And log to console for dev.
- We clear the input box (by resetting queryModel.Question).
- The UI for conversation: we loop through each entry, display "You: ..." and "Assistant: ...".
  - If answer is not yet set (empty string and isLoading true), we currently just show "Assistant is typing..." outside the loop. We do that by checking isLoading separately. (Another approach: put a placeholder in the entry itself.)
- Also display errorMessage if any.

This yields a simple chat log.

**Styling:** We used a card with padding and min-height to look like a chat window. This can be improved (maybe scrollable if many messages, but it's fine for a few). We keep it simple.

### Step 4.3: Test the UI (with stub if necessary)

At this point, you have a full connection from UI to agent. If everything is wired right, you can run the app:

- Navigate to Support page.
- Ask: "Where is my order 1001?"
- The UI will call the API, the agent will call GetOrderDetails(1001), get a status string, and reply with it. The UI should then show it under "Assistant:".

However, if something is not configured properly with Copilot SDK or connectivity, you might get an error (which in our UI would show "something went wrong").

For testing in a scenario where Copilot SDK might not actually function (if offline), you could temporarily stub the SupportAgentClient to return a canned response for known questions. But assuming the environment is properly set up for AI connectivity, we proceed.

### Step 4.4: Multi-turn Consideration

Our current implementation treats each query independently:

- The system prompt is re-sent every time, and the agent has no memory of prior conversation beyond the current question. We do append Q&A to UI for user reference, but each call stands alone.
- This is acceptable for now, because queries like "Where is order 1002?" are fully answerable with one turn.
- If the user asks a follow-up like "Can I return it?", the agent wouldn't know the context of "it" unless we provide conversation history to the next call. That's advanced (would require we maintain session or feed previous Q&A into prompt).
- For this lab, we assume independent questions or the agent itself can ask clarifying questions within one session. Actually, if the agent needs clarification, how would that work? Given our design, the agent could output something like "Which order are you referring to?" as the assistant's answer. The user would then have to ask again specifying. It's not a full chat loop because we close session after one answer.
- To allow actual multi-turn, we could keep the session alive across multiple calls by storing sessionId or session object in a static or cache per user. That's beyond our scope but something to think about.
- In a production support bot, maintaining the conversation context is important for follow-ups. Copilot SDK might allow streaming multiple interactions in one session. But for simplicity, one question = one answer here.

### Step 4.5: UI/UX polish (Optional)

- You could disable the input while loading to prevent sending another query simultaneously (we did disable the send button via disabled=@isLoading).
- If you want asynchronous streaming (like token by token update to show a typing effect), Copilot SDK might allow a streaming mode. That would require hooking an event or reading partial output. This is advanced; we won't implement streaming in this lab. Instead, we show a simple "Assistant is typing..." until the full answer is ready.
- The conversation list grows indefinitely; in a real app, you might limit or provide a "clear chat" button. Not needed for now.

Alright, at this point, everything is implemented: Backend tools, AI integration, and frontend. Now it's time to actually run and test the integrated solution.

## Task 5: Test the AI Agent Integration

Run the application (Server and Client). Use the following test scenarios to validate:

1. **Check Order Status Query:** Go to Contact Support, ask: "Where is my order 1002?"
   - Expected behavior: The assistant should respond with something like "Order 1002 was shipped on [date] and is on its way." (Whatever your GetOrderDetails returns for order 1002). The answer should be correct based on the database. Check that this matches what you see on the Orders page for #1002. If it does, success! If the agent gives a vague or wrong answer, there might be an issue (like maybe it didn't call the tool and guessed). Ideally, the prompt and function usage ensures it calls our function.
   - If you get no answer and just the error message, see the server logs. Possibly the CopilotClient couldn't connect – ensure you are logged in to GitHub CLI and that internet is available. This is environment-specific. For the lab, assume it's configured to work.

2. **Return Order Query:** Ask: "I want to return my order 1001."
   - The agent should verify order 1001's status. If #1001 was delivered in seed data, it should proceed to call ProcessRefund. That will update the DB and log an email. The agent's answer likely: "I've processed the return for order 1001. You will receive a refund of $X.XX within a week." Exactly as our tool returns.
   - Check that on the Orders page, if you refresh (or navigate away and back), Order 1001 now shows status Returned. That confirms the process_refund tool executed and DB updated.
   - Also check your server console for the email log from EmailServiceDev (it should have printed the refund email content). This shows that part worked.
   - If the user asks a follow-up like "Can I also return order 1002?" while the session is closed, they'd have to ask in a new message. That's fine for now.

3. **Unknown Order:** Ask: "Where is order 9999?" (assuming that ID doesn't exist in DB). The agent via GetOrderDetails will return "cannot find order". The agent's reply should convey that politely. It might directly use our returned string which says "I'm sorry, I cannot find an order with ID 9999." – which is already polite. Good.
   - Check that the agent didn't hallucinate an answer like "It's delivered" when it doesn't exist. If our tools are properly used, it shouldn't. If it does, maybe it didn't use the tool, meaning our system prompt might need to be stricter. We can fine-tune prompt to always use tools.

4. **Off-topic question:** Ask: "What's the weather?" – The agent should not have a tool for this, and our system prompt told it to refer to human support for unrelated queries. The likely response: It might say something like "I'm sorry, I can only help with your order related questions." If it attempts to answer with something irrelevant or makes up, then we need to enforce prompt more. But given the instructions, it should refuse properly. This is a good test of boundaries.
   - Similarly, a question like "Tell me a joke" should yield a deflection or polite refusal.

5. **Multi-step scenario:** Ask something that requires both tools. For example: "Where is order 1001 and can I return it?" – This is tricky: The user combined a status check and an action. The agent might:
   - Use get_order_details (sees it's delivered), then it might automatically call process_refund to fulfill the second request, then answer perhaps combining: "Order 1001 was delivered on Jan 5. I have now processed a return for you; you will get refund...".
   - This would test the agent's ability to use two functions sequentially. Our Copilot SDK session should handle multi-step planning. Check if it indeed did both. (See the database after – order 1001 should be marked returned if it did).
   - If it only answered the first part or got confused, the prompt could be adjusted to encourage multi-step. But likely it can handle it since we gave it tools.
   - This is a key advantage of such an agent: able to act based on conversation context.

All tests done? Great.

**Troubleshooting tips:**

- If the agent's responses seem off or it's not using a tool when it should, consider adjusting the system prompt to be more explicit. For example, adding: "You MUST use the functions to get information. Do not make up answers. Only respond with data you retrieved from functions." The Copilot SDK's agent might already bias toward using them due to how we registered the functions (the descriptions help).
- If there's any error like an exception in controller, see the output/log. Common issues might be:
  - CopilotClient not started or null: ensure Program.cs added the singleton properly.
  - If the request hangs or is very slow: The Copilot call might be taking time (it is going to an AI model). GPT-4 can take a few seconds. Our UI shows "typing..." to cover that. If it's more than, say, 15 seconds, something may be wrong.
  - If you get a 401 from the agent API: likely Copilot SDK not authenticated. You might need to run copilot-cli auth to login. For the lab environment, they might handle it.

## Task 6: (Optional) Add Logging and Observability

(This task is optional but recommended for real-world readiness.)

Now that the integration works, consider adding logging to monitor the AI agent's activities:

**Server-side Logging:** We touched on this: log when each tool is executed and what it returns. This way, if the agent provides an incorrect answer, you can check whether the tool gave correct info or the agent ignored it. Example additions:

```csharp
_logger.LogInformation("GetOrderDetails called for orderId {orderId}, result: {result}", orderId, result);
```

Also log the Q&A:

```csharp
_logger.LogInformation("User question: {question}, Agent answer: {answer}", query.Question, answer);
```

If later integrated with Application Insights on Azure, these logs can be turned into telemetry events you can query (e.g., count how often returns are processed by AI vs how often users ask status questions).

**Frontend Logging:** If needed, any errors caught (like in errorMessage) could be sent to some telemetry. But on frontend, we mainly rely on server logs.

**Telemetry for AI usage:** Another angle: GitHub might have rate limits or auditing for Copilot SDK usage. Keep an eye on how many calls are made. If we ramped this to thousands of users, consider caching results for identical questions asked repeatedly (maybe not needed here since each question is personal).

**User Experience Logging:** Perhaps log how long each agent query took (Stopwatch around AskAgentAsync) so you know the average latency (for future optimization or choosing a faster model if needed).

**Cloud Monitoring:** If deploying to Azure, enabling Application Insights would capture all the above logs and metrics in a centralized way. That's a bit beyond our lab, but the groundwork with built-in ILogger is already laid.

## Task 7: Cloud Deployment Considerations (Discussion)

(No coding here, just wrapping up knowledge.)

Now that you have a working AI-enhanced support portal locally, let's discuss how you would deploy this to Azure and ensure the AI agent continues to function:

**Deploying Web App & API:** You can publish the ASP.NET Core Server (with Blazor) to an Azure App Service. Because it's a unified project (hosted model), a single App Service can serve both the API and Blazor WASM. Alternatively, separate them: host API on App Service, and host the Blazor client on Azure Static Web Apps or CDN. For simplicity, one App Service instance running the Server project (which will also serve the client) is straightforward.

- Use dotnet publish and deploy or use Visual Studio publish profile to Azure.
- Ensure the connection string is updated: likely you don't want to use SQLite in Azure for production. Switch to Azure SQL, and run EF Core migrations on that Azure SQL instance (or use EnsureCreated() temporarily for a demo).
- Alternatively, if using SQLite for a quick demo on Azure, note Azure App Service can handle the .db file, but with caution on deploying updates. It's acceptable for a small-scale or internal tool.

**Azure Copilot SDK:** This is new territory. The GitHub Copilot SDK might not be officially supported on Azure App Service yet, especially in preview. Potential issues:

- Authentication: The server needs to authenticate to GitHub to use Copilot. Locally, it used your credentials. On Azure, no interactive login is possible. Possibly, GitHub could allow a PAT (Personal Access Token) for Copilot in headless scenarios, but that's not available (Copilot uses OAuth).
- The Copilot SDK might require a logged-in GitHub identity. One hack: if it relies on a local cache of credentials, you'd have to somehow provide those to the App Service (not ideal).
- **Alternate Plan: Use Azure OpenAI Service:** Instead of Copilot SDK, in production you might replace it with your own prompt orchestration with Azure OpenAI's APIs. You could use a library like Azure OpenAI .NET SDK to send the conversation (system+user) and get an answer. But for function calling, you'd need to implement a loop: after getting answer, check if it wants an action (you could embed a format like [[CALL:get_order_details:1001]] by designing the prompt, or use OpenAI's function calling if available in Azure by then). That's a custom solution but doable. The pattern would mimic what Copilot does but with more control.
- For the scope of this lab, we assume Copilot SDK runs locally for demonstration. For a real product, we'd lean to Azure OpenAI (ensuring data stays in tenant).

**Scalability:** On Azure, you can scale out the App Service to handle multiple requests. The Copilot model calls are external and could be a bottleneck if too many simultaneous queries (GitHub might rate-limit Copilot usage if flooded). Keep an eye on performance. Caching certain answers isn't very applicable since each question is user-specific. But scaling out means multiple instances might each run Copilot SDK – watch out if the SDK tries to use some local resource locked to user. The stateless approach we chose helps (each call independent).

**Cost:** Using GitHub Copilot in a production app might violate terms (Copilot is meant for code suggestion, not runtime question-answer for end-users). Also, it might not have a pricing model per API call for heavy use. If implementing this for real, Azure OpenAI with pay-per-call would be more appropriate. Always consider cost of AI API calls when scaling to thousands of requests. Azure OpenAI's GPT-4, for instance, costs per 1K tokens. Our usage generating a few sentences is maybe a couple hundred tokens per call, which might be a few cents each – manageable but should be monitored.

**Extending Agent Skills:** In the future, you could give the agent more tools (for example, a tool to track an order via shipping API, or to offer a discount coupon to the user – if business permits). The architecture is ready for that: just implement the function and register it. Ensure to update the system prompt to tell the agent when to use the new tool.

**User Feedback & Handoff:** In a real deployment, you would gather user feedback to train/improve the agent:

- Perhaps ask the user "Did this answer help? Yes/No" to get a sense of agent success.
- If the agent fails or the user is unhappy ("This doesn't solve my issue."), you'd want to hand off to a human. Could integrate a feature: if user types "human" or if agent doesn't know, create a ticket or live chat with a human agent. The agent or code could detect certain fallback conditions.
- Logging conversations (with user consent and PII caution) would allow you to review how the agent is doing and refine its prompt or functions.

## Congratulations!

You have successfully integrated an AI agent into the ContosoShop application. You've not only made the support page interactive and smart, but you've also learned how to leverage AI (via GitHub Copilot SDK) in an enterprise app setting – from identifying use cases and functions, implementing them, to connecting everything end-to-end.

This lab showcased a powerful pattern: using AI "Agents" that can act on your backend's functions to automate user support. You can imagine applying this pattern beyond e-commerce – e.g., an AI agent to automate IT helpdesk tasks (resetting passwords, unlocking accounts via tools), or an agent in a CRM that pulls data from various systems to answer sales questions – the possibilities are vast. The key is careful design of the agent's abilities and safeguards, as you have practiced here.

Feel free to experiment further: tweak the agent's prompt to change its tone or verbosity, add more Q&A pairs to test its limits, or even try to trick it – see how it handles edge cases. This will give you deeper insight into the AI's behavior and how to refine enterprise AI agents for real-world reliability.

**End of Lab**
