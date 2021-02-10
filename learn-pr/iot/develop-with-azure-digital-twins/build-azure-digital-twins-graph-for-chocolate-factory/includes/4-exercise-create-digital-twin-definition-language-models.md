Next, you'll use what you learned about models in the previous section to create your own. You'll create a collection of models that resemble a real-life industrial scenario. For this reason, there's some complexity and some work in putting this collection of models together. The result of this work is a much better learning experience, though, and when you start graphing the models, you get deeper insights into the digital twin world. With this greater realism in mind, you're going to need to create a number of models.

First, you need to create a folder to keep your model files in. For example, create a sub-folder in your **Documents** folder, with a name such as **factory-models**. You can use any tool that works well with text files to create these models. Good choices include Visual Studio, Visual Studio Code, or even Notepad.

## Create a model for a chocolate factory

For the factory itself, create a model with the following properties and relationships:

| Element | Type | Description |
| --------- | ---- | ----------- |
Factory name | Property | A friendly name for the factory.
Geo location | Property with fields | Geo location (latitude, longitude) of the factory.
Has floors  | Relationship | The factory has floors, identified by the `dtmi:com:microsoft:iot:e2e:digital_factory:floor;1` ID.

1. Look over the following model definition, noting how the three components are defined:

    ```json
    {
        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:chocolate_factory;1",
        "@type": "Interface",
        "displayName": "Digital Factory - Interface Model",
        "@context": "dtmi:dtdl:context;2",
        "contents": [
            {
                "@type": "Property",
                "name": "FactoryName",
                "schema": "string",
                "writable": true
            },
            {
                "@type": "Property",
                "name": "GeoLocation",
                "schema": {
                    "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:custom_schema:GeoCord;1",
                    "@type": "Object",
                    "fields": [
                        {
                        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:custom_schema:GeoCord:lat;1",
                        "name": "Latitude",
                        "schema": "double"
                        },
                        {
                        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:custom_schema:GeoCord:lon;1",
                        "name": "Longitude",
                        "schema": "double"
                        }
                    ]
                }
            },
            {
                "@type": "Relationship",
                "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:chocolate_factory:rel_has_floors;1",
                "name": "rel_has_floors",
                "displayName": "Has floors",
                "target": "dtmi:com:microsoft:iot:e2e:digital_factory:floor;1"
            }
        ]
    }
    ```

1. Create a new file in your text editor and copy the factory model into it. Save it with the name **FactoryInterface.json** to your **factory-models** folder.

## Create a model for a factory floor

For the factory floor, you'll give it an ID and keep track of the ambient temperature of the floor. You also need the relationship that a floor contains production lines.

| Element | Type | Description |
| --------- | ---- | ----------- |
Floor ID | Property | A unique ID for the floor.
Temperature | Property with units | Ambient temperature of the floor.
Runs production lines  | Relationship | The floor has production lines, identified by the `dtmi:com:microsoft:iot:e2e:digital_factory:production_line;1` ID.

1. Again, look over the following model definition. Note how a property with specific units is defined:

    ```json
    {
        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:floor;1",
        "@type": "Interface",
        "displayName": "Factory Floor - Interface Model",
        "@context": "dtmi:dtdl:context;2",
        "contents": [
            {
                "@type": "Property",
                "name": "FloorId",
                "schema": "string",
                "writable": true
            },
            {
                "@type": ["Property", "Temperature"],
                "name": "Temperature",
                "schema": "double",
                "unit": "degreeCelsius",
                "writable": true
            },
            {
                "@type": "Relationship",
                "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:floor:rel_runs_lines;1",
                "name": "rel_runs_lines",
                "displayName": "Runs production lines",
                "target": "dtmi:com:microsoft:iot:e2e:digital_factory:production_line;1"
            }
        ]
    }
    ```

1. Create a new file in your text editor, and copy the factory floor model into it. Save it with the name **FactoryFloorInterface.json** to your **factory-models** folder.

## Create a production line model

Now things get a bit more complex. You need to define a model for a production line that can cope with the multiple steps, pieces, and types of equipment that are in use.

