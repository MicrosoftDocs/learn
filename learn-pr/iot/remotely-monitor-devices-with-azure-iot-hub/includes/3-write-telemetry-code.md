The coding in this module is broken down into three parts: sending and receiving telemetry, sending and receiving a direct method, and managing digital twins.

At the end of this unit, you will be sending and receiving telemetry.

## Create an app to send telemetry

::: zone pivot="vscode"

1. Open Visual Studio Code. From the **Terminal** menu, open a **New Terminal**.

1. In the opened terminal, create an empty folder where you will develop your code, called "CheeseCave", by entering `mkdir CheeseCave`. Then, navigate to that folder with `cd CheeseCave`.

1. From the **File** menu, create a new file. Insert a single line as a comment, such as `// Cheese Cave device app`. Save the file to the "CheeseCave" folder (locating this folder might involve a bit of navigation), with the name "app.js". By using the .js file extension, Visual Studio Code interprets this file as JavaScript and evaluates the contents with the JavaScript language service.

1. Back in the terminal, enter **npm install azure-iot-device**. When this package has installed, enter **npm install azure-iot-digitaltwins-service**. Then enter **npm install chalk**.

1. After you have entered the code below into the app.js file, you can run it from the terminal by entering `node app.js`. Ensure that the CheeseCave folder is the current folder of the terminal, when you run the app.

::: zone-end
::: zone pivot="vstudio"

1. Navigate to the **JavaScript** project types, and create a new **Blank Node.js Console Application** project, called "CheeseCave".

    ![Screenshot showing how to create the blank Node.js Visual Studio project](../media/cheesecave-vs-project.png)

1. In the **Solution Explorer** tab, right click **npm**, and select **Install New npm Packages**. Install **azure-iot-device**, **azure-iot-digitaltwins-service**, and **chalk**.

    ![Screenshot showing how to install npm packages into your Visual Studio project](../media/cheesecave-vs-npm.png)

1. Delete the default contents of the app.js file. Add the line `// Cheese Cave device app`.

1. When you have entered the code below, you will be able to run the app with the **Start Without Debugging**, or **Start Debugging**, options. In the latter case, you can set breakpoints, examine data, and perform other debugging tasks.

::: zone-end

### Add code to send telemetry

This section adds code to send telemetry from a simulated device. The device sends temperature (in degrees centigrade) and humidity (in percentages) regardless of whether any back-end app is listening or not.

1. With the **app.js** file open, copy and paste the following code.

``` JavaScript

```

1. Replace the &lt;your device connection string&gt; with the device connection string you saved off in the previous unit. No other lines of code need to be changed.

### Test your code to send telemetry

1. For Visual Studio, select **Debug/Start Without Debugging**. For Visual Studio Code, in a terminal, navigate to the "CheeseCave" folder, and type `node app.js`.
1. You should quickly get a console screen, similar to the following image. Note the use of the chalk utility to set some text to green. If you do not get a screen similar to this, check your device connection string carefully.

    ![Screenshot showing the temperature and humidity telemetry being sent](../media/cheesecave-telemetry.png)

1. Watch the telemetry for a short while, checking that is it giving temperatures and humidity in the expected ranges.
1. You can leave this app running, as it is needed for the next section.

## Create a second app to receive telemetry

Now we have a device pumping out telemetry, we need to listen for that telemetry with a back-end app, also connected to our IoT Hub.

::: zone pivot="vscode"

1. Open Visual Studio Code. From the **Terminal** menu, open a **New Terminal**.

1. In the opened terminal, create an empty folder where you will develop your code, called "CheeseCaveOperator", by entering `mkdir CheeseCaveOperator`. Then, navigate to that folder with `cd CheeseCaveOperator`.

1. From the **File** menu, create a new file. Insert a single line as a comment, such as `// Cheese Cave Operator back-end app`. Save the file to the "CheeseCaveOperator" folder (locating this folder might involve a bit of navigation), with the name "app.js".

1. Back in the terminal, enter **npm install @azure/event-hubs**. When this package has installed, enter **npm install azure-iothub**. Then enter **npm install chalk**.

1. After you have entered the code below into the app.js file, you can run it from the terminal by entering `node app.js`. Ensure that the "CheeseCaveOperator" folder is the current folder of the terminal, when you run the app.

::: zone-end
::: zone pivot="vstudio"

1. Navigate to the **JavaScript** project types, and create a new **Blank Node.js Console Application** project, called "CheeseCaveOperator".

1. In the **Solution Explorer** tab, right click **npm**, and select **Install New npm Packages**. Install **@azure/event-hubs**, **azure-iothub**, and **chalk**.

1. Delete the default contents of the app.js file. Add a comment line such as `// Cheese Cave Operator back-end app`.

1. When you have entered the code below, you will be able to run the app with the **Start Without Debugging**, or **Start Debugging**, options.

::: zone-end

### Add code to receive telemetry

1. With the **app.js** file open, copy and paste the following code.

``` JavaScript

```

> [!NOTE]
> Our implementation only reads messages after the app has been started. Any telemetry sent prior to this is not handled.

1. Replace the &lt;your service connection string&gt; with the _service_ connection string you saved off in a text file, in the previous unit.

1. Replace the &lt;your device ID&gt; with the device ID from your text file (you may have used the suggested "CheeseCaveID").

### Test your code to receive telemetry

This is an important test in this module, testing whether your back-end app is picking up the telemetry being sent out by your simulated device. Remember that your device app is still running, and sending telemetry.

1. Using Visual Studio, select **Debug/Start Without Debugging**. In Visual Studio Code, enter `node app.js` from a terminal opened to the "CheeseCaveOperator" folder.
1. A second console window should open up, and immediately respond if it successfully connects to IoT Hub. If not, carefully check your IoT Hub service connection string, noting that this should be the _service_ connection string, and not any other.

    ![Screenshot showing the temperature and humidity telemetry being received](../media/cheesecave-telemetry-received.png)

1. Visually compare the telemetry sent and received. Is there an exact match? Is there much of a delay?

If everything is working so far, this is great progress. You have an app sending telemetry from a device, and a back-end app acknowledging  receipt of the data. This covers the _monitoring_ side of our scenario. The next step handles the _control_ side - what to do when there are issues with the data.
