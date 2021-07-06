The amusement park company you work for needed a Virtual Reality/Augmented Reality application that showcases the interactivity of a new park attraction. The application needs to simulate the experience of summoning a dragon in a virtual space, and it needs to be easily accessible via the web.

You and your team decided to fulfill these requirements by using Azure Speech-to-text, Babylon.js, and Azure Blob Storage to implement the application. Specifically, you:

* Used Azure Speech-to-text to recognize users' speech and check if they're saying the spell to summon the dragon.
* Enabled WebXR support in the Babylon.js web application so that the dragon-summoning activity can be done in Virtual Reality or Augmented Reality.
* Built and deployed the Babylon.js web application to the public web using Azure Blob Storage.

Without these technologies, it would have been difficult to showcase the park activity online. You and your team might have needed to train your own speech recognition model, work with the WebXR API in lower-level code, or set up your own server for hosting the website. Azure Speech, Babylon.js, and Azure Blob Storage allowed you and your team to create and deploy a voice activated WebXR application much more efficiently.

[!INCLUDE[](../../../includes/azure-sandbox-cleanup.md)]

## References

* Azure [Speech-to-text documentation](/azure/cognitive-services/speech-service/index-speech-to-text)
* [WebXR](https://doc.babylonjs.com/divingDeeper/webXR) documentation for Babylon.js
* [Azure Blob Storage documentation](/azure/storage/blobs)
