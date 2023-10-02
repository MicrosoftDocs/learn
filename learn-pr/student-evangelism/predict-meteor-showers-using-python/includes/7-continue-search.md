As a reminder, we're following these steps to find the optimal date to view meteor showers in a particular capital/major city:
1. Determine the *latitude* of the city.
2. Use that latitude to figure out which *constellations* are visible to that city.
3. Use the constellations to determine which *meteor showers* are visible to that city.
4. Use the meteor showers to determine the *dates* that they're visible.
5. Use the dates to find the *optimal date* that has the least amount of light from the Moon.

## Use latitude to determine constellation

Now that we have a city latitude, the next step is to use the latitude to determine which constellations are viewable in the city.

```python
# Get the list of constellations that are viewable from that latitude
constellation_list = constellations.loc[(constellations['latitudestart'] >= latitude) & (constellations['latitudeend'] <= latitude), 'constellation'].tolist()
```

We can break down this line as follows:
- `(constellations['latitudestart'] >= latitude) & (constellations['latitudeend'] <= latitude)`
  - Mark a row as `True` only if the latitude found in the previous line is within the `latitudestart` and `latitudeend` values for that row.
- `constellations.loc[(constellations['latitudestart'] >= latitude) & (constellations['latitudeend'] <= latitude)`
  - Get all of the rows where the latitude is within range for that constellation. 
- `constellations.loc[(constellations['latitudestart'] >= latitude) & (constellations['latitudeend'] <= latitude), 'constellation']`
  - Get only the constellation column from those rows.
- `constellations.loc[(constellations['latitudestart'] >= latitude) & (constellations['latitudeend'] <= latitude), 'constellation'].tolist()`
  - Convert the series returned from the `.loc` function to a list.

## Print the constellation list

Remember, always print as you go to make sure that you're getting the data that you expect. 

```python
def predict_best_meteor_shower_viewing(city):
    # Get the latitude of the city from the cities DataFrame
    latitude = cities.loc[cities['city'] == city, 'latitude'].iloc[0]

    # Get the list of constellations that are viewable from that latitude
    constellation_list = constellations.loc[(constellations['latitudestart'] >= latitude) & (constellations['latitudeend'] <= latitude), 'constellation'].tolist()
    
    return constellation_list
```

```python
print(predict_best_meteor_shower_viewing('Abu Dhabi'))
```

```output
['Lyra', 'Aquarius', 'Orion', 'Perseus']
```

## Create an output string

Before continuing through the data dive, create a string that will contain all of the meteor showers viewable from that city. Include the best dates to view the meteor showers. 

At this point, we can also account for the fact that we aren't representing all cities or all constellations. So some user inputs could result in errors. To the top of your function, add the following conditional statement:

```python
# Create an empty string to return the message back to the user
meteor_shower_string = ""

if city not in cities.values:
    meteor_shower_string = "Unfortunately, " + city + " isn't available for a prediction at this time."
    return meteor_shower_string
```

This string will return before anything else happens in the code, making sure an error doesn't occur. Here's how to test this code:

```python
print(predict_best_meteor_shower_viewing('San Diego'))
```

```output
Unfortunately, San Diego isn't available for a prediction at this time.
```

You can also add a check to see if a constellation is visible from the specified city. Here's the code so far:
```python
def predict_best_meteor_shower_viewing(city):
    # Create an empty string to return the message back to the user
    meteor_shower_string = ""

    if city not in cities.values:
        meteor_shower_string = "Unfortunately, " + city + " isn't available for a prediction at this time."
        return meteor_shower_string

    # Get the latitude of the city from the cities DataFrame
    latitude = cities.loc[cities['city'] == city, 'latitude'].iloc[0]

    # Get the list of constellations that are viewable from that latitude
    constellation_list = constellations.loc[(constellations['latitudestart'] >= latitude) & (constellations['latitudeend'] <= latitude), 'constellation'].tolist()

    # If no constellations are viewable, let the user know
    if not constellation_list:
        meteor_shower_string = "Unfortunately, there are no meteor showers viewable from "+ city + "."

        return meteor_shower_string
```

Now, at the beginning of the string to return, add a starter sentence:

```python
meteor_shower_string = "In " + city + " you can see the following meteor showers:\n"
```

## Determine which meteor showers are visible

Meteor showers are often associated with a constellation that's used to indicate where in the sky you should look for the meteor shower. So we can use these constellations to determine which meteor showers are visible.

In any given city, you're likely to see multiple constellations. So for this next part, loop through each of the constellations that were found in the previous step.

The code should look familiar: 

