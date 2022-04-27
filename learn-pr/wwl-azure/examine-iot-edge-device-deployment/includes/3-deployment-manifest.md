The deployment manifest tells your device which modules to install and how to configure them to work together.

The deployment manifest is a JSON document that describes:

 -  The IoT Edge agent module twin, which includes three components.
    
     -  The container image for each module that runs on the device.
     -  The credentials to access private container registries that contain module images.
     -  Instructions for how each module should be created and managed.
 -  The IoT Edge hub module twin, which includes how messages flow between modules and eventually to IoT Hub.
 -  Optionally, the desired properties of any other module twins.

All IoT Edge devices must be configured with a deployment manifest. A newly installed IoT Edge runtime reports an error code until configured with a valid manifest. You can create a deployment manifest using the Azure IoT Edge portal, REST APIs, or the IoT Hub Service SDK.

## Create a deployment manifest

At a high level, a deployment manifest is a list of module twins that are configured with their desired properties. A deployment manifest tells an IoT Edge device (or a group of devices) which modules to install and how to configure them. Deployment manifests include the desired properties for each module twin. IoT Edge devices report back the reported properties for each module.

Two modules are required in every deployment manifest: `$edgeAgent`, and `$edgeHub`. These modules are part of the IoT Edge runtime that manages the IoT Edge device and the modules running on it.

In addition to the two runtime modules, you can add up to 50 modules of your own to run on an IoT Edge device.

A deployment manifest that contains only the IoT Edge runtime (edgeAgent and edgeHub) is valid.

Deployment manifests follow this structure:

```JSON
{
    "modulesContent": {
        "$edgeAgent": { // required
            "properties.desired": {
                // desired properties of the Edge agent
                // includes the image URIs of all modules
                // includes container registry credentials
            }
        },
        "$edgeHub": { //required
            "properties.desired": {
                // desired properties of the Edge hub
                // includes the routing information between modules, and to IoT Hub
            }
        },
        "module1": {  // optional
            "properties.desired": {
                // desired properties of module1
            }
        },
        "module2": {  // optional
            "properties.desired": {
                // desired properties of module2
            }
        }
    }
}

```

## Configure modules

Define how the IoT Edge runtime installs the modules in your deployment. The IoT Edge agent is the runtime component that manages installation, updates, and status reporting for an IoT Edge device. Therefore, the `$edgeAgent` module twin requires the configuration and management information for all modules. This information includes the configuration parameters for the IoT Edge agent itself.

