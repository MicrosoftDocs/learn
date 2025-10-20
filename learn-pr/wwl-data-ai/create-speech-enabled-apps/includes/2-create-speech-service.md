
Before you can use Azure AI Speech, you need to create an Azure AI Speech resource in your Azure subscription. You can use either a dedicated Azure AI Speech resource or a multi-service Azure AI Services or Azure AI Foundry resource.

After you create your resource, you'll need the following information to use it from a client application through one of the supported SDKs:

- The *location* in which the resource is deployed (for example, *eastus*)
- One of the *keys* assigned to your resource.

You can view of these values on the **Keys and Endpoint** page for your resource in the Azure portal.

While the specific syntax and parameters can vary between language-specific SDKs, most interactions with the Azure AI Speech service start with the creation of a **SpeechConfig** object that encapsulates the connection to your Azure AI Speech resource.

For example, the following Python code instantiates a SpeechConfig object based on an Azure AI Speech resource in the East US region:

```python
import azure.cognitiveservices.speech as speech_sdk

speech_config = speech_sdk.SpeechConfig(your_project_key, 'eastus')
```

> [!NOTE]
> This example assumes that the Speech SDK package for python has been installed, like this:
>
> `pip install azure-cognitiveservices-speech`