By the end of this unit, you should be comfortable selecting and dropping specific columns from a DataFrame.

It might seem strange to discuss splitting a DataFrame in a course section on joining them, but we'll do so here to create the DataFrames that we'll join later on. We take this approach for two reasons:

- Creating our own DataFrames gives us easy control over the content of the child DataFrames to best demonstrate aspects of joining datasets.
- Because we have a baseline, a joined DataFrame (`df`), it's easy to see how different methods of joining the child DataFrames produce different results.

We're going to create two child DataFrames, `df1` and `df2`. `df1` will contain the first 35 columns of our data, and `df2` will contain the rest. This structure will allow us to explore how we can manipulate and manage columns in a dataset. It will also allow us to simulate a common scenario where some of the data that you need is in one location, while the rest is in a different location.

```python
df1 = df.iloc[:,:35]
```

### Try it yourself

- Why did we use syntax `df1 = df.iloc[:,:35]` to capture the first 35 columns of `df`?
- What does the first `:` (colon) in the square brackets do?

Experiment with `df3 = df.iloc[:35]` in a code cell and compare `df3.info()` with `df1.info()` to see why we need to use this syntax.

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Try:

  ```python
  df3 = df.iloc[:35]
  ```

  Then check:

  ```python
  df3.info()
  ```

  Now look at:

  ```python
  df1.info()
  ```

  The output is:

  ```Output
  <class 'pandas.core.frame.DataFrame'>
  Int64Index: 8790 entries, 8790 to 17579
  Data columns (total 35 columns):
  NDB_No                8790 non-null int64
  Shrt_Desc             8790 non-null object
  Water_(g)             8789 non-null float64
  Energ_Kcal            8790 non-null int64
  Protein_(g)           8790 non-null float64
  Lipid_Tot_(g)         8790 non-null float64
  Ash_(g)               8465 non-null float64
  Carbohydrt_(g)        8790 non-null float64
  Fiber_TD_(g)          8196 non-null float64
  Sugar_Tot_(g)         6958 non-null float64
  Calcium_(mg)          8442 non-null float64
  Iron_(mg)             8646 non-null float64
  Magnesium_(mg)        8051 non-null float64
  Phosphorus_(mg)       8211 non-null float64
  Potassium_(mg)        8364 non-null float64
  Sodium_(mg)           8707 non-null float64
  Zinc_(mg)             8084 non-null float64
  Copper_mg)            7533 non-null float64
  Manganese_(mg)        6630 non-null float64
  Selenium_(ï¿½g)       7090 non-null float64
  Vit_C_(mg)            7972 non-null float64
  Thiamin_(mg)          8156 non-null float64
  Riboflavin_(mg)       8174 non-null float64
  Niacin_(mg)           8153 non-null float64
  Panto_Acid_mg)        6548 non-null float64
  Vit_B6_(mg)           7885 non-null float64
  Folate_Tot_(ï¿½g)     7529 non-null float64
  Folic_Acid_(ï¿½g)     6751 non-null float64
  Food_Folate_(ï¿½g)    7022 non-null float64
  Folate_DFE_(ï¿½g)     6733 non-null float64
  Choline_Tot_ (mg)     4774 non-null float64
  Vit_B12_(ï¿½g)        7597 non-null float64
  Vit_A_IU              8079 non-null float64
  Vit_A_RAE             7255 non-null float64
  Retinol_(ï¿½g)        6984 non-null float64
  dtypes: float64(32), int64(2), object(1)
  memory usage: 2.4+ MB
  ```

</details>

<br /><br />

***

## Let's create df2

We'll create `df2` in a similar manner to `df1`. But we need to do things a little differently here to ensure that the first column (`NDB_No`) makes it into `df2`. This is going to serve as the column that's common to both child DataFrames when we join them later in this section.

We also want to populate `df2` with a different number of rows than `df1`, again simulating real-world scenarios. Doing so will make it easier to demonstrate what goes on with some of the join techniques shown later.

```python
df2 = df.iloc[0:2000, [0]+[i for i in range(35,53)]]
```

> [!div class="alert is-tip"]
>
> ### Question
>
> If you're unsure about why we use `[0] + [i for i in range(35,53)]` in the preceding list comprehension, review the documentation for the `range()` function by using `range?` in a code cell. You might want to run `[0] + [i for i in range(35,53)]` in the cell as part of your exploration, and experiment with adding (or concatenating) arrays. And remember that Python uses zero-based indexing.

We can examine `df2` by using the `head()` and `info()` methods.

