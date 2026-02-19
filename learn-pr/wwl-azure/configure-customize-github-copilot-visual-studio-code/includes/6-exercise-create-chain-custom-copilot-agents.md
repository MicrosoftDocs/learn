> [!IMPORTANT]
> To complete this exercise, you need an active GitHub account and a Visual Studio Code environment with GitHub Copilot enabled. If you don't have a GitHub account, you can [sign up](https://github.com/) for a free individual account and use a GitHub Copilot Free plan to complete the exercise. For help with enabling GitHub Copilot in Visual Studio Code, see [Enable GitHub Copilot in Visual Studio Code](https://go.microsoft.com/fwlink/?linkid=2320158&azure-portal=true).

In this exercise, you configure a C# project to use custom GitHub Copilot instructions and create custom agents that collaborate through handoffs. Tasks include:

1. Set up a C# project and configure the development environment.
1. Create repository-level custom instructions to enforce coding standards.
1. Define a "Planner" custom agent with read-only tools.
1. Define an "Implementer" custom agent with editing capabilities.
1. Define a "Tester" custom agent or use the built-in test capabilities.
1. Run the chained agents workflow to complete a development task end-to-end.

When you select the launch exercise button, the browser navigates to a public GitHub page that provides instructions for this exercise.

When you finish the exercise, return here for:

- A quick knowledge check.
- A summary of what you learned during this module.
- A badge for completing this module.




**TODO: UPDATE THE LINK IN THE BUTTON BELOW TO POINT TO THE EXERCISE REPO ONCE IT'S CREATED.**




[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2352126&azure-portal=true)




---
lab:
    title: 'Exercise - Configure and customize GitHub Copilot in Visual Studio Code'
    description: 'Learn how to configure a C# project to use custom Copilot instructions and create custom agents that collaborate through handoffs.'
    level: 300
    duration: 50 minutes
---

# Configure and customize GitHub Copilot in Visual Studio Code

GitHub Copilot provides powerful AI-assisted coding out of the box, but its true potential emerges when you customize it to match your team's specific workflows and project requirements. By providing custom instructions and creating specialized agents, you can transform GitHub Copilot from a general-purpose assistant into a set of tailored AI collaborators that understand your codebase, follow your conventions, and handle multi-step development tasks.

In this exercise, you configure the ContosoInventory C# Web API project to use custom Copilot instructions and create custom agents that collaborate through handoffs to complete a development task end-to-end.

This exercise should take approximately **50** minutes to complete.

> **IMPORTANT**: To complete this exercise, you must provide your own GitHub account and GitHub Copilot subscription. If you don't have a GitHub account, you can <a href="https://github.com/" target="_blank">sign up</a> for a free individual account and use a GitHub Copilot Free plan to complete the exercise. If you have access to a GitHub Copilot Pro, GitHub Copilot Pro+, GitHub Copilot Business, or GitHub Copilot Enterprise subscription from within your lab environment, you can use your existing GitHub Copilot subscription to complete this exercise.

## Before you start

Your lab environment MUST include the following resources:

- Git 2.48 or later.
- The .NET SDK version 8.0 or later.
- Access to a GitHub account with GitHub Copilot enabled.
- Visual Studio Code (version 1.106 or later) with the C# Dev Kit and GitHub Copilot Chat extensions.

## Exercise scenario

You're a software developer working for a consulting firm. The firm developed the ContosoInventory web application (a Blazor WebAssembly application with an ASP.NET Core backend) for Contoso's IT department. The application manages inventory categories for tracking equipment used across the organization. The client has specific coding standards, architectural patterns, and review processes, and they've asked you to add a Product Inventory management feature so individual products can be tracked within each category.

You decide to use GitHub Copilot's customization features to accelerate development while ensuring that all code adheres to the client's standards:

1. Create custom instruction files that embed the client's coding standards into Copilot's behavior so that all AI-generated code follows the established conventions.
1. Define custom agents for specific development roles—a "Planner" that designs implementation plans, an "Implementer" that writes code, and a "Reviewer" that checks code quality.
1. Chain these agents together using handoffs to create a structured multi-step workflow from planning through implementation to review.

The ContosoInventory application uses a three-project architecture:

- **ContosoInventory.Server**: ASP.NET Core Web API with Entity Framework Core, Identity authentication, and SQLite.
- **ContosoInventory.Client**: Blazor WebAssembly SPA that runs in the browser and calls the server API.
- **ContosoInventory.Shared**: Shared class library containing models, DTOs, and enums.

