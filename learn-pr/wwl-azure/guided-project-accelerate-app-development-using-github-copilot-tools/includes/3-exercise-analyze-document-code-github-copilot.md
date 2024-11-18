GitHub Copilot can help you understand and document a codebase by generating explanations and documentation. In this exercise, you'll use GitHub Copilot to analyze and document the library application. You'll also create a GitHub repository for the library application and generate a README file for the repository using GitHub Copilot.

This exercise includes the following tasks:

- Use GitHub Copilot to explain the library application codebase.
- Use Visual Studio Code to create a GitHub repository for the library application.
- Use GitHub Copilot extensions to analyze the solution and create a README.md file for the repository.

## Examine the library application codebase

Before you create a code repository and README file, you should take some time to examine the codebase. It's important to understand the app architecture and key features before documenting the project. You should also run the application to ensure that it performs as expected.

### Use GitHub Copilot to explain the library application codebase

GitHub Copilot can help you to understand an unfamiliar codebase by generating explanations at the solution and feature levels.

Use the following steps to complete this section of the exercise:

1. Ensure that you have the `AccelerateDevGitHubCopilot` solution open in Visual Studio Code.

1. Open the Chat view, and then enter a prompt that uses GitHub Copilot's `@workspace` participant to generate a description of the project.

    For example, enter the following prompt in the Chat view:

    ```plaintext
    @workspace Describe this project
    ```

1. Take a couple minutes to review the response.

    You should see a response similar to the following description:

    ```markdown
    This project appears to be a library management system with a multi-layered architecture, including application core, console application, and infrastructure layers. Here's a breakdown of the project structure:
    
    ### Project Structure
    
    - **Solution File**
      - `AccelerateDevGitHubCopilot.sln`: The solution file that ties all the projects together.
    
    - **Source Code (`src/`)**
      - **Library.ApplicationCore**
        - Contains core business logic and entities.
        - **Entities**: Likely contains domain models.
        - **Enums**: Contains enumerations used across the application.
        - **Interfaces**: Defines contracts for repositories and services.
        - **Services**: Likely contains implementations of the business logic.
        - `Library.ApplicationCore.csproj`: Project file for the application core.
    
      - **Library.Console**
        - Contains the console application that interacts with the core library.
        - `appSettings.json`: Configuration file for the console application.
        - ConsoleApp: Main class for the console application.
        - ConsoleState: Likely manages the state of the console application.
        - `Library.Console.csproj`: Project file for the console application.
        - `Program.cs`: Entry point for the console application.
    
      - **Library.Infrastructure**
        - Likely contains data access implementations and other infrastructure-related code.
        - **Data**: Contains data access classes.
        - `Library.Infrastructure.csproj`: Project file for the infrastructure layer.
    
    - **Tests (`tests/`)**
      - **UnitTests**
        - Contains unit tests for the application core.
        - **ApplicationCore**
          - **LoanService**
          - **PatronService**
        - `LoanFactory.cs`: Likely contains factory methods for creating loan objects for tests.
        - `PatronFactory.cs`: Likely contains factory methods for creating patron objects for tests.
        - UnitTests.csproj: Project file for the unit tests.
    
    ### Summary

    This project is a .NET-based library management system with a clear separation of concerns across different projects for core logic, console interface, infrastructure, and testing. The solution is well-structured to support development, testing, and deployment.
    ```

1. Use the Solution Explorer view to expand the project folders.

1. Locate and open the `ConsoleApp.cs` file.

    The ConsoleApp.cs file is located in the `src/Library.Console` folder.

1. Enter a prompt in the Chat view that generates a description of the `ConsoleApp` class.

    For example, enter the following prompt in the Chat view:

    ```plaintext
    @workspace #file:ConsoleApp.cs Describe the ConsoleApp class
    ```

