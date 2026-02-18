---
lab:
    title: 'Exercise - Configure and customize GitHub Copilot in Visual Studio Code'
    description: 'Learn how to configure a C# project to use custom Copilot instructions and create custom agents that collaborate through handoffs.'
    level: 300
    duration: 45 minutes
---

# Configure and customize GitHub Copilot in Visual Studio Code

GitHub Copilot provides powerful AI-assisted coding out of the box, but its true potential emerges when you customize it to match your team's specific workflows and project requirements. By providing custom instructions and creating specialized agents, you can transform GitHub Copilot from a general-purpose assistant into a set of tailored AI collaborators that understand your codebase, follow your conventions, and handle multi-step development tasks.

In this exercise, you configure a C# Web API project to use custom Copilot instructions and create custom agents that collaborate through handoffs to complete a development task end-to-end.

This exercise should take approximately **45** minutes to complete.

> **IMPORTANT**: To complete this exercise, you must provide your own GitHub account and GitHub Copilot subscription. If you don't have a GitHub account, you can <a href="https://github.com/" target="_blank">sign up</a> for a free individual account and use a GitHub Copilot Free plan to complete the exercise. If you have access to a GitHub Copilot Pro, GitHub Copilot Pro+, GitHub Copilot Business, or GitHub Copilot Enterprise subscription from within your lab environment, you can use your existing GitHub Copilot subscription to complete this exercise.

## Before you start

Your lab environment MUST include the following resources:

- Git 2.48 or later.
- The .NET SDK version 8.0 or later.
- Access to a GitHub account with GitHub Copilot enabled.
- Visual Studio Code (version 1.106 or later) with the C# Dev Kit and GitHub Copilot Chat extensions.

## Exercise scenario

You're a software developer working for a consulting firm. The firm developed a C# Web API project for a client that manages product inventory. The client has specific coding standards, architectural patterns, and review processes. You're tasked with using GitHub Copilot to accelerate development while ensuring that all code adheres to these standards.

You intend to use the following approach:

- Create custom instruction files that embed the client's coding standards into Copilot's behavior so that all AI-generated code follows the established conventions.
- Define custom agents for specific development roles—a "Planner" that designs implementation plans, an "Implementer" that writes code, and a "Reviewer" that checks code quality.
- Chain these agents together using handoffs to create a structured multi-step workflow from planning through implementation to review.

This exercise includes the following tasks:

1. Set up a C# project and configure the development environment.
1. Create repository-level custom instructions to enforce coding standards.
1. Create path-specific instruction files for targeted guidance.
1. Create a reusable prompt file for a common task.
1. Define a "Planner" custom agent with read-only tools.
1. Define an "Implementer" custom agent with editing capabilities.
1. Define a "Reviewer" custom agent for code quality checks.
1. Run the chained agents workflow to complete a development task end-to-end.

## Set up a C# project and configure the development environment

In this task, you create a new C# Web API project, initialize a Git repository, and open it in Visual Studio Code with GitHub Copilot enabled.

Use the following steps to complete this task:

1. Open a terminal window (Command Prompt, PowerShell, or Terminal), and then navigate to the location where you want to create the project.

    For example:

    ```powershell
    cd C:\TrainingProjects
    ```

    Replace `C:\TrainingProjects` with your preferred location. You can use any directory where you have write permissions, and you can create a new folder location if needed.

1. To create a new C# Web API project, enter the following commands:

    ```powershell
    dotnet new webapi -n ContosoInventoryApi --use-controllers
    cd ContosoInventoryApi
    ```

    This creates a new ASP.NET Core Web API project with a controller-based structure. The project includes a sample `WeatherForecast` controller that you'll replace with inventory-related features.

1. To initialize a Git repository for the project, enter the following command:

    ```powershell
    git init
    ```

1. To open the project in Visual Studio Code, enter the following command:

    ```powershell
    code .
    ```

