After analyzing secret scanning alerts using Ask mode, you're ready to implement remediation. GitHub Copilot's Agent mode enables you to execute complex secret removal and secure storage implementation systematically while maintaining application functionality.

> [!NOTE]
> Always use GitHub Copilot's Ask mode to analyze secret scanning alerts and formulate a remediation plan before using Agent mode to implement changes. This approach ensures that remediation is comprehensive and preserves application functionality.

## What is Agent mode?

GitHub Copilot's Agent mode works autonomously to execute complex remediation tasks across your codebase. Unlike Ask mode, which provides guidance and suggestions in the Chat view, Agent mode implements changes directly in your code files.

Agent mode capabilities include:

- Removing hard-coded secrets from code files.
- Implementing environment variable or configuration-based secret access.
- Updating multiple files consistently with secure patterns.
- Adding necessary configuration files and examples.
- Refactoring code to use dependency injection or secure configuration.
- Running tests to verify changes maintain functionality.

Agent mode is ideal for implementing multi-step secret remediation that requires coordinated changes across multiple files, configuration updates, and testing verification. Agent mode automatically determines the required context and executes the necessary steps to achieve your remediation goals.

## Effective prompting strategies

Agent mode implements the security fixes identified during your Ask mode analysis. Effective prompts should be specific, actionable, and include safety considerations.

### Preparation and safety

Establish safety measures before making changes to credential management.

The following prompts help ensure a safe remediation process:

- Create unit tests that verify the current behavior of the selected payment processing functions before making changes.
- Analyze the selected code and document all dependencies on the hard-coded API key.
- Create a backup branch before implementing secret remediation changes.

### Basic secret removal

GitHub Copilot Agent can be used to address straightforward secret exposures with secure alternatives.

The following prompts assign simple secret removal tasks to GitHub Copilot Agent:

- "Remove the hard-coded Stripe API key from the selected code and replace it with environment variable access."
- "Refactor the selected database connection string to read from IConfiguration instead of being hard-coded."
- "Replace the hard-coded Azure Storage key in the selected code with Azure Key Vault access."
- "Remove the hard-coded GitHub personal access token and implement secure configuration-based access."

Consider the following scenario:

You have the following code sample that contains a hard-coded Stripe API key:

```csharp
// Before (hard-coded secret)
public class PaymentProcessor
{
    private const string StripeKey = "sk_live_51Abc123...";
    
    public async Task<bool> ProcessPayment(decimal amount)
    {
        StripeConfiguration.ApiKey = StripeKey;
        // Process payment...
    }
}
```

You assign the "Remove the hard-coded Stripe API key from the selected code and replace it with environment variable access." task to GitHub Copilot's Agent mode.

Agent mode analyzes the code, removes the hard-coded credential, and implements environment variable access with appropriate error handling:

```csharp
// After (secure environment variable access)
public class PaymentProcessor
{
    private readonly string _stripeKey;
    
    public PaymentProcessor()
    {
        _stripeKey = Environment.GetEnvironmentVariable("STRIPE_API_KEY")
            ?? throw new InvalidOperationException(
                "STRIPE_API_KEY environment variable is not configured. " +
                "Please set this environment variable with your Stripe secret key.");
    }
    
    public async Task<bool> ProcessPayment(decimal amount)
    {
        StripeConfiguration.ApiKey = _stripeKey;
        // Process payment...
    }
}
```

### Comprehensive remediation patterns

GitHub Copilot Agent can be used to implement comprehensive secret remediation patterns involving multiple components or architectural changes.

The following prompts assign complex remediation tasks to GitHub Copilot Agent:

- "Remove all hard-coded credentials from the selected PaymentProcessor class and refactor it to use dependency injection with IConfiguration."

- "Implement secure secret management for the selected service class using environment variables for development and Azure Key Vault for production."

- "Refactor the selected authentication module to eliminate hard-coded credentials and use ASP.NET Core configuration system."

- "Remove hard-coded secrets from the selected code and create corresponding configuration examples in appsettings.json and .env.example files."

Consider the following scenario:

You have the following code sample that contains a hard-coded Stripe API key:

