::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=277ddb64-b658-4338-8e59-4d78b7ece007]

::: zone-end

::: zone pivot="text"

A Foundry resource and project is sufficient for using Azure Language in Foundry portal, but you will need an additional *Language resource* to use the Azure Language SDK. You can create a Language resource in the Azure portal, or programmatically in a [command line interface (CLI)](/cli/azure/get-started-with-azure-cli?view=azure-cli-latest).  

![Screenshot of the Azure portal with the marketplace open to the Language resource.](../media/azure-portal-create-resource.png)

When you create a Language resource, Azure creates an *endpoint* for Azure Language. The endpoint is the address to a specific cloud service or model. We can find the Language service endpoint and key in the Azure portal. 

![Screenshot of a Language resource in the Azure portal with the key and endpoint page open.](../media/azure-portal-credentials.png)

When you run your application code, your application sends a request, or call, to the endpoint. The call can be sent using the REST API or SDK. The service returns a response, such as key phrases detected, in a format known as JSON. 

>[!NOTE]
>You can review foundational material on [applications and using endpoints here](/training/modules/get-started-with-ai-in-azure/5-endpoints?pivots=text).

The **Azure Language SDK** is a set of programming libraries that let your application talk to Azure’s Language Services. You would use the SDK when writing applications in **Python**, **JavaScript**, **C#**, or **Java**.

## Use the Azure Language Python SDK 

Let's see how you can use the Azure Language Python SDK to build an application that analyzes a document. 

To use the Azure Language Python SDK, you need to have compatible version of Python and the Azure Language Python SDK installed. 

Application code is written in *code editors*, such as Visual Studio Code. A code editor’s *terminal* is a built‑in command‑line window inside the editor where you can run commands without leaving your development environment.  

The Python SDK can be installed in the Visual Studio Code *terminal* using: 

```bash
pip install azure-ai-textanalytics
```

In the code editor, we can create one text file, and one Python file which contains application code. 
![Screenshot of Visual Studio Code with a text file open.](../media/python-sdk-text-analysis-0.png)

At the start of the application code, import the SDK. 

```python
from azure.ai.textanalytics import TextAnalyticsClient
from azure.core.credentials import AzureKeyCredential
```

![Screenshot of Visual Studio Code with a Python file open with a focus on the client object created.](../media/python-sdk-text-analysis-1.png)

Then we use our Language resource endpoint and key to create an authenticated **client object**, the tool your code uses to communicate with a service. The client object knows the service's endpoint, carries credentials (like keys or tokens), exposes methods (for example: `analyze_sentiment()`), and handles sending requests and receiving responses under the hood.

We use the client's methods to call Azure Language functions. For example, we can extract key phrases with `client.extract_key_phrases()`, recognize entities with the function `client.recognize_entities()`, and analyze sentiment with `client.analyze_sentiment()`. To generate a summary, we need to use an asynchronous technique to begin the summarization task and retrieve the results. 
![Screenshot of Visual Studio Code with a Python file open with a focus on the text analysis functions.](../media/python-sdk-text-analysis-2.png)

We can display the results of the analysis by running the application code in the terminal with the command `python <file_name>.py`. When we run the app, it uses Azure Language in our Foundry resource to perform each of the tasks. 
![Screenshot of Visual Studio Code with the terminal open with a focus on the results.](../media/python-sdk-text-analysis-3.png)

## Examples of code to use with the Azure Language Python SDK 

Take a look at examples of code that can be used with the Azure Python SDK for the same text analysis tasks found in the previous unit. Regardless of the text analysis feature used, a client is needed to call the feature.      

```python
# Import packages
import os
from azure.core.credentials import AzureKeyCredential
from azure.ai.textanalytics import TextAnalyticsClient

# Create a client 
endpoint = os.environ["AZURE_LANGUAGE_ENDPOINT"]
key = os.environ["AZURE_LANGUAGE_KEY"]

client = TextAnalyticsClient(endpoint=endpoint, credential=AzureKeyCredential(key))
```

#### Key phrase extraction 

```python
text = "I had a fantastic meal at the Foundry diner in Seattle on Saturday. The mushroom risotto was perfectly prepared, and really tasty. Our waiter, Pete, was friendly and efficient; and gave us a great recommendation for a dessert (strawberry cheesecake). I'd definitely recommend this place for a casual dinner."

result = client.extract_key_phrases([text])[0]

print("Key phrases:")
for phrase in result.key_phrases:
    print("-", phrase)
```

#### Entity extraction 

```python
text = "I had a fantastic meal at the Foundry diner in Seattle on Saturday. The mushroom risotto was perfectly prepared, and really tasty. Our waiter, Pete, was friendly and efficient; and gave us a great recommendation for a dessert (strawberry cheesecake). I'd definitely recommend this place for a casual dinner."

result = client.recognize_entities([text])[0]

for entity in result.entities:
    print(f"{entity.text} | category={entity.category} | confidence={entity.confidence_score}")
```

#### Sentiment analysis

```python
text = "I had a fantastic meal at the Foundry diner in Seattle on Saturday. The mushroom risotto was perfectly prepared, and really tasty. Our waiter, Pete, was friendly and efficient; and gave us a great recommendation for a dessert (strawberry cheesecake). I'd definitely recommend this place for a casual dinner."

result = client.analyze_sentiment([text])[0]

print("Sentiment:", result.sentiment)
print("Confidence scores:", result.confidence_scores)
```

#### Summarization

In the Python SDK, **extractive summarization** is done as a long‑running action. 

```python
from azure.ai.textanalytics import ExtractiveSummaryAction

text = (
    "I had a fantastic meal at the Foundry diner in Seattle on Saturday. The mushroom risotto was perfectly prepared, and really tasty. Our waiter, Pete, was friendly and efficient; and gave us a great recommendation for a dessert (strawberry cheesecake). I'd definitely recommend this place for a casual dinner."
)

poller = client.begin_analyze_actions(
    documents=[text],
    actions=[ExtractiveSummaryAction(max_sentence_count=2)]
)

# Wait for the operation to finish and print the summary sentences
for doc_actions in poller.result():
    extractive_results = doc_actions[0]  # first (and only) document
    for action_result in extractive_results:
        if action_result.is_error:
            print("Error:", action_result.code, action_result.message)
        else:
            print("Summary sentences:")
            for sentence in action_result.sentences:
                print("-", sentence.text)
```

With Foundry and the Azure Language SDK, you can write code for AI applications that process natural language text and generate insight from your documents. Next, let's take a look at how to include Azure Language capabilities in AI agents.  

::: zone-end
