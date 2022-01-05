In an Azure Digital Twins solution, the entities in your environment are represented by digital twins. Each digital twin is an instance of one of your custom-defined digital models. A digital twin can be connected to other digital twins via relationships to form a twin graph (a representation of your entire environment).

The image below shows a simplified Contoso Cheese Factory Azure Digital Twins environment expressed as a twin graph. The graph contains seven digital twin nodes connected by relationships. To the left of the twins graph are the corresponding models.

:::image type="content" source="../media/m11-l02-adt-graph-models-6a4c9f9b.png" alt-text="Screenshot that shows a simplified Contoso Cheese Factory Azure Digital Twins environment expressed as a twin graph.":::


> [!TIP]
> "Azure Digital Twins" refers to this Azure service as a whole. "Digital twin(s)" or just "twin(s)" refers to individual twin nodes inside your instance of the service.

## Digital twins

Since the digital twins nodes that you create in your Azure Digital Twins solution are based on a model type, the first step in adding a digital twin to Azure Digital Twins is to upload a model type to your Azure Digital Twins service. After creating and uploading a model, you can create an instance of the type; the digital twin. For example, after creating a model of type Cheese Cave, you can create one or more digital twins that use this type (for example, a Cheese Cave digital twin called Cave\_1, another called Cave\_2, etc.).

## Relationships: a graph of digital twins

Twins are connected into a twin graph by their relationships. The relationships that a twin can have are defined as part of its model.

For example, the model Cheese Factory might define a “Has Caves” relationship that targets twins of type Cheese Cave. With this definition, Azure Digital Twins will allow you to create “Has Caves” relationships from any Cheese Factory twin to any Cheese Cave twin.

The result of this process is a set of nodes (the digital twins) connected via edges (their relationships) in a graph.

## Visualization

While the primary way to interact with your Azure Digital Twins instance is through the APIs and SDKs, it can be helpful to see a visualization of the twins and graphs that you are creating in your instance.

Microsoft provides a sample application, the Azure Digital Twins explorer, that can be used to visualize the Azure Digital Twins graph and to edit the twins and models.
