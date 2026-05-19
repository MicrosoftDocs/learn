Each function in Azure Functions has exactly one trigger. The trigger invokes the function and provides data needed by the function. A function can optionally use one or more input and output bindings. Bindings connect resources to the function. Input bindings pass data into function parameters, while output bindings declaratively write data from the function to other services. Triggers and bindings help you to avoid hardcoding access to other services.

Considering the scenario detailed in the introduction, you can implement a solution using Azure Functions and an image-analysis service that's suited to manufacturing quality inspection. For example, you can use Azure Content Understanding image analyzers for schema-based image extraction and classification, including manufacturing quality-control scenarios such as detecting defects and anomalies, or train a custom image classification or object detection model with Azure Machine Learning automated ML (AutoML). The Azure components of the solution are built from managed Azure services and event-driven functions, so you can combine existing components and rapidly deploy a system based on your business logic.

The solution is based on three functions:

- Process newly uploaded images and extract product quality signals for fault detection.

- Save successfully processed images and related metadata for further training.

- Save images and metadata marked for review.

The solution uses:

- Azure Event Grid

- Azure Blob Storage

- Azure Content Understanding or Azure Machine Learning AutoML image models

- Azure Cosmos DB for NoSQL

- Azure Queue Storage

- Cameras

Cameras or applications upload images from the production line to Azure Blob Storage in a storage account kind that supports Blob Storage events. Use StorageV2 (general-purpose v2) for most workloads. Use BlockBlobStorage only for premium block blob workloads. Configure an Event Grid subscription to route `Microsoft.Storage.BlobCreated` events to the Event Grid-triggered function. Event Grid sends event metadata, such as the blob URL and event type, to the function.

The function reads the image bytes from Azure Blob Storage by using a Blob input binding or the Storage SDK. Blob input bindings use configured container and blob paths with binding expressions; they don't consume arbitrary blob URLs directly. If the event or queue message contains only a URL, parse the URL in code to get the container and blob name for the binding path, or use the Azure Storage SDK to read the blob. The function calls Azure Content Understanding or a deployed Azure Machine Learning model from code to check for defects or anomalies, and can send an email notification by using the SendGrid output binding. SendGrid is a supported external email integration that requires configuration, including a SendGrid API key; it isn't a managed Azure service. For downstream steps, the function routes messages to distinct Azure Queue Storage queues, such as one queue for high-confidence results and another queue for review-needed results. Each message contains the blob reference, quality result, confidence, and other metadata, while the image files remain in Azure Blob Storage.

## Triggers and Bindings

| Azure Functions                                              | Triggers                                                     | Input Binding or data read | Output Binding or action                 |
| ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------- | ---------------------------------------- |
| Process incoming images and extract products in them for fault detection | Event Grid trigger: an Event Grid subscription delivers a `Microsoft.Storage.BlobCreated` event from a supported Azure Blob Storage account to the function. | Event metadata includes a blob URL. The function uses the container and blob name in a Blob input binding path, or reads the blob with the Storage SDK. | Function code calls Azure Content Understanding or a deployed Azure Machine Learning AutoML image model. A SendGrid output binding can send email, and separate Azure Queue Storage output bindings can send image references, quality results, and confidence metadata to high-confidence and review-needed queues. |
| Save successfully processed images and related metadata for further training | Azure Queue Storage trigger: a message from the high-confidence results queue identifies a high-confidence image result. | Azure Queue Storage message contains the container name, blob name, result, confidence, and metadata. A Blob input binding that maps to those values or the Storage SDK can read the image if needed. | Azure Blob Storage output binding saves training images; Azure Cosmos DB for NoSQL output binding stores JSON metadata and classification result documents in a container. |
| Save images and metadata marked for review                   | Azure Queue Storage trigger: a message from the review-needed results queue identifies a low-confidence or review-needed image result. | Azure Queue Storage message contains the container name, blob name, result, confidence, and metadata. A Blob input binding that maps to those values or the Storage SDK can read the image if needed. | Azure Blob Storage output binding saves review images; Azure Cosmos DB for NoSQL output binding stores JSON review metadata documents in a container. |
