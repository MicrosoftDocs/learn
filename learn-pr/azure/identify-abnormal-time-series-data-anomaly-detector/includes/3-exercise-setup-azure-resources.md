The first thing you'll need to successfully complete the exercises in this module is to set up the Azure resources. 

In this exercise, you'll run a setup script to create the Azure IoT Hub service to connect the household smart meter devices to the cloud. The Azure IoT Hub will be routing the raw data to an Azure blob storage.  Then finally you'll be creating an Azure Anomaly Detector instance to analyze the data.

These are Azure services to understand before we start:
- _Azure IoT Hub_ is a communication channel for sending and receiving data between smart devices and the cloud. 
- _Azure Blob storage_ is used to store massive amounts of unstructured data. It helps you create data lakes for your analytics workloads. It's useful for storing the raw data we'll collect from the Azure IoT Hub.

### Set up a Blob storage, IoT Hub, and Anomaly Detector instance

Manually creating and configuring a Blob storage, IoT Hub and Anomaly Detector instance can take some time. To save time, you can use a Bash setup script, which is available on GitHub. Follow these instructions to create the Azure resources you need with Azure CLI commands script.

1.	In the sandbox, clone the following setup script using Azure Cloud Shell
    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-detect-anomalies-in-realtime.git
    ```
2.	To run the setup script, run the following commands
    ```bash
    cd mslearn-detect-anomalies-in-realtime
    chmod +x setup.sh
    bash setup.sh
    ```
![Diagram displaying blob iot and anomaly detector resources](..\media\3-exercise-setup-azure-resources-1.png)

The setup script will take a few minutes for the following resources to be created:
- Storage Account to manage your Blob storage
- Storage Container in the Storage Account to manage your files 
- IoT Hub to receive and send message from devices
- Device registration to the IoT Hub
- IoT Hub configuration to route message to a target storage.  In this case, your Blob storage.
- Anomaly Detector API instance

After the script completes, copy the following fields from the script output for later use in the lab exercises.
- **BLOB_CONNECTION_STRING**
- **IOTHUB_DEVICE_CONNECTION_STRING**
- **ANOMALY_DETECTOR_NAME**
- **API_KEY_ANOMALY DETECTOR**

## Verify that the Storage account, IoT Hub and Anomaly Detector were created

Now, you need to verify that the resources are set up correctly.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **Resource groups** on the Left navigation page. The **Resource groups** pane appears.

2. Select the resource group: **learn-######-####-###** on the **Resource groups** pane appears.

    ![Diagram displaying Azure portal left navigation pane](..\media\3-exercise-setup-azure-resources-2.png)
    
3. In the list of resources, you show see the following resource instances: **anomaly######**, **myLearnIoTHub######** and **store######**.

 [   ![Diagram displaying list of resources on Azure portal in the Resource Group](..\media\3-exercise-setup-azure-resources-3.png) ](..\media\3-exercise-setup-azure-resources-3.png#lightbox)


