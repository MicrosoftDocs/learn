Code security refers to the measures taken to protect software from unauthorized access, data breaches, and other security threats. Code security is an essential aspect of software development that involves protecting applications and systems from security threats. Improving your code security can help you to protect your applications and systems from security threats.

> [!IMPORTANT]
> This training isn't about best practices for developing secure code. Instead, it focuses on how to use GitHub Copilot Chat to generate suggestions for improving code security in a sample application. The suggestions do not represent best practices or comprehensive solutions for developing secure code. Developers should use their judgment and expertise to evaluate and implement the suggestions provided by GitHub Copilot Chat. Implementing suggestions proposed by GitHub Copilot does not replace the need for thorough code reviews and testing.

## Code security

Ensuring code security is everyone's responsibility, not just the developer. However, developers play a crucial role by ensuring that the code they write follows secure coding practices. Secure coding practices help to ensure that software vulnerabilities can't be exploited by attackers. By following secure coding practices, developers can help protect the software from security threats and ensure that it is secure and reliable.

The following sections provide an overview of code security processes that you may want to consider.

### Evaluate code security using a comprehensive approach

When evaluating code security, it’s important to consider a comprehensive approach that encompasses various aspects of the software development lifecycle. Here are some key considerations:

- Secure coding practices: Adhering to secure coding standards and guidelines to prevent vulnerabilities.
- Code analysis tools: Utilizing static and dynamic code analysis tools to detect security flaws.
- Dependency management: Ensuring that third-party libraries and dependencies are up-to-date and free from known vulnerabilities.
- Authentication and authorization: Implementing robust authentication and authorization mechanisms to protect against unauthorized access.
- Data protection: Encrypting sensitive data both at rest and in transit to prevent data breaches.
- Error handling: Developing secure error handling procedures that do not expose sensitive information.
- Security testing: Conducting thorough security testing, including penetration testing and vulnerability assessments.
- Compliance: Ensuring that the code complies with relevant security standards and regulations.
- Education and training: Providing developers with ongoing security education and training to keep them informed about the latest threats and best practices.
- Incident response: Having a well-defined incident response plan prepared. If a security breach occurs, the incident response plan must be accessible.

Considering these factors and integrating security best practices into your development process contributes to the creation of secure content and applications.

### Conduct code security reviews

When working to ensure that code is secure, developers should review the following aspects of their code:

- Correctness: Verify that the code is free from logical errors and defects that could lead to security vulnerabilities.
- Security: Ensure that code adheres to security best practices and doesn't contain vulnerabilities.
- Diagnostics: Include proper logging and diagnostic capabilities to detect and respond to security incidents.
- Design errors or limitations: Review the design of the code to ensure there are no flaws or limitations that could be exploited.
- Scale and performance: Consider the performance and scalability of the code. Poor performance and scalability can impact security in high-load scenarios.
- Localization: Ensure that the code securely handles different locales, which can affect data formatting and representation.
- Accessibility (UX): Verify that security measures do not negatively impact the accessibility and user experience.
- Testing: Review the testing strategies and ensure that security testing is thorough and covers all aspects of the code.
- Instrumentation: Ensure that the code is instrumented in a way that supports security monitoring and threat detection.
- Consistency and code style conventions: Maintain a consistent coding style that follows secure coding guidelines and standards.

When developers review these aspects of their code, they can significantly enhance the security of their code. Code reviews help developers contribute to the overall security posture of the software they develop.

### Analyze code vulnerabilities

Certain portions of an application are more vulnerable to security attacks, and it’s crucial to focus on securing these areas. Here are some of the more vulnerable areas:

- Integration points: Security design reviews must be conducted for integration points with dependent product teams. Reviews are essential for products handling high business impact (HBI) data or enterprise applications and services.
- Internal systems: Internal incidents are a common cause of security breaches, especially in small businesses.
- Email systems: Email servers, particularly those that are unsupported or unpatched, are persistently vulnerable.
- Databases and storage: Databases that expect sensitive data to be pre-encrypted before storage can be vulnerable if the data is not encrypted as expected.
- Runtime environment: Technologies like Runtime Application Self-Protection (RASP) can detect attacks on an application in real-time, making the runtime environment a critical area to secure.
- Web applications: Web applications are often targeted by attackers using methods like SQL injection, cross-site scripting (XSS), and buffer overflows.
- Endpoints: Devices and applications are at risk of cyber attacks. It’s essential to reduce the attack surface using capabilities like ransomware mitigation, application control, web protection, and network firewall.

Developers and security teams should prioritize these areas and implement strong security measures to protect against potential attacks. Regular security reviews, updates, and adherence to best practices can help mitigate these vulnerabilities.

### Search for common security flaws

Developers can encounter various security flaws in their code, which can lead to vulnerabilities if not properly addressed. Some typical security flaws include:

