
What sorts of foods populate the clusters? We'll examine that question in greater depth later on. But we can get some sense of our clusters just by looking at the mean values for each of them.

```python
nutr_df.groupby('Cluster').mean()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | Calcium_(mg) | Iron_(mg) | ... | Beta_Crypt_(Âµg) | Lycopene_(Âµg) | Lut+Zea_ (Âµg) | Vit_E_(mg) | Vit_D_Âµg | Vit_K_(Âµg) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **Cluster** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| **0** | 71.816817 | 137.272615 | 12.223610 | 5.735732 | 1.258326 | 9.008705 | 1.006785 | 3.604840 | 40.666530 | 1.285576 | ... | 6.820312 | 176.133635 | 258.333470 | 0.427105 | 0.478660 | 14.840954 | 2.045090 | 2.265424 | 0.801076 | 43.479852 |
| **1** | 14.111772 | 333.278481 | 13.330380 | 6.430886 | 4.023291 | 62.117595 | 8.775949 | 18.922152 | 360.063291 | 21.291519 | ... | 127.329114 | 6.050633 | 574.569620 | 8.037468 | 2.954430 | 57.910127 | 1.867608 | 1.970924 | 1.746911 | 74.607595 |
| **2** | 13.299777 | 422.539702 | 10.758201 | 20.214479 | 3.395434 | 52.163176 | 4.500744 | 20.878958 | 177.214640 | 3.316067 | ... | 4.470223 | 76.518610 | 100.244417 | 2.330608 | 0.437717 | 11.111911 | 6.609720 | 7.394919 | 4.668969 | 20.063275 |

3 rows × 43 columns
***

We can quickly see that cluster 2 encompasses fatty foods (high `Lipid_Tot_(g)` values). Clusters 0 and 1 have similar mean protein and lipid amounts. An easy-to-see differentiation between those clusters is their relative carbohydrate and sugar levels. The relative carbohydrate and sugar levels in cluster 1 are higher than those in cluster 0.

We can look at these high-level differences in a little more detail by using the `describe()` method. Honestly, this is a little cumbersome because of the size of the DataFrame.

```python
nutr_df.groupby('Cluster').describe()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Alpha_Carot_(Âµg) | | | | | | | | Ash_(g) | | ... | Water_(g) | | Zinc_(mg) | | | | | | | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | count | mean | std | min | 25% | 50% | 75% | max | count | mean | ... | 75% | max | count | mean | std | min | 25% | 50% | 75% | max |
| **Cluster** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| **0** | 2432.0 | 40.168586 | 305.882647 | 0.0 | 0.0 | 0.0 | 0.0 | 4795.0 | 2432.0 | 1.258326 | ... | 85.665 | 99.90 | 2432.0 | 1.982932 | 2.801148 | 0.00 | 0.2800 | 0.820 | 2.83 | 61.04 |
| **1** | 79.0 | 227.721519 | 1616.630993 | 0.0 | 0.0 | 0.0 | 11.0 | 14251.0 | 79.0 | 4.023291 | ... | 9.440 | 85.14 | 79.0 | 11.678354 | 15.716752 | 0.01 | 3.3000 | 7.100 | 13.84 | 90.95 |
| **2** | 806.0 | 8.844913 | 113.667236 | 0.0 | 0.0 | 0.0 | 0.0 | 2820.0 | 806.0 | 3.395434 | ... | 20.790 | 59.55 | 806.0 | 1.787320 | 1.994994 | 0.00 | 0.5325 | 1.135 | 2.60 | 25.43 |

3 rows × 344 columns
***

We can also predict the label for new or hypothetical observations. Let's provide the nutritional details for Gjetost cheese and see which cluster our model places it in. (Gjetost cheese is one of our discarded entries from the original DataFrame, with `NaN` values entered as follows.)

```python
newcase = [[1021,
            13.44,
            466.0,
            9.65,
            29.51,
            4.75,
            42.65,
            0.0,
            1.50,
            400.0,
            0.52,
            70.0,
            444.0,
            1409.0,
            600.0,
            1.14,
            0.08,
            0.04,
            14.5,
            0.0,
            0.315,
            1.382,
            0.813,
            3.351,
            0.271,
            5.0,
            0.0,
            5.0,
            15.4,
            2.42,
            1113.0,
            334.0,
            0,
            20,
            0,
            0.5,
            22,
            2.4,
            19.16,
            7.879,
            0.938,
            94.0,
            28.35]]
```

