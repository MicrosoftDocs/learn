Code reliability and performance are closely related aspects of software quality. They are interdependent in the following ways:

- Improvements in one area can positively affect the other.
- Deficiencies in one can lead to problems with the other.

> [!IMPORTANT]
> This training isn't about best practices for developing reliable or high-performing code. Instead, it focuses on how to use GitHub Copilot Chat to generate suggestions for improving code reliability and performance in a sample application. The suggestions do not represent best practices or comprehensive solutions for code reliability and performance. Developers should use their judgment and expertise to evaluate and implement the suggestions provided by GitHub Copilot Chat. Implementing suggestions proposed by GitHub Copilot does not replace the need for thorough code reviews and testing.

## Code reliability and performance

Developers should strive for a balance between code reliability and performance. A successful balance produces the following mutually beneficial results:

- Applications that meet functional requirements.
- Applications that deliver a seamless and efficient user experience.

The following sections provide an overview of code reliability and performance, along with factors that developers should consider when working on improvements in these areas.

### Examine code reliability

Code reliability refers to the likelihood that software functions correctly under specific conditions and for a certain period of time. Improving code reliability helps to ensure that your software performs as expected and meets user requirements.

Developers can consider the following factors when working on code reliability improvements:

- Potential issues: Identifying potential issues in the code can help prevent bugs and errors from occurring. Identifying potential issues should include reviewing the code for common pitfalls and addressing them proactively.
- Testing: Adequate testing is crucial to identify and fix bugs before the product is released. Adequate testing should include unit testing, integration testing, system testing, and acceptance testing.
- Exception handling: Proper exception handling mechanisms can prevent a system from failing when unexpected conditions occur.

> [!NOTE]
> Ensure that your code quality is high before your start working on code reliability. Code refactoring, along with standards and guidelines, can help ensure high-quality code.

There are other factors that affect code reliability. Some of theses factors aren't developer responsibilities, while others should be considered before or after code reliability. These other factors include:

- Development practices: Following best practices in software development, such as code reviews, pair programming, and adhering to coding standards, can lead to more reliable code.
- Reliability goals and metrics: Setting clear reliability goals and having metrics to measure them can guide the development process towards creating more reliable software.
- Documentation: Comprehensive documentation can aid in understanding the system and its components, which is essential for maintaining and troubleshooting the system.
- Dependencies: External libraries and services that the code depends on can affect its reliability. If a third-party service fails, it can cause the dependent system to fail as well.
- Performance: Performance issues can also affect reliability. Ensuring that the system performs well under different loads is important.
- Monitoring and troubleshooting: Continuous monitoring and a reliable troubleshooting guide can help maintain the reliability of a service by quickly identifying and addressing issues.
- Design and architecture: A well-designed system with a solid architecture can handle errors gracefully and maintain functionality even when some components fail.
- External factors: Post-release reliability issues can arise due to external factors such as hardware and operating system updates, which may introduce compatibility issues or system failures.

Improving the reliability of your code can help you to reduce the likelihood of bugs, errors, and unexpected behaviors.

### Examine code performance

Code performance refers to how efficiently a program or application runs, particularly in terms of speed, memory usage, and overall resource consumption. To ensure or improve code performance, developers can take several actions:

Developers should consider the following factors when working on code performance improvements:

- Optimize algorithms: Choose the most efficient algorithms and data structures for the task at hand. Even small improvements can have a significant impact on performance.
- Avoid unnecessary computations: Cache results of expensive operations when possible, and avoid redundant calculations.
- Use multithreading and asynchronous programming: Take advantage of modern CPU architectures by parallelizing tasks and performing I/O operations asynchronously.
- Minimize I/O operations: Disk and network I/O can be slow, so it’s important to minimize these operations or perform them asynchronously to avoid blocking the main execution thread.

> [!NOTE]
> Ensure that your code quality is high before your start working on code performance. Code refactoring, along with standards and guidelines, can help ensure high-quality code.