1. Take a moment to review the project structure.

    Use Visual Studio Code's EXPLORER view to review the project files. You should see a structure similar to the following:

    ```plaintext
    ContosoInventoryApi/
    ├── Controllers/
    │   └── WeatherForecastController.cs
    ├── Properties/
    │   └── launchSettings.json
    ├── appsettings.json
    ├── appsettings.Development.json
    ├── ContosoInventoryApi.csproj
    ├── ContosoInventoryApi.http
    ├── Program.cs
    └── WeatherForecast.cs
    ```

1. Verify that GitHub Copilot is active in Visual Studio Code.

    Look for the GitHub Copilot icon in the status bar at the bottom of the VS Code window. The icon should be visible and not show any warnings. If Copilot isn't active, sign in to your GitHub account using the Accounts icon in the Activity Bar.

1. Open the Copilot Chat view by selecting the Chat icon in the Activity Bar, or by pressing **Ctrl+Alt+I**.

    Verify that Copilot Chat opens successfully. You'll use Copilot Chat extensively throughout this exercise.

1. Build the project to verify that everything compiles correctly.

    Open a terminal in VS Code (**Terminal > New Terminal**) and enter:

    ```powershell
    dotnet build
    ```

    The build should complete successfully without errors.

## Create repository-level custom instructions to enforce coding standards

In this task, you create a `.github/copilot-instructions.md` file that provides Copilot with always-on guidelines for the project. These instructions are automatically included in every Copilot Chat request within the workspace.

Use the following steps to complete this task:

1. In Visual Studio Code's EXPLORER view, right-click the root folder of your project and select **New Folder**.

1. Name the folder **.github**.

    > **NOTE**: The folder name must start with a period. This is a convention used by GitHub for configuration files and is the standard location for Copilot instruction files.

1. Right-click the **.github** folder and select **New File**.

1. Name the file **copilot-instructions.md**.

1. Add the following content to the **copilot-instructions.md** file:

    ```markdown
    # Contoso Inventory API - Coding Standards

    ## Naming Conventions
    - Use PascalCase for class names, public methods, and public properties.
    - Use camelCase for local variables and method parameters.
    - Prefix private fields with an underscore (e.g., _inventoryService).
    - Suffix interface names with the interface prefix "I" (e.g., IInventoryService).

    ## Architecture Patterns
    - Follow the repository pattern for all data access operations.
    - Use dependency injection for all service dependencies. Register services in Program.cs.
    - Separate business logic into service classes. Controllers should only handle HTTP concerns.
    - Use DTOs (Data Transfer Objects) for API request and response payloads. Never expose database entities directly.

    ## Error Handling
    - Use try-catch blocks for all external API calls and database operations.
    - Return appropriate HTTP status codes (200 for success, 400 for bad requests, 404 for not found, 500 for server errors).
    - Log all exceptions using ILogger<T> with structured logging.
    - Include meaningful error messages in API responses.

    ## Documentation
    - Include XML documentation comments on all public methods and classes.
    - Use inline comments only for complex business logic that is not self-explanatory.

    ## Testing
    - Write unit tests using xUnit and Moq.
    - Follow the Arrange-Act-Assert pattern in test methods.
    - Name test methods using the pattern: MethodName_Scenario_ExpectedResult.
    ```

1. Save the file.

1. Verify that Copilot is picking up your custom instructions.

    Open the Copilot Chat view and enter the following prompt:

    ```plaintext
    What naming convention should I use for private fields in this project?
    ```

    Copilot should reference your custom instructions and respond with guidance to prefix private fields with an underscore. In the Copilot Chat response, look for a **References** section that cites `copilot-instructions.md` to verify the instructions are being applied.

    > **NOTE**: If you don't see the instructions being referenced, verify that the `chat.includeApplyingInstructions` setting is enabled in VS Code settings. This setting is on by default.

