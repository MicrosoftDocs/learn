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

## Create Visual Studio Codespaces environment

1. Start by opening a browser tab or window and navigating to [Visual Studio Codespaces](https://visualstudio.microsoft.com/services/visual-studio-codespaces/).

    > [!NOTE]
    > At this time, Safari is not a supported browser for the preview of Visual Studio Codespaces.

    An Azure subscription is required to create an environment for Visual Studio Codespaces.
1. Select the **Get started** button.
1. Sign in using the Microsoft Account that is linked to your Azure subscription.
1. The first time you use Visual Studio Codespaces, you need to create a new plan, which should be selected in the drop-down at the top of the page.
1. Select **Create Codespace**.
1. Select your Subscription in the **Select Billing** pane and choose a location for the service.
1. Select **Create**.
1. Once your plan is created, you can then create your first environment.  
1. If the **Create Codespace** panel does not open automatically, select **Create Codespace**.
1. Select the programming language of choice and continue with the exercise.

## Call the Language Detection service

:::zone pivot="csharp"

1. Enter an environment name of your choosing, example **LanguageDetectCS**.
1. Leave the rest of the settings at their default and select **Create**.
1. It will take a few minutes for the environment to be created so while you wait, go to your Cognitive Service in the Azure portal and copy one of your keys.
1. Once the environment indicates that it is available, select the hamburger menu in the upper left corner and choose **Terminal, New Terminal**.
1. Once the new terminal opens, verify your prompt is **codespace:~/workspace$**.
1. Type in the command ``` dotnet new console ```.
1. A skeleton .NET Core application is created.
1. Select the **Program.cs** file in the file panel to open it in the editor.
1. To get a larger space in which to work, close the **Welcome** and **Creation Log** tabs.
1. You may be prompted to install the C# extension.  Select **Install** when prompted, then select **Reload Required** to apply the extension to the environment.
1. The next prompt asks you to install required assets.  Select **Yes** to install these assets.
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

        LanguageDetectionExample(client);
        Console.Write("Press any key to exit.");
        Console.ReadKey();
    }
    ```

1. Paste your key and endpoint into the placeholders variables in Program.cs.
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

1. Enter an environment name of your choosing, example **LanguageDetectPy**.
1. Leave the rest of the settings at their default and select **Create**.
1. It will take a few minutes for the environment to be created so while you wait, go to your Cognitive Service in the Azure portal and copy one of your keys.
1. Once the environment is created, close the **Welcome** and **Creation Log** tabs.
1. Create a new file and call it **DetectLanguage.py**.
1. Visual Studio Codespace will prompt you to install the Python extension, choose **Install**.
1. Select the **Reload Required** button in the **Extensions** pane.
1. Choose **Do not show again** when prompted for PyLint.
1. If the **Terminal** window is not open at the bottom of the editor, select the hamburger menu and choose **Terminal, New Terminal**.
1. In the Terminal window, install the **Text Analytics** library with the command, ```sudo pip install --upgrade azure-cognitiveservices-language-textanalytics```.
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
