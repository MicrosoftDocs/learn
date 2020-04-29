
We will be using the USDA NNDB dataset in Sections 1.2 and 1.3. However, particularly in Section 1.2, we want to include food group information to go with the food entries to aid with interpreting the result of our data analysis in that section. You will add food group information to this USDA dataset in preparation for these coming sections.

First, let's reload our original NNDB dataset so that we have a clean copy.

```python
df = pd.read_csv('Data/USDA-nndb.csv', encoding='latin_1')
```

The output is:

```Output
TBD
```

Now let's load in the columns that we want from the older NNDB dataset that includes food groups.

```python
fg_df = pd.read_csv('Data/USDA-nndb-combined.csv', usecols=['NDB_No', 'FoodGroup'])
fg_df.head()
```

The output is:

```Output
TBD
```

Note that `fg_df` does not have the same number of rows as `df`:

```python
fg_df.shape
```

The output is:

```Output
TBD
```

### Try it yourself

We need to combine `df` and `fg_df` using the pandas `merge()` function. As you prepare to do so, keep the following considerations front of mind:

1. Which type of join should you use to capture all of the information in both datasets? (**Hint:** Look at the `head` and `tail` of the resulting `DataFrame` for clues.)
1. In order to put the `FoodGroup` column immediately after the `NDB_No` column, in what order should you enter the two `DataFrame`s into the `merge()` function? (You might need to experiment a couple of times to get the desired order.)

Perform the command to join the `df` and `fg_df` in the code cell below.

```python

```

The output is:

```Output
TBD
```

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  combined_df.head()
  ```

  The output is:

```Output
  TBD
  ```

  And:

  ```python
  combined_df.tail()
  ```

  The output is:

```Output
  TBD
  ```

</details>

<br /><br />

Now save the merged `DataFrame` using the `to_csv()` method.

```python
combined_df.to_csv('Data/USDA-nndb-merged.csv',
                   sep=',',
                   encoding='latin_1',
                   index=False)
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Because the most interesting insights come from joining different datasets, the pandas `merge()` function is at the heart of most data science projects.
