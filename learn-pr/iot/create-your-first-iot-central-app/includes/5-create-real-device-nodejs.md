In this unit, you are going to create a programming project to simulate a sensor device in a refrigerated truck. This simulation enables you to test the code long before requiring a real truck! IoT Central treats this simulation as "real" because the communication code between the device app and the IoT Central app would be the same for a real truck. In other words, in a real situation (where you run a refrigerated truck company), you would start with simulated code similar to that in this unit, and, after it worked to your satisfaction, the simulation specific code would be replaced with real code. And the communication code would remain the same. This latter fact makes writing the following code a valuable experience.

## Create the device app

Using your preferred development environment, build the device sensor app. Visual Studio Code and Visual Studio examples are available in this unit.

::: zone pivot="vscode-node"

Node.js is a platform for building server apps, based on JavaScript. All the JavaScript code you will need is provided below, so you do not need to be a JavaScript developer to get this app up and running.

1. Open Visual Studio Code. From the **Terminal** menu, open a **New Terminal**.

1. In the opened terminal, create an empty folder where you will develop your code, called "RefrigeratedTrucks", by entering `mkdir RefrigeratedTrucks`. Then, navigate to that folder with `cd RefrigeratedTrucks`.

1. From the **File** menu, create a new file. Insert a single line as a comment, such as `// Refrigerated Truck app`. Save the file to the "RefrigeratedTrucks" folder (locating this folder might involve a bit of navigation), with the name "app.js". By using the .js file extension, Visual Studio Code interprets this file as JavaScript and evaluates the contents with the JavaScript language service.

    ![Screenshot showing how to save the JavaScript file, in Visual Studio Code](../media/refrigerated-trucks-vscode.png)

1. Back in the terminal, enter **npm install azure-iot-device**. When this package has installed, enter **npm install azure-maps-rest**.

1. After you have entered the code below into the app.js file, you can run it from the terminal by entering `node app.js`. Ensure that the RefrigeratedTrucks folder is the current folder of the terminal, when you run the app.

::: zone-end
::: zone pivot="vscode-csharp"

1. To use C# in Visual Studio Code, ensure both [.NET Core](https://dotnet.microsoft.com/download), and the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) are installed.

1. Open a terminal in Visual Studio Code, and create a folder called "cheesecavedevice" (enter `mkdir cheesecavedevice`). Navigate to the cheesecavedevice folder.

1. Enter the following command in the terminal: `dotnet new console`. This command creates a Program.cs file in your folder, along with a project file.

1. Enter `dotnet restore` in the terminal. This command gives your app access to the required .NET packages.

1. In the terminal, install the required libraries. Enter:
    * **dotnet add package AzureMapsRestToolkit**
    * **dotnet add package Microsoft.Azure.Devices.Shared**
    * **dotnet add package Newtonsoft.Json**

1. From the **File** menu, open up the Program.cs file, and delete the default contents.

1. After you've entered the code below into the Program.cs file, you can run the app with the command `dotnet run`. This command will run the Program.cs file in the current folder, so ensure you are in the cheesecavedevice folder.

::: zone-end
::: zone pivot="vs-node"

1. Navigate to the **JavaScript** project types, and create a new **Blank Node.js Console Application** project, called "RefrigeratedTruck".

    ![Screenshot showing how to create a new blank Node.js project, in Visual Studio](../media/refrigerated-trucks-vs-project.png)

1. Install azure-iot-device and azure-maps-rest npm packages by right-clicking on the **npm** entry in Solution Explorer, and select **Install New npm Packages...**.

1. In the dialog that follows, search for and install **azure-iot-device**, then **azure-maps-rest**.

    ![Screenshot showing how to add an npm package, in Visual Studio](../media/refrigerated-trucks-vs-npm.png)

1. Delete the default contents of the app.js file.

1. When you have entered the code below, you will be able to run the app with the **Start Without Debugging**, or **Start Debugging**, options. In the latter case you can set breakpoints, examine data, and perform other debugging tasks.

::: zone-end
::: zone pivot="vs-csharp"

1. Open Visual Studio, and create a new **Visual C#/Windows Desktop** project. Select **Console App (.NET Framework)**.

1. Give the project a friendly name, such as "CheeseCaveDevice".

1. Under **Tools/NuGet Package Manager**, select **Manage NuGet Packages for Solution**. Install the following libraries:
    * **AzureMapsRestToolkit**
    * **Microsoft.Azure.Devices.Shared**
    * **Newtonsoft.Json**

1. Delete the default contents of the Program.cs file.

1. Add all the code that follows to the Program.cs file.

::: zone-end

## Write the device app

::: zone pivot="vs-node,vscode-node"

