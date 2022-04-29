With Azure Container Instances, you can launch single containers in Azure and use advanced functionality to address sophisticated networking and security requirements. 

Suppose you work at a network provider, and you're responsible for creating Application Programmable Interface (APIs) for your customers. These APIs are a premium service for which you charge your customers, so they need to be able to launch and stop their APIs on-demand. Once a customer has started an API, they're responsible for its life cycle. A critical requirement is that APIs are not exposed to the public Internet, and that a specific customer only has access to their own API.

Azure Container Instances offer an ideal platform for this type of applications:

- They're a purely on-demand infrastructure, offering very granular per-second billing
- Azure Container Instances offer quick startup times
- Azure Container Instances allow for very granular sizing
- Both Windows and Linux container images are supported

In this module, you'll learn some advanced tools that you can use with Azure Container Instances.

## Learning objectives

By the end of this module, you'll be able to:

- Deploy Azure Container Instances in Azure Virtual Networks
- Configure the Azure Container Instances using YAML (Yet Another Markup Language)
- Include sidecar containers in the YAML definition
- Include initialization containers in the YAML definition
- Integrate with an Azure PaaS service using Private Link
