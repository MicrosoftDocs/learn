In an Azure Digital Twins solution, Models provide the blueprint that is used to create the digital twin entities within your Azure Digital Twins environment.

Consider this example of an Azure Digital Twins environment expressed as a graph.

:::image type="content" source="../media/m11-l02-simple-twins-environment-fb572ff0.png" alt-text="Diagram that shows an Azure Digital Twins graph that represents a small building with two floors and one room on each floor.":::


The nodes that you see in this graph are the digital twin instances that were created using the corresponding Model (either a Floor or a Room model).

Models have names (such as Floor, Room, or TemperatureSensor), and contain elements such as properties, telemetry/events, and relationships that describe how the digital twin entities are related to each other within your environment.

## Elements of a model

Azure Digital Twins models are defined using the Digital Twins Definition Language (DTDL), which is expressed using a JSON-style coding format. Within a model definition, the top-level code item is an Interface, which encapsulates the entire model.

A DTDL model interface may contain zero, one, or many of each of the following fields:

 -  Property - Properties are data fields that represent the state of an entity (like the properties in many object-oriented programming languages). Properties have backing storage and can be read at any time.
 -  Telemetry - Telemetry fields represent measurements or events, and are often used to describe device sensor readings. Unlike properties, telemetry is not stored on a digital twin; it is a series of time-bound data events that need to be handled as they occur. For more on the differences between property and telemetry, see the Properties vs. telemetry section below.
 -  Component - Components allow you to build your model interface as an assembly of other interfaces, if you want. An example of a component is a frontCamera interface (and another component interface backCamera) that are used in defining a model for a phone. You must first define an interface for frontCamera as though it were its own model, and then you can reference it when defining Phone. Use a component to describe something that is an integral part of your solution but doesn't need a separate identity, and doesn't need to be created, deleted, or rearranged in the twin graph independently. If you want entities to have independent existences in the twin graph, represent them as separate digital twins of different models, connected by relationships (see next bullet).
 -  Relationship - Relationships let you represent how a digital twin can be involved with other digital twins. Relationships can represent different semantic meanings, such as contains ("floor contains room"), cools ("hvac cools room"), isBilledTo ("compressor is billed to user"), etc. Relationships allow the solution to provide a graph of interrelated entities.

## Differentiating between property and telemetry fields

Since property and telemetry fields could both represent numeric data, it may not be obvious when or where each should be used. Here is some more guidance on distinguishing between DTDL property and telemetry fields in Azure Digital Twins.

The difference between properties and telemetry for Azure Digital Twins models is as follows:

 -  Properties are expected to have backing storage (a stored and accessible value). You can read a property at any time and retrieve its value. If the property is writeable, you can also assign a value to the property.
 -  Telemetry is more like a stream of events; it’s a set of data messages that have short lifespans. If you don't monitor for a telemetry event and take actions when it happens, there is no trace of the event at a later time. You can't come back to it and read it later.
    
     -  In C\# terms, telemetry is like a C\# event.
     -  In IoT terms, telemetry is typically a data value sent by a device at a specified time interval.

## Applying property and telemetry fields in an IoT context

When designing a model, a telemetry field is often used in models that represent IoT devices. In this case, you will typically monitor incoming device data and take actions as the data arrives.

A property field is used most often when designing a model because properties provide you with backing storage and the ability to read and query the data fields.

Telemetry and property fields are often be used together to handle data ingress from devices. As all ingress to Azure Digital Twins is via APIs, you will typically use your ingress function to read telemetry or property events from devices, and then set a property field value in response.

You can also publish a telemetry event from the Azure Digital Twins API. As with other telemetry, that is a short-lived event that requires a listener to handle.

### Property and telemetry fields example

Consider the following example:

 -  IoT hub: IoT device with temperature sensor is connected to IoT hub.
 -  Azure Digital Twins model - telemetry field: Azure Function is used to deliver IoT telemetry data to Azure Digital Twins device twin (temp01).
 -  Azure Digital Twins model - property field: Monitor temp01 telemetry field events and capture “last received” value and “last received time” value. Store values in last\_received and last\_received\_time property fields.
 -  Query model properties: Query as needed to extract most recently reported temperature and time.

:::image type="content" source="../media/m11-l02-telemetry-property-fields-twins-model-89781ba3.png" alt-text="Diagram that shows how property and telemetry fields are used within an Azure Digital Twins solution."  lightbox="../media/m11-l02-telemetry-property-fields-twins-model-89781ba3.png":::
