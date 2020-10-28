Machine learning models are trained with enough data to avoid mistakes. Without enough data, a machine learning model might be too general.

For example, if you trained a machine learning model with only temperature data, you might not discover that precipitation is more important and doesn't always correlate to lower temperatures in Florida, United States. If that happened, the model might indicate that it's safe to launch a rocket on a day that has a good temperature but a lot of precipitation, and would be unsafe.

## Collect data

The first step in any data science or machine learning solution is to collect and understand the data. For this learning path, we collected publicly available data from [NOAA](https://www.noaa.gov/?azure-portal=true) and [Weather Underground](https://www.wunderground.com/history?azure-portal=true) for the dates of NASA rocket launches taken from the [list of NASA missions Wikipedia page](https://wikipedia.org/wiki/List_of_NASA_missions?azure-portal=true). We then compiled this data into one [Excel file](https://nasadata.blob.core.windows.net/rocketlaunches/RocketLaunchDataCompleted.xlsx?azure-portal=true). When you select the Excel file link, it automatically downloads the file).

The Excel file contains the weather data for the individual crewed and uncrewed launches, as well as the two days before and after each launch. We added data for the two days surrounding the launches to see if there were any patterns that might be interesting. Here's a screenshot from the Excel file.

:::image type="content" source="../media/excel.png" alt-text="Screenshot that shows Excel data." loc-scope="Azure":::

## Missing data

The Excel file has extensive data about each launch. However, as you start to explore this data, you might find one significant problem. Only one row represents a rocket launch that was supposed to happen but was pushed due to weather concerns:

Row 294 - Space X Dragon - May 27, 2020  

A list of every launch that was attempted but pushed due to weather is not as easily discoverable as the list of successful launches. The dates that were considered and moved before announcement of the expected launch date are also not easily discoverable.

## Subject matter experts

The [United States Air Force's 45th Space Wing](https://www.patrick.af.mil/About-Us/Weather/?azure-portal=true) has one mission: "Exploit the weather to assure *safe* access to air and space." Combined with the minds at NASA, the likelihood of choosing a date that will have weather concerns is small. To ensure the fewest number of changes to a launch schedule, weather and flight subject matter experts take into account climate changes, weather patterns, and existing data .

You can start to explore this issue on your own by heading to the [NASA launch schedule](https://www.nasa.gov/launchschedule/?azure-portal=true). Even without machine learning, take a look at predicted weather patterns in Cape Canaveral and see if you can identify why that date/time was chosen over one a week before or after.

## Find more data

The goal of this learning path is to start you on the curious journey of weather and its relationship with launches. We encourage you to discover more data to improve your own machine learning model. It's part of the data science journey!

What do you think you could use to discover launches that had to be delayed because of  weather? News articles? Archives?
