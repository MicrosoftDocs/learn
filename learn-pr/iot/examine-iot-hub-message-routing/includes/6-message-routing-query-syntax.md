Message routing enables users to route different data types, including device telemetry messages, device lifecycle events, and device twin change events, to various endpoints. Azure IoT Hub message routing provides a querying capability to filter the data before routing it to the endpoints.

A single message may match the condition on multiple routing queries, in which case Azure IoT Hub delivers the message to the endpoint associated with each matched query. Azure IoT Hub also automatically deduplicates message delivery, so if a message matches multiple queries that have the same destination, it's only written once to that destination.

Each routing query you configure has the following properties:

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    The unique name that identifies the query.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Source
  :::column-end:::
  :::column:::
    The origin of the data stream to be acted upon. For example, device telemetry.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Condition
  :::column-end:::
  :::column:::
    The query expression for the routing query that is run against the message application properties, system properties, message body, device twin tags, and device twin properties to determine if it's a match for the endpoint.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Endpoint
  :::column-end:::
  :::column:::
    The name of the endpoint where Azure IoT Hub sends messages that match the query. We recommend that you choose an endpoint in the same region as your Azure IoT hub.
  :::column-end:::
:::row-end:::

## Message routing query syntax

Message routing allows you to query on the message properties and message body as well as device twin tags and device twin properties. If the message body isn't in JSON format, message routing can still route the message, but queries can't be applied to the message body. Queries are described as Boolean expressions where, if true, the query succeeds and routes all the incoming data; otherwise, the query fails and the incoming data isn't routed. If the expression evaluates to a null or undefined value, it's treated as a Boolean false value, and generates an error in the Azure IoT Hub routes resource logs. The query syntax must be correct for the route to be saved and evaluated.

## Message routing query based on message properties

Azure IoT Hub defines a common format for all device-to-cloud messaging for interoperability across protocols. Azure IoT Hub assumes the following JSON representation of the message.
* System properties (**systemProperties**) are added for all users and identify the content of the message.
* Users can optionally add application properties (**appProperties**) to the message. Application properties are user-defined strings. We recommend using unique property names as Azure IoT Hub device-to-cloud messaging isn't case-sensitive. For example, if you have multiple properties with the same name, Azure IoT Hub will only send one of the properties.

```json
{ 
  "message": { 
    "systemProperties": { 
      "contentType": "application/json", 
      "contentEncoding": "UTF-8", 
      "iothub-message-source": "deviceMessages", 
      "iothub-enqueuedtime": "2017-05-08T18:55:31.8514657Z" 
    }, 
    "appProperties": { 
      "processingPath": "{cold | warm | hot}", 
      "verbose": "{true, false}", 
      "severity": 1-5, 
      "testDevice": "{true | false}" 
    }, 
    "body": "{\"Weather\":{\"Temperature\":50}}" 
  } 
} 

```

### Message properties query expressions

A query on message system properties needs to be prefixed with the `$` symbol. Queries on application properties are accessed with their name and shouldn't be prefixed with the `$` symbol. If an application property name begins with `$`, then Azure IoT Hub searches for it in the system properties, and it isn't found, then it looks in the application properties. The following examples show how to query on system properties and application properties.

To query on system property contentEncoding:

```SQL
$contentEncoding = 'UTF-8'

```

To query on application property processingPath:

```SQL
processingPath = 'hot'

```

To combine these queries, you can use Boolean expressions and functions:

```SQL
$contentEncoding = 'UTF-8' AND processingPath = 'hot'

```