```python
df2.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Alpha_Carot_(ï¿½g) | Beta_Carot_(ï¿½g) | Beta_Crypt_(ï¿½g) | Lycopene_(ï¿½g) | Lut+Zea_ (ï¿½g) | Vit_E_(mg) | Vit_D_ï¿½g | Vit_D_IU | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 8790 | 1001 | 0.0 | 158.0 | 0.0 | 0.0 | 0.0 | 2.32 | 0.0 | 0.0 | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 5.00 | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
> | 8791 | 1002 | 1.0 | 135.0 | 6.0 | 0.0 | 13.0 | 1.37 | 0.0 | 0.0 | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 3.80 | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
> | 8792 | 1003 | 0.0 | 193.0 | 0.0 | 0.0 | 0.0 | 2.80 | 0.0 | 0.0 | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 12.80 | 1 tbsp | 205.0 | 1 cup | 0.0 |
> | 8793 | 1004 | 0.0 | 74.0 | 0.0 | 0.0 | 0.0 | 0.25 | 0.5 | 21.0 | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 28.35 | 1 oz | 17.0 | 1 cubic inch | 0.0 |
> | 8794 | 1005 | 0.0 | 76.0 | 0.0 | 0.0 | 0.0 | 0.26 | 0.5 | 22.0 | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 132.00 | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

Now use `info()`.

```python
df2.info()
```

The output is:

```Output
<class 'pandas.core.frame.DataFrame'>
Int64Index: 2000 entries, 8790 to 10789
Data columns (total 19 columns):
NDB_No                2000 non-null int64
Alpha_Carot_(ï¿½g)    1426 non-null float64
Beta_Carot_(ï¿½g)     1447 non-null float64
Beta_Crypt_(ï¿½g)     1425 non-null float64
Lycopene_(ï¿½g)       1426 non-null float64
Lut+Zea_ (ï¿½g)       1418 non-null float64
Vit_E_(mg)            1456 non-null float64
Vit_D_ï¿½g            1289 non-null float64
Vit_D_IU              1289 non-null float64
Vit_K_(ï¿½g)          1359 non-null float64
FA_Sat_(g)            1965 non-null float64
FA_Mono_(g)           1823 non-null float64
FA_Poly_(g)           1825 non-null float64
Cholestrl_(mg)        1947 non-null float64
GmWt_1                1967 non-null float64
GmWt_Desc1            1967 non-null object
GmWt_2                1171 non-null float64
GmWt_Desc2            1171 non-null object
Refuse_Pct            2000 non-null float64
dtypes: float64(16), int64(1), object(2)
memory usage: 312.5+ KB
```

Let's take a look at `df1`.

```python
df1.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_B6_(mg) | Folate_Tot_(ï¿½g) | Folic_Acid_(ï¿½g) | Food_Folate_(ï¿½g) | Folate_DFE_(ï¿½g) | Choline_Tot_ (mg) | Vit_B12_(ï¿½g) | Vit_A_IU | Vit_A_RAE | Retinol_(ï¿½g) |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 8790 | 1001 | BUTTER,WITH SALT | 15.87 | 717 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | ... | 0.003 | 3.0 | 0.0 | 3.0 | 3.0 | 18.8 | 0.17 | 2499.0 | 684.0 | 671.0 |
> | 8791 | 1002 | BUTTER,WHIPPED,W/ SALT | 16.72 | 718 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | ... | 0.008 | 4.0 | 0.0 | 4.0 | 4.0 | 18.8 | 0.07 | 2468.0 | 683.0 | 671.0 |
> | 8792 | 1003 | BUTTER OIL,ANHYDROUS | 0.24 | 876 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | ... | 0.001 | 0.0 | 0.0 | 0.0 | 0.0 | 22.3 | 0.01 | 3069.0 | 840.0 | 824.0 |
> | 8793 | 1004 | CHEESE,BLUE | 42.41 | 353 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | ... | 0.166 | 36.0 | 0.0 | 36.0 | 36.0 | 15.4 | 1.22 | 721.0 | 198.0 | 192.0 |
> | 8794 | 1005 | CHEESE,BRICK | 41.11 | 371 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | ... | 0.065 | 20.0 | 0.0 | 20.0 | 20.0 | 15.4 | 1.26 | 1080.0 | 292.0 | 286.0 |

5 rows × 35 columns
***

You'll notice on that both DataFrames have their old indexes that they inherited from `df`. We can fix that by using the `reset_index()` method, but then we run into a problem.

