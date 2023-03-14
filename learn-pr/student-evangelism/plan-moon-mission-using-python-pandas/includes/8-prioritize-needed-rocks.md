Determining which types of samples to collect from the Moon requires expertise, but we can start to make some assumptions to learn how to clean and manipulate data.

First, we can determine how much remains of each sample that was returned from the Apollo missions, given the amount that was originally collected and the percentage of remaining pristine sample.

```python
rock_samples['Remaining (kg)'] = rock_samples['Weight (kg)'] * (rock_samples['Pristine (%)'] * .01)
rock_samples.head()
```

> [!NOTE]
> You need to multiply the **Pristine (%)** column by 0.01, because it was being represented as a whole number.

Looking at the `head()` or `info()` of the `rock_samples` DataFrame isn't useful at this point. With over 2,000 samples, it's difficult to get an understanding of what the values are. For that, you can use the `describe()` function:

```python
rock_samples.describe()
```

| ID | Remaining (kg) | Weight (kg) | Pristine (%) | ... |
|---|---|---|---|---|
| count | 2229.000000 | 2229.000000 | 2229.000000 | 2229.000000 |
| mean | 52058.432032 | 0.168253 | 84.512764 | 0.138103 |
| std | 26207.651471 | 0.637286 | 22.057299 | 0.525954 |
| min | 10001.000000 | 0.000000 | 0.000000 | 0.000000 |
| 25% | 15437.000000 | 0.003000 | 80.010000 | 0.002432 |
| 50% | 65527.000000 | 0.010200 | 92.300000 | 0.008530 |
| 75% | 72142.000000 | 0.093490 | 98.140000 | 0.078240 |
| max | 79537.000000 | 11.729000 | 180.000000 | 11.169527 |

This helps us see that, on average, each sample weighs about .16 kg and has about 84% of the original amount remaining. We can use this knowledge to extract only the samples that are likely running low, which means that they have been used a lot by researchers.

```python
low_samples = rock_samples.loc[(rock_samples['Weight (kg)'] >= .16) & (rock_samples['Pristine (%)'] <= 50)]
low_samples.head()
```

| Index | ID | Mission | Type | Subtype	weight (kg) | Pristine (%) | Remaining (kg) | ... |
|---|---|---|---|---|---|---|---|
| 11 | 10017 | Apollo11 | Basalt | Ilmenite | 0.973 | 43.71 | 0.425298 |
| 14 | 10020 | Apollo11 | Basalt | Ilmenite | 0.425 | 27.88 | 0.118490 |
| 15 | 10021 | Apollo11 | Breccia | Regolith | 0.250 | 30.21 | 0.075525 |
| 29 | 10045 | Apollo11 | Basalt | Olivine | 0.185 | 12.13 | 0.022441 |
| 37 | 10057 | Apollo11 | Basalt | Ilmenite | 0.919 | 35.15 | 0.323028 |

```python
low_samples.info()
```

```output
 #   Column         Non-Null Count  Dtype  
---  ------         --------------  -----  
 0   ID             27 non-null     int64  
 1   Mission        27 non-null     object 
 2   Type           27 non-null     object 
 3   Subtype        27 non-null     object 
 4   Weight (kg)     27 non-null     float64
 5   Pristine (%)    27 non-null     float64
 6   Remaining (kg)  27 non-null     float64
 ```

Twenty-seven samples seem like a small amount to base a recommendation on. We can probably find some other samples that are needed for more research here on Earth. To discover them, we can use the `unique()` function to see how many unique types we have across the `low_samples` and `rock_samples` DataFrames.

```python
low_samples.Type.unique()
```

```output
array(['Basalt', 'Breccia', 'Soil', 'Core'], dtype=object)
```

```python
rock_samples.Type.unique()
```

```output
array(['Soil', 'Basalt', 'Core', 'Breccia', 'Special', 'Crustal'], dtype=object)
```

We can see that, although six unique types were collected across all samples, the samples that are running low are from only four unique types. But this doesn't tell us everything about the samples we might want to focus on. For example, in our `low_samples` DataFrame, how many of each type are considered low?

```python
low_samples.groupby('Type')['Weight (kg)'].count()
```

> [!NOTE]
> Here we are using the **Weight (kg)** column to count the number of rows for each type that we've grouped by. The actual weight has no impact.

```output
Type
Basalt     14
Breccia     8
Core        1
Soil        4
Name: Weight (kg), dtype: int64
```

Notice that there are more Basalt and Breccia type rocks with low samples than those of Core and Soil. Additionally, because the likelihood is high that every mission has some Core and Soil collection requirements, we can focus on the Basalt and Breccia rock types for the samples that we need to have collected:

```python
needed_samples = low_samples[low_samples['Type'].isin(['Basalt', 'Breccia'])]
needed_samples.info()
```

```output
 #   Column         Non-Null Count  Dtype  
---  ------         --------------  -----  
 0   ID             22 non-null     int64  
 1   Mission        22 non-null     object 
 2   Type           22 non-null     object 
 3   Subtype        22 non-null     object 
 4   Weight (kg)     22 non-null     float64
 5   Pristine (%)    22 non-null     float64
 6   Remaining (kg)  22 non-null     float64
```

But are Basalt and Breccia the only two types of rocks we want to look for?