A full list of supported operators and functions is provided in the [expression and conditions](/azure/iot-hub/iot-hub-devguide-query-language#expressions-and-conditions) section of [IoT Hub query language for device and module twins, jobs, and message routing](/azure/iot-hub/iot-hub-devguide-query-language).

## Message routing query based on message body

To enable querying on message body, the message should be in a JSON encoded in either UTF-8, UTF-16 or UTF-32. The `contentType` must be set to `application/JSON`. The `contentEncoding` system property must be one of the supported UTF encodings supported by that system property. If these properties aren't specified, Azure IoT Hub won't evaluate the query expression on the message body.

The following example shows how to create a message with a properly formed and encoded JSON body:

```javascript
var messageBody = JSON.stringify(Object.assign({}, {
    "Weather": {
        "Temperature": 50,
        "Time": "2017-03-09T00:00:00.000Z",
        "PrevTemperatures": [
            20,
            30,
            40
        ],
        "IsEnabled": true,
        "Location": {
            "Street": "One Microsoft Way",
            "City": "Redmond",
            "State": "WA"
        },
        "HistoricalData": [
            {
                "Month": "Feb",
                "Temperature": 40
            },
            {
                "Month": "Jan",
                "Temperature": 30
            }
        ]
    }
}));

// Encode message body using UTF-8  
var messageBytes = Buffer.from(messageBody, "utf8");

var message = new Message(messageBytes);

// Set message body type and content encoding 
message.contentEncoding = "utf-8";
message.contentType = "application/json";

// Add other custom application properties   
message.properties.add("Status", "Active");

deviceClient.sendEvent(message, (err, res) => {
    if (err) console.log('error: ' + err.toString());
    if (res) console.log('status: ' + res.constructor.name);
});

```

### Query expressions for message routing query based on message body

A query on a message body needs to be prefixed with `$body`. You can use a body reference, body array reference, or multiple body references in the query expression. Your query expression can also combine a body reference with a message system properties reference or a message application properties reference. For example, the following are all valid query expressions:

```SQL
$body.Weather.HistoricalData[0].Month = 'Feb'

```

```SQL
$body.Weather.Temperature = 50 AND $body.Weather.IsEnabled

```

```SQL
length($body.Weather.Location.State) = 2 

```

```SQL
$body.Weather.Temperature = 50 AND processingPath = 'hot' 

```

You can run queries and functions only on properties in the body reference. You can't run queries or functions on the entire body reference. For example, the following query isn't supported and returns `undefined`:

```SQL
$body[0] = 'Feb'

```

To filter a twin notification payload based on what changed, run your query on the message body. For example, to filter when there's a desired property change on `sendFrequency` and the value is greater than 10:

```SQL
`$body.properties.desired.telemetryConfig.sendFrequency > 10`

```

To filter messages that contains a property change, no matter the value of the property, you can use the `is_defined()` function (when the value is a primitive type):

```SQL
`is_defined($body.properties.desired.telemetryConfig.sendFrequency)`

```

## Message routing query based on device twin

Message routing enables you to query on device twin or module twin tags and properties, which are JSON objects. The following sample illustrates a device twin with tags and properties:

```json
{
    "tags": { 
        "deploymentLocation": { 
            "building": "43", 
            "floor": "1" 
        } 
    }, 
    "properties": { 
        "desired": { 
            "telemetryConfig": { 
                "sendFrequency": "5m" 
            }, 
            "$metadata" : {...}, 
            "$version": 1 
        }, 
        "reported": { 
            "telemetryConfig": { 
                "sendFrequency": "5m", 
                "status": "success" 
            },
            "batteryLevel": 55, 
            "$metadata" : {...}, 
            "$version": 4 
        } 
    } 
} 

```

> [!NOTE]
> Modules do not inherit twin tags from their corresponding devices. Twin queries for messages originating from device modules (for example, from IoT Edge modules) query against the module twin and not the corresponding device twin.

### Query expressions for message routing query based on device twin

A query on device twin properties needs to be prefixed with `$twin`. Your query expression can also combine a twin tag or property reference with a body reference, a message system properties reference, or a message application properties reference. We recommend using unique names in tags and properties as the query isn't case-sensitive. We also recommend that you avoid using `twin`, `$twin`, `body`, or `$body`, as a property names. For example, the following are all valid query expressions:

```SQL
$twin.properties.desired.telemetryConfig.sendFrequency = '5m'

```

```SQL
$body.Weather.Temperature = 50 AND $twin.properties.desired.telemetryConfig.sendFrequency = '5m'

```

```SQL
$twin.tags.deploymentLocation.floor = 1 

```

## Limitations

Routing queries don't support using whitespace or any of the following characters in property names, the message body path, or the device/module twin path: `()<>@,;:\"/?={}`.