There are other factors that affect code performance. Some of theses factors aren't developer responsibilities, while others should be considered before or after working on code performance. These other factors include:

- Profile and benchmark: Use profiling tools to identify performance bottlenecks. Benchmarking before and after making changes can quantify the impact of optimizations.
- Manage memory efficiently: Use memory profiling tools to detect leaks and ensure that memory is being allocated and deallocated properly.
- Optimize database interactions: Use efficient queries, proper indexing, and database caching to minimize the performance overhead of database interactions.
- Code reviews: Regularly review code for performance issues. Peer reviews can help catch inefficiencies that the original developer might have missed.
- Stay updated: Use the latest versions of languages, libraries, and frameworks, as they often include performance improvements.
- Educate and collaborate: Stay informed about best practices for performance optimization and collaborate with other developers to learn from their experiences.

When developers focus on these areas, they can significantly improve the performance of their code, leading to faster, more responsive applications. Performance optimization is an ongoing process, and it’s important to continuously monitor and improve the performance of your applications.

GitHub Copilot Chat can help you improve the performance of your code by providing suggestions for optimizing algorithms, reducing unnecessary computations, using multithreading and asynchronous programming, and minimizing I/O operations.

## Improve code reliability and performance using GitHub Copilot Chat

In this exercise, you use GitHub Copilot Chat to generate suggestions that help you improve code reliability and performance in a sample application.

### Prepare sample apps in your Visual Studio Code environment

You use the **APL2007M5BankAccount-Reliability** project during this exercise. It's located in the **SampleApps** folder that you downloaded in the previous unit. You should be able to find the SampleApps folder on your Windows Desktop.

Open the **APL2007M5BankAccount-Reliability** sample app in Visual Studio Code.

### Develop prompts for GitHub Copilot Chat

The prompts you write for GitHub Copilot Chat should provide a clearly defined context and intent. Consider the following suggestions when developing your prompts:

- Define an outer context that's scoped at a higher level than the code you want to update. For example, if you want to improve a method, specify the class or file that includes the method as the outer context. Identify the method as an inner context.
- Use chat participants and chat variables to help specify context. You can use the `#file:` and `#selection` chat variables to identify the specific code you are focused on. You can also include the full workspace (`@workspace`) when appropriate. Refer to the file or code selection in the natural language portion of your prompt.
- The intent should be clear, concise, and specific. Your prompt should specify the type of improvement you want to achieve.

During this portion of the exercise, you review the **APL2007M5BankAccount-Reliability** project and create three prompts for GitHub Copilot Chat. The prompts focus on improving code reliability and performance.

Use the following steps to complete this portion of the exercise:

1. Open the Solution Explorer view.

1. Expand the **BankAccount** project, and then review the **BankAccount.cs** and **Program.cs** code files.

    The **BankAccount.cs** file contains the code for the `BankAccount` class, which represents a bank account with properties such as AccountNumber, Balance, AccountHolderName, AccountType, and DateOpened. It contains the following methods:

    - Credit(double amount): This method increases the Balance of the account by the specified amount.
    - Debit(double amount): This method decreases the Balance of the account by the specified amount. If the Balance is less than the amount, it throws an Exception with the message "Insufficient balance for debit."
    - GetBalance(): This method returns the current Balance of the account.
    - Transfer(BankAccount toAccount, double amount): This method transfers a specified amount from the current account to the toAccount. If the Balance is less than the amount, it throws an Exception with the message "Insufficient balance for transfer." If the AccountHolderName is different and the amount is more than 500, it throws an Exception with the message "Transfer amount exceeds maximum limit for different account owners."
    - PrintStatement(): This method prints the AccountNumber and Balance to the console.
    - CalculateInterest(double interestRate): This method calculates the interest on the current Balance using the specified interestRate.

    The **Program.cs** file contains a console application that simulates a banking system. It includes the following methods:

    - Main Method: The entry point of the application. It creates a list of bank accounts and simulates transactions and transfers on these accounts.
    - CreateBankAccounts Method: This method creates a specified number of bank accounts with random initial balances, account holder names, account types, and opening dates. It uses a try-catch block to handle any exceptions that might occur during account creation.
    - SimulateTransactions Method: This method simulates a specified number of transactions on each account in the provided list. Each transaction is a random dollar amount, and can be either a credit (deposit) or a debit (withdrawal), depending on whether the amount is positive or negative.
    - SimulateTransfers Method: This method is identical to SimulateTransactions. It seems like it's intended to simulate transfers between accounts, but currently, it's just duplicating the functionality of SimulateTransactions.
    - GenerateRandomDollarAmount Method: This method generates a random dollar amount within a specified range. The range and calculation method differ depending on whether the amount is for an account balance or a transaction
    - GenerateRandomAccountHolder Method: This method selects a random account holder name from a predefined list.
    - GenerateRandomAccountType Method: This method selects a random account type from a predefined list.
    - GenerateRandomDateOpened Method: This method generates a random date within a specified range for the account opening date.

