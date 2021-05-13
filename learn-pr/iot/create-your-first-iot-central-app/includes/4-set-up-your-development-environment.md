
In this unit, you'll set up an Azure Maps account. This account is used to calculate the best route from point A to point B. Route finding takes into account the vehicle, traffic, road regulations, and many other factors.

Before you set up the Azure Maps account, install the right language systems. You might have already installed these systems for an earlier project.

::: zone pivot="vs-node,vscode-node"

To use Node.js as a development language, install the [Node.js runtime system](https://nodejs.org/).

::: zone-end
::: zone pivot="vscode-csharp"

To use C# in Visual Studio Code, ensure that both [.NET Core](https://dotnet.microsoft.com/download) and the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) are installed.

::: zone-end

## Create a free Azure Maps account

If you don't already have an Azure Maps account, create one: 

1. Right-click [Azure Maps](https://azure.microsoft.com/services/azure-maps), and then select **Open in new window**.

1. Follow the prompts to create a free account. When your account is set up, you'll need the _primary key_ for the account. In the menu for your Azure Maps resource, find this key by selecting **Authentication**. Copy the primary key and paste it into your _Truck keys.txt_ document. Add a note that it applies to Azure Maps.

1. Optionally, verify that your Azure Maps key works. Save the following code snippet in an HTML file. In the code, replace `<your Azure Maps key>` with your own key. Then load the file in a web browser. 

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
                        subscriptionKey: '<your Azure Maps key>'
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
Do you see a map of the world? Can you zoom in and out and move around on the map?

## Next steps

You've now completed the preparatory steps to connect your first IoT Central app to real devices. Good work!

The next step is to create the device app.
