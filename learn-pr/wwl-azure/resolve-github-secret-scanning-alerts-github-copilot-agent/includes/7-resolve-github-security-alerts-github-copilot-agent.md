After analyzing secret scanning alerts using Ask mode, you're ready to implement remediation. GitHub Copilot's Agent mode enables you to execute complex secret removal and secure storage implementation systematically while maintaining application functionality.

> [!NOTE]
> Always use GitHub Copilot's Ask mode to analyze secret scanning alerts and formulate a remediation plan before using Agent mode to implement changes. This approach ensures that remediation is comprehensive and preserves application functionality.

## What is Agent mode?

GitHub Copilot's Agent mode works autonomously to execute complex remediation tasks across your codebase. Unlike Ask mode, which provides guidance and suggestions in the chat panel, Agent mode implements changes directly in your code files.

Agent mode capabilities include:

- Removing hard-coded secrets from code files.
- Implementing environment variable or configuration-based secret access.
- Updating multiple files consistently with secure patterns.
- Adding necessary configuration files and examples.
- Refactoring code to use dependency injection or secure configuration.
- Running tests to verify changes maintain functionality.

Agent mode is ideal for implementing multi-step secret remediation that requires coordinated changes across multiple files, configuration updates, and testing verification. Agent mode automatically determines the required context and executes the necessary steps to achieve your remediation goals.

## Remediate secret scanning alerts using Agent mode

You can use Agent mode to implement the security fixes identified during your Ask mode analysis. Agent mode can execute multiple remediation steps automatically while preserving application functionality and improving security posture.

### Strategies for remediating secret scanning alerts

Here are key strategies for using Agent mode to remediate secret scanning alerts:

- **Remove hard-coded secrets**: Instruct Agent mode to replace hard-coded credentials with secure configuration access.

- **Implement environment variable access**: Have Agent mode refactor code to read secrets from environment variables.

- **Use secret management services**: Let Agent mode integrate Azure Key Vault, AWS Secrets Manager, or similar services.

- **Update configuration patterns**: Use Agent mode to implement dependency injection or IConfiguration patterns.

- **Add configuration examples**: Have Agent mode create template files (.env.example, appsettings.template.json) showing required configuration without actual secrets.

- **Maintain functionality**: Instruct Agent mode to preserve all existing business logic, error handling, and application behavior.

- **Update tests**: Use Agent mode to modify tests to work with new configuration-based approach.

### Agent mode prompts for remediating secret scanning alerts

When using Agent mode to remediate secret scanning alerts, your prompts should be specific, actionable, and include safety considerations. Here are examples of natural language text you can include in your prompt when remediating secret scanning alerts:

#### Preparation and safety

These prompts help you establish safety measures before making changes to credential management.

- "Create unit tests that verify the current behavior of the selected payment processing functions before making changes."
- "Analyze the selected code and document all dependencies on the hard-coded API key."
- "Create a backup branch before implementing secret remediation changes."

#### Basic secret removal

Use these prompts to address straightforward secret exposures with secure alternatives.

- "Remove the hard-coded Stripe API key from the selected code and replace it with environment variable access."
- "Refactor the selected database connection string to read from IConfiguration instead of being hard-coded."
- "Replace the hard-coded Azure Storage key in the selected code with Azure Key Vault access."
- "Remove the hard-coded GitHub personal access token and implement secure configuration-based access."

#### Comprehensive remediation patterns

These prompts guide Agent mode through more complex secret remediation involving multiple components or architectural changes.

- "Remove all hard-coded credentials from the selected PaymentProcessor class and refactor it to use dependency injection with IConfiguration."
- "Implement secure secret management for the selected service class using environment variables for development and Azure Key Vault for production."
- "Refactor the selected authentication module to eliminate hard-coded credentials and use ASP.NET Core configuration system."
- "Remove hard-coded secrets from the selected code and create corresponding configuration examples in appsettings.json and .env.example files."