For the purposes of this lab exercise, you can test the application using two user accounts (Mateo Gomez and Megan Bowen). Mateo has the Admin role and can perform all CRUD operations on categories. Megan has the Viewer role and can only view categories.

This exercise includes the following tasks:

1. Review features of the ContosoInventory application.
1. Create repository-level custom instructions to enforce coding standards.
1. Create path-specific instruction files for targeted guidance.
1. Create a reusable prompt file for a common task.
1. Define a "Planner" custom agent with read-only tools.
1. Define an "Implementer" custom agent with editing capabilities.
1. Define a "Reviewer" custom agent for code quality checks.
1. Run the chained agents workflow to complete a development task end-to-end.

## Review features of the ContosoInventory application

Before adding Copilot customization files, you need to become familiar with the existing application features.

Use the following steps to complete this task:

1. Open a browser window and navigate to GitHub.com.

    You can log in to your GitHub account using the following URL: <a href="https://github.com/login" target="_blank">GitHub login</a>.

1. Sign in to your GitHub account, and then open your repositories tab.

    You can open your repositories tab by clicking on your profile icon in the top-right corner, then selecting **Repositories**.

1. On the Repositories tab, select the **New** button.

1. Under the **Create a new repository** section, select **Import a repository**.

1. On the **Import your project to GitHub** page, under **Your source repository details**, enter the following URL for the source repository:

    ```plaintext
    https://github.com/MicrosoftLearning/github-copilot-customization-starter-app
    ```

1. Under the **Your new repository details** section, in the **Owner** dropdown, select your GitHub username.

1. In the **Repository name** field, enter **ContosoInventory**

    GitHub automatically checks the availability of the repository name. If this name is already taken, append a unique suffix (for example, your initials or a random number) to the repository name to make it unique.

1. To create a private repository, select **Private**, and then select **Begin import**.

    GitHub uses the import process to create the new repository in your account.

    > **NOTE**: It can take a minute or two for the import process to finish. Wait for the import process to complete.

    GitHub displays a progress indicator and notifies you when the import is complete.

1. Once the import is complete, open your new repository.

    A link to your repository should be displayed. Your repository should be located at: `https://github.com/YOUR-USERNAME/ContosoInventory`.

1. On your ContosoInventory repository page, select the **Code** button, and then copy the HTTPS URL.

    The URL should be similar to: `https://github.com/YOUR-USERNAME/ContosoInventory.git`

1. Open a terminal window in your development environment, and then navigate to the location where you want to create the local clone of the repository.

    For example:

    ```powershell
    cd C:\TrainingProjects
    ```

    Replace `C:\TrainingProjects` with your preferred location. You can use any directory where you have write permissions, and you can create a new folder location if needed.

1. To clone your ContosoInventory repository, enter the following command:

    Be sure to replace `YOUR-USERNAME` with your actual GitHub username before running the command.

    ```powershell
    git clone https://github.com/YOUR-USERNAME/ContosoInventory.git
    ```

    You might be prompted to authenticate using your GitHub credentials during the clone operation. You can authenticate using your browser.

1. To navigate into your ContosoInventory directory and open it in Visual Studio Code, enter the following commands:

    ```powershell
    cd ContosoInventory
    code .
    ```

