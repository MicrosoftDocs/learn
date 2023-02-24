Before you continue, it's important to establish what information you want to use to make a recommendation to the astronauts. In this case, the more publicly available information that could affect the amount of sample that is *possible* to return is the type of spacecraft used. 

## Convert the sample weight

While details of rocket design are proprietary, some information is publicly available, such as the weight of the modules (parts of the rocket) that will carry the samples back to Earth, and the total amount of weight that the rocket can lift above the atmosphere. 

We will get into the specifics of that in a later unit, but the critical part for the purposes of the samples is understanding that rocket weight is often measured in kilograms, not grams. We should then manipulate the original data by converting the sample weights into kilograms for easier data analysis later.

```python
rock_samples['Weight (g)'] = rock_samples['Weight (g)'].apply(lambda x : x * 0.001)
rock_samples.rename(columns={'Weight (g)':'Weight (kg)'}, inplace=True)
rock_samples.head()
```

|   | ID | Mission | Type | Subtype | Weight (g) | Pristine (%) |
|---|---|---|---|---|---|---|
| **0** | 10001 | Apollo11 | Soil | Unsieved | 0.125 | 88.36 |
| **1** | 10002 | Apollo11 | Soil | Unsieved | 5.6290 | 93.73 |
| **2** | 10003 | Apollo11 | Basalt | Ilmenite | 0.2130 | 65.56 |
| **3** | 10004 | Apollo11 | Core | Unsieved | 0.0448 | 71.76 |
| **4** | 10005 | Apollo11 | Core | Unsieved | 0.0534 | 40.31 |

Here we first modified the values in the **Weight (g)** column to be the same value multiplied by 0.001. Then we modified the name of the column to be more accurate by changing it to **Weight (kg)**.

## Create a new DataFrame

Pandas, the Python library we are using to do our data analysis, has a structure called a DataFrame, and it's really effective for representing 2D data. You might have recognized that, when you run the `rock_samples.head()` code, what is printed out looks almost like a snapshot of an Excel worksheet, which is a great way to think about DataFrames in pandas.

The `rock_samples` DataFrame has a row for every sample that was collected but, as we mentioned earlier, we want to understand the rock samples in total as they relate to the specific rockets that brought them back. 

Create a new DataFrame called `missions` that will be a summary of data for each of the six Apollo missions that brought samples back. Create a column in this DataFrame called **Mission** that has one row for each mission.

```python
missions = pd.DataFrame()
missions['Mission'] = rock_samples['Mission'].unique()
missions.head()
```

| Index | Mission |
|-------|---------|
| 0     | Apollo11 |
| 1     | Apollo12 |
| 2     | Apollo14 |
| 3     | Apollo15 |
| 4     | Apollo16 |

```python
missions.info()
```

```output
 #   Column   Non-Null Count  Dtype 
---  ------   --------------  ----- 
 0   Mission  6 non-null      object
```

## Sum total sample weight by mission

Now you can add a new column to the `missions` DataFrame to represent the sum of all samples collected on that mission. 

```python
sample_total_weight = rock_samples.groupby('Mission')['Weight (kg)'].sum()
missions = pd.merge(missions, sample_total_weight, on='Mission')
missions.rename(columns={'Weight (kg)':'Sample weight (kg)'}, inplace=True)
missions
```
| Index | Mission | Sample weight (kg) |
|-------|---------|-------------------|
| 0     | Apollo11 | 21.55424 |
| 1     | Apollo12 | 34.34238 |
| 2     | Apollo14 | 41.83363 |
| 3     | Apollo15 | 75.39910 |
| 4     | Apollo16 | 92.46262 |
| 5     | Apollo17 | 109.44402 |

Let's break out this code a bit. The first line was `sample_total_weight = rock_samples.groupby('Mission')['Weight (kg)'].sum()`, which can be broken out as follows:
- `rock_samples.groupby('Mission')` - This groups all the rows by the values in the **Mission** column.
- `rock_samples.groupby('Mission')['Weight (kg)']` - This grabs all the values in the **Weight (kg)** column, but groups by unique values in the **Mission** column.
- `rock_samples.groupby('Mission')['Weight (kg)'].sum()` - This sums all the values in the **Weight (kg)** column for each unique value in the **Mission** column.

If you were to print out that one line, you would get a pandas series, which is basically a 1D data type, or a list. The list would have the index be the unique value from the **Mission** column, instead of a number:

```python
sample_total_weight = rock_samples.groupby('Mission')['Weight (kg)'].sum()
sample_total_weight
```

```output
Mission
Apollo11     21.55424
Apollo12     34.34238
Apollo14     41.83363
Apollo15     75.39910
Apollo16     92.46262
Apollo17    109.44402
Name: Weight (kg), dtype: float64
```

The next line, `pd.merge(missions, sample_total_weight, on='Mission')`, can be described as:

> Merge the `missions` DataFrame with the `sample_total_weight` series by using the **Mission** column as the index to merge on. What the computer will do is basically this: for each value in the **Missions** column in the `missions` DataFrame, find that same value in the  `sample_total_weight` series, and add the value from the series into the row as a new column in the DataFrame.  

This example is fairly straightforward, because there are only six rows. So we can confirm that the number 21.55424, for example, was added to the Apollo 11 row in the `missions` DataFrame. 

The next line simply renames the column, just as we did before, to ensure that we are being specific with our data. 

The last line prints out the entire `missions` DataFrame. Because there are only six missions, we can print out the entire DataFrame and still understand what we are looking at. There is no need to use `head()` to print out only the first five rows.

## Get the difference in weights across missions

We're not rocket experts, so it's important to take a look at a lot of different cross sections of data that are available to you. In this case, we can see that the total weight of the samples increased with each mission, but it's hard to immediately see by how much. We can add one more column to the `missions` DataFrame that simply grabs the difference between the current row and the row preceding it:

```python
missions['Weight diff'] = missions['Sample weight (kg)'].diff()
missions
```

| Index | Mission | Sample weight (kg) | Weight diff |
|-------|---------|-------------------|-------------|
| 0     | Apollo11 | 21.55424 | NaN |
| 1     | Apollo12 | 34.34238 | 12.78814 |
| 2     | Apollo14 | 41.83363 | 7.49125 |
| 3     | Apollo15 | 75.39910 | 33.56547 |
| 4     | Apollo16 | 92.46262 | 17.06352 |
| 5     | Apollo17 | 109.44402 | 16.98140 |

Notice that in the first row, for Apollo11, the value in the **Weight diff** column is `NaN`. This is called a *null* value. Because Apollo11 was the first mission, there is no difference between the weight of the rock collected on Apollo11 and that of the previous mission. We can fill this `NaN` value with 0:

```python
missions['Weight diff'] = missions['Weight diff'].fillna(value=0)
missions
```

| Index | Mission | Sample weight (kg) | Weight diff |
|-------|---------|-------------------|-------------|
| 0     | Apollo11 | 21.55424 | 0.00000 |
| 1     | Apollo12 | 34.34238 | 12.78814 |
| 2     | Apollo14 | 41.83363 | 7.49125 |
| 3     | Apollo15 | 75.39910 | 33.56547 |
| 4     | Apollo16 | 92.46262 | 17.06352 |
| 5     | Apollo17 | 109.44402 | 16.98140 |

This Python code did the following:
- Looked only at the **Weight diff** column in the `missions` DataFrame
- Filled all "na" (or null) values with a certain value 
- The value to fill in the na values is 0
- Saved the modified list of values for that column back into the column

This last step is important. Pandas is a library that is designed to let us explore data, which means that some of the functions will provide insight into the data, but not directly modify it. When in doubt, read the docs and test!
