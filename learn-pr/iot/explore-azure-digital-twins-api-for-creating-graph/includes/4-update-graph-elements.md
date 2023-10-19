In this unit, you'll use the Model and Digitaltwin APIs to make updates to the sample graph that you imported in the previous unit.

## Update models

Start by reviewing the [Models API documentation](/rest/api/digital-twins/dataplane/models). The API contains operations to add new models, delete models, get a model's details by its ID, list all models, and update a model.

:::image type="content" source="../media/4-models.png" alt-text="Reference doc screenshot showing the Models operations." border="false" lightbox="../media/4-models":::


Use the Model Update API documentation to craft a request in the data plane collection to edit a model

### Verify updates
List operation for models

## Update twin properties

Start by reviewing the [Twins API documentation](/rest/api/digital-twins/dataplane/twins). The API contains operations to add/delete, get, and update digital twins, their components, and their relationships. In this section, you'll focus on operations dealing with twins themselves.

:::image type="content" source="../media/4-twins.png" alt-text="Reference doc screenshot showing the Twins operations and highlighting the twin-focused ones." border="false" lightbox="../media/4-twins":::

Use the Twin Update API documentation to craft a request in the data plane collection to edit a twin's property value

### Verify updates
GetByID for twins

## Update relationships

Start by reviewing the [Twins API documentation](/rest/api/digital-twins/dataplane/twins) again, this time looking at the operations that deal with relationships.

:::image type="content" source="../media/4-relationships.png" alt-text="Reference doc screenshot showing the Twins operations and highlighting the relationship ones." border="false" lightbox="../media/4-relationships":::

    1. Use the Twin UpdateRelationship API documentation to craft a request in the data plane collection to edit a twin's relationship

### Verify updates
List operation for relationships