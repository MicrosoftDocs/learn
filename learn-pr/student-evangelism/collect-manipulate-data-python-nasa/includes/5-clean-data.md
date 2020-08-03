Now that we have the data imported, will we need to apply a machine learning practice known as "cleaning the data". This pretty much means what you think it means: take data that looks incorrect or messy and clean it up by changing the value or deleting it altogether. Some common examples of cleaning data are ensuring that there are no null values or making every value in a column look the same. 

We do this because computers will get confused if they look at inconsistent data or if lots of values in the data are null.

## Data Cleansing

The first step that we will take to clean our data is to replaces all the missing values with something. Replacing these values usually requires subject matter expertise, but in this case you will use your best judgment. In our case, we have some rows (remember, rows represent days) where we are missing some weather or launch data. 

To get started, first get an overview of the launch data by typing this into a cell:

```python
launch_data.info()
```

This gives an overview of the data, showing us that of 300 rows, there are some columns with missing information:

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
 13  Percipitation at Launch Time  299 non-null    float64       
 14  Hist Ave Percipitation        299 non-null    float64       
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
Most notably, we can see that `Hist Ave Max Wind Speed`, `Hist Ave Visibility`, and `Hist Ave Sea Level Pressure` have no data. 

It makes sense that `Wind Speed at Launch Time`, `Temp at Launch Time`, `Launched`, `Crewed or Uncrewed`, `Time`, and `Name` only have 60 values, since we only have 60 launches in our data, the rest are the days preceding and proceeding the launch. 

Here are a few ways to cleanse the data: 
- We know that the rows that do not have a Y in the Launched column did not have a rocket launch, so we will make those missing values 'N'
- For rows missing information on whether the rocket was crewed or uncrewed we will assume uncrewed. There were fewer crewed missions so it is likely it was uncrewed.
- For missing wind direction we will just mark them as "unknown"
- For missing Condition data we will just assume it was a typical day and put "fair"
- For any other data, just put the value as 0

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

Try running `launch_data.info()` again to see the changes to the data you just made.

> [!NOTE]
> You are changing the data that is stored in the launch_data variable, *not* the data saved in the Excel doc. So if you find that you can modified or removed any data that you didn't mean to, you can always re-run your notebook to bring the original data back in.

## Data Manipulation

Next, since computations are best suited for numerical inputs, we will convert all text into numbers. As an example, we will use a "1" if a rocket is crewed and a "0" if a rocket is uncrewed.

```python
## As part of the data cleaning process we have to convert text data to numerical because computers only understand numbers
label_encoder = preprocessing.LabelEncoder()

# There are 3 columns that have categorical text info and we convert them to numbers
launch_data['Crewed or Uncrewed'] = label_encoder.fit_transform(launch_data['Crewed or Uncrewed'])
launch_data['Wind Direction'] = label_encoder.fit_transform(launch_data['Wind Direction'])
launch_data['Condition'] = label_encoder.fit_transform(launch_data['Condition'])
```

Now let's look at all the data again after it has been cleaned. Looking all nice and fresh!

```python
launch_data.head()
```