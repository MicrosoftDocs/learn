In addition to creating visualizations to display data from your resources, Workbooks provides functionality to combine and correlate the data from these sources to give you greater insight into your system.

You can use techniques like using graphs or charts side by side to give you a quick visual idea of how the resources compare. You can use rendering and style settings to implement visuals like "traffic lights" or color coding to make issues easily identifiable. All of these tools allow you to completely customize your reports for effective and efficient system monitoring.

## Merge and correlate data
You can also merge data from different sources can enhance the insights experience. Azure Monitor has several correlatable data sources that are often critical to the triage and diagnostic workflow. You can merge or join data to provide rich insights using the merge control.

For example, you can augment active alert information with related metric data. Merging data allows you to see the effect of an active alert, and also gives you insight into potential causes, such as high CPU usage.

Workbooks support these merges:

- Inner unique join
- Full inner join
- Full outer join
- Left outer join
- Right outer join
- Left semi-join
- Right semi-join
- Left anti-join
- Right anti-join
- Union
- Duplicate table

## Commonly used features

You can use the different features included in Workbooks to make your data more useful and effective. Some useful features include:
- **Rendering options**. You have multiple and robust rendering options for your Workbooks, such as:
    - Linking
    - Icons
    - Heatmaps
    - Bars
    - Composite bars
    - Spark bars
    - Location, and more.
- **Link action**. You can configure link actions so that when a user selects the cell, they're directed to another page.
- **Time brushing**. Time range brushing allows a user to "brush" or "scrub" a range on a chart and have that range output as a parameter value.
- **Traffic lights**. You can summarize status by using a simple visual indication instead of presenting the full range of data values. You can use an indicator or icon that represents the status next to the underlying metric.
- **Versioning**. You can save multiple versions of a workbook. You can then compare, view, or restore versions.
- **Interactivity**. You can make your workbooks interactive using several techniques:
    - When you update a parameter, any control that uses the parameter automatically refreshes and redraws to reflect the new value.
    - You can construct scenarios where selecting a row in a grid updates subsequent charts based on the content of the row.
    - You can add interactivity with a special type of grid column renderer called a link renderer. A link renderer converts a grid cell into a hyperlink based on the contents of the cell.
    - You can make controls appear or disappear based on the values of parameters.
    - You can export parameters from query and metrics workbook components when a row or multiple rows are selected.