```csharp
// Before (hard-coded secret)
public class PaymentProcessor
{
    private const string StripeKey = "sk_live_51Abc123...";
    
    public async Task<bool> ProcessPayment(decimal amount)
    {
        StripeConfiguration.ApiKey = StripeKey;
        // Process payment...
    }
}
```

You assign the "Remove all hard-coded credentials from the selected PaymentProcessor class and refactor it to use dependency injection with IConfiguration." task to GitHub Copilot's Agent mode.

Agent mode refactors the code to use ASP.NET Core's configuration system:

```csharp
// Improved configuration-based approach
public class PaymentProcessor
{
    private readonly string _stripeKey;
    
    public PaymentProcessor(IConfiguration configuration)
    {
        _stripeKey = configuration["Stripe:ApiKey"]
            ?? throw new InvalidOperationException(
                "Stripe:ApiKey is not configured. " +
                "Set this in appsettings.json, user secrets, or environment variables.");
    }
    
    public async Task<bool> ProcessPayment(decimal amount)
    {
        StripeConfiguration.ApiKey = _stripeKey;
        // Process payment...
    }
}

// In Program.cs or Startup.cs
services.AddScoped<PaymentProcessor>();
```

For multiple secret types, Agent mode systematically remediates all credentials:

```csharp
// Comprehensive configuration-based secret management
public class ApplicationServices
{
    private readonly IConfiguration _configuration;
    
    public ApplicationServices(IConfiguration configuration)
    {
        _configuration = configuration 
            ?? throw new ArgumentNullException(nameof(configuration));
        ValidateConfiguration();
    }
    
    private void ValidateConfiguration()
    {
        var requiredSettings = new[]
        {
            "Stripe:ApiKey",
            "ConnectionStrings:DefaultConnection",
            "Azure:StorageAccountKey"
        };
        
        var missingSettings = requiredSettings
            .Where(setting => string.IsNullOrEmpty(_configuration[setting]))
            .ToList();
        
        if (missingSettings.Any())
        {
            throw new InvalidOperationException(
                $"Required configuration missing: {string.Join(", ", missingSettings)}");
        }
    }
    
    public string GetStripeKey() => _configuration["Stripe:ApiKey"];
    public string GetConnectionString() => _configuration["ConnectionStrings:DefaultConnection"];
    public string GetStorageKey() => _configuration["Azure:StorageAccountKey"];
}
```

### Configuration and documentation

GitHub Copilot Agent can be used to generate configuration templates and documentation to support secure secret management.

The following prompts assign documentation tasks to GitHub Copilot Agent:

- "Create an appsettings.template.json file showing required configuration structure without actual secret values."
- "Add a .env.example file documenting all required environment variables for the application."
- "Update the README.md to include instructions for configuring API keys and database credentials."
- "Add code comments explaining how to configure the application's secrets securely."

The first two tasks could be used to generate documentation files similar to the following examples:

```json
// appsettings.template.json
{
  "Stripe": {
    "ApiKey": "your-stripe-secret-key-here",
    "PublishableKey": "your-stripe-publishable-key-here"
  },
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  }
}
```

```plaintext
# .env.example
STRIPE_API_KEY=sk_live_your_key_here
STRIPE_PUBLISHABLE_KEY=pk_live_your_key_here
DATABASE_CONNECTION_STRING=Server=your_server;Database=your_db;
```

## Other common remediation patterns

Beyond basic configuration access, certain credential types require specialized handling approaches.

### Database connection strings

GitHub Copilot Agent can refactor database connection strings to use named connections from configuration files.

Consider the following example where a hard-coded connection string is replaced with configuration-based access:

```csharp
// Pattern: Use named connection strings from configuration
public class DataContext : DbContext
{
    public DataContext(DbContextOptions<DataContext> options)
        : base(options)
    {
    }
}

// In Program.cs
services.AddDbContext<DataContext>(options =>
    options.UseSqlServer(
        configuration.GetConnectionString("DefaultConnection")
        ?? throw new InvalidOperationException("DefaultConnection not configured")));
```

### OAuth credentials