1. Test another aspect of the instructions.

    In Copilot Chat, enter the following prompt:

    ```plaintext
    How should I structure data access in this project?
    ```

    Copilot should mention the repository pattern as specified in your custom instructions.

## Create path-specific instruction files for targeted guidance

In this task, you create `.instructions.md` files that provide targeted coding guidelines for specific parts of the codebase. These files allow you to define different rules for controllers, services, and other areas of the project.

Use the following steps to complete this task:

1. In the **.github** folder, create a new folder named **instructions**.

1. In the **.github/instructions/** folder, create a new file named **controllers.instructions.md**.

1. Add the following content to **controllers.instructions.md**:

    ```markdown
    ---
    name: 'API Controller Standards'
    description: 'Coding standards for ASP.NET Core API controllers'
    applyTo: '**/Controllers/**/*.cs'
    ---
    # API Controller Standards

    - Inherit from ControllerBase and apply the [ApiController] attribute.
    - Use attribute routing with [Route("api/[controller]")] on the class.
    - Keep controller methods thin: delegate business logic to service classes.
    - Use action-specific attributes: [HttpGet], [HttpPost], [HttpPut], [HttpDelete].
    - Return IActionResult or ActionResult<T> from all action methods.
    - Include [ProducesResponseType] attributes to document response types.
    - Validate model state using data annotations on request DTOs.
    - Inject services through the constructor, not directly in action methods.
    ```

1. In the **.github/instructions/** folder, create a new file named **services.instructions.md**.

1. Add the following content to **services.instructions.md**:

    ```markdown
    ---
    name: 'Service Layer Standards'
    description: 'Coding standards for business logic service classes'
    applyTo: '**/Services/**/*.cs'
    ---
    # Service Layer Standards

    - Define a corresponding interface for every service class (e.g., IProductService for ProductService).
    - Use async/await for all I/O-bound operations (database calls, HTTP requests, file I/O).
    - Accept and return DTOs, not database entities.
    - Include comprehensive input validation at the start of each public method.
    - Throw specific exception types (ArgumentException, InvalidOperationException) rather than generic Exception.
    - Log significant operations using ILogger<T> with structured logging parameters.
    ```

1. Save both files.

1. Verify that the path-specific instructions are active.

    Open one of the controller files (for example, **Controllers/WeatherForecastController.cs**) and then open the Copilot Chat view. Right-click in the Chat view and select **Diagnostics** to inspect the loaded instruction files.

    You should see both `copilot-instructions.md` (repository-wide) and `controllers.instructions.md` (path-specific for controllers) listed as active instructions.

    > **NOTE**: Path-specific instructions are automatically merged with repository-wide instructions when Copilot works with files that match the `applyTo` pattern. The `description` field is also used for semantic matching, so Copilot may include these instructions when you ask about controllers or services even if a matching file isn't open.

## Create a reusable prompt file for a common task

In this task, you create a prompt file that defines a reusable slash command for generating API endpoint documentation. Prompt files standardize common tasks so your team can execute them consistently.

Use the following steps to complete this task:

1. In the **.github** folder, create a new folder named **prompts**.

1. In the **.github/prompts/** folder, create a new file named **generate-api-docs.prompt.md**.

1. Add the following content to **generate-api-docs.prompt.md**:

    ```markdown
    ---
    description: 'Generate API documentation for the active controller file'
    tools: ['search', 'read']
    ---
    # Generate API Documentation

    Analyze the controller in the active file and generate comprehensive API documentation.

    For each endpoint in the controller:
    1. List the HTTP method and route.
    2. Describe the purpose of the endpoint.
    3. Document the request parameters, body, and query string inputs.
    4. Document the possible response status codes and their meanings.
    5. Provide an example request and response in JSON format.

    Format the output as a Markdown document suitable for a developer wiki.
    ```

1. Save the file.

1. Verify that the prompt file is registered as a slash command.

    Open the Copilot Chat view and type `/` in the chat input. You should see `generate-api-docs` appear in the list of available slash commands.

    > **NOTE**: If the prompt file doesn't appear in the slash command list, verify that the `chat.promptFiles` setting is enabled in VS Code settings. You can check this by opening Settings (**Ctrl+,**) and searching for "prompt files."

1. Test the prompt file.

    Open the **Controllers/WeatherForecastController.cs** file, then in Copilot Chat, enter:

    ```plaintext
    /generate-api-docs
    ```

    Copilot should analyze the WeatherForecast controller and produce formatted API documentation for its endpoints. This demonstrates how prompt files standardize common tasks across the team.

## Define a "Planner" custom agent with read-only tools

In this task, you create a custom agent that acts as a planning assistant. The Planner agent analyzes feature requirements and generates implementation plans without writing or editing any code. It uses only read-only tools to gather context from the codebase.

Use the following steps to complete this task:

1. In the **.github** folder, create a new folder named **agents**.

1. In the **.github/agents/** folder, create a new file named **planner.agent.md**.

1. Add the following content to **planner.agent.md**:

    ```markdown
    ---
    description: Analyzes feature requirements and generates implementation plans without writing code
    tools: ['search', 'read', 'fetch']
    handoffs:
      - label: Start Implementation
        agent: implementer
        prompt: "Implement the plan outlined above. Follow the project's custom instructions for coding standards. Create all necessary files including models, DTOs, services, interfaces, and controllers."
        send: false
    ---
    # Planner

    You are a senior software architect working on a C# ASP.NET Core Web API project. When the user describes a feature or change, analyze the request and generate a detailed implementation plan.

    Before creating a plan, always search the existing codebase to understand the current project structure, coding patterns, and dependencies already in place.

    Your plan MUST include:
    1. **Summary**: A brief overview of the feature and its purpose.
    2. **Files to create or modify**: A complete list of files that need to be created or changed, with their full paths.
    3. **Implementation steps**: Step-by-step tasks in logical dependency order. Each step should specify what to do and which file to work in.
    4. **Models and DTOs**: Define the data structures needed, including property names and types.
    5. **Service interface and implementation**: Outline the service methods needed and their signatures.
    6. **Controller endpoints**: List the API endpoints to create, including HTTP methods, routes, request/response types, and status codes.
    7. **Dependency injection**: Specify any service registrations needed in Program.cs.
    8. **Risks and considerations**: Highlight potential issues, edge cases, or decisions that need input.

    IMPORTANT RULES:
    - Do NOT write or modify any code. Focus on planning only.
    - Do NOT create files. Your role is advisory.
    - Follow the project's established architecture patterns and coding standards.
    - Ask clarifying questions if the requirements are ambiguous.
    - Reference existing code patterns in the project for consistency.
    ```

1. Save the file.

1. Verify that the Planner agent appears in the Copilot Chat agents dropdown.

    In the Copilot Chat view, open the agents dropdown (it usually says "Copilot" or the name of the current agent). You should see **planner** listed among the available agents.

    > **TIP**: You can also type `/agents` in Copilot Chat to quickly view and switch between all available agents.

1. Select the **planner** agent.

    Notice that the chat input placeholder text changes to "Analyzes feature requirements and generates implementation plans without writing code" — this is the description you defined in the agent's frontmatter.

1. Test the Planner agent by entering the following prompt:

    ```plaintext
    Analyze the project structure and describe the current architecture, including any existing models, services, and controllers.
    ```

    The Planner agent should use the `search` and `read` tools to examine the project files and provide an overview of the current architecture. Since the agent only has read-only tools, it won't attempt to modify any files.

1. Switch back to the default Copilot agent by opening the agents dropdown and selecting **Copilot**.

## Define an "Implementer" custom agent with editing capabilities

In this task, you create a custom agent that implements code changes based on plans or instructions. The Implementer agent has editing capabilities and follows the project's custom instructions for coding standards.

Use the following steps to complete this task:

1. In the **.github/agents/** folder, create a new file named **implementer.agent.md**.

1. Add the following content to **implementer.agent.md**:

    ```markdown
    ---
    description: Implements code changes based on plans, following the project coding standards
    tools: ['search', 'read', 'edit', 'terminal']
    handoffs:
      - label: Review Code
        agent: reviewer
        prompt: "Review the code changes made in the implementation above. Check for bugs, security issues, naming convention violations, and adherence to the project's coding standards defined in the custom instruction files."
        send: false
    ---
    # Implementer

    You are an expert C# developer working on an ASP.NET Core Web API project. Your role is to implement code changes based on plans, feature requests, or bug fix descriptions.

    WORKFLOW:
    1. Read the plan or request carefully before writing any code.
    2. Search the existing codebase to understand current patterns, naming conventions, and dependencies.
    3. Implement changes following the project's established patterns and the coding standards defined in the custom instruction files.
    4. Create files in the correct project directories.
    5. After completing the implementation, provide a summary of all files created or modified.

    IMPLEMENTATION RULES:
    - Follow the repository pattern for data access. Create an interface and implementation for each service.
    - Use dependency injection. Register new services in Program.cs.
    - Use DTOs for API request and response payloads. Never expose database entities directly.
    - Include XML documentation comments on all public methods and classes.
    - Prefix private fields with an underscore.
    - Use PascalCase for public members, camelCase for local variables.
    - Include proper error handling with try-catch blocks for database and external API calls.
    - Use async/await for I/O-bound operations.
    - Return appropriate HTTP status codes from controller actions.
    ```

1. Save the file.

1. Verify that the agent appears in the agents dropdown.

    Open the Copilot Chat agents dropdown. You should now see both **planner** and **implementer** listed.

    Notice that the Planner agent includes a "Start Implementation" handoff button. This handoff is configured to switch to the Implementer agent when selected, carrying over the conversation context.

## Define a "Reviewer" custom agent for code quality checks

In this task, you create a custom agent that reviews code for bugs, security issues, and adherence to coding standards. The Reviewer agent uses only read-only tools, ensuring it doesn't accidentally modify code during its analysis.

Use the following steps to complete this task:

1. In the **.github/agents/** folder, create a new file named **reviewer.agent.md**.

1. Add the following content to **reviewer.agent.md**:

    ```markdown
    ---
    description: Reviews code for bugs, security issues, and coding standards compliance
    tools: ['search', 'read']
    handoffs:
      - label: Fix Issues
        agent: implementer
        prompt: "Fix the issues identified in the code review above. Address each finding in order of severity, starting with Critical and High issues first."
        send: false
    ---
    # Code Reviewer

    You are an experienced code reviewer specializing in C# and ASP.NET Core applications. When asked to review code, examine it thoroughly for issues across the following categories:

    ## Review Checklist
    1. **Bugs and logical errors**: Look for null reference risks, off-by-one errors, race conditions, and incorrect logic.
    2. **Security vulnerabilities**: Check for SQL injection, missing input validation, hardcoded secrets, missing authentication/authorization, and insecure data handling.
    3. **Naming convention violations**: Verify adherence to the project's naming standards (PascalCase for public members, underscore prefix for private fields, etc.).
    4. **Architecture compliance**: Confirm the code follows the repository pattern, uses dependency injection, and separates concerns properly.
    5. **Error handling**: Ensure try-catch blocks are present for external calls, appropriate HTTP status codes are returned, and exceptions are logged.
    6. **Missing documentation**: Flag public methods or classes that lack XML documentation comments.
    7. **Performance issues**: Identify unnecessary allocations, missing async/await, or inefficient queries.

    ## Output Format
    Present your findings as a structured review:
    - Group findings by severity: **Critical**, **High**, **Medium**, **Low**
    - For each finding, include:
      - The file and location
      - A description of the issue
      - A suggested fix
    - End with an **Overall Assessment** summarizing the code quality and any patterns of concern.

    IMPORTANT: Do NOT modify any files. Your role is advisory only.
    ```

1. Save the file.

1. Verify that all three agents appear in the agents dropdown.

    Open the Copilot Chat agents dropdown. You should now see **planner**, **implementer**, and **reviewer** listed alongside the built-in agents.

1. Take a moment to review the agent chain you've configured.

    The handoff configuration creates the following workflow:

    - **Planner** → (Start Implementation) → **Implementer**: After the Planner produces a plan, you can hand off to the Implementer to write the code.
    - **Implementer** → (Review Code) → **Reviewer**: After the Implementer writes code, you can hand off to the Reviewer to check the code quality.
    - **Reviewer** → (Fix Issues) → **Implementer**: If the Reviewer finds issues, you can hand off back to the Implementer to apply fixes.

    Each handoff uses `send: false`, which means the prompt is pre-filled for you to review and edit before submitting. This keeps you in control at every step of the workflow.

## Run the chained agents workflow to complete a development task end-to-end

In this task, you run the full Planning → Implementation → Review workflow using your custom agents to add a new inventory management feature to the project. This demonstrates how chaining agents creates a structured, multi-step development process.

Use the following steps to complete this task:

1. Open the Copilot Chat view and select the **planner** agent from the agents dropdown.

1. Enter the following prompt to request a feature plan:

    ```plaintext
    I need to add a Product Inventory management feature to this Web API. The feature should support:
    - A Product model with: Id (int), Name (string), Sku (string), Description (string), Price (decimal), StockQuantity (int), Category (string), CreatedDate (DateTime), LastUpdatedDate (DateTime).
    - CRUD operations for products (Create, Read by ID, Read all with filtering by category, Update, Delete).
    - A restock endpoint that increases the StockQuantity for a specific product.
    - Input validation on all create/update operations.
    - The project should use an in-memory list for data storage (no database required for this exercise).
    ```

    The Planner agent should search the existing codebase to understand the current structure and then produce a detailed implementation plan. The plan should include the files to create, implementation steps, model definitions, service interfaces, controller endpoints, and dependency injection registrations.

1. Review the plan produced by the Planner agent.

    Verify that the plan:

    - Lists all files to be created (models, DTOs, interfaces, services, controllers).
    - Follows the naming conventions from your custom instructions (PascalCase, underscore prefix for private fields).
    - Uses the repository pattern / service layer pattern as specified in your instructions.
    - Includes DTOs for API payloads rather than exposing entities directly.
    - Specifies dependency injection registrations in Program.cs.

    > **NOTE**: If the plan doesn't align with your custom instructions, you can ask the Planner to revise it. For example: "Revise the plan to use DTOs for all API request and response types, as required by our coding standards."

1. When you're satisfied with the plan, select the **Start Implementation** handoff button.

    This button appears at the end of the Planner agent's response. When you select it, Copilot Chat:

    - Switches to the **implementer** agent.
    - Carries over the conversation history, including the full plan.
    - Pre-fills the prompt text: "Implement the plan outlined above..."

1. Review the pre-filled prompt and select **Send** (or press **Enter**) to submit it.

    The Implementer agent begins writing the code based on the Planner's plan. It creates the models, DTOs, service interface, service implementation, and controller. Watch as it creates files and follows the coding standards from your custom instruction files.

    > **NOTE**: The implementation may take a few minutes depending on the complexity of the plan. The Implementer agent uses the `edit` and `terminal` tools to create files and potentially run build commands.

1. After the Implementer finishes, review the summary of files created.

    The Implementer should have created files similar to the following (exact names and locations may vary based on the plan):

    - **Models/Product.cs**: The product entity.
    - **DTOs/ProductDto.cs** (or similar): DTOs for create, update, and response payloads.
    - **Services/IProductService.cs**: The service interface.
    - **Services/ProductService.cs**: The service implementation with in-memory data storage.
    - **Controllers/ProductsController.cs**: The API controller with CRUD and restock endpoints.
    - Updated **Program.cs**: Service registration via dependency injection.

1. Build the project to verify that the generated code compiles.

    In the terminal, enter:

    ```powershell
    dotnet build
    ```

    If the build has errors, you can ask the Implementer agent to fix them. For example: "The build has the following errors. Please fix them." Then paste the error output.

1. Select the **Review Code** handoff button to switch to the Reviewer agent.

    The Reviewer agent receives the full conversation context, including the plan and the implementation. The pre-filled prompt asks it to review the code changes.

1. Review the pre-filled prompt and select **Send** to submit it.

    The Reviewer agent examines all the created files, checking for bugs, security issues, naming convention violations, and compliance with the project's coding standards. It presents findings grouped by severity.

1. Review the Reviewer's findings.

    The review should check that:

    - Naming conventions match the custom instructions (PascalCase for public members, underscore prefix for private fields).
    - The service layer pattern is followed with proper interface/implementation separation.
    - DTOs are used for API payloads instead of entities.
    - Error handling includes try-catch blocks and proper HTTP status codes.
    - XML documentation comments are present on public methods.
    - Input validation is implemented on create/update operations.

    > **NOTE**: The Reviewer may identify issues that the Implementer missed. This is expected and demonstrates the value of having specialized agents review each other's work.

1. If the Reviewer identifies issues, select the **Fix Issues** handoff button.

    This hands off back to the Implementer agent with a prompt to fix the issues identified in the review. The Implementer addresses each finding in order of severity.

1. After the fixes are applied, verify the project builds successfully.

    ```powershell
    dotnet build
    ```

1. Optionally, test the API by running the application.

    Start the application:

    ```powershell
    dotnet run
    ```

    Open a browser and navigate to the Swagger UI (typically at `http://localhost:<port>/swagger`). You can test the CRUD endpoints:

    - **POST /api/products**: Create a new product with a JSON body.
    - **GET /api/products**: List all products (try filtering by category if supported).
    - **GET /api/products/{id}**: Get a specific product.
    - **PUT /api/products/{id}**: Update a product.
    - **DELETE /api/products/{id}**: Delete a product.
    - **POST /api/products/{id}/restock** (or similar): Restock a product.

    When you're done testing, press **Ctrl+C** in the terminal to stop the application.