1. Take a minute to consider the prompts that could help you to improve code reliability and performance.

    Develop prompts for both the BankAccount class and the Program class. Consider the following reliability and performance factors when developing your prompts:

    - Potential issues: Identifying potential issues in the code can help prevent bugs and errors from occurring. This includes reviewing the code for common pitfalls and addressing them proactively.
    - Testing: Adequate testing is crucial to identify and fix bugs before the product is released. This includes unit testing, integration testing, system testing, and acceptance testing.
    - Exception handling: Proper exception handling mechanisms can prevent a system from failing when unexpected conditions occur.

    - Optimize Algorithms: Choose the most efficient algorithms and data structures for the task at hand. Even small improvements can have a significant impact on performance.
    - Avoid Unnecessary Computations: Cache results of expensive operations when possible, and avoid redundant calculations.
    - Use Multithreading and Asynchronous Programming: Take advantage of modern CPU architectures by parallelizing tasks and performing I/O operations asynchronously.
    - Minimize I/O Operations: Disk and network I/O can be slow, so it’s important to minimize these operations or perform them asynchronously to avoid blocking the main execution thread.

    For this project, you can use the following prompts to generate suggestions for improving the reliability of your code:

    Prompt: `@workspace /explain #file:BankAccount.cs How can I improve exception handling the selected code?` (BankAccount.cs)

    Prompt: `@workspace /explain #file:BankAccount.cs How can I reduce unexpected issues for the selected code?` (BankAccount.cs)

    Prompt: `@workspace /explain #file:BankAccount.cs How can I improve unit test support for the selected code?` (BankAccount.cs)

    Prompt: `@workspace /explain #file:Program.cs How can I avoid future bugs or issues in the selected code?` (Program.cs)

    Prompt: `@workspace /explain #file:Program.cs How can I improve exception handling for the selected code?` (Program.cs)

    Prompt: `@workspace /explain #file:Program.cs How can I improve the efficiency of algorithms or data structures for the selected code?` (Program.cs)

    Prompt: `@workspace /explain #file:Program.cs How can I improve performance with asynchronous tasks or methods in the selected code?` (Program.cs)

    Prompt: `@workspace /explain #file:BankAccountTests.cs How can I improve unit test support for the selected code?` (BankAccountTests.cs)

1. Select two prompts that you can use to improve the BankAccount class during this exercise.

    For the BankAccount class, try to select prompts that focus on reliability.

1. Select two prompts that you can use to improve the Program class during this exercise.

    For the Program class, try to select one prompt that focuses on reliability and one that focuses on performance.

### Improve code reliability of the BankAccount class using GitHub Copilot Chat

Ensuring the reliability of production code is essential for any software project. The APL2007M5BankAccount-Reliability sample app uses the Program class to simulate the banking scenario, but it's the BankAccount class that's deployed to a production environment. Improving the reliability of the BankAccount class helps to ensure that it performs as expected and meets user requirements.

