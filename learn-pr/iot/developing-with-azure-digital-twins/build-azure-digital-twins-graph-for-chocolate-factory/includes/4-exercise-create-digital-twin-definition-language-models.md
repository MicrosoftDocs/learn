Let's build some models for real. In this module, we want to create a collection of models that resemble a real-life industrial scenario. For this reason, there's some complexity, and some work, in putting this collection of models together. The result will be a much better learning experience, and, when we come to graphing the models, our scenario will provide deeper insights into the digital twin world. With this greater realism in mind, we're going to need to create a number of models.

Before we start at the top, and define a model for a factory, create a folder, say in your **Documents** folder, with a name such as **factory-models**. You can use any tool that works well with text files, to create these models. Good choices include Visual Studio, Visual Studio Code, or even Notepad.

## Create a model for a chocolate factory.

1. For the factory itself, let's create a model with the following properties and relationships.

| Component | Type | Description |
| --------- | ---- | ----------- |
Factory name | Property | A friendly name for the factory.
Geo location | Property with fields | Geo location (latitude, longitude) of the factory.
Has floors  | Relationship | The factory has floors, identified by the `dtmi:com:microsoft:iot:e2e:digital_factory:floor;1` ID.

1. Look over the following model definition, noting how our three components are defined.

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

1. Create a new file in your text editor, and copy and paste in the factory model. Save it with the name **FactoryInterface.json** to your **factory-models** folder.

## Create a model for a factory floor

1. For the factory floor, let's give it an ID, and keep tabs on the ambient temperature of the floor. We also need the relationship that a floor contains production lines.

| Component | Type | Description |
| --------- | ---- | ----------- |
Floor ID | Property | A unique ID for the floor.
Temperature | Property with units | Ambient temperature of the floor.
Runs production lines  | Relationship | The floor has production lines, identified by the `dtmi:com:microsoft:iot:e2e:digital_factory:production_line;1` ID.

1. Again, look over the following model definition. Noting how a property with specific units is defined.

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

1. Create a new file in your text editor, and copy and paste in the factory floor model. Save it with the name **FactoryFloorInterface.json**, again to your **factory-models** folder.

## Create a production line model

1. Now things get a bit more complex. We need to define a model for a production line, that will cope with the multiple steps, and multiple pieces and types of equipment that are in use.

| Component | Type | Description |
| --------- | ---- | ----------- |
Line ID | Property | A unique ID for the production line. Perhaps a floor could contain more than one line.
LineOperationStatus | Property with schema | A property that indicates whether the production line is online (running), or not.
Runs steps  | Relationship | The production lines runs production steps, identified by the `dtmi:com:microsoft:iot:e2e:digital_factory:production_line:rel_runs_steps;1` ID. The steps also have an online/offline status property.

1. Look over the production line model. Note the use of the status schema, for both the production line, and for each production step.

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

1. Copy the model above, and save it to your factory folder, with the name **ProductionLineInterface.json**.

## Create a production line step model

The production line consists of three steps: roasting, grinding, molding. 

As several properties of any step are going to be identical, let's create a _base_ model, that the specific steps can inherit from. 

| Component | Type | Description |
| --------- | ---- | ----------- |
Step ID | Property | A unique ID for the production step, perhaps including the name of the step.
StartTime | Property | A start time for the step.
FinalStep | Property | A boolean value, set to true if this is the last step of the production line.
OperationStatus | Property with schema | A property that indicates whether the step is online, or not.
StepLink | Relationship | The relationship of the production line step, to the other steps.

1. Look over the definition for the production line step model. 

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

1. Save the step model to your factory folder, with the name **ProductionStepInterface.json**.

## Create the specific production line step models

The new concept that the production line step models bring, is that of _extending_ a base model. The following table shows the fields we need, in addition to those inherited from the production line step model.

### Create the roasting step model

[![Graphical representation of the roasting step](../media/adt-roasting.png)](../media/adt-roasting.png#lightbox)

The roasting model needs a few physics related properties.

| Component | Type | Description |
| --------- | ---- | ----------- |
ChasisTemperature | Property with units | Temperature of the fanning/roasting machine.
RoastingTime | Property with units | An integer number of minutes to roast the beans.
PowerUsage | Property with units | The kilowatt power usage of the machine.
FanSpeed | Property | The speed of the roasting fan. Now you know why the process is known as "fanning"!

1. In the following definition for the roasting step, note the **extends** construct. Also note that _only_ the **ChasisTemperature** property is writable.


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

1. Save the roasting model to your factory folder, with the name **ProductionStepRoasting.json**.


### Create the grinding step model

[![Graphical representation of the grinding step](../media/adt-grinding.png)](../media/adt-grinding.png#lightbox)

The next step is grinding, with similar properties to roasting.

| Component | Type | Description |
| --------- | ---- | ----------- |
ChasisTemperature | Property with units | Temperature of the grinding machine.
GrindingTime | Property with units | An integer number of minutes to grind the beans.
PowerUsage | Property with units | The kilowatt power usage of the machine.
Force | Property | The force, in pounds, of the steel grinding plates.

1. Copy and paste the following definition for the grinding step, into a file called **ProductionStepGrinding.json**.

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

1. Save the file to your factory models folder.

### Create the molding step model

[![Graphical representation of the molding step](../media/adt-molding.png)](../media/adt-molding.png#lightbox)

The final step is molding, with just a couple of properties.

| Component | Type | Description |
| --------- | ---- | ----------- |
ChasisTemperature | Property with units | Temperature of the molding machine.
PowerUsage | Property with units | The kilowatt power usage of the machine.

1. Copy and paste the following definition for the molding step, into a file called **ProductionStepMolding.json**.

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

1. Save the file to your factory models folder.

## Next steps

You have created a total of seven models. Whereas we've simplified the real process of making chocolate, we've created digital models of sufficient complexity that visually verifying them as accurate is tough. The next step is to validate our work so far. Thankfully, there's a tool to do this. So, without further ado, let's run this tool on our digital twin models.
