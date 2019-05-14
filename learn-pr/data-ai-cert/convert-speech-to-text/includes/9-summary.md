The Speech Translation API lets you add end-to-end, real-time, multilanguage translation of speech to your applications, tools, and devices. The same API can be used for both speech-to-speech and speech-to-text translation.

With the Speech Translation API, client applications stream speech audio to the Speech service and receive back a stream of results. These results include the recognized text in the source language and its translation in the target language. Interim translations can be provided until an utterance is complete, at which time a final translation is provided.

For true speech-to-speech translation, a synthesized audio version of the final translation can also be prepared. The Speech Translation API uses the WebSocket protocol to provide a full-duplex communication channel between the client and the server. But you don't need to deal with WebSocket connections because the Speech SDK handles that for you.

The Speech Translation API uses the same technologies that power various Microsoft products and services. This service is already used by thousands of businesses worldwide in their applications and workflows.

## Cleanup

To avoid any unexpected costs in your Azure account, delete the **mslearn-speechapi** resource group. Deleting this group will remove all the resources we created in this module. Here are the steps you need to take:

1. In the left menu in the Azure portal, select **Resource groups**, and then find the **mslearn-speechapi** resource group.

1. Select the resource group, and either right-click the row or use the **ellipsis** (...) button at the end of the row to open the context menu.

1. Select **Delete resource group**.

1. Enter the name of the **mslearn-speechapi** resource group, and then select **Delete**. Azure will remove all the resources for you.