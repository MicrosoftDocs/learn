Machine learning is essentially the process of creating knowledge from raw information (data). Machine learning is part of a broader field - data science. It takes a significant amount of work to covert raw data (even prior to being collected) into to knowledge. 

For example, let's imagine you have a garden where you're trying to plant lettuce. You want to optimize it to grow the most amount of lettuce in the least amount of time. There is a lot of data you can collect that might influence how you set up the most successful environment. You can factor in sun exposure, temperature, moisture in the soil and air, type of lettuce, exposure to fresh air, size of the planter, type of soil, amount of soil. The list could be even longer, since there might be some things that would affect the growth that you might not even realize, like noise level or type of noise near the plant.

The [data science lifecycle](https://docs.microsoft.com/azure/machine-learning/team-data-science-process/lifecycle?azure-portal=true) can help guide you on your journey to the creation of new knowledge from data sources.

:::image type="content" source="../media/data-science-lifecyle.png" alt-text="Data Science Lifecyle" loc-scope="Azure":::

The four steps, discussed throughout these units are:

1. Define a business goal using subject matter expertise
2. Collect, clean, and manipulate your data
3. Choose a machine learning algorithm, and then train and test your model
4. Deploy your model to be used with other applications

## Step 1: Business goal and subject matter expertise

First you need a clear goal: get as much lettuce as fast as possible. However, the conditions aren't absolute. If your baseline production is one pound of lettuce in 14 days, and you're able to decrease the time to get the same one pound in 13.5 days by modifying your setup with classical music played at 50 decibels for 30 minutes every three hours, it's probably not worth that hassle.

Also, while it's *possible* that sound  affects plant growth, the *likelihood* of the affect impacting your outcome might be so small that it's not even worth considering. Subject matter expertise (knowledge of how plants grow) is important so that you don't spend too much time modifying variables in your setup that won't yield major changes.

If you look at rocket launches and weather patterns with the same lens, you see that the goal really has two parts:

- Increase the likelihood that the day chosen for launch will be a good day
- Know what conditions should stop a launch if necessary

And the expertise that we would need to reach those goals, even pre-data gathering, includes meteorologists, physicists, biologists, rocket scientists, and many others. The SMEs (subject matter experts) create scopes for what aspects require critical attention so the number of variables to be analyzed can be minimized.

For example, SMEs might determine that that the amount of direct sunlight on the launch pad might not make a difference, but that the moisture in the air does. They might also know that there are ranges of important data that we can disregard. For example, a launch-site temperature of less than 30 degrees fahrenheit rules out consideration of all the other factors.
