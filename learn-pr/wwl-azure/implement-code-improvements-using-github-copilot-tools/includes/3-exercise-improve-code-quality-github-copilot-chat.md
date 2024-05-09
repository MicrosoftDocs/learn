The term "code quality" refers to the overall quality of the codebase, including readability, maintainability, and modularity. Code quality is a measure of how "well-structured" your code is and how easily can be understood, maintained, and expanded.

> [!IMPORTANT]
> This training does not teach developers how create high-quality code. Instead, it focuses on how to use GitHub Copilot Chat to generate suggestions for improving code quality in a sample application. The suggestions do not represent best practices or comprehensive solutions for developing high-quality code. Developers should use their judgment and expertise to evaluate and implement the suggestions provided by GitHub Copilot Chat. Implementing suggestions proposed by GitHub Copilot does not replace the need for thorough code reviews and testing.

## Code refactoring and code quality

Code refactoring is the process of restructuring existing computer code without changing its external behavior. The goal of code refactoring is to improve the internal structure of the codebase, making it easier to understand, maintain, and extend. Code refactoring can help you produce high-quality code by enhancing readability, simplifying complexity, increasing modularity, and improving reusability.

The following section describes the relationship between code refactoring and code quality, and includes a list of factors to consider when working on code quality improvements.

### Examine code refactoring and high-quality code

Code refactoring helps you improve the internal structure of your code without altering its external behavior or functionality. Refactoring can help you produce high-quality code by enhancing readability, simplifying complexity, increasing modularity, and improving reusability. Each of these factors helps to create a more manageable and maintainable codebase.

Developers can consider the following factors when working on code quality improvements:

- Readability: Improve or enhance the readability of code can make it easier for developers to understand.
- Complexity: Reduce code complexity makes the code easier to understand, manage, and maintain.
- Modularity and reusability: Break code down into smaller, reusable modules or components can make the code easier to manage and maintain.

There are additional factors that can be associated with code quality. The factors listed above represent three common areas that developers identify when discussing code quality. Additional factors include:

- Testability: The ease with which the code can be tested to ensure it works correctly. Often a byproduct of good design and modularity.
- Extensibility: The ease with which the code can be extended or enhanced to add new features or functionality. Often a byproduct of good design and modularity.

Here are some additional factors that can be evaluated separately:

- Reliability: The code’s ability to perform its intended functions under specified conditions.
- Performance: How efficiently the code executes.
- Security: The code’s ability to protect data and resources from unauthorized access or modification.
- Scalability: The code’s ability to handle increased workloads or growth in the future.
- Usability: The ease with which the code can be used by developers or end users.
- Portability: The ability of the code to run on different platforms or environments.

Improving code quality is often considered a precursor to adding new features or enhancements. You should consider improvements to code quality before working on code reliability, performance, or security.

> [!NOTE]
> The next two units in this module will cover improving code reliability, performance, and security using GitHub Copilot Chat.

## Improve code quality using GitHub Copilot Chat

In this exercise, you'll use GitHub Copilot Chat to generate suggestions that help you improve code quality in a sample application.

### Prepare sample apps in your Visual Studio Code environment

This module includes practice activities that use GitHub Copilot, GitHub Copilot Chat, and prepared code samples. The activities are designed for an environment that includes the following:

- Visual Studio Code.
- The C# Dev Kit extension for Visual Studio Code
- The GitHub Copilot and GitHub Copilot Chat extensions for Visual Studio Code. A GitHub account with an active subscription for GitHub Copilot is required.
- Sample code projects created using C#.

> [!NOTE]
> If you have not already installed Visual Studio Code and the required extensions, complete those installations before continuing.

