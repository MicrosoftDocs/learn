In this unit, you'll get an overview of the layout and features of the Azure Digital Twins explorer sample application on a conceptual level before applying these features to your chocolate factory digital twin in the next unit.

The explorer sample app is run from the [Azure portal](https://portal.azure.com/).

## Access the Azure Digital Twins Explorer

To access the explorer, you'll need to navigate to your Azure Digital Twins instance. In the overview pane of your instance, you'll be able to access the explorer by selecting the **Open Azure Digital Twins Explorer (preview)** button.

:::image type="content" source="../media/azure-digital-twins-explorer-portal-access.png" alt-text="Terminal help output when running npm install." lightbox="../media/azure-digital-twins-explorer-portal-access.png":::

Once you've accessed the explorer, you'll probably want to either upload your models, or upload a graph you created previously. In the following image, note the model import icon to the left, and the graph import icon in the center. The image also highlights the `localhost:3000` address, and the icon to save updates to your digital twins.

:::image type="content" source="../media/explorer-intro.png" alt-text="Screenshot showing the layout of the Azure Digital Twins explorer sample." lightbox="../media/explorer-intro.png":::

## Upload models and create twins

The following image shows the factory model from the chocolate factory scenario. After uploading a model, you typically use the **Create a twin** icon to create the twin. Creating the twin adds the circle representation of the model to the graph, and a selection of properties to the **PROPERTY EXPLORER**. (Not all properties are currently shown in the property explorer, due to limitations of this sample.)

:::image type="content" source="../media/explorer-create-twin.png" alt-text="Screenshot showing the import of a model, and the creation of its digital twin." lightbox="../media/explorer-create-twin.png":::

Rather than upload one model at a time, typically you would upload a folder full of models.

By selecting elements in the graph, you can add relationships between model twins. You hold down the Ctrl key while selecting the source model, then the target model, and then you can select a relationship from a list. The list is composed of those relationships you defined for the source model.

Creating relationships for the chocolate factory is one of the main tasks of the next unit.

## Import and export graphs

Having spent a good amount of time creating a graph, it's good to know you can save the completed work and import the graph again at a later date, if needed.

The following example shows a more complex graph of models of electrical power components, forming a distribution grid:

:::image type="content" source="../media/explorer-graph-import.png" alt-text="Screenshot showing an electrical distribution grid, as a graph." lightbox="../media/explorer-graph-import.png":::

Note that the digital twin example of the chocolate factory has been deliberately simplified. More robust uses of Azure Digital Twins, like the electrical power components, can get complicated as more elements are added.

There are a range of options in the explorer sample for automatically laying out the graph. You can also drag any model to a new location.

Graphs, when exported, are stored in a human-readable Excel spreadsheet. The following image shows a section of the spreadsheet for the distribution grid example in this section:

:::image type="content" source="../media/distribution-grid.png" alt-text="Screenshot showing a section of an Excel spreadsheet that contains the distribution grid graph." lightbox="../media/distribution-grid.png":::

## Next steps

Next, you put the sample to use on your chocolate factory production line.
