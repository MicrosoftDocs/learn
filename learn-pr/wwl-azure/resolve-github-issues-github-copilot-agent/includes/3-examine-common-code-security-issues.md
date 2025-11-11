Understanding common security vulnerabilities is essential to identifying and resolving code security issues effectively. This unit covers prevalent security issues in code, their impact, and why addressing them promptly is critical for application security.

## Why focus on security issues?

Security vulnerabilities represent one of the most critical categories of software defects. A single vulnerability can result in:

- **Data breaches**: Exposure of sensitive customer or business data
- **Financial losses**: Direct costs from breaches, regulatory fines, and remediation expenses
- **Reputation damage**: Loss of customer trust and business credibility
- **Operational disruption**: System compromises can halt business operations

Functional bugs may be embarrassing to a developer, but security bugs can have severe consequences for an organization and users. Every developer must be security-conscious, regardless of their role or specialization.

## Open Web Application Security Project (OWASP)

The Open Web Application Security Project (OWASP) is a nonprofit organization focused on improving software security. OWASP maintains the widely recognized "OWASP Top 10" - a regularly updated list of the most critical web application security risks based on data from security organizations worldwide.

The OWASP Top 10 serves as a security baseline for developers and organizations, helping prioritize which vulnerabilities to address first. The rankings shift over time as attack patterns evolve. For example:

- **2017 OWASP Top 10**: Injection flaws held the #1 spot
- **2021 OWASP Top 10**: Injection moved to #3 as new threats like broken access control emerged

The OWASP Top 10 reflects real-world attack data, not theoretical concerns. Code vulnerabilities like SQL injection and weak encryption consistently rank among the industry's most critical security concerns.

## Injection attacks

Injection attacks occur when untrusted data is sent to an interpreter as part of a command or query. The attacker's hostile data tricks the interpreter into executing unintended commands or accessing unauthorized data.

### SQL injection

SQL injection is one of the most dangerous and common injection attacks. It occurs when an application incorporates untrusted input directly into SQL queries without proper validation or parameterization.

Consider the following code example:

```csharp
// DANGEROUS: Concatenating user input directly into SQL
string query = "SELECT * FROM Users WHERE Username = '" + userInput + "' AND Password = '" + passwordInput + "'";
SqlCommand command = new SqlCommand(query, connection);
SqlDataReader reader = command.ExecuteReader();
```

An attacker could enter `' OR '1'='1` as the username input, transforming the query into:

```sql
SELECT * FROM Users WHERE Username = '' OR '1'='1' AND Password = ''
```

Since `'1'='1'` is always true, this query returns all users, bypassing authentication entirely.

#### Real-world impact

SQL injection attacks have caused numerous high-profile breaches. Attackers can:

- Bypass authentication mechanisms
- Extract entire databases containing sensitive information
- Modify or delete data
- Execute administrative operations on the database

#### Secure implementation

The secure way to handle SQL queries is to use parameterized queries (also called prepared statements).

For example:

```csharp
// SECURE: Using parameterized queries
string query = "SELECT * FROM Users WHERE Username = @username AND Password = @password";
SqlCommand command = new SqlCommand(query, connection);
command.Parameters.AddWithValue("@username", userInput);
command.Parameters.AddWithValue("@password", passwordInput);
SqlDataReader reader = command.ExecuteReader();
```

Parameterized queries separate code from data. The database treats parameter values as data only, never as executable SQL code, preventing injection attacks.

### Other injection types

SQL injection is just one form of injection attack, and developers must be aware of other injection vulnerabilities that can compromise application security.

While SQL injection is most common, other injection vulnerabilities exist:

- **Command injection**: Inserting system commands into application inputs that execute shell commands.
- **LDAP injection**: Manipulating LDAP queries to access unauthorized directory information.
- **NoSQL injection**: Exploiting NoSQL databases through malicious queries.
- **XML injection**: Inserting malicious XML content to access or modify data.

**The universal pattern**: Any time you insert untrusted input into a command or query that gets interpreted, you risk injection. The solution pattern is always similar: sanitize, validate, or parameterize to separate code from data.

## Weak encryption of sensitive data

Storing or transmitting sensitive data without proper encryption exposes it to unauthorized access. This category includes both inadequate encryption methods and complete lack of encryption.

### Insecure password storage

Passwords require special protection because they serve as the primary authentication mechanism for most applications.

Storing passwords improperly is a critical vulnerability.

#### Plaintext storage (never acceptable)

```csharp
// DANGEROUS: Storing passwords in plaintext
string password = userInput;
database.SavePassword(username, password);
```

If the database is compromised, all user passwords are immediately exposed.

#### Weak hashing (insufficient)

```csharp
// INSUFFICIENT: Using MD5 or SHA1 without salt
using (MD5 md5 = MD5.Create())
{
    byte[] hash = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
    string hashedPassword = Convert.ToBase64String(hash);
}
```

