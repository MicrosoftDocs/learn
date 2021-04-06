Machine learning is part of the broader field of data science, and it's essentially the process of creating knowledge from raw data. 

Significant work is required to covert raw data into to knowledge. For example, imagine you have a garden and you're trying to grow lettuce. You want to optimize your garden so that you can grow the most amount of lettuce in the least amount of time. You can collect a large amount of data that might influence how you set up the most successful environment to grow lettuce. You can factor in sun exposure, temperature, moisture in the soil and air, the type of lettuce and seed source, exposure to fresh air, the size of the planter, and the quality and amount of soil. The list might be even longer because there might be some factors that would affect growth that you might not even be aware of, like the noise level or type of noise near your garden.

An understanding of the [data science lifecycle](https://docs.microsoft.com/azure/machine-learning/team-data-science-process/lifecycle?azure-portal=true) can guide you in your effort to create new knowledge from data sources.

:::image type="content" source="../media/data-science-lifecycle.png" alt-text="Image that shows a diagram of the data science lifecycle." border="false" loc-scope="Azure":::

Here are the four steps of the data science lifecycle:

1. Define a business goal by using subject matter expertise.
2. Collect, clean, and manipulate your data.
3. Choose a machine learning algorithm, and then train and test your model.
4. Deploy your model, to be used with other applications.

## Business goal and subject matter experts

First, you need a clear goal. In the garden example, the goal is to produce as much lettuce as quickly as possible. However, growing conditions aren't absolute. If your baseline production is 1 pound of lettuce in 14 days, you need a way to speed up production. You have found that if you play classical music at 50 decibels for 30 minutes every 3 hours, you get the same 1 pound of lettuce in 13.5 days. But such a complex solution probably is not worth the hassle.

So, it seems *possible* that sound affects plant growth. However, the *likelihood* of sound affecting your outcome might be too small to be worth considering. Access to subject matter experts (SMEs) in plant growth is important so that you don't modify variables that won't yield major changes.

If you look at rocket launches and weather patterns by using the same lens, you see that the goal really has two parts:

- To increase the likelihood that the day chosen for launch will be a good weather day.
- To know what conditions should stop a launch.

The expertise that's needed to reach those goals is in the contributions of meteorologists, physicists, biologists, rocket scientists, and many others. SMEs create scopes for what aspects potentially affect a launch and so require critical attention, thereby minimizing the number of variables to analyze.

For example, SMEs might determine that the amount of direct sunlight on the launch pad might not make a difference, but that the amount of moisture in the air does. They might also know that there are ranges of important data that we can disregard. For example, a launch site temperature of less than 30 degrees fahrenheit rules out consideration of all other factors.