| Element | Type | Description |
| --------- | ---- | ----------- |
Line ID | Property | A unique ID for the production line. Perhaps a floor contains more than one line.
`LineOperationStatus` | Property with schema | A property that indicates whether the production line is online (running), or not.
Runs steps  | Relationship | The production steps for the production lines' runs, identified by the `dtmi:com:microsoft:iot:e2e:digital_factory:production_line:rel_runs_steps;1` ID. The steps also have an online or offline status property.

1. Look over the production line model. Note the use of the status schema for both the production line and for each production step:

    ```json
    {
        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_line;1",
        "@type": "Interface",
        "displayName": "Factory Production Line - Interface Model",
        "@context": "dtmi:dtdl:context;2",
        "contents": [
            {
                "@type": "Property",
                "name": "LineId",
                "schema": "string",
                "writable": true
            },
            {
                "@type": "Property",
                "name": "LineOperationStatus",
                "schema": "dtmi:com:microsoft:iot:e2e:digital_factory:production_line:status;1",
                "writable": true
            },
            {
                "@type": "Relationship",
                "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_line:rel_runs_steps;1",
                "name": "rel_runs_steps",
                "displayName": "Runs steps",
                "properties": [
                    {
                        "@type": "Property",
                        "name": "active",
                        "schema": "dtmi:com:microsoft:iot:e2e:digital_factory:production_line:status;1"
                    }
                ]
            }
        ],
        "schemas":  {
            "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_line:status;1",
            "@type": "Enum",
            "valueSchema": "integer",
            "enumValues": [
                {
                "name": "offline",
                "displayName": "Offline",
                "enumValue": 1
                },
                {
                "name": "online",
                "displayName": "Online",
                "enumValue": 2
                }
            ]
        }
    }
    ```

1. Copy the production line model and save it to your factory folder, with the name **ProductionLineInterface.json**.

## Create a production line step model

The production line consists of three steps: roasting, grinding, and molding.

Because several properties of any step are going to be identical, you'll create a *base* model that the specific steps can inherit from:

| Element | Type | Description |
| --------- | ---- | ----------- |
Step ID | Property | A unique ID for the production step, perhaps including the name of the step.
`StartTime` | Property | A start time for the step.
`FinalStep` | Property | A Boolean value, set to true if this is the last step of the production line.
`OperationStatus` | Property with schema | A property that indicates whether the step is online or not.
`StepLink` | Relationship | The relationship of the production line step to the other steps.

1. Look over the definition for the production line step model:

    ```json
    {
        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step;1",
        "@type": "Interface",
        "displayName": "Factory Production Steps - Interface Model",
        "@context": "dtmi:dtdl:context;2",
        "contents": [
            {
                "@type": "Property",
                "name": "StepId",
                "schema": "string"
            },
            {
                "@type": ["Property"],
                "name": "StartTime",
                "schema": "dateTime"
            },
            {
                "@type": "Property",
                "name": "FinalStep",
                "schema": "boolean"
            },
            {
                "@type": "Property",
                "name": "OperationStatus",
                "schema": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step:status;1",
                "writable": true
            },
            {
                "@type": "Relationship",
                "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step:rel_step_link;1",
                "name": "rel_step_link",
                "displayName": "Step link",
                "properties": [
                    {
                        "@type": "Property",
                        "name": "FinalStep",
                        "schema": "boolean"
                    }
                ]
            }
        ],
        "schemas":  {
            "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step:status;1",
            "@type": "Enum",
            "valueSchema": "integer",
            "enumValues": [
                {
                "name": "offline",
                "displayName": "Offline",
                "enumValue": 1
                },
                {
                "name": "online",
                "displayName": "Online",
                "enumValue": 2
                }
            ]
        }
    }
    ```

1. Save the step model to your factory folder, and name the file **ProductionStepInterface.json**.

## Create the specific production line step models

The production line step models extend a base model. The following table shows the fields you need, in addition to those inherited from the production line step model.

### Create the roasting step model

:::image type="content" source="../media/roasting.png" alt-text="Image of the roasting step." lightbox="../media/roasting.png":::

The roasting model needs a few physics-related properties:

| Element | Type | Description |
| --------- | ---- | ----------- |
`ChasisTemperature` | Property with units | Temperature of the fanning/roasting machine.
`RoastingTime` | Property with units | An integer number of minutes to roast the beans.
`PowerUsage` | Property with units | The kilowatt power usage of the machine.
`FanSpeed` | Property | The speed of the roasting fan. (Now you know why the process is known as "fanning"!)

