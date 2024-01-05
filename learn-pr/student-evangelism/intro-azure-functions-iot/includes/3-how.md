An Azure function has two parts: **triggers and bindings**. A function has a specific single trigger. The trigger invokes the function. Triggers provide data needed by the function. Bindings connect resources to the function. Data from bindings is provided to the function as parameters. You could have input and output bindings for a function. Triggers and bindings help you to avoid hardcoding access to other services. 

Considering the scenario detailed in the introduction, you can implement a solution using Azure Functions and Cognitive APIs. This solution scales well if needed due to the nature of serverless applications. It's built from pre-existing solutions. Using Azure Functions, you can combine these existing components and rapidly deploy a system based on your business logic.

The solution is based on three Azure functions:

- Process incoming images and extract products in them for fault detection.

- Save successfully processed images for further training.

- Save images marked for review.

The solution uses:

- Azure Event Grid

- Azure Storage Blob

- Azure AI Vision

- Cosmos DB database

- Cameras

Azure Event Grid orchestrates the solution. It receives images from cameras in the production line. The function “Process incoming images and extract products in them for fault detection” uses Azure Cognitive APIs to check if the images have faults. If a fault is detected, then a notification is sent by email. Some images are sent for review by the “Save images marked for review” function. Finally, the images successfully processed are saved by the “Save successfully processed images for further training" function.

## Triggers and Bindings

| Azure Functions                                              | Triggers                                                     | Input Binding | Output Binding                           |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------- | ---------------------------------------- |
| Save successfully processed images for further training      | Event Grid: Event Grid is used to read an image from another Azure function marked as faulty or non-faulty with high confidence. Image is stored in queue for use in future training. | Message queue | Cosmos DB                                |
| Save images marked for review                                | Event Grid: Event Grid is used to read an image from another Azure function marked as faulty or non-faulty with low confidence. Image is stored in queue for manual review. | Message Queue | Blob storage                             |
| Process incoming images and extract products in them for fault detection | Event Grid: Event Grid is used to read an image from Blob Storage | Blob storage  | Computer Vision API and SendGrid (email) |
