Here, you'll learn more about how an Azure Digital Twins solution is built. You'll see these concepts applied to the factory module scenario, and understand how an Azure Digital Twins graph might look for that environment.

For a hands-on experience, this unit uses an Azure sandbox. Start by running the following commands in the Cloud Shell to create an Azure Digital Twins instance:

> [!IMPORTANT]
> If you receive an error with *code: LocationNotAvailableForResourceType*, try switching the location to [another available region](https://azure.microsoft.com/en-us/explore/global-infrastructure/products-by-region/?products=digital-twins).

```azurecli
    INSTANCE_NAME="Distribution-Center-$RANDOM"
    echo "Your Azure Digital Twins instance's name is: $INSTANCE_NAME"

    az dt create --dt-name $INSTANCE_NAME --resource-group <rgn>[sandbox resource group name]</rgn> --location westcentralus 
```

## Define models

In Azure Digital Twins, you freely define the types of digital entities that represent your environment, including the people, places, and things that it contains. Using the vocabulary that fits your business, you define your own twin types in terms of their properties, telemetry, components, and relationships. These custom twin types are called **models**.

>[!TIP]
>From a programming perspective, models are similar to class definitions.

Models for Azure Digital Twins are defined using the [Digital Twins Definition Language (DTDL)](https://github.com/Azure/opendigitaltwins-dtdl/tree/master/DTDL). DTDL is based on JSON-LD and is programming-language independent, so you can write it in any text editor by creating valid DTDL files with a *json* extension. DTDL isn't exclusive to Azure Digital Twins; it's also used to represent device data in other IoT services such as IoT Plug and Play. You can design your own model sets from scratch, or get started with a pre-existing set of industry ontologies provided by Microsoft based on common vocabulary for your industry. You can also bring external models and convert them to DTDL, to make them compatible with Azure Digital Twins. If you design models from scratch, you may still want to consider using published industry standards in your solution language to help make them more recognizable and extensible.

The following code snippet shows the DTDL inside a model file. This example aligns with the factory scenario for this module and represents the concept of a robotic arm. The model has several properties representing box pickup information, including a boolean property indicating an alert that the arm didn't pick up its latest package, and a property representing its hydraulic pressure level.

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
   "name": "LastPickupFailedBoxID",
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

The role of the model is to define the concept of what a robotic arm is, so you'll only create one model file to use for all the robotic arms in your environment. You'll also create other models for other types of entities in your environment, such as a factory temperature sensor or the distribution center as a whole.

Model files can be uploaded to the service using the Azure Digital Twins APIs and SDKs, the Azure CLI, or Azure Digital Twins Explorer (a visual developer tool that's accessible from your instance page in the Azure portal).

Run the following commands in the Cloud Shell to upload the *RobotArm* model, and another model for the entire distribution center, as inline JSON to your Azure Digital Twins instance in the sandbox.

```azurecli
    az dt model create -n $INSTANCE_NAME --models '{"@id":"dtmi:assetGen:RobotArm;1","@type":"Interface","@context":"dtmi:dtdl:context;2","displayName":"RobotArm","contents":[{"@type":"Property","name":"FailedPickupsLastHr","schema":"integer"},{"@type":"Property","name":"PickupFailedAlert","schema":"boolean"},{"@type":"Property","name":"LastPickupFailedBoxID","schema":"string"},{"@type":"Property","name":"HydraulicPressure","schema":"double"}]}' 

    az dt model create -n $INSTANCE_NAME --models '{"@id":"dtmi:assetGen:DistributionCenter;1","@type":"Interface","@context":["dtmi:dtdl:context;2"],"displayName":"DistributionCenter","contents":[{"@type":"Property","name":"AvgHydraulicPressure","schema":"double"},{"@type":"Relationship","name":"contains","properties":[{"@type":"Property","name":"targetModel","schema":"string"}],"target":"dtmi:assetGen:RobotArm;1"}]}'
```

Then, in the next section, you'll use the robot arm model definition to create multiple robotic arm twin entities to map to the specific, individual robot arms in your environment.

## Define twins

After creating models to define the types of entity in your environment, you create instances of each model to represent the actual, specific environment entities. These instances are called **digital twins** (or just **twins** for simplicity).

>[!TIP]
>From a programming perspective, twins are like instances of the model definitions.

Twins can be created using the Azure Digital Twins APIs and SDKs, the Azure CLI, or Azure Digital Twins Explorer. In the request, you'll provide an ID for the twin (its `$dtID` value) and reference the model it should use. You can also optionally define properties during creation.

Run the following commands in the Cloud Shell to create six robotic arm twins, all based on the *RobotArm* model from the previous section, and one distribution center twin based on the *DistributionCenter* model. These commands will also instantiate the twin properties with default values.

```azurecli
    az dt twin create --dt-name $INSTANCE_NAME --dtmi "dtmi:assetGen:RobotArm;1" --twin-id "Arm1" --properties '{"FailedPickupsLastHr": 0,"PickupFailedAlert": False,"HydraulicPressure": 0}'
    az dt twin create --dt-name $INSTANCE_NAME --dtmi "dtmi:assetGen:RobotArm;1" --twin-id "Arm2" --properties '{"FailedPickupsLastHr": 0,"PickupFailedAlert": False,"HydraulicPressure": 0}'
    az dt twin create --dt-name $INSTANCE_NAME --dtmi "dtmi:assetGen:RobotArm;1" --twin-id "Arm3" --properties '{"FailedPickupsLastHr": 0,"PickupFailedAlert": False,"HydraulicPressure": 0}'
    az dt twin create --dt-name $INSTANCE_NAME --dtmi "dtmi:assetGen:RobotArm;1" --twin-id "Arm4" --properties '{"FailedPickupsLastHr": 0,"PickupFailedAlert": False, "HydraulicPressure": 0}'
    az dt twin create --dt-name $INSTANCE_NAME --dtmi "dtmi:assetGen:RobotArm;1" --twin-id "Arm5" --properties '{"FailedPickupsLastHr": 0,"PickupFailedAlert": False, "HydraulicPressure": 0}'
    az dt twin create --dt-name $INSTANCE_NAME --dtmi "dtmi:assetGen:RobotArm;1" --twin-id "Arm6" --properties '{"FailedPickupsLastHr": 0,"PickupFailedAlert": False, "HydraulicPressure": 0}'

    az dt twin create --dt-name $INSTANCE_NAME --dtmi "dtmi:assetGen:DistributionCenter;1" --twin-id "DistCtr" --properties '{"AvgHydraulicPressure": 0}'
```

Once your twins have been created, you can retrieve them from the service as JSON objects.

Run the following command in the Cloud Shell to see the details of the *Arm1* twin returned from the service.

```azurecli
    az dt twin show --dt-name $INSTANCE_NAME --twin-id Arm1
```

## Build a graph through relationships

Digital twins are connected to each other via **relationships** to form a conceptual graph of your complete environment. The types of relationship that a twin can have are defined in its [model definition](#define-models), and then specific twin-to-twin relationships are stored in the [twins](#define-twins) themselves.

In the factory example for this module, say you create a digital twin to represent this entire factory distribution center. (We'll only be looking at the arms in this center for now, but having a model definition for the distribution center would enable you to expand this solution to include multiple distribution centers later.)

The DTDL model definition for the distribution center included this excerpt, allowing for a *contains* relationship with a robot arm:

```json
{
      "@type": "Relationship",
      "name": "contains",
      "target": "dtmi:assetGen:RobotArm;1"
    }
```

Run the following command in the Cloud Shell to create six *contains* relationships from the distribution center twin, each targeting one of the existing robot arm twins.

```azurecli
    az dt twin relationship create --dt-name $INSTANCE_NAME --relationship contains --relationship-id contains1 --source DistCtr --target Arm1
    az dt twin relationship create --dt-name $INSTANCE_NAME --relationship contains --relationship-id contains2 --source DistCtr --target Arm2
    az dt twin relationship create --dt-name $INSTANCE_NAME --relationship contains --relationship-id contains3 --source DistCtr --target Arm3
    az dt twin relationship create --dt-name $INSTANCE_NAME --relationship contains --relationship-id contains4 --source DistCtr --target Arm4
    az dt twin relationship create --dt-name $INSTANCE_NAME --relationship contains --relationship-id contains5 --source DistCtr --target Arm5
    az dt twin relationship create --dt-name $INSTANCE_NAME --relationship contains --relationship-id contains6 --source DistCtr --target Arm6
```

Here's a screenshot from Azure Digital Twins Explorer, displaying the graph in 2D that you've created in this unit so far. The graph has one distribution center twin, *DistCtr*, and six robot arm twins, *Arm1* through *Arm6*. *DistCtr* has a *contains* relationship to each of the arm twins.

:::image type="content" source="../media/2-3-factory-graph.png" alt-text="Screenshot of Azure Digital Twins Explorer showing a 2D graph. In the graph, one distribution center twin is connected to six arm twins via six lines labeled contains." border="false" lightbox="../media/2-3-factory-graph.png":::

You can view your digital twin graph in 2D using Azure Digital Twins Explorer, or in 3D using Azure Digital Twins 3D Scenes Studio. Run the following command in the Cloud Shell to create a direct URL to your Azure Digital Twins instance in Azure Digital Twins Explorer.

```azurecli
    echo "https://explorer.digitaltwins.azure.net/?dtId=$INSTANCE_NAME"
```

In another browser tab or window, navigate to the URL shown in the output of the previous command.

## Set up data flow

Now that you have a static graph representing the entities in your environment and their relationships to each other, you can set up **live data ingestion** into the graph, so that it stays current with the state of your real environment.

Azure Digital Twins uses Azure functions to ingest data into a graph from many sources, including event data from IoT Hub devices and business data from across Azure or external applications. In the function body, you define where the function watches for new data and how that data is processed, including how it maps to and updates the right twins in your graph. You can also create Azure functions to propagate data throughout the twin graph, so that when one twin receives an update, other related twins automatically update accordingly.

In the factory example for this module, your Azure function updates the properties of the robot arm twins based on data from their associated devices registered in IoT Hub, and you'll also create a second Azure function that aggregates data from all of the arm twins and updates properties on the main *DistCtr* twin that contains them all.

> [!NOTE]
> A complete simulation of live data flow is outside the scope of this introductory module, but you can simulate the results in your Cloud Shell by running the following commands to update the values of the twin properties manually.

```azurecli
    az dt twin update -n $INSTANCE_NAME --twin-id Arm1 --json-patch '[{"op":"replace","path":"/FailedPickupsLastHr","value":1},{"op":"replace","path":"/PickupFailedAlert","value":True},{"op":"add","path":"/LastPickupFailedBoxID","value":"Box507"},{"op":"replace","path":"/HydraulicPressure","value":18.451452874964478}]'
    az dt twin update -n $INSTANCE_NAME --twin-id Arm2 --json-patch '[{"op":"replace","path":"/HydraulicPressure","value":14.384850273058374}]'
    az dt twin update -n $INSTANCE_NAME --twin-id Arm3 --json-patch '[{"op":"replace","path":"/HydraulicPressure","value":16.378455483758937}]'
    az dt twin update -n $INSTANCE_NAME --twin-id Arm4 --json-patch '[{"op":"replace","path":"/HydraulicPressure","value":14.384850273058374}]'
    az dt twin update -n $INSTANCE_NAME --twin-id Arm5 --json-patch '[{"op":"replace","path":"/FailedPickupsLastHr","value":3},{"op":"replace","path":"/PickupFailedAlert","value":True},{"op":"add","path":"/LastPickupFailedBoxID","value":"Box845"},{"op":"replace","path":"/HydraulicPressure","value":24.45139457338478}]'
    az dt twin update -n $INSTANCE_NAME --twin-id Arm6 --json-patch '[{"op":"replace","path":"/FailedPickupsLastHr","value":7},{"op":"replace","path":"/PickupFailedAlert","value":True},{"op":"add","path":"/LastPickupFailedBoxID","value":"Box926"},{"op":"replace","path":"/HydraulicPressure","value":18.28457395755839}]'
    az dt twin update -n $INSTANCE_NAME --twin-id DistCtr --json-patch '[{"op":"replace","path":"/AvgHydraulicPressure","value":17.72259624}]'
```

Now your digital graph represents the state of your factory distribution center and its robotic arms.

In the next section, you'll see how to query the graph to gather insights and export data to other services (inside or outside of Azure) for further processing and data presentation.

## Query and export data

Now that your graph is complete and property values are updated, you can query your graph using the Azure Digital Twins APIs and SDKs, the Azure CLI, or Azure Digital Twins Explorer. Azure Digital Twins uses a custom **query language** that's similar to SQL, which can retrieve digital twins according to their properties, models, and relationships.

Run the following queries in your Cloud Shell to see information about your environment.

* Query to see all robotic arms that are contained within the distribution center's graph:

    ```azurecli
    az dt twin query --dt-name $INSTANCE_NAME --query-command "SELECT centerarms FROM DIGITALTWINS distCenter JOIN centerarms RELATED distCenter.contains WHERE distCenter.\$dtId = 'DistCtr'"
    ```

* Query to see the average hydraulic pressure of the distribution center:

    ```azurecli
    az dt twin query --dt-name $INSTANCE_NAME --query-command "SELECT AvgHydraulicPressure FROM DIGITALTWINS T WHERE T.\$dtId = 'DistCtr'"
    ```

* Query to see all robotic arms that currently hold a `PickupFailedAlert` value of True:

    ```azurecli
    az dt twin query --dt-name $INSTANCE_NAME --query-command 'SELECT * FROM DIGITALTWINS T WHERE T.PickupFailedAlert = True'
    ```

* Query to see any robotic arms that have failed more than five pickups in the last hour:

    ```azurecli
    az dt twin query --dt-name $INSTANCE_NAME --query-command 'SELECT * FROM DIGITALTWINS T WHERE T.FailedPickupsLastHr > 5'
    ``

One way to use the query results in the factory example for this module is to program them into custom applications or dashboards to display to factory operators in near-real time.

You can also query historized twin data collected over time using the **data history** feature, to have a wider pool of environment data and the ability to identify patterns over time. You can set up a data history connection that connects an Azure Digital Twins instance to an Azure Data Explorer cluster, so that graph updates are automatically stored in Azure Data Explorer. From there, you can query the data in Azure Data Explorer, and use the results however you'd like. In the factory example for this module, you'll want to collect this historical data so that whenever a robotic arm fails to pick up a package, you can investigate how frequent that behavior has been over the past day, week, month, etc. This will help you identify if the arm needs to be replaced.

For further data processing or storage, you can create **event routes** that export digital twin data to endpoints in either Azure Event Grid, Azure Event Hubs, or Azure Service Bus. Other applications can watch these endpoints and receive the data there. Endpoints and event routes can be defined using the Azure Digital Twins APIs and SDKs or the Azure CLI. In the request, you'll provide the name of the Azure Digital Twins instance, the name of the Event Grid, Event Hubs, or Service Bus resource, and optional filter conditions to specify which events are routed there. If your company in the factory example is already using any database or external applications for distribution center monitoring, you can use event routes to integrate your Azure Digital Twins data into those solutions.
