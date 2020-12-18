Let's take a step back and see how the number of samples compares to the amount of sample. We can compare the total weight from the `needed_samples` DataFrame to the `rock_samples` DataFrame. That is, we'll compare the samples we've identified as running low to all the samples collected on Apollo missions.

```python
needed_samples.groupby('Type')['Weight (kg)'].sum()
```

```output
Type
Basalt     17.4234
Breccia    10.1185
Name: Weight (kg), dtype: float64
```

```python
rock_samples.groupby('Type')['Weight (kg)'].sum()
```

```output
Type
Basalt      93.14077
Breccia    168.88075
Core        19.93587
Crustal      4.74469
Soil        87.58981
Special      0.74410
Name: Weight (kg), dtype: float64
```

One bit of information really stands out: we've never had a lot of Crustal rocks in the first place. 

We can add Crustal rocks to the set of needed samples:

```python
needed_samples = needed_samples.append(rock_samples.loc[rock_samples['Type'] == 'Crustal'])
needed_samples.info()
```

```output
 #   Column         Non-Null Count  Dtype  
---  ------         --------------  -----  
 0   ID             68 non-null     int64  
 1   Mission        68 non-null     object 
 2   Type           68 non-null     object 
 3   Subtype        68 non-null     object 
 4   Weight (kg)     68 non-null     float64
 5   Pristine (%)    68 non-null     float64
 6   Remaining (kg)  68 non-null     float64
 ```

## Summary of needed samples

The final step is to consolidate everything we know into one table that can be shared with the astronauts. First, we need a column for each type of rock that we have already identified as rocks we want more samples of:

 ```python
needed_samples_overview = pd.DataFrame()
needed_samples_overview['Type'] = needed_samples.Type.unique()
needed_samples_overview
 ```

| Index | Type |
|---|---|
| 0 | Basalt |
| 1 | Breccia |
| 2 | Crustal |

Next, we want the total weight of each type of rock that was originally collected:

```python
needed_sample_weights = needed_samples.groupby('Type')['Weight (kg)'].sum().reset_index()
needed_samples_overview = pd.merge(needed_samples_overview, needed_sample_weights, on='Type')
needed_samples_overview.rename(columns={'Weight (kg)':'Total weight (kg)'}, inplace=True)
needed_samples_overview
```

| Index | Type | Total weight (kg) |
|---|---|---|
| 0 | Basalt | 17.42340 |
| 1 | Breccia | 10.11850 |
| 2 | Crustal | 4.74469 |

When astronauts are up on the Moon, one way they can identify rocks is by their size. If we can give them an estimated size of each type of rock, that might make their collection process easier.

```python
needed_sample_ave_weights = needed_samples.groupby('Type')['Weight (kg)'].mean().reset_index()
needed_samples_overview = pd.merge(needed_samples_overview, needed_sample_ave_weights, on='Type')
needed_samples_overview.rename(columns={'Weight (kg)':'Average weight (kg)'}, inplace=True)
needed_samples_overview
```

| Index | Type | Total weight (kg) | Average weight (kg) |
|---|---|---|---|
| 0 | Basalt | 17.42340 | 1.244529 |
| 1 | Breccia | 10.11850 | 1.264812 |
| 2 | Crustal | 4.74469 | 0.103145 |

Crustals are small! They're probably a lot harder to spot, so no wonder we don't have a lot of them.

We probably want to give the astronauts some indication of how many of each type we want them to collect. So, for the three types we're looking for, we should grab the total number we have of each type and get the remaining percentage of each type of rock. 

```python
total_rock_count = rock_samples.groupby('Type')['ID'].count().reset_index()
needed_samples_overview = pd.merge(needed_samples_overview, total_rock_count, on='Type')
needed_samples_overview.rename(columns={'ID':'Number of samples'}, inplace=True)
total_rocks = needed_samples_overview['Number of samples'].sum()
needed_samples_overview['Percentage of rocks'] = needed_samples_overview['Number of samples'] / total_rocks
needed_samples_overview
```

| Index | Type | Total weight (kg) | Average weight (kg) | Number of samples | Percentage of rocks |
|---|---|---|---|---|---|
| 0 | Basalt | 17.42340 | 1.244529 | 351 | 0.258850 |
| 1 | Breccia | 10.11850 | 1.264812 |959 | 0.707227 |
| 2 | Crustal | 4.74469 | 0.103145 | 46 | 0.033923 |

And finally, to tie it all back into a recommendation to the Artemis program, we can determine the average weight of samples we estimated in the preceding unit.

```python
artemis_ave_weight = artemis_mission['Estimated sample weight (kg)'].mean()
artemis_ave_weight
```

```output
64.22588520079607
```

We can use this number to determine how many of each rock we want the astronauts to aim to collect:

```python
needed_samples_overview['Weight to collect'] = needed_samples_overview['Percentage of rocks'] * artemis_ave_weight
needed_samples_overview['Rocks to collect'] = needed_samples_overview['Weight to collect'] / needed_samples_overview['Average weight (kg)']
needed_samples_overview
```

| Index | Type | Total weight (kg) | Average weight (kg) | Number of samples | Percentage of rocks | Weight to collect | Rocks to collect |
|---|---|---|---|---|---|---|---|
| 0 | Basalt | 17.42340 | 1.244529 | 351 | 0.258850 | 16.624842 | 13.358345 |
| 1 | Breccia | 10.11850 | 1.264812 |959 | 0.707227 | 45.422289 | 35.912271 |
| 2 | Crustal | 4.74469 | 0.103145 | 46 | 0.033923 | 2.178754 | 21.123128 |

So, we might tell the Artemis astronauts to please try to collect 13 Basalt rocks, 35 Breccia rocks, and 21 Crustal rocks. Whew!
