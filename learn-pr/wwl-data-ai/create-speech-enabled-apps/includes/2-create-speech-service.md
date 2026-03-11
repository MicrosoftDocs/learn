
Azure Speech in Foundry Tools is a set of speech-related capabilities that are provided by a Foundry resource. You can use these capabilities to add speech support to apps and agents built in Microsoft Foundry projects. For example:

- Creating an application to transcribe recorded calls or meetings.
- Creating an AI assistant that can read text messages or emails aloud.

:::image type="content" source="../media/azure-speech.png" alt-text="Diagram showing an Azure Speech resource performing speech-to-text and text-to-speech functions.":::

## Using Azure Speech in a Microsoft Foundry resource

To use Azure Speech in Foundry Tools, you must provision a Microsoft Foundry resource in your Azure subscription.

After you have provisioned a Foundry resource in your Azure subscription, you can use its **endpoint** to call the Azure Language APIs from your code, authenticating requests by providing the **key** associated with your resource. You can call the Azure Language APIs by submitting requests in JSON format to the REST interface, or by using any of the available programming language-specific SDKs.

> [!NOTE]
> The code examples in this module are based in Python, using the [Python SDK for Azure Speech in Foundry Tools](https://pypi.org/project/azure-cognitiveservices-speech/). SDKs for other common languages (such as Microsoft C#, JavaScript, and others) follow a similar pattern.

### Creating a SpeechConfig

The initial object you need to create to provide access to the Azure Speech in Foundry Toole endpoint is a **SpeechConfig** object; which encapsulates the connection details for the service in your Foundry resource.

> [!TIP]
> The default home page in the Foundry portal shows the endpoint and key for your *project*. To view the key and endpoint for your *resource*, you can view the parent resource for your project in the **Admin** tab of the **Operate** page of the portal. The project and foundry resource keys are the same, and the project endpoint is the resource endpoint with */api/projects/{project_name}* appended - so if the project endpoint is `https://my-ai-app-foundry.services.ai.azure.com/api/projects/my-ai-app`, then the resource endpoint is `https://my-ai-app-foundry.services.ai.azure.com`.

For example, the following Python code creates a **SpeechConfig** object that can be used to submit requests to Azure Speech APIs in a Foundry resource.

```python
# run "pip install azure-cognitiveservices-speech" first to install the package 
import azure.cognitiveservices.speech as speech_sdk

# Create SpeechConfig using endpoint and key
speech_config = speech_sdk.SpeechConfig(subscription="YOUR_FOUNDRY_KEY",
                                        endpoint="YOUR_FOUNDRY_ENDPOINT")
```

> [!NOTE]
> Releases of the Python SDK prior to **1.48.2** required that you specify the *region* where your resource is deployed instead of the endpoint. With the latest release, you can use either the Foundry resource endpoint or the region.
