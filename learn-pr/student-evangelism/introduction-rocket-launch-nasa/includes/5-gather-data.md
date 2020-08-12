After you've clearly defined what you want to know, you can evaluate the data you have and the data you might need to collect. From there, you can prepare your data in a way that supports the discovery you're interested in.

## Step 2: Gather the data

With constraints, scopes, and prioritization of data based on subject matter expertise, you can begin to gather useful data. This step can present its own challenges. You could grow 10 heads of lettuce under slightly different conditions, and then determine which conditions yield the best results.

For rocket launches, comparison experiments are not as easy. You can run simulations, but they are based on data. Some of that data comes from failed rocket launches that were attempted under negative circumstances. Otherwise how would you *really* know that they're negative circumstances? You can also use other information to determine constraints. For example, gathered from aircraft or from basic physics. But it isn't ethical or economical to undertake a test launch under each unique circumstance to be able to determine with certainty the safest circumstances. Furthermore, many conditions, like weather, can't be controlled.

## Step 2.5: Clean and manipulate the data

At first impression, you might be suspicious to learn that one step in machine learning is to "manipulate" the data. In this case, however, manipulate doesn't mean that the data is modified to get a desirable outcome. It means that the data is made to be the most accurate representation of the truth.

For example, with your lettuce garden, you might run a study that focuses on soil moisture. You collect moisture readings every hour so you can determine how it impacts growth. The moisture sensor breaks one day at 2:55 PM. You notice and fix it before the 4:00 PM reading, but you lose the 3:00 PM sensor reading. It's reasonable to "manipulate" the data by replacing the missing value with an average of the 2:00 PM and 4:00 PM readings. If you don't notice the broken sensor until the next day, however, it might make more sense to "clean" your data by removing that day's readings from the analysis altogether.

For rocket launches, much data is missing. NASA is likely to have access to better data that is publicly available. NASA has  subject matter expertise of people involved in the nuances of rocket launches and weather. They also have access to all of their previous experiments and analyses. By contrast, you'll  rely mostly on accessible weather data like temperature, precipitation, and cloudiness. You'll focus on the days when a launch happened. The realistic result is that this project will be less accurate than NASA's predictions. Because you only have examples of successful launches, the machine learning model you train will be skewed towards good conditions. It won't be great at identifying bad conditions.
