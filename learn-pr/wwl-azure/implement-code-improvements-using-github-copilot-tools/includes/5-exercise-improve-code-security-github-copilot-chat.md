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

Many other security flaws can found in code. It’s important for developers to use tools and practices to identify and fix these issues proactively.

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

    Prompt: `@workspace /explain #file:BankAccount.cs How can I implement authentication in the selected code?` (BankAccount.cs)

    Prompt: `@workspace /explain #file:BankAccount.cs How can I protect sensitive data in the selected code?` (BankAccount.cs)

    Prompt: `@workspace /explain #file:BankAccount.cs How can I implement logging of suspicious account activities of the selected code?` (BankAccount.cs)

    Prompt: `@workspace /explain #file:BankAccount.cs How can I improve the security of exception handling in the selected code?` (BankAccount.cs)

    Prompt: `@workspace /explain #file:BankAccount.cs How can I improve the security of the selected code?` (BankAccount.cs)

    Prompt: `@workspace /explain #file:Program.cs How can I improve the security of the selected code?` (Program.cs)

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

1. Open the Chat view, and then enter the first prompt that you prepared for the BankAccount class.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain #file:BankAccount.cs How can I implement authentication in the selected code?` in the Chat view, GitHub Copilot Chat suggests updates that are similar to the following response:

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

    *This is a very basic form of authentication and would not be secure enough for a real banking application. In a real application, you would want to hash and salt the password before storing it, and you would need to use secure methods to transmit the password from the user to the application. You might also want to consider using two-factor authentication or other more secure methods.*

1. Implement the suggested updates that help to improve code security for your `BankAccount` class.

1. To ensure that no errors were introduced by the changes, build and run your solution before continuing.

1. Select all of the code in the BankAccount.cs file, and then enter your second prompt in the Chat view.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain #file:BankAccount.cs How can I protect sensitive data in the selected code?` in the Chat view, GitHub Copilot Chat suggests updates that are similar to the following response:

    *In the provided code, sensitive data such as AccountNumber and AccountHolderName are publicly accessible properties of the BankAccount class. This could potentially expose sensitive information.*

    *To protect this data, you could:*

    *1. Encapsulation: Make these properties private and provide public methods to access them if necessary. This way, you can control how and when this data is accessed.*

    ```csharp
    private string AccountNumber { get; }
    private string AccountHolderName { get; }
    
    public string GetAccountNumber() 
    {
        // Add any necessary logic here before returning the account number
        return AccountNumber;
    }
    
    public string GetAccountHolderName() 
    {
        // Add any necessary logic here before returning the account holder name
        return AccountHolderName;
    }
    ```

    *2. Data Masking: If you need to display these properties (for example, in a user interface), consider masking part of the data. For instance, you could display only the last four digits of the account number.*

    ```csharp
    public string GetMaskedAccountNumber() 
    {
        return "**** **** " + AccountNumber.Substring(AccountNumber.Length - 4);
    }
    ```

    *3. Encryption: If the data needs to be stored or transmitted, consider encrypting it. This would require a secure encryption and decryption mechanism.*

    *Remember, the best way to protect sensitive data depends on your specific use case and requirements. Always follow best practices for data protection and comply with any relevant data protection laws and regulations.*

1. Implement the suggested updates that help to improve code security for your `BankAccount` class.

1. To ensure that no errors were introduced by the changes, build and run your solution before continuing.

### Improve code security of the Program class using GitHub Copilot Chat

1. Open the Program.cs file in Visual Studio Code, and then select all of the code in the file.

