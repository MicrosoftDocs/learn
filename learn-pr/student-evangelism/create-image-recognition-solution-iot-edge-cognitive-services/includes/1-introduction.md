Azure IoT Edge allows you to move your workloads from the cloud to the edge and run locally on the edge devices where your data is being generated. Transferring workloads to the edge fit in well with services that process a lot of data, such as computer vision models. The Cognitive Services with IoT Edge let you build a solution and deploy them to IoT devices as containers. Together, these two services enable you to find insights from images or video streams without transferring all data off-site first. 

Suppose you work as a Data Scientist and are responsible for deploying Cognitive Services that implement the image recognition function for self-checkouts used in supermarkets. To enable visually impaired people to use the self-checkout, the system should also include an image to speech capability. The system will validate the scanned item image against a pre-trained machine learning model to identify the item scanned. The scanned item will then be weighed, and the cost will be calculated depending on the identification. This approach means that the visually impaired person does not need to look at the item. Using text to speech functionality, the customer will be informed by an audio message that the item has been scanned. The business logic for the image recognition module will reside in the device. The system will identify the scanned item and convert a label of the image to speech. You could build and train the image recognition module in the cloud, dedicated to a given domain, and deploy it as a container to the device.

In this module, you'll run an Azure IoT Edge solution that uses Custom Vision and Speech Services and deploy the solution to the Edge device. The application consists of several modules that scan the items using a camera, classifies the scanned items, and converts the identified items to speech. By the end of this module, you'll be able to connect IoT devices to the cognitive service and deploy your solution to the IoT Edge device. The application will start telling you what items have been scanned.

## Learning objectives

- Use a pre-trained image classification module with Azure Cognitive Services

- Deploy your solution to the IoT Edge using VS Code

- Verify a module that running successfully

## Prerequisites

- Basic knowledge of IoT Edge

- Basic knowledge of Cognitive Services

- Azure subscription

- Simulated Azure IoT Edge device (such as a PC)

- USB Camera