1. Take a couple minutes to review the response.

    You should see a response similar to the following description:

    ```markdown
    The `ConsoleApp` class in `src/Library.Console/ConsoleApp.cs` is responsible for managing the console-based user interface of the application. It interacts with various services and repositories to perform operations related to patrons and loans. Here are the key components and methods of the `ConsoleApp` class:
    
    ### Fields
    - `_currentState`: Tracks the current state of the console application.
    - `matchingPatrons`: A list of patrons that match a search query.
    - `selectedPatronDetails`: Holds details of the currently selected patron.
    - `selectedLoanDetails`: Holds details of the currently selected loan.
    - `_patronRepository`: An instance of `IPatronRepository` for accessing patron data.
    - `_loanRepository`: An instance of `ILoanRepository` for accessing loan data.
    - `_loanService`: An instance of `ILoanService` for performing loan-related operations.
    - `_patronService`: An instance of `IPatronService` for performing patron-related operations.
    
    ### Constructor
    - `ConsoleApp(ILoanService loanService, IPatronService patronService, IPatronRepository patronRepository, ILoanRepository loanRepository)`: Initializes the `ConsoleApp` with the provided services and repositories.
    
    ### Methods
    - `Run()`: The main entry point for running the console application.
    - `PatronSearch()`: Handles the logic for searching patrons.
    - `ReadPatronName()`: Reads the patron's name from the console input.
    - `PrintPatronsList(List<Patron> matchingPatrons)`: Prints a list of matching patrons to the console.
    - `PatronSearchResults()`: Handles the logic for displaying and selecting from the search results.
    - `ReadInputOptions(CommonActions options, out int optionNumber)`: Reads input options from the console.
    - `WriteInputOptions(CommonActions options)`: Writes the available input options to the console.
    - `PatronDetails()`: Displays details of the selected patron.
    - `LoanDetails()`: Displays details of the selected loan and handles actions like extending or returning the loan.
    
    ### Example Usage
    ```

    ```cs
    public async Task Run()
    {
        while (_currentState != ConsoleState.Quit)
        {
            switch (_currentState)
            {
                case ConsoleState.PatronSearch:
                    _currentState = await PatronSearch();
                    break;
                case ConsoleState.PatronSearchResults:
                    _currentState = await PatronSearchResults();
                    break;
                case ConsoleState.PatronDetails:
                    _currentState = await PatronDetails();
                    break;
                case ConsoleState.LoanDetails:
                    _currentState = await LoanDetails();
                    break;
                default:
                    throw new InvalidOperationException("Unknown state.");
            }
        }
    }
    ```

    ```markdown
    The `ConsoleApp` class orchestrates the flow of the console application, allowing users to search for patrons, view patron details, and manage loans. it uses a state machine pattern to manage different states of the console application, making it easier to handle user interactions and transitions between different operations.
    ```

1. Open the `Program.cs` file.

1. Enter a prompt in the Chat view that generates a description of the `Program.cs` file.

    For example, enter the following prompt in the Chat view:

    ```plaintext
    @workspace #file:Program.cs Describe the Program.cs file
    ```

1. Take a couple minutes to review the response.

    You should see a response similar to the following description:

    ```markdown
    The `Program.cs` file in the `src/Library.Console/Program.cs` path is responsible for setting up the dependency injection container and running the console application. Here's a breakdown of its key components:
    
    1. **Dependency Injection Setup**:
        - It creates a `ServiceCollection` to register services.
        - It builds a configuration object from the `appSettings.json` file.
        - It registers various services and repositories with different lifetimes (singleton, scoped).
    
    2. **Service Registration**:
        - Configuration is registered as a singleton.
        - Repositories (`IPatronRepository`, `ILoanRepository`) and services (`ILoanService`, `IPatronService`) are registered as scoped.
        - `JsonData` and `ConsoleApp` are registered as singletons.
    
    3. **Service Provider**:
        - It builds the service provider from the registered services.
        - It retrieves the `ConsoleApp` service and runs it asynchronously.
    
    Here's a simplified version of the code:
    ```

    ```csharp
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Configuration;
    using Library.Infrastructure.Data;
    using Library.ApplicationCore;
    
    var services = new ServiceCollection();
    
    var configuration = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appSettings.json")
        .Build();
    
    services.AddSingleton<IConfiguration>(configuration);
    services.AddScoped<IPatronRepository, JsonPatronRepository>();
    services.AddScoped<ILoanRepository, JsonLoanRepository>();
    services.AddScoped<ILoanService, LoanService>();
    services.AddScoped<IPatronService, PatronService>();
    services.AddSingleton<JsonData>();
    services.AddSingleton<ConsoleApp>();
    
    var serviceProvider = services.BuildServiceProvider();
    
    var consoleApp = serviceProvider.GetRequiredService<ConsoleApp>();
    consoleApp.Run().Wait();
    ```

    ```markdown
    This file is crucial for initializing and running the console application with the necessary dependencies.
    ```

