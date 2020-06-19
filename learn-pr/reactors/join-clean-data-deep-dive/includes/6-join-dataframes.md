We'll examine the most commonly used DataFrame function for joining datasets: `merge()`. But first, let's refresh ourselves on the shapes of our two DataFrames so that the output of our joining makes more sense. This will display the number of rows and columns in each DataFrame.

```python
df1.shape
```

```Output
(8790, 35)
```

And for df2:

```python
df2.shape
```

```Output
(2000, 19)
```

The type of dataset join that's most widely used by practicing data scientists is the left join. If you already have some experience with SQL, you know what this refers to. Basically, a left join takes all of the data from one DataFrame and merges it with everything that it has in common with another DataFrame. 

You can think of the data from the first DataFrame as the left set in a Venn diagram. The merged data is then the intersection with the right set in the same Venn diagram.

We do this by using the `merge()` function. We also need to specify the type of join we want to perform by using the `how` parameter, as well as the index on which to join the DataFrames by using the `on` parameter.

This is similar to the SQL: `FROM df1 LEFT JOIN df2 ON df1.NBD_No = df2.NBD_No`.

```python
left_df = pd.merge(df1, df2, how='left', on='NDB_No')
left_df.shape
```

The output is:

```Output
(8790, 53)
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Is the shape of the resulting DataFrame what you were expecting? Why or why not?

Now let's compare this to the original `df` DataFrame.

```python
df.shape
```

The output is:

```Output
(8790, 53)
```

> [!div class="alert is-tip"]
>
> ### Question
>
> The shapes are the same, but do you expect `df` and `left_df` to be identical? If so, why? If not, what differences do you expect there to be between them?

Let's check to see what the differences between these DataFrames might be.

```python
df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 8790 | 1001 | BUTTER,WITH SALT | 15.87 | 717 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | ... | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 5.00 | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
> | 8791 | 1002 | BUTTER,WHIPPED,W/ SALT | 16.72 | 718 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | ... | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 3.80 | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
> | 8792 | 1003 | BUTTER OIL,ANHYDROUS | 0.24 | 876 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | ... | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 12.80 | 1 tbsp | 205.0 | 1 cup | 0.0 |
> | 8793 | 1004 | CHEESE,BLUE | 42.41 | 353 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | ... | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 28.35 | 1 oz | 17.0 | 1 cubic inch | 0.0 |
> | 8794 | 1005 | CHEESE,BRICK | 41.11 | 371 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | ... | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 132.00 | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

5 rows × 53 columns
***

For `left_df`:

