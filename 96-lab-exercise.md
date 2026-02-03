# Lab Exercise: Integrate an AI Agent into the E-commerce Support Portal

**Lab Title:** Intelligent Customer Support Agent Integration with GitHub Copilot SDK

**Lab Objective:**
In this lab, you will enhance the ContosoShop E-commerce Support Portal by integrating an AI-powered support agent using the GitHub Copilot SDK. By the end, the "Contact Support" page will allow a user to ask questions (e.g., "Where is my order?" or "I need to return my order") and receive helpful, automated answers or actions from an AI agent. The agent will use the backend's capabilities (like checking order status or initiating a return) to resolve queries. This will give you hands-on experience in defining AI agent skills (tools), using the Copilot SDK in an ASP.NET Core environment, and updating a Blazor UI to interact with the agent.

The lab is broken into sequential tasks, each building on the previous:

1. **Project Setup & Prerequisites** — Ensure the base app runs and required tools are installed.
2. **Define the AI Agent's Role and Tools** — Decide what the agent should do and identify the functions (tools) needed (planning stage).
3. **Implement Backend Tools for the Agent** — Create the functions in the Web API that will serve as the agent's actions (GetOrderDetails, ProcessRefund, SendCustomerEmail).
4. **Register and Configure the Copilot SDK Agent** — Initialize the Copilot SDK in the backend, define the agent's persona/goal, and register the functions from step 3 as tools available to the agent.
5. **Expose an Agent API Endpoint** — Create a new API endpoint that the frontend can call, which sends the user's query to the Copilot agent and returns the agent's response.
6. **Update the Blazor Frontend for Agent Chat** — Build a simple chat interface on the Contact Support page for users to submit questions and view the AI agent's answers in real-time.
7. **Test the End-to-End Experience** — Run the application, try various support queries, and observe the agent performing tasks (like checking order status or processing a return).
8. **(Optional) Add Logging and Telemetry** — Implement logging for agent interactions and discuss how this would be monitored in a production environment (optional but good practice).

Throughout the lab, we will highlight **why** each step is done and **how** it leverages the base app's design. By the end, you'll not only have a working AI agent in the app, but also a clear understanding of the underlying integration pattern which you can apply to other use cases.

## Before You Begin — Prerequisites & Setup

- **Azure Simulator & Credentials:** This lab does *not* require an Azure subscription; everything runs locally. However, you do need access to the GitHub Copilot SDK (Technical Preview) and a GitHub account with Copilot access. Ensure you have:
  - GitHub Copilot enabled on your account and the **GitHub Copilot CLI/SDK** technical preview access. (Sign up was through GitHub — if you have access, you can use the github-copilot-cli or SDK packages.)
  - Node.js 16+ if using the Copilot CLI daemon (for the SDK to work locally). But in .NET, the SDK can connect directly; we will use the NuGet package approach.

- **Development Environment:** Make sure you have **.NET 8 SDK** installed. Use `dotnet --version` to confirm (should be 8.x). You will be working in Visual Studio Code or Visual Studio 2022 — either is fine. VS Code with the C# extension is lightweight and works well, and if you installed the GitHub Copilot VSCode extension, that's fine but not required for the SDK usage.
  
  Also, ensure the solution is open and you can run the base app (as verified in previous steps). If not already done, run the application and verify that you can view the Orders and Support page without errors.

- **GitHub Copilot SDK Package:** The .NET SDK is provided as a NuGet package (for example, GitHub.Copilot.SDK). In this lab, you'll add this package to the Server project. (You do *not* need it on the Client project, since the agent runs on the server side.)
  
  *Important:* The Copilot SDK might be in a private NuGet feed (depending on the preview distribution). If so, instructions will be provided on how to authenticate and install it. For our lab scenario, assume you have a way to add it — either by a provided local package or a feed. The package version we use is the latest preview (for example, "0.5.0-preview" — actual version may vary).

- **Familiarity Recap:** This lab will involve writing C# code in the backend and frontend. Familiarize with where things are:
  - Open OrderController.cs (or OrderService.cs) to recall how returns are handled.
  - Open Support.razor to see the placeholder for contact support.
  - You'll be adding new files (possibly for agent configuration) and modifying existing ones. It's a good idea to create a new git branch or backup before proceeding, so you can compare changes later.

Now, let's dive into the tasks.