- Injection Flaws: Such as SQL, NoSQL, OS, and LDAP injection, where untrusted data is sent to an interpreter as part of a command or query.
- Broken Authentication: When authentication and session management are implemented incorrectly, authentication can be broken. Good implementations ensure that passwords, keys, and session tokens aren't compromised by attackers.
- Sensitive Data Exposure: Inadequate protection of sensitive data can lead to exposure during transfer over the network or at rest.
- Broken Access Control: Restrictions that control the access granted to authenticated users are not being properly enforced.
- Cross-Site Scripting (XSS): XSS flaws occur whenever an application includes untrusted data in a web page without proper validation or escaping.
- Insecure Deserialization: This can lead to remote code execution, replay attacks, injection attacks, and privilege escalation attacks.
- Insufficient Logging & Monitoring: Insufficient logging and monitoring, coupled with missing or ineffective integration with incident response, allows for continued attacks.
- Insecure Direct Object References (IDOR): A type of access control issue that arises when an application provides direct access to objects based on user-supplied input.
- Missing Function Level Access Control: Sometimes an application does not properly protect function level access controls, allowing attackers to forge requests to access functionality without proper authorization.

Many other security flaws can be found in code. It’s important for developers to use tools and best practices to identify and fix these issues proactively.

## Improve code security using GitHub Copilot Chat

In this exercise, you'll use GitHub Copilot Chat to generate suggestions that help you improve code security in a sample application.

### Prepare sample apps in your Visual Studio Code environment

You'll use the **APL2007M5BankAccount-Security** project during this exercise. It's located in the **SampleApps** folder that you downloaded in the previous unit. You should be able to find the SampleApps folder on your Windows Desktop.

Open the **APL2007M5BankAccount-Security** sample app in Visual Studio Code.

### Develop prompts for GitHub Copilot Chat

The prompts you write for GitHub Copilot Chat should provide a clearly defined context and intent. Consider the following suggestions when developing your prompts:

- Define an outer context that's scoped at a higher level than the code you want to update. For example, if you want to improve a method, specify the class or file that includes the method as the outer context. Identify the method as an inner context.
- Use chat participants and chat variables to help specify context. You can use the `#file:` and `#selection` chat variables to identify the specific code you are focused on. You can also include the full workspace (`@workspace`) when appropriate. Refer to the file or code selection in the natural language portion of your prompt.
- The intent should be clear, concise, and specific. Your prompt should specify the type of improvement you want to achieve.

During this portion of the exercise, you review the **APL2007M5BankAccount-Security** project and create three prompts for GitHub Copilot Chat. The prompts focus on improving code security.

Use the following steps to complete this portion of the exercise:
Your goal for this exercise is to write prompts that help you to improve code security. You use the **APL2007M5BankAccount-Security** project to develop your prompts.

1. Open the **APL2007M5BankAccount-Security** project, and then review the **Program.cs** and **BankAccount.cs** code files.

    The **Program.cs** file contains the code for a simple banking application that simulates the creation of bank accounts, transactions, and transfers.

    The **BankAccount.cs** file contains the code for the `BankAccount` class, which represents a bank account with basic functionalities such as deposit, withdrawal, and balance inquiry.

1. Take a minute to consider the prompts that could help you to improve code security.

    For this project, you can use the following prompts to generate suggestions for improving your code security:

    Prompt: `@workspace /explain How can I implement authentication in the [selected code]?` (attach BankAccount.cs to the Chat context)

    Prompt: `@workspace /explain How can I protect sensitive data in the [selected code]?` (attach BankAccount.cs to the Chat context)

    Prompt: `@workspace /explain How can I implement logging of suspicious account activities of the [selected code]?` (attach BankAccount.cs to the Chat context)

    Prompt: `@workspace /explain How can I improve the security of exception handling in the [selected code]?` (attach BankAccount.cs to the Chat context)

    Prompt: `@workspace /explain How can I improve the security of the [selected code]?` (attach BankAccount.cs to the Chat context)

    Prompt: `@workspace /explain How can I improve the security of the [selected code]?` (attach Program.cs to the Chat context)

1. Select three prompts to use during the remainder of the exercise.

    Try to select two prompts that address security issues in the BankAccount.cs file and one for the Program.cs file. In this exercise, the BankAccount class represents your "product". The Program.cs file uses the BankAccount class to simulate account activities and transactions.

### Improve code security of the BankAccount class using GitHub Copilot Chat

Developing secure code is essential for any software project. The level of security required depends on the nature of the application and the data it processes.

In this exercise, you use GitHub Copilot Chat to generate suggestions for improving the security of the BankAccount class in the **APL2007M5BankAccount-Security** project.

GitHub Copilot Chat can be used to help improve code security. Your prompts can direct GitHub Copilot to generate suggestions for improving authentication, data protection, logging, and dozens of other topics. You can also create broadly scoped prompts that ask for general suggestions to improve code security. A combination of specific and general prompts can help you to identify areas that need improvement and implement the necessary changes.