In the blank app.js file, insert the following code. Each additional section of code should be appended to the end of the file, in the order listed here.

   > [!NOTE]
   > If you would like to skip this unit, and load all of the code into your app, then download and copy all of the contents of app.js from [MicrosoftDocs/mslearn-your-first-iot-central-app](https://github.com/MicrosoftDocs/mslearn-your-first-iot-central-app) into the app.js file of your project. If you copy this code (and replace the connection and subscription strings) then go straight to the next unit, and start testing!

1. Add code to connect to Azure IoT Central and Azure Maps, replacing the `<your...>` strings for both technologies with your own strings. Do not change any other lines of code.

    ```js
    "use strict";

    const truckNum = 1;

    var truckIdentification = "Truck number " + truckNum;

    var connectionString;

    switch (truckNum) {
        case 1:
            connectionString = "<your IoT Central connection string for truck 1>";
            break;

        // You will be adding more trucks in a later unit....
    }

    console.log("Starting " + truckIdentification);

    // Use the Azure IoT device SDK for devices that connect to Azure IoT Central.
    var clientFromConnectionString = require('azure-iot-device-mqtt').clientFromConnectionString;
    var Message = require('azure-iot-device').Message;
    var rest = require("azure-maps-rest")

    var subscriptionKeyCredential = new rest.SubscriptionKeyCredential("<your Azure Maps Account Subscription Key>");

    var pipeline = rest.MapsURL.newPipeline(subscriptionKeyCredential);

    var routeURL = new rest.RouteURL(pipeline);

    var client = clientFromConnectionString(connectionString);
    ```

    > [!NOTE]
    > An Azure Maps `Pipeline` class contains the HTTP request policies. You are using the default policies in this app, so provide only our key as a parameter. A `RouteURL` class represents a URL to the Azure Maps route operations, which takes our pipeline as a parameter.

1. Add global variables.

    ```js
    // Truck globals initialized to the starting state of the truck.

    // Enums in javascript can be represented by frozen name:value pairs.
    var stateEnum = Object.freeze({ "ready": "ready", "enroute": "enroute", "delivering": "delivering", "returning": "returning", "loading": "loading", "dumping": "dumping" });
    var contentsEnum = Object.freeze({ "full": "full", "melting": "melting", "empty": "empty" });
    var fanEnum = Object.freeze({ "on": "on", "off": "off", "failed": "failed" });

    const deliverTime = 600;            // Time to complete delivery, in seconds.
    const loadingTime = 800;            // Time to load contents.
    const dumpingTime = 400;            // Time to dump melted contents.
    const tooWarmThreshold = 2;         // Degrees C that is too warm for contents.
    const tooWarmtooLong = 60;          // Time in seconds for contents to start melting if temps are above threshold.

    var timeOnCurrentTask = 0;          // Time on current task, in seconds.
    var interval = 60;                  // Simulated time interval, in seconds.
    var tooWarmPeriod = 0;              // Time that contents are too warm, in seconds.
    var temp = -2;                      // Current temp of contents, in degrees C.
    var baseLat = 47.644702;            // Base position latitude.
    var baseLon = -122.130137;          // Base position longitude.
    var currentLat = baseLat;           // Current position latitude.
    var currentLon = baseLon;           // Current position longitude.
    var destinationLat;                 // Destination position latitude.
    var destinationLon;                 // Destination position longitude.

    var fan = fanEnum.on;               // Cooling fan state.
    var contents = contentsEnum.full;   // Truck contents state.
    var state = stateEnum.ready;        // Truck is full and ready to go!
    var optimalTemperature = -5;        // Setting - can be changed by the operator from IoT Central.

    const noEvent = "none";
    var conflict = noEvent;              // Event: set to a warning if a conflicting command received.
    var newCustomerId = noEvent;         // Event: set when a new customer Id is received.

    var customer = [                    // Lat/lon position of customers.
        // Gasworks Park
        [47.645892, -122.336954],

        // Golden Gardens Park
        [47.688741, -122.402965],

        // Seward Park
        [47.551093, -122.249266],

        // Lake Sammamish Park
        [47.555698, -122.065996],

        // Marymoor Park
        [47.663747, -122.120879],

        // Meadowdale Beach Park
        [47.857295, -122.316355],

        // Lincoln Park
        [47.530250, -122.393055],

        // Gene Coulon Park
        [47.503266, -122.200194],

        // Luther Bank Park
        [47.591094, -122.226833],

        // Pioneer Park
        [47.544120, -122.221673]
    ];

    var path = [];                      // Lat/lon steps for the route.
    var timeOnPath = [];                // Time in seconds for each section of the route.
    var truckOnSection;                 // The current path section the truck is on.
    var truckSectionsCompletedTime;     // The time the truck has spent on previous completed sections.
    ```

1. Add the functions to get a route via Azure Maps.

    ```js
    function Degrees2Radians(deg) {
        return deg * Math.PI / 180;
    }

    function DistanceInMeters(lat1, lon1, lat2, lon2) {
        var dlon = Degrees2Radians(lon2 - lon1);
        var dlat = Degrees2Radians(lat2 - lat1);

        var a = (Math.sin(dlat / 2) * Math.sin(dlat / 2)) + Math.cos(Degrees2Radians(lat1)) * Math.cos(Degrees2Radians(lat2)) * (Math.sin(dlon / 2) * Math.sin(dlon / 2));
        var angle = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        var meters = angle * 6371000;
        return meters;
    }

    function Arrived() {
        // If the truck is within 10 meters of the destination, call it good.
        if (DistanceInMeters(currentLat, currentLon, destinationLat, destinationLon) < 10)
            return true;
        return false;
    }

    function UpdatePosition() {
        while ((truckSectionsCompletedTime + timeOnPath[truckOnSection] < timeOnCurrentTask) && (truckOnSection < timeOnPath.length - 1)) {

            // Truck has moved onto the next section.
            truckSectionsCompletedTime += timeOnPath[truckOnSection];
            ++truckOnSection;
        }

        // Ensure remainder is 0 to 1, as interval may take count over what is needed.
        var remainderFraction = Math.min(1, (timeOnCurrentTask - truckSectionsCompletedTime) / timeOnPath[truckOnSection]);

        // The path should be one entry longer than the timeOnPath array.
        // Find how far along the section the truck has moved.
        currentLat = path[truckOnSection][0] + remainderFraction * (path[truckOnSection + 1][0] - path[truckOnSection][0]);
        currentLon = path[truckOnSection][1] + remainderFraction * (path[truckOnSection + 1][1] - path[truckOnSection][1]);
    }

    function GetRoute(newState) {
        // Set the state to ready, until the new route arrives.
        state = stateEnum.ready;

        // Note coordinates are longitude first.
        var coordinates = [
            [currentLon, currentLat],
            [destinationLon, destinationLat]
        ];

        var results = routeURL.calculateRouteDirections(rest.Aborter.timeout(10000), coordinates);

        results.then(data => {
            console.log("Number of points = " + JSON.stringify(data.routes[0].legs[0].points.length, null, 4));

            // Clear the path.
            path.length = 0;

            // Start with the current location.
            path.push([currentLat, currentLon]);

            // Retrieve the route and push the points onto the array
            for (var n = 0; n < data.routes[0].legs[0].points.length; n++) {
                var x = data.routes[0].legs[0].points[n].latitude;
                var y = data.routes[0].legs[0].points[n].longitude;

                path.push([x, y]);
            }

            // Finish with the destination.
            path.push([destinationLat, destinationLon]);

            console.log(JSON.stringify(path, null, 4));

            // Store the path length and time taken, to calculate the average speed.
            var meters = data.routes[0].summary.lengthInMeters;
            var seconds = data.routes[0].summary.travelTimeInSeconds;
            var pathSpeed = meters / seconds;

            var distanceApartInMeters;
            var timeForOneSection;

            // Clear the time on path array.
            timeOnPath.length = 0;

            // Calculate how much time is required for each section of the path.
            for (var t = 0; t < path.length - 1; t++) {
                // Calculate distance between the two path points, in meters.
                distanceApartInMeters = DistanceInMeters(path[t][0], path[t][1], path[t + 1][0], path[t + 1][1]);

                // Calculate the time for each section of the path.
                timeForOneSection = distanceApartInMeters / pathSpeed;
                timeOnPath.push(timeForOneSection);
            }
            truckOnSection = 0;
            truckSectionsCompletedTime = 0;
            timeOnCurrentTask = 0;

            // Update the state now the route has arrived. One of: enroute or returning.
            state = newState;
        }, reason => {
            // Error: The request was aborted.
            console.log(reason);
            conflict = "Failed to find map route";
        });
    }
    ```

    > [!NOTE]
    > It is important to grasp the asynchronous nature of calls to Azure Maps, the call to the `calculateRouteDirections` function will end immediately after it is called while your app is waiting for the results from Azure Maps. When the results are returned from Azure Maps, the method passed in to `results.then(...)` will be called with the resulting route.

1. Add the command to deliver to a customer.

    ```js
    function CmdGoToCustomer(request, response) {
        // Pick up variables from the request payload, with the field name specified in IoT Central.
        var num = request.payload.customerId;

        if (num >= 0 && num < customer.length) {
            // What to do depends on the state of the truck.
            switch (state) {
                case stateEnum.dumping:
                case stateEnum.loading:
                case stateEnum.delivering:
                    conflict = "Unable to act - " + state;
                    break;
                case stateEnum.ready:
                case stateEnum.enroute:
                case stateEnum.returning:
                    if (contents === contentsEnum.empty) {
                        conflict = "Unable to act - empty";
                    }
                    else {
                        // Set event only when all is good.
                        newCustomerId = num;

                        destinationLat = customer[num][0];
                        destinationLon = customer[num][1];

                        // Find route from current position to destination, storing the route.
                        GetRoute(stateEnum.enroute);
                    }
                    break;
            }
        }
        else {
            // Send an event message if an invalid customer number has been received.
            conflict = "Invalid customer: " + num;
        }

        // Acknowledge the command.
        response.send(200, 'Success', function (errorMessage) {
            // Failure
            if (errorMessage) {
                console.error('Failed sending a CmdGoToCustomer response:\n' + errorMessage.message);
            }
        });
    }
    ```

    > [!NOTE]
    > The statement `var num = request.payload.customerId;` shows how data (text, numbers, toggles, dates) are passed from the IoT Central app in a command. Note, too, that the device responds with a conflict if it is not in the correct state, and that the command itself is acknowledged at the end of the function. The recall command that follows in the next step handles things very similarly.

1. Add the recall command.

    ```js
    function ReturnToBase() {
        destinationLat = baseLat;
        destinationLon = baseLon;

        // Find route from current position to base, storing route.
        GetRoute(stateEnum.returning);
    }

    function CmdRecall(request, response) {
        switch (state) {
            case stateEnum.ready:
            case stateEnum.loading:
            case stateEnum.dumping:
                conflict = "Already at base";
                break;

            case stateEnum.returning:
                conflict = "Already returning";
                break;

            case stateEnum.delivering:
                conflict = "Unable to recall - " + state;
                break;

            case stateEnum.enroute:
                ReturnToBase();
                break;
        }

        // Acknowledge the command.
        response.send(200, 'Success', function (errorMessage) {
            // Failure
            if (errorMessage) {
                console.error('Failed sending a CmdRecall response:\n' + errorMessage.message);
            }
        });
    }
    ```

1. Add the function that updates the truck simulation at each time interval.

    ```js
    function dieRoll(max) {
        return Math.random() * max;
    }

    function UpdateTruck() {
        if (contents == contentsEnum.empty) {
            // Turn the cooling system off, if possible, when the contents are empty.
            if (fan == fanEnum.on) {
                fan = fanEnum.off;
            }
            temp += -2.9 + dieRoll(6);
        }
        else {
            // Contents are full or melting.
            if (fan != fanEnum.failed) {
                if (temp < optimalTemperature - 5) {
                    // Turn the cooling system off, as contents are getting too cold.
                    fan = fanEnum.off;
                }
                else {
                    if (temp > optimalTemperature) {

                        // Temp getting higher, turn cooling system back on.
                        fan = fanEnum.on;
                    }
                }

                // Randomly fail the cooling system.
                if (dieRoll(100) < 1) {
                    fan = fanEnum.failed;
                }
            }

            // Set the contents temperature. Maintaining a cooler temperature if the cooling system is on.
            if (fan === fanEnum.on) {
                temp += -3 + dieRoll(5);
            }
            else {
                temp += -2.9 + dieRoll(6);
            }

            // If the temperature is above a threshold, count the seconds this is occurring, and melt the contents if it goes on too long.
            if (temp >= tooWarmThreshold) {
                // Contents are warming.
                tooWarmPeriod += interval;

                if (tooWarmPeriod >= tooWarmtooLong) {

                    // Contents are melting.
                    contents = contentsEnum.melting;
                }
            }
            else {
                // Contents are cooling.
                tooWarmPeriod = Math.max(0, tooWarmPeriod - interval);
            }
        }

        timeOnCurrentTask += interval;

        switch (state) {
            case stateEnum.loading:
                if (timeOnCurrentTask >= loadingTime) {

                    // Finished loading.
                    state = stateEnum.ready;
                    contents = contentsEnum.full;
                    timeOnCurrentTask = 0;

                    // Repair/turn on the cooling fan.
                    fan = fanEnum.on;
                    temp = -2;
                }
                break;

            case stateEnum.ready:
                timeOnCurrentTask = 0;
                break;

            case stateEnum.delivering:
                if (timeOnCurrentTask >= deliverTime) {

                    // Finished delivering.
                    contents = contentsEnum.empty;
                    ReturnToBase();
                }
                break;

            case stateEnum.returning:
                // Update the truck position.
                UpdatePosition();

                // Check to see if the truck has arrived back at base.
                if (Arrived()) {
                    switch (contents) {

                        case contentsEnum.empty:
                            state = stateEnum.loading;
                            break;

                        case contentsEnum.full:
                            state = stateEnum.ready;
                            break;

                        case contentsEnum.melting:
                            state = stateEnum.dumping;
                            break;
                    }
                    timeOnCurrentTask = 0;
                }
                break;

            case stateEnum.enroute:
                // Update truck position.
                UpdatePosition();

                // Check to see if the truck has arrived at the customer.
                if (Arrived()) {
                    state = stateEnum.delivering;
                    timeOnCurrentTask = 0;
                }
                break;

            case stateEnum.dumping:
                if (timeOnCurrentTask >= dumpingTime) {

                    // Finished dumping.
                    state = stateEnum.loading;
                    contents = contentsEnum.empty;
                    timeOnCurrentTask = 0;
                }
                break;
        }
    }
    ```

    > [!NOTE]
    > This function is called every time interval. The actual time interval is set later on (at 5 seconds), though the "simulated time" (the number of seconds you specify that has passed each time this function is called) is set by the global `var interval = 60`, which means the simulation runs at a rate of 60 divided by 5, or 12 times the speed of real time. To lower the simulated time, reduce the `var interval` to, say, 30 (for a simulation that runs at six times real-time). Setting `var interval = 5` would run the simulation in real-time (which would be a bit slow, given the real driving times to the customer destinations).

1. Add the function to send truck telemetry and events, if any have occurred.

    ```js
    // Send device simulated telemetry measurements.
    function sendTruckTelemetry() {
        // Simulate the truck.
        UpdateTruck();

        // Create the telemetry data JSON package.
        var data = JSON.stringify(
            {
                // Format is:
                // Field name from IoT Central app ":" variable name from Node.js app.
                temperature: temp,
                stateTruck: state,
                stateCoolingSystem: fan,
                stateContents: contents,
                location: {
                    // Names must be lon, lat.
                    lon: currentLon,
                    lat: currentLat
                },
            });

        // Add the conflict event string, if there is one.
        if (conflict != noEvent) {
            data += JSON.stringify(
                {
                    eventConflict: conflict,
                }
            );
            conflict = noEvent;
        }

        // Add the new customer event string, if there is one.
        if (newCustomerId != noEvent) {
            data += JSON.stringify(
                {
                    eventCustomer: newCustomerId,
                }
            );
            newCustomerId = noEvent;
        }

        // Create the message with the above defined data
        var message = new Message(data);

        console.log("Message: temp = " + temp);

        // Send the message
        client.sendEvent(message, function (errorMessage) {
            // Error
            if (errorMessage) {
                console.log('Failed to send message to Azure IoT Central: ${err.toString()}');
            }
        });
    }
    ```

    > [!NOTE]
    > The `sendTruckTelemetry` is an important function, handling the sending of telemetry, states, and events to IoT Central. Note the use of JSON strings to send the data, and that an acknowledgement message is sent at the end of the function.

1. Add the code to handle settings and properties. You only have one setting and one property in our app, though if there are more, they are easily added.

    ```js
    // Send device properties once to the IoT Central app.
    function sendDeviceProperties(deviceTwin) {
        var properties =
        {
            // Format is:
            // <Property field name in Azure IoT Central> ":" <value in Node.js app>
            truckId: truckIdentification,
        };

        console.log(' * Property - truckId: ' + truckIdentification);

        deviceTwin.properties.reported.update(properties, (errorMessage) =>
            console.log(` * Sent device properties ` + (errorMessage ? `Error: ${errorMessage.toString()}` : `(success)`)));
    }

    // Object containing all the device settings.
    var settings = {
        // Format is:
        // '<field name from Azure IoT Central>' ":" (newvalue, callback) ....
        //  <variable name in Node.js app> = newValue;
        //  callback(<variable name in Node.js app>,'completed');
        'optimalTemperature': (newValue, callback) => {
            setTimeout(() => {
                optimalTemperature = newValue;
                callback(optimalTemperature, 'completed');
            }, 1000);
        }
    };

    // Handle settings changes that come from Azure IoT Central via the device twin.
    function handleSettings(deviceTwin) {
        deviceTwin.on('properties.desired', function (desiredChange) {
            // Iterate all settings looking for the defined one.
            for (let setting in desiredChange) {
                // Found the specified setting.
                if (settings[setting]) {
                    console.log(` * Received setting: ${setting}: ${desiredChange[setting].value}`);

                    // Update the setting.
                    settings[setting](desiredChange[setting].value, (newValue, status, message) => {
                        var patch =
                        {
                            [setting]:
                            {
                                value: newValue,
                                status: status,
                                desiredVersion: desiredChange.$version,
                                message: message
                            }
                        }
                        deviceTwin.properties.reported.update(patch, (err) => console.log(` * Sent setting update for ${setting} ` +
                            (err ? `error: ${err.toString()}` : `(success)`)));
                    });
                }
            }
        });
    }
    ```

    > [!NOTE]
    > This section of code is generic to most Node.js apps that communicate with IoT Central. To add additional settings or properties, add name pairs to the variables `var settings` and `var properties` respectively. No other code changes are usually needed.

1. Add the connection callback function. This function is called when the Node.js app first attempts to contact IoT Central.

    ```js
    // Handle device connection to Azure IoT Central.
    var connectCallback = (errorMessage) => {
        // Connection error
        if (errorMessage) {
            console.log(`Device could not connect to Azure IoT Central: ${errorMessage.toString()}`);
        }
        // Successfully connected
        else {
            // Notify the user
            console.log('Device successfully connected to Azure IoT Central');

            // Send telemetry measurements to Azure IoT Central every 5 seconds.
            setInterval(sendTruckTelemetry, 5000);

            // Set up device command callbacks
            client.onDeviceMethod('cmdGoTo', CmdGoToCustomer);
            client.onDeviceMethod('cmdRecall', CmdRecall);

            // Get device twin from Azure IoT Central
            client.getTwin((errorMessage, deviceTwin) => {
                // Failed to retrieve device twin.
                if (errorMessage) {
                    console.log(`Error getting device twin: ${errorMessage.toString()}`);
                }
                else {
                    // Notify the user of the successful link.
                    console.log('Device Twin successfully retrieved from Azure IoT Central');

                    // Send device properties once on device startup.
                    sendDeviceProperties(deviceTwin);

                    // Apply device settings and handle changes to device settings.
                    handleSettings(deviceTwin);
                }
            });
        }
    };
    ```

    > [!NOTE]
    > Most of the `connectCallback` function is generic, and can be used for most Node.js apps that communicate with IoT Central. Specific to this app are the two `client.onDeviceMethod` calls that link JavaScript functions in this app to the commands in the IoT Central app, and the `setInterval(sendTruckTelemetry, 5000);` call, which specifies the `sendTruckTelemetry` function should be called every five seconds (5,000 milliseconds).

1. Complete the app with the single line to start the device, specifying the connection callback.

    ```js
    // Start the device,and connect it to Azure IoT Central.
    client.open(connectCallback);
    ```

::: zone-end
::: zone pivot="vs-csharp,vscode-csharp"

In the blank app.js file, insert the following code. Each additional section of code should be appended to the end of the file, in the order listed here.

   > [!NOTE]
   > If you would like to skip this unit, and load all of the code into your app, then download and copy all of the contents of Program.cs from [MicrosoftDocs/mslearn-your-first-iot-central-app](https://github.com/MicrosoftDocs/mslearn-your-first-iot-central-app) into the Program.cs file of your project. If you copy this code (and replace the connection and subscription strings) then go straight to the next unit, and start testing!

1. Add the `using` statement, including for Azure IoT Central and Azure Maps.

   ```cs
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using Microsoft.Azure.Devices.Client;
    using Microsoft.Azure.Devices.Shared;
    using Microsoft.Azure.Devices.Provisioning.Client;
    using Microsoft.Azure.Devices.Provisioning.Client.Transport;
    using Newtonsoft.Json;
    using AzureMapsToolkit;
    using AzureMapsToolkit.Common;
    ```

    > [!NOTE]
    > tbd

1. Add the namespace, class, and global variables.

   ```cs
    namespace refrigerated_truck
    {
        class Program
        {
            enum StateEnum
            {
                ready,
                enroute,
                delivering,
                returning,
                loading,
                dumping
            };
            enum ContentsEnum
            {
                full,
                melting,
                empty
            }
            enum FanEnum
            {
                on,
                off,
                failed
            }
    
            // Azure maps service globals.
            static AzureMapsServices azureMapsServices;
    
            // Telemetry globals.
            const int intervalInMilliseconds = 5000;        // Time interval required by wait function.
    
            // Refrigerated truck globals.
            const int truckNum = 1;
            static string truckIdentification = "Truck number " + truckNum;
    
            const double deliverTime = 600;                 // Time to complete delivery, in seconds.
            const double loadingTime = 800;                 // Time to load contents.
            const double dumpingTime = 400;                 // Time to dump melted contents.
            const double tooWarmThreshold = 2;              // Degrees C that is too warm for contents.
            const double tooWarmtooLong = 60;               // Time in seconds for contents to start melting if temps are above threshold.
    
            static double timeOnCurrentTask = 0;            // Time on current task in seconds.
            static double interval = 60;                    // Simulated time interval in seconds.
            static double tooWarmPeriod = 0;                // Time that contents are too warm in seconds.
            static double tempContents = -2;                // Current temp of contents in degrees C.
            static double baseLat = 47.644702;              // Base position latitude.
            static double baseLon = -122.130137;            // Base position longitude.
            static double currentLat;                       // Current position latitude.
            static double currentLon;                       // Current position longitude.
            static double destinationLat;                   // Destination position latitude.
            static double destinationLon;                   // Destination position longitude.
    
            static FanEnum fan = FanEnum.on;                // Cooling fan state.
            static ContentsEnum contents = ContentsEnum.full;    // Truck contents state.
            static StateEnum state = StateEnum.ready;       // Truck is full and ready to go!
            static double optimalTemperature = -5;          // Setting - can be changed by the operator from IoT Central.
    
            const string noEvent = "none";
            static string conflict = noEvent;               // Event: set to a warning if a conflicting command received.
            static string newCustomerId = noEvent;          // Event: set when a new customer ID is received.
    
            static double[,] customer = new double[,]
            {                    
                // Lat/lon position of customers.
                // Gasworks Park
                {47.645892, -122.336954},
    
                // Golden Gardens Park
                {47.688741, -122.402965},
    
                // Seward Park
                {47.551093, -122.249266},
    
                // Lake Sammamish Park
                {47.555698, -122.065996},
    
                // Marymoor Park
                {47.663747, -122.120879},
    
                // Meadowdale Beach Park
                {47.857295, -122.316355},
    
                // Lincoln Park
                {47.530250, -122.393055},
    
                // Gene Coulon Park
                {47.503266, -122.200194},
    
                // Luther Bank Park
                {47.591094, -122.226833},
    
                // Pioneer Park
                {47.544120, -122.221673 }
            };
    
            static double[,] path;                          // Lat/lon steps for the route.
            static double[] timeOnPath;                     // Time in seconds for each section of the route.
            static int truckOnSection;                      // The current path section the truck is on.
            static double truckSectionsCompletedTime;       // The time the truck has spent on previous completed sections.
            static Random rand;
    
            // IoT Central global variables.
            static DeviceClient s_deviceClient;
            static CancellationTokenSource cts;
            static string GlobalDeviceEndpoint = "global.azure-devices-provisioning.net";
            static TwinCollection reportedProperties = new TwinCollection();
    
            // User IDs.
            static string ScopeID = "0ne000A0BF1";
            static string DeviceID = "truck-cs-112";
            static string PrimaryKey = "kPX9seMWzjKyU5fs4eY3iYEz5TnShhtRkqfU85sCh60=";
            static string AzureMapsKey = "-Sg7hD_YKJo9i2H9AbNKkrcCesoLicHEZ4AOP7cP7ao";
    ```

1. Add the functions to get a route via Azure Maps.

   ```cs
         static double Degrees2Radians(double deg)
        {
            return deg * Math.PI / 180;
        }

        // Returns the distance in meters between two locations on Earth.
        static double DistanceInMeters(double lat1, double lon1, double lat2, double lon2)
        {
            var dlon = Degrees2Radians(lon2 - lon1);
            var dlat = Degrees2Radians(lat2 - lat1);

            var a = (Math.Sin(dlat / 2) * Math.Sin(dlat / 2)) + Math.Cos(Degrees2Radians(lat1)) * Math.Cos(Degrees2Radians(lat2)) * (Math.Sin(dlon / 2) * Math.Sin(dlon / 2));
            var angle = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
            var meters = angle * 6371000;
            return meters;
        }

        static bool Arrived()
        {
            // If the truck is within 10 meters of the destination, call it good.
            if (DistanceInMeters(currentLat, currentLon, destinationLat, destinationLon) < 10)
                return true;
            return false;
        }

        static void UpdatePosition()
        {
            while ((truckSectionsCompletedTime + timeOnPath[truckOnSection] < timeOnCurrentTask) && (truckOnSection < timeOnPath.Length - 1))
            {
                // Truck has moved onto the next section.
                truckSectionsCompletedTime += timeOnPath[truckOnSection];
                ++truckOnSection;
            }

            // Ensure remainder is 0 to 1, as interval may take count over what is needed.
            var remainderFraction = Math.Min(1, (timeOnCurrentTask - truckSectionsCompletedTime) / timeOnPath[truckOnSection]);

            // The path should be one entry longer than the timeOnPath array.
            // Find how far along the section the truck has moved.
            currentLat = path[truckOnSection,0] + remainderFraction * (path[truckOnSection + 1,0] - path[truckOnSection,0]);
            currentLon = path[truckOnSection,1] + remainderFraction * (path[truckOnSection + 1,1] - path[truckOnSection,1]);
        }

        static void GetRoute(StateEnum newState)
        {
            // Set the state to ready, until the new route arrives.
            state = StateEnum.ready;

            var req = new RouteRequestDirections
            {
                Query = $"{currentLat},{currentLon}:{destinationLat},{destinationLon}"
            };
            var directions = azureMapsServices.GetRouteDirections(req).Result;

            if (directions.Error != null || directions.Result == null)
            {
                // Handle any error.
                redMessage("Failed to find map route");
            }
            else
            {
                int nPoints = directions.Result.Routes[0].Legs[0].Points.Length;
                greenMessage($"Route found. Number of points = {nPoints}");

                // Clear the path. Add two points for the start point and destination.
                path = new double[nPoints + 2, 2];
                int c = 0;

                // Start with the current location.
                path[c, 0] = currentLat;
                path[c, 1] = currentLon;
                ++c;

                // Retrieve the route and push the points onto the array.
                for (var n = 0; n < nPoints; n++)
                {
                    var x = directions.Result.Routes[0].Legs[0].Points[n].Latitude;
                    var y = directions.Result.Routes[0].Legs[0].Points[n].Longitude;
                    path[c, 0] = x;
                    path[c, 1] = y;
                    ++c;
                }

                // Finish with the destination.
                path[c, 0] = destinationLat;
                path[c, 1] = destinationLon;

                // Store the path length and time taken, to calculate the average speed.
                var meters = directions.Result.Routes[0].Summary.LengthInMeters;
                var seconds = directions.Result.Routes[0].Summary.TravelTimeInSeconds;
                var pathSpeed = meters / seconds;

                double distanceApartInMeters;
                double timeForOneSection;

                // Clear the time on path array. The path array is 1 less than the points array.
                timeOnPath = new double[nPoints + 1];

                // Calculate how much time is required for each section of the path.
                for (var t = 0; t < nPoints + 1; t++)
                {
                    // Calculate distance between the two path points, in meters.
                    distanceApartInMeters = DistanceInMeters(path[t,0], path[t,1], path[t + 1,0], path[t + 1,1]);

                    // Calculate the time for each section of the path.
                    timeForOneSection = distanceApartInMeters / pathSpeed;
                    timeOnPath[t] = timeForOneSection;
                }
                truckOnSection = 0;
                truckSectionsCompletedTime = 0;
                timeOnCurrentTask = 0;

                // Update the state now the route has arrived. One of: enroute or returning.
                state = newState;
            }
        }           ```

    > [!NOTE]
    > tbd

1. Add the command to deliver to a customer.

   ```cs
        static Task<MethodResponse> CmdGoToCustomer(MethodRequest methodRequest, object userContext)
        {
            try
            {
                // Pick up variables from the request payload, with the field name specified in IoT Central.
                var payloadString = Encoding.UTF8.GetString(methodRequest.Data);
                var dict = JsonConvert.DeserializeObject<Dictionary<string, string>>(payloadString);

                // Parse the input string for name/value pair.
                string key = dict.Keys.ElementAt(0);
                int customerNumber = Int32.Parse(dict.Values.ElementAt(0));

                // Check for a valid key and customer ID.
                if (customerNumber >= 0 && customerNumber < customer.Length && key == "customerId")
                {
                    switch (state)
                    {
                        case StateEnum.dumping:
                        case StateEnum.loading:
                        case StateEnum.delivering:
                            conflict = "Unable to act - " + state;
                            break;

                        case StateEnum.ready:
                        case StateEnum.enroute:
                        case StateEnum.returning:
                            if (contents == ContentsEnum.empty)
                            {
                                conflict = "Unable to act - empty";
                            }
                            else
                            {
                                // Set event only when all is good.
                                newCustomerId = customerNumber.ToString();

                                destinationLat = customer[customerNumber, 0];
                                destinationLon = customer[customerNumber, 1];

                                // Find route from current position to destination, storing route.
                                GetRoute(StateEnum.enroute);
                            }
                            break;
                    }

                    // Acknowledge the direct method call with a 200 success message.
                    string result = "{\"result\":\"Executed direct method: " + methodRequest.Name + "\"}";
                    return Task.FromResult(new MethodResponse(Encoding.UTF8.GetBytes(result), 200));
                }
                else
                {
                    conflict = $"Invalid customer: {customerNumber}";

                    // Acknowledge the direct method call with a 400 error message.
                    string result = "{\"result\":\"Invalid customer\"}";
                    return Task.FromResult(new MethodResponse(Encoding.UTF8.GetBytes(result), 400));
                }
            }
            catch
            {
                // Acknowledge the direct method call with a 400 error message.
                string result = "{\"result\":\"Invalid call\"}";
                return Task.FromResult(new MethodResponse(Encoding.UTF8.GetBytes(result), 400));
            }
        }
    ```

    > [!NOTE]
    > The statement `var dict = JsonConvert.DeserializeObject<Dictionary<string, string>>(payloadString);` shows how data is passed from the IoT Central app in a command. Note, too, that the device responds with a conflict if it is not in the correct state, and that the command itself is acknowledged at the end of the function. The recall command that follows in the next step handles things very similarly.

1. Add the recall command.

   ```cs
        static void ReturnToBase()
        {
            destinationLat = baseLat;
            destinationLon = baseLon;

            // Find route from current position to base, storing route.
            GetRoute(StateEnum.returning);
        }

        static Task<MethodResponse> CmdRecall(MethodRequest methodRequest, object userContext)
        {
            switch (state)
            {
                case StateEnum.ready:
                case StateEnum.loading:
                case StateEnum.dumping:
                    conflict = "Already at base";
                    break;

                case StateEnum.returning:
                    conflict = "Already returning";
                    break;

                case StateEnum.delivering:
                    conflict = "Unable to recall - " + state;
                    break;

                case StateEnum.enroute:
                    ReturnToBase();
                    break;
            }

            // Acknowledge the command.
            if (conflict == noEvent)
            {
                // Acknowledge the direct method call with a 200 success message.
                string result = "{\"result\":\"Executed direct method: " + methodRequest.Name + "\"}";
                return Task.FromResult(new MethodResponse(Encoding.UTF8.GetBytes(result), 200));
            }
            else
            {
                // Acknowledge the direct method call with a 400 error message.
                string result = "{\"result\":\"Invalid call\"}";
                return Task.FromResult(new MethodResponse(Encoding.UTF8.GetBytes(result), 400));
            }
        }
    ```

1. Add the function that updates the truck simulation at each time interval.

   ```cs
        static double DieRoll(double max)
        {
            return rand.NextDouble() * max;
        }

        static void UpdateTruck()
        {
            if (contents == ContentsEnum.empty)
            {
                // Turn the cooling system off, if possible, when the contents are empty.
                if (fan == FanEnum.on)
                {
                    fan = FanEnum.off;
                }
                tempContents += -2.9 + DieRoll(6);
            }
            else
            {
                // Contents are full or melting.
                if (fan != FanEnum.failed)
                {
                    if (tempContents < optimalTemperature - 5)
                    {
                        // Turn the cooling system off, as contents are getting too cold.
                        fan = FanEnum.off;
                    }
                    else
                    {
                        if (tempContents > optimalTemperature)
                        {
                            // Temp getting higher, turn cooling system back on.
                            fan = FanEnum.on;
                        }
                    }

                    // Randomly fail the cooling system.
                    if (DieRoll(100) < 1)
                    {
                        fan = FanEnum.failed;
                    }
                }

                // Set the contents temperature. Maintaining a cooler temperature if the cooling system is on.
                if (fan == FanEnum.on)
                {
                    tempContents += -3 + DieRoll(5);
                }
                else
                {
                    tempContents += -2.9 + DieRoll(6);
                }

                // If the temperature is above a threshold, count the seconds this is occuring, and melt the contents if it goes on too long.
                if (tempContents >= tooWarmThreshold)
                {
                    // Contents are warming.
                    tooWarmPeriod += interval;

                    if (tooWarmPeriod >= tooWarmtooLong)
                    {
                        // Contents are melting.
                        contents = ContentsEnum.melting;
                    }
                }
                else
                {
                    // Contents are cooling.
                    tooWarmPeriod = Math.Max(0, tooWarmPeriod - interval);
                }
            }

            timeOnCurrentTask += interval;

            switch (state)
            {
                case StateEnum.loading:
                    if (timeOnCurrentTask >= loadingTime)
                    {
                        // Finished loading.
                        state = StateEnum.ready;
                        contents = ContentsEnum.full;
                        timeOnCurrentTask = 0;

                        // Turn on the cooling fan.
                        // If the fan is in a failed state, assume it has been fixed.
                        fan = FanEnum.on;
                        tempContents = -2;
                    }
                    break;

                case StateEnum.ready:
                    timeOnCurrentTask = 0;
                    break;

                case StateEnum.delivering:
                    if (timeOnCurrentTask >= deliverTime)
                    {
                        // Finished delivering.
                        contents = ContentsEnum.empty;
                        ReturnToBase();
                    }
                    break;

                case StateEnum.returning:

                    // Update the truck position.
                    UpdatePosition();

                    // Check to see if the truck has arrived back at base.
                    if (Arrived())
                    {
                        switch (contents)
                        {
                            case ContentsEnum.empty:
                                state = StateEnum.loading;
                                break;

                            case ContentsEnum.full:
                                state = StateEnum.ready;
                                break;

                            case ContentsEnum.melting:
                                state = StateEnum.dumping;
                                break;
                        }
                        timeOnCurrentTask = 0;
                    }
                    break;

                case StateEnum.enroute:

                    // Move the truck.
                    UpdatePosition();

                    // Check to see if the truck has arrived at the customer.
                    if (Arrived())
                    {
                        state = StateEnum.delivering;
                        timeOnCurrentTask = 0;
                    }
                    break;

                case StateEnum.dumping:
                    if (timeOnCurrentTask >= dumpingTime)
                    {
                        // Finished dumping.
                        state = StateEnum.loading;
                        contents = ContentsEnum.empty;
                        timeOnCurrentTask = 0;
                    }
                    break;
            }
        }
    ```

    > [!NOTE]
    > This function is called every time interval. The actual time interval is set later on (at 5 seconds), though the "simulated time" (the number of seconds you specify that has passed each time this function is called) is set by the global `static double interval = 60`. Setting this value at 60 means the simulation runs at a rate of 60 divided by 5, or 12 times real time. To lower the simulated time, reduce the interval to, say, 30 (for a simulation that runs at six times real-time). Setting interval at 5 would run the simulation in real-time. Though realistic, this speed would be a bit slow, given the real driving times to the customer destinations.

1. Add the function to send truck telemetry and events, if any have occurred.

   ```cs
        static void colorMessage(string text, ConsoleColor clr)
        {
            Console.ForegroundColor = clr;
            Console.WriteLine(text);
            Console.ResetColor();
        }
        static void greenMessage(string text)
        {
            colorMessage(text, ConsoleColor.Green);
        }

        static void redMessage(string text)
        {
            colorMessage(text, ConsoleColor.Red);
        }

        static async void SendTruckTelemetryAsync(Random rand, CancellationToken token)
        {
            while (true)
            {
                UpdateTruck();

                // Create the telemetry JSON message.
                var telemetryDataPoint = new
                {
                    temperature = Math.Round(tempContents, 2),
                    stateTruck = state.ToString(),
                    stateCoolingSystem = fan.ToString(),
                    stateContents = contents.ToString(),
                    location = new { lon = currentLon, lat = currentLat },
                };
                var telemetryMessageString = JsonConvert.SerializeObject(telemetryDataPoint);
                var telemetryMessage = new Message(Encoding.ASCII.GetBytes(telemetryMessageString));

                // Add the conflict event string, if there is one.
                if (conflict != noEvent)
                {
                    var eventPoint1 = new
                    {
                        eventConflict = conflict,
                    };
                    // try this first!! tbd
                    telemetryMessage.Properties.Add("eventConflict", conflict);
                    conflict = noEvent;
                }

                // Add the new customer event string, if there is one.
                if (newCustomerId != noEvent)
                {
                    var eventPoint2 = new
                    {
                        eventCustomer = newCustomerId,
                    };
                    telemetryMessage.Properties.Add("eventCustomer", newCustomerId);
                    newCustomerId = noEvent;
                }

                Console.WriteLine($"\nTelemetry data: {telemetryMessageString}");

                // Bail if requested.
                token.ThrowIfCancellationRequested();

                // Send the telemetry message.
                await s_deviceClient.SendEventAsync(telemetryMessage);
                greenMessage($"Telemetry sent {DateTime.Now.ToShortTimeString()}");

                await Task.Delay(intervalInMilliseconds);
            }
        }
    ```

    > [!NOTE]
    > The `SendTruckTelemetryAsync` is an important function, handling the sending of telemetry, states, and events to IoT Central. Note the use of JSON strings to send the data, and that an acknowledgement message is sent at the end of the function.

1. Add the code to handle settings and properties. You only have one setting and one property in our app, though if there are more, they are easily added.

   ```cs
        static async Task SendDevicePropertiesAsync()
        {
            Console.WriteLine("Send device properties...");
            reportedProperties["truckID"] =  truckIdentification;
            Console.WriteLine(JsonConvert.SerializeObject(reportedProperties));
            await s_deviceClient.UpdateReportedPropertiesAsync(reportedProperties);
        }
        static async Task HandleSettingChanged(TwinCollection desiredProperties, object userContext)
        {
            Console.WriteLine("Received settings change...");
            Console.WriteLine(JsonConvert.SerializeObject(desiredProperties));

            string setting = "optimalTemperature";
            if (desiredProperties.Contains(setting))
            {
                BuildAcknowledgement(desiredProperties, setting);
            }
            
            Console.WriteLine("Send settings changed acknowledgement...");
            await s_deviceClient.UpdateReportedPropertiesAsync(reportedProperties);
        }

        static void BuildAcknowledgement(TwinCollection desiredProperties, string setting)
        {
            reportedProperties[setting] = new
            {
                value = desiredProperties[setting]["value"],
                status = "completed",
                desiredVersion = desiredProperties["$version"],
                message = "Processed"
            };
        }
    ```

    > [!NOTE]
    > This section of code is generic to most C# apps that communicate with IoT Central. To add additional properties or settings, add to `reportedProperties`, or create a new setting string, and check on `desiredProperties`, respectively. No other code changes are usually needed.

1. Add the `Main` function.

   ```cs
        static void Main(string[] args)
        {
            rand = new Random();
            colorMessage("Refrigerated truck sensor device app.\n", ConsoleColor.Yellow);
            currentLat = baseLat;
            currentLon = baseLon;

            // Connect to Azure Maps.
            azureMapsServices = new AzureMapsServices(AzureMapsKey);  

            try
            {
                using (var security = new SecurityProviderSymmetricKey(DeviceID, PrimaryKey, null))
                {
                    DeviceRegistrationResult result = RegisterDeviceAsync(security).GetAwaiter().GetResult();
                    if (result.Status != ProvisioningRegistrationStatusType.Assigned)
                    {
                        Console.WriteLine("Failed to register device");
                        return;
                    }
                    IAuthenticationMethod auth = new DeviceAuthenticationWithRegistrySymmetricKey(result.DeviceId, (security as SecurityProviderSymmetricKey).GetPrimaryKey());
                    s_deviceClient = DeviceClient.Create(result.AssignedHub, auth, TransportType.Mqtt);
                }
                SendDevicePropertiesAsync().GetAwaiter().GetResult();

                Console.Write("Register settings changed handler...");
                s_deviceClient.SetDesiredPropertyUpdateCallbackAsync(HandleSettingChanged, null).GetAwaiter().GetResult();
                Console.WriteLine("Done");

                cts = new CancellationTokenSource();

                // Create a handler for the direct method calls.
                s_deviceClient.SetMethodHandlerAsync("cmdGoTo", CmdGoToCustomer, null).Wait();
                s_deviceClient.SetMethodHandlerAsync("cmdRecall", CmdRecall, null).Wait();

                SendTruckTelemetryAsync(rand, cts.Token);

                Console.WriteLine("Press any key to exit...");
                Console.ReadKey();
                cts.Cancel();
            }
            catch (Exception ex)
            {
                Console.WriteLine();
                Console.WriteLine(ex.Message);
            }
        }

        public static async Task<DeviceRegistrationResult> RegisterDeviceAsync(SecurityProviderSymmetricKey security)
        {
            Console.WriteLine("Register device...");

            using (var transport = new ProvisioningTransportHandlerMqtt(TransportFallbackType.TcpOnly))
            {
                ProvisioningDeviceClient provClient =
                          ProvisioningDeviceClient.Create(GlobalDeviceEndpoint, ScopeID, security, transport);

                Console.WriteLine($"RegistrationID = {security.GetRegistrationID()}");                

                Console.Write("ProvisioningClient RegisterAsync...");
                DeviceRegistrationResult result = await provClient.RegisterAsync();

                Console.WriteLine($"{result.Status}");
                Console.WriteLine($"ProvisioningClient AssignedHub: {result.AssignedHub}; DeviceID: {result.DeviceId}");

                return result;
            }
        }
    ```

    > [!NOTE]
    > tbd.

1. Complete the app by entering closing braces for the class and namespace.

   ```cs
        }
    }
    ```

::: zone-end

Fantastic! You are now ready to test your code.
