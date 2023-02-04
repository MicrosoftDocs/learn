Models for Azure Digital Twins are defined using the Digital Twins Definition Language (DTDL), which is based on JSON-LD and is programming-language independent.

Azure Digital Twins uses DTDL version 2. For more information about this version of DTDL, see its spec documentation in GitHub: [Digital Twins Definition Language (DTDL) - version 2](https://github.com/Azure/opendigitaltwins-dtdl/blob/master/DTDL/v2/DTDL.v2.md). Use of DTDL version 1 with Azure Digital Twins has now been deprecated.

> [!NOTE]
> DTDL is not exclusive to Azure Digital Twins, but is also used to represent device data in other IoT services such as IoT Plug and Play. Not all services that use DTDL implement the exact same features of DTDL. For example, IoT Plug and Play does not use the DTDL features that are for graphs, while Azure Digital Twins does not currently implement DTDL commands.

## Azure Digital Twins DTDL implementation specifics

For a DTDL model to be compatible with Azure Digital Twins, it must meet these requirements.

 -  All top-level DTDL elements in a model must be of type interface. Azure Digital Twins model APIs can receive JSON objects that represent either an interface or an array of interfaces. As a result, no other DTDL element types are allowed at the top level.
 -  DTDL for Azure Digital Twins must not define any commands.
 -  Azure Digital Twins only allows a single level of component nesting. This requirement means that an interface that's being used as a component can't have any components itself.
 -  Interfaces can't be defined inline within other DTDL interfaces; they must be defined as separate top-level entities with their own IDs. Then, when another interface wants to include that interface as a component or through inheritance, it can reference its ID.

Azure Digital Twins also does not observe the writable attribute on properties or relationships. Although this can be set as per DTDL specifications, the value isn't used by Azure Digital Twins. Instead, these are always treated as writable by external clients that have general write permissions to the Azure Digital Twins service.

## Example model code

Twin type models can be written in any text editor. The DTDL language follows JSON syntax, so you should store models with the extension .json. Using the JSON extension will enable many programming text editors to provide basic syntax checking and highlighting for your DTDL documents.

Consider a solar system environment that contains models for planets, each with a name, a mass, and a temperature. Each of the planets may also interact with moons that are their satellites, and the planets may contain craters. In the DTDL code example below, the Planet model expresses connections to these other entities by referencing two external models—Moon and Crater. These external models are also defined in the example code below, but are kept simple so as not to detract from the primary Planet example.

```json
[
{
  "@id": "dtmi:com:contoso:Planet;1",
  "@type": "Interface",
  "@context": "dtmi:dtdl:context;2",
  "displayName": "Planet",
  "contents": [
    {
      "@type": "Property",
      "name": "name",
      "schema": "string"
    },
    {
      "@type": "Property",
      "name": "mass",
      "schema": "double"
    },
    {
      "@type": "Telemetry",
      "name": "Temperature",
      "schema": "double"
    },
    {
      "@type": "Relationship",
      "name": "satellites",
      "target": "dtmi:com:contoso:Moon;1"
    },
    {
      "@type": "Component",
      "name": "deepestCrater",
      "schema": "dtmi:com:contoso:Crater;1"
    }
  ]
},
{
  "@id": "dtmi:com:contoso:Crater;1",
  "@type": "Interface",
  "@context": "dtmi:dtdl:context;2"
},
{
  "@id": "dtmi:com:contoso:Moon;1",
  "@type": "Interface",
  "@context": "dtmi:dtdl:context;2"
}
]

```

The fields of the model are:

:::row:::
  :::column:::
    **Field**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    @id
  :::column-end:::
  :::column:::
    An identifier for the model. Must be in the following format:
`dtmi:<domain>:<unique model identifier>;<model version number>`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    @type
  :::column-end:::
  :::column:::
    Identifies the kind of information being described. For an interface, the type is Interface.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    @context
  :::column-end:::
  :::column:::
    Sets the context for the JSON document. Models should use the following:
`dtmi:dtdl:context;2`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    displayName
  :::column-end:::
  :::column:::
    (optional) Allows you to give the model a friendly name if desired.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    contents
  :::column-end:::
  :::column:::
    All remaining interface data is placed here, as an array of attribute definitions.
Each attribute must provide an @type (Property, Telemetry, Command, Relationship, or Component) to identify the type of interface information it describes, and then a set of properties that define the actual attribute (for example, name and schema to define a Property).
  :::column-end:::
:::row-end:::


> [!NOTE]
> Notice that the component interface (either Crater or Moon in the json example) is defined in the same array as the interface that uses it (Planet). Components must be defined this way in API calls in order for the interface to be found.

## Possible schemas

As per DTDL, the schema for Property and Telemetry attributes can be of standard primitive types—integer, double, string, and Boolean—and other types such as DateTime and Duration.

In addition to primitive types, Property and Telemetry fields can have these complex types:

 -  Object
 -  Map
 -  Enum

Telemetry fields also support the Array type.

## Model inheritance

Sometimes, you may want to specialize a model further. For example, it might be useful to have a generic model Room, and specialized variants ConferenceRoom and Gym. To express specialization, DTDL supports inheritance: interfaces can inherit from one or more other interfaces.

The following example reimagines the Planet model from the earlier DTDL example as a subtype of a larger CelestialBody model. The "parent" model is defined first, and then the "child" model builds on it by using the field “extends”.

```json
[
{
    "@id": "dtmi:com:contoso:CelestialBody;1",
    "@type": "Interface",
    "@context": "dtmi:dtdl:context;2",
    "displayName": "Celestial body",
    "contents": [
    {
        "@type": "Property",
        "name": "name",
        "schema": "string"
    },
    {
        "@type": "Property",
        "name": "mass",
        "schema": "double"
    },
    {
        "@type": "Telemetry",
        "name": "temperature",
        "schema": "double"
    }
    ]
},
{
    "@id": "dtmi:com:contoso:Planet;1",
    "@type": "Interface",
    "@context": "dtmi:dtdl:context;2",
    "displayName": "Planet",
    "extends": "dtmi:com:contoso:CelestialBody;1",
    "contents": [
    {
        "@type": "Relationship",
        "name": "satellites",
        "target": "dtmi:com:contoso:Moon;1"
    },
    {
        "@type": "Component",
        "name": "deepestCrater",
        "schema": "dtmi:com:contoso:Crater;1"
    }
    ]
},
{
    "@id": "dtmi:com:contoso:Crater;1",
    "@type": "Interface",
    "@context": "dtmi:dtdl:context;2"
}
]

```

In this example, CelestialBody contributes a name, a mass, and a temperature to Planet. The extends section is an interface name, or an array of interface names (allowing the extending interface to inherit from multiple parent models if desired).

Once inheritance is applied, the extending interface exposes all properties from the entire inheritance chain.

The extending interface cannot change any of the definitions of the parent interfaces; it can only add to them. It also cannot redefine a capability already defined in any of its parent interfaces (even if the capabilities are defined to be the same). For example, if a parent interface defines a double property mass, the extending interface cannot contain a declaration of mass, even if it's also a double.
