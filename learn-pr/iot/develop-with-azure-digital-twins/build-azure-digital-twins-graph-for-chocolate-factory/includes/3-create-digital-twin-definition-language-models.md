In this unit, we examine the Digital Twins Definition Language (DTDL) by going over the main components of the language, and looking at some examples. DTDL is based on the widely used Json script language.

## Introduction to models

DTDL is used to build _models_. Think of a model as the data elements of a C# class. The model defines the characteristics of a real-world object. The level of detail, and the size of the object, are entirely up to you. The object may be as small as a temperature sensor, as grand as a building, or factory, and as diverse as a sensor, a person, a vehicle, a process, or about anything relevant to your operations. 

Models have names, and later on in this module you will create digital twins of the models.

Within the DTDL language, the top-level type is an _interface_. This encapsulates the entire model, and the rest of the model is defined within the interface.

Models are made of four main parts: _Properties_, _Telemetry_, _Components_, and _Relationships_. A model interface can have zero, one, or many, of each of these parts. Let's examine each in turn, with a short example.

## Property

Property is both the most common part of a model, and one of the easiest to define. For example, to define a string ID:

```json
  {
    "@type": "Property",
    "name": "LineId",
    "schema": "string",
    "writable": true
  },
```

It's possible to define a _semantic type_ for a property. A semantic type typically is a physical unit: temperature, pressure, voltage, and so on. For example, to set a temperature semantic type for a _set temperature_ property, add the **unit** entry, and extend the **type** definition:

```json
  {
    "@type": ["Property", "Temperature"],
    "name": "setTemperature",
    "schema": "double",
    "unit": "degreeCelsius",
    "writable": true
  }

```

In addition to Celsius, `degreeFarenheit`, and even `degreeKelvin` are acceptable units.

The **type**, **name**, and **schema** are the only required entries for a property. There's a range of optional entries, including **@id**, **description**, **displayName**, and some others. The **writable** entry is optional, and defaults to _false_.

>[!Note]
>Refer to the DTDL spec for a full list of required and optional entries, and the complete list of acceptable units. A link is in the **Summary** page.

Most models contain a range of properties.

## Telemetry

Telemetry is most often envisioned as a continuous stream of readings: temperature, pressure, location, altitude, and so on. In the context of digital twin models, telemetry also includes computed data, and even occasional error or information messages.

For a continuous stream of telemetry values, define an object in your model such as:

```json
  {
    "@type": ["Telemetry", "Temperature"],
    "name": "temperature",
    "schema": "double",
    "unit": "degreeCelsius"
  }
```

Similar to properties, only **type**, **name**, and **schema** are required entries for telemetry. The _cadence_ and content of the telemetry are _not_ set in the digital twin model. These values would be set by software that uses the digital twin model as one of its inputs. We've quite a few Learn module's to go through before delving into this level of complexity!

## Component

Components are, as you might guess, model definitions that are defined elsewhere, but are included within the current model by reference.

For example, say a _sensor_ was defined in another model definition, with the ID `dtmi:com:example:Sensor;1`. To use that definition as a component in another model:

```json
   {
    "@type": "Component",
    "name": "Sensor",
    "schema": "dtmi:com:example:Sensor;1"
  }
```

Components are a similar concept to inheritance in C#. Again,  **type**, **name**, and **schema** are the required entries.

## Relationship

A _relationship_ is perhaps the most interesting of the model definition constructs. A relationship is a link to any other digital twin model. There's not a predefined list of the types of relationship you can have, you can define any type of relationship you like. For example, "contains" is a common use, however, you could define a relationship as "is connected to", "owes money to", "lies on the floor of", "has on the walls", or anything that works for your scenario.

You can set the entry **maxMultiplicity**, which is optional. For example, if your model was a train, that can contain passenger models, **maxMultiplicity** would be the capacity of the train.

As an example from our chocolate factory scenario. The definition of a factory floor includes the following relationship to production lines:

```json
  {
    "@type": "Relationship",
    "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:floor:rel_runs_lines;1",
    "name": "rel_runs_lines",
    "displayName": "Runs production lines",
    "target": "dtmi:com:microsoft:iot:e2e:digital_factory:production_line;1"
  }
```

For this relationship to validate correctly, the **target** must be an ID for a production line.

Another, slightly more complicated example. A production line contains many _steps_. The following definition attaches an **active** property to the steps.

```json

 {
   "@type": "Relationship",
   "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:production_line:rel_runs_steps;1",
   "name": "rel_runs_steps",
   "displayName": "Runs Steps",
   "properties": [
      {
        "@type": "Property",
        "name": "active",
        "schema": "dtmi:com:microsoft:iot:e2e:digital_factory:production_line:status;1"
      }
    ]
  },
```

We've now covered the main four parts of a model.

Finally, let's look at a complete model definition.

## Examine some complete models

Take a look at the following listing, which defines a model for a factory.

```json
[
  {
    "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:chocolate_factory;1",
    "@type": "Interface",
    "displayName": "Digital Factory - Interface Model",
    "@context": "dtmi:dtdl:context;2",
    "contents": [
      {
        "@type": "Property",
        "name": "FactoryId",
        "schema": "string"
      },
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
        "@type": "Property",
        "name": "Tags",
        "schema": "string",
        "writable": true
      },
      {
        "@type": "Relationship",
        "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:chocolate_factory:rel_has_floors;1",
        "name": "rel_has_floors",
        "displayName": "Has Floors",
        "target": "dtmi:com:microsoft:iot:e2e:digital_factory:floor;1"
      }
    ]
  }
]
```

Looking at the listing, note the following entries:

- The **@Id** entry is a unique ID, shown to a digital twins standard format.
- The initial **@type** entry must be **Interface**.
- The **displayName** is the friendly name of the model.
- **contents** contains objects of type **Telemetry**, **Property**, **Component**, and **Relationship**. Basic models may only contain one, or several, of these types.
- The **@context** value must be set to **"dtmi:dtdl:context;2"**.
- The **dtmi** that you see in the IDs, stands for a  _Digital Twin Model Identifier_. The IDs shown in the examples follow standard practice for digital twin ID format.

The factory is an example of a digital twin model of a large complex object, which would require many subcomponents to be realistic. At the other end of the spectrum, a digital twin model can represent something as small as a thermostat.

``` json
  {
      "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:Thermostat;1",
      "@type": "Interface",
      "displayName": "Thermostat",
      "contents": [
          {
            "@type": "Telemetry",
            "name": "temperature",
            "schema": "double"
          },
          {
            "@type": ["Property", "Temperature"],
            "name": "setTemperature",
            "schema": "double",
            "unit": "degreeCelsius",
            "writable": true
          },
          {
            "@type": "Property",
            "name": "switch",
            "schema": "dtmi:com:microsoft:iot:e2e:digital_factory:thermostat:status;1",
            "writable": true
          }
      ],
      "schemas":  {
      "@id": "dtmi:com:microsoft:iot:e2e:digital_factory:thermostat:status;1",
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
    "@context": "dtmi:dtdl:context;2"
  }
```

The definition of the thermostat shows another DTDL construct, the **Enum**. Notice that the **switch** property references the enum through its **schema**. 

The operation of this model is implied. If the **switch** property is set to **offline**, nothing happens. If set to **online**, telemetry values for temperature are generated. The thermostat can also be used to set a desired temperature. This value would be communicated to a model of type _furnace_, or similar, to actually alter the generation of heat, or cooling air. 

Code would be written to actually operate the thermostat, say as part of a simulation. The model helps structure the code that needs to be written. This implied structure is one of the key advantages of using the DTDL modeling language: it helps clearly define what is going to be simulated, and what is out of scope.

## Next step

The next step in this module, is to use what we've learned about the model definition language, to create a range of models for a chocolate factory production line. 