1. Enter a prompt in the Chat view that generates an explanation of the data access classes.

    For example, enter the following prompt in the Chat view:

    ```plaintext
    @workspace #file:JsonData.cs #file:JsonLoanRepository.cs #file:JsonPatronRepository.cs Explain how the data access classes work
    ```

1. Take a couple minutes to review the response.

    You should see a response similar to the following description:

    ```markdown
    The data access classes in your workspace, specifically `JsonData`, `JsonLoanRepository`, and `JsonPatronRepository`, work together to manage and access data stored in JSON files. Here's an overview of how they function:
    
    ### `JsonData`
    
    The `JsonData` class is responsible for loading and managing data from JSON files. It uses paths specified in the configuration to locate these files. The class has properties to hold lists of various entities like `Authors`, `Books`, `BookItems`, `Patrons`, and `Loans`.
    
    - **Constructor**: Initializes file paths from the configuration.
    - **EnsureDataLoaded**: Ensures that data is loaded into memory.
    - **LoadData**: Loads data from JSON files into the respective properties.
    - **GetPopulatedPatron**: Populates a `Patron` object with its associated `Loans`.
    
    ### `JsonLoanRepository`
    
    The `JsonLoanRepository` class implements the `ILoanRepository` interface and uses `JsonData` to manage loan data.
    
    - **Constructor**: Accepts a `JsonData` instance.
    - **GetLoan**: Retrieves a loan by its ID, ensuring data is loaded first.
    - **UpdateLoan**: Updates an existing loan and saves the changes back to the JSON file.
    
    ### `JsonPatronRepository`
    
    The `JsonPatronRepository` class implements the `IPatronRepository` interface and uses `JsonData` to manage patron data.
    
    - **Constructor**: Accepts a `JsonData` instance.
    - **GetPatron**: Retrieves a patron by its ID, ensuring data is loaded first.
    - **SearchPatrons**: Searches for patrons based on a search input.
    - **UpdatePatron**: Updates an existing patron.
    
    ### Example Usage
    
    - **Loading Data**: When a method like `GetPatron` or `GetLoan` is called, it first ensures that data is loaded by calling `EnsureDataLoaded` on the `JsonData` instance.
    - **Retrieving Data**: The repositories use the loaded data to find and return specific entities.
    - **Updating Data**: When updating, the repositories modify the in-memory data and then save it back to the JSON files.
    
    ### Code Links
    
    - `JsonData`
    - `JsonLoanRepository`
    - `JsonPatronRepository`
    
    This setup allows for a clear separation of concerns, with `JsonData` handling the low-level data loading and saving, while the repositories provide higher-level data access methods.
    ```

1. Take a couple minutes to examine the JSON data files that are used to simulate library records.

    The JSON data files are located in the `src/Library.Console/Json` folder.

    The data files use ID properties to link entities. For example, a `Loan` object has a `PatronId` property that links to a `Patron` object with the same ID. The JSON files contain data for authors, books, book items, patrons, and loans.

    > [!NOTE]
    > Notice that Author names, book titles, and patron names have been anonymized for the purposes of this guided project.

### Build and run the application

Running the application will help you understand the user interface, key features of the application, and how app components interact.

Use the following steps to complete this section of the exercise:

