A common scenario in an AI application is to connect to a generative AI model and use *prompts* to engage in a chat-based dialog with it.

While you can use the Azure OpenAI SDK, to connect "directly" to a model using key-based or Microsoft Entra ID authentication; when your model is deployed in an Azure AI Foundry project, you can also use the Azure AI Foundry SDK to retrieve a project client, from which you can then get an authenticated OpenAI chat client for any models deployed in the project's Azure AI Foundry resource. This approach makes it easy to write code that consumes models deployed in your project, switching between them easily by changing the model deployment name parameter.

> [!TIP]
> You can use the OpenAI chat client provided by an Azure AI Foundry project to chat with any model deployed in the associated Azure AI Foundry resource - even non-OpenAI models, such as Microsoft Phi models.

The following Python code sample uses the **get_openai_client()** method to get an OpenAI client with which to chat with a model that has been deployed in the project'a Azure AI Foundry resource.

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient
from openai import AzureOpenAI

try:
    
    # connect to the project
    project_endpoint = "https://......"
    project_client = AIProjectClient(            
            credential=DefaultAzureCredential(),
            endpoint=project_endpoint,
        )
    
    # Get a chat client
    chat_client = project_client.get_openai_client(api_version="2024-10-21")
    
    # Get a chat completion based on a user-provided prompt
    user_prompt = input("Enter a question:")
    
    response = chat_client.chat.completions.create(
        model=your_model_deployment_name,
        messages=[
            {"role": "system", "content": "You are a helpful AI assistant."},
            {"role": "user", "content": user_prompt}
        ]
    )
    print(response.choices[0].message.content)

except Exception as ex:
    print(ex)
```

> [!NOTE]
> In addition to the **azure-ai-projects** and **azure-identity** packages discussed previously, the sample code shown here assumes that the **openai** package has been installed:
>
> `pip install openai`