Then:

```python
kmeansmodel.predict(newcase)
```

The output is:

```Output
array([1])
```

The output indicates that Gjetost cheese falls under cluster 1.

We can also see the actual coordinate values for cluster centroids.

```python
kmeansmodel.cluster_centers_
```

The output is:

```Output
array([[ 5.19147344e-01, -4.74611100e-01,  2.97580905e-02,
        -2.69327660e-01, -1.63389078e-01, -4.43020482e-01,
        -2.43165565e-01, -2.95955913e-01, -1.63751856e-01,
        -2.07451727e-01, -2.60919025e-01, -1.55810696e-01,
        -1.27068942e-01, -9.05851979e-02, -4.77652431e-02,
        -1.57870397e-01, -8.23482764e-02, -1.65947664e-02,
        -2.43126473e-02, -1.35036794e-01, -1.44203152e-01,
        -9.85132597e-02, -9.83892226e-02, -8.64619503e-02,
        -1.76821214e-01, -1.48075798e-01, -1.10584243e-01,
         1.48896139e-02, -1.46043075e-02, -2.85635138e-02,
        -1.06521285e-01,  8.58262861e-03,  2.24611792e-02,
        -1.76150297e-02,  2.00676657e-02,  2.40507703e-02,
        -1.85548660e-01, -2.47321972e-02, -1.56388501e-03,
        -2.05049980e-01, -2.11195492e-01, -2.43018317e-01,
         5.00462974e-02],
       [-1.40200829e+00,  7.82751805e-01,  1.29646585e-01,
        -2.16361000e-01,  6.08661461e-01,  1.55921783e+00,
         1.58384462e+00,  6.97685830e-01,  1.11856728e+00,
         4.07176567e+00,  1.48364482e+00,  6.18176278e-01,
         6.29767101e-01,  1.19611858e-01,  2.47759857e+00,
         1.89680543e+00,  1.07526994e+00,  1.96775682e-01,
         1.14421338e+00,  2.74794536e+00,  3.78025220e+00,
         3.63624472e+00,  2.84734837e+00,  3.95620893e+00,
         3.98176764e+00,  4.00253487e+00,  1.41090807e+00,
         6.94103091e-01,  2.68979982e+00,  1.95528760e+00,
         3.06754360e+00,  5.20496729e-01,  6.20732214e-01,
         9.05699101e-01, -1.00725377e-01,  2.70330468e-01,
         2.00786691e+00,  1.22447549e+00,  5.61404663e-01,
        -2.37986466e-01, -2.61378538e-01, -4.18001733e-03,
         3.64844994e-01],
       [-1.42904179e+00,  1.35535583e+00, -1.02498457e-01,
         8.33867728e-01,  4.33347374e-01,  1.18393003e+00,
         5.78480061e-01,  8.24624814e-01,  3.84463646e-01,
         2.26864902e-01,  6.41869886e-01,  4.09547999e-01,
         3.21687427e-01,  2.61605291e-01, -9.87161490e-02,
         2.90438183e-01,  1.43082733e-01,  3.07855992e-02,
        -3.87897009e-02,  1.38116378e-01,  6.45932281e-02,
        -5.91551923e-02,  1.77941294e-02, -1.26879705e-01,
         1.43262469e-01,  5.44914219e-02,  1.95383550e-01,
        -1.12959907e-01, -2.19573834e-01, -1.05460614e-01,
         2.07491589e-02, -7.69133925e-02, -1.28614681e-01,
        -3.56209389e-02, -5.06789803e-02, -9.90664769e-02,
         3.63068057e-01, -4.53906452e-02, -5.03071961e-02,
         6.42037818e-01,  6.62873872e-01,  7.33685816e-01,
        -1.86768424e-01]])
```

Remember that there is a method to this wall of numbers. Each coordinate is a point in 43-dimensional space, so an array of 43 values represents each centroid.

Let's now add back in our descriptive features so that we can see which food groups are in our clusters.