GitHub Copilot Chat can be used to help improve the reliability of your code. Your prompts can direct GitHub Copilot to generate suggestions that improve exception handling, reduce unexpected issues, and improve unit test support. You can also create broadly scoped prompts that ask for general suggestions to improve the reliability of the code. A combination of specific and general prompts can help you to identify areas that need improvement and implement the necessary changes.

> [!TIP]
> Implementing and testing suggested updates takes time, and time may be a factor during this exercise. Selecting prompts that focus on specific areas of improvement can help you to manage your time. Prompts that are too broad may generate a large number of suggestions or complex suggestions that are difficult to evaluate and implement in a short amount of time. Once you begin, you can update your prompts with more specific details if you find that the suggested updates are too broadly scoped or too complex.

1. Ensure that the project builds and runs without errors.

    Warnings are acceptable as long as the application runs, but errors must be resolved before you start working with GitHub Copilot Chat.

1. Open the BankAccount.cs file in Visual Studio Code, and then select all of the code in the file.

1. Open the Chat view, and then enter the first "reliability" prompt that you prepared for the BankAccount class.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain #file:BankAccount.cs How can I improve exception handling the selected code?` in the Chat view, GitHub Copilot Chat suggests updates that are similar to the following response:

    *In the provided `BankAccount` class, exceptions are thrown when certain conditions are not met, such as insufficient balance for a debit or transfer operation. Throwing exceptions is a good practice as it prevents the program from continuing with invalid state or data. However, there are a few improvements you can make to enhance the exception handling:*

    *1. **Use Specific Exceptions**: Instead of throwing the base `Exception` class, use more specific exceptions. This makes it easier for the calling code to understand and handle specific types of errors. For example, you could throw an InvalidOperationException when trying to debit or transfer with insufficient funds.*

    *2. **Include More Information in Exception Messages**: The exception messages could provide more details about the operation that failed. For example, in the `Debit` method, the exception message could include the attempted debit amount and the current balance.*

    *3. **Consider Custom Exceptions**: If there are specific error conditions that are unique to your application, you might want to create custom exception classes. Creating custom exceptions allows you to encapsulate more information about the error condition and makes your code more self-documenting.*

    *Here's how you could improve the `Debit` method with these suggestions:*

    ```csharp
    public void Debit(double amount)
    {
        if (Balance >= amount)
        {
            Balance -= amount;
        }
        else
        {
            throw new InvalidOperationException($"Insufficient balance for debit. Attempted to debit {amount}, but current balance is {Balance}.");
        }
    }
    ```

    *And here's an example of a custom exception class:*

    ```csharp
    public class InsufficientFundsException : Exception
    {
        public double AttemptedAmount { get; }
        public double CurrentBalance { get; }
    
        public InsufficientFundsException(double attemptedAmount, double currentBalance)
            : base($"Insufficient balance for debit. Attempted to debit {attemptedAmount}, but current balance is {currentBalance}.")
        {
            AttemptedAmount = attemptedAmount;
            CurrentBalance = currentBalance;
        }
    }
    ```

    *You could then throw this custom exception in the Debit method:*

    ```csharp
    public void Debit(double amount)
    {
        if (Balance >= amount)
        {
            Balance -= amount;
        }
        else
        {
            throw new InsufficientFundsException(amount, Balance);
        }
    }
    ```

    *This way, the calling code can catch InsufficientFundsException and have access to the AttemptedAmount and CurrentBalance properties to handle the error condition more effectively.*

1. Implement the suggested updates that help to improve code reliability for your `BankAccount` class.