1. Take a moment to review the project structure.

    Use Visual Studio Code's EXPLORER view to expand the project folders. You should see a folder structure similar to the following:

    ```plaintext
    ContosoInventory/
    ├── ContosoInventory.Server/
    │   ├── App_Data/                           (SQLite database file location)
    │   ├── Controllers/
    │   │   ├── AuthController.cs               (Login, Logout, GetCurrentUser)
    │   │   └── CategoriesController.cs         (CRUD + toggle-active)
    │   ├── Data/
    │   │   ├── InventoryContext.cs             (EF Core DbContext)
    │   │   ├── DbInitializer.cs               (Database seeding)
    │   │   └── Migrations/                     (EF Core migrations)
    │   ├── Models/
    │   │   └── Category.cs                     (Category entity)
    │   ├── Services/
    │   │   ├── ICategoryService.cs             (Category service interface)
    │   │   └── CategoryService.cs              (Category service implementation)
    │   ├── Properties/
    │   │   └── launchSettings.json
    │   ├── appsettings.json
    │   ├── appsettings.Development.json
    │   ├── ContosoInventory.Server.csproj
    │   └── Program.cs
    ├── ContosoInventory.Client/
    │   ├── Layout/
    │   │   ├── MainLayout.razor                (Application shell with nav bar)
    │   │   └── NavMenu.razor                   (Navigation menu component)
    │   ├── Pages/
    │   │   ├── Home.razor                      (Dashboard with category stats)
    │   │   ├── Login.razor                     (Login form)
    │   │   └── Categories.razor                (Category management page)
    │   ├── Services/
    │   │   ├── CategoryApiService.cs           (HTTP client for category API)
    │   │   └── CookieAuthStateProvider.cs      (Custom AuthenticationStateProvider)
    │   ├── wwwroot/
    │   │   ├── css/
    │   │   │   └── app.css                     (Application styles)
    │   │   └── index.html                      (Blazor host page)
    │   ├── _Imports.razor
    │   ├── App.razor                           (Root component with routing)
    │   ├── ContosoInventory.Client.csproj
    │   └── Program.cs
    ├── ContosoInventory.Shared/
    │   ├── DTOs/
    │   │   ├── CategoryResponseDto.cs
    │   │   ├── CreateCategoryDto.cs
    │   │   ├── UpdateCategoryDto.cs
    │   │   ├── LoginDto.cs
    │   │   └── UserInfoDto.cs
    │   ├── ContosoInventory.Shared.csproj
    │   └── GlobalUsings.cs
    └── ContosoInventory.sln
    ```

1. Open the **ContosoInventory.Server/Program.cs** file and review the application configuration.

    Notice the following key configuration areas:

    - Entity Framework Core with SQLite for data access
    - ASP.NET Core Identity for authentication with cookie-based sessions and account lockout
    - Service registrations for `ICategoryService`
    - Database seeding via `DbInitializer.InitializeAsync` at startup
    - CORS, rate limiting, CSRF protection, and security headers middleware

1. Open the **ContosoInventory.Server/Controllers/CategoriesController.cs** file and note the existing API endpoints.

    The categories controller provides the following endpoints:

    - `GetAllCategories`: Gets all categories ordered by display order
    - `GetCategoryById`: Gets a specific category by ID
    - `CreateCategory`: Creates a new category (Admin only)
    - `UpdateCategory`: Updates an existing category (Admin only)
    - `DeleteCategory`: Deletes a category (Admin only)
    - `ToggleActive`: Toggles the active status of a category (Admin only)

1. Open the **ContosoInventory.Server/Services/CategoryService.cs** file and review the service implementation.

    Notice the patterns used: async/await for all database operations, DTO mapping, structured logging, input validation, and error handling with try-catch blocks. The Copilot agents will reference these patterns when creating a Product feature later in the exercise.

1. Open a terminal in Visual Studio Code and build the solution.

    ```powershell
    cd ContosoInventory/ContosoInventory.Server
    dotnet build
    ```

    > **IMPORTANT**: The project uses .NET 8 by default. If you have the .NET 9 or .NET 10 SDK installed, but not .NET 8, you need to update the project to target the version of .NET that you have installed. For AI assistance with updating to a later version of .NET, open the GitHub Copilot Chat view and ask GitHub Copilot to update your project files to the version of .NET that you have installed in your environment.

    The build should complete successfully without errors (there might be warnings).

1. Start the server application.

    ```powershell
    dotnet run
    ```

    > **NOTE**: The first time you run the application, it may take a little extra time to apply database migrations and seed the database with sample data. You should see console output indicating that the database has been initialized and seeded. You should also see a message that the server starts listening on `http://localhost:5240`.

1. Open a browser and navigate to `http://localhost:5240`.

    The application should open to the ContosoInventory login page. You should see a login form along with a **Lab Exercise — Test Accounts** information card that displays the demo credentials for both test users.

1. Sign in using the Admin demo credentials.

    Enter `mateo@contoso.com` for the email and `Password123!` for the password, and then select **Sign in**.

1. Verify that the Home page displays category statistics.

    You should see a welcome message and statistics showing 8 total categories, 7 active, and 1 inactive.

1. Navigate to the **Categories** page and verify that all 8 categories are listed.

    You should see categories like Laptops & Desktops, Monitors & Displays, Networking Equipment, and others. As an Admin, you should also see Add Category, Edit, Deactivate/Activate, and Delete action buttons.

