What do our vectors mean? Put another way, what kinds of foods populate the differnt clusters we have discovered among the data?

To see these results, we will create pandas Series for each of the components, index them by feature, and then sort them in descreasing order (so that a higher number represents a feature that is positively correlated with that vector and negative numbers represent low correlation).

First, run this code in a cell:

```python
vects = fit.components_[:5]
```

Next, run this code in a cell:

```python
c1 = pd.Series(vects[0], index=nutr_df.columns)
c1.sort_values(ascending=False)
```

This is the output:

```Output
Protein_(g)          0.253011
Selenium_(Âµg)       0.237214
Zinc_(mg)            0.233275
Choline_Tot_ (mg)    0.227019
Phosphorus_(mg)      0.224003
Niacin_(mg)          0.212308
Riboflavin_(mg)      0.206798
Panto_Acid_mg)       0.205353
Cholestrl_(mg)       0.202130
FA_Mono_(g)          0.199087
Lipid_Tot_(g)        0.197132
Vit_B12_(Âµg)        0.196320
Vit_B6_(mg)          0.193737
FA_Sat_(g)           0.192418
Iron_(mg)            0.162307
FA_Poly_(g)          0.161677
Energ_Kcal           0.159268
Ash_(g)              0.146991
Magnesium_(mg)       0.143715
Potassium_(mg)       0.142175
Thiamin_(mg)         0.138838
Vit_D_Âµg            0.138423
Retinol_(Âµg)        0.115504
Sodium_(mg)          0.104025
Copper_mg)           0.095703
Calcium_(mg)         0.058003
Vit_E_(mg)           0.040701
Food_Folate_(Âµg)    0.017723
Folate_Tot_(Âµg)     0.016790
Folic_Acid_(Âµg)     0.001449
Manganese_(mg)      -0.035053
Vit_K_(Âµg)         -0.035386
Vit_A_IU            -0.051647
Lycopene_(Âµg)      -0.054287
Beta_Crypt_(Âµg)    -0.084480
Alpha_Carot_(Âµg)   -0.093607
Fiber_TD_(g)        -0.098041
Water_(g)           -0.107941
Carbohydrt_(g)      -0.122976
Lut+Zea_ (Âµg)      -0.123936
Beta_Carot_(Âµg)    -0.144259
Sugar_Tot_(g)       -0.145755
Vit_C_(mg)          -0.160070
dtype: float64
```

Our first cluster is defined by foods that are high in protein and minerals like selenium and zinc while also being low in sugars and vitamin C. Even to a non-specialist, these sound like foods such as meat, poultry, or legumes.

> [!div class="alert is-tip"]
> ### Takeaway
>
> Particularly when it comes to interpretation, subject-matter expertise can prove essential to producing high-quality analysis. For this reason, you should also try to include SMEs in your data -cience projects.

Then, run this code in a cell:

```python
c2 = pd.Series(vects[1], index=nutr_df.columns)
c2.sort_values(ascending=False)
```

Here's the output:

```Output
Manganese_(mg)       0.298009
Fiber_TD_(g)         0.291384
Folate_Tot_(Âµg)     0.272273
Carbohydrt_(g)       0.257291
Food_Folate_(Âµg)    0.241234
Copper_mg)           0.225446
Magnesium_(mg)       0.213403
Calcium_(mg)         0.199649
Lut+Zea_ (Âµg)       0.194307
Sugar_Tot_(g)        0.183276
Ash_(g)              0.181539
Vit_E_(mg)           0.178778
Vit_K_(Âµg)          0.178267
Iron_(mg)            0.175137
Folic_Acid_(Âµg)     0.161876
Thiamin_(mg)         0.147750
Beta_Carot_(Âµg)     0.144678
Energ_Kcal           0.137560
FA_Poly_(g)          0.126692
Potassium_(mg)       0.125701
Vit_C_(mg)           0.101272
Alpha_Carot_(Âµg)    0.089881
Sodium_(mg)          0.084379
Phosphorus_(mg)      0.083271
Beta_Crypt_(Âµg)     0.075684
Riboflavin_(mg)      0.072510
Vit_A_IU             0.064685
Lycopene_(Âµg)       0.053394
Lipid_Tot_(g)        0.053251
Panto_Acid_mg)       0.033587
FA_Mono_(g)          0.027734
FA_Sat_(g)           0.010743
Niacin_(mg)          0.000861
Zinc_(mg)           -0.008836
Selenium_(Âµg)      -0.022615
Choline_Tot_ (mg)   -0.029344
Protein_(g)         -0.031398
Vit_B6_(mg)         -0.037995
Retinol_(Âµg)       -0.067326
Vit_D_Âµg           -0.132349
Vit_B12_(Âµg)       -0.158239
Cholestrl_(mg)      -0.162787
Water_(g)           -0.200880
dtype: float64
```