1. Ensure that you have the **Solution Explorer** view open.

    The Solution Explorer view is not the same as the Explorer view. The Solution Explorer view uses project and solution files as "directory" nodes to display the structure of the solution.

1. To run the application, right-click **Library.Console**, select **Debug**, and then select **Start New Instance**.

    If the **Debug** and **Start New Instance** options aren't displayed, ensure that you're using the Solution Explorer view and not the Explorer view.

    The following steps guide you through a simple use case.

1. When prompted for a patron name, type **One** and then press Enter.

    You should see a list of patrons that match the search query.

    > [!NOTE]
    > The application uses a case-sensitive search process.

1. At the "Input Options" prompt, type **2** and then press Enter.

    Entering **2** selects the second patron in the list.

    You should see the patron's name and membership status followed by book loan details.

1. At the "Input Options" prompt, type **1** and then press Enter.

    Entering **1** selects the first book in the list.

    You should see book details listed, including the due date and return status.

1. At the "Input Options" prompt, type **r** and then press Enter.

    Entering **r** returns the book.

1. Verify that the message "Book was successfully returned." is displayed.

    The message "Book was successfully returned." should be followed by the book details. Returned books are marked with `Returned: True`.

1. To begin a new search, type **s** and then press Enter.

1. When prompted for a patron name, type **One** and then press Enter.

1. At the "Input Options" prompt, type **2** and then press Enter.

1. Verify that first book loan is marked `Returned: True`.

1. At the "Input Options" prompt, type **q** and then press Enter.

1. Stop the debug session.

## Create the GitHub repository for your code

Creating the GitHub repository for your code will enable you to share your work with others and collaborate on the project.

> [!NOTE]
> You use your own GitHub account to create a private GitHub repository for the library application.

Use the following steps to complete this section of the exercise:

