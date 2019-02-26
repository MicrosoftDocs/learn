The Speech Service API lets you add end-to-end, real-time, multi-language translation of speech to your applications, tools, and devices. The same API can be used for both speech-to-speech and speech-to-text translation.

With the Translator Speech API, client applications stream speech audio to the service and receive back a stream of results. These results include the recognized text in the source language and its translation in the target language. Interim translations can be provided until an utterance is complete, at which time a final translation is provided.

Optionally, a synthesized audio version of the final translation can be prepared, enabling true speech-to-speech translation. The Speech Translation API uses a WebSockets protocol to provide a full-duplex communication channel between the client and the server. But you don't need to deal with WebSockets; the Speech SDK handles that for you.

The Speech Translation API employs the same technologies that power various Microsoft products and services. This service is already used by thousands of businesses worldwide in their applications and workflows.

## Cleanup

To avoid any unexpected costs in your Azure account, delete the **mslearn-speechapi** resource group. This will remove all of the resources we created in this module. Here's the steps you need to do.

1. Find the **mslearn-speechapi** resource group. Select **Resource groups** in the Azure sidebar to quickly locate it.

1. Select the resource group and either right-click on the row, or use the "..." button on the far-right side of the row to open the context menu.

1. Select **Delete resource group**.

1. Type the name of the resource group and click **Delete**. Azure will de-provision all of the resources for you.