1. To ensure that no errors were introduced by the changes, build and run your solution before continuing.

    > [!TIP]
    > In the example above, the Chat view provided code snippets that implement one example of the suggested update (using specific exceptions, including more information in the exception message, and creating custom exceptions). After you implement suggestions, try using code line completions to generate new code that duplicates the update. In the case of this example, code line completions can be used to create more custom exception classes. You can then use code line completions to update the other methods with the new custom exceptions. You can also rerun the original prompt to see other suggestions.

1. Select all of the code in the BankAccount.cs file, and then enter your second "reliability" prompt in the Chat view.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain #file:BankAccount.cs How can I reduce unexpected issues for the selected code?` in the Chat view, GitHub Copilot Chat suggests updates that are similar to the following response:

    *The code you provided is well-structured and uses custom exceptions to handle various error conditions, which is a good practice. However, there are a few improvements you could make to further reduce unexpected issues:*

    *1. Use Enum for Account Type: Instead of using a string for the account type and checking if it's "Savings" or "Current", consider using an enum. This would prevent potential issues with string comparison (like case sensitivity) and limit the account type to predefined values.*

    ```csharp
    public enum AccountType
    {
        Savings,
        Current
    }
    ```

    *2. Use Decimal for Monetary Values: It's generally recommended to use the decimal type instead of double for monetary values to avoid rounding errors.*

    *3. Add More Validations: You could add more validations in your methods. For example, in the Transfer method, you could check if the toAccount is not null before proceeding with the transfer.*

    *4. Use Constants for Magic Numbers: In your Transfer method, there's a magic number 500. It would be better to define it as a constant with a meaningful name at the top of your class.*

    ```csharp
    private const double MaxTransferAmountForDifferentOwners = 500;
    ```

    *5. Custom Exception for Transfer Limit: Instead of throwing a general Exception when the transfer amount exceeds the limit for different account owners, consider creating a custom exception like ExceededTransferLimitException.*

    *6. Logging: Consider adding logging to your application. This can help you understand the flow of your application and diagnose issues.*

    *7. Unit Tests: Write unit tests for your methods to ensure they behave as expected in various scenarios. This can help catch issues early in the development process.*

1. Consider the scope and breadth of the suggestions provided by GitHub Copilot Chat.

    Some prompts may generate a large number of suggestions that affect a broad scope. If this happens, check to see if a single suggestion item can be used to define a new prompt that provides a more specific intent and/or context.

1. Use the list of suggestions to construct a prompt that includes a more detailed intent and/or context.

    Each of the suggestions provided by GitHub Copilot Chat can be investigated and implemented separately. Starting at the top of the list and working your way down can help you to focus on one improvement at a time.

1. Enter your detailed prompt in the Chat view, and then review the suggestions provided by GitHub Copilot Chat.

    Suppose you used the second reliability prompt example. GitHub Copilot Chat's response includes the following suggestion item:

    *Add More Validations: You could add more validations in your methods. For example, in the Transfer method, you could check if the toAccount is not null before proceeding with the transfer.*

    You could use this suggestion to create a new prompt that focuses on adding more validations to the Transfer method. You could select the Transfer method and then enter the following prompt in the Chat view:

    `@workspace /explain #file:BankAccount.cs How can I improve method validations for the selected code?`

    In this case, GitHub Copilot Chat suggests updates that are similar to the following response:

    *The code you provided is well-structured and follows good practices for exception handling. However, there are a few areas where you could make improvements:*

    *1. Consolidate Validation Logic: You could create a separate validation class or method to handle all the validation logic. This would make your BankAccount class cleaner and more focused on its main responsibilities.*

    *2. Use Custom Validation Attributes: For some of the validation, you could use custom validation attributes. This would allow you to annotate the properties that need validation and keep the validation logic separate from the business logic.*

    *3. Use Fluent Validation: Fluent Validation is a .NET library that uses a fluent interface and lambda expressions for building validation rules. This can make your validation code more intuitive and easier to read.*

    *4. Avoid Magic Numbers: In your Transfer method, you have a hardcoded value of 500. It's generally a good practice to avoid "magic numbers" and instead define them as constants with meaningful names at the top of your class.*

    Here's an example of how you might implement some of these suggestions:

    ```csharp
    public class BankAccount
    {
        private const double MaxTransferAmountForDifferentOwners = 500;
    
        // ...
    
        public void Transfer(BankAccount toAccount, double amount)
        {
            ValidateTransferAmount(amount);
            ValidateTransferLimitForDifferentOwners(toAccount, amount);
    
            if (Balance >= amount)
            {
                Debit(amount);
                toAccount.Credit(amount);
            }
            else
            {
                throw new InsufficientFundsException(amount, Balance);
            }
        }
    
        private void ValidateTransferAmount(double amount)
        {
            if (amount < 0)
            {
                throw new InvalidTransferAmountException(amount);
            }
        }
    
        private void ValidateTransferLimitForDifferentOwners(BankAccount toAccount, double amount)
        {
            if (AccountHolderName != toAccount.AccountHolderName && amount > MaxTransferAmountForDifferentOwners)
            {
                throw new Exception("Transfer amount exceeds maximum limit for different account owners.");
            }
        }
    }
    ```

    You can continue working through the suggestions provided by GitHub Copilot Chat until you implement all of the improvements that you think are necessary.

