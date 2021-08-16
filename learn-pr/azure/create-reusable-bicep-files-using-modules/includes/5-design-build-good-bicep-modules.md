## How do you define a module?

Each module you create should have a clear purpose. Think of a module as having a _contract_ - it accepts a set of parameters, creates a set of resources, and might provide some outputs back to the parent template. Whoever deploys the template shouldn't need to worry about _how_ your module works - just that it does what they expect. So, when you plan a module, consider both what you need to know to be able to fulfill the module's purpose, and what anyone who consumes your module will expect to provide and see as outputs.

Generally it's not a good practice to create a module for every resource in your Bicep file. Normally a good Bicep module would define multiple related resources. However, if you have a particularly complex resource with a lot of configuration, it might make sense to create a single module to encapsulate the complexity.

## How do you identify the resources to split out?

Sometimes it's obvious how you should split a large Bicep file - you might have a set of resources that clearly belong together in a module. Other times, it's not as straightforward to determine the resources that should be grouped into a module.

The Bicep visualizer can help you to put your whole Bicep file in perspective. The visualizer is included in the Bicep extension for Visual Studio Code. To view the visualizer, open the Visual Studio Code **Explorer**, then select and hold (or right-click) the Bicep file and select **Open Visualizer**. The visualizer shows a graphical representation of the resources in your Bicep file, and it includes lines between resources to show the dependencies that Bicep detects:

:::image type="content" source="../media/7-visualize-template.png" alt-text="A diagram showing all resources from the Bicep template and their dependencies.":::

Consider whether the visualization illustrates any clusters of resources.

## Extract your resources and other elements to a module

Once you've decided on the resources to extract, move them into a new Bicep file. Make sure you move or copy any parameters, variables, and outputs as well.

> [!TIP]
> Once you've copied your Bicep code into a module, it's a good practice to review the new module file to confirm it still fits with your chosen template style, and that it has a clear set of parameters and outputs.

## Filenames

Make sure you use a descriptive filename for each module. The filename effectively becomes the identifier for the module, so it's important that your colleagues can understand what the purpose of the module is just by looking at the filename.