```python
merged_df = nutr_df.join(desc_df)
merged_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | Calcium_(mg) | Iron_(mg) | ... | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | Cluster | FoodGroup | Shrt_Desc | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **NDB_No** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| **1001** | 15.87 | 717.0 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | 24.0 | 0.02 | ... | 21.021 | 3.043 | 215.0 | 2 | Dairy and Egg Products | BUTTER,WITH SALT | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
| **1002** | 16.72 | 718.0 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | 23.0 | 0.05 | ... | 19.874 | 3.331 | 225.0 | 2 | Dairy and Egg Products | BUTTER,WHIPPED,W/ SALT | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
| **1003** | 0.24 | 876.0 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | 4.0 | 0.00 | ... | 28.732 | 3.694 | 256.0 | 2 | Dairy and Egg Products | BUTTER OIL,ANHYDROUS | 1 tbsp | 205.0 | 1 cup | 0.0 |
| **1004** | 42.41 | 353.0 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | 528.0 | 0.31 | ... | 7.778 | 0.800 | 75.0 | 2 | Dairy and Egg Products | CHEESE,BLUE | 1 oz | 17.0 | 1 cubic inch | 0.0 |
| **1005** | 41.11 | 371.0 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | 674.0 | 0.43 | ... | 8.598 | 0.784 | 94.0 | 2 | Dairy and Egg Products | CHEESE,BRICK | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

5 rows × 50 columns
***

Now we can look at the value counts for the food groups in our clusters.

```python
merged_df.loc[nutr_df['Cluster'] == 0]['FoodGroup'].value_counts()
```

The output is:

```Output
Beef Products                          421
Vegetables and Vegetable Products      412
Pork Products                          194
Fruits and Fruit Juices                165
Poultry Products                       145
Baby Foods                             108
Finfish and Shellfish Products         106
Dairy and Egg Products                 104
Soups, Sauces, and Gravies              97
Beverages                               93
Baked Products                          77
Lamb, Veal, and Game Products           68
Legumes and Legume Products             68
Sweets                                  58
Fast Foods                              57
Sausages and Luncheon Meats             52
Meals, Entrees, and Side Dishes         32
Cereal Grains and Pasta                 26
Restaurant Foods                        20
Fats and Oils                           20
Breakfast Cereals                        9
Spices and Herbs                         7
Nut and Seed Products                    3
American Indian/Alaska Native Foods      2
Name: FoodGroup, dtype: int64
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Look over the Python in the preceding code cell. Does the syntax make sense? If not, review the documentation for [`pandas.DataFrame.loc`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.loc.html?azure-portal=true) and [`pandas.Series.value_counts`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.value_counts.html?azure-portal=true).

### Try it yourself

Find the `FoodGroup` value counts for clusters 1 and 2.

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Solution:

  ```python
  merged_df.loc[nutr_df['Cluster'] == 1]['FoodGroup'].value_counts()
  ```

  The output is:

  ```Output
  Vegetables and Vegetable Products    63
  Spices and Herbs                      4
  Soups, Sauces, and Gravies            1
  Snacks                                1
  Name: FoodGroup, dtype: int64
  ```

  And:

  ```python
  merged_df.loc[nutr_df['Cluster'] == 2]['FoodGroup'].value_counts()
  ```

  The output is:

  ```Output
  Vegetables and Vegetable Products    349
  Fruits and Fruit Juices              165
  Baby Foods                           107
  Soups, Sauces, and Gravies            97
  Beverages                             93
  Dairy and Egg Products                69
  Baked Products                        62
  Legumes and Legume Products           62
  Sweets                                62
  Meals, Entrees, and Side Dishes       30
  Cereal Grains and Pasta               26
  Fats and Oils                         20
  Restaurant Foods                      16
  Fast Foods                            15
  Finfish and Shellfish Products        10
  Breakfast Cereals                      9
  Spices and Herbs                       6
  Nut and Seed Products                  3
  Sausages and Luncheon Meats            2
  Pork Products                          1
  Name: FoodGroup, dtype: int64
  ```

</details>

<br /><br />

***