> [!TIP]
> Implementing and testing suggested updates takes time, and time may be a factor during this exercise. Selecting prompts that focus on specific areas of improvement can help you to manage your time. Prompts that are too broad may generate a large number of suggestions or complex suggestions that are difficult to evaluate and implement in a short amount of time. Once you begin, you can update your prompts with more specific details if you find that the suggested updates are too broadly scoped or too complex.

1. Ensure that the project builds and runs without errors.

    Warnings are acceptable as long as the application runs, but errors must be resolved before you start working with GitHub Copilot Chat.

1. Open the BankAccount.cs file in Visual Studio Code, and then select all of the code in the file.

1. Open the Chat view.

1. In the Chat view, use the **Attach Context** button to add relevant files to the Chat context, and then enter your prompt.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, suppose you complete the following actions:

    - You open the BankAccount.cs file and select all of the code.
    - You choose the following prompt: `@workspace /explain How can I implement authentication in the BankAccount.cs file?`
    - You open the Chat view and attach the BankAccount.cs and Program.cs files to the Chat context.
    - You enter the prompt in the Chat view.

    GitHub Copilot Chat suggests updates that are similar to the following response:

    *Implementing authentication in this context would typically involve adding a method to the BankAccount class that verifies the account holder's identity before allowing certain operations. This could be done using a password, a PIN, or some other form of authentication.*

    *Here's a simple example of how you might add password-based authentication to the BankAccount class:*

    ```csharp
    public class BankAccount
    {
        // Existing code...
    
        private string password;
    
        public BankAccount(string accountNumber, double initialBalance, string accountHolderName, string accountType, DateTime dateOpened, string password)
        {
            // Existing code...
    
            this.password = password;
        }
    
        public bool Authenticate(string password)
        {
            return this.password == password;
        }
    
        public void Credit(double amount, string password)
        {
            if (!Authenticate(password))
            {
                throw new Exception("Authentication failed.");
            }
    
            // Existing code...
        }
    
        // Similar changes would be made to the Debit, Transfer, and other methods...
    }
    ```

    *In this example, a password is added as a parameter to the BankAccount constructor and stored in a private field. An Authenticate method is added that checks if the provided password matches the stored password. The Credit method (and other methods that should require authentication) is modified to take a password as an argument and call Authenticate before performing the operation.*

    *This is a very basic form of authentication and is not secure enough for real applications. In a real application, you would want to hash and salt the password before storing it, and you would need to use secure methods to transmit the password from the user to the application. You might also want to consider using two-factor authentication or other more secure methods.*

1. Implement the suggested updates that help to improve code security for your `BankAccount` class.

    The Program.cs file must be updated to use the password and authentication added to the BankAccount class. You can use GitHub Copilot Chat to generate suggestions for updating the Program.cs file.

    1. Select the contents of the Program.cs file, attach the Program.cs and BankAccount.cs files to the Chat context, and then enter the following prompt in the Chat view:

        ```plaintext
        @workspace /Explain How can I update the Program.cs file to use the password and authentication added to BankAccount.cs?
        ```

    1. Review the suggestions provided by GitHub Copilot Chat, and then implement the suggested updates.

    1. To ensure that no errors were introduced by the changes, build and run your solution before continuing.

        Use GitHub Copilot to help resolve any issues identified during the build process.

    > [!IMPORTANT]
    > This very basic form of authentication is not secure enough for real applications. In a real application, you would want to hash and salt the password before storing it, and you would need to use secure methods to transmit the password from the user to the application. You might also want to consider using two-factor authentication or other more secure methods.

1. Ensure that your application builds and runs before continuing.

