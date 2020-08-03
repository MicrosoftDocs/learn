Machine learning is essentially using the information you have (data) to create knowledge. Machine learning is a part of the broader data science field. It takes a significant amount of work to move from raw date (even prior to being collected) to knowledge. 

For example, let's imagine you have a garden where you're trying to plant lettuce and you want to optimize for the most amount of lettuce in the least amount of time. There is a lot of data available for collection the might influence how you setup the environment for the most success; you can collect the sun exposure, temperature, moisture in the soil and air, type of lettuce, exposure to fresh air, size of the planter, type of soil, amount of soil. The list could be even longer, since there might be some things that would effect the growth that you might not even realize, like noise level or type of noise near the plant. 

The [Data Science Lifecyle](https://docs.microsoft.com/azure/machine-learning/team-data-science-process/lifecycle?azure-portal=true) can help guide us through the journey to using data to create new knowledge. 

:::image type="content" source="../media/data-science-lifecyle.png" alt-text="Data Science Lifecyle" loc-scope="azure":::

The four steps, discussed throughout these units are:
1. Define a business goal using subject matter expertise
2. Collect, clean, and manipulate your data
3. Choose a machine learning algorithm and train and test your model
4. Deploy your model to be used with other applications

## Step 1: Business Goal and Subject Matter Expertise

This is the first step - you have a clear goal: get as much lettuce as fast as possible, but these are not absolute conditions. If you're able to get 1 pound of lettuce in 14 days, but if you modify your entire setup to have classical music played at 50 decibles for 30 minutes every 3 hours and you could have 1 pound of lettuce in 13.5 days, it's probably not worth that hassle. Furthermore, while it's *possible* that sound could effect plant growth, the *likelihood* of it effecting plant growth to the point where it would effect your outcome at all might be so small it's not even worth considering. Having subject matter expertise (some knowledge of how plants grow) would be important so that you don't spend too much time modifying variables in your setup that won't yield major changes. 

If we look at rocket launches and weather patterns with that same lens we can see that the goal really has two parts:
- Increase the likelihood that the day chosen for launch will be a good day
- Know what conditions should stop a launch if necessary

And the expertise that we would need to reach those goals, even pre-data gathering, includes meteoroligists, physisists, biologists, rocket scientists, and many more. The SMEs (subject matter experts) will create scopes for what is most critical to pay attention to, to reduce the size of what needs to be analyzed in order to answer these questions. For example, this could mean that the amount of direct sunlight on the launch pad might not make a difference, but that the moisture in the air does. It could also mean that there are ranges of important data that we can disregard, for example, if it is below 30 degrees farenheit in temperature at the launch site, it isn't even worth considering. 
