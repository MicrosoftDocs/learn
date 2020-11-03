In this unit, we look at the layout and features of the Azure Digital Twins Explorer tool.

The Explorer tool is run from a command prompt window, after installing a number of dependencies. 

## Sign in

It's necessary to sign in, and validate a digital twins instance. You will need the host URL of your instance, and the client and tenant IDs of a registered app.

After signing in, you'll probably want to either upload your models, or upload a graph you created previously. Looking at the following image, note the model import icon to the left, and the graph import icon in the center. The image also highlights the `localhost:3000` address, and the icon to save updates to your digital twins. 

[![Screenshot showing the layout of the graph explorer tool](../media/adt-explorer-intro.png)](../media/adt-explorer-intro.png#lightbox)

## Upload models and create twins

The following image shows the factory model, from our chocolate factory scenario. After uploading, typically use the `Create a twin` icon to create the twin, which adds the circle representation of the model to the graph, and a selection of properties to the PROPERTY EXPLORER. Not all properties are currently shown in the property explorer, there are some limitations to the tool.

[![Screenshot showing the import of a model, and the creation of its digital twin](../media/adt-explorer-create-twin.png)](../media/adt-explorer-create-twin.png#lightbox)

Rather than upload one model at a time, typically you would upload a folder full of models.

By selecting elements in the graph, you can add relationships between model twins. You hold down the Ctrl key, and click the source model, then the target model, then you can select a relationship from a list. The list is those relationships you defined for the source model.

Creating relationships for our chocolate factory is one of the main tasks of the next unit.

## Import and export graphs

Having spent a good amount of time creating a graph, it's good to know you can save the completed work. And import the graph again at a later date, if needed.

The following example shows a graph of models of electrical power components, forming a distribution grid.

[![Screenshot showing an electrical distribution grid, as a graph](../media/adt-explorer-graph-import.png)](../media/adt-explorer-graph-import.png#lightbox)

You can see how model graphs could get quite complex. There are a range of options in the explorer for automatically laying out the graph. You can also drag any model to a new location.

Graphs, when exported, are stored in a human-readable Excel spreadsheet. The following image shows a section of the spreadsheet for the distribution grid example.

[![Screenshot showing a section of an Excel spreadsheet containing the distribution grid graph](../media/adt-distribution-grid.png)](../media/adt-distribution-grid.png#lightbox)

## Next steps

This unit is a brief overview of the features of ADTExplorer. Now, let's put the tool to use on our chocolate factory production line.