1. Implement the suggested updates, and then build and run your solution before continuing.

    Fix any errors that are introduced by the changes before you continue.

### Improve code reliability and performance of the Program class using GitHub Copilot Chat

1. Open the Program.cs file in Visual Studio Code, and then select all of the code in the file.

1. Open the Chat view, and then enter the "performance" prompt that you prepared for the Program class.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain #file:Program.cs How can I improve performance with asynchronous tasks or methods in the selected code?` in the Chat view, GitHub Copilot Chat suggests updates that are similar to the following response:

    *In the selected code, you can improve performance by using asynchronous programming for the SimulateTransactions and SimulateTransfers methods. These methods are performing operations on each account in a sequential manner, which can be time-consuming if the number of accounts or transactions is large.*

    *Here's how you can modify the SimulateTransactions method to use Task for asynchronous programming:*

    ```csharp
    static async Task SimulateTransactionsAsync(List<BankAccount> accounts, int numberOfTransactions, double minTransactionAmount, double maxTransactionAmount)
    {
        var tasks = accounts.Select(async account =>
        {
            for (int i = 0; i < numberOfTransactions; i++)
            {
                double transactionAmount = GenerateRandomDollarAmount(false, minTransactionAmount, maxTransactionAmount);
                try
                {
                    if (transactionAmount >= 0)
                    {
                        account.Credit(transactionAmount);
                        Console.WriteLine($"Credit: {transactionAmount}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
                    }
                    else
                    {
                        account.Debit(-transactionAmount);
                        Console.WriteLine($"Debit: {transactionAmount}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Transaction failed: {ex.Message}");
                }
            }
    
            Console.WriteLine($"Account: {account.AccountNumber}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
        });
    
        await Task.WhenAll(tasks);
    }
    ```

    *You can do the same for the SimulateTransfers method.*

    *Please note that this assumes that the Credit and Debit methods of the BankAccount class are thread-safe. If they are not, you need to ensure thread safety before using this approach.*

    *Also, keep in mind that the order of console output may not be the same as the original code due to the concurrent execution of tasks. If maintaining the order of output is important, you might need to use other methods such as ConcurrentQueue to store the output and then write it to the console in order.*

    *Finally, remember to call these methods with await in the Main method, which also needs to be marked as async:*

    ```csharp
    static async Task Main(string[] args)
    {
        List<BankAccount> accounts = CreateBankAccounts(NumberOfAccounts);
        await SimulateTransactionsAsync(accounts, NumberOfTransactions, minTransactionAmount, maxTransactionAmount);
        await SimulateTransfersAsync(accounts, NumberOfTransactions, minTransactionAmount, maxTransactionAmount);
    }
    ```