1. To download a zip file containing the sample apps, select the following link: [SampleApps](https://raw.githubusercontent.com/MicrosoftLearning/APL-2007-Accelerate-app-development-by-using-GitHub-Copilot/master/LearnModuleExercises/Downloads/SampleApps.zip).

1. Unzip the download files.

    Unzip the files in your development environment. Consider using your PC as your development environment so that you have access to your code after completing this module. If you aren't using your PC as your development environment, you can unzip the files in a sandbox or hosted environment.

    1. On your local machine, navigate to your downloads folder.
    1. Right-click **SampleApps.zip**, and then select **Extract all**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Copy the extracted **SampleApps** folder to your Windows Desktop folder.

    The **SampleApps** folder contains a collection of sample apps, including the **APL2007M5BankAccount** project that you will use in this exercise.

1. Open the **APL2007M5BankAccount** sample app in Visual Studio Code.

### Develop prompts for GitHub Copilot Chat

The prompts and questions that you write for GitHub Copilot Chat need to specify context and intent. For prompts that will be used to refactor your code, the context should include your workspace or a file, and the intent should describe the goal you want to achieve. Consider the following suggestions when you're developing your prompts:

- The context should reference your workspace (`@workspace`) or a file (`#file:`). This will help to ensure that GitHub Copilot examines an appropriate scope when formulating a response. Your prompt could also use `#selection` to identify a specific method or code block that you've selected in the editor.
- The intent should specify the code quality aspect that you want to improve. For example, you might ask GitHub Copilot Chat to suggest ways to improve code readability.

Your goal for this exercise is to write prompts that will help you to improve code readability, maintainability, and modularity. You will use the **APL2007M5BankAccount** project to develop your prompts.

1. Open the **Program.cs** file in the **APL2007M5BankAccount** project and review the code.

    The **Program.cs** file contains the code for a simple banking application that simulates the creation of bank accounts, transactions, and transfers.

1. Take a minute to consider the prompts that could help you to improve code readability, maintainability, and modularity.

    For the BankAccount project, you can use the following prompts to generate suggestions for refactoring or simplifying your code:

    Prompt: `@workspace /explain #file:Program.cs How can I improve the readability of the selected code?`

    Prompt: `@workspace /explain #file:Program.cs How can I improve the maintainability of the selected code?`

    Prompt: `@workspace /explain #file:Program.cs How can I improve the modularity of the selected code?`

    Prompt: `@workspace /explain #file:Program.cs How can I improve the reusability of the selected code?`

    Prompt: `@workspace /explain #file:Program.cs What are some options for refactoring the selected code?`

    Prompt: `@workspace /explain #file:Program.cs What are some options for simplifying the selected code?`

1. Select the three prompts that you'll use during the remainder of the exercise.

### Refactor your code using GitHub Copilot Chat

GitHub Copilot Chat will suggest code updates that refactor your code. It's important to understand the code that you're working with before you make decision about refactoring. You will need to review the suggestions provided by GitHub Copilot Chat and consider which suggestions support your goals before you implement them. For the purpose of this exercise, your time may also be a factor in deciding which suggestions to implement.

1. Ensure that you have the **APL2007M5BankAccount** project open in Visual Studio Code.

1. Expand the BankAccount folder and open the **Program.cs** file.

1. Take a minute to review the code.

    This program is a console application that simulates a banking system. It creates a number of bank accounts, simulates transactions on these accounts, and simulates transfers between these accounts. Here are the key features:

    - Constants: The program defines several constants at the top of the Program class. These constants include the maximum number of years back a bank account can be opened, the number of accounts to be created, the number of transactions to be simulated, and the minimum and maximum amounts for transactions and initial account balances.

    - Main Method: The Main method is the entry point of the program. It creates a list of bank accounts and then simulates transactions and transfers on these accounts.

    - CreateBankAccounts Method: This method creates a specified number of bank accounts with random initial balances, account holder names, account types, and opening dates. It uses a try-catch block to handle any exceptions that might occur during account creation.

    - SimulateTransactions Method: This method simulates a specified number of transactions on a list of bank accounts. It generates a random transaction amount for each transaction and then credits or debits the account with this amount, depending on whether the amount is positive or negative. It uses a try-catch block to handle any exceptions that might occur during the transactions.

    - SimulateTransfers Method: This method is identical to the SimulateTransactions method. It seems to be intended to simulate transfers between accounts, but currently, it just simulates transactions on individual accounts.

    - GenerateRandomDollarAmount Method: This method generates a random dollar amount within a specified range. It uses a different formula to generate the amount depending on whether the amount is for an account balance or a transaction.

    - GenerateRandomAccountHolder Method: This method selects a random account holder name from a predefined list of names.

    - GenerateRandomAccountType Method: This method selects a random account type from a predefined list of types.

    - GenerateRandomDateOpened Method: This method generates a random date within a specified range of years back from the current date.

    The program uses the BankAccount class to represent bank accounts. This class is not shown in the provided code, but it presumably has properties for the account number, balance, account holder name, account type, and date opened, and methods for crediting and debiting the account.

1. Ensure that the project builds and runs without errors.

1. Open the Chat view, and then enter the first prompt that you've prepared.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain #file:Program.cs How can I improve the readability of the selected code?` in the Chat view, GitHub Copilot Chat will suggest updates that are similar to the following:

    *1. Extract repeated code into separate methods: The Random object is created multiple times in different methods. You could create a static Random object at the class level and use it in all methods. This would not only improve readability but also provide better randomness.*

    `private static readonly Random random = new Random();`

    *1. Use meaningful variable names: The variable name range in the GenerateRandomDateOpened method is a bit vague. A more descriptive name like daysRange could be used.*

    *1. Add comments: While the code is mostly self-explanatory, adding comments to explain what each method does can be helpful for other developers reading your code.*

    *1. Use constants for magic numbers: In the GenerateRandomDateOpened method, the number 10 is used to represent the number of years back the start date can be. This could be extracted to a constant with a descriptive name, like MaxYearsBack.*

    *1. Use var keyword: In C#, you can use the var keyword when the right-hand side of the assignment makes the type obvious. This can make your code cleaner and easier to read.*

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
    > Notice the placeholder values (such as `/* types here */`) in the `GenerateRandomAccountHolder` and `GenerateRandomAccountType` methods. GitHub Copilot Chat will often replace code details with placeholders. These are easy to spot if you're paying attention. You'll need to replace the placeholder values with values from your app if you implement an update. When you see placeholders, you should make copies of your existing values before implementing the suggested updates. If the suggested code block aligns with the code in your app, you can use a block comment to comment out your existing code, and then use the Chat view's **Insert at Cursor** button to make the suggested updates without creating a naming conflict. Once you've verified that the suggested update works as expected, you can remove the block comment.

1. Implement the suggested updates that help to improve code readability, maintainability, modularity.

    > [!IMPORTANT]
    > At your place of business, you'll also need to ensure that updates comply with the coding standards and policies that you're following.

    If you used block comments to comment out your existing code, you can use the Chat view's **Insert at Cursor** to insert the suggested updates. You can also use the Copy option and paste the update into the location of your choice.

1. To ensure that no errors were introduced by the changes, build and run your solution before continuing.

1. Enter your second prompt and review the updates proposed by GitHub Copilot Chat.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain #file:Program.cs How can I improve the maintainability of the selected code?` in the Chat view, GitHub Copilot Chat will suggest updates that are similar to the following:

    *The selected code is well-structured and follows good practices, but there are a few areas where it could be improved for better maintainability:*

    *1. Separation of Concerns: The Main method is doing a lot of things: creating accounts, simulating transactions, and simulating transfers. These could be broken down into separate methods to improve readability and maintainability.*

    *1. Error Handling: The code uses a general Exception for error handling. It would be better to create custom exceptions that are specific to the application. This would make it easier to understand and handle errors.*

    *1. Magic Numbers: The code contains magic numbers (like 20 for the number of accounts, 100 for the number of transactions, etc.). These should be replaced with named constants.*

    *1. Code Duplication: The code for generating random values is duplicated in several places. This could be refactored into a utility class or methods.*

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

1. Take a minute enter your third prompt and review the suggestions.

    > [!NOTE]
    > You will not be implementing the suggested updates from your third prompt during this exercise. However, reviewing the additional suggestions may provide interesting insights into how you can further improve your code.

    For example, if you enter `@workspace /explain /file:Program.cs How can I improve the modularity of the selected code?` in the Chat view, GitHub Copilot Chat will suggest updates that are similar to the following:

    *The selected code is a simulation of a banking system. It creates bank accounts, simulates transactions, and transfers between these accounts. While the code is functional, it could be improved in terms of modularity. Here are some suggestions:*

    *1. Separate Concerns: The `Program` class is doing too much. It's creating accounts, simulating transactions, and generating random data. Each of these responsibilities could be a separate class. For example, you could have a `BankAccountFactory` class that's responsible for creating bank accounts, a `TransactionSimulator` class for simulating transactions, and a `RandomDataGenerator` class for generating random data.*

    *1. Use Interfaces: Interfaces can be used to define a contract for classes. This can make your code more flexible and easier to test. For example, you could define an `IAccountFactory` interface with a `Create` method, and then have `BankAccountFactory` implement this interface.*

    *1. Magic Numbers: There are several "magic numbers" in the code (like 10, 50000, -500, 500, etc.). These numbers should be replaced with named constants to make the code more readable and maintainable.*

    *1. Duplication: The `SimulateTransactions` and `SimulateTransfers` methods have almost identical code. This duplication could be eliminated by creating a common method that both methods call.*

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

In the next two units will cover the follow:

- Improve code reliability by using GitHub Copilot Chat
- Improve code security and performance by using GitHub Copilot Chat

## Summary

In this exercise, you used GitHub Copilot Chat to generate suggestions that help you improve code quality in a sample application. You developed prompts that focused on improving code readability, maintainability, and modularity. You reviewed the suggestions provided by GitHub Copilot Chat and implemented the updates that helped to improve code quality. You also considered additional suggestions that could further improve your code.