1. Select all of the code in the BankAccount.cs file, and then enter your second prompt in the Chat view.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, suppose you complete the following actions:

    - You open the BankAccount.cs file and select all of the code.
    - You choose the following prompt: `@workspace /explain How can I protect account numbers and account holder names in the selected code?`
    - You open the Chat view and attach the BankAccount.cs and Program.cs files to the Chat context.
    - You enter the prompt in the Chat view.

    GitHub Copilot Chat suggests updates that are similar to the following response:

    *To protect sensitive data such as account numbers and account holder names in your BankAccount class, you can take the following steps:*

    *1. Use Encapsulation:*

    *- Make the sensitive properties private and provide controlled access through methods.*

    *2. Encrypt Sensitive Data:*

    *-Use encryption to store sensitive data securely.*

    *3. Avoid Plaintext Storage:*

    *- Ensure that sensitive data is not stored or transmitted in plaintext.*

    *Updated Implementation*

    *Here is an updated version of BankAccount.cs that uses encryption for account numbers and account holder names:*

    ```csharp
    using System;
    using System.Security.Cryptography;
    using System.Text;
    
    namespace BankAccountApp
    {
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
    
        public class InvalidAccountTypeException : Exception
        {
            public string AccountType { get; }
    
            public InvalidAccountTypeException(string accountType)
                : base($"Invalid account type: {accountType}.")
            {
                AccountType = accountType;
            }
        }
    
        public class InvalidAccountNumberException : Exception
        {
            public string AccountNumber { get; }
    
            public InvalidAccountNumberException(string accountNumber)
                : base($"Invalid account number: {accountNumber}.")
            {
                AccountNumber = accountNumber;
            }
        }
    
        public class InvalidAccountHolderNameException : Exception
        {
            public string AccountHolderName { get; }
    
            public InvalidAccountHolderNameException(string accountHolderName)
                : base($"Invalid account holder name: {accountHolderName}.")
            {
                AccountHolderName = accountHolderName;
            }
        }
    
        public class InvalidDateOpenedException : Exception
        {
            public DateTime DateOpened { get; }
    
            public InvalidDateOpenedException(DateTime dateOpened)
                : base($"Invalid date opened: {dateOpened}.")
            {
                DateOpened = dateOpened;
            }
        }
    
        public class InvalidInitialBalanceException : Exception
        {
            public double InitialBalance { get; }
    
            public InvalidInitialBalanceException(double initialBalance)
                : base($"Invalid initial balance: {initialBalance}.")
            {
                InitialBalance = initialBalance;
            }
        }
    
        public class InvalidInterestRateException : Exception
        {
            public double InterestRate { get; }
    
            public InvalidInterestRateException(double interestRate)
                : base($"Invalid interest rate: {interestRate}.")
            {
                InterestRate = interestRate;
            }
        }
    
        public class InvalidTransferAmountException : Exception
        {
            public double TransferAmount { get; }
    
            public InvalidTransferAmountException(double transferAmount)
                : base($"Invalid transfer amount: {transferAmount}.")
            {
                TransferAmount = transferAmount;
            }
        }
    
        public class InvalidCreditAmountException : Exception
        {
            public double CreditAmount { get; }
    
            public InvalidCreditAmountException(double creditAmount)
                : base($"Invalid credit amount: {creditAmount}.")
            {
                CreditAmount = creditAmount;
            }
        }
    
        public class InvalidDebitAmountException : Exception
        {
            public double DebitAmount { get; }
    
            public InvalidDebitAmountException(double debitAmount)
                : base($"Invalid debit amount: {debitAmount}.")
            {
                DebitAmount = debitAmount;
            }
        }
    
        public class AuthenticationException : Exception
        {
            public AuthenticationException(string message) : base(message) { }
        }
    
        public class BankAccount
        {
            public enum AccountTypes
            {
                Savings,
                Checking,
                MoneyMarket,
                CertificateOfDeposit,
                Retirement
            }
    
            private string EncryptedAccountNumber { get; }
            private string EncryptedAccountHolderName { get; }
            public double Balance { get; private set; }
            public AccountTypes AccountType { get; }
            public DateTime DateOpened { get; }
            private const double MaxTransferAmountForDifferentOwners = 500;
    
            private string Username { get; }
            private string Password { get; }
    
            public BankAccount(string accountNumber, double initialBalance, string accountHolderName, string accountType, DateTime dateOpened, string username, string password)
            {
                if (accountNumber.Length != 10)
                {
                    throw new InvalidAccountNumberException(accountNumber);
                }
    
                if (initialBalance < 0)
                {
                    throw new InvalidInitialBalanceException(initialBalance);
                }
    
                if (accountHolderName.Length < 2)
                {
                    throw new InvalidAccountHolderNameException(accountHolderName);
                }
    
                if (dateOpened > DateTime.Now)
                {
                    throw new InvalidDateOpenedException(dateOpened);
                }
    
                EncryptedAccountNumber = Encrypt(accountNumber);
                EncryptedAccountHolderName = Encrypt(accountHolderName);
                Balance = initialBalance;
                AccountType = (AccountTypes)Enum.Parse(typeof(AccountTypes), accountType);
                DateOpened = dateOpened;
                Username = username;
                Password = password;
            }
    
            public void Credit(double amount)
            {
                if (amount < 0)
                {
                    throw new InvalidCreditAmountException(amount);
                }
    
                Balance += amount;
            }
    
            public void Debit(double amount)
            {
                if (amount < 0)
                {
                    throw new InvalidDebitAmountException(amount);
                }
    
                if (Balance >= amount)
                {
                    Balance -= amount;
                }
                else
                {
                    throw new InsufficientFundsException(amount, Balance);
                }
            }
    
            public double GetBalance()
            {
                return Balance;
            }
    
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
                if (Decrypt(EncryptedAccountHolderName) != Decrypt(toAccount.EncryptedAccountHolderName) && amount > MaxTransferAmountForDifferentOwners)
                {
                    throw new Exception("Transfer amount exceeds maximum limit for different account owners.");
                }
            }
    
            public void PrintStatement()
            {
                Console.WriteLine($"Account Number: {Decrypt(EncryptedAccountNumber)}, Balance: {Balance}");
            }
    
            public double CalculateInterest(double interestRate)
            {
                if (interestRate < 0)
                {
                    throw new InvalidInterestRateException(interestRate);
                }
    
                return Balance * interestRate;
            }
    
            public void Authenticate(string username, string password)
            {
                if (Username != username || Password != password)
                {
                    throw new AuthenticationException("Invalid username or password.");
                }
            }
    
            private string Encrypt(string plainText)
            {
                using (Aes aes = Aes.Create())
                {
                    aes.Key = Encoding.UTF8.GetBytes("A very strong key"); // Use a secure key
                    aes.IV = Encoding.UTF8.GetBytes("A strong IV123456"); // Use a secure IV
    
                    ICryptoTransform encryptor = aes.CreateEncryptor(aes.Key, aes.IV);
    
                    using (var ms = new System.IO.MemoryStream())
                    {
                        using (var cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                        {
                            using (var sw = new System.IO.StreamWriter(cs))
                            {
                                sw.Write(plainText);
                            }
                        }
    
                        return Convert.ToBase64String(ms.ToArray());
                    }
                }
            }
    
            private string Decrypt(string cipherText)
            {
                using (Aes aes = Aes.Create())
                {
                    aes.Key = Encoding.UTF8.GetBytes("A very strong key"); // Use a secure key
                    aes.IV = Encoding.UTF8.GetBytes("A strong IV123456"); // Use a secure IV
    
                    ICryptoTransform decryptor = aes.CreateDecryptor(aes.Key, aes.IV);
    
                    using (var ms = new System.IO.MemoryStream(Convert.FromBase64String(cipherText)))
                    {
                        using (var cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
                        {
                            using (var sr = new System.IO.StreamReader(cs))
                            {
                                return sr.ReadToEnd();
                            }
                        }
                    }
                }
            }
        }
    }
    ```

    *Usage:*

    *- Ensure you have the necessary cryptographic libraries available. The above example uses AES encryption with a hardcoded key and IV for simplicity. In a real-world application, you should securely manage keys and IVs, possibly using a key management service.*

    > [!IMPORTANT]
    > In a real-world application, you should securely manage keys and IVs, possibly using a key management service. The examples provided in this training identify areas for improvement but do not represent best practices for secure encryption. You can use GitHub Copilot Chat to pursue additional suggestions for improving encryption and data protection in your application.

