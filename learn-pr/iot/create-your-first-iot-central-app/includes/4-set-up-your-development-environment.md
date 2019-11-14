In this unit, you will prepare the process to connect a real device to IoT Central. By "real" IoT Central understands that there is a remote app running - the app can be in a real device, taking input from real sensors, or running a simulation. Both options are treated as a connection to a real device.

The essential component for communication between a device and IoT Central is a _connection string_. There are some tools that make generating these strings easy. In this unit, you will access these tools in such as way that you can reuse them later on. To start with, you need some information on our real device.

## Add a real device

1. With your Refrigerated Truck app open in the [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true) portal, select **Devices** from the left-hand menu.

1. Open the **+** dropdown menu, and select **Real**.

    ![Screenshot showing how to create a real device, using the IoT Central portal](../media/refrigerated-trucks-new-real.png)

1. Leave the **Device ID** as is, and change the default **Device Name** to something readable ("Refrigerated Truck - 1"), and then select **Create**.

    ![Screenshot showing how to rename the real device to a friendly name](../media/refrigerated-trucks-new-real-create.png)

    When the device is created, you will notice the phrase "Missing Data" where the telemetry would normally be. Not until the device starts transmitting data will this phrase change.

1. Click on the **Connect** button for the device, top right of your screen. Take your time, and copy the **Scope ID**, **Device ID**, and **Primary Key**, to a text document, such as Notepad or TextEdit.

1. Save the text file. You will be using these values after installing and running a few utilities to generate connection strings.

1. In the IoT Central portal, click the **Close** button.

## Generate a connection string

All of the work to generate connection strings is handled through Azure Cloud Shell.

1. Navigate to the [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

1. In the Azure Cloud Shell, create a refrigerated-truck folder, and navigate to it:

    ```bash
    mkdir ~/refrigerated-truck
    cd ~/refrigerated-truck
    ```

1. Install the Device Provisioning System (DPS) key generator (_dps-keygen_), in the refrigerated-truck folder:

    ```bash
    npm install dps-keygen
    ```

1. Download and install a DPS connection string utility (_dps-cstr_) from GitHub:

    ```bash
    wget https://github.com/Azure/dps-keygen/blob/ota/bin/linux/dps_cstr?raw=true -O dps_cstr
    ```

    > [!NOTE]
    > You may have noticed in the above URL that you are downloading the Linux version of dps-cstr. This is needed to run in Azure Cloud Shell.

1. To give dps-cstr the correct permissions, run the following command:

    ```bash
    chmod +x dps_cstr
    ```

1. Remember that in the previous section you stored a **Scope ID**, **Device ID**, and **Primary Key**, for our device. It is a good idea to keep a text document such as Notepad open, and create in it the following string, replacing **{scope-id}**, **{device-id}**, and **{primary-key}** with your own values. Using the text document enables you to create and validate the string before committing to running it.

    ```bash
    ./dps_cstr {scope_id} {device_id} {primary_key} > connection1.txt
    ```

1. Now copy this command from your text document into the refrigerated-truck folder of Azure Cloud Shell, and run it.

1. Use the **{ }** icon in Azure Cloud Shell to navigate to the connection1.txt file. You will probably have to expand the **refrigerated-truck** node to locate it. Double-click on connection1.txt to open the file. Carefully copy all the contents to your text tool.

    ![Screenshot showing how to locate the connection1.txt file in the Azure Cloud Shell](../media/refrigerated-trucks-connection1.png)

    > [!IMPORTANT]
    > The last element of the connection string is the Primary Key. Verify that the connection string in your text file ends with an exact copy of the Primary Key, and if not, correct the copy you have made of the correction string in your text document.

1. The connection string you will use in the Node.js app (that follows in the next unit) starts with **HostName=**, so separate off this part of the string in your text document, so you have one line containing a string that looks similar to the following:

    ```js
    HostName=iotc-<your Scope ID>.azure-devices.net;DeviceId=<your Device ID>;SharedAccessKey=<your Primary Key>
    ```

1. Save off your text file.

You now have the all important connection string. The Scope ID identifies the app, the Device ID the real device, and the Primary Key gives you permission for the connection.

## Create a free Azure Maps account

If you do not already have an Azure Maps account, you will need to create one.

1. Navigate to [Azure Maps](https://azure.microsoft.com/services/azure-maps/?azure-portal=true).

1. Follow the prompts to create a free account. When your account is set up, you will need the **Subscription Key** for the account. Copy and paste this key into your text document, with a note that it applies to Azure Maps.

1. You can (optionally) verify your Azure Maps subscription key works. Save the following HTML to an .html file (after replacing the **subscriptionKey** entry with your own key) with any filename. Then, load the file in a web browser. Do you see a map of the world?

```html
<!DOCTYPE html>
<html>

<head>
    <title>Map</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Add references to the Azure Maps Map control JavaScript and CSS files. -->
    <link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css">
    <script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>

    <!-- Add a reference to the Azure Maps Services Module JavaScript file. -->
    <script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas-service.min.js"></script>

    <script>
        function GetMap() {
            //Instantiate a map object
            var map = new atlas.Map("myMap", {
                //Add your Azure Maps subscription key to the map SDK. Get an Azure Maps key at https://azure.com/maps
                authOptions: {
                    authType: 'subscriptionKey',
                    subscriptionKey: '<your Azure Maps subscription key>'
                }
            });
        }
    </script>
    <style>
        html,
        body {
            width: 100%;
            height: 100%;
            padding: 0;
            margin: 0;
        }

        #myMap {
            width: 100%;
            height: 100%;
        }
    </style>
</head>

<body onload="GetMap()">
    <div id="myMap"></div>
</body>

</html>
```

## Next steps

You have now completed the preparatory steps of connecting your first IoT Central app to real devices. The next step is to use the connection string in a Node.js app.