1. In the following definition for the roasting step, note the `extends` construct. Also note that *only* the `ChasisTemperature` property is writable:

    ```json
    {
        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_roasting;1",
        "@type": "Interface",
        "extends": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step;1",
        "displayName": "Factory Production Step: Fanning/Roasting - Interface Model",
        "@context": "dtmi:dtdl:context;2",
        "contents": [
            {
                "@type": ["Property", "Temperature"],
                "name": "ChasisTemperature",
                "schema": "double",
                "unit": "degreeCelsius",
                "writable": true
            },
            {
                "@type": ["Property", "TimeSpan"],
                "name": "RoastingTime",
                "schema": "integer",
                "unit": "minute"
            },
            {
                "@type": ["Property", "Power"],
                "name": "PowerUsage",
                "schema": "double",
                "unit" : "kilowatt"
            },
            {
                "@type": "Property",
                "name": "FanSpeed",
                "schema": "double"
            }
        ]
    }
    ```

1. Save the roasting model to your factory folder, and name it **ProductionStepRoasting.json**.

### Create the grinding step model

:::image type="content" source="../media/grinding.png" alt-text="Image of the grinding step." lightbox="../media/grinding.png":::

The next step is grinding, with similar properties to roasting:

| Element | Type | Description |
| --------- | ---- | ----------- |
`ChasisTemperature` | Property with units | Temperature of the grinding machine.
`GrindingTime` | Property with units | An integer number of minutes to grind the beans.
`PowerUsage` | Property with units | The kilowatt power usage of the machine.
Force | Property | The force, in pounds, of the steel grinding plates.

1. Note the following definition for the grinding step:

    ```json
    {
        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_grinding;1",
        "@type": "Interface",
        "extends": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step;1",
        "displayName": "Factory Production Step: Grinding/Crushing - Interface Model",
        "@context": "dtmi:dtdl:context;2",
        "contents": [
            {
                "@type": ["Property", "Temperature"],
                "name": "ChasisTemperature",
                "schema": "double",
                "unit": "degreeCelsius",
                "writable": true
            },
            {
                "@type": ["Property", "TimeSpan"],
                "name": "GrindingTime",
                "schema": "integer",
                "unit": "minute"
            },
            {
                "@type": ["Property", "Power"],
                "name": "PowerUsage",
                "schema": "double",
                "unit" : "kilowatt"
            },
            {
                "@type": ["Property", "Force"],
                "name": "Force",
                "schema": "double",
                "unit": "pound"
            }
        ]
    }
    ```

1. Copy the grinding step model into a file named **ProductionStepGrinding.json**, and save it to your factory models folder.

### Create the molding step model

:::image type="content" source="../media/molding.png" alt-text="Image of the molding step." lightbox="../media/molding.png":::

The final step is molding, which only includes a couple of properties:

| Element | Type | Description |
| --------- | ---- | ----------- |
`ChasisTemperature` | Property with units | Temperature of the molding machine.
`PowerUsage` | Property with units | The kilowatt power usage of the machine.

1. Note following definition for the molding step:

    ```json
    {
        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_molding;1",
        "@type": "Interface",   
        "displayName": "Factory Production Step: Molding - Interface Model",
        "extends": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step;1",
        "@context": "dtmi:dtdl:context;2",
        "contents": [
            {
                "@type": ["Property", "Temperature"],
                "name": "ChasisTemperature",
                "schema": "double",
                "unit": "degreeCelsius",
                "writable": true
            }, 
            {
                "@type": ["Property", "Power"],
                "name": "PowerUsage",
                "schema": "double",
                "unit" : "kilowatt"
            }
        ]
    }
    ```

1. Save the molding step model into a file called **ProductionStepMolding.json**, and save it to your factory models folder.

## Next steps

You have created a total of seven models. While the real process of making chocolate has been simplified, you've created digital models of sufficient complexity that visually verifying them as accurate is tough.

The next step is to validate your work so far. Thankfully, there's a sample application to do this. You can run this app on your digital twin models to make sure they're all valid.