1. Log out and sign in with the Viewer credentials.

    Enter `megan@contoso.com` for the email and `Password123!` for the password.

1. Navigate to the **Categories** page and verify that Admin-only action buttons (Add Category, Edit, Deactivate/Activate, Delete) are not visible.

    As a Viewer, Megan can see the category list but cannot modify data.

1. Log out from the application.

1. To stop the application, return to the Visual Studio Code integrated terminal where the server is running, and then press **Ctrl+C**.

    > **NOTE**: You can leave the terminal open for the next task.

1. Verify that GitHub Copilot is active in Visual Studio Code.

    Look for the GitHub Copilot icon in the status bar at the bottom of the VS Code window. The icon should be visible and not show any warnings. If Copilot isn't active, sign in to your GitHub account using the Accounts icon in the Activity Bar.

1. Open the Copilot Chat view by selecting the Chat icon in the Activity Bar, or by pressing **Ctrl+Alt+I**.

    Verify that Copilot Chat opens successfully. You'll use Copilot Chat extensively throughout this exercise.

## Create repository-level custom instructions to enforce coding standards

In this task, you create a `.github/copilot-instructions.md` file that provides Copilot with always-on guidelines for the project. These instructions are automatically included in every Copilot Chat request within the workspace.

Use the following steps to complete this task:

1. Before creating custom instructions manually, try the `/init` shortcut to see what Copilot generates automatically.

    Open the Copilot Chat view and enter the following command:

    ```plaintext
    /init
    ```

    Copilot analyzes your workspace—detecting the C# language, ASP.NET Core framework, Entity Framework Core, and the project structure—and generates a starter `copilot-instructions.md` file tailored to what it finds.

1. Review the generated instructions.

    Examine the content that `/init` produced. Notice that Copilot infers general best practices for the detected technology stack, but it doesn't know about the client's specific coding standards, such as the underscore prefix for private fields, the repository pattern requirement, or the xUnit testing conventions. The `/init` command is a useful starting point, but you'll replace it with manually crafted instructions that reflect the client's exact requirements.

1. Delete the generated file so you can create one from scratch.

    If `/init` created a `.github/copilot-instructions.md` file, delete it. If `/init` also created the `.github` folder, you can keep the folder—you'll use it in the next step.