## Task 1: Define the Agent's Role and Tools (Planning)

Before coding, it's crucial to plan **what tasks the AI agent will handle** and **what backend capabilities (tools) it needs** to accomplish them. From the scenario and the base features, we identify the following:

**Agent's Role (Persona):** The agent will act as an automated customer support assistant for ContosoShop. It should be able to answer questions about order status and perform order-related actions (like initiating a return). It will communicate in a friendly, concise manner as a customer service representative. We will encode this role in the agent's system prompt.

**Common User Queries to Support:**

a. *"Where is my order [#]?"* — The user wants to know the status of a specific order (maybe they provide an order number or whether it's shipped/delivered). The agent should fetch the latest status and respond, e.g., "Your order #1002 was shipped on March 1 and is in transit. Expected delivery: March 5."

b. *"I want to return my [item/order]."* — The user received an order and wants to return it. The agent should confirm eligibility (is it delivered? within allowed window), then process the return (update status, and confirm refund initiation), and respond with confirmation: "I've processed a return for order #1001. You will receive a refund of $59.99 to your card within 5-7 days."

c. *General question like "How do I contact support?"* — The agent can handle or deflect these (in this case, it *is* the support, so it might say "You can ask me any question about your orders, or email support@contososhop.com for other inquiries.").

d. If asked something outside its scope (e.g., "Can I buy a new laptop from you?" which is a sales question not support, or "Tell me a joke"), the agent should politely say it's focused on support issues — we will include instructions to handle unsupported queries by deflecting (or maybe a simple "I'm here to help with order issues.").

**Tools Needed:** Based on the above queries, the agent will need to perform actions on the server:

a. **GetOrderDetails (Order Lookup)** — Given an order ID (or perhaps if user doesn't specify, the agent could assume the latest order), retrieve the order status and key info (delivery date, etc.). This maps to functionality already in the app (OrderService can get order by ID). We will implement a tool function `GetOrderDetails(orderId)` that returns a summary of the order's status. It might return a text like "Order 1002 is shipped (expected March 5)." or a structured object we can format.

b. **ProcessRefund (Initiate Return)** — Given an order ID, mark it returned and log the refund. The app already has an API endpoint for this; we can call the same logic. We'll implement a tool `ProcessRefund(orderId)` that wraps the existing return functionality but tailored for agent use (it might directly call `OrderService.ProcessReturn` and `EmailService`). It should return a confirmation message or data for the agent to tell the user.

c. **SendCustomerEmail (Email Confirmation)** — Although the ProcessRefund logic already triggers an email via EmailService, we might want a tool that explicitly allows the agent to send a follow-up email. However, since the agent is conversing directly, it may not need to send a separate email in this context (the user gets immediate answer). We might use this tool if we wanted the agent to be able to send transcripts or additional info by email. For completeness (as originally planned), we will create a `SendCustomerEmail(orderId, message)` tool. In this lab, the agent might not call it spontaneously, but we include it to demonstrate multi-step capabilities (e.g., agent could confirm "I have emailed you the return shipping label." if we had that use-case).

d. Potentially, **LookupLatestOrder** — If a user asks "Where is my order?" without specifying which, the agent could check if the user has any pending orders and respond about the latest. We can handle this within GetOrderDetails by some convention (like if orderId not provided, use latest). For simplicity, we assume queries will mention an order number or the agent will ask which order if ambiguous. We won't implement a separate tool; we'll just note this scenario.

**Agent Knowledge and Context:** The agent can get order info via tools, but it also needs to know the user's identity or which orders to search. Since our app currently operates in a single-user context, the agent can assume it's always dealing with John Doe's orders (no need to distinguish user ID). We will ensure the tools fetch data for the demo user. In a multi-user scenario, we'd pass the user's ID to the agent's context securely (not done here due to single-user assumption).

**Safety and Bounds:** The agent should not do anything outside these tools (we won't give it database write access except through ProcessRefund, and that has checks). We will explicitly restrict it to only the tools we define. The Copilot SDK ensures the agent can't call arbitrary code — it can only invoke registered functions. We'll reinforce in the prompt that it should stick to order questions. This covers our bases so it doesn't attempt something weird (like "delete order" — we aren't giving it such a tool).

We have our plan: the primary tools to implement are **GetOrderDetails**, **ProcessRefund**, and possibly **SendCustomerEmail** for completeness.

*Before moving on:* Open the Server project in your IDE. You will be adding these as methods. One approach is to create a dedicated class for agent tools, e.g., SupportAgentService. But since some logic is in OrderService, you could also integrate there. To keep things organized, we'll make a new class SupportAgent (or similar) that hosts these tool methods as static or instance methods. The Copilot SDK will need either delegate functions or methods to call; we'll register them in Program or Startup.

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
using ContosoShop.Server.Data; // for ContosoContext
using ContosoShop.Shared.Models; // for Order, OrderStatus
using System.Text;              // for building messages

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
        _context.SaveChanges(); // persist the status change
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

- We inject ContosoContext, IEmailService, and OrderService. We assume OrderService.GetOrderById returns an Order including status and key dates. If OrderService doesn't exist, we could query `_context.Orders.Include(i=>i.Items)…` directly. But leveraging existing logic (like any business rules in OrderService) is better.

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

Open Program.cs (or Startup.cs if using older style). Add:

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

**However**, we do need to **register the tools** with the Copilot SDK so the agent can call them. That means we have to tell Copilot about GetOrderDetails, etc., and provide delegates for those.

We will do this registration ideally once (not on every call, to save overhead). We can do it at service startup: create a CopilotClient, define the tools, and keep it ready.

So, in Program.cs (Server side), after registering services, do:

```csharp
// Pseudocode for clarity; will refine below
var copilotClient = new CopilotClient();
await copilotClient.StartAsync(); // perhaps we should do this in an async context or .Wait for sync startup
var sessionOptions = new SessionOptions { Model = "gpt-4", MaxTokens = 1024 };
var agentSession = await copilotClient.CreateSessionAsync(sessionOptions);

// Register functions:
agentSession.RegisterFunction("get_order_details", "Get order status information by order ID. Parameter: order_id (int).",
    (int order_id) => supportAgentService.GetOrderDetails(order_id));
```

The above is illustrative. In practice, we might not want to create a long-lived session at startup because we plan to create on each call. Alternatively, we don't create a session at startup, we only register the *function definitions* at client level.

It depends on Copilot SDK's API:

- Possibly we can register global functions on CopilotClient or on a Session. The preview docs suggest functions are tied to sessions (like "function calling" in OpenAI API is per request or session).
- If sessions are cheap, we can indeed do it per request: create session, register these functions, then ask.

For clarity and to ensure fresh state for each query, we'll do the registration per request.

Thus, when a query comes in:

- Create a CopilotClient (or reuse a static one).
- Create a session with the needed model.
- Register our 3 functions on that session.
- Send the user's message to the session and get a response.
- Return the response to user.

We must also craft the **System Prompt** (or initial message) for the agent so it knows how to behave:

- E.g., *"You are a helpful customer support assistant for ContosoShop. You have access to the customer's order information. You can retrieve order details and process returns using provided tools. Only use the tools to get information or perform actions. Respond concisely and in a friendly tone."*
- Also instruct on format somewhat: e.g., *"If the user asks about an order, use get_order_details. If they ask to return, use process_refund. Explain outcomes to the user. If question is unrelated to orders, politely say you are only trained to help with orders."*

This system message will be given to the Copilot session.

Now, implement this in code.

### Step 3.2: Create SupportAgentController (API for AI)

Add a new controller, SupportAgentController.cs, in Server/Controllers:

```csharp
using Microsoft.AspNetCore.Mvc;
using GitHub.Copilot.SDK; // assume this is the correct namespace for Copilot classes

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

        // Return the answer to the user
        return Ok(new { Answer = answer });
    }
}

// Model for the request
public class SupportQuery
{
    public string Question { get; set; }
}
```

**Explanation:**

This controller is responsible for handling user queries to the AI agent. When the Blazor client calls POST /api/agent/ask with a question, this endpoint:

1. Creates a new Copilot session.
2. Registers the three tool functions (get_order_details, process_refund, send_email) with the session.
3. Sends a system message (the agent's instructions/prompt) to the session.
4. Sends the user's question as a user message.
5. Gets the response from the agent (which may have called one or more tools behind the scenes to formulate the answer).
6. Returns the response to the user.

Note: The actual Copilot SDK API might differ slightly in method names or parameters. This is a conceptual implementation. Refer to the Copilot SDK documentation for exact API signatures. The key idea is:

- You register functions that the agent can call.
- You provide a system prompt to guide the agent's behavior.
- You send the user's message and retrieve the agent's response.

### Step 3.3: Register CopilotClient in DI

In Program.cs (Server), register the CopilotClient as a singleton (or scoped if needed):

```csharp
builder.Services.AddSingleton<CopilotClient>(sp => new CopilotClient());
```

This makes it available for dependency injection into the controller.

At this point, the backend is ready. The agent can receive queries, use the tools to look up orders or process returns, and respond to the user.

Next, we need to wire up the Blazor frontend to call this API endpoint.

## Task 4: Expose an Agent API Endpoint

*(This is part of Task 3, but separated for clarity)*

We've already created the endpoint in Task 3.2: POST /api/agent/ask.

The endpoint accepts a JSON body with a Question property and returns a JSON response with an Answer property.

**Test the endpoint (optional):** Before integrating with the frontend, you can test this endpoint using a tool like Postman or curl:

```bash
curl -X POST https://localhost:5001/api/agent/ask \
  -H "Content-Type: application/json" \
  -d '{"Question":"Where is my order 1002?"}'
```

You should receive a response like:

```json
{
  "Answer": "Order 1002 was shipped on Mar 01, 2024 and is on its way."
}
```

If this works, the agent is functioning correctly.

## Task 5: Update the Blazor Frontend for Agent Chat

Now we build a simple chat interface on the Contact Support page for users to submit questions and view the AI agent's answers in real-time.

### Step 5.1: Create AgentService (Client)

In the Client project, create a service to call the agent API. Add a file `Services/AgentService.cs`:

```csharp
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;

public interface IAgentService
{
    Task<string> AskQuestionAsync(string question);
}

public class AgentService : IAgentService
{
    private readonly HttpClient _http;

    public AgentService(HttpClient http)
    {
        _http = http;
    }

    public async Task<string> AskQuestionAsync(string question)
    {
        var response = await _http.PostAsJsonAsync("api/agent/ask", new { Question = question });
        response.EnsureSuccessStatusCode();
        var result = await response.Content.ReadFromJsonAsync<AgentResponse>();
        return result?.Answer ?? "Sorry, I couldn't get a response.";
    }
}

public class AgentResponse
{
    public string Answer { get; set; }
}
```

Register this service in Program.cs (Client):

```csharp
builder.Services.AddScoped<IAgentService, AgentService>();
```

### Step 5.2: Update Support.razor

Open `Pages/Support.razor` in the Client project. Replace the placeholder content with a chat interface:

```razor
@page "/support"
@inject IAgentService AgentService

<h3>Contact Support</h3>

<div class="chat-container">
    @foreach (var message in messages)
    {
        <div class="message @message.Role">
            <strong>@message.Role:</strong> @message.Text
        </div>
    }
</div>

<div class="input-area">
    <input @bind="userInput" placeholder="Ask a question..." class="form-control" @onkeyup="HandleKeyUp" />
    <button @onclick="SendMessage" class="btn btn-primary">Send</button>
</div>

@if (!string.IsNullOrEmpty(errorMessage))
{
    <div class="alert alert-danger mt-3">@errorMessage</div>
}

@code {
    private string userInput = "";
    private string errorMessage = "";
    private List<ChatMessage> messages = new();

    private async Task SendMessage()
    {
        if (string.IsNullOrWhiteSpace(userInput))
            return;

        // Add user message to chat
        messages.Add(new ChatMessage { Role = "You", Text = userInput });
        var question = userInput;
        userInput = ""; // Clear input

        try
        {
            // Get agent response
            var answer = await AgentService.AskQuestionAsync(question);
            messages.Add(new ChatMessage { Role = "Agent", Text = answer });
        }
        catch (Exception ex)
        {
            errorMessage = $"Error: {ex.Message}";
        }
    }

    private void HandleKeyUp(KeyboardEventArgs e)
    {
        if (e.Key == "Enter")
            SendMessage();
    }

    public class ChatMessage
    {
        public string Role { get; set; }
        public string Text { get; set; }
    }
}

<style>
    .chat-container {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 16px;
        height: 400px;
        overflow-y: auto;
        background-color: #f9f9f9;
        margin-bottom: 16px;
    }
    .message {
        margin-bottom: 12px;
        padding: 8px;
        border-radius: 4px;
    }
    .message.You {
        background-color: #e3f2fd;
        text-align: right;
    }
    .message.Agent {
        background-color: #fff;
        border-left: 3px solid #2196F3;
    }
    .input-area {
        display: flex;
        gap: 8px;
    }
    .input-area input {
        flex: 1;
    }
</style>
```

**Explanation:**

- We maintain a list of ChatMessage objects representing the conversation history (user questions and agent answers).
- When the user types a question and clicks Send (or presses Enter), we:
  - Add the user's message to the chat.
  - Call AgentService.AskQuestionAsync to get the agent's response.
  - Add the agent's response to the chat.
- The UI displays the conversation in a scrollable container with distinct styling for user and agent messages.
- Error handling displays any errors in an alert.

## Task 6: Test the End-to-End Experience

Run the application:

1. Start the Server project (which hosts the API and serves the Blazor client).
2. Navigate to the Contact Support page.
3. Try various queries:
   - "Where is my order 1002?"
   - "I want to return order 1001."
   - "Can you help me with order 1003?"
4. Observe the agent responding with order status, processing returns, and providing helpful answers.

**Expected Behavior:**

- For "Where is my order 1002?", the agent should call GetOrderDetails(1002) and respond with something like: "Order 1002 was shipped on March 1, 2024 and is on its way."
- For "I want to return order 1001" (assuming 1001 is delivered), the agent should call ProcessRefund(1001) and respond: "I've processed the return for order 1001. You will receive a refund of $59.99 within a week."
- For unrelated questions, the agent should politely say it can only help with orders.

**Troubleshooting:**

- If the agent doesn't call tools, check:
  - Tool function names and descriptions are clear.
  - System prompt instructs the agent to use tools.
- If errors occur, check the server logs for exceptions.
- Use browser dev tools (F12) to inspect network requests and see the actual API calls.

## Task 7: (Optional) Add Logging and Telemetry

To make the application production-ready, consider adding logging:

1. In SupportAgentController, log each query and response:
   ```csharp
   _logger.LogInformation("User asked: {Question}", query.Question);
   _logger.LogInformation("Agent responded: {Answer}", answer);
   ```
2. In SupportAgentService, log when tools are invoked:
   ```csharp
   _logger.LogInformation("GetOrderDetails called for order {OrderId}", orderId);
   ```
3. For production, pipe these logs to Application Insights or another monitoring service to track:
   - How often the agent is used
   - What tools are most commonly invoked
   - Error rates and response times

This telemetry is crucial for improving the agent over time and understanding user needs.

## Summary

Congratulations! You've successfully integrated an AI-powered support agent into the ContosoShop E-commerce Support Portal using the GitHub Copilot SDK.

**What you accomplished:**

1. **Planned the agent's capabilities** by identifying the tools it needs (GetOrderDetails, ProcessRefund, SendCustomerEmail).
2. **Implemented backend tool functions** in C# that encapsulate business logic for order lookup and refund processing.
3. **Registered the Copilot SDK agent** and configured it with a system prompt and tool registrations.
4. **Exposed an API endpoint** (/api/agent/ask) that the frontend can call to interact with the agent.
5. **Built a chat interface** in Blazor that allows users to ask questions and receive intelligent responses.
6. **Tested the end-to-end flow** to verify that the agent can successfully look up orders, process returns, and respond helpfully.

**Key Takeaways:**

- **AI agents can be integrated into existing applications** with minimal changes to the core business logic. The Copilot SDK abstracts the complexity of AI orchestration.
- **Tool registration is the bridge** between AI capabilities and your application's functionality. By registering functions, you give the agent "superpowers" to perform real actions.
- **System prompts are critical** for guiding the agent's behavior. Clear instructions help the agent know when and how to use tools.
- **The pattern is reusable:** You can apply this same approach to other scenarios—sales assistance, technical support, data analysis, etc.

**Next Steps:**

- **Enhance the agent** by adding more tools (e.g., track shipments, look up product info, handle exchanges).
- **Improve the UI** with typing indicators, message timestamps, and better error handling.
- **Add authentication** so the agent can personalize responses based on the logged-in user.
- **Deploy to Azure** and monitor agent interactions with Application Insights.
- **Experiment with different models** and prompts to optimize response quality.

You now have a solid foundation for building AI-powered assistants in your applications!
