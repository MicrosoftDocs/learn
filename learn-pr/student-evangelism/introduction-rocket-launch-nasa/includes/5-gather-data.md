Step 2 in the data science lifecycle is to collect, clean, and manipulate your data. After you've clearly defined what you want to know, you can evaluate the data you have and the data that you might need to collect. From there, you can prepare your data in a way that supports the discovery you're interested in.

### Get data

With the constraints, scopes, and prioritization of data that SMEs provide in place, you can begin to gather useful data. This step has its own challenges. Returning to the gardening example, you might grow 10 heads of lettuce under slightly different conditions, and then determine which conditions yield the best results.

For a rocket launch, comparison experiments aren't as easy to do. You can run simulations, but simulations are based on data analysis, not on literal trial and error under exact conditions. It isn't ethical or economical to undertake a test launch under each unique circumstance to be able to determine with certainty the safest circumstances for a launch. Also, many conditions, like weather, can't be controlled. (Although, it's true that some of the data that's used in a simulation comes from failed rocket launches that were attempted under negative circumstances. Otherwise, how would you know the limitations of certain conditions?) You also can use other information to determine constraints, like information that's gathered from aircraft or basic physics or math calculations.

### Clean and manipulate data

On first impression, you might be suspicious to learn that one step in machine learning is to *manipulate* data. Here, manipulate doesn't mean that the data is modified to get the outcome you want. It means that you take care to ensure that the data is the most accurate representation of the truth.

For example, with your lettuce garden, you might run a study that focuses on soil moisture. You collect moisture readings every hour, so you can determine how moisture affects growth. One day, at 2:55 PM, the moisture sensor stops working. You notice the broken sensor, and you fix it before the scheduled 4:00 PM sensor reading. But, you lose the data that would have been collected at the scheduled 3:00 PM sensor reading. It's reasonable to manipulate the data by replacing the missing value with an average of the 2:00 PM and 4:00 PM readings. If you don't notice the broken sensor until the next day, though, it might make more sense to *clean* your data by removing that day's readings from the analysis altogether, so incomplete data doesn't lead to an inaccurate result.

A large amount of data is needed to predict ideal conditions for a rocket launch. NASA is likely to have access to better data than what is publicly available. NASA has  access to the subject matter expertise of people who work closely with the nuances of rocket launches and weather. It also has access to all its previous experiments and analyses. 

By contrast, in the machine learning model you'll train in the next module of this learning path, you'll rely mostly on accessible weather data like temperature, precipitation, and cloudiness. You'll focus on past days when launches actually took place. The realistic result is that this project will be less accurate than NASA's predictions. Because you have only examples of successful launches, the machine learning model you train will be skewed toward good conditions.
