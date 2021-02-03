## Add a model and twin

You can add/upload a model using the CLI command below, and then create a twin using this model that will be updated with information from IoT Hub.

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

1. Upload this model to your twins instance by running the following command in the PowerShell session from the previous unit

    ```azurecli
    az dt model create --models '{"@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_moulding;1", "@type": "Interface","displayName": "Factory Production Step: Moulding - Interface Model", "extends": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step;2","@context": "dtmi:dtdl:context;2", "contents": [{"@type": [ "Property", "Temperature" ],"name": "ChasisTemperature","schema": "double","unit": "degreeFahrenheit", "writable": true }, { "@type": "Property", "name": "PowerUsage", "schema": "double"  } ]}' -n $dtname
    ```

1. Use the following command to create a twin and set 0.0 as an initial temperature value.

    ```azurecli
     $properties = '{"ChasisTemperature": 0.0}'
     $properties | out-file ./properties.json
    az dt twin create --dtmi "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_moulding;1" --twin-id GrindingStep --properties  ./properties.json --dt-name $dtname
    ```

    Output of a successful twin create command should look like this:

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
