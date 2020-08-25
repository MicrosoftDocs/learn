We'll be using the USDA NNDB dataset in sections 1.2 and 1.3. Particularly in section 1.2, we want to include food group information to go with the food entries, to aid with interpreting the result of our data analysis in that section. You'll add food group information to this USDA dataset in preparation for these coming sections.

First, let's reload our original NNDB dataset so that we have a clean copy.

```python
df = pd.read_csv('Data/USDA-nndb.csv', encoding='latin1')
```

Now let's load in the columns that we want from the older NNDB dataset that includes food groups.

```python
fg_df = pd.read_csv('Data/USDA-nndb-combined.csv', usecols=['NDB_No', 'FoodGroup'])
fg_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | FoodGroup |
> | --- | --- | --- |
> | 0 | 1001 | Dairy and Egg Products |
> | 1 | 1002 | Dairy and Egg Products |
> | 2 | 1003 | Dairy and Egg Products |
> | 3 | 1004 | Dairy and Egg Products |
> | 4 | 1005 | Dairy and Egg Products |

Note that `fg_df` does not have the same number of rows as `df`:

```python
fg_df.shape
```

The output is:

```Output
(8989, 2)
```

### Try it yourself

We need to combine `df` and `fg_df` by using the pandas `merge()` function. As you prepare to do so, keep the following considerations in mind:

- Which type of join should you use to capture all of the information in both datasets?

  <details>
    <summary>Hint <i>(expand to reveal)</i></summary>

  Look at the `head` and `tail` of the resulting DataFrame for clues.

  </details>

- To put the `FoodGroup` column immediately after the `NDB_No` column, in what order should you enter the two DataFrames into the `merge()` function? (You might need to experiment a couple of times to get the desired order.)

Perform the command to join `df` and `fg_df` in a code cell.

```python
combined_df = pd.concat([df, fg_df])
```

```python
combined_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | Alpha_Carot_(ï¿½g) | Ash_(g) | Beta_Carot_(ï¿½g) | Beta_Crypt_(ï¿½g) | Calcium_(mg) | Carbohydrt_(g) | Cholestrl_(mg) | Choline_Tot_ (mg) | Copper_mg) | Energ_Kcal | ... | Vit_A_RAE | Vit_B12_(ï¿½g) | Vit_B6_(mg) | Vit_C_(mg) | Vit_D_IU | Vit_D_ï¿½g | Vit_E_(mg) | Vit_K_(ï¿½g) | Water_(g) | Zinc_(mg) |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 0 | 0.0 | 2.11 | 158.0 | 0.0 | 24.0 | 0.06 | 215.0 | 18.8 | 0.000 | 717.0 | ... | 684.0 | 0.17 | 0.003 | 0.0 | 0.0 | 0.0 | 2.32 | 7.0 | 15.87 | 0.09 |
> | 1 | 1.0 | 1.62 | 135.0 | 6.0 | 23.0 | 2.87 | 225.0 | 18.8 | 0.010 | 718.0 | ... | 683.0 | 0.07 | 0.008 | 0.0 | 0.0 | 0.0 | 1.37 | 4.6 | 16.72 | 0.05 |
> | 2 | 0.0 | 0.00 | 193.0 | 0.0 | 4.0 | 0.00 | 256.0 | 22.3 | 0.001 | 876.0 | ... | 840.0 | 0.01 | 0.001 | 0.0 | 0.0 | 0.0 | 2.80 | 8.6 | 0.24 | 0.01 |
> | 3 | 0.0 | 5.11 | 74.0 | 0.0 | 528.0 | 2.34 | 75.0 | 15.4 | 0.040 | 353.0 | ... | 198.0 | 1.22 | 0.166 | 0.0 | 21.0 | 0.5 | 0.25 | 2.4 | 42.41 | 2.66 |
> | 4 | 0.0 | 3.18 | 76.0 | 0.0 | 674.0 | 2.79 | 94.0 | 15.4 | 0.024 | 371.0 | ... | 292.0 | 1.26 | 0.065 | 0.0 | 22.0 | 0.5 | 0.26 | 2.5 | 41.11 | 2.60 |

5 rows × 54 columns
***

And:

```python
combined_df.tail()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | Alpha_Carot_(ï¿½g) | Ash_(g) | Beta_Carot_(ï¿½g) | Beta_Crypt_(ï¿½g) | Calcium_(mg) | Carbohydrt_(g) | Cholestrl_(mg) | Choline_Tot_ (mg) | Copper_mg) | Energ_Kcal | ... | Vit_A_RAE | Vit_B12_(ï¿½g) | Vit_B6_(mg) | Vit_C_(mg) | Vit_D_IU | Vit_D_ï¿½g | Vit_E_(mg) | Vit_K_(ï¿½g) | Water_(g) | Zinc_(mg) |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 8984 | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |
> | 8985 | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |
> | 8986 | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |
> | 8987 | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |
> | 8988 | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |

5 rows × 54 columns
***

Now save the merged DataFrame by using the `to_csv()` method.

```python
combined_df.to_csv('Data/USDA-nndb-merged.csv',
                   sep=',',
                   encoding='latin1',
                   index=False)
```

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Because the most interesting insights come from joining different datasets, the pandas `merge()` function is at the heart of most data science projects.
