With the growing popularity of the public cloud, it's become increasingly common for customers to upload their on-premises data to Azure for at-scale analytics using Azure Machine Learning. In many cases, customers want to be able to preprocess such data on-premises. This preprocessing can be beneficial to obtain immediate feedback based on a preliminary analysis, to limit the volume of data upload, or to filter out potentially sensitive data to prevent it from leaving the internal network. Contoso's research application that uses Machine Learning (ML) to process and analyze customer data and then upload it to Azure storage for long-term archival, is an example of one of these scenarios. You can address such a need by using Azure Stack Edge. In this unit you learn what Azure Stack Edge is, when to use it, and what its benefits are.

## What is Azure Stack Edge

Azure Stack Edge allows you to perform processing and ML-based inferencing of on-premises data and upload it to Azure by using a purpose-built, Microsoft-provided appliance residing in an on-premises location. Microsoft offers such appliances on a subscription basis, and in several different form factors, which facilitates a wide range of deployment scenarios. Including such environments as retail stores, field hospitals, rural clinics, factory floors, and disaster areas.

Azure Stack Edge supports generic virtualized and containerized workloads but is optimized for processing and analyzing data at the edge, and transferring results to the cloud. Azure Stack Edge focuses on processing, analyzing, and transferring data, rather than implementing a wide range of virtualized and containerized workloads. To provide these specialized capabilities, Azure Stack Edge offers appliances that are Graphical Processing Unit (GPU)-based, or Field Programmable Gate Array (FPGA)-based. Along with a Vision Processing Unit (VPU), these appliances enable accelerated Artificial Intelligence-inferencing, and provide the network storage gateway functionality.

> [!NOTE]
> In the simplest terms, you can think of Azure Stack Edge as a pre-built, specialized appliance that you can use to process and analyze data in edge locations and transfer it to Azure.

> [!NOTE]
> Unlike Azure Stack Hub and Azure Stack HCI, Azure Stack Edge appliances are available directly from Microsoft on a subscription basis.

An Azure Stack Edge implementation consists of the following main components:

|Component|Description|
|---|---|
|An Azure Stack Edge physical appliance|An appliance that customers place in their on-premises edge locations to function as a network storage gateway, which is accessible via a local share. The appliance also offers GPU or FGPA-based compute capabilities, which provide accelerated AI inferencing for Machine Learning (ML) models. The local compute uses containers in a managed Kubernetes environment to process data. These containers can be deployed and managed either via IoT Hub using the Azure IoT system or with Arc enabled Kubernetes. In both cases, there's end to end integration. The integration allows you to create the local Kubernetes environment, access the GPU or VPU acceleration, and connect to IoT Hub or Arc enabled Kubernetes.|An Azure Stack Edge resource accessible via the Azure portal|This resource allows you to administer and monitor multiple Azure Stack Edge physical appliances. Including, the management of their local shares hosting the data being processed and transferred to Azure Storage. Additionally, the Azure Stack Edge resource allows you to configure the compute role on the Azure Stack Edge appliance that manages data processing.|
|An Azure Stack Edge local web user interface (UI)|This UI provides a direct connection to individual Azure Stack Edge appliances. The connection facilitates initial installation and supporting management capabilities. Such as, restarting the appliance or reviewing and copying local logs.|

:::image type="content" source="../media/5-azure_stack_edge.png" alt-text="Azure Stack Edge is an appliance that contains local edge compute resources, local storage, and hardware acceleration. It collects on-premises data, transfers it to Azure, and relies on cloud resources such as Azure IoT Hub, Azure Stack Edge, and Azure Storage for long-term storage." border="false":::

## Common use cases of Azure Stack Edge

Azure Stack Edge combines three groups of capabilities into the same physical appliance. Representing its role as a data processing unit, deployment target for accelerated AI inferencing models, and a data gateway. These roles correspond to the three main use cases of Azure Stack Edge:

|Use case|Description|
|---|---|
|Data processing|You can use Azure Stack Edge to transform data to optimize its subsequent transfer, streamline subsequent analytics, or remove content deemed sensitive from a security or privacy standpoint. It's possible to accomplish some or all of these objectives through data aggregation, filtering, and deduplication. Additionally, data processing might also involve analyzing and responding to IoT events.|
|Inferencing with Azure Machine Learning models|You can use Azure Stack Edge to run ML models before transferring data to the cloud. You might still want to consider performing transfer of the full data set to retrain and optimize ML models using cloud resources.|
|Transferring on-premises data to Azure|You can use Azure Stack Edge to facilitate continuous transfer of on-premises data to Azure Storage for longer term retention or further processing and analytics.|

While it's possible to implement inferencing following data transfer, shifting the compute tasks to an Azure Stack Edge appliance offers several benefits:

- Immediate response to results generated by ML models within the Azure Stack Edge appliance, without having to wait for data transfer to Azure.
- Minimized amount of data being transferred to Azure storage, resulting in cost and bandwidth savings.
- Automatic encryption of data at rest and in transit, Azure Stack Edge appliance encrypts locally stored data with BitLocker transferring to Azure Storage over HTTPS.

Choose the best response for each of the following questions, and then select **Check your answers**.