```python
df1 = df1.reset_index()
df1.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | index | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | ... | Vit_B6_(mg) | Folate_Tot_(ï¿½g) | Folic_Acid_(ï¿½g) | Food_Folate_(ï¿½g) | Folate_DFE_(ï¿½g) | Choline_Tot_ (mg) | Vit_B12_(ï¿½g) | Vit_A_IU | Vit_A_RAE | Retinol_(ï¿½g) |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 0 | 8790 | 1001 | BUTTER,WITH SALT | 15.87 | 717 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | ... | 0.003 | 3.0 | 0.0 | 3.0 | 3.0 | 18.8 | 0.17 | 2499.0 | 684.0 | 671.0 |
> | 1 | 8791 | 1002 | BUTTER,WHIPPED,W/ SALT | 16.72 | 718 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | ... | 0.008 | 4.0 | 0.0 | 4.0 | 4.0 | 18.8 | 0.07 | 2468.0 | 683.0 | 671.0 |
> | 2 | 8792 | 1003 | BUTTER OIL,ANHYDROUS | 0.24 | 876 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | ... | 0.001 | 0.0 | 0.0 | 0.0 | 0.0 | 22.3 | 0.01 | 3069.0 | 840.0 | 824.0 |
> | 3 | 8793 | 1004 | CHEESE,BLUE | 42.41 | 353 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | ... | 0.166 | 36.0 | 0.0 | 36.0 | 36.0 | 15.4 | 1.22 | 721.0 | 198.0 | 192.0 |
> | 4 | 8794 | 1005 | CHEESE,BRICK | 41.11 | 371 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | ... | 0.065 | 20.0 | 0.0 | 20.0 | 20.0 | 15.4 | 1.26 | 1080.0 | 292.0 | 286.0 |

5 rows × 36 columns
***

Our old indexes are still there for `df1`, but now they're in a new column titled `index`. Pandas doesn't want to delete data that we might need. We can instruct pandas to remove the column, which we know is unnecessary, by using the `drop=True` parameter for the method. (We also need to drop the `index` column that we created in the prior step.)

```python
df1 = df1.drop(['index'], axis=1) #remove the index we created previously
df1 = df1.reset_index(drop=True) #reset the index and tell pandas not to create the copy
df1.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_B6_(mg) | Folate_Tot_(ï¿½g) | Folic_Acid_(ï¿½g) | Food_Folate_(ï¿½g) | Folate_DFE_(ï¿½g) | Choline_Tot_ (mg) | Vit_B12_(ï¿½g) | Vit_A_IU | Vit_A_RAE | Retinol_(ï¿½g) |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 0 | 1001 | BUTTER,WITH SALT | 15.87 | 717 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | ... | 0.003 | 3.0 | 0.0 | 3.0 | 3.0 | 18.8 | 0.17 | 2499.0 | 684.0 | 671.0 |
> | 1 | 1002 | BUTTER,WHIPPED,W/ SALT | 16.72 | 718 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | ... | 0.008 | 4.0 | 0.0 | 4.0 | 4.0 | 18.8 | 0.07 | 2468.0 | 683.0 | 671.0 |
> | 2 | 1003 | BUTTER OIL,ANHYDROUS | 0.24 | 876 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | ... | 0.001 | 0.0 | 0.0 | 0.0 | 0.0 | 22.3 | 0.01 | 3069.0 | 840.0 | 824.0 |
> | 3 | 1004 | CHEESE,BLUE | 42.41 | 353 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | ... | 0.166 | 36.0 | 0.0 | 36.0 | 36.0 | 15.4 | 1.22 | 721.0 | 198.0 | 192.0 |
> | 4 | 1005 | CHEESE,BRICK | 41.11 | 371 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | ... | 0.065 | 20.0 | 0.0 | 20.0 | 20.0 | 15.4 | 1.26 | 1080.0 | 292.0 | 286.0 |

5 rows × 35 columns
***

Now let's do the same thing to `df2`.

```python
df2 = df2.reset_index(drop=True)
df2.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Alpha_Carot_(ï¿½g) | Beta_Carot_(ï¿½g) | Beta_Crypt_(ï¿½g) | Lycopene_(ï¿½g) | Lut+Zea_ (ï¿½g) | Vit_E_(mg) | Vit_D_ï¿½g | Vit_D_IU | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 0 | 1001 | 0.0 | 158.0 | 0.0 | 0.0 | 0.0 | 2.32 | 0.0 | 0.0 | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 5.00 | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
> | 1 | 1002 | 1.0 | 135.0 | 6.0 | 0.0 | 13.0 | 1.37 | 0.0 | 0.0 | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 3.80 | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
> | 2 | 1003 | 0.0 | 193.0 | 0.0 | 0.0 | 0.0 | 2.80 | 0.0 | 0.0 | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 12.80 | 1 tbsp | 205.0 | 1 cup | 0.0 |
> | 3 | 1004 | 0.0 | 74.0 | 0.0 | 0.0 | 0.0 | 0.25 | 0.5 | 21.0 | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 28.35 | 1 oz | 17.0 | 1 cubic inch | 0.0 |
> | 4 | 1005 | 0.0 | 76.0 | 0.0 | 0.0 | 0.0 | 0.26 | 0.5 | 22.0 | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 132.00 | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

For practice, let's export these DataFrames to CSV files by using the `to_csv()` method. Note that unless we explicitly tell pandas not to, it will also export the index as a column in the CSV file. We'll also need to be careful to explicitly encode our CSV to UTF-8.

```python
df1.to_csv('Data/NNDB1.csv', sep=',', encoding='utf-8',index=False)
```

### Try it yourself

How would you export df2 to a CSV file?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Try:

  ```python
  df2.to_csv('Data/NNDB1_wNBDno.csv', sep=',', encoding='utf-8',index=False)
  ```

</details>

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Although it's not common in the real world to split DataFrames only to merge them again later, you'll need to drop columns or create new DataFrames that contain only the information you need. With truly large datasets, this is not just a convenience for your analysis. It's a necessity for memory and performance!