For a complete list of properties that can or must be included, see Properties of the IoT Edge agent and IoT Edge hub - [https://docs.microsoft.com/azure/iot-edge/module-edgeagent-edgehub](/azure/iot-edge/module-edgeagent-edgehub).

The `$edgeAgent` properties follow this structure:

```JSON
"$edgeAgent": {
    "properties.desired": {
        "schemaVersion": "1.1",
        "runtime": {
            "settings":{
                "registryCredentials":{
                      // give the edge agent access to
                      // container images that aren't public
                }
            }
        },
        "systemModules": {
            "edgeAgent": {
                // configuration and management details
            },
            "edgeHub": {
                // configuration and management details
            }
        },
        "modules": {
            "module1": { // optional
                // configuration and management details
            },
            "module2": { // optional
                // configuration and management details
            }
        }
    }
},

```

## Declare routes

The IoT Edge hub manages communication between modules, IoT Hub, and any leaf devices. Therefore, the `$edgeHub` module twin contains a desired property called routes that declares how messages are passed within a deployment. You can have multiple routes within the same deployment.

Routes are declared in the `$edgeHub` desired properties with the following syntax:

```JSON
"$edgeHub": {
    "properties.desired": {
        "routes": {
            "route1": "FROM <source> WHERE <condition> INTO <sink>",
            "route2": "FROM <source> WHERE <condition> INTO <sink>"
        },
    }
}

```

Every route needs a source and a sink, but the condition is an optional piece that you can use to filter messages.

### Source

The source specifies where the messages come from. IoT Edge can route messages from modules or leaf devices.

Using the IoT SDKs, modules can declare specific output queues for their messages using the ModuleClient class. Output queues aren't necessary, but are helpful for managing multiple routes. Leaf devices can use the DeviceClient class of the IoT SDKs to send messages to IoT Edge gateway devices in the same way that they would send messages to IoT Hub.

The source property can be any of the following values:

:::row:::
  :::column:::
    **Source**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    /\*
  :::column-end:::
  :::column:::
    All device-to-cloud messages or twin change notifications from any module or leaf device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    /twinChangeNotifications
  :::column-end:::
  :::column:::
    Any twin change (reported properties) coming from any module or leaf device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    /messages/\*
  :::column-end:::
  :::column:::
    Any device-to-cloud message sent by a module through some or no output, or by a leaf device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    /messages/modules/\*
  :::column-end:::
  :::column:::
    Any device-to-cloud message sent by a module through some or no output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    /messages/modules/&lt;moduleId&gt;/\*
  :::column-end:::
  :::column:::
    Any device-to-cloud message sent by a specific module through some or no output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    /messages/modules/&lt;moduleId&gt;/outputs/\*
  :::column-end:::
  :::column:::
    Any device-to-cloud message sent by a specific module through some output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    /messages/modules/&lt;moduleId&gt;/outputs/&lt;output&gt;
  :::column-end:::
  :::column:::
    Any device-to-cloud message sent by a specific module through a specific output.
  :::column-end:::
:::row-end:::


### Condition

The condition is optional in a route declaration. If you want to pass all messages from the source to the sink, just leave out the WHERE clause entirely. Or you can use the IoT Hub query language to filter for certain messages or message types that satisfy the condition. IoT Edge routes don't support filtering messages based on twin tags or properties.

The messages that pass between modules in IoT Edge are formatted the same as the messages that pass between your devices and Azure IoT Hub. All messages are formatted as JSON and have systemProperties, appProperties, and body parameters.

You can build queries around any of the three parameters with the following syntax:

 -  System properties: `$<propertyName>` or `{$<propertyName>}`
 -  Application properties: `<propertyName>`
 -  Body properties: `$body.<propertyName>`

An example that is specific to IoT Edge is when you want to filter for messages that arrived at a gateway device from a leaf device. Messages that come from modules include a system property called **connectionModuleId**. So if you want to route messages from leaf devices directly to IoT Hub, use the following route to exclude module messages:

```query
FROM /messages/* WHERE NOT IS_DEFINED($connectionModuleId) INTO $upstream

```

### Sink

The sink defines where the messages are sent. Only modules and IoT Hub can receive messages. Messages can't be routed to other devices. There are no wildcard options in the sink property.

The sink property can be any of the following values:

:::row:::
  :::column:::
    **Sink**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $upstream
  :::column-end:::
  :::column:::
    Send the message to IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    BrokeredEndpoint("/modules/&lt;moduleId&gt;/inputs/&lt;input&gt;")
  :::column-end:::
  :::column:::
    Send the message to a specific input of a specific module.
  :::column-end:::
:::row-end:::


IoT Edge provides at-least-once guarantees. The IoT Edge hub stores messages locally in case a route can't deliver the message to its sink. For example, if the IoT Edge hub can't connect to IoT Hub, or the target module isn't connected.

IoT Edge hub stores the messages up to the time specified in the `storeAndForwardConfiguration.timeToLiveSecs` property of the IoT Edge hub desired properties.

## Define or update desired properties

The deployment manifest specifies desired properties for each module deployed to the IoT Edge device. Desired properties in the deployment manifest overwrite any desired properties currently in the module twin.

If you do not specify a module twin's desired properties in the deployment manifest, IoT Hub won't modify the module twin in any way. Instead, you can set the desired properties programmatically.

The same mechanisms that allow you to modify device twins are used to modify module twins.

## Deployment manifest example

The following example shows what a valid deployment manifest document may look like.

```json
{
  "modulesContent": {
    "$edgeAgent": {
      "properties.desired": {
        "schemaVersion": "1.1",
        "runtime": {
          "type": "docker",
          "settings": {
            "minDockerVersion": "v1.25",
            "loggingOptions": "",
            "registryCredentials": {
              "ContosoRegistry": {
                "username": "myacr",
                "password": "<password>",
                "address": "myacr.azurecr.io"
              }
            }
          }
        },
        "systemModules": {
          "edgeAgent": {
            "type": "docker",
            "settings": {
              "image": "mcr.microsoft.com/azureiotedge-agent:1.1",
              "createOptions": "{}"
            }
          },
          "edgeHub": {
            "type": "docker",
            "status": "running",
            "restartPolicy": "always",
            "settings": {
              "image": "mcr.microsoft.com/azureiotedge-hub:1.1",
              "createOptions": "{\"HostConfig\":{\"PortBindings\":{\"443/tcp\":[{\"HostPort\":\"443\"}],\"5671/tcp\":[{\"HostPort\":\"5671\"}],\"8883/tcp\":[{\"HostPort\":\"8883\"}]}}}"
            }
          }
        },
        "modules": {
          "SimulatedTemperatureSensor": {
            "version": "1.0",
            "type": "docker",
            "status": "running",
            "restartPolicy": "always",
            "settings": {
              "image": "mcr.microsoft.com/azureiotedge-simulated-temperature-sensor:1.0",
              "createOptions": "{}"
            }
          },
          "filtermodule": {
            "version": "1.0",
            "type": "docker",
            "status": "running",
            "restartPolicy": "always",
            "settings": {
              "image": "myacr.azurecr.io/filtermodule:latest",
              "createOptions": "{}"
            }
          }
        }
      }
    },
    "$edgeHub": {
      "properties.desired": {
        "schemaVersion": "1.0",
        "routes": {
          "sensorToFilter": "FROM /messages/modules/SimulatedTemperatureSensor/outputs/temperatureOutput INTO BrokeredEndpoint(\"/modules/filtermodule/inputs/input1\")",
          "filterToIoTHub": "FROM /messages/modules/filtermodule/outputs/output1 INTO $upstream"
        },
        "storeAndForwardConfiguration": {
          "timeToLiveSecs": 10
        }
      }
    }
  }
}

```
