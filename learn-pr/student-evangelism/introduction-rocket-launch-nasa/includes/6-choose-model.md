At this point in the data science lifecycle, you have data that best represents the truth about what you're researching. So it's time to model the machine learning to start uncovering knowledge. Modeling is the process of choosing what features of the data are the most likely drivers of knowledge. These data features can vary. For example, they might be columns in a table, secondary information like the difference between two columns, or something more nuanced like the color of an image.

## Step 3: Modeling

For your lettuce garden, some aspects of the environment are likely to be more important than others. For example, soil moisture is more relevant than noise level. But for other features, it can be difficult to assess if they're more correlated with the desired outcome. For example, is soil moisture more of an indicator of growth over time than temperature? Featurization is a technique that uses the machine learning model to help you understand which features correlate more tightly with the outcome.

For rocket launches, you might not have access to some highly correlated data like the shape, size, and classification of clouds. However, you'll have three main pieces of data that are likely to be highly correlated - temperature, precipitation, and humidity. In this learning path, the goal is to use past launch data, past weather data, and predicted weather data to determine if a launch is likely to be successful in the future.

## The algorithm cheat sheet

A great resource for determining what kind of machine learning algorithm will be useful for your particular analysis is the [Algorithm cheat sheet](https://docs.microsoft.com/azure/machine-learning/algorithm-cheat-sheet?azure-portal=true).

:::image type="content" source="../media/algorithm-cheat-sheet.png" alt-text="Flowchart style diagram of the Algorithm cheat sheet."  loc-scope="azure":::

To revisit your central question:  *Will this day, with these weather conditions, yield a successful launch?*

The question is answered with a yes or a no. It's a problem where a two-class classification algorithm can be helpful. If you look in that category on  on the algorithm cheat sheet, you'll see that you can choose from many algorithms. In this case, you'll use a decision tree classifier. This type of algorithm takes observations about an event, like the weather conditions for a particular day, and draws conclusions about the target value. It results in a yes or a no that a rocket would successfully launch that day.