1. Do not need to implement the suggested updates for the second prompt.

    In the example, the suggested updates would help to improve the security of the application, but they require significant configuration and updates to the Program.cs code that is beyond the scope of this exercise.

### Improve code security of the Program class using GitHub Copilot Chat

1. Open the Program.cs file in Visual Studio Code, and then select all of the code in the file.

1. Open the Chat view, and then enter the first prompt that you prepared for the Program class.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, suppose you complete the following actions:

    - You open the Program.cs file and select all of the code.
    - You choose the following prompt: `@workspace /explain How can I improve the security of the Program.cs file?`
    - You open the Chat view and attach the BankAccount.cs and Program.cs files to the Chat context.
    - You enter the prompt in the Chat view.

    GitHub Copilot Chat suggests updates that are similar to the following response:

    *To improve the security of the Program.cs file, you should focus on the following areas:*

    *1. Secure Password Handling:*

    *- Use secure password hashing and avoid storing passwords in plaintext.*
    *- Use a library like BCrypt.Net for hashing passwords.*

    *2. Encrypt Sensitive Data:*

    *- Encrypt sensitive data such as account numbers and account holder names.*

    *3. Avoid Hardcoded Passwords:*

    *- Avoid using hardcoded passwords. Instead, generate strong random passwords or prompt users to create their own.*

    *4. Use Secure Random Number Generation:*

    *- Use a cryptographically secure random number generator for generating sensitive data.*

    *Updated Implementation*

    *Here is an updated version of Program.cs that incorporates these improvements:*

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security.Cryptography;
    using System.Text;
    using System.Threading.Tasks;
    
    namespace BankAccountApp
    {
        class Program
        {
            private static readonly Random random = new Random();
            private const int MaxYearsBack = 10;
            private const int NumberOfAccounts = 20;
            private const int NumberOfTransactions = 100;
            private const double minTransactionAmount = -500.0;
            private const double maxTransactionAmount = 500.0;
            private const double minAccountStart = 200.0;
            private const double maxAccountStart = 1000.0;
    
            static async Task Main()
            {
                List<BankAccount> accounts = CreateBankAccounts(NumberOfAccounts);
                await SimulateTransactionsAsync(accounts, NumberOfTransactions, minTransactionAmount, maxTransactionAmount);
                await SimulateTransfersAsync(accounts, NumberOfTransactions, minTransactionAmount, maxTransactionAmount);
            }
    
            static List<BankAccount> CreateBankAccounts(int numberOfAccounts)
            {
                List<BankAccount> accounts = new();
                int createdAccounts = 0;
                while (createdAccounts < numberOfAccounts)
                {
                    try
                    {
                        double initialBalance = GenerateRandomDollarAmount(true, minAccountStart, maxAccountStart);
                        string accountHolderName = GenerateRandomAccountHolder();
                        string accountType = GenerateRandomAccountType();
                        DateTime dateOpened = GenerateRandomDateOpened();
                        string accountNumber = "102000" + random.Next(1000, 9999).ToString();
                        string username = "user" + createdAccounts;
                        string password = GenerateSecurePassword();
                        BankAccount account = new(accountNumber, initialBalance, accountHolderName, accountType, dateOpened, username, password);
                        accounts.Add(account);
                        createdAccounts++;
                    }
                    catch (ArgumentException ex)
                    {
                        Console.WriteLine($"Account creation failed due to invalid argument: {ex.Message}");
                        // Log the exception
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Account creation failed: {ex.Message}");
                        // Log the exception
                    }
                    finally
                    {
                        // Any cleanup code would go here.
                    }
                }
                return accounts;
            }
    
            static async Task SimulateTransactionsAsync(List<BankAccount> accounts, int numberOfTransactions, double minTransactionAmount, double maxTransactionAmount)
            {
                var tasks = accounts.Select(async account =>
                {
                    for (int i = 0; i < numberOfTransactions; i++)
                    {
                        double transactionAmount = GenerateRandomDollarAmount(false, minTransactionAmount, maxTransactionAmount);
                        try
                        {
                            account.Authenticate(account.Username, account.Password); // Authenticate before transaction
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
    
            static async Task SimulateTransfersAsync(List<BankAccount> accounts, int numberOfTransactions, double minTransactionAmount, double maxTransactionAmount)
            {
                var tasks = accounts.Select(async account =>
                {
                    for (int i = 0; i < numberOfTransactions; i++)
                    {
                        double transactionAmount = GenerateRandomDollarAmount(false, minTransactionAmount, maxTransactionAmount);
                        try
                        {
                            account.Authenticate(account.Username, account.Password); // Authenticate before transfer
                            BankAccount toAccount = accounts[random.Next(accounts.Count)];
                            toAccount.Authenticate(toAccount.Username, toAccount.Password); // Authenticate target account
                            account.Transfer(toAccount, transactionAmount);
                            Console.WriteLine($"Transfer: {transactionAmount}, From: {account.AccountNumber}, To: {toAccount.AccountNumber}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Transfer failed: {ex.Message}");
                        }
                    }
    
                    Console.WriteLine($"Account: {account.AccountNumber}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
                });
    
                await Task.WhenAll(tasks);
            }
    
            static double GenerateRandomDollarAmount(bool isAccount, double min, double max)
            {
                if (isAccount)
                {
                    double accountStartingValue = random.NextDouble() * (max - min) + min;
                    return Math.Round(accountStartingValue, 2);
                }
                else
                {
                    double transactionAmount = random.NextDouble() * random.Next((int)min, (int)max) + random.NextDouble();
                    return Math.Round(transactionAmount, 2);
                }
            }
    
            static string GenerateRandomAccountHolder()
            {
                string[] accountHolderNames = { "John Smith", "Maria Garcia", "Mohammed Khan", "Sophie Dubois", "Liam Johnson", "Emma Martinez", "Noah Lee", "Olivia Kim", "William Chen", "Ava Wang", "James Brown", "Isabella Nguyen", "Benjamin Wilson", "Mia Li", "Lucas Anderson", "Charlotte Liu", "Alexander Taylor", "Amelia Patel", "Daniel Garcia", "Sophia Kim" };
                var accountHolderName = accountHolderNames[random.Next(0, accountHolderNames.Length)];
                return accountHolderName;
            }
    
            static string GenerateRandomAccountType()
            {
                string[] accountTypes = { "Savings", "Checking", "Money Market", "Certificate of Deposit", "Retirement" };
                return accountTypes[random.Next(0, accountTypes.Length)];
            }
    
            static DateTime GenerateRandomDateOpened()
            {
                DateTime startDate = new(DateTime.Today.Year - MaxYearsBack, 1, 1);
                int daysRange = (DateTime.Today - startDate).Days;
                DateTime randomDate = startDate.AddDays(random.Next(daysRange));
    
                if (randomDate.Year == DateTime.Today.Year && randomDate >= DateTime.Today)
                {
                    randomDate = randomDate.AddDays(-1);
                }
    
                return randomDate;
            }
    
            static string GenerateSecurePassword()
            {
                const int passwordLength = 12;
                const string validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()";
                StringBuilder password = new StringBuilder();
                using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
                {
                    byte[] uintBuffer = new byte[sizeof(uint)];
    
                    while (passwordLength > password.Length)
                    {
                        rng.GetBytes(uintBuffer);
                        uint num = BitConverter.ToUInt32(uintBuffer, 0);
                        password.Append(validChars[(int)(num % (uint)validChars.Length)]);
                    }
                }
    
                return password.ToString();
            }
        }
    }
    ```

1. Notice that the updates to Program.cs focused on secure random number generation.

    The other suggestions apply to the BankAccount class, and the implementation is beyond the scope of this training.

1. Construct an additional prompt for Program.cs that seeks to secure exception handling.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain How can I implement secure exception handling in the Program.cs file?` in the Chat view, GitHub Copilot Chat suggests updates that are similar to the following response:

    *To implement secure exception handling in the Program.cs file, you should follow these best practices:*

    *1. Catch Specific Exceptions:*

    *- Catch specific exceptions rather than using a general catch (Exception ex) block. This helps in understanding and handling different types of errors appropriately.*

    *2. Log Exceptions Securely:*

    *- Log exceptions securely without exposing sensitive information. Use a logging framework to manage logs.*

    *3. Provide User-Friendly Messages:*

    *- Provide user-friendly error messages without revealing internal details.*

    *4. Use Finally Blocks for Cleanup:*

    *- Use finally blocks to ensure that any necessary cleanup is performed, regardless of whether an exception was thrown.*

    *5. Avoid Catching Non-Critical Exceptions:*

    *- Avoid catching exceptions that should be allowed to propagate, such as OutOfMemoryException or StackOverflowException.*

    *Here is an updated version of Program.cs with secure exception handling:*

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security.Cryptography;
    using System.Text;
    using System.Threading.Tasks;
    
    namespace BankAccountApp
    {
        class Program
        {
            private static readonly Random random = new Random();
            private const int MaxYearsBack = 10;
            private const int NumberOfAccounts = 20;
            private const int NumberOfTransactions = 100;
            private const double minTransactionAmount = -500.0;
            private const double maxTransactionAmount = 500.0;
            private const double minAccountStart = 200.0;
            private const double maxAccountStart = 1000.0;
    
            static async Task Main()
            {
                List<BankAccount> accounts = CreateBankAccounts(NumberOfAccounts);
                await SimulateTransactionsAsync(accounts, NumberOfTransactions, minTransactionAmount, maxTransactionAmount);
                await SimulateTransfersAsync(accounts, NumberOfTransactions, minTransactionAmount, maxTransactionAmount);
            }
    
            static List<BankAccount> CreateBankAccounts(int numberOfAccounts)
            {
                List<BankAccount> accounts = new();
                int createdAccounts = 0;
                while (createdAccounts < numberOfAccounts)
                {
                    try
                    {
                        double initialBalance = GenerateRandomDollarAmount(true, minAccountStart, maxAccountStart);
                        string accountHolderName = GenerateRandomAccountHolder();
                        string accountType = GenerateRandomAccountType();
                        DateTime dateOpened = GenerateRandomDateOpened();
                        string accountNumber = "102000" + random.Next(1000, 9999).ToString();
                        string username = "user" + createdAccounts;
                        string password = GenerateSecurePassword();
                        BankAccount account = new(accountNumber, initialBalance, accountHolderName, accountType, dateOpened, username, password);
                        accounts.Add(account);
                        createdAccounts++;
                    }
                    catch (ArgumentException ex)
                    {
                        Console.WriteLine($"Account creation failed due to invalid argument: {ex.Message}");
                        // Log the exception securely
                        LogException(ex);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Account creation failed: {ex.Message}");
                        // Log the exception securely
                        LogException(ex);
                    }
                    finally
                    {
                        // Any cleanup code would go here.
                    }
                }
                return accounts;
            }
    
            static async Task SimulateTransactionsAsync(List<BankAccount> accounts, int numberOfTransactions, double minTransactionAmount, double maxTransactionAmount)
            {
                var tasks = accounts.Select(async account =>
                {
                    for (int i = 0; i < numberOfTransactions; i++)
                    {
                        double transactionAmount = GenerateRandomDollarAmount(false, minTransactionAmount, maxTransactionAmount);
                        try
                        {
                            account.Authenticate(account.Username, account.Password); // Authenticate before transaction
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
                        catch (InvalidCreditAmountException ex)
                        {
                            Console.WriteLine($"Invalid credit amount: {ex.Message}");
                            LogException(ex);
                        }
                        catch (InvalidDebitAmountException ex)
                        {
                            Console.WriteLine($"Invalid debit amount: {ex.Message}");
                            LogException(ex);
                        }
                        catch (InsufficientFundsException ex)
                        {
                            Console.WriteLine($"Insufficient funds: {ex.Message}");
                            LogException(ex);
                        }
                        catch (AuthenticationException ex)
                        {
                            Console.WriteLine($"Authentication failed: {ex.Message}");
                            LogException(ex);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Transaction failed: {ex.Message}");
                            LogException(ex);
                        }
                    }
    
                    Console.WriteLine($"Account: {account.AccountNumber}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
                });
    
                await Task.WhenAll(tasks);
            }
    
            static async Task SimulateTransfersAsync(List<BankAccount> accounts, int numberOfTransactions, double minTransactionAmount, double maxTransactionAmount)
            {
                var tasks = accounts.Select(async account =>
                {
                    for (int i = 0; i < numberOfTransactions; i++)
                    {
                        double transactionAmount = GenerateRandomDollarAmount(false, minTransactionAmount, maxTransactionAmount);
                        try
                        {
                            account.Authenticate(account.Username, account.Password); // Authenticate before transfer
                            BankAccount toAccount = accounts[random.Next(accounts.Count)];
                            toAccount.Authenticate(toAccount.Username, toAccount.Password); // Authenticate target account
                            account.Transfer(toAccount, transactionAmount);
                            Console.WriteLine($"Transfer: {transactionAmount}, From: {account.AccountNumber}, To: {toAccount.AccountNumber}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
                        }
                        catch (InvalidTransferAmountException ex)
                        {
                            Console.WriteLine($"Invalid transfer amount: {ex.Message}");
                            LogException(ex);
                        }
                        catch (InsufficientFundsException ex)
                        {
                            Console.WriteLine($"Insufficient funds: {ex.Message}");
                            LogException(ex);
                        }
                        catch (AuthenticationException ex)
                        {
                            Console.WriteLine($"Authentication failed: {ex.Message}");
                            LogException(ex);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Transfer failed: {ex.Message}");
                            LogException(ex);
                        }
                    }
    
                    Console.WriteLine($"Account: {account.AccountNumber}, Balance: {account.Balance.ToString("C")}, Account Holder: {account.AccountHolderName}, Account Type: {account.AccountType}");
                });
    
                await Task.WhenAll(tasks);
            }
    
            static double GenerateRandomDollarAmount(bool isAccount, double min, double max)
            {
                if (isAccount)
                {
                    double accountStartingValue = random.NextDouble() * (max - min) + min;
                    return Math.Round(accountStartingValue, 2);
                }
                else
                {
                    double transactionAmount = random.NextDouble() * random.Next((int)min, (int)max) + random.NextDouble();
                    return Math.Round(transactionAmount, 2);
                }
            }
    
            static string GenerateRandomAccountHolder()
            {
                string[] accountHolderNames = { "John Smith", "Maria Garcia", "Mohammed Khan", "Sophie Dubois", "Liam Johnson", "Emma Martinez", "Noah Lee", "Olivia Kim", "William Chen", "Ava Wang", "James Brown", "Isabella Nguyen", "Benjamin Wilson", "Mia Li", "Lucas Anderson", "Charlotte Liu", "Alexander Taylor", "Amelia Patel", "Daniel Garcia", "Sophia Kim" };
                var accountHolderName = accountHolderNames[random.Next(0, accountHolderNames.Length)];
                return accountHolderName;
            }
    
            static string GenerateRandomAccountType()
            {
                string[] accountTypes = { "Savings", "Checking", "Money Market", "Certificate of Deposit", "Retirement" };
                return accountTypes[random.Next(0, accountTypes.Length)];
            }
    
            static DateTime GenerateRandomDateOpened()
            {
                DateTime startDate = new(DateTime.Today.Year - MaxYearsBack, 1, 1);
                int daysRange = (DateTime.Today - startDate).Days;
                DateTime randomDate = startDate.AddDays(random.Next(daysRange));
    
                if (randomDate.Year == DateTime.Today.Year && randomDate >= DateTime.Today)
                {
                    randomDate = randomDate.AddDays(-1);
                }
    
                return randomDate;
            }
    
            static string GenerateSecurePassword()
            {
                const int passwordLength = 12;
                const string validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()";
                StringBuilder password = new StringBuilder();
                using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
                {
                    byte[] uintBuffer = new byte[sizeof(uint)];
    
                    while (passwordLength > password.Length)
                    {
                        rng.GetBytes(uintBuffer);
                        uint num = BitConverter.ToUInt32(uintBuffer, 0);
                        password.Append(validChars[(int)(num % (uint)validChars.Length)]);
                    }
                }
    
                return password.ToString();
            }
    
            static void LogException(Exception ex)
            {
                // Implement a secure logging mechanism here
                // For example, log to a file, database, or external logging service
                Console.WriteLine($"Logged exception: {ex.Message}");
            }
        }
    }
    ```

1. Implement the suggested updates that help to improve code security for your `Program.cs` file.

1. To ensure that no errors were introduced by the changes, build and run your solution.

## Summary

In this exercise, you used GitHub Copilot Chat to generate suggestions for improving code security in a sample application. You developed prompts that directed GitHub Copilot to provide suggestions for improving authentication, data protection, logging, and other security-related topics. You implemented the suggested updates to improve the security of the BankAccount class and the Program class in the **APL2007M5BankAccount-Security** project.
