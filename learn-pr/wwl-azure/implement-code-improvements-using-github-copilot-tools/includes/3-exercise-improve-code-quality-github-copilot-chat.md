The term "code quality" refers to the overall quality of the codebase, including readability, maintainability, and modularity. Code quality is a measure of how "well-structured" your code is and how easily it can be understood, maintained, and extended.

> [!IMPORTANT]
> This training isn't about best practices for developing high-quality code. Instead, it focuses on how to use GitHub Copilot Chat to generate suggestions for improving code quality in a sample application. The suggestions do not represent best practices or comprehensive solutions for developing high-quality code. Developers should use their judgment and expertise to evaluate and implement the suggestions provided by GitHub Copilot Chat. Implementing suggestions proposed by GitHub Copilot does not replace the need for thorough code reviews and testing.

## Code refactoring and high-quality code

Code refactoring is the process of restructuring existing code without changing its external behavior. The goal of code refactoring is to improve the internal structure of the codebase, making it easier to understand, maintain, and extend. Code refactoring can help you produce high-quality code by enhancing readability, reducing complexity, improving modularity, and increasing reusability. Each of these factors helps to create a more manageable and maintainable codebase.

Developers should consider the following factors when working on code quality improvements:

- Readability: Improve or enhance the readability of code can make it easier for developers to understand.
- Complexity: Reduce code complexity makes the code easier to understand, manage, and maintain.
- Modularity and reusability: Break code down into smaller, reusable modules or components can make the code easier to manage and maintain.

The factors listed above represent three common areas that developers identify when discussing code quality. Other factors that can be associated with code quality include:

- Testability: The ease with which the code can be tested to ensure it works correctly. Often a byproduct of good design and modularity.
- Extensibility: The ease with which the code can be extended or enhanced to add new features or functionality. Often a byproduct of good design and modularity.

Code quality is not the only factor that developers consider during code reviews. Here are some more factors that developers often evaluate in addition to code quality:

- Reliability: The code’s ability to perform its intended functions under specified conditions.
- Performance: How efficiently the code executes.
- Security: The code’s ability to protect data and resources from unauthorized access or modification.
- Scalability: The code’s ability to handle increased workloads or growth in the future.
- Usability: The ease with which the code can be used by developers or end users.
- Portability: The ability of the code to run on different platforms or environments.

> [!NOTE]
> The next two units in this module cover improving code reliability, performance, and security using GitHub Copilot Chat.

Improving code quality is often considered a precursor to adding new features or enhancements. You should consider improvements to code quality before working on code reliability, performance, or security.

## Improve code quality using GitHub Copilot Chat

In this exercise, you'll use GitHub Copilot Chat to generate suggestions that help you improve code quality in a sample application.

### Prepare sample apps in your Visual Studio Code environment

This module includes practice activities that use GitHub Copilot, GitHub Copilot Chat, and prepared code samples. The activities are designed for an environment that includes the following tools and resources:

- Visual Studio Code.
- The C# Dev Kit extension for Visual Studio Code
- The GitHub Copilot and GitHub Copilot Chat extensions for Visual Studio Code. A GitHub account with an active subscription for GitHub Copilot is required.
- Sample code projects created using C#.

> [!NOTE]
> If you have not already installed Visual Studio Code and the required extensions, complete those installations before continuing.

To prepare for the exercises in this module, complete the following steps:

1. To download a zip file containing the sample apps, select the following link: [SampleApps](https://raw.githubusercontent.com/MicrosoftLearning/APL-2007-Accelerate-app-development-by-using-GitHub-Copilot/master/LearnModuleExercises/Downloads/SampleApps.zip).

1. Unzip the download files.

    Unzip the files in your development environment. Consider using your PC as your development environment so that you have access to your code after completing this module. If you aren't using your PC as your development environment, you can unzip the files in a sandbox or hosted environment.

    1. On your local machine, navigate to your downloads folder.
    1. Right-click **SampleApps.zip**, and then select **Extract all**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Copy the extracted **SampleApps** folder to your Windows Desktop folder.

    The **SampleApps** folder contains a collection of sample apps, including the **APL2007M5BankAccount** project that you use in this exercise.

1. Open the **APL2007M5BankAccount** sample app in Visual Studio Code.

### Develop prompts for GitHub Copilot Chat

The prompts you write for GitHub Copilot Chat should provide a clearly defined *context* and *intent*. The *intent* portion of the prompt describes the goal that you what to achieve. For example, you may ask GitHub Copilot to "refactor to improve code modularity". The *context* portion of the prompt tells GitHub Copilot what resources to consider. For example, you may want GitHub Copilot to consider the entire workspace, but focus on a specific file or code section. Consider the following suggestions when developing your prompts:

- Define an outer context that's scoped at a higher level than the code you want to update. For example, if you want to refactor a method, specify the class or file that contains the method as the outer context. Identify the method as an inner context.
- Use chat participants and chat variables to help specify context. You can use the `#file:` and `#selection` chat variables to identify the specific code you are focused on. You can also include the full workspace (`@workspace`) when appropriate. Suppose you want to refactor a method in a specific file. You can use the `#file:` chat variable to tell GitHub Copilot which file to look at. You can select the method in the editor and use the `#selection` chat variable to tell GitHub Copilot what code to you want to refactor. You can also use the `@workspace` chat variable to tell GitHub Copilot to consider the entire workspace. Reinforce the specified context by referring to the selection or file in the natural language portion of your prompt. For example, you might say, "how can I improve the readability of the selected code?"
- The intent should be clear and specific, and should specify the code quality aspect that you want to improve. For example, you might ask GitHub Copilot Chat to "How can I improve the modularity of the selected code".

During this portion of the exercise, you review the **APL2007M5BankAccount** project and create three prompts for GitHub Copilot Chat. The prompts focus on improving code readability, maintainability, and modularity.

Use the following steps to complete this portion of the exercise:

1. Open the **Program.cs** file and review the code.

    This program is a console application that simulates a banking system. Here are the key features:

    - Main Method: The Main method is the entry point of the application. It creates bank accounts and uses the accounts to simulate transactions.

    - Constants: The program defines several constants at the top of the Program class. The constants include things like: the number of accounts to create, the number of transactions to simulate, and the transaction limits.

1. Take a minute to write some prompts you can use to improve code readability, maintainability, and modularity.

    For the BankAccount project, your prompts could be similar to the following examples:

    Prompt: `@workspace /explain #file:Program.cs How can I improve the readability of the selected code?`

    Prompt: `@workspace /explain #file:Program.cs #selection How can I improve the maintainability of the selected code?`

    Prompt: `@workspace /explain #file:Program.cs How can I improve the modularity of the selected code?`

    Prompt: `#file:Program.cs #selection How can I refactor the selected code to improve modularity?`

    Prompt: `@workspace /explain #file:Program.cs What are some options for simplifying the selected code?`

1. Create three prompts to use during the remainder of the exercise.

### Refactor your code using GitHub Copilot Chat

You can use GitHub Copilot Chat to suggest code updates that refactor and improve your code. It's important to understand your code and your goals before making a decision about how to refactor the application.

The suggestions GitHub Copilot Chat provides must be reviewed carefully. Consider which suggestions support your goals before you implement them. For the purpose of this exercise, your time may also be a factor in deciding which suggestions to implement.

Use the following steps to complete this portion of the exercise:

1. Take a minute to review the methods included in the Program.cs file.

    - CreateBankAccounts Method: This method creates a specified number of bank accounts with random initial balances, account holder names, account types, and opening dates. It uses a try-catch block to handle any exceptions that might occur during account creation.

    - SimulateTransactions Method: This method simulates a specified number of transactions on a list of bank accounts. It generates a random transaction amount for each transaction and then credits or debits the account with this amount, depending on whether the amount is positive or negative. It uses a try-catch block to handle any exceptions that might occur during the transactions.

    - SimulateTransfers Method: This method is identical to the SimulateTransactions method. It seems to be intended to simulate transfers between accounts, but currently, it just simulates transactions on individual accounts.

    - GenerateRandomDollarAmount Method: This method generates a random dollar amount within a specified range. It uses a different formula to generate the amount depending on whether the amount is for an account balance or a transaction.

    - GenerateRandomAccountHolder Method: This method selects a random account holder name from a predefined list of names.

    - GenerateRandomAccountType Method: This method selects a random account type from a predefined list of types.

    - GenerateRandomDateOpened Method: This method generates a random date within a specified range of years back from the current date.

1. Ensure that the project builds and runs without errors.

1. Choose your first prompt from the prompts that you prepared.

1. Select the code that you want to improve, open the Chat view, and then enter your prompt.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, suppose you complete the following actions:

    - You choose the following prompt: `@workspace /explain #file:Program.cs How can I improve the readability of the selected code?`
    - You select the following method(s): `GenerateRandomBalance`, `GenerateRandomAccountHolder`, `GenerateRandomAccountType`, `GenerateRandomDateOpened`.
    - You enter the prompt in the Chat view.

    After you complete these actions, GitHub Copilot Chat suggests updates that are similar to the following response:

    *1. Extract repeated code into separate methods: The Random object is created multiple times in different methods. You could create a static Random object at the class level and use it in all methods. This would not only improve readability but also provide better randomness.*

    `private static readonly Random random = new Random();`

    *2. Use meaningful variable names: The variable name `range` in the GenerateRandomDateOpened method is a bit vague. A more descriptive name like daysRange could be used.*

    *3. Add comments: While the code is mostly self-explanatory, adding comments to explain what each method does can be helpful for other developers reading your code.*

    *4. Use constants for magic numbers: In the GenerateRandomDateOpened method, the number `10` is used to represent the number of years back the start date can be. This could be extracted to a constant with a descriptive name, like `MaxYearsBack`.*

    *5. Use var keyword: In C#, you can use the var keyword when the right-hand side of the assignment makes the type obvious. This can make your code cleaner and easier to read.*

   *Here's how your code might look after these improvements:*

    ```csharp
    private static readonly Random random = new Random();
    private const int MaxYearsBack = 10;
    
    static double GenerateRandomBalance(double min, double max)
    {
        double balance = random.NextDouble() * (max - min) + min;
        return Math.Round(balance, 2);
    }
    
    static string GenerateRandomAccountHolder()
    {
        string[] accountHolderNames = {  /* names here */  };
        var accountHolderName = accountHolderNames[random.Next(0, accountHolderNames.Length)];
        return accountHolderName;
    }
    
    static string GenerateRandomAccountType()
    {
        string[] accountTypes = {  /* types here */  };
        return accountTypes[random.Next(0, accountTypes.Length)];
    }
    
    static DateTime GenerateRandomDateOpened()
    {
        DateTime startDate = new DateTime(DateTime.Today.Year - MaxYearsBack, 1, 1);
        int daysRange = (DateTime.Today - startDate).Days;
        DateTime randomDate = startDate.AddDays(random.Next(daysRange));
    
        if (randomDate.Year == DateTime.Today.Year && randomDate >= DateTime.Today)
        {
            randomDate = randomDate.AddDays(-1);
        }
    
        return randomDate;
    }

    ```

    > [!TIP]
    > Notice the placeholder values (such as `/* types here */`) in the `GenerateRandomAccountHolder` and `GenerateRandomAccountType` methods. GitHub Copilot Chat occasionally replaces code details with placeholders. These are easy to spot if you're paying attention. You'll need to replace the placeholder values with values from your app when you implement an update. If you see placeholders, you should make a copy of your existing code before implementing the suggested updates. If the suggested code block aligns with the code in your app, you can use a block comment to comment out your existing code, and then use the Chat view's **Insert at Cursor** button to implement the suggested updates without creating a naming conflict. Once you verify that the suggested update works as expected, you can remove the block comment.

1. Implement the suggested updates that help to improve code readability, maintainability, modularity.

    If you used block comments to comment out your existing code, you can use the Chat view's **Insert at Cursor** to insert the suggested updates. You can also use the Copy option and paste the update into the location of your choice.

    Consider the coding standards and policies implemented at your workplace before choosing which update suggestions to implement.

1. To ensure that no errors were introduced when you implemented your updates, build and run your solution before continuing.

1. Enter your second prompt and review the updates proposed by GitHub Copilot Chat.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, suppose you complete the following actions:

    - You implement the updates that GitHub Copilot Chat suggested for the first example prompt.
    - You choose the following prompt: `@workspace /explain #file:Program.cs How can I improve the maintainability of the selected code?`.
    - You select the following method(s): `Main`, `GenerateRandomBalance`, `GenerateRandomAccountHolder`, `GenerateRandomAccountType`, `GenerateRandomDateOpened`.
    - You enter the prompt in the Chat view.

    After you complete these actions, GitHub Copilot Chat suggests updates that are similar to the following response:

    *The selected code is well-structured and follows good practices, but there are a few areas where it could be improved for better maintainability:*

    *1. Separation of Concerns: The Main method is doing a lot of things: creating accounts, simulating transactions, and simulating transfers. These could be broken down into separate methods to improve readability and maintainability.*

    *2. Error Handling: The code uses a general Exception for error handling. It would be better to create custom exceptions that are specific to the application. This would make it easier to understand and handle errors.*

    *3. Magic Numbers: The code contains magic numbers (like 20 for the number of accounts, 100 for the number of transactions, etc.). These should be replaced with named constants.*

    *4. Code Duplication: The code for generating random values is duplicated in several places. This could be refactored into a utility class or methods.*

    ```csharp
    class Program
    {
        private static readonly Random random = new Random();
        private const int MaxYearsBack = 10;
        private const int NumberOfAccounts = 20;
        private const int NumberOfTransactions = 100;
    
        static void Main(string[] args)
        {
            List<BankAccount> accounts = CreateBankAccounts(NumberOfAccounts);
            SimulateTransactions(accounts, NumberOfTransactions);
            SimulateTransfers(accounts);
        }
    
        static List<BankAccount> CreateBankAccounts(int numberOfAccounts)
        {
            List<BankAccount> accounts = new List<BankAccount>();
            int createdAccounts = 0;
            while (createdAccounts < numberOfAccounts)
            {
                try
                {
                    // same code as before...
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Account creation failed: {ex.Message}");
                }
            }
            return accounts;
        }
    
        static void SimulateTransactions(List<BankAccount> accounts, int numberOfTransactions)
        {
            // same code as before...
        }
    
        static void SimulateTransfers(List<BankAccount> accounts)
        {
            // same code as before...
        }
    
        // same helper methods as before...
    }
    ```

1. Review the suggestions provided by GitHub Copilot Chat.

1. Implement the suggested updates that help to improve code readability, maintainability, and modularity.

    If you used block comments to comment out your existing code, you can use the Chat view's **Insert at Cursor** to insert the suggested updates. You can also use the Copy option and paste the update into the location of your choice.

1. To ensure that no errors were introduced by the changes, build and run your solution before continuing.

1. Enter your third prompt, and then take a minute review the suggestions.

    For example, suppose you complete the following actions:

    - You implement the updates that GitHub Copilot Chat suggested for the first and second example prompts.
    - You choose the following prompt: `@workspace /explain #file:Program.cs How can I improve the modularity of the selected code?`.
    - You select the following code: Select all of the Program.cs file.
    - You enter the prompt in the Chat view.

    After you complete these actions, GitHub Copilot Chat suggests updates that are similar to the following response:

    *The selected code is a simulation of a banking system. It creates bank accounts, simulates transactions, and transfers between these accounts. While the code is functional, it could be improved in terms of modularity. Here are some suggestions:*

    *1. Separate Concerns: The `Program` class is doing too much. It's creating accounts, simulating transactions, and generating random data. Each of these responsibilities could be a separate class. For example, you could have a `BankAccountFactory` class that's responsible for creating bank accounts, a `TransactionSimulator` class for simulating transactions, and a `RandomDataGenerator` class for generating random data.*

    *2. Use Interfaces: Interfaces can be used to define a contract for classes. This can make your code more flexible and easier to test. For example, you could define an `IAccountFactory` interface with a `Create` method, and then have `BankAccountFactory` implement this interface.*

    *3. Magic Numbers: There are several "magic numbers" in the code (like 10, 50000, -500, 500, etc.). These numbers should be replaced with named constants to make the code more readable and maintainable.*

    *4. Duplication: The `SimulateTransactions` and `SimulateTransfers` methods have almost identical code. This duplication could be eliminated by creating a common method that both methods call.*

   *Here's an example of how you could refactor the CreateBankAccounts method:*

    **Code snippet A: Use Interfaces**

    ```csharp
    interface IAccountFactory
    {
        BankAccount Create(int index);
    }
    
    class BankAccountFactory : IAccountFactory
    {
        private readonly RandomDataGenerator _randomDataGenerator;
    
        public BankAccountFactory(RandomDataGenerator randomDataGenerator)
        {
            _randomDataGenerator = randomDataGenerator;
        }
    
        public BankAccount Create(int index)
        {
            double initialBalance = _randomDataGenerator.GenerateRandomBalance(10, 50000);
            string accountHolderName = _randomDataGenerator.GenerateRandomAccountHolder();
            string accountType = _randomDataGenerator.GenerateRandomAccountType();
            DateTime dateOpened = _randomDataGenerator.GenerateRandomDateOpened();
            return new BankAccount($"Account {index + 1}", initialBalance, accountHolderName, accountType, dateOpened);
        }
    }


    // In the `Program` class, you would then use the `IAccountFactory` to create accounts:
    interface IAccountFactory
    {
        BankAccount Create(int index);
    }
    
    class BankAccountFactory : IAccountFactory
    {
        private readonly RandomDataGenerator _randomDataGenerator;
    
        public BankAccountFactory(RandomDataGenerator randomDataGenerator)
        {
            _randomDataGenerator = randomDataGenerator;
        }
    
        public BankAccount Create(int index)
        {
            double initialBalance = _randomDataGenerator.GenerateRandomBalance(10, 50000);
            string accountHolderName = _randomDataGenerator.GenerateRandomAccountHolder();
            string accountType = _randomDataGenerator.GenerateRandomAccountType();
            DateTime dateOpened = _randomDataGenerator.GenerateRandomDateOpened();
            return new BankAccount($"Account {index + 1}", initialBalance, accountHolderName, accountType, dateOpened);
        }
    }

    ```

    **Code snippet B: Duplication**

    ```csharp
    static void SimulateOperations(List<BankAccount> accounts, int numberOfOperations, Action<BankAccount, double> operation)
    {
        foreach (BankAccount account in accounts)
        {
            for (int i = 0; i < numberOfOperations; i++)
            {
                double transactionAmount = GenerateRandomBalance(-500, 500);
                try
                {
                    operation(account, transactionAmount);
                    Console.WriteLine($"Operation: {transactionAmount}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Operation failed: {ex.Message}");
                }
            }
    
            Console.WriteLine($"Account: {account.AccountNumber}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
        }
    }

    
    // Then you can call this method like this:
    SimulateOperations(accounts, NumberOfTransactions, (account, amount) => {
        if (amount >= 0)
        {
            account.Credit(amount);
        }
        else
        {
            account.Debit(-amount);
        }
    });
    ```

    > [!NOTE]
    > You don't need to implement the update suggestions that GitHub Copilot generated from your third prompt. Reviewing the suggestions may provide insights into how the code improvement process progresses.

The next two units cover the following topics:

- Improve code reliability and performance by using GitHub Copilot Chat
- Improve code security by using GitHub Copilot Chat

## Summary

In this exercise, you used GitHub Copilot Chat to generate suggestions that help you improve code quality in a sample application. You developed prompts that focused on improving code readability, maintainability, and modularity. You reviewed the suggestions provided by GitHub Copilot Chat and implemented the updates that helped to improve code quality. You also considered additional suggestions that could further improve your code.
