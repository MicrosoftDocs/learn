In this unit, you propagate data through the digital twin graph of your smart building. This involves the resources shown in Flow B below:

:::image type="content" source="../media/2-3-4-building-scenario.png" alt-text="Graph showing data flowing from a device into Azure Digital Twins, then throughout Azure Digital Twins." border="false" lightbox="../media/2-3-4-building-scenario.png":::

Data flow follows this path:
1. The *Thermostat 67* twin produces a notification that its *Temperature* property has changed. Azure Digital Twins routes this notification data to Event Grid.
1. Event Grid sends the notification data to another custom Azure function.
1. The Azure function code uses the notification data to update connected twins as appropriate. In this case, it will update the *Temperature* property on the *Room21* twin, setting the value to match the *Temperature* value on the thermostat twin that the room contains.

## Create required resources

First, create the resources that are needed for this flow: the Event Grid topic and the Azure function.

### Create Event Grid topic

### Create Azure function

#### Publish Azure function
to existing function app

## Connect resources

### Connect Azure Digital Twins to Event Grid

Create Azure Digital Twins endpoint and event route

### Connect Event Grid to Azure function

## Run simulation