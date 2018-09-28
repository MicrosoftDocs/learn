Azure IoT Central is a fully managed Internet of Things (IoT) solution that makes it easy to connect, monitor, and manage your global IoT assets.

Here, you'll follow the scenario in which a remote coffee machine is connected to Azure IoT Central for monitoring and management of issues. You can monitor telemetry such as water temperature and humidity, observe the state of your machine, set optimal temperature, receive warranty status, and send commands. If the warranty is expired when the water temperature is outside the expected range, an email from IoT Central is sent to the client’s maintenance department for further action.

You'll begin by a creating a device in Azure IoT Central that defines the data and commands that can be exchanged with the IoT device.

In this module, you will:
  - Create an Azure IoT Central custom application
  - Create and define your device template
  - Connect a coffee machine simulator to your application in Azure IoT Central
  - Validate your connection and data flow
  - Configure rules for maintenance notifications
 
## Sign in to Azure IoT Central
In this unit, you sign in to IoT Central to create a new custom application. A 7-day trial is sufficient to complete this module. 

1. Navigate to the Azure IoT Central [Application Manager](https://aka.ms/iotcentral?azure-portal=true) page. 

1. On the sign-in page, enter the email address and password that you use to access your Microsoft account.

## Create a new custom application

1. To create a new Azure IoT Central application, choose **New Application**. 

1. On the **Create Application** page: 
    * Choose **Free** for the payment plan
    * Select **Custom Application** as the application template
    * Choose a friendly application name, like **Coffee Maker 01-A**
    * (Optionally) edit the URL - this will be required if the name you selected is already in use
    * Choose **Create**
