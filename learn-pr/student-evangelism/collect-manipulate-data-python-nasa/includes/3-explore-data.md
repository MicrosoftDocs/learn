As described in the Introduction to Rocket Launches module (link to unit 7), machine learning models are trained using enough data to avoid mistakes. Without enough data, a machine learning model could be too general. For example, if you trained a machine learning model with only temperature data and nothing else, you might not discover that precipitation is significantly more important and doesn't always correlate to lower temperatures in Florida, USA. If that were to happen, the model might indicate that it was safe to launch a rocket on a day that falls in a good temperature, but where there is a lot of precipitation and therefore would be unsafe. 

## Collecting Data

The first step in any data science/machine learning solution is to collect and understand the data. For this learning path we have collected publicly available data from [NOAA](https://www.noaa.gov/?azure-portal=true) and [Weather Underground](https://www.wunderground.com/history?azure-portal=true) for the dates of NASA rocket launches taken from the [list of NASA missions Wikipedia page](https://wikipedia.org/wiki/List_of_NASA_missions?azure-portal=true) and compiled it into one Excel file. 

The Excel file contains the weather data for the individual crewed and uncrewed launches, as well as the two days before and after each launch. We added the two days surrounding the launches data to see if there were any patterns that might be interesting. Here is a screenshot from the [Excel doc that you can download here](https://nasadata.blob.core.windows.net/rocketlaunches/RocketLaunchDataCompleted.xlsx?azure-portal=true).

:::image type="content" source="../media/excel.png" alt-text="excel data" loc-scope="azure":::

## Missing Data

What we find in this Excel doc is extensive data about each launch. However, are you start to explore this data you might find one big issue:
There is only one row that represents a rocket launch that was supposed to happen, but was pushed due to weather concerns:  
Row 294 - Space X Dragon - May 27, 2020  

A list of every single launch that was attempted but pushed due to weather is not as easily discoverable as the list of successful launches. Furthermore, the dates that were considered and moved prior to announcing the expected launch date are also not easily discoverable. 

## SMEs: Subject Matter Experts

The [United States Airforce's 45th Space Wing](https://www.patrick.af.mil/About-Us/Weather/?azure-portal=true) has one mission: "Exploit the weather to assure *safe* access to air and space." Combined with the incredible minds at NASA, the likelihood of choosing a date that will have weather concerns is small. The subject matter experts on weather and flight take into account climate changes, weather patterns, and existing known data to ensure the fewest amount of changes to a launch schedule. 

You can start to explore this on your own by heading to the [NASA Launch Schedule](https://www.nasa.gov/launchschedule/?azure-portal=true). Even without machine learning, you can start to look at predicted weather patterns in Cape Canaveral and see if you can identify why that date/time was chosen over one a week before or after. 

## Finding More Data

The goal of this rocket launch learning path is to start you on the curious journey of weather and it's relationship with launches. We encourage you to discover more data to improve your own machine learning model. This is part of the data science journey!

What do you think you could use to discover launches that had to be pushed due to weather? News articles? Archives?