```python
# Iterate through each constellation that is viewable from the city
    for constellation in constellation_list:
        # Find the meteor shower that is nearest to that constellation
        meteor_shower = meteor_showers.loc[meteor_showers['radiant'] == constellation, 'name'].iloc[0]
        # Find the start and end dates for that meteor shower
        meteor_shower_startdate = meteor_showers.loc[meteor_showers['radiant'] == constellation, 'startdate'].iloc[0]
        meteor_shower_enddate = meteor_showers.loc[meteor_showers['radiant'] == constellation, 'enddate'].iloc[0]

        # Find the Moon phases for each date within the viewable time frame of that meteor shower
        moon_phases_list = moon_phases.loc[(moon_phases['date'] >= meteor_shower_startdate) & (moon_phases['date'] <= meteor_shower_enddate)]
```

Remember to test! You can add a print statement at the end. Just make sure to indent it so that it prints each time the `for` loop iterates.

```python
print(moon_phases_list)
```

Here's an example of the first few lines of the output:

|  | `date` | `percentage` |
|--|------|------------|
| **111** | 2020-04-21 | 0.5 |
| **112** | 2020-04-22 | 0.0 |
| **109** | 2020-04-19 | 0.5 |
| **110** | 2020-04-20 | 0.5 |
| **111** | 2020-04-21 | 0.5 |
| **112** | 2020-04-22 | 0.0 |
| **113** | 2020-04-23 | 0.0 |
| **114** | 2020-04-24 | 0.0 |

## Find the optimal date based on Moon phases

Finally, we can find the minimum value of the Moon phase (the least amount of light shining from the Moon). For this predictive function, we just grab the first date. 

```python
# Find the first date where the Moon is the least visible
best_moon_date = moon_phases_list.loc[moon_phases_list['percentage'].idxmin()]['date']
```

Then add that information to the string that you'll send back:

```python
# Add that date to the string to report back to the user
meteor_shower_string += meteor_shower + " is best seen if you look towards the " + constellation + " constellation on " +  best_moon_date.to_pydatetime().strftime("%B %d, %Y") + ".\n"
```

One tricky part in this code is where we convert the date to a `pydatetime` and then convert it to a string by using `strftime`. If we try to omit this part, we'll get an error.

## Final code

Here's the final code for this predictive function:

```python
def predict_best_meteor_shower_viewing(city):
    # Create an empty string to return the message back to the user
    meteor_shower_string = ""

    if city not in cities.values:
        meteor_shower_string = "Unfortunately, " + city + " isn't available for a prediction at this time."
        return meteor_shower_string

    # Get the latitude of the city from the cities DataFrame
    latitude = cities.loc[cities['city'] == city, 'latitude'].iloc[0]

    # Get the list of constellations that are viewable from that latitude
    constellation_list = constellations.loc[(constellations['latitudestart'] >= latitude) & (constellations['latitudeend'] <= latitude), 'constellation'].tolist()

    # If no constellations are viewable, let the user know
    if not constellation_list:
        meteor_shower_string = "Unfortunately, there are no meteor showers viewable from "+ city + "."

        return meteor_shower_string

    meteor_shower_string = "In " + city + " you can see the following meteor showers:\n"
    
    # Iterate through each constellation that is viewable from the city
    for constellation in constellation_list:
        # Find the meteor shower that is nearest to that constellation
        meteor_shower = meteor_showers.loc[meteor_showers['radiant'] == constellation, 'name'].iloc[0]

        # Find the start and end dates for that meteor shower
        meteor_shower_startdate = meteor_showers.loc[meteor_showers['radiant'] == constellation, 'startdate'].iloc[0]
        meteor_shower_enddate = meteor_showers.loc[meteor_showers['radiant'] == constellation, 'enddate'].iloc[0]

        # Find the Moon phases for each date within the viewable time frame of that meteor shower
        moon_phases_list = moon_phases.loc[(moon_phases['date'] >= meteor_shower_startdate) & (moon_phases['date'] <= meteor_shower_enddate)]

        # Find the first date where the Moon is the least visible
        best_moon_date = moon_phases_list.loc[moon_phases_list['percentage'].idxmin()]['date']

        # Add that date to the string to report back to the user
        meteor_shower_string += meteor_shower + " is best seen if you look towards the " + constellation + " constellation on " +  best_moon_date.to_pydatetime().strftime("%B %d, %Y") + ".\n"
    
    return meteor_shower_string
```

Make sure you're careful with indentation!

Call the function like this:

```python
print(predict_best_meteor_shower_viewing('Abu Dhabi'))
```

Here's your result:

```output
In Abu Dhabi you can see the following meteor showers:
Lyrids is best seen if you look towards the Lyra constellation on April 22, 2020.
Eta Aquarids is best seen if you look towards the Aquarius constellation on April 22, 2020.
Orionids is best seen if you look towards the Orion constellation on October 16, 2020.
Perseids is best seen if you look towards the Perseus constellation on July 20, 2020.
```
