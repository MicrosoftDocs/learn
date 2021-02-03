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

1. Upload this model to your twins instance by running the following commands in the PowerShell session from the previous unit:

    ```azurecli
    $model = '{"@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_moulding;1", "@type": "Interface","displayName": "Factory Production Step: Moulding - Interface Model","@context": "dtmi:dtdl:context;2", "contents": [{"@type": [ "Property", "Temperature" ],"name": "ChasisTemperature","schema": "double","unit": "degreeFahrenheit", "writable": true }, { "@type": "Property", "name": "PowerUsage", "schema": "double"  } ]}'
    $model | out-file ./model.json
    az dt model create --models ./model.json -n $dtname
    ```

1. Use the next command to create a twin and set 0.0 as an initial temperature value:

    ```azurecli
     $properties = '{"ChasisTemperature": 0.0}'
     $properties | out-file ./properties.json
    az dt twin create --dtmi "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_moulding;1" --twin-id GrindingStep --properties  ./properties.json --dt-name $dtname
    ```

    The output of a successful **twin create** command should look like this:

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
