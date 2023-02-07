
In this exercise you'll learn how to perform the following actions:

* Register an application with the Microsoft identity platform
* Use the `PublicClientApplicationBuilder` class in MSAL.NET
* Acquire a token interactively in a console application

## Prerequisites

* An **Azure account** with an active subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free)
* **Visual Studio Code**: You can install Visual Studio Code from [https://code.visualstudio.com](https://code.visualstudio.com/).

## Register a new application

1. Sign in to the portal: [https://portal.azure.com](https://portal.azure.com) 

1. Search for and select **Azure Active Directory**. 

1. Under **Manage**, select **App registrations** > **New registration**.

1. When the **Register an application** page appears, enter your application's registration information:

    | Field | Value |
    |--|--|
    | **Name** | `az204appreg` |
    | **Supported account types** | Select **Accounts in this organizational directory only** |
    | **Redirect URI (optional)** | Select **Public client/native (mobile & desktop)** and enter `http://localhost` in the box to the right. |

    Below are more details on the **Supported account types**.


1. Select **Register**.

Azure Active Directory assigns a unique application (client) ID to your app, and you're taken to your application's **Overview** page. 

## Set up the console application

1. Launch Visual Studio Code and open a terminal by selecting **Terminal** and then **New Terminal**.

1. Create a folder for the project and change in to the folder.

    ```ps
    md az204-auth
    cd az204-auth
    ```

1. Create the .NET console app.

    ```ps
    dotnet new console
    ```

1. Open the *az204-auth* folder in Visual Studio Code.

    ```ps
    code . -r
    ```

## Build the console app

In this section you will add the necessary packages and code to the project.

### Add packages and using statements

1. Add the `Microsoft.Identity.Client` package to the project in a terminal in Visual Studio Code.

    ```ps
    dotnet add package Microsoft.Identity.Client
    ```

2. Open the *Program.cs* file and add `using` statements to include `Microsoft.Identity.Client` and to enable async operations.

    ```csharp
    using System.Threading.Tasks;
    using Microsoft.Identity.Client;
    ```

3. Change the Main method to enable async.

    ```csharp
    public static async Task Main(string[] args)
    ```

### Add code for the interactive authentication

1. We'll need two variables to hold the Application (client) and Directory (tenant) IDs. You can copy those values from the portal. Add the code below and replace the string values with the appropriate values from the portal.

    ```csharp
    private const string _clientId = "APPLICATION_CLIENT_ID";
    private const string _tenantId = "DIRECTORY_TENANT_ID";
    ```

2. Use the `PublicClientApplicationBuilder` class to build out the authorization context.

    ```csharp
    var app = PublicClientApplicationBuilder
        .Create(_clientId)
        .WithAuthority(AzureCloudInstance.AzurePublic, _tenantId)
        .WithRedirectUri("http://localhost")
        .Build();
    ```

    Code | Description
    | - | - |
    `.Create` | Creates a `PublicClientApplicationBuilder` from a clientID.
    `.WithAuthority` | Adds a known Authority corresponding to an ADFS server. In the code we're specifying the Public cloud, and using the tenant for the app we registered.

### Acquire a token

When you registered the *az204appreg* app it automatically generated an API permission `user.read` for Microsoft Graph. We'll use that permission to acquire a token.

1. Set the permission scope for the token request. Add the following code below the `PublicClientApplicationBuilder`.

    ```csharp
    string[] scopes = { "user.read" };
    ```

1. Add code to request the token and write the result out to the console.

    ```csharp
    AuthenticationResult result = await app.AcquireTokenInteractive(scopes).ExecuteAsync();

    Console.WriteLine($"Token:\t{result.AccessToken}");
    ```

## Review completed application

The contents of the *Program.cs* file should resemble the example below.

```csharp
using System;
using System.Threading.Tasks;
using Microsoft.Identity.Client;

namespace az204_auth
{
    class Program
    {
        private const string _clientId = "APPLICATION_CLIENT_ID";
        private const string _tenantId = "DIRECTORY_TENANT_ID";

        public static async Task Main(string[] args)
        {
            var app = PublicClientApplicationBuilder
                .Create(_clientId)
                .WithAuthority(AzureCloudInstance.AzurePublic, _tenantId)
                .WithRedirectUri("http://localhost")
                .Build(); 
            string[] scopes = { "user.read" };
            AuthenticationResult result = await app.AcquireTokenInteractive(scopes).ExecuteAsync();

            Console.WriteLine($"Token:\t{result.AccessToken}");
        }
    }
}
```

## Run the application

1. In the Visual Studio Code terminal run `dotnet build` to check for errors, then `dotnet run` to run the app. 

1. The app will open the default browser prompting you to select the account you want to authenticate with. If there are multiple accounts listed select the one associated with the tenant used in the app.

1. If this is the first time you've authenticated to the registered app you will receive a **Permissions requested** notification asking you to approve the app to read data associated with your account. Select **Accept**.

    :::image type="content" source="../media/permission-consent.png" alt-text="Select **Accept** to grant the permission.":::    

1. You should see the results similar to the example below in the console.

    ```
    Token:  eyJ0eXAiOiJKV1QiLCJub25jZSI6IlVhU.....
    ```
