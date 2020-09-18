Once your Cognitive Services are deployed, applications consume from the containerized Cognitive Services endpoint rather than the default Azure endpoint. Your sample application can be a list of documents representing health worker notes. The application will use the correct Cognitive Services library to consume a prediction from the containerized endpoint. In this case, you will use the text analytics client library. The detected language retrieved from the service will be printed out for each document. Let’s run a sample application that connects through the exposed endpoint of our Kubernetes deployment.

::: zone pivot="python"

1. First, set the environment variables we will use to connect, CONTAINER_ENDPOINT and COGNITIVE_SERVICE_KEY (if not already set).  Set the environment variables for your session using console window (bash) with the following command.

    ```bash
    export CONTAINER_ENDPOINT=https://<EXTERNAL-IP>:5000
    export COGNITIVE_SERVICE_KEY=<subscription_key>
    ```

    Let’s run a sample application that consumes from our language detection container:

1. Import required libraries.

    ```python
    import os
    from azure.core.credentials import AzureKeyCredential
    from azure.ai.textanalytics import TextAnalyticsClient
    ```

1. Set endpoint and subscription key.

    ```python
    service_endpoint = os.environ["CONTAINER_ENDPOINT"]
    subscription_key = os.environ["COGNITIVE_SERVICE_KEY"]
    ```

1. Initiate the client.

    ```python
    credential = AzureKeyCredential(subscription_key)
    text_analytics_client = TextAnalyticsClient(service_endpoint, credential)
    client = text_analytics_client
    ```

1. Run language detection example with two documents, one in English and one in Spanish.

    ```python
    try:
        documents = ["The patient has fever, fatigue, and loss of appetite.",
                     "La paciente tiene fiebre y le duele la garganta"]
        response = client.detect_language(documents = documents, country_hint = 'us')
    
        for document_response in response:
            print("Language used: ", document_response.primary_language.name)
    
    except Exception as err:
        print("Encountered exception. {}".format(err))
    ```

1. Detected languages are printed, one per document submitted.

    ```bash
    Language used:  English
    Language used:  Spanish
    ```

::: zone-end

::: zone pivot="csharp"

1. First, set the environment variables we will use to connect, CONTAINER_ENDPOINT and COGNITIVE_SERVICE_KEY (if not already set).  Set the environment variables for your session using console window (bash) with the following command.

    ```bash
    export CONTAINER_ENDPOINT=https://<EXTERNAL-IP>:5000
    export COGNITIVE_SERVICE_KEY=<subscription_key>
    ```

    Let’s run a sample application that consumes from our language detection container:

1. Import required libraries.

    ```csharp
    using System;
    using static System.Environment;
    using System.Collections.Generic;
    using Azure;
    using Azure.AI.TextAnalytics;
    ```

1. Set endpoint and subscription key.

    ```csharp
    var serviceEndpoint = GetEnvironmentVariable("CONTAINER_ENDPOINT");
    var subscriptionKey = GetEnvironmentVariable("COGNITIVE_SERVICE_KEY");
    ```

1. Initiate client.

    ```csharp
    AzureKeyCredential credentials = new AzureKeyCredential(subscriptionKey);
    var client = new TextAnalyticsClient(new Uri(serviceEndpoint), credentials);
    ```

1. Run language detection example with two documents, one in English and one in Spanish.

    ```csharp
    var documents = new List<DetectLanguageInput>
    {
        new DetectLanguageInput("1", "The patient has fever, fatigue, and loss of appetite."),
        new DetectLanguageInput("2", "La paciente tiene fiebre y le duele la garganta.")
    };

    DetectLanguageResultCollection response = client.DetectLanguageBatch(documents);
    foreach (DetectLanguageResult result in response)
    {
        Console.WriteLine($"Language used: {result.PrimaryLanguage.Name}");
    }
    ```

1. Detected languages are printed, one per document submitted.

    ```bash
    Language used: English
    Language used: Spanish
    ```

::: zone-end

## Cleanup

You have completed all the exercises, but don’t forget to clean up your resources.

If you are not using the resource group for other services, you can remove everything in it by running:

```azurecli
az group delete --name <resource-group> --yes --no-wait
```

Alternatively, you could remove individual services with the following commands:

1. Azure Kubernetes Service

    ```azurecli
    az aks delete --name <aks-name> --resource-group <resource-group>
    ```

1. Azure Container Registry

    ```azurecli
    az acr delete --name <acr-name>
    ```

1. Azure Text Analytics Service

    ```azurecli
    az cognitiveservices account delete --resource-group <resource-group> --name <service-name>
    ```
