Now that you have cleaned up your datasets, you can begin to create one function that you will use to make your prediction. 

Before you do that, you need to make sure you know exactly what you want to predict:

Given a city, what date would you most likely see which meteor showers?

This module introduces a simplified way of examining data. Without a lot of predictions, it's a lot like a complex lookup table. You can expand on this with data like weather in the future to make this more like a classical machine learning model. 

## Write the prediction function

Let's review the four datasets that we have so far (NOTE: the output is cut down to only include the columns):

```python
meteor_showers.info()
```

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
 #   Column    Non-Null Count  Dtype  
---  ------    --------------  -----  
 0   city      256 non-null    object 
 1   latitude  256 non-null    float64
 2   country   256 non-null    object 
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

The function that we are writing will need to:
1. Determine the *latitude* of a city
2. Use that *latitude* to figure out which *constellations* are visible to that city
3. Use the *constellations* to determine which *meteor showers* are visible to that city
4. Use the *meteor showers* to determine the *dates* that it is visible 
5. Use the *dates* to find the optimal *date* that has the least amount of shine from the moon

You can use that outline of steps to build your function step by step.

## Determine the latitude

Create a function called predict_best_meteor_shower_viewing that takes in a city as a parameter:

```python
def predict_best_meteor_shower_viewing(city):
```

This is where we get into some tricky Python. If it is complicated, don't worry! This is just the first time you are working with this type of data science functionality. It takes time to get used to it, so treat this as practice!

```python
def predict_best_meteor_shower_viewing(city):
    # Get the latitude of the city from the cities dataframe
    latitude = cities.loc[cities['city'] == city, 'latitude'].iloc[0]
```

Let's break this line of code down:

### `cities['city'] == city`  
This is creating a list of true and false values where true will be on the row where the city is equal to the city passed in as a parameter. 

If you were to write the following, for example:
```python
print(cities['city'] == 'Abu Dhabi')
```

You would get the following output:
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

This line of code will return the rows where the True or False value from above is True. In this case, there will only be 1 returned because our cities dataframe has one row for each city. For example, you could write the following:
```python
print(cities.loc[cities['city'] == 'Abu Dhabi'])
```

And the output would be:
|  | city | latitude | country |
|--|------|----------|---------|
| 0 | Abu Dhabi | 24.47 | United Arab Emirates |

### `cities.loc[cities['city'] == city, 'latitude']`

This line of code will only return the 'latitude' column, instead of the entire row. For example, you could print the following:

```python
print(cities.loc[cities['city'] == 'Abu Dhabi', 'latitude'])
```

And the output would be:
```output
0    24.47
Name: latitude, dtype: float64
```

### `latitude = cities.loc[cities['city'] == city, 'latitude'].iloc[0]`

Finally, the entire line of code will return the spefic value of that column at row 0, in this case, 24.47:
```python
print(cities.loc[cities['city'] == 'Abu Dhabi', 'latitude'].iloc[0])
```

```output
24.47
```

## Call the function

Now that you have some value, it's best to test your function so far to make sure it's working as you expect it to. You should return the value that you have so far, and then call the function:

```python
def predict_best_meteor_shower_viewing(city):
    # Get the latitude of the city from the cities dataframe
    latitude = cities.loc[cities['city'] == city, 'latitude'].iloc[0]

    return latitude
```

```python
print(predict_best_meteor_shower_viewing('Abu Dhabi'))
```

```output
24.47
```