1. In Visual Studio Code's EXPLORER view, create a **.github** folder in the root of your project if one doesn't already exist.

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

    > **NOTE**: VS Code also recognizes `AGENTS.md` and `CLAUDE.md` files as always-on instructions. An `AGENTS.md` file placed in the root of your workspace works similarly to `copilot-instructions.md` and is useful when you work with multiple AI tools and want a single set of instructions recognized by all of them. Additionally, nested `AGENTS.md` files can be placed in subdirectories to provide context-specific instructions that apply only when Copilot operates on files within that directory or its children. For this exercise, you use the `.github/copilot-instructions.md` convention, which is the standard approach for GitHub Copilot customization.

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

    Open the **ContosoInventory.Server/Controllers/CategoriesController.cs** file in the editor, and then open the Copilot Chat view. Right-click in the Chat view and select **Diagnostics** to inspect the loaded instruction files.

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
    agent: 'copilot'
    tools: ['search', 'read']
    ---
    # Generate API Documentation

    Analyze the controller in ${file} and generate comprehensive API documentation.

    For each endpoint in the controller:
    1. List the HTTP method and route.
    2. Describe the purpose of the endpoint.
    3. Document the request parameters, body, and query string inputs.
    4. Document the possible response status codes and their meanings.
    5. Provide an example request and response in JSON format.

    Format the output as a Markdown document suitable for a developer wiki.
    ```

    The `${file}` syntax is a **prompt file variable** that automatically resolves to the file currently open in the editor. When you run this prompt with a controller file open, Copilot receives the full contents of that file as context. Prompt files also support `${selection}` (the currently selected text) and custom variables that prompt the user for input when the prompt is executed.

    The `agent` field in the frontmatter specifies which agent handles the prompt when the slash command is invoked. Here it's set to `copilot` (the default agent), but you could set it to a custom agent name—for example, after creating the Reviewer agent later in this exercise, you could change this to `agent: 'reviewer'` to have documentation generated through the Reviewer's lens. The frontmatter also supports an optional `model` field for specifying a preferred AI model.

1. Save the file.

1. Verify that the prompt file is registered as a slash command.

    Open the Copilot Chat view and type `/` in the chat input. You should see `generate-api-docs` appear in the list of available slash commands.

    > **NOTE**: If the prompt file doesn't appear in the slash command list, verify that the `chat.promptFiles` setting is enabled in VS Code settings. You can check this by opening Settings (**Ctrl+,**) and searching for "prompt files."

1. Test the prompt file.

    Open the **ContosoInventory.Server/Controllers/CategoriesController.cs** file in the editor, then in Copilot Chat, enter:

    ```plaintext
    /generate-api-docs
    ```

    Copilot should analyze the CategoriesController and produce formatted API documentation for all six endpoints (GET all, GET by ID, POST, PUT, DELETE, and toggle-active). This demonstrates how prompt files standardize common tasks across the team and shows meaningful output because the existing controller has multiple endpoints with different HTTP methods, authorization levels, and response types.

1. Verify that the `${file}` variable resolved correctly.

    In the Copilot Chat response, the documentation should specifically reference `CategoriesController.cs` — the file you had open in the editor. The `${file}` variable provided the controller's contents as context to the prompt. If you close all editor tabs and run `/generate-api-docs` again, Copilot won't have a specific controller to analyze and will produce a more generic or less accurate response, demonstrating that the variable provides meaningful context.

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
      - label: Write Tests First
        agent: implementer
        prompt: "Before implementing the feature, write unit tests based on the plan outlined above. Use xUnit and Moq following the project's testing conventions. Create test classes that cover the service methods and controller actions described in the plan. Do not implement the production code yet—only the tests."
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

    > **NOTE**: The Planner agent defines **two handoffs**: "Start Implementation" and "Write Tests First." Both target the implementer agent but with different prompts—one for writing production code and one for writing tests first. This gives you the flexibility to choose your development approach (implementation-first or test-driven) after reviewing the plan. You'll see both handoff buttons appear after the Planner produces a response in a later task.

    > **TIP**: Each handoff entry also supports an optional `model` field that specifies a different AI model for that stage of the workflow. The format is `model: "Model Name (vendor)"` (for example, `model: "GPT-4.1 (OpenAI)"` or `model: "Claude Sonnet 4 (Anthropic)"`). This is useful when different workflow stages benefit from different model capabilities—for instance, using a reasoning model for planning and a faster model for implementation. The available models depend on your Copilot subscription.

1. Test the Planner agent by entering the following prompt:

    ```plaintext
    Analyze the project structure and describe the current architecture, including any existing models, services, and controllers. Identify the patterns used in the Category feature implementation.
    ```

    The Planner agent should use the `search` and `read` tools to examine the project files and provide a detailed overview of the current architecture. It should identify the Category model, CategoryService, CategoriesController, the DTO pattern, dependency injection setup, and the overall three-project architecture. Since the agent only has read-only tools, it won't attempt to modify any files.

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

    Notice that the Planner agent includes two handoff buttons: **"Start Implementation"** and **"Write Tests First."** Both handoffs target the Implementer agent but with different prompts. The "Start Implementation" handoff directs the Implementer to write production code, while "Write Tests First" directs it to write unit tests before any production code. This demonstrates how a single agent can offer **multiple handoffs** that let the developer choose the appropriate next step based on the situation.

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

    > **NOTE**: The `send` field controls whether the handoff prompt is submitted automatically. When set to `false` (the default), the prompt is pre-filled in the chat input for you to review and optionally edit before sending. When set to `true`, the prompt is submitted immediately and the target agent begins working right away without waiting for your approval. All handoffs in this exercise use `send: false` to keep you in control at each transition. In fully automated pipelines where you trust the agent chain to operate without supervision, `send: true` can streamline the workflow—but it removes the human-in-the-loop checkpoint.

    > **NOTE**: By default, custom agents run on the client (inside VS Code). For long-running tasks—such as building an entire feature or running a comprehensive test suite—you can set `target: cloud` in the agent's YAML frontmatter to run the agent remotely. Cloud agents free your local VS Code instance while the agent processes in the background. Background agents are a related concept: they run independently without blocking the chat interface, allowing you to continue working while the agent completes its task. The available execution environments depend on your Copilot subscription.

## Run the chained agents workflow to complete a development task end-to-end

In this task, you run the full Planning → Implementation → Review workflow using your custom agents to add a new inventory management feature to the project. This demonstrates how chaining agents creates a structured, multi-step development process.

Use the following steps to complete this task:

1. Open the Copilot Chat view and select the **planner** agent from the agents dropdown.

1. Enter the following prompt to request a feature plan:

    ```plaintext
    I need to add a Product Inventory management feature to this Web API, following the same patterns used by the existing Category feature. The feature should support:
    - A Product model with: Id (int), Name (string), Sku (string), Description (string), Price (decimal), StockQuantity (int), CategoryId (int, foreign key to Category), CreatedDate (DateTime), LastUpdatedDate (DateTime).
    - CRUD operations for products (Create, Read by ID, Read all with optional filtering by CategoryId, Update, Delete).
    - A restock endpoint that increases the StockQuantity for a specific product.
    - Input validation on all create/update operations.
    - Authorization: Admin role required for create, update, delete, and restock operations. All authenticated users can read.
    - Use Entity Framework Core with the existing SQLite database (add Product to the DbContext and create a migration).
    - Follow the same service interface, DTO, and controller patterns used in the Category feature.
    ```

    The Planner agent should search the existing codebase, analyze the Category implementation patterns (model, DTOs, service interface, service implementation, controller), and produce a detailed implementation plan that mirrors the established architecture.

1. Review the plan produced by the Planner agent.

    Verify that the plan:

    - Lists all files to be created (Product model, Product DTOs, IProductService interface, ProductService implementation, ProductsController).
    - Follows the naming conventions from your custom instructions (PascalCase, underscore prefix for private fields).
    - Uses the same service layer pattern established in the existing CategoryService.
    - Includes DTOs for API payloads rather than exposing entities directly.
    - Recognizes the CategoryId foreign key relationship between Product and Category.
    - Specifies dependency injection registrations in Program.cs.
    - Includes a migration step for adding the Product table to the SQLite database.
    - Mentions authorization requirements (Admin-only for write operations).

    > **NOTE**: If the plan doesn't align with your custom instructions or the existing Category patterns, you can ask the Planner to revise it. For example: "Revise the plan to follow the same DTO patterns used in the Category feature, including separate CreateProductDto, UpdateProductDto, and ProductResponseDto types."

1. When you're satisfied with the plan, select the **Start Implementation** handoff button.

    You should see two handoff buttons at the end of the Planner's response: **"Start Implementation"** and **"Write Tests First."** Select **"Start Implementation"** to proceed with the implementation-first approach. When you select it, Copilot Chat:

    - Switches to the **implementer** agent.
    - Carries over the conversation history, including the full plan.
    - Pre-fills the prompt text: "Implement the plan outlined above..."

    > **NOTE**: The "Write Tests First" button is available if you prefer a test-driven development approach. It sends a different prompt to the Implementer that focuses on creating unit tests before production code. For this exercise, you'll use "Start Implementation" to proceed with the main workflow.

1. Review the pre-filled prompt and select **Send** (or press **Enter**) to submit it.

    The Implementer agent begins writing the code based on the Planner's plan. It creates the models, DTOs, service interface, service implementation, and controller. Watch as it creates files and follows the coding standards from your custom instruction files.

    > **NOTE**: The implementation may take a few minutes depending on the complexity of the plan. The Implementer agent uses the `edit` and `terminal` tools to create files and potentially run build commands.

1. After the Implementer finishes, review the summary of files created.

    The Implementer should have created files similar to the following (exact names and locations may vary based on the plan):

    - **ContosoInventory.Server/Models/Product.cs**: The product entity with CategoryId foreign key.
    - **ContosoInventory.Shared/DTOs/ProductResponseDto.cs** (or similar): Response DTO.
    - **ContosoInventory.Shared/DTOs/CreateProductDto.cs** (or similar): Creation DTO with validation attributes.
    - **ContosoInventory.Shared/DTOs/UpdateProductDto.cs** (or similar): Update DTO with validation attributes.
    - **ContosoInventory.Server/Services/IProductService.cs**: The service interface.
    - **ContosoInventory.Server/Services/ProductService.cs**: The service implementation using EF Core.
    - **ContosoInventory.Server/Controllers/ProductsController.cs**: The API controller with CRUD, restock, and authorization.
    - Updated **ContosoInventory.Server/Data/InventoryContext.cs**: Added `DbSet<Product>` and model configuration.
    - Updated **ContosoInventory.Server/Program.cs**: Service registration via dependency injection.
    - A new EF Core migration for the Product table.

1. Build the project to verify that the generated code compiles.

    In the terminal, ensure you're in the **ContosoInventory.Server** directory, and then enter:

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
    - The service layer pattern is followed consistently with the existing CategoryService (interface/implementation separation).
    - DTOs are used for API payloads instead of entities.
    - Error handling includes try-catch blocks and proper HTTP status codes.
    - XML documentation comments are present on public methods.
    - Input validation is implemented on create/update operations.
    - Authorization attributes are applied correctly (Admin-only for write operations).
    - The CategoryId foreign key relationship is properly configured.

    > **NOTE**: The Reviewer may identify issues that the Implementer missed. This is expected and demonstrates the value of having specialized agents review each other's work. The Reviewer can compare the new Product code directly against the existing Category implementation for consistency.

1. If the Reviewer identifies issues, select the **Fix Issues** handoff button.

    This hands off back to the Implementer agent with a prompt to fix the issues identified in the review. The Implementer addresses each finding in order of severity.

1. After the fixes are applied, verify the project builds successfully.

    Ensure you're in the **ContosoInventory.Server** directory, and then enter:

    ```powershell
    dotnet build
    ```

1. Optionally, test the API by running the application.

    Start the application:

    ```powershell
    dotnet run
    ```

    Open a browser and navigate to the Swagger UI at `http://localhost:5240/swagger`. You can test the new Product endpoints alongside the existing Category endpoints. First, use **POST /api/auth/login** with `mateo@contoso.com` / `Password123!` to authenticate as the Admin user, then test:

    - **POST /api/products**: Create a new product with a JSON body. Use a valid `CategoryId` from the existing categories (e.g., 1 for "Laptops & Desktops").
    - **GET /api/products**: List all products (try filtering by CategoryId if supported).
    - **GET /api/products/{id}**: Get a specific product.
    - **PUT /api/products/{id}**: Update a product.
    - **DELETE /api/products/{id}**: Delete a product.
    - **POST /api/products/{id}/restock** (or similar): Restock a product.

    When you're done testing, press **Ctrl+C** in the terminal to stop the application.