1. Implement the suggested updates that help to improve code performance (or reliability) of your `Program` class.

    > [!NOTE]
    > For the `@workspace /explain #file:Program.cs How can I improve performance with asynchronous tasks or methods in the selected code?` prompt, the suggested method updates lack awaitable tasks and the methods run synchronously. However, both methods use the `Select` LINQ method to create a collection of tasks, each of which performs a series of transactions on (potentially) a different bank account. These tasks are all started at roughly the same time and they run concurrently (not in parallel). This means that they all make progress at the same time, but they do not necessarily run on different threads.

    The `await Task.WhenAll(tasks)` line waits for all of these tasks to complete. This is an asynchronous operation, because the method yields control while it's waiting for the tasks to complete. This allows other code to run on the same thread while the tasks are in progress.

    There can be significant performance benefits to running tasks concurrently, especially for I/O-bound operations like the ones in your code.

    In the `SimulateTransactionsAsync` and `SimulateTransfersAsync` methods, each task is performing operations on a (potentially) different bank account. In a production environment, these operations would likely involve waiting for a response from a server, which is an I/O-bound operation. While one task is waiting for a response, the other tasks can continue to make progress. This is much more efficient than running the tasks one after the other, which would require waiting for each operation to complete before starting the next one.

    Concurrent execution can also improve the responsiveness of your application. While the tasks are running, your application can continue to respond to user input or perform other work.

1. To ensure that no errors were introduced by the changes, build and run your solution before continuing.

1. Select all of the code in the Program.cs file, and then enter your "reliability" prompt in the Chat view.

1. Review the suggestions provided by GitHub Copilot Chat.

    > [!NOTE]
    > You don't need to implement the update suggestions that GitHub Copilot generated from this fourth prompt, but you should review the suggestions.

    For example, if you enter `@workspace /explain #file:Program.cs How can I improve exception handling for the selected code?` in the Chat view, GitHub Copilot Chat suggests updates that are similar to the following response:

    *The current exception handling in your code is quite basic. It catches all exceptions, writes a message to the console, and then continues execution. This is a good start, but there are several ways you could improve it:*

    *1. Specific Exception Types: Instead of catching all exceptions, you could catch specific exception types that you expect might occur. This allows you to handle different types of exceptions in different ways.*

    *2. Logging: Instead of (or in addition to) writing the exception message to the console, you could log the exception. This could be as simple as writing to a file, or you could use a logging library that supports different log levels, multiple log targets, etc.*

    *3. Rethrowing Exceptions: In some cases, you might want to rethrow an exception after catching it. This allows a higher level of your code to also catch the exception and handle it. Be careful with this, as it can make your code harder to understand if overused.*

    *4. `Finally` Block: You can use a `finally` block to ensure that certain code gets executed whether an exception is thrown or not. This is useful for cleanup code, like closing a file or a network connection.*

    *Here's an example of how you might apply these suggestions to the CreateBankAccounts method:*

    ```csharp
    static List<BankAccount> CreateBankAccounts(int numberOfAccounts)
    {
        List<BankAccount> accounts = new List<BankAccount>();
        int createdAccounts = 0;
        while (createdAccounts < numberOfAccounts)
        {
            try
            {
                // ... existing code ...
            }
            catch (ArgumentException ex)
            {
                Console.WriteLine($"Account creation failed due to invalid argument: {ex.Message}");
                // Log the exception, rethrow it, etc.
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Account creation failed: {ex.Message}");
                // Log the exception, rethrow it, etc.
            }
            finally
            {
                // Any cleanup code would go here.
            }
        }
        return accounts;
    }
    ```

## Summary

In this exercise, you used GitHub Copilot Chat to generate suggestions that help you improve code reliability and performance in a sample application. You developed prompts that directed GitHub Copilot to provide suggestions that improve exception handling, reduce unexpected issues, and improve unit test support. You also created prompts that focused on improving performance with asynchronous tasks or methods.