## Summary

In this exercise, you successfully configured and customized GitHub Copilot in Visual Studio Code for a C# Web API project. You:

- **Created repository-level custom instructions** (`.github/copilot-instructions.md`) that embed your team's coding standards—naming conventions, architecture patterns, error handling, and documentation requirements—into every Copilot Chat interaction.
- **Created path-specific instruction files** (`.github/instructions/*.instructions.md`) that provide targeted guidance for controllers and services, using `applyTo` glob patterns to match specific file locations.
- **Created a reusable prompt file** (`.github/prompts/generate-api-docs.prompt.md`) that standardizes API documentation generation as a slash command.
- **Defined three custom agents** (Planner, Implementer, and Reviewer) with tailored instructions, tool permissions, and behavioral guidelines for each development role.
- **Configured handoffs** between agents to create a structured Planning → Implementation → Review workflow with developer oversight at each transition.
- **Ran the complete chained workflow** to add a Product Inventory feature end-to-end, demonstrating how the agents collaborate while following the project's coding standards.

This pattern—embedding team knowledge in instruction files and orchestrating specialized agents through handoffs—is applicable to any development project. You can adapt these techniques for other scenarios such as Test-Driven Development (Test Writer → Implementer), debugging workflows (Debugger → Patcher → Tester), or migration projects (Analyzer → Upgrader → Reviewer).

## Clean up

Now that you've finished the exercise, take a minute to clean up your environment:

- Stop the application if it's still running (press **Ctrl+C** in the terminal).
- Optionally archive or delete the project directory.