## Summary

In this exercise, you successfully configured and customized GitHub Copilot in Visual Studio Code for the ContosoInventory C# Web API project. You:

- **Imported and reviewed the ContosoInventory starter application** to understand the existing three-project architecture (Server, Client, Shared), Category feature implementation, and security configuration with role-based authorization.
- **Explored the `/init` shortcut** to auto-generate a starter instruction file, then **created repository-level custom instructions** (`.github/copilot-instructions.md`) with the client's specific coding standards—naming conventions, architecture patterns, error handling, and documentation requirements—embedded into every Copilot Chat interaction.
- **Created path-specific instruction files** (`.github/instructions/*.instructions.md`) that provide targeted guidance for controllers and services, using `applyTo` glob patterns to match specific file locations.
- **Created a reusable prompt file** (`.github/prompts/generate-api-docs.prompt.md`) that standardizes API documentation generation as a slash command, using the `${file}` variable to pass the active editor file as context, and tested it against the existing CategoriesController.
- **Defined three custom agents** (Planner, Implementer, and Reviewer) with tailored instructions, tool permissions, and behavioral guidelines for each development role.
- **Configured handoffs** between agents—including **multiple handoffs** on the Planner agent offering both implementation-first and test-first paths—to create a structured Planning → Implementation → Review workflow with developer oversight at each transition.
- **Ran the complete chained workflow** to add a Product Inventory feature end-to-end, using the existing Category feature as a reference architecture. The agents collaborated to create a Product model with a CategoryId foreign key, DTOs, service interface and implementation, and a controller with authorization—all following the project's established coding standards.

This pattern—embedding team knowledge in instruction files and orchestrating specialized agents through handoffs—is applicable to any development project. You can adapt these techniques for other scenarios such as Test-Driven Development (Test Writer → Implementer), debugging workflows (Debugger → Patcher → Tester), or migration projects (Analyzer → Upgrader → Reviewer).

## Clean up

Now that you've finished the exercise, take a minute to clean up your environment:

- Stop the application if it's still running (press **Ctrl+C** in the terminal).
- Optionally archive or delete the project directory.
- If you created a private ContosoInventory repository in your GitHub account, you can delete it by going to the repository **Settings** tab and selecting **Delete this repository** at the bottom of the page.
