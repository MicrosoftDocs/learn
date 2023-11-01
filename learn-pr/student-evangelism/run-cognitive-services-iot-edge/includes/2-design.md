In this module, you'll run Azure AI services on an edge device with Azure IoT Edge.

## High-level goals

- **Run offline if needed**: Leverage the advantages of Azure IoT Edge.
- **Run Cognitive Services APIs**: The characteristics of Docker containers enable you to run Azure AI services APIs on the edge.
- **Focus on language detection**: You'll deploy a Docker container to the edge device that uses the Text Analytics API. This API enables you to detect which language the input text is written in.

## The steps you'll follow

1. Create an IoT hub
2. Create an IoT Edge device
3. Create an Azure resource for Text Analytics
4. Configure your Language Detection container with the Azure AI services keys
5. Set the Language Detection container on to the edge device
6. Test your cognitive service

By the end of the module, you'll deploy a module to an edge device, which uses Azure AI services in a container. It will analyze text and detect the language of the text on the edge. You'll test your Text Analytics API in the browser. Consider the scenario outlined previously. In this scenario, for a disaster zone, you were tasked with managing donated medical supplies from a variety of countries/regions. By using cognitive API capabilities like language detection on an edge device, you can rapidly determine the origin (source) of the medicine, even when the internet connectivity is non-existent.
