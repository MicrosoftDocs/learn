You know how enabling managed identities for Azure resources creates an identity for your app to use for authentication. Now create an app that uses that identity to access secrets in the vault.

::: zone pivot="csharp"

## Read secrets in an ASP.NET Core app

Azure Key Vault API is a REST API that handles all management and usage of keys and vaults. Each secret in a vault has a unique URL. Secret values are retrieved with HTTP GET requests.

The official Key Vault client for .NET Core is the `SecretClient` class in the `Azure.Security.KeyVault.Secrets` NuGet package. However, you don't need to use it directly. With ASP.NET Core's `AddAzureKeyVault` method, you can load all the secrets from a vault into the Configuration API at startup. This technique lets you access all of your secrets by name using the same `IConfiguration` interface you use for the rest of your configuration. Apps that use `AddAzureKeyVault` require both `Get` and `List` permissions to the vault.

> [!TIP]
> Regardless of the framework or language you use to build your app, you should design it to cache secret values locally or load them into memory at startup, unless you have a specific reason not to. Reading them directly from the vault every time you need them is unnecessarily slow and expensive.

`AddAzureKeyVault` only requires the vault name as an input, which you get from your local app configuration. It also automatically handles managed identity authentication. When the API is used in an app deployed to Azure App Service with managed identities for Azure resources enabled. It detects the managed identities token service and uses it to authenticate. It's a good fit for most scenarios and implements all best practices. You use it in this unit's exercise.

::: zone-end

::: zone pivot="javascript"

## Read secrets in a Node.js app

Azure Key Vault API is a REST API that handles all management and usage of keys and vaults. Each secret in a vault has a unique URL. Secret values are retrieved with HTTP GET requests.

The official Key Vault client for Node.js apps is the `SecretClient` class in the `@azure/keyvault-secrets` npm package. Apps that include secret names in their configuration or code generally use its `getSecret` method, which loads a secret value given its name. `getSecret` requires your app's identity to have the `Get` permission on the vault. Apps designed to load all secrets from a vault also use the `listPropertiesOfSecrets` method, which loads a list of secrets and requires the `List` permission.

Before your app can create a `SecretClient` instance, it must get a credential object for authenticating to the vault. To authenticate, use the `DefaultAzureCredential` provided by the `@azure/identity` npm package. The `DefaultAzureCredential` is appropriate for most scenarios where the application is intended to ultimately run in the Azure Cloud because the `DefaultAzureCredential` combines credentials commonly used to authenticate when deployed, with credentials used to authenticate in a development environment. The `DefaultAzureCredential` attempts to authenticate by using the following mechanisms in order:

* Environment. The `DefaultAzureCredential` reads account information specified by using environment variables and uses it to authenticate.
* Managed Identity. If the application is deployed to an Azure host with Managed Identity enabled, the `DefaultAzureCredential` authenticates with that account.
* Visual Studio Code. If the developer authenticated by using the Visual Studio Code Azure Account plugin, the `DefaultAzureCredential` authenticates with that account.
* Azure CLI. If the developer authenticated an account by using the Azure CLI `az login` command, the `DefaultAzureCredential` authenticates with that account.

