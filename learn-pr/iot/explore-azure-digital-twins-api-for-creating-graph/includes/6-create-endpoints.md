In this unit, you'll use the Endpoints API to create a new endpoint for your Azure Digital Twins instance. An **endpoint** is a recognized destination outside of Azure Digital Twins that can receive digital twin events. By setting up an endpoint in this section, you'll begin to lay the groundwork for a complete future solution that can export Azure Digital Twins data to external destinations.

## View Endpoints API documentation

Start by reviewing the [Endpoints API documentation](/rest/api/digital-twins/controlplane/endpoints). Notice that unlike previous API sets used so far in this module, the Endpoints API is part of the **Control plane** collection. The API contains operations for creating/updating, deleting, getting, and listing endpoints.

:::image type="content" source="../media/6-endpoints.png" alt-text="Reference doc screenshot showing the Endpoints operations." border="false" lightbox="../media/6-endpoints":::

## Create an endpoint

use the CreateOrUpdate operation to craft a request in the control plane collection to create an endpoint

## Check endpoint status

View the API documentation for Endpoint API's Get operation
Use Endpoint API's Get operation to check the status of the new endpoint