```python
left_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 0 | 1001 | BUTTER,WITH SALT | 15.87 | 717 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | ... | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 5.00 | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
> | 1 | 1002 | BUTTER,WHIPPED,W/ SALT | 16.72 | 718 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | ... | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 3.80 | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
> | 2 | 1003 | BUTTER OIL,ANHYDROUS | 0.24 | 876 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | ... | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 12.80 | 1 tbsp | 205.0 | 1 cup | 0.0 |
> | 3 | 1004 | CHEESE,BLUE | 42.41 | 353 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | ... | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 28.35 | 1 oz | 17.0 | 1 cubic inch | 0.0 |
> | 4 | 1005 | CHEESE,BRICK | 41.11 | 371 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | ... | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 132.00 | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

5 rows × 53 columns
***

Aside from the indexes, the first five rows of both DataFrames are the same. Let's check the last five rows.

```python
df.tail()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 17575 | 83110 | MACKEREL,SALTED | 43.00 | 305 | 18.50 | 25.10 | 13.40 | 0.00 | 0.0 | 0.0 | ... | 7.8 | 7.148 | 8.320 | 6.210 | 95.0 | 80.0 | 1 piece, (5-1/2" x 1-1/2" x 1/2") | 17.0 | 1 cubic inch, boneless | 0.0 |
> | 17576 | 90240 | SCALLOP,(BAY&SEA),CKD,STMD | 70.25 | 111 | 20.54 | 0.84 | 2.97 | 5.41 | 0.0 | 0.0 | ... | 0.0 | 0.218 | 0.082 | 0.222 | 41.0 | 85.0 | 3 oz | NaN | NaN | 0.0 |
> | 17577 | 90480 | SYRUP,CANE | 26.00 | 269 | 0.00 | 0.00 | 0.86 | 73.14 | 0.0 | 73.2 | ... | 0.0 | 0.000 | 0.000 | 0.000 | 0.0 | 21.0 | 1 serving | NaN | NaN | 0.0 |
> | 17578 | 90560 | SNAIL,RAW | 79.20 | 90 | 16.10 | 1.40 | 1.30 | 2.00 | 0.0 | 0.0 | ... | 0.1 | 0.361 | 0.259 | 0.252 | 50.0 | 85.0 | 3 oz | NaN | NaN | 0.0 |
> | 17579 | 93600 | TURTLE,GREEN,RAW | 78.50 | 89 | 19.80 | 0.50 | 1.20 | 0.00 | 0.0 | 0.0 | ... | 0.1 | 0.127 | 0.088 | 0.170 | 50.0 | 85.0 | 3 oz | NaN | NaN | 0.0 |

5 rows × 53 columns
***

For `left_df`:

```python
left_df.tail()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 8785 | 83110 | MACKEREL,SALTED | 43.00 | 305 | 18.50 | 25.10 | 13.40 | 0.00 | 0.0 | 0.0 | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |
> | 8786 | 90240 | SCALLOP,(BAY&SEA),CKD,STMD | 70.25 | 111 | 20.54 | 0.84 | 2.97 | 5.41 | 0.0 | 0.0 | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |
> | 8787 | 90480 | SYRUP,CANE | 26.00 | 269 | 0.00 | 0.00 | 0.86 | 73.14 | 0.0 | 73.2 | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |
> | 8788 | 90560 | SNAIL,RAW | 79.20 | 90 | 16.10 | 1.40 | 1.30 | 2.00 | 0.0 | 0.0 | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |
> | 8789 | 93600 | TURTLE,GREEN,RAW | 78.50 | 89 | 19.80 | 0.50 | 1.20 | 0.00 | 0.0 | 0.0 | ... | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |

5 rows × 53 columns
***

There are differences here in the last five rows. Notice that the rightmost columns of `left_df` contain have Not a Number (`NaN`) values. This is because the left DataFrame was larger than the right DataFrame. If you recall, we took only the first 2,000 rows from `df2`.

### Try it yourself

A right join is simply the mirror image of a left join. Entries from the left DataFrame that are common with the right DataFrame are merged with the right DataFrame.

Perform a right join of `df1` and `df2` in the following code cell. But before you do that, ask yourself what shape you expect the resulting DataFrame to have. Do you expect it to have any `NaN` values?

<br/>

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  The parameter for the right join is `how='right'`.

  ```python
  right_df = pd.merge(df1, df2, how='right', on='NDB_No')
  ```

</details>

<br /><br />

Another intuitive and widely used type of join is the inner join. This join merges entries that are common to both DataFrames, resulting in a DataFrame that has no `NaN` values.

```python
inner_df = pd.merge(df1, df2, how='inner', on='NDB_No')
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Before we examine the shape of the resulting DataFrame, what do you predict it will be? Why?

```python
inner_df.shape
```

The output is:

```Output
(2000, 53)
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Why are there only 2,000 rows after you perform an inner join between `df1` and `df2`?

Did `inner_df` behave as you expected it would? Let's briefly examine it by using the `head()` and `tail()` methods.

```python
inner_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 0 | 1001 | BUTTER,WITH SALT | 15.87 | 717 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | ... | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 5.00 | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
> | 1 | 1002 | BUTTER,WHIPPED,W/ SALT | 16.72 | 718 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | ... | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 3.80 | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
> | 2 | 1003 | BUTTER OIL,ANHYDROUS | 0.24 | 876 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | ... | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 12.80 | 1 tbsp | 205.0 | 1 cup | 0.0 |
> | 3 | 1004 | CHEESE,BLUE | 42.41 | 353 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | ... | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 28.35 | 1 oz | 17.0 | 1 cubic inch | 0.0 |
> | 4 | 1005 | CHEESE,BRICK | 41.11 | 371 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | ... | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 132.00 | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

5 rows × 53 columns
***

Then `tail()`:

```python
inner_df.tail()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 1995 | 8538 | CEREALS RTE,KASHI,HEART TO HEART,OAT FLAKES & ... | 3.0 | 376 | 10.39 | 3.79 | 2.5 | 80.3 | 7.4 | 22.7 | ... | 1.9 | 0.8 | 1.1 | 1.2 | 0.0 | 55.0 | 1 cup, (1 NLEA serving) | NaN | NaN | 0.0 |
> | 1996 | 8539 | CEREALS RTE,KASHI ORGANIC PROMISE,CINN HARVEST | 5.0 | 336 | 11.00 | 1.40 | 3.6 | 79.0 | 10.7 | 16.5 | ... | NaN | 0.2 | 0.2 | 1.0 | 0.0 | 55.0 | 28 biscuits, (1 NLEA serving) | NaN | NaN | 0.0 |
> | 1997 | 8542 | CEREALS RTE,KELLOGG'S,FRSTD MINI-WHEATS BITE S... | 5.1 | 352 | 8.70 | 1.60 | 0.5 | 84.6 | 10.2 | 22.7 | ... | NaN | 0.4 | 0.2 | 0.8 | 0.0 | 55.0 | 25 biscuits, (1 NLEA serving) | NaN | NaN | 0.0 |
> | 1998 | 8543 | CEREALS RTE,KELLOGG'S,SPL K VANILLA ALMOND | 3.0 | 366 | 7.80 | 4.00 | 2.2 | 83.0 | 9.6 | 29.2 | ... | 0.7 | 0.4 | 2.0 | 1.1 | 0.0 | 30.0 | .75 cup, (1 NLEA serving) | NaN | NaN | 0.0 |
> | 1999 | 8544 | CEREALS RTE,POST GREAT GRAINS CRANBERRY ALMOND... | 6.2 | 384 | 8.90 | 5.90 | 2.4 | 76.6 | 11.1 | 25.5 | ... | 2.0 | 0.8 | 3.0 | 1.7 | 0.0 | 48.0 | .75 cup, (1 NLEA serving) | NaN | NaN | 0.0 |

5 rows × 53 columns
***

The resulting DataFrame is essentially the first 2,000 rows of the original `df` DataFrame.

### Try it yourself

An outer join is the union of two DataFrames. Anything that's in either DataFrame will be in the resultant one. Perform an outer join of `df1` and `df2`.

- What shape do you expect the resulting DataFrame to have?
- How does it differ from the left join of `df1` and `df2`?
- What differences would there have to be in the shape or content of either DataFrame for the outer join of the two to be different from their left join?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  outer_df = pd.merge(df1, df2, how='outer', on='NDB_No')
  outer_df.shape
  ```

  ```output
  (8790, 53)
  ```

  Left join of `df1` and `df2` is:
  ```output
  (8790, 53)
  ```

</details>