For more information, [see the documentation](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/README.md#defaultazurecredential).

> [!TIP]
> Regardless of the framework or language you use to build your app, you should design it to cache secret values locally or load them into memory at startup, unless you have a specific reason not to. Reading them directly from the vault every time you need them is unnecessarily slow and expensive.

::: zone-end

## Handle secrets in an app

After a secret is loaded into your app, it's up to your app to handle it securely. In the app that you build in this module, you write your secret value out to the client response, and to demonstrate that it loaded successfully, you view it in a web browser. **Returning a secret value to the client is *not* something you should normally do!** Usually, you use secrets to do things like initialize client libraries for databases or remote APIs.

> [!IMPORTANT]
> Always carefully review your code to ensure your app never writes secrets to any kind of output, including logs, storage, and responses.

## Exercise

::: zone pivot="csharp"

To load the secret from our vault, you create a new ASP.NET Core web API, and use `AddAzureKeyVault`.

### Create the app

1. To create a new ASP.NET Core web API app and open it in the editor, run the following commands in Azure Cloud Shell.

    ```console
    dotnet new webapi -o KeyVaultDemoApp
    cd KeyVaultDemoApp
    code .
    ```

1. After the editor loads, add the NuGet package containing `AddAzureKeyVault` and restore all of the app's dependencies. In Azure Cloud Shell, run the following commands.

    ```console
    dotnet add package Azure.Identity
    dotnet add package Azure.Extensions.AspNetCore.Configuration.Secrets
    dotnet restore
    ```

### Add code that loads and uses secrets

To demonstrate good use of Key Vault, modify your app to load secrets from the vault at startup. You also add a new controller with an endpoint that gets your `SecretPassword` secret from the vault.

1. For the app startup, enter the following command to launch the editor.

    ```console
    code .
    ```

1. Open `Program.cs`, delete the contents, and replace them with the following code.

    ```csharp
    using System;
    using Azure.Identity;
    using Microsoft.AspNetCore;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.Hosting;

    namespace KeyVaultDemoApp
    {
        public class Program
        {
            public static void Main(string[] args)
            {
                CreateHostBuilder(args).Build().Run();
            }

            public static IHostBuilder CreateHostBuilder(string[] args) =>
                Host.CreateDefaultBuilder(args)
                    .ConfigureWebHostDefaults(webBuilder =>
                    {
                        webBuilder.UseStartup<Startup>();
                    })
                    .ConfigureAppConfiguration((context, config) =>
                    {
                        // Build the current set of configuration to load values from
                        // JSON files and environment variables, including VaultName.
                        var builtConfig = config.Build();

                        // Use VaultName from the configuration to create the full vault URI.
                        var vaultName = builtConfig["VaultName"];
                        Uri vaultUri = new Uri($"https://{vaultName}.vault.azure.net/");

                        // Load all secrets from the vault into configuration. This will automatically
                        // authenticate to the vault using a managed identity. If a managed identity
                        // is not available, it will check if Visual Studio and/or the Azure CLI are
                        // installed locally and see if they are configured with credentials that can
                        // access the vault.
                        config.AddAzureKeyVault(vaultUri, new DefaultAzureCredential());
                    });
        }
    }
    ```

    > [!IMPORTANT]
    > Make sure to save files when you're done editing them. You can save files either through the "..." menu, or the accelerator key (**Ctrl**+**S** on Windows and Linux, **Cmd**+**S** on macOS).

    The only change from the starter code is the addition of `ConfigureAppConfiguration`. This element is where we load the vault name from configuration and call `AddAzureKeyVault` with it.

1. For the controller, create a new file in the `Controllers` folder called `SecretTestController.cs`, and paste in the following code.

    > [!TIP]
    > To create a new file, use the `touch` command in Cloud Shell. In this case, run the `touch Controllers/SecretTestController.cs` command. To find it in the top right corner of the *Files* pane of the editor, select the **Refresh** icon.

    ```csharp
    using System;
    using Microsoft.AspNetCore.Http;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Configuration;

    namespace KeyVaultDemoApp.Controllers
    {
        [Route("api/[controller]")]
        public class SecretTestController : ControllerBase
        {
            private readonly IConfiguration _configuration;

            public SecretTestController(IConfiguration configuration)
            {
                _configuration = configuration;
            }

            [HttpGet]
            public IActionResult Get()
            {
                // Get the secret value from configuration. This can be done anywhere
                // we have access to IConfiguration. This does not call the Key Vault
                // API, because the secrets were loaded at startup.
                var secretName = "SecretPassword";
                var secretValue = _configuration[secretName];

                if (secretValue == null)
                {
                    return StatusCode(
                        StatusCodes.Status500InternalServerError,
                        $"Error: No secret named {secretName} was found...");
                }
                else {
                    return Content($"Secret value: {secretValue}" +
                        Environment.NewLine + Environment.NewLine +
                        "This is for testing only! Never output a secret " +
                        "to a response or anywhere else in a real app!");
                }
            }
        }
    }
    ```

1. Run the `dotnet build` command in Azure Cloud Shell and make sure everything compiles. The app is ready to run. Now it's time to get it into Azure!

::: zone-end

::: zone pivot="javascript"

Create a new web API with Express.js and use the `@azure/keyvault-secrets` and `@azure/identity` packages to load the secret from our vault.

### Create the app

Run the following code in Azure Cloud Shell to initialize a new Node.js app, install the needed packages, and open a new file in the editor.

```console
mkdir KeyVaultDemoApp
cd KeyVaultDemoApp
npm init -y
npm install @azure/identity @azure/keyvault-secrets express
touch app.js
code app.js
```

### Add code that loads and uses secrets

To demonstrate good use of Key Vault, your app loads secrets from the vault at startup. To demonstrate that your secrets loaded, create an endpoint that displays the value of the `SecretPassword` secret.

1. To set up the app, paste the following code into the editor. This code imports the necessary packages, sets up the port and vault URI configuration, and creates a new object to hold the secret names and values.

    ```javascript
    // Importing dependencies
    const { DefaultAzureCredential } = require("@azure/identity");
    const { SecretClient } = require("@azure/keyvault-secrets");
    const app = require('express')();

    // Initialize port
    const port = process.env.PORT || 3000;

    // Create Vault URI from App Settings
    const vaultUri = `https://${process.env.VaultName}.vault.azure.net/`;

    // Map of key vault secret names to values
    let vaultSecretsMap = {};
    ```

    > [!IMPORTANT]
    > Make sure to save files as you work on them, especially when you're finished. You can save files either through the "..." menu, or the accelerator key (**Ctrl**+**S** on Windows and Linux, **Cmd**+**S** on macOS).

1. Next, add the code to authenticate to the vault and load the secrets. You add this code as two separate functions. Insert a couple of blank lines after the code you previously added, and then paste in the following code.

    ```javascript
    const getKeyVaultSecrets = async () => {
      // Create a key vault secret client
      let secretClient = new SecretClient(vaultUri, new DefaultAzureCredential());
      try {
        // Iterate through each secret in the vault
        listPropertiesOfSecrets = secretClient.listPropertiesOfSecrets();
        while (true) {
          let { done, value } = await listPropertiesOfSecrets.next();
          if (done) {
            break;
          }
          // Only load enabled secrets - getSecret will return an error for disabled secrets
          if (value.enabled) {
            const secret = await secretClient.getSecret(value.name);
            vaultSecretsMap[value.name] = secret.value;
          }
        }
      } catch(err) {
        console.log(err.message)
      }
    }
    ```

1. To test whether our secret was loaded, create the Express endpoint. Paste in this code.

    ```javascript
    app.get('/api/SecretTest', (req, res) => {
      let secretName = 'SecretPassword';
      let response;
      if (secretName in vaultSecretsMap) {
        response = `Secret value: ${vaultSecretsMap[secretName]}\n\nThis is for testing only! Never output a secret to a response or anywhere else in a real app!`;
      } else {
        response = `Error: No secret named ${secretName} was found...`
      }
      res.type('text');
      res.send(response);
    });
    ```

1. Call your functions to load the secrets from our vault, then start the app. To complete the app, paste in this last snippet.

    ```javascript
    (async () =>  {
      await getKeyVaultSecrets();
      app.listen(port, () => {
        console.log(`Server running at http://localhost:${port}`);
      });
    })().catch(err => console.log(err));
    ```

1. You're finished writing code, so make sure to save the file.

The app is ready to run. Now it's time to get it into Azure!

::: zone-end
