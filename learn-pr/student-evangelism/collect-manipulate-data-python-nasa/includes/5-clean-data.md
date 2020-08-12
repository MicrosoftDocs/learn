Now that we have the data imported, we need to apply a machine learning practice known as "cleaning the data." This means taking data that looks incorrect or messy and cleaning it up by changing the value or deleting it altogether. Common examples of cleaning data are ensuring that there are no null values and making every value in a column look the same. 

We do this because computers will get confused if they look at inconsistent data or if lots of values in the data are null.

## Data cleaning

The first step that you'll take to clean your data is to replace all the missing values with something. Replacing these values usually requires subject matter expertise, but in this case you'll use your best judgment. Some rows (remember, rows represent days) are missing weather or launch data. 

To get started, first get an overview of the launch data by entering this command into a cell:

```python
launch_data.info()
```

Of 300 rows, some columns have missing information:

```Output
RangeIndex: 300 entries, 0 to 299
Data columns (total 26 columns):
 #   Column                        Non-Null Count  Dtype         
---  ------                        --------------  -----         
 0   Name                          60 non-null     object        
 1   Date                          300 non-null    datetime64[ns]
 2   Time (East Coast)             59 non-null     object        
 3   Location                      300 non-null    object        
 4   Crewed or Uncrewed            60 non-null     object        
 5   Launched?                     60 non-null     object        
 6   High Temp                     299 non-null    float64       
 7   Low Temp                      299 non-null    float64       
 8   Ave Temp                      299 non-null    float64       
 9   Temp at Launch Time           59 non-null     float64       
 10  Hist High Temp                299 non-null    float64       
 11  Hist Low Temp                 299 non-null    float64       
 12  Hist Ave Temp                 299 non-null    float64       
 13  Precipitation at Launch Time  299 non-null    float64       
 14  Hist Ave Precipitation        299 non-null    float64       
 15  Wind Direction                299 non-null    object        
 16  Max Wind Speed                299 non-null    float64       
 17  Visibility                    299 non-null    float64       
 18  Wind Speed at Launch Time     59 non-null     float64       
 19  Hist Ave Max Wind Speed       0 non-null      float64       
 20  Hist Ave Visibility           0 non-null      float64       
 21  Sea Level Pressure            299 non-null    object        
 22  Hist Ave Sea Level Pressure   0 non-null      float64       
 23  Day Length                    298 non-null    object        
 24  Condition                     298 non-null    object        
 25  Notes                         3 non-null      object 
```

You can see that `Hist Ave Max Wind Speed`, `Hist Ave Visibility`, and `Hist Ave Sea Level Pressure` have no data. 

It makes sense that `Wind Speed at Launch Time`, `Temp at Launch Time`, `Launched`, `Crewed or Uncrewed`, `Time`, and `Name` have only 60 values, because the data includes only 60 launches. The rest are the days before and after the launch.

Here are a few ways to clean the data:

- The rows that don't have `Y` in the `Launched` column did not have a rocket launch, so make those missing values `N`.
- For rows missing information on whether the rocket was crewed or uncrewed, assume uncrewed. Uncrewed is more likely because there were fewer crewed missions.
- For missing wind direction, mark it as `unknown`.
- For missing condition data, assume it was a typical day and use `fair`.
- For any other data, use a value of `0`.

In the next cell, paste and run this code:

```python
## To handle missing values, we will fill the missing values with appropriate values 
launch_data['Launched?'].fillna('N',inplace=True)
launch_data['Crewed or Uncrewed'].fillna('Uncrewed',inplace=True)
launch_data['Wind Direction'].fillna('unknown',inplace=True)
launch_data['Condition'].fillna('Fair',inplace=True)
launch_data.fillna(0,inplace=True)
launch_data.head()
```

Try running `launch_data.info()` again to see the changes that you just made to the data.

> [!NOTE]
> You're changing the data that's stored in the `launch_data` variable, *not* the data saved in the Excel file. If you find that you modified or removed any data that you didn't mean to, you can re-run your notebook to bring the original data back in.

## Data manipulation

Because computations are best suited for numerical inputs, convert all text into numbers. As an example, we'll use `1` if a rocket is crewed and `0` if a rocket is uncrewed.

```python
## As part of the data cleaning process, we have to convert text data to numerical because computers understand only numbers
label_encoder = preprocessing.LabelEncoder()

# Three columns have categorical text info, and we convert them to numbers
launch_data['Crewed or Uncrewed'] = label_encoder.fit_transform(launch_data['Crewed or Uncrewed'])
launch_data['Wind Direction'] = label_encoder.fit_transform(launch_data['Wind Direction'])
launch_data['Condition'] = label_encoder.fit_transform(launch_data['Condition'])
```

Let's look at all the data again and verify that it has been cleaned.

```python
launch_data.head()
```