Some of the entries in our clusters make sense, and others look like the contents of a grab bag. Part of the reason is that the k-means algorithm has to draw arbitrary boundaries between clusters. There will be a lot of entries in all clusters that are right on the edge and could belong to two (or more) clusters. To reduce some of this noise, we can sort these by distance from centroid of the respective clusters and look at the entries closest to the centroids.

```python
import numpy as np

distances = kmeansmodel.fit_transform(X)
merged_df['Distance'] = np.min(distances, axis=1)
merged_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | Calcium_(mg) | Iron_(mg) | ... | FA_Poly_(g) | Cholestrl_(mg) | Cluster | FoodGroup | Shrt_Desc | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct | Distance |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **NDB_No** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| **1001** | 15.87 | 717.0 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | 24.0 | 0.02 | ... | 3.043 | 215.0 | 4 | Dairy and Egg Products | BUTTER,WITH SALT | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 | 11.032499 |
| **1002** | 16.72 | 718.0 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | 23.0 | 0.05 | ... | 3.331 | 225.0 | 4 | Dairy and Egg Products | BUTTER,WHIPPED,W/ SALT | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 | 10.091317 |
| **1003** | 0.24 | 876.0 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | 4.0 | 0.00 | ... | 3.694 | 256.0 | 4 | Dairy and Egg Products | BUTTER OIL,ANHYDROUS | 1 tbsp | 205.0 | 1 cup | 0.0 | 13.840848 |
| **1004** | 42.41 | 353.0 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | 528.0 | 0.31 | ... | 0.800 | 75.0 | 3 | Dairy and Egg Products | CHEESE,BLUE | 1 oz | 17.0 | 1 cubic inch | 0.0 | 4.598277 |
| **1005** | 41.11 | 371.0 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | 674.0 | 0.43 | ... | 0.784 | 94.0 | 3 | Dairy and Egg Products | CHEESE,BRICK | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 | 4.914904 |

5 rows × 51 columns
***

> [!div class="alert is-tip"]
> ### Questions
>
> - Why is it necessary to find only the minimum distance to the three centroids for a data point (`np.min`)?
> - What role does the `axis=1` parameter play in the `np.min()` function?

We can now sort `FoodGroup` value counts by distance to the cluster's centroid. That task can make the lists of principal food types in each cluster more intuitive.

```python
merged_df.loc[nutr_df['Cluster'] == 0].sort_values(by='Distance')['FoodGroup'][:500].value_counts()
```

The output is:

```Output
Breakfast Cereals                    33
Snacks                                5
Vegetables and Vegetable Products     4
Beef Products                         3
Poultry Products                      3
Baby Foods                            3
Beverages                             3
Baked Products                        1
Spices and Herbs                      1
Cereal Grains and Pasta               1
Name: FoodGroup, dtype: int64
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Look over the Python in the preceding code cell. Does the syntax make sense? If not, review the documentation for [`pandas.DataFrame.sort_values`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.sort_values.html?azure-portal=true) and [slicing ranges in pandas](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#slicing-ranges?azure-portal=true).

### Try it yourself

Find the sorted `FoodGroup` value counts for clusters 1 and 2.
  
> [!NOTE]
> Because the sizes of the clusters differ, try a variety of ranges for your slices.

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Possible solutions:

  ```python
  merged_df.loc[nutr_df['Cluster'] == 1].sort_values(by='Distance')['FoodGroup'][:30].value_counts()
  ```

  The output is:

  ```Output
  Vegetables and Vegetable Products    29
  Spices and Herbs                      1
  Name: FoodGroup, dtype: int64
  ```

  And:

  ```python
  merged_df.loc[nutr_df['Cluster'] == 2].sort_values(by='Distance')['FoodGroup'][:200].value_counts()
  ```

  The output is:

  ```Output
  Vegetables and Vegetable Products    64
  Fruits and Fruit Juices              50
  Baby Foods                           22
  Soups, Sauces, and Gravies           16
  Dairy and Egg Products                8
  Sweets                                7
  Breakfast Cereals                     6
  Meals, Entrees, and Side Dishes       5
 Legumes and Legume Products           5
  Cereal Grains and Pasta               4
  Restaurant Foods                      2
  Beverages                             1
  Name: FoodGroup, dtype: int64
  ```

</details>

<br /><br />

***

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Even without subject-matter expertise, we can gain insights of varying depth about the clusters.
