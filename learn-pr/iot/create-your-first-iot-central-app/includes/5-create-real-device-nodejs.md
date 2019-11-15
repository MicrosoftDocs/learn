In this unit, you are going to add Node.js code for a simulated refrigerated truck, which enables you to test the code long before requiring a real truck. IoT Central treats this simulation as "real" because the communication code between the Node.js app and the IoT Central app would be the same for a real truck. In other words, in a real situation (where you run a refrigerated truck company), you would start with simulated code similar to that in this unit, and, after it worked to your satisfaction, the simulation specific code would be replaced with real code. And the communication code would remain the same. This latter fact makes writing the following code a valuable experience.

## Create the Node.js app

Using your preferred development environment, build a Node.js app. Visual Studio Code and Visual Studio examples are available in this unit. Node.js is a platform for building server apps, based on JavaScript. All the JavaScript code you will need is provided below, so you do not need to be a JavaScript developer to get this app up and running.

::: zone pivot="vscode"

1. Open Visual Studio Code. From the **Terminal** menu, open a **New Terminal**.

1. In the opened terminal, create an empty folder where you will develop your code, called "RefrigeratedTrucks", by entering `mkdir RefrigeratedTrucks`. Then, navigate to that folder with `cd RefrigeratedTrucks`.

1. From the **File** menu, create a new file. Insert a single line as a comment, such as `// Refrigerated Truck app`. Save the file to the "RefrigeratedTrucks" folder (locating this folder might involve a bit of navigation), with the name "app.js". By using the .js file extension, Visual Studio Code interprets this file as JavaScript and evaluates the contents with the JavaScript language service.

    ![Screenshot showing how to save the JavaScript file, in Visual Studio Code](../media/refrigerated-trucks-vscode.png)

1. Back in the terminal, load the libraries you need with the following commands:
    * **npm install azure-iot-device**
    * **npm install azure-iot-device-mqtt**
    * **npm install azure-maps-rest**

1. After you have entered the code below into the app.js file, you can run it from the terminal by entering `node app.js`. Ensure that the RefrigeratedTrucks folder is the current folder of the terminal, when you run the app.

::: zone-end
::: zone pivot="vstudio"

1. Navigate to the **JavaScript** project types, and create a new **Blank Node.js Console Application** project, called "RefrigeratedTruck".

    ![Screenshot showing how to create a new blank Node.js project, in Visual Studio](../media/refrigerated-trucks-vs-project.png)

1. Install azure-iot-device and azure-maps-rest npm packages by right-clicking on the **npm** entry in Solution Explorer, and select **Install New npm Packages...**.

1. In the dialog that follows, search for and install the following libraries:
    * **azure-iot-device**
    * **azure-iot-device-mqtt**
    * **azure-maps-rest**

    ![Screenshot showing how to add an npm package, in Visual Studio](../media/refrigerated-trucks-vs-npm.png)

1. Delete the default contents of the app.js file.

1. When you have entered the code below, you will be able to run the app with the **Start Without Debugging**, or **Start Debugging**, options. In the latter case you can set breakpoints, examine data, and perform other debugging tasks.

::: zone-end

## Write the Node.js app

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

Fantastic! You are now ready to test your code.
