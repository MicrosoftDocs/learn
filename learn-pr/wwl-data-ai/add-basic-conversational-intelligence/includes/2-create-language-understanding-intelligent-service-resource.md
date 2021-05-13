Let’s look at how we can use LUIS to add natural language capabilities to a picture-management bot. LUIS allows you to map natural language *utterances* to *intents*. In other words, LUIS maps the user's words, phrases, or sentences to tasks or actions the user wants to do.

Our application might have several intents: finding pictures, sharing pictures, and ordering prints of pictures. We'll give LUIS a few example utterances of ways users might ask for each of these things. LUIS will then map additional new utterances to each intent based on what it learns over time.

> [!NOTE]
> This is an optional exercise. To use a LUIS service that's tied to your Azure account, follow these steps to create the LUIS service. To use a test environment only, go to the "Create a LUIS app" exercise later on this page.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. In the left pane, select **+ Create a resource**.
1. In the **Search the Marketplace** box, type **LUIS**, and then press Enter.
1. In the search results, select **Language Understanding**.
1. Select **Create**.
1. Leave the Create options set to **Both**.
1. Choose a subscription.
1. Enter a unique name for your LUIS service.
1. Create a new resource group named **LearnRG**.
1. For **Authoring Location**, choose the one nearest you.
1. For **Authoring pricing tier**, select **F0**
1. Set your **Prediction location** to the same region you chose for **Authoring location**
1. For **Prediction pricing tier**, select **F0**. If **F0** is not available, select **S0** or other free/low cost tier.
1. Select **Review + Create**.
1. If the validation succeeds, select **Create**.

After the deployment has finished, go the resource page for the service. You'll need one of the displayed subscription keys for later exercises. Locate the **Resource Management** section and then select the **Keys and Endpoints** section to see the two created keys.

## Create a LUIS app in the LUIS portal

Azure requires you to create the LUIS app in the same geographic location where you created the service. If you didn't create the service in the previous optional exercise, use the location closest to you.

