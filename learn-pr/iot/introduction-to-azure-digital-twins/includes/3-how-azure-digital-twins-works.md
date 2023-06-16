Here, you'll learn more about how an Azure Digital Twins solution is built. You'll see these concepts applied to the factory module scenario, and understand how an Azure Digital Twins graph might look for that environment.

## Define models

In Azure Digital Twins, you freely define the types of digital entities that represent your environment, including the people, places, and things that it contains. Using the vocabulary that fits your business, you define your own twin types in terms of their properties, telemetry, components, and relationships. These custom twin types are called **models**.

>[!TIP]
>From a programming perspective, models are similar to class definitions.

Models for Azure Digital Twins are defined using the [Digital Twins Definition Language (DTDL)](https://github.com/Azure/opendigitaltwins-dtdl/tree/master/DTDL). DTDL is based on JSON-LD and is programming-language independent, so you can write it in any text editor by creating valid DTDL files with a *json* extension. DTDL isn't exclusive to Azure Digital Twins; it's also used to represent device data in other IoT services such as IoT Plug and Play. You can design your own model sets from scratch, or get started with a pre-existing set of industry ontologies provided by Microsoft based on common vocabulary for your industry. You can also bring models from outside of Azure Digital Twins and convert them to DTDL, to make them compatible with Azure Digital Twins. If you design models from scratch, you may still want to consider using published industry standards in your solution language to help make them more recognizable and extensible.

The following code snippet shows the DTDL inside a model file. This example aligns with the factory scenario for this module and represents the concept of a robotic arm. The model has several properties representing box pickup information, including a boolean property indicating an alert that the latest package was not picked up, and a property representing its hydraulic pressure level.

```json
{
 "@id": "dtmi:assetGen:RobotArm;1",
 "@type": "Interface",
 "@context": "dtmi:dtdl:context;2",
 "displayName": "RobotArm",
 "contents": [
  {
   "@type": "Property",
   "name": "FailedPickupsLastHr",
   "schema": "integer"
  },
  {
   "@type": "Property",
   "name": "PickupFailedAlert",
   "schema": "boolean"
  },
  {
   "@type": "Property",
   "name": "PickupFailedBoxID",
   "schema": "string"
  },
  {
   "@type": "Property",
   "name": "HydraulicPressure",
   "schema": "double"
  }
 ]
}
```

The role of the model is to define the concept of what a robotic arm is, so you'll only create one model file to use for all the robotic arms in your environment. You'll also create additional models for other types of entity in your environment, such as a factory temperature sensor or the distribution center as a whole.

Model files can be uploaded to the service using the Azure Digital Twins APIs and SDKs, the Azure CLI, or Azure Digital Twins Explorer (a visual developer tool that's accessible from your instance page in the Azure portal).

Then, in the next section, you'll use the robot arm model definition to create multiple robotic arm twin entities to map to the specific, individual robot arms in your environment.

## Define twins

After creating models to define the types of entity in your environment, you create instances of each model to represent the actual, specific environment entities. These instances are called **digital twins** (or just **twins** for simplicity).

>[!TIP]
>From a programming perspective, twins are like instances of the model definitions.

Twins can be created using the Azure Digital Twins APIs and SDKs, the Azure CLI, or Azure Digital Twins Explorer (a visual developer tool that's accessible from your instance page in the Azure portal). In the request, you'll provide an ID for the twin (its `$dtID` value) and reference the model it should use. You can also optionally define properties during creation.

Once your twin has been created, you can retrieve it from the service as a JSON object.

Here's an example of a robotic arm twin, created using the robotic arm model from the previous section. In the factory example for this module, you'll have many similar twins, one for each arm in your factory. This is the twin for *Arm1*, and the model properties are set to actual values based on what the physical *Arm1* device is experiencing and reporting through its IoT data.

```json
{
  "$dtId": "Arm1",
  "$etag": "W/\"3b8f6202-1924-41ae-83fa-0f037cf36e3a\"",
  "$metadata": {
    "$lastUpdateTime": "2023-03-10T16:00:06.4554504Z",
    "$model": "dtmi:assetGen:RobotArm;1",
    "FailedPickupsLastHr": {
      "lastUpdateTime": "2022-11-08T15:02:59.1706116Z"
    },
    "HydraulicPressure": {
      "lastUpdateTime": "2022-11-08T15:02:59.1706116Z"
    },
    "PickupFailedAlert": {
      "lastUpdateTime": "2023-03-10T16:00:06.4554504Z"
    },
    "PickupFailedBoxID": {
      "lastUpdateTime": "2022-11-08T15:02:59.1706116Z"
    }
  },
  "FailedPickupsLastHr": 3,
  "HydraulicPressure": 17.451452874964478,
  "PickupFailedAlert": true,
  "PickupFailedBoxID": "Box506"
}
```

## Build a graph through relationships

Digital twins are connected to each other via **relationships** to form a conceptual graph of your complete environment. The types of relationship that a twin can have are defined in its [model definition](#define-models), and then specific twin-to-twin relationships are stored in the [twins](#define-twins) themselves.

In the factory example for this module, say you create a digital twin to represent this entire factory distribution center. (We'll only be looking at the arms in this center for now, but having a model definition for the distribution center would enable you to expand this solution to include multiple distribution centers later.)

The DTDL model definition for the distribution center will include this excerpt, allowing for a *contains* relationship with a robot arm:

```json
{
      "@type": "Relationship",
      "name": "contains",
      "target": "dtmi:assetGen:RobotArm;1"
    }
```

Then, when you create the digital twin for the distribution center, you'll add a *contains* relationship from the distribution center twin to any existing robot arm twins, using the Azure Digital Twins APIs and SDKs, the Azure CLI, or Azure Digital Twins Explorer (a visual developer tool that's accessible from your instance page in the Azure portal).

Here's a screenshot from Azure Digital Twins Explorer, showing a graph that contains one distribution center twin, *DistCtr*, and six robot arm twins, *Arm1* through *Arm6*. *DistCtr* has a *contains* relationship to each of the arm twins.

:::image type="content" source="../media/2-3-factory-graph.png" alt-text="Screenshot of Azure Digital Twins Explorer showing a 2D graph. In the graph, one distribution center twin is connected to six arm twins via six lines labeled contains." border="false" lightbox="../media/2-3-factory-graph.png":::

## Set up data flow

Now that you have a static graph representing the entities in your environment and their relationships to each other, it's time to set up **live data ingestion** into the graph, so that it stays current with the state of your real environment.

Using Azure functions, you can ingest data into your graph from many sources, including event data from IoT Hub devices and business data from across Azure or external applications. In the function body, you define how data is processed and map it to the correct twins in your graph. You can also create Azure functions to propagate data throughout the twin graph, so that when one twin receives an update, other related twins automatically update accordingly.

In the factory example for this module, you'll first make sure the robot arm devices are connected to **IoT Hub**, an Azure service for managing IoT devices in the cloud. Then, you'll create an **Azure function** that's connected to the IoT Hub, watching for device updates and routing them into Azure Digital Twins. The function body will also define how to process the data into the graph, making sure that data from each physical arm is used to update the properties on its corresponding digital twin. This will hydrate your graph with data that you can use to monitor the performance of each arm, to help you identify specific machines that are underperforming so they can be investigated, repaired, or replaced.

To help you monitor overall efficiency of box pickups in the distribution center, you'll also create an Azure function that aggregates data from all of the arm twins and updates properties on the main *DistCtr* twin that contains them all. Recall from the example in the [Define models](#define-models) section that each robot arm twin has an integer property *FailedPickupsLastHr*. You'll aggregate that data from all arm twins, using the following steps.

1. Create an event route in Azure Digital Twins that sends data to an Event Grid endpoint whenever *FailedPickupsLastHr* is updated on an arm twin.
1. Your Azure function listens on the endpoint for updates from the robot arm twins and receives the new data when any of them changes this value.
1. The function will use graph relationships to identify the distribution center twin that contains this arm twin, and from there identify the other arm twins that are contained within the same distribution center.
1. The function will compute a new average number of failed pickups from the value of *FailedPickupsLastHr* across all arm twins in the distribution center.
1. The function will update the value of a property on the *DistCtr* twin, *AvgFailedPickupsLastHr*, to reflect the new average of failed pickups across all the arms in the distribution center.

Now you have a live digital graph that represents the state of your factory distribution center and its robotic arms. You can view your digital twin graph in 2D using Azure Digital Twins Explorer, or in 3D using Azure Digital Twins [3D Scenes Studio](https://explorer.digitaltwins.azure.net/3dscenes).

In the next section, you'll see how to query the graph to gather insights and export data to other services (inside or outside of Azure) for further processing and data presentation.

## Query and export data

Now that your graph is complete and property values are regularly being updated, you can query your graph using the Azure Digital Twins APIs and SDKs, the Azure CLI, or Azure Digital Twins Explorer. Azure Digital Twins uses a custom **query language** that's similar to SQL, which can retrieve digital twins according to their properties, models, and relationships. Here's an example query that will return all robotic arms that currently hold a `PickupFailedAlert` value of True.

```SQL
SELECT * FROM DIGITALTWINS T WHERE T.PickupFailedAlert = True
```

One way to use the query results in the factory example for this module is to program them into custom applications or dashboards to display to factory operators in near-real time.

You can also query historized twin data collected over time using the **data history** feature, to have a wider pool of environment data and the ability to identify patterns over time. You can set up a data history connection that connects an Azure Digital Twins instance to an Azure Data Explorer cluster, so that graph updates are automatically stored in Azure Data Explorer. From there, you can query the data in Azure Data Explorer, and use the results however you'd like. In the factory example for this module, you'll want to collect this historical data so that whenever a robotic arm fails to pick up a package, you can investigate how frequent that behavior has been over the past day, week, month, etc. This will help you identify if the arm needs to be replaced.

For additional data processing or storage, you can create **event routes** that export digital twin data to endpoints in either Azure Event Grid, Azure Event Hubs, or Azure Service Bus. Other applications can watch these endpoints and receive the data there. Endpoints and event routes can be defined using the Azure Digital Twins APIs and SDKs or the Azure CLI. In the request, you'll provide the name of the Azure Digital Twins instance, the name of the Event Grid, Event Hubs, or Service Bus resource, and optional filter conditions to specify which events are routed there. If your company in the factory example is already using any database or external applications for distribution center monitoring, you can use event routes to integrate your Azure Digital Twins data into those solutions.