#### Configuration and documentation

Use these prompts to ensure proper configuration support and documentation.

- "Create an appsettings.template.json file showing required configuration structure without actual secret values."
- "Add a .env.example file documenting all required environment variables for the application."
- "Update the README.md to include instructions for configuring API keys and database credentials."
- "Add code comments explaining how to configure the application's secrets securely."

#### Testing and validation

These prompts ensure remediation doesn't break functionality.

- "After implementing secret remediation, run all unit tests and verify functionality is preserved."
- "Create new tests that verify the application fails gracefully when required secrets are not configured."
- "Update existing tests to work with the new configuration-based secret access pattern."
- "Add integration tests that verify the application works correctly with secrets from environment variables."

## Agent mode workflow for remediating secret scanning alerts

Follow this systematic workflow to remediate secret scanning alerts using Agent mode:

### Step 1: Prepare your workspace

Starting with a clean workspace ensures you can track changes accurately and roll back if needed.

Before making changes, ensure you're working in a clean Git branch with all existing work committed. Create a new feature branch specifically for secret remediation. Navigate to the file containing the exposed secret and have your remediation plan ready from your Ask mode analysis.

```bash
# Create a new branch for secret remediation
git checkout -b fix/remove-exposed-secrets

# Verify clean working directory
git status
```

### Step 2: Understand the current implementation

Before Agent mode makes changes, ensure you have comprehensive understanding of the current code.

Review the code that uses the exposed secret and identify:

- All locations where the secret is referenced.
- How the application initializes or configures the service using the secret.
- Dependencies on the secret (services, controllers, background jobs).
- Error handling related to the secret or service.

Use Ask mode to complete this analysis if you haven't already.

### Step 3: Start with basic secret removal

Begin by removing the hard-coded secret and implementing environment variable access.

Example prompt: "Remove the hard-coded Stripe API key from PaymentProcessor.cs and refactor it to read from an environment variable named STRIPE_API_KEY. Ensure the code throws a clear exception if the environment variable is not set."

Agent mode analyzes the code, removes the hard-coded credential, and implements environment variable access with appropriate error handling:

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

### Step 4: Implement proper configuration patterns

Upgrade the basic environment variable approach to use proper configuration systems.

Example prompt: "Refactor PaymentProcessor to use IConfiguration dependency injection instead of direct environment variable access. Add configuration section for Stripe settings."

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
```

Agent mode also updates the dependency injection configuration:

```csharp
// In Program.cs or Startup.cs
services.AddScoped<PaymentProcessor>();
```

### Step 5: Add configuration documentation

Create template files that show developers what configuration is needed without exposing actual secrets.

Example prompt: "Create an appsettings.template.json file showing the required Stripe configuration structure without actual secret values. Also create a .env.example file for local development."

Agent mode creates configuration examples:

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

### Step 6: Handle multiple secret types

If your application has multiple exposed secrets, remediate them systematically.

Example prompt: "Remove all hard-coded secrets from the selected files including the Stripe API key, database connection string, and Azure Storage account key. Implement consistent configuration-based access for all of them."

Agent mode systematically remediates multiple secrets:

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

### Step 7: Remove secrets from Git history

After removing secrets from current code, clean them from Git history to complete remediation.

> [!WARNING]
> Removing secrets from Git history requires rewriting repository history and force-pushing. This affects all collaborators and requires coordination with your team.

Example prompt: "Provide Git commands to remove the hard-coded Stripe key from all commits in the repository history."

Agent mode provides guidance (but typically doesn't execute Git commands directly):

```bash
# Using git-filter-repo (recommended)
# Install git-filter-repo if not already available
pip install git-filter-repo

# Remove specific string from all files in history
git filter-repo --replace-text <(echo "sk_live_51Abc123XYZ==>REDACTED")

# Alternative: Remove entire file from history
git filter-repo --invert-paths --path path/to/file/with/secret.cs