1. Select one of the following URLs, and open it in a new browser window.

   - **North America:** [https://www.luis.ai/](https://www.luis.ai/)
   - **Europe:** [https://eu.luis.ai/](https://eu.luis.ai/)
   - **Australia:** [https://au.luis.ai/](https://au.luis.ai/)

    > [!NOTE]
    > There are three LUIS websites, based on region. You must author and publish in the same region. Select the closest region to you.

1. Select the **Sign in** link in the upper-right corner.
1. Sign in with your Microsoft account.
1. The pages displayed will be different if you have already created a LUIS app or have no apps created at all.  Select either **Go to apps**, or the apps option that is available on your initial LUIS page.
1. Select **+ New app for conversation** and then **New app for conversation** again.  Take note of the other options such as the ability to import *JSON* or *LU* file that contains LUIS configuration options.

    >[!NOTE]
    >The LUIS user interface is updated on a regular basis and the actual options may change, in terms of the text used.  The basic workflow is the same but you may need to adapt to the UI changes for the text on some elements or instructions given here.

1. Give your LUIS app a name, for example, **PictureBotLUIS**.
1. For **Culture**, select the appropriate choice for you language.
1. Give your LUIS app a description so it's clear what the app's purpose is.
1. If you have already created a **Prediction Resource**, you can select that in the drop-down for **Prediction resource (Optional)**.
1. Select **Done**.
1. A guidance dialog may display that will provide some information on how to create an effective LUIS app.  You can step through these concepts to gain an idea of how to create a LUIS app.  When finished, close the dialog by selecting the **X** in the upper right corner.

The newly created app will open with the **Build** tab opened and displaying the **Intents** panel with a default **None** intent displayed.

That is all that is required to create a new LUIS app that is linked to a LUIS service on Microsoft Azure.

## Create a LUIS app with code

It is possible to create a LUIS application through code.  You may want to create the LUIS app this way if you want to integrate with a continuous integration, continuous development (CI/CD) environment.  In order to create a LUIS app in code, you still require a LUIS authoring key.  The authoring key is available by creating the LUIS resource first. Once you have the resource created, you can use the key for that service to author the LUIS app with code.

### Environment setup

1. Ensure that you have followed the instructions earlier in this unit to create a LUIS resource.
1. Copy the key and endpoint from the LUIS resource.  It will be required during the app creation.

    The environment for this exercise will make use of Visual Studio Code as the editor. Depending on the programming language you choose, the setup will differ. Follow the steps outlined here to configure your local computer for completion of the exercises.

1. Install [Visual Studio Code](https://code.visualstudio.com/) for your operating system.

### Python

1. If you will be completing your coding with Python, ensure you have a [Python environment](https://www.python.org/downloads/) installed locally.
1. Once you have Python installed, you will need to [install the extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) for VS Code.

### C#

1. If you will be using C# as your code language, start by installing the latest [.NET Core](https://docs.microsoft.com/dotnet/core/install/windows?tabs=netcore31) package for your platform. You can choose Windows, Linux, or macOS from the drop-down on this page.
1. Once you have .NET Core installed, you will need to add the C# Extension to VS Code. Select the **Extensions** option in the left nav pane, or press **CTRL+SHIFT+X** and enter C# in the search dialog.

With your environment setup, you are now ready to begin the coding exercise.

:::zone pivot="csharp"

This exercise demonstrates how to create a Language Understanding application using a .NET Core console application and the C# programming language.

1. Using Windows Explorer, create a folder on your local drive to store the project files.  Name the folder **LU_Csharp**.
1. Open Visual Studio Code.
1. Open the folder you just created.
1. You will create a .NET Core application so right-click the **LU_Csharp** folder and choose **Open in Terminal**
1. Type in the command ```dotnet new console``` and press Enter.
1. A new C# dotnet core project structure is set up for you complete with a Program.cs file, a workspace.csproj file, and the obj folder. You may need to expand the csharp folder to see the new files.
1. Select the Program.cs file and inspect its contents. You will modify and add code to this file for the exercise.

    >[!NOTE]
    >If you are prompted to install the C# Extension, select Install. Then select the reload option.
    >After the reload, you may also be prompted to install extensions, choose to install them

1. You may get another prompt asking you to install required assets.  Select **Yes** to install these assets.
1. You will also need to install the **LUIS Authoring SDK**.  
1. Enter this command in the terminal window.

    ```dotnetcli
    dotnet add package Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring --version 3.0.0
    ```

1. You can now start to enter some code for the application.
1. You will require several libraries for the Text Analytics functionality so paste these **using** statements into your **Program.cs** file.

    ```csharp
    using Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring;
    using Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring.Models;

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security;
    using System.Threading.Tasks;
    ```

1. The next step is to create the variables to hold the key and endpoint for client authorization.  Paste the following code inside the **Program.cs** class file, before the **Main()** method.

    ```csharp
    private static readonly string authoring_key = "YOUR_LUIS_KEY";
    private static readonly string authoring_endpoint = "YOUR_LUIS_ENDPOINT";
    ```

1. Paste your key and endpoint into the placeholders in the variables.
1. Create an ApiKeyServiceClientCredentials object with your key, and use it with your endpoint to create an LUISAuthoringClient object. Paste this code into **Main()** and replace the existing line of code there.

    ```csharp
    // Generate the credentials and create the client.
    var credentials = new Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring.ApiKeyServiceClientCredentials(authoring_key);
    var client = new LUISAuthoringClient(credentials, new System.Net.Http.DelegatingHandler[] { })
    {
        Endpoint = authoring_endpoint
    };
    ```

1. You will also create a C# struct to hold the application information, **ID** and **Version**.  Place this code inside the namespace and before the **Program.cs** class.

    ```csharp
        // <ApplicationInfo>
        struct ApplicationInfo
        {
            public Guid ID;
            public string Version;
        }
        // </ApplicationInfo>
    ```

1. Create a new method to perform the task of creating the application.

    ```csharp
        // Return the application ID and version.
        async static Task<ApplicationInfo> CreateApplication(LUISAuthoringClient client)
        {
            string app_name = String.Format("PictureBotLUIS");
            string app_description = "LUIS app built with LUIS .NET SDK.";
            string app_version = "0.1";
            string app_culture = "en-us";

            var app_info = new ApplicationCreateObject()
            {
                Name = app_name,
                InitialVersionId = app_version,
                Description = app_description,
                Culture = app_culture
            };
            var app_id = await client.Apps.AddAsync(app_info);
            Console.WriteLine("Created new LUIS application {0}\n with ID {1}.", app_info.Name, app_id);
            return new ApplicationInfo() { ID = app_id, Version = app_version };
        }
    ```

1. Call the **CreateApplication()** method from Main with the following code.

    ```csharp
    ApplicationInfo appInfo = await CreateApplication(client);
    ```

1. You will also need to modify the signature of Main() due to the asynchronous operation.

    ```csharp
    async static Task Main(string[] args)
    ```

1. Your completed code should look like the following:

    ```csharp
    using Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring;
    using Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring.Models;

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security;
    using System.Threading.Tasks;

    namespace create_luis_app
    {

        // <ApplicationInfo>
        struct ApplicationInfo
        {
            public Guid ID;
            public string Version;
        }
        // </ApplicationInfo>

        class Program
        {
            private static readonly string authoring_key = "YOUR_LUIS_KEY";
            private static readonly string authoring_endpoint = "YOUR_LUIS_ENDPOINT";

            async static Task Main(string[] args)
            {
                // Generate the credentials and create the client.
                var credentials = new Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring.ApiKeyServiceClientCredentials(authoring_key);
                var client = new LUISAuthoringClient(credentials, new System.Net.Http.DelegatingHandler[] { })
                {
                    Endpoint = authoring_endpoint
                };

                ApplicationInfo appInfo = await CreateApplication(client);
            }

            // Return the application ID and version.
            async static Task<ApplicationInfo> CreateApplication(LUISAuthoringClient client)
            {
                string app_name = String.Format("PictureBotLUIS");
                string app_description = "Picture Bot app built with LUIS .NET SDK.";
                string app_version = "0.1";
                string app_culture = "en-us";

                var app_info = new ApplicationCreateObject()
                {
                    Name = app_name,
                    InitialVersionId = app_version,
                    Description = app_description,
                    Culture = app_culture
                };
                var app_id = await client.Apps.AddAsync(app_info);
                Console.WriteLine("Created new LUIS application {0}\n with ID {1}.", app_info.Name, app_id);
                return new ApplicationInfo() { ID = app_id, Version = app_version };
            }
        }
    }

    ```

    >[!CAUTION]
    >If you decide to run the code now, it will create a LUIS app for you however, the units in this module will build on this LUIS app code by adding intents, utterances, and entities.  If you run this code now, you will need to either delete the LUIS app before running the subsequent topic code, or comment out the call to **CreateApplication()**.

:::zone-end

:::zone pivot="python"

This exercise demonstrates creating a LUIS application with Python code.

1. Using Windows Explorer, create a folder on your local drive to store the project files.  Name the folder **LU_Python**.
1. Open Visual Studio Code.
1. Open the folder you just created.
1. Select the **New File** button and create a Python file called **create_luis.py**.
1. Right-click the python file name and select **Open in Terminal**.
1. You will need to install the LUIS package to gain access to the SDK.
1. Type in the command, ``` sudo pip install azure-cognitiveservices-language-luis ```.

    >[!Note]
    >Your command may differ depending on your Python environment.  You may need to use just ```pip install``` or ```python3 install```

1. Once the package is installed, you can begin to enter the code.
1. Add the necessary import statements to the top of your Python file.

    ```python
    from azure.cognitiveservices.language.luis.authoring import LUISAuthoringClient
    from msrest.authentication import CognitiveServicesCredentials

    import datetime, json, os, time
    ```

1. You will also require variables to store your key and endpoint.

    ```python
    authoring_key = 'YOUR_LUIS_KEY'

    authoring_endpoint = 'YOUR_LUIS_ENDPOINT'
    ```

1. The next step is to instantiate a client object and authenticate to the service.

    ```python
    # Instantiate a LUIS client
    client = LUISAuthoringClient(authoring_endpoint, CognitiveServicesCredentials(authoring_key))
    ```

1. This next function handles the work of creating the LUIS app with the client information.

    ```python
    def create_app():
        # Create a new LUIS app
        app_name    = "PictureBotLUIS"
        app_desc    = "Picture Bot app built with LUIS Python SDK."
        app_version = "0.1"
        app_locale  = "en-us"

        app_id = client.apps.add(dict(name=app_name,
                                    initial_version_id=app_version,
                                    description=app_desc,
                                    culture=app_locale))

        print("Created LUIS app {}\n    with ID {}".format(app_name, app_id))
        return app_id, app_version
    ```

1. Almost all the pieces are in place, the last bit of code is a call to the **create_app** function so add this line to the end of you Python code.

    ```python
    create_app()
    ```

1. Paste your key and endpoint into the placeholders in the code.

    >[!CAUTION]
    >If you decide to run the code now, it will create a LUIS app for you however, the units in this module will build on this LUIS app code by adding intents, utterances, and entities.  If you run this code now, you will need to either delete the LUIS app before running the subsequent topic code, or comment out the call to **create_app()**.


:::zone-end
