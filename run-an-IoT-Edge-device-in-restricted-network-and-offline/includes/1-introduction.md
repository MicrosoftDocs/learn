Run an IoT Edge device in restricted network and offline.

Azure IoT Edge supports extended offline operations on IoT Edge devices, and also enables offline operations on non-IoT Edge child devices. Said IoT Edge device and any child devices can continue to function with intermittent or no internet connection so long as the IoT Edge device has had one opportunity to connect to IoT Hub.

The IoT Edge hub takes on three roles when an IoT Edge device goes into offline mode. First, it stores any upstream messages and saves them until the device reconnects. Second, it acts on behalf of IoT Hub to authenticate modules and child devices so that they can continue to operate. Third, it enables communication between child devices that normally would go through IoT Hub.

## Learning objectives

In this module you will:

- Verify Lab Prerequisites
- Create an IoT Hub and Device ID
- Deploy Azure IoT Edge Enabled Linux VM
- Setup IoT Edge Parent with Child IoT Devices
- Configure IoT Edge Device as Gateway
- Open IoT Edge Gateway Device Inbound Ports using Azure CLI
- Configure IoT Edge Device Time-to-Live and Message Storage
- Connect Child IoT Device to IoT Edge Gateway
- Test Device Connectivity and Offline Support

## Prerequisites

- An introductory knowledge of the purpose of Azure IoT
- Ability to navigate Azure IoT portal
- Ability to use Node.js, or C#, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level

This lab assumes the following resources are available:
- Resource Group -- AZ-220-RG
- IoT Hub -- AZ-220-HUB-_{YOUR-ID}_
- IoT Device -- SimulatedThermostat

If the resources are unavailable, please execute the **lab-setup.azcli** script before starting the lab.

Note: You will need the SimulatedDevice connection string. You can obtain that by running the following command in the Azure Cloud Shell
 
```bash
az iot hub device-identity show-connection-string --hub-name AZ-220-HUB-_{YOUR-ID}_ --device-id SimulatedThermostat -o tsv
```

## The scenario

Retailer Tailwind Trader's conveyor belt system monitors vibrations, telemetry, and counts objects. They want their system to be resilient to network outages and also optimize the bulk upload of telemetry data at specific times in the day (load balancing network usage). Your job will be to configure IoT Edge to support offline in case network drops and look into storing telemetry from sensors locally and configure for regular syncs at given times.

In this module, you will learn the different scenarios where IoT Edge device is on an enterprise network (needs proxy settings) or needs extended offline capabilities to address the scenario above

## Task 1: Execute Setup Script

1. If necessary, log in to your Azure portal using your Azure account credentials.  If you have more than one Azure account, be sure that you are logged in with the account that is tied to the subscription that you will be using for this course.

1. Open the Azure Cloud Shell by clicking the **Terminal** icon within the top header bar of the Azure portal, and select the Bash shell option.

1. Before the Azure CLI can be used with commands for working with Azure IoT Hub, the Azure IoT Extensions need to be installed. To install the extension, run the following command:

    ```bash
     az extension add --name azure-cli-iot-ext
    ```

1. To upload the setup script, in the Azure Cloud Shell toolbar, click **Upload/Download** files (fourth button from the right).

1. In the dropdown, select **Upload** and in the file selection dialog, navigate to the **lab-setup.azcli** file for this lab. Select the file and click **Open** to upload it.

    A notification will appear when the file upload has completed.

1. You can verify that the file has uploaded by listing the content of the current directory by entering the **ls** command.

1. To create a directory for this lab, move lab-setup.azcli into that directory, and make that the current working directory, enter the following commands:

    ```bash
     mkdir lab14
     mv lab-setup.azcli lab14
     cd lab14
```

1. To ensure the **lab-setup.azcli** has the execute permission, enter the following commands:

    ```bash
     chmod +x lab-setup.azcli
    ```

9. To edit the lab-setup.azcli file, click { } (Open Editor) in the toolbar (second button from the right). In the Files list, select lab14 to expand it and then select lab-setup.azcli.

    The editor will now show the contents of the lab-setup.azcli file.

10. In the editor, update the values of the {YOUR-ID} and Location variables. Set {YOUR-ID} to the Unique ID you created at the start of this course - i.e. **CP123019**, and set Location to the location that makes sense for your resources.

    **Note:** The Location variable should be set to the short name for the location. You can see a list of the available locations and their short-names (the Name column) by entering this command:

    ```CLI
    az account list-locations -o Table
    ```

    ```bash
    DisplayName           Latitude    Longitude    Name
    --------------------  ----------  -----------  ------------------
    East Asia             22.267      114.188      eastasia
    Southeast Asia        1.283       103.833      southeastasia
    Central US            41.5908     -93.6208     centralus
    East US               37.3719     -79.8164     eastus
    East US 2             36.6681     -78.3889     eastus2
    ```

11. To save the changes made to the file and close the editor, click … in the top-right of the editor window and select Close Editor.

    If prompted to save, click Save and the editor will close.

    **Note:** You can use CTRL+S to save at any time and CTRL+Q to close the editor.

12. To create a resource group named AZ-220-RG, create an IoT Hub named AZ-220-HUB-{YourID}, add a device with a Device ID of SimulatedThermostat, and display the device connection string, enter the following command:

    ```bash
     ./lab-setup.azcli
    ```

    This will take a few minutes to run. You will see JSON output as each step completes.

13. Once complete, the connection string for the device, starting with “HostName=”, is displayed. Copy this connection string into a text document and note that it is for the **SimulatedThermostat** device.
