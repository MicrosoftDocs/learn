You can add or upload a model by using the CLI command in step 1. Then, you can use this model to create a twin that will be updated with information from Azure IoT Hub.

The model looks like this:

```JSON
{
    "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_moulding;1",
    "@type": "Interface",
    "displayName": "Factory Production Step: Moulding - Interface Model",
    "extends": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step;2",
    "@context": "dtmi:dtdl:context;2",
    "contents": [
      {
        "@type": [ "Property", "Temperature" ],
        "name": "ChasisTemperature",
        "schema": "double",
        "unit": "degreeFahrenheit",
        "writable": true
      },
      {
        "@type": "Property",
        "name": "PowerUsage",
        "schema": "double"
      }
    ]
  }
```

1. Upload this model to your Azure Digital Twins instance by running the following command. (Use the PowerShell session from the previous unit.)

    ```azurecli
    az dt model create --models '{"@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_moulding;1", "@type": "Interface","displayName": "Factory Production Step: Moulding - Interface Model", "extends": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step;2","@context": "dtmi:dtdl:context;2", "contents": [{"@type": [ "Property", "Temperature" ],"name": "ChasisTemperature","schema": "double","unit": "degreeFahrenheit", "writable": true }, { "@type": "Property", "name": "PowerUsage", "schema": "double"  } ]}' -n $dtname
    ```

1. Use the next command to create a twin and set 0.0 as an initial temperature value:

    ```azurecli
    az dt twin create --dtmi "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_moulding;1" --twin-id GrindingStep --properties '{"ChasisTemperature": 0.0}' --dt-name $dtname
    ```

    Output of a successful **twin create** command should look like this:

    ```json
    {
      "$dtId": "GrindingStep",
      "$etag": "W/\"911fc8fa-8ffb-4c22-b7f3-ed939f4f8c64\"",
      "$metadata": {
        "$model": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_moulding;1",
        "ChasisTemperature": {
          "lastUpdateTime": "2020-10-26T19:27:20.1460603Z"
    }
      },
      "ChasisTemperature": 0.0
    }
    ```