GitHub Copilot Agent can separate OAuth client IDs and secrets, ensuring that sensitive information is stored securely.

Consider the following example where OAuth credentials are refactored for secure storage:

```csharp
// Pattern: Separate client ID (public) from client secret (private)
public class OAuthConfiguration
{
    public string ClientId { get; set; }  // Can be in appsettings.json
    public string ClientSecret { get; set; }  // Must be in secure storage
    
    public void Validate()
    {
        if (string.IsNullOrEmpty(ClientId))
            throw new InvalidOperationException("OAuth ClientId not configured");
        if (string.IsNullOrEmpty(ClientSecret))
            throw new InvalidOperationException("OAuth ClientSecret not configured");
    }
}

services.Configure<OAuthConfiguration>(configuration.GetSection("OAuth"));
```

### Encryption keys

GitHub Copilot Agent can implement secure loading of encryption keys from configuration or secure storage.

Consider the following example where encryption keys are loaded securely:

```csharp
// Pattern: Load encryption keys from secure storage
public class EncryptionService
{
    private readonly byte[] _encryptionKey;
    
    public EncryptionService(IConfiguration configuration)
    {
        var keyBase64 = configuration["Encryption:Key"]
            ?? throw new InvalidOperationException("Encryption key not configured");
        
        _encryptionKey = Convert.FromBase64String(keyBase64);
        
        if (_encryptionKey.Length != 32)  // 256-bit key
            throw new InvalidOperationException("Encryption key must be 256 bits");
    }
}
```

## Considerations for complex scenarios

Different secret remediation scenarios require specific approaches.

### Secrets in multiple files

Use Agent mode to remediate all occurrences consistently and implement a centralized configuration service that all components use.

### Secrets with multiple components

For credentials with multiple parts (client ID + secret, username + password), ensure all components are moved to secure storage and use configuration sections to group related settings.

### Backward compatibility

If maintaining compatibility during migration, implement fallback logic that checks environment variables if configuration is missing, log warnings when using deprecated methods, and plan a migration timeline to remove fallback code.

### Testing with secrets

Use mock configuration in unit tests, use test credentials (when provided by services) in integration tests, and never commit test credentials that could grant real access.

## Best practices

Follow these practices for effective and safe remediation.

### Remediate incrementally

Remediate one type of secret at a time, test after each remediation, and commit working changes before moving to the next secret. This approach makes issues easier to identify and resolve.

### Use appropriate secret storage

Different environments require different approaches: User Secrets or .env files for local development, GitHub Secrets or Azure Pipeline variables for CI/CD, and Azure Key Vault or AWS Secrets Manager for staging/production.

## Remediation workflow

Use the following step-by-step approach to remediate GitHub secret scanning alerts:

1. **Rotate credentials immediately**: Log into the service provider's dashboard, revoke the exposed credential, and generate a new secret. This is the most critical security step—exposed credentials must be invalidated before any code changes.

2. **Prepare workspace**: Commit or stash all pending changes and create a clean Git branch for remediation.

3. **Analyze dependencies**: Use Ask mode first to understand what the secret accesses, how it's used, and identify all code dependencies (see Preparation and safety prompts).

4. **Remove hard-coded secrets**: Select the code containing the secret and apply Basic secret removal prompts to replace with environment variable or configuration access.

5. **Implement configuration patterns**: Apply Comprehensive remediation prompts to upgrade to proper dependency injection and configuration systems.

6. **Add documentation**: Use Configuration and documentation prompts to create template files (appsettings.template.json, .env.example) and update README with configuration instructions.

7. **Update tests**: Apply Testing and validation prompts to refactor tests for the new configuration-based approach.

8. **Validate changes**: Build the application, run all tests, manually test critical paths, and review changes in Git diff before committing.

9. **Remove from Git history**: Use git-filter-repo to clean secrets from repository history.

   > [!WARNING]
   > Removing secrets from Git history requires rewriting repository history and force-pushing. Coordinate with your team before proceeding.

10. **Commit and document**: Review all changes, commit to your branch, configure the new credential securely in your environment, and finalize documentation with complete configuration requirements.