1. Open a browser window and navigate to your GitHub account.

    The GitHub login page is: [https://github.com/login](https://github.com/login).

1. Sign in to your GitHub account.

1. Open your GitHub account menu, and then select **Your repositories**.

1. Switch to the Visual Studio Code window.

1. In Visual Studio Code, open the Source Control view.

1. Select **Publish to GitHub**, and then select **Publish to GitHub private repository**.

    Accept the default name for the repository: AccelerateDevGitHubCopilot.

1. Notice that Visual Studio Code displays status messages during the publish process.

    When the publish process is finished, you'll see a message informing you that your code was successfully published to the GitHub repository that you specified.

1. Switch to the browser window for your GitHub account.

1. Open the new AccelerateDevGitHubCopilot repository in your GitHub account.

    If you don't see your AccelerateDevGitHubCopilot repository, refresh the page. If you still don't see the repository, try the following steps:

    1. Switch to Visual Studio Code.
    1. Open your notifications (a notification was generated when the new repository was published).
    1. Select **Open on GitHub** to open your repository.

1. On the Code tab of your AccelerateDevGitHubCopilot repository, select **Add a README**.

1. In the README.md editor, type **Coming soon** and then select **Commit changes**.

1. In the `Commit changes` dialog, select **Commit changes**.

1. Switch to Visual Studio Code and ensure that the Source Control view is open.

1. Open the **Views and More Actions** menu, and then select **Pull**.

    The Views and More Actions menu can be opened using the ellipsis in the top-right corner of the Source Control view.

1. Open the Explorer view (not Solution Explorer), and then expand the **AccelerateDevGitHubCopilot** folder.

1. Open the README.md file.

    You should see the message "Coming soon".

You'll be using GitHub Copilot Chat to update your repository's README file in the next section of this exercise.

## Create the project documentation for the README file

The README file is an essential part of any GitHub repository. The README provides information based on the needs of the project, project contributors, and stakeholders.

For this guided project exercise, your README file should include the following sections:

- **Project Title**: A brief, clear title for the project.
- **Description**: A detailed explanation of what the project is and what it does.
- **Project Structure**: A breakdown of the project structure, including key folders and files.
- **Key Classes and Interfaces**: A list of key classes and interfaces in the project.
- **Usage**: Instructions on how to use the project, often including code examples.
- **License**: The license that the project is under.

In this section of the exercise, you'll use GitHub Copilot to create project documentation and add it to your `README.md` file.

Use the following steps to complete this section of the exercise:

1. Open the Chat view.

1. To generate project documentation for your README file, enter the following prompt:

    ```plaintext
    @workspace Generate the contents of a README.md file for the code repository. Use "Library App" as the project title. The README file should include the following sections: Description, Project Structure, Key Classes and Interfaces, Usage, License. Format all sections as raw markdown. Use a bullet list with indents to represent the project structure. Do not include ".gitignore" or the ".github", "bin", and "obj" folders.
    ```

    > [!NOTE]
    > Using multiple prompts, one for each section of the README file would produce more detailed results. A single prompt is used in this exercise to simplify the process.

1. Review the response to ensure each section is formatted as markdown.

    > [!NOTE]
    > You can update sections individually to provide more detailed information or if they aren't formatted correctly. You can also copy GitHub Copilot's response to the README file and then make corrections directly in the markdown file.

1. Copy the suggested documentation sections to the README.md file.

    ```markdown
    # Library App
    
    ## Description
    Library App is a console application designed to manage library operations such as book loans, patron management, and inventory tracking. It is built using .NET and follows a modular architecture with separate projects for core application logic, infrastructure, and console interface.
    
    ## Project Structure
    - `AccelerateDevGitHubCopilot.sln` - Solution file
    - `README.md` - Project documentation
    - `src/`
      - `Library.ApplicationCore/`
        - `Entities/` - Core entities like `Book`
        - `Enums/` - Enumerations used across the application
        - `Interfaces/` - Interfaces for services and repositories
        - `Library.ApplicationCore.csproj` - Project file for Application Core
        - `Services/` - Core services like `LoanService`
      - `Library.Console/`
        - `appSettings.json` - Configuration file
        - `CommonActions.cs` - Common actions for the console app
        - `ConsoleApp.cs` - Main console application class
        - `ConsoleState.cs` - State management for the console app
        - `Json/` - JSON files for configuration
        - `Library.Console.csproj` - Project file for Console application
        - `Program.cs` - Entry point for the console application
      - `Library.Infrastructure/`
        - `Data/` - Data access implementations
        - `Library.Infrastructure.csproj` - Project file for Infrastructure
    - `tests/`
      - `UnitTests/`
        - `ApplicationCore/` - Unit tests for Application Core
    
    ## Key Classes and Interfaces
    - **Library.ApplicationCore**
      - `Entities.Book`: Represents a book in the library.
      - `Interfaces.ILoanService`: Interface for loan service operations.
      - `Interfaces.IPatronService`: Interface for patron service operations.
      - `Interfaces.IPatronRepository`: Interface for patron repository operations.
      - `Interfaces.ILoanRepository`: Interface for loan repository operations.
    - **Library.Console**
      - `ConsoleApp`: Main class for the console application.
      - `Program`: Entry point of the console application.
    - **Library.Infrastructure**
      - `Data`: Contains data access implementations.

    ## Usage
    To run the console application, navigate to the `src/Library.Console` directory and execute the following command:
    ```

    ```sh
    dotnet run
    ```

    ```markdown
    ## License
    This project is licensed under the MIT License.
    ```

1. Save the updated README.md file.

1. Open the Source Control view.

1. To have GitHub Copilot generate a commit message, select the icon on the right side of the message box.

    You should see a commit message similar to the following message:

    ```plaintext
    chore: Update README.md with project description and usage instructions
    ```

1. Stage and Commit the file updates.

1. Sync (or Push) your updates to the GitHub repository.

## Check your work

To check your work, complete the following steps:

1. Open the GitHub repository for the AccelerateDevGitHubCopilot project.

1. Use the **Code** tab to review the updated README.md file.

1. Ensure that the project structure described in the README file aligns the folder structure of the repository.

1. Review the commit history and locate the commit message generated by GitHub Copilot.