MD5 and SHA1 are cryptographically broken. Modern GPUs can test billions of password combinations per second against these fast hashes. Additionally, without salt, attackers can use precomputed rainbow tables to crack passwords instantly.

#### Secure hashing (recommended)

```csharp
// SECURE: Using bcrypt with automatic salt generation
string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);

// Later, for verification:
bool isValid = BCrypt.Net.BCrypt.Verify(userInput, storedHash);
```

Secure password hashing requires:

- **Salt**: Random data added to passwords before hashing, preventing rainbow table attacks
- **Slow algorithm**: Functions like bcrypt, scrypt, or Argon2 are computationally expensive, limiting brute-force attempts to hundreds or thousands per second instead of billions

### Encryption of data at rest

Beyond password security, any sensitive data stored on disk or in databases needs protection through proper encryption.

Sensitive data stored without encryption is vulnerable if storage media is compromised.

#### Vulnerable scenario

```csharp
// VULNERABLE: Writing sensitive data in plaintext
File.WriteAllText("customer_data.txt", sensitiveInformation);
```

If a laptop containing this file is stolen, or if an attacker gains file system access, the data is immediately readable.

#### Secure approach

```csharp
// SECURE: Encrypting data before storage
using (Aes aes = Aes.Create())
{
    aes.Key = GetEncryptionKey(); // Securely managed key
    aes.GenerateIV();
    
    using (FileStream fileStream = new FileStream("customer_data.enc", FileMode.Create))
    {
        fileStream.Write(aes.IV, 0, aes.IV.Length);
        using (CryptoStream cryptoStream = new CryptoStream(fileStream, aes.CreateEncryptor(), CryptoStreamMode.Write))
        using (StreamWriter writer = new StreamWriter(cryptoStream))
        {
            writer.Write(sensitiveInformation);
        }
    }
}
```

Proper encryption provides a defense layer even if storage is compromised, assuming encryption keys are properly managed separately.

## Logging and error handling issues

Improper logging and error handling can inadvertently expose sensitive information or system details that aid attackers.

### Logging sensitive data

While logging is essential for debugging and monitoring, it can become a security vulnerability when sensitive information is captured.

Applications must never log sensitive information in plaintext.

#### Dangerous logging practices

```csharp
// DANGEROUS: Logging sensitive information
logger.LogInformation($"User {username} logged in with password: {password}");
logger.LogInformation($"Credit card processed: {cardNumber}");
logger.LogInformation($"API Key: {apiKey}");
```

This exposes sensitive data in logs, which may be accessible to unauthorized users or leaked through log management systems.

#### Secure logging practices

```csharp
// SECURE: Logging without sensitive data
logger.LogInformation($"User {username} logged in successfully");
logger.LogInformation($"Payment processed for order {orderId}");
logger.LogInformation($"API call authenticated successfully");
```

#### Best practices

- Never log passwords, authentication tokens, or API keys
- Mask or redact sensitive information like credit card numbers or Social Security numbers
- Log events and outcomes, not sensitive data values

### Excessive error information disclosure

Error messages serve an important debugging purpose, but they must be carefully crafted to avoid revealing system internals to potential attackers.

Detailed error messages can reveal system architecture, file paths, database schemas, and other information useful to attackers.

#### Problematic error handling

```csharp
// PROBLEMATIC: Exposing detailed error information to users
catch (Exception ex)
{
    return $"Error: {ex.Message}\nStack Trace: {ex.StackTrace}\nConnection String: {connectionString}";
}
```

This reveals internal system details that attackers can use to craft more sophisticated attacks.

#### Secure error handling

```csharp
// SECURE: User-friendly messages with detailed internal logging
catch (Exception ex)
{
    logger.LogError(ex, "Failed to process user request");
    return "An error occurred while processing your request. Please try again or contact support.";
}
```

Users receive friendly, minimal error messages while developers get detailed error information through secure logs.

## Path traversal attacks

Path traversal (also called directory traversal) occurs when an application uses user-supplied input to construct file paths without proper validation. Attackers can use special character sequences to access files outside the intended directory.

Consider the following vulnerable code:

```csharp
// VULNERABLE: Using user input directly in file paths
string filename = Request.Query["file"];
string filePath = Path.Combine(@"C:\uploads\", filename);
string content = File.ReadAllText(filePath);
```

An attacker could provide input like `../../../Windows/System32/config/SAM` to access sensitive system files, or `../../web.config` to read application configuration containing secrets.

Vulnerable code enables the following attack mechanism:

- `..` sequences navigate up directory levels.
- Attackers can escape the intended directory sandbox.
- Access sensitive files, configuration files, or system files.
- Potentially overwrite critical application files.

Consider the following secure implementation:

```csharp
// SECURE: Validating and constraining file paths
string filename = Request.Query["file"];

// Remove path traversal sequences
filename = Path.GetFileName(filename);

// Construct full path
string uploadsDirectory = Path.GetFullPath(@"C:\uploads\");
string filePath = Path.GetFullPath(Path.Combine(uploadsDirectory, filename));

// Verify the resulting path is still within the uploads directory
if (!filePath.StartsWith(uploadsDirectory))
{
    throw new SecurityException("Invalid file path");
}

string content = File.ReadAllText(filePath);
```

Secure implementations demonstrate the following defense strategies:

- Use `Path.GetFileName()` to remove directory information.
- Whitelist allowed files or patterns instead of blacklisting dangerous characters.
- Validate that resolved paths remain within intended directories.
- Implement strict file access permissions at the operating system level.

## Additional security considerations

In addition to the vulnerabilities covered in the previous sections, several other security issues require developer awareness.

### Cross-site scripting (XSS)

Cross-site scripting allows attackers to inject malicious code into web applications, potentially compromising user data and sessions.

While not applicable to console applications, web developers must validate and encode all user input before displaying it in browsers.

### Hard-coded secrets

Credentials and sensitive configuration values embedded directly in source code represent a critical security risk that can expose entire systems.

Embedding API keys, passwords, or tokens directly in source code exposes them to anyone with repository access. Secrets should be:

- Stored in secure configuration systems or vaults.
- Never committed to version control.
- Rotated regularly.
- Managed with proper access controls.

### Resource exhaustion and denial of service

Applications that don't properly manage resources can be exploited by attackers to cause service disruptions or system crashes.

Poor resource management can enable denial-of-service attacks. Examples include:

- Reading entire large files into memory (causing out-of-memory errors).
- Not limiting request sizes or frequencies.
- Inefficient algorithms that consume excessive CPU.
- Failing to dispose of resources properly.

## How to identify security issues in code

Identifying security vulnerabilities in code requires a systematic approach.

### Analyze user input handling

User input represents the primary attack vector for most security vulnerabilities, making it critical to examine how your code processes external data.

Every point where your code accepts user input is a potential entry point for attacks:

- **Look for**: Input used in SQL queries, file paths, system commands, or critical logic.
- **Ask**: "Am I trusting this input too much?"
- **Consider**: Injection vulnerabilities, path traversal, command injection.

### Review cryptographic operations

Security implementations involving encryption, hashing, and authentication require extra scrutiny because weak cryptography can compromise entire systems.

Cryptographic code requires special scrutiny:

- **Look for**: `MD5.Create()`, `SHA1.Create()`, plaintext password storage..
- **Ask**: "Is this cryptographic method still considered secure?"
- **Consider**: Using bcrypt, scrypt, or Argon2 for passwords; SHA-256 or better for integrity checks.

### Examine logging statements

Logs can inadvertently become security vulnerabilities when they capture sensitive information that should remain protected.

Scan your codebase for sensitive data in logs:

- **Look for**: Log statements containing variables named password, secret, token, apiKey, cardNumber.
- **Ask**: "What information am I exposing in logs?"
- **Consider**: What happens if these logs are compromised or accidentally exposed?

### Inspect file operations

File handling code presents unique security challenges because it can expose system resources beyond your application's intended scope.

File handling code needs careful validation:

- **Look for**: `Path.Combine` with user input, file operations based on user-supplied paths.
- **Ask**: "Can a user escape the intended directory?"
- **Consider**: Path traversal attacks and directory escape techniques.

### Leverage automated tools

While manual code review is essential, automated tools can efficiently scan large codebases and identify common vulnerability patterns that might be missed during manual inspection.

Combine manual code review with automated analysis:

- **Static analysis**: Tools like GitHub CodeQL scan code for known vulnerability patterns.
- **GitHub Copilot**: Use Ask mode to analyze code sections: "Are there security issues in this code?"
- **Security linters**: Language-specific tools can flag obvious security mistakes.

GitHub Copilot can identify many common security issues when you ask it to analyze code. It draws on patterns from millions of codebases to recognize vulnerabilities.

## Shift-left security approach

The principle of "shifting left" means addressing security earlier in the development lifecycle:

- **Design phase**: Consider security implications of architectural decisions.
- **Development phase**: Write secure code from the start, catch issues during code review.
- **Testing phase**: Include security testing alongside functional testing.
- **Deployment phase**: Scan for vulnerabilities before release.

Catching security issues during development is far less expensive than discovering them in production. The cost and impact of fixing vulnerabilities increases exponentially with each stage they progress through.

## Summary

Common security vulnerabilities like injection attacks, weak encryption, improper logging, and path traversal represent serious threats to application security. Understanding these vulnerabilities helps you recognize them in code and prioritize their remediation. By combining knowledge of common vulnerability patterns with tools like GitHub Copilot, you can identify and address security issues more effectively.