1. Open the Chat view, and then enter the first prompt that you prepared for the Program class.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain #file:Program.cs How can I improve the security of the selected code?` in the Chat view, GitHub Copilot Chat suggests updates that are similar to the following response:

    *The selected code is a simulation of bank transactions, so it doesn't directly deal with sensitive data or security concerns. However, if this were a real banking application, there would be several areas to consider for improving security:*

    *1. Sensitive Data Exposure: In a real-world application, sensitive data like account numbers, account holder names, and transaction amounts should be encrypted when stored and transmitted. In this code, these values are simply printed to the console, which would not be secure in a production environment.*

    *2. Error Handling: The code catches exceptions and writes them to the console. In a real-world application, you should avoid exposing any detailed error information that could provide hints to an attacker about the internal workings of your application. Instead, log the details to a secure, private log and show a generic error message to the user.*

    *3. Random Number Generation: The Random class in C# is not suitable for generating secure random numbers, as it's predictable. If you need to generate secure random numbers (for example, for generating account numbers or transaction IDs), consider using a more secure method, like the RNGCryptoServiceProvider class.*

    *4. Input Validation: While not directly applicable to this code, it's worth mentioning that any user-provided inputs should be validated and sanitized to prevent attacks such as SQL Injection or Cross-Site Scripting (XSS).*

    *5. Secure Coding Practices: Follow secure coding practices like principle of least privilege, defense in depth, etc. For example, limit the permissions of the application to only what it needs to function.*

   *Remember, security is a broad and complex field, and these are just a few areas to consider. Depending on the specific requirements and context of your application, there may be other security considerations as well.*

1. Notice that the suggestions provided by GitHub Copilot Chat are general and do not directly apply to the code in the Program.cs file.

    GitHub Copilot recognized that the application is a simulation and that it uses random numbers to generate account numbers and transaction IDs. The suggestions provided are relevant to a real-world banking application but may not be directly applicable to the simulation code.

1. Assume that you're working on a real-world application and consider how you could modify your prompt to generate more specific suggestions.

1. Construct an updated prompt and enter it in the Chat view.

1. Review the suggestions provided by GitHub Copilot Chat.

    For example, if you enter `@workspace /explain #file:Program.cs How can I implement secure exception handling in the selected code?` in the Chat view, GitHub Copilot Chat suggests updates that are similar to the following response:

    *The selected code already includes some basic exception handling, but there are a few ways you can improve it to make it more secure:*

    *1. Avoid revealing sensitive information: When logging or displaying exceptions, be careful not to reveal sensitive information. For example, if an exception occurs because of a failed database operation, the exception message might contain the SQL query, which could reveal table names, column names, or other sensitive information. In the selected code, you're already doing a good job of this by only logging the exception message and not the entire exception.*

    *2. Catch specific exceptions: It's generally a good practice to catch the most specific exceptions possible. This allows you to handle different types of exceptions in different ways. For example, you might want to retry the operation if a TimeoutException occurs, but if an InvalidOperationException occurs, you might want to log the error and abort the operation. In the selected code, you're catching ArgumentException and Exception, but there might be other specific exceptions you could catch as well.*

    *3. Don't swallow exceptions: If you catch an exception and don't rethrow it or otherwise handle it, you're "swallowing" the exception. This can make it difficult to debug issues because it hides the fact that an exception occurred. In the selected code, you're logging the exceptions but not rethrowing them. Depending on the situation, you might want to rethrow the exception after logging it.*

    *Here's an example of how you might modify the `CreateBankAccounts` method to implement these suggestions:*

    ```csharp
    static List<BankAccount> CreateBankAccounts(int numberOfAccounts)
    {
        List<BankAccount> accounts = new();
        int createdAccounts = 0;
        while (createdAccounts < numberOfAccounts)
        {
            try
            {
                // ... same code as before ...
            }
            catch (ArgumentException ex)
            {
                Console.WriteLine($"Account creation failed due to invalid argument: {ex.Message}");
                // Log the exception
                throw; // Rethrow the exception
            }
            catch (TimeoutException ex)
            {
                Console.WriteLine($"Account creation failed due to timeout: {ex.Message}");
                // Log the exception
                // You might want to retry the operation here
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Account creation failed: {ex.Message}");
                // Log the exception
                throw; // Rethrow the exception
            }
            finally
            {
                // Any cleanup code would go here.
            }
        }
        return accounts;
    }
    ```

    *In this modified version of the method, we're catching TimeoutException in addition to ArgumentException and Exception, and we're rethrowing the exceptions after logging them. This makes it clear that an exception occurred, and allows higher-level code to decide how to handle the exception.*

1. Implement the suggested updates that help to improve code reliability for your `Program` class.

1. To ensure that no errors were introduced by the changes, build and run your solution before continuing.

## Summary

In this exercise, you used GitHub Copilot Chat to generate suggestions for improving code security in a sample application. You developed prompts that directed GitHub Copilot to provide suggestions for improving authentication, data protection, logging, and other security-related topics. You implemented the suggested updates to improve the security of the BankAccount class and the Program class in the **APL2007M5BankAccount-Security** project.
