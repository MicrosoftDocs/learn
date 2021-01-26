This exercise steps through the process of preparing a submission for the language detection service, using either C# or Python. You will require an active Azure subscription and a Cognitive Service for this exercise.  Your Cognitive Service may be a multi-service resource (Cognitive Services resource), or it may be a **Text Analytics** resource.

## Setting up your environment (optional if these requirements are already met)

1. To complete the exercises, you will require an Azure subscription and a Cognitive Services resource.
1. Sign in to the [Azure portal](https://portal.azure.com) using your Azure subscription credentials.  If you do not have an Azure subscription yet, [create the subscription](https://azure.microsoft.com/free) before proceeding.
1. Select the + Create a resource option in the left nav pane or on the Home page of the Azure portal.
1. In the text entry to search the Azure Marketplace, enter **Cognitive Services** for a multi-service resource, and press **Enter**.
1. Select **Cognitive Services** from the list presented.
1. Select the **Create** button.
1. Enter a unique name for the service, such as **myMultiCogService**.
1. Select your Azure subscription from the **Subscription** drop-down list.
1. Choose a **Location** that is closest to you.
1. For the **Pricing Tier**, select F0 if available, otherwise select S0.
1. Select an existing resource group or create a new one, if you do not already have an appropriate resource group.
1. Select the check box to confirm you understand the notice on the page.
1. Select **Create**.
1. Once the deployment succeeds, go to the newly created Cognitive Service resource.
1. Open the **Keys and Endpoint** page by selecting that option from left nav pane of the service.  You will need the key and endpoint for the exercises.

## Development environment setup

The environment for this exercise will make use of Visual Studio Code as the editor. Depending on the programming language you choose, the setup will differ. Follow the steps outlined here to configure your local computer for completion of the exercises.

1. Install [Visual Studio Code](https://code.visualstudio.com/) for your operating system.

### Python

1. If you will be completing your coding with Python, ensure you have a [Python environment](https://www.python.org/downloads/) installed locally.
1. Once you have Python installed, you will need to [install the extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) for VS Code.

### C#

1. If you will be using C# as your code language, start by installing the latest [.NET Core](https://docs.microsoft.com/dotnet/core/install/windows?tabs=netcore31) package for your platform. You can choose Windows, Linux, or macOS from the drop-down on this page.
1. Once you have .NET Core installed, you will need to add the C# Extension to VS Code. Select the **Extensions** option in the left nav pane, or press **CTRL+SHIFT+X** and enter C# in the search dialog.

With your environment setup, you are now ready to begin the coding exercise.

## Call the Language Detection service

:::zone pivot="csharp"

1. Start by opening Visual Studio Code.
1. Create a new folder with a name of your choosing, example **DetectLangCsharp**.
1. Right-click the **DetectLangCsharp** folder and choose **Open in Integrated Terminal**.

    >[!Note]
    >Visual Studio Code may have different menu options depending on the packages you have installed.  You are looking for a terminal window at the bottom of Visual Studio Code that offers a command prompt/terminal.

1. We will be using C# and .NET Core for this exercise so type in the command ```dotnet new console``` and press Enter.
1. A new C# dotnet core project structure is set up for you complete with a **Program.cs** file, a workspace.csproj file, and the obj folder.
1. Select the **Program.cs** file in the file panel to open it in the editor.
1. You can now start to enter some code for the application.
1. You will require several libraries for the Text Analytics functionality so paste these **using** statements into your **Program.cs** file.

    ```csharp
    using System;
    using Azure;
    using Azure.AI.TextAnalytics
    ```

1. Inside Program.cs, add two variables to store the credential information for accessing the service.

    ```csharp
    private static readonly AzureKeyCredential credentials = new AzureKeyCredential("YourCognitiveKey");
    private static readonly Uri endpoint = new Uri("YourCognitiveEndpoint");
    ```

1. Create a method called DetectLanguage() by pasting in the code below the existing Main() method in Program.cs.

    ```csharp
    static void DetectLanguage(TextAnalyticsClient client)
    {
        DetectedLanguage detectedLanguage = client.DetectLanguage("Ce document est rédigé en Français.");
        Console.WriteLine("Language:");
        Console.WriteLine($"\t{detectedLanguage.Name},\tISO-6391: {detectedLanguage.Iso6391Name}\n");
    }
    ```

1. Next, modify Main() so that it contains the code snippet here.

    ```csharp
    static void Main(string[] args)
    {
        var client = new TextAnalyticsClient(endpoint, credentials);

        DetectLanguage(client);
        Console.Write("Press any key to exit.");
        Console.ReadKey();
    }
    ```

1. Paste your key and endpoint into the placeholders variables in **Program.cs**.
1. Before you run the code, you will need to add the TextAnalytics package to the application.  Enter the following command to add the package, ``` dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.4 ```, and press Enter.

    >[!CAUTION]
    >The dotnet add package command is specifying a version.  This version can, and will change.  You may need to update the version information in this command.  One mechanism to find the supported version is to run ``` dotnet add package Azure.AI.TextAnalytics ``` without specifying a version.  It will generate errors.  One of these errors will list a "nearest version".   You can then update the command to include that version.

1. Once the package is added, in the Terminal, enter the command ``` dotnet run ```.
1. If there are no errors in the code and your key is accurate, you should see output similar to this.

    ```dos
    Language:
        French, ISO-6391: fr
    ```

:::zone-end

:::zone pivot="python"

1. Create a folder to store the project in by using your local file system, **DetectLangPython**.
1. In Visual Studio Code, select the File icon. Then open the folder you created.
1. Create a new file in this folder, and call it **detectlang.py**.
1. Select the hamburger menu and choose **Terminal, New Terminal**.
1. In the Terminal window, install the **Text Analytics** library with the command, ```sudo pip install --upgrade azure-cognitiveservices-language-textanalytics```.

    >[!Note]
    >Depending on your Python environment, the above command may not be appropriate. You may have to use just ```pip install``` or ```python3 install```

1. In your Python file, add the following code at the top.

    ```python
    import os
    from azure.cognitiveservices.language.textanalytics import TextAnalyticsClient
    from msrest.authentication import CognitiveServicesCredentials
    ```

1. Next, you will add variables to store your endpoint and key.

    ```python

    # variables to store subscription key and root URL for the Cognitive Service resource
    subscription_key = "YourCognitiveKey"
    endpoint = "YourCognitiveEndpoint"
    ```

1. In your Python code, create a function to authenticate to your Cognitive Service. This function will use the key and the URL endpoint for your service.

    ```python
    def authenticateClient():
        credentials = CognitiveServicesCredentials(key)
        text_analytics_client = TextAnalyticsClient(
            endpoint=endpoint, credentials=credentials)
        return text_analytics_client
    ```

1. Create a ```documents``` variable and store a properly formatted documents array, in JSON format, using the following code. In this instance, we are creating the JSON inside the method that will call the service.  Use the following code to create the new method.

    ```python

    def language_detection():
        client = authenticateClient()

        try:
            documents = [
                {'id': '1', 'text': 'This is a document written in English.'},
                {'id': '2', 'text': 'Este es un document escrito en Español.'},
                {'id': '3', 'text': '这是一个用中文写的文件'}
            ]
            response = client.detect_language(documents=documents)

            for document in response.documents:
                print("Document Id: ", document.id, ", Language: ",
                      document.detected_languages[0].name)

        except Exception as err:
            print("Encountered exception. {}".format(err))
    ```

1. This function will pass the entire JSON file, to the service.  The JSON contents are passed in the body of the request.
1. The code then calls the service, passing in the JSON file, and storing the results in the ```response``` variable.
1. Finally, it iterates over the documents returned, in the ```response``` variable.  It will output the ID and detected language for each document that was included in the request.
1. Now that have your text document, key and URL configured, it is time to call the service and output the results.

    ```python
    language_detection()
    ```

1. Paste your key and endpoint URL into the placeholders in the code.
1. Select the **Run Python File in Terminal** or right-click anywhere in the code editor and select **Run Python File in Terminal**.
1. If your code contains no errors, the resulting output should be sent to the terminal window and is displayed here for comparison.

    ```dos
    Document Id:  1 , Language:  English
    Document Id:  2 , Language:  Spanish
    Document Id:  3 , Language:  Chinese_Simplified
    ```

:::zone-end
