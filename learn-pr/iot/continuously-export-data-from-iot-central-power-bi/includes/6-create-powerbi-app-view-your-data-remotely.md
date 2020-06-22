In this unit, we look at two Microsoft technologies that can be used to visualize Azure IoT Central continuous data. The technologies are Power BI, and PowerApps.

Let's first go over some of the concepts behind Microsoft PowerApps.

## Introduction to Microsoft PowerApps

Using PowerApps, you can build your application without any coding. A web portal is used to select components, inputs, outputs, and so on. Your app is built almost as a drag-and-drop process. You might select a _template_, if one of the available templates matches your ideas. If there's no suitable template, you can build your app from scratch.

PowerApps can be built to ingest data either from an underlying data platform, known as the _Common Data Service_. Or, as we would need in our scenario, from an external data source. This data source can be SharePoint, Excel, Office 365, and many others. For our scenario, we would use the Azure Blob Storage for our data source. Fortunately, this option is available.

The key concept to PowerApps is _rapid development_. You can build a functional, useful app in just a few minutes.

Lets drill-down a little further into the types of PowerApp. There are three: _Canvas apps_, _Portal apps_, and _Model-driven apps_.

### Understanding Canvas apps

The name should give away the idea. You drag and drop components onto a _canvas_. An easy way to start may be to select **All templates**, after signing into to [Power Apps](https://make.preview.powerapps.com/environments/). Instead, it may be more fun to select **Canvas app from blank**, and educate yourself by dragging in a mix of components.

You're given the option of specifying **Tablet** or **Phone** for your canvas app. Then you get a powerful, but slightly intimidating, user-interface. Lots of options:

[![Screenshot showing the user interface when creating a canvas PowerApp](../media/continuous-data-power-apps-canvas.png)](../media/continuous-data-power-apps-canvas.png#lightbox)

The key to canvas apps is they are user-interface driven. Canvas apps start with your user experience, selecting a target of phone, tablet, or web. Data, from over 200 different sources, can then be selected and connected.

### Understanding Portal apps

Portal apps are external-facing. You can build a web portal that allows users outside of your organization to sign in, view, and create, data using the Common Data Service.

### Understanding Model-driven apps

Model-driven apps are fascinating. You _start_ by selecting your data model, and source. Model-driven apps automatically create a user-interface that matches the format of your data. Forms, views, dashboards, charts, and other components are built without you having to specify anything!

Now, let's look at the other technology, Power BI. BI stands for _Business Intelligence_.

## Visualize data using Power BI

Power BI is an easy-to-use dashboard-building technology. You create dashboards from tiles. Tiles can be **Images**, **Text boxes**, **Videos**, or the more complex **Web content**. The **Web content** tile can contain HTML, typically cut-and-pasted into a tile creation box. Each tile is a rectangular shape, then you can resize to fit your preferred output device.

There's a built-in conversion, for any dashboard, to output in a format suitable for a mobile phone.

[![Image showing a desktop, tablet, and mobile example of a Power BI dashboard](../media/continuous-data-power-bi-layout.png)](../media/continuous-data-power-bi-layout.png#lightbox)

The fifth type of tile, **Custom Streaming Data**, is the one we're most interested in. This tile is the most powerful, as it accepts data from any available _Dataset_. Power BI Datasets take input from many sources, as convenient as an Excel spreadsheet, to the more complex such as the output from an Azure Stream Analytics job.

[![Screenshot showing the five types of Power BI dashboard tiles](../media/continuous-data-power-bi-tiles.png)](../media/continuous-data-power-bi-tiles.png#lightbox)

It takes only minutes to build a functioning Power BI dashboard, as we'll see in the next unit.

To accept Azure IoT Central data as a source, we'll need to create an Azure Event Hub, and a Stream Analytics job.

## Next steps

PowerApps is the more powerful of the two technologies. Sophisticated apps can be built using PowerApps, more so than using Power BI technology. However, currently, PowerApps require a paid subscription to enable Azure data as a source.

So, for this module, we'll build a Power BI dashboard to show continuous IoT Central data on a mobile phone. Students are encouraged to investigate PowerApps, for a developer-level solution.