Our second group is foods that are high in fiber and folic acid and low in cholesterol.

> EXERCISE



Hint: Remember that Python uses zero-indexing.


### Try it yourself

Can you think of a more concise way to check the number of rows and columns in a `DataFrame`?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Find the sorted output for $c_{3}$, $c_{4}$, and $c_{5}$.

  Hint: Remember that Python uses zero-indexing.
 
 
  Here's a possible solution:

  ```python
  TBD
  ```
    
  The output is:

  ```Output
  TBD
  ```

</details>

<br /><br />

***

Even without subject-matter expertise, it is possible to get a more accurate sense of the kinds of foods are defined by each component? Yes! This is the reason we merged the FoodGroup column back into pca_df. We will sort that DataFrame by the components and count the values from FoodGroup for the top items.

```python
pca_df.sort_values(by='c1')['FoodGroup'][:500].value_counts()
```

Here's the output:

```Output
Vegetables and Vegetable Products    189
Fruits and Fruit Juices              110
Beverages                             70
Sweets                                41
Soups, Sauces, and Gravies            34
Baby Foods                            31
Fats and Oils                          8
Spices and Herbs                       5
Dairy and Egg Products                 4
Breakfast Cereals                      3
Cereal Grains and Pasta                2
Baked Products                         1
Nut and Seed Products                  1
Restaurant Foods                       1
Name: FoodGroup, dtype: int64
```

We can do the same thing for $c_{2}$.

```python
pca_df.sort_values(by='c2')['FoodGroup'][:500].value_counts()
```

The output is:

```Output
Dairy and Egg Products         22
Fats and Oils                   5
Baby Foods                      2
Sausages and Luncheon Meats     1
Soups, Sauces, and Gravies      1
Poultry Products                1
Name: FoodGroup, dtype: int64
```

Exercise: Repeat this process for $c_{3}$, $c_{4}$, and $c_{5}$.


**A parting note**: Baby Foods and some other categories might seem to dominate several of the categories. This is a product of all of the rows we had to drop that had NaN values. If we look at all of the value counts for FoodGroup, we will see that they are not evenly distributed, with some categories far more represented than others.

```python
df['FoodGroup'].value_counts()
```

The output is:

```Output
Beef Products                        345
Vegetables and Vegetable Products    259
Baked Products                       217
Pork Products                        165
Dairy and Egg Products               132
Poultry Products                     128
Fruits and Fruit Juices              122
Sweets                               108
Finfish and Shellfish Products        94
Beverages                             87
Soups, Sauces, and Gravies            68
Baby Foods                            64
Lamb, Veal, and Game Products         64
Legumes and Legume Products           57
Nut and Seed Products                 49
Snacks                                44
Fats and Oils                         43
Sausages and Luncheon Meats           40
Fast Foods                            24
Spices and Herbs                      22
Meals, Entrees, and Side Dishes       21
Breakfast Cereals                     20
Restaurant Foods                      10
Cereal Grains and Pasta                7
Name: FoodGroup, dtype: int64
```