# Force push the rewritten history
git push --force-with-lease origin main

# All team members must re-clone or reset their repositories
git clone <repository-url>
```

### Step 8: Update tests for new configuration

Modify existing tests to work with the new configuration-based approach.

Example prompt: "Update unit tests for PaymentProcessor to work with the new IConfiguration-based constructor. Use mock configuration in tests."

Agent mode refactors tests:

```csharp
// Updated test with mocked configuration
[TestClass]
public class PaymentProcessorTests
{
    private Mock<IConfiguration> _mockConfiguration;
    private PaymentProcessor _paymentProcessor;
    
    [TestInitialize]
    public void Setup()
    {
        _mockConfiguration = new Mock<IConfiguration>();
        _mockConfiguration.Setup(c => c["Stripe:ApiKey"])
            .Returns("sk_test_fake_key_for_testing");
        
        _paymentProcessor = new PaymentProcessor(_mockConfiguration.Object);
    }
    
    [TestMethod]
    public async Task ProcessPayment_ValidAmount_ReturnsSuccess()
    {
        // Arrange
        decimal amount = 99.99m;
        
        // Act
        var result = await _paymentProcessor.ProcessPayment(amount);
        
        // Assert
        Assert.IsTrue(result);
    }
    
    [TestMethod]
    [ExpectedException(typeof(InvalidOperationException))]
    public void Constructor_MissingConfiguration_ThrowsException()
    {
        // Arrange
        var emptyConfig = new Mock<IConfiguration>();
        emptyConfig.Setup(c => c["Stripe:ApiKey"]).Returns((string)null);
        
        // Act
        var processor = new PaymentProcessor(emptyConfig.Object);
        
        // Assert is handled by ExpectedException
    }
}
```

### Step 9: Validate changes

After implementing remediation, verify that functionality is preserved and security is improved.

Example prompt: "Run all unit tests and report any failures. Verify that the application builds successfully."

Agent mode can execute tests and report results:

```bash
# Build the solution
dotnet build

# Run all tests
dotnet test

# Results:
# Test Run Successful.
# Total tests: 47
#      Passed: 47
#      Failed: 0
#    Skipped: 0
```

### Step 10: Update documentation

Document the configuration requirements for other developers.

Example prompt: "Update the README.md file to include a section on configuring secrets for local development and production deployment."

Agent mode adds comprehensive documentation:

```markdown
## Configuration

### Required Secrets

This application requires the following secrets to be configured:

#### Local Development

For local development, use User Secrets:

```bash
# Initialize user secrets
dotnet user-secrets init

# Set required secrets
dotnet user-secrets set "Stripe:ApiKey" "sk_test_your_test_key"
dotnet user-secrets set "ConnectionStrings:DefaultConnection" "your_connection_string"
```

Alternatively, create a `.env` file (do not commit to Git):

```plaintext
STRIPE_API_KEY=sk_test_your_test_key
DATABASE_CONNECTION_STRING=Server=localhost;Database=YourDB;
```

#### Production Deployment

For production, configure secrets in your hosting environment:

**Azure App Service:**
1. Navigate to Configuration > Application Settings
2. Add the following settings:
   - `Stripe:ApiKey` = your production Stripe key
   - `ConnectionStrings:DefaultConnection` = your production database connection

**Azure Key Vault:**
1. Store secrets in Azure Key Vault
2. Configure managed identity for your application
3. Reference Key Vault secrets in configuration

**Docker/Kubernetes:**
Pass secrets as environment variables or mount as volumes:

