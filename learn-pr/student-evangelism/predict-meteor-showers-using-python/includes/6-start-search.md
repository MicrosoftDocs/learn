Now that you've cleaned up your datasets, you can begin to create a function that you'll use to make your prediction. 

But first, make sure you know exactly what you want to predict: In a given city, on what date would you most likely see which meteor showers?

This module introduces a simplified way to examine data. Without using a lot of predictions, our method is a lot like a complex lookup table. You can later expand on the model with data like weather to make it more like a classical machine learning model. 

## Write the prediction function

Let's review our four datasets: 

```python
meteor_showers.info()
```

> [!NOTE]
> The output is cut down to show only the columns.

```output
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   name                 5 non-null      object        
 1   radiant              5 non-null      object        
 2   bestmonth            5 non-null      int64         
 3   preferredhemisphere  5 non-null      object        
 4   startdate            5 non-null      datetime64[ns]
 5   enddate              5 non-null      datetime64[ns]
 ```

```python
moon_phases.info()
```

```output
 #   Column      Non-Null Count  Dtype         
---  ------      --------------  -----         
 0   date        366 non-null    datetime64[ns]
 1   percentage  366 non-null    float64 
 ```

```python
cities.info()
```

```output
 #   Column           Non-Null Count  Dtype  
---  ------           --------------  -----  
 0   city             256 non-null    object 
 1   latitude         256 non-null    float64
 2   country/region   256 non-null    object 
 ```

```python
constellations.info()
```

```output
 #   Column         Non-Null Count  Dtype 
---  ------         --------------  ----- 
 0   constellation  5 non-null      object
 1   bestmonth      5 non-null      int64 
 2   latitudestart  5 non-null      int64 
 3   latitudeend    5 non-null      int64 
 4   hemisphere     5 non-null      int64 
```

The function that we write needs to:
1. Determine the *latitude* of a city.
2. Use that latitude to figure out which *constellations* are visible to that city.
3. Use the constellations to determine which *meteor showers* are visible to that city.
4. Use the meteor showers to determine the *dates* that they're visible. 
5. Use the dates to find the *optimal date* that has the least amount of light from the Moon.

Use these steps to build your function.

## Determine the latitude

Create a function called `predict_best_meteor_shower_viewing` that takes in a city as a parameter:

```python
def predict_best_meteor_shower_viewing(city):
```

Here, we get into some tricky Python work. If you find it complicated, don't worry! This exercise is the first time you're working with this type of data science functionality. It takes time to get used to, so treat this work as practice.

```python
def predict_best_meteor_shower_viewing(city):
    # Get the latitude of the city from the cities DataFrame
    latitude = cities.loc[cities['city'] == city, 'latitude'].iloc[0]
```

Let's break down this code.

### `cities['city'] == city`

The `cities['city'] == city` line of code creates a list of true and false values. `True` will be on the row where the city is equal to the city that's passed in as a parameter. 

Consider this example:

```python
print(cities['city'] == 'Abu Dhabi')
```

This code gets the following output:

```output
0       True
1      False
2      False
3      False
4      False
       ...  
251    False
252    False
253    False
254    False
255    False
Name: city, Length: 256, dtype: bool
```

### `cities.loc[cities['city'] == city]`

The `cities.loc[cities['city'] == city]` line of code returns the rows where the preceding true or false value is `True`. In this case, only one row is returned because our cities DataFrame has one row for each city. 

For example, you could write the following code:

```python
print(cities.loc[cities['city'] == 'Abu Dhabi'])
```

Here's the output:

|  | city | latitude | country/region |
|--|------|----------|---------|
| **0** | Abu Dhabi | 24.47 | United Arab Emirates |

### `cities.loc[cities['city'] == city, 'latitude']`

The `cities.loc[cities['city'] == city, 'latitude']` line of code returns only the latitude column. It doesn't return the entire row. 

For example, you could print the following code:

```python
print(cities.loc[cities['city'] == 'Abu Dhabi', 'latitude'])
```

Here's the output:

```output
0    24.47
Name: latitude, dtype: float64
```

### `latitude = cities.loc[cities['city'] == city, 'latitude'].iloc[0]`

Finally, the entire line of code returns the specific value of that column at row 0:

```python
print(cities.loc[cities['city'] == 'Abu Dhabi', 'latitude'].iloc[0])
```

In this case, the returned value is 24.47:

```output
24.47
```

## Call the function

Now that you have a value, test your function to make sure it's working as you expect it to. Return the current value, and then call the function:

```python
def predict_best_meteor_shower_viewing(city):
    # Get the latitude of the city from the cities DataFrame
    latitude = cities.loc[cities['city'] == city, 'latitude'].iloc[0]

    return latitude
```

```python
print(predict_best_meteor_shower_viewing('Abu Dhabi'))
```

```output
24.47
```