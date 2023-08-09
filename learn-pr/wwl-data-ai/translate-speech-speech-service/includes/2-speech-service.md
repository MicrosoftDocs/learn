
The Speech service provides robust, machine learning and artificial intelligence-based speech translation services, enabling developers to add end-to-end, real-time, speech translations to their applications or services.

Before you can use the Speech service, you need to create a Speech resource in your Azure subscription. You can use either a dedicated **Speech** resource or a multi-service **Cognitive Services** resource.

After creating your Azure resource, you will need the following information to use it from a client application through one of the supported SDKs:

- The *location* in which the resource is deployed (for example, *eastus*)
- One of the *keys* assigned to your resource.

You can view of these values on the **Keys and Endpoint** page for your resource in the Azure portal.

> [!NOTE]
> If you are currently using *Bing Speech* or the older *Translator Speech* API, Microsoft offers migration strategies for bringing your applications over to the Speech service.  Your Translator Speech access keys will not work on the new Speech services endpoints, which necessitate a migration to the new services.
>
> See the following resources for more information:
>
> - [Migrate from Bing Speech](/azure/cognitive-services/speech-service/how-to-migrate-from-bing-speech)
> - [Migrate from Translator Speech API](/azure/cognitive-services/speech-service/how-to-migrate-from-translator-speech-api)