```yaml
environment:
  - STRIPE_API_KEY=${STRIPE_API_KEY}
  - DATABASE_CONNECTION_STRING=${DATABASE_CONNECTION_STRING}
```
```

## Best practices for Agent mode remediation

Maximize the effectiveness and safety of your Agent mode secret remediation:

### Always analyze before implementing

Never use Agent mode to remediate secrets without first using Ask mode to:

- Understand what the secret is and what it accesses.
- Analyze how the secret is used in the application.
- Identify all dependencies and usage locations.
- Plan the remediation approach.

Agent mode executes your plan; Ask mode helps you create a sound plan.

### Start with a clean Git state

Before beginning remediation:

- Commit or stash all pending changes.
- Create a new feature branch for secret remediation.
- Ensure you can easily roll back if needed.

This allows you to clearly see what Agent mode changed and revert if necessary.

### Remediate incrementally

Don't try to fix all secrets at once. Instead:

1. Remediate one type of secret at a time.
1. Test after each remediation.
1. Commit working changes before moving to the next secret.

This approach makes issues easier to identify and resolve.

### Validate after each major change

After Agent mode makes significant changes:

- Run all tests to verify functionality.
- Build the application to catch compilation errors.
- Manually test critical paths affected by the changes.
- Review the changes in Git diff before committing.

Validation ensures remediation maintains application functionality.

### Rotate exposed credentials

Agent mode can remove secrets from code, but it cannot rotate credentials with service providers:

1. Log into the service provider's dashboard (Stripe, AWS, Azure, etc.).
1. Revoke the exposed credential.
1. Generate a new secret.
1. Configure the new secret in your environment.
1. Test that the application works with the new credential.

Only after rotating credentials is the remediation truly complete.

### Document configuration requirements

Agent mode can help create documentation, but ensure it's comprehensive:

- List all required secrets.
- Explain where to obtain credentials.
- Provide setup instructions for different environments.
- Include troubleshooting guidance for common configuration issues.

Good documentation helps other developers configure secrets correctly.

### Use appropriate secret storage for each environment

Different environments require different secret management approaches:

- **Local Development**: User Secrets or local .env files (excluded from Git).
- **CI/CD Pipelines**: GitHub Secrets, Azure Pipeline variables, or similar.
- **Staging/Production**: Azure Key Vault, AWS Secrets Manager, or managed configuration.

Agent mode can implement code that works with all of these, but you must configure them appropriately.

## Common secret remediation patterns

Different types of secrets often require specific remediation approaches:

### API keys and tokens

For API key remediation:

```csharp
// Pattern: Environment variable access with clear error messages
public class ServiceClient
{
    private readonly string _apiKey;
    
    public ServiceClient(IConfiguration configuration)
    {
        _apiKey = configuration["ServiceProvider:ApiKey"]
            ?? throw new InvalidOperationException(
                "ServiceProvider:ApiKey must be configured. " +
                "See README.md for configuration instructions.");
    }
}
```

### Database connection strings

For connection string remediation:

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

For OAuth secret remediation:

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

For encryption key remediation:

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

## Handling complex scenarios

Some secret remediation scenarios require additional consideration:

### Secrets in multiple files

When secrets appear in multiple locations:

1. Use Agent mode to remediate all occurrences consistently.
1. Implement a centralized configuration service that all components use.
1. Ensure all usage locations are updated to the new pattern.

Example prompt: "Refactor all classes in the selected files that use hard-coded Stripe keys to consistently use IConfiguration dependency injection."

### Secrets with multiple components

Some credentials have multiple parts (client ID + secret, username + password):

1. Ensure all components are moved to secure storage.
1. Use configuration sections to group related settings.
1. Validate that all components are configured together.

### Backward compatibility requirements

If you need to maintain compatibility during migration:

1. Implement fallback logic that checks environment variables if configuration is missing.
1. Log warnings when using deprecated configuration methods.
1. Plan a migration timeline to remove fallback code.

### Testing with secrets

Tests should never use real credentials:

1. Use mock configuration in unit tests.
1. Use test credentials (when provided by services) in integration tests.
1. Configure test secrets separately from production secrets.
1. Never commit test credentials that could grant real access.

By following these comprehensive patterns and practices, you can use GitHub Copilot's Agent mode to effectively remediate secret scanning alerts while maintaining application security and functionality.
