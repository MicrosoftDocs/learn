As a data scientist, you'll often want to visualize your data to help understand it better. This can mean looking at raw data, viewing summary measures such as averages, or graphing the data. Graphs are a powerful means of viewing data, because they can help you discern moderately complex patterns quickly without needing to define mathematical summary measures. 

## Represent data visually 

Representing your data visually ordinarily means graphing it. You do this to provide a fast qualitative assessment of the data, which can be useful for understanding results, finding outlier values, understanding how numbers are distributed, raising new questions about the data, and so on. 

Although you might sometimes know ahead of time what kind of graph will be most useful, at other times you might use graphs in an exploratory way. 

To understand the power of data visualization, consider the data in the following table, which describes the location (x,y) of a self-driving car. It's hard to see any real patterns in the data's raw form. The mean or average tells you that the car's path was centered around x=0.2 and y=0.3, and the range of numbers appears to be between about -2 and 2.

|**Time**  |**Location-X** |**Location-Y** |
|------|-----------|-----------|
|0     |0          |2          |
|1     |1.682942   |1.080605   |
|2     |1.818595   |-0.83229   |
|3     |0.28224    |-1.97998   |
|4     |-1.5136    |-1.30729   |
|5     |-1.91785   |0.567324   |
|6     |-0.55883   |1.920341   |
|7     |1.313973   |1.507805   |
|12    |0.00001    |0.00001    |
|13    |0.840334   |1.814894   |
|14    |1.981215   |0.273474   |
|15    |1.300576   |-1.51938   |
|16    |-0.57581   |-1.91532   |
|17    |-1.92279   |-0.55033   |
|18    |-1.50197   |1.320633   |
|19    |0.299754   |1.977409   |
|20    |1.825891   |0.816164   |

If you now plot Location-X over time, you can see that the table appears to be missing some values between times 7 and 12. 

:::image type="content" source="../media/location-x-graph.png" alt-text="Graph showing Location-X, plotted over time." border="false"::: 

If you graph X versus Y, you end up with a map of where the car has driven. It’s instantly obvious that the car has been driving in a circle but that, at some point, it drove to the center of that circle. 

:::image type="content" source="../media/location-x-vs-location-y-graph.png" alt-text="Graph showing Location-X and Location-Y." border="false"::: 

Graphs aren't limited to 2D scatter plots such as these. You can use them to explore many other kinds of data. For example, you might represent proportions through pie charts or stacked bar graphs. Or you might show how data is spread by using histograms, box, and whisker plots. Or you might use another type of graph to show how two data sets differ. When you're trying to understand raw data or results, it's a good idea to experiment with different types of graphs until you come across one that explains the data in a visually intuitive and more useful way. 