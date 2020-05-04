We know from experience that we probably will need to do some cleanup of our data before we can run the machine learning algorithms we want to run.

## Handle `null` values

Because this is a real-world dataset, it is a safe bet that it contains `null` values. Later in this module, we will have to transform our data by using a function that cannot use NaN values. Let's drop rows that contain those values now.

### Try it yourself

Drop rows from the DataFrame that contain NaN values.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  If you need help remembering which method to use, see the [pandas documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.dropna.html?azure-portal=true).

  The exercise solution is:

  ```python
  df.dropna()
  ```

  :::image type="content" alt-text="A screenshot that shows the table output of running df.dropna()" source="../media/df-drop-na.png" loc-scope="Azure":::

</details>

<br /><br />

***

Now, let’s see how many rows we have left.

```python
df.shape
```

The output is:

```Output
(2190, 54)
```

Dropping those rows eliminated 76 percent of our data (from 8989 entries to 2190). An imperfect state of affairs, but we still have enough for our purposes in this section.

> [!div class="alert is-tip"]
> ### Key takeaway
>
> Another solution to removing `null` values is to impute values for them, but this can be tricky. Should we handle missing values as equal to 0? What about a fatty food with `NaN` for `Lipid_Tot_(g)`? We could try taking the averages of values surrounding a `NaN`, but what about foods that are right next to rows containing foods from radically different food groups? It is possible to make justifiable imputations for missing values, but it can be important to involve subject-matter experts (SMEs) in that process.

## Split off descriptive columns

Our descriptive columns (such as `FoodGroup` and `Shrt_Desc`) pose challenges for us when it comes time to perform PCA because they are categorical rather than numerical features, so we will split our DataFrame in to one containing the descriptive information and one containing the nutritional information.

```python
desc_df = df.iloc[:, [0, 1, 2]+[i for i in range(50,54)]]
desc_df.set_index('NDB_No', inplace=True)
desc_df.head()
```

Here's the output:

:::image type="content" alt-text="A screenshot that shows the results of running desc_df.head, in table format." source="../media/desc-df-head2.png" loc-scope="Azure":::

### Try it yourself

Why was it necessary to structure the `iloc` method call the way we did in the preceding cell? What did it accomplish? Why was it necessary set the `desc_df` index to `NDB_No`?

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

A possible solution:

```python
nutr_df = df.iloc[:, :-5]
nutr_df.head()
```

Here's the output:

:::image type="content" alt-text="A screenshot that shows the results of running nutr_df.head, in table format." source="../media/nutr-df-head-49.png" loc-scope="Azure":::
5 rows × 49 columns

</details>

<br /><br />

***

### Try it yourself

Now set the index of `nutr_df` to use `NDB_No`.

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  The correct code for students to use here is:

  ```python
  nutr_df.set_index('NDB_No', inplace=True)
  ```

This is the output - TBD

  ```Output
  TBD - error
  ```
</details>

<br /><br />

***

Let's take a look at `nutr_df` now:

```python
nutr_df.head()
```

Here's the output:

:::image type="content" alt-text="A screenshot that shows the results of running nutr_df.head, in table format." source="../media/nutr-df-head-46.png" loc-scope="Azure":::
5 rows × 46 columns

## Check for correlation among features

One thing that can skew our classification results is correlation among our features. Recall that the whole reason that PCA works is that it exploits the correlation among data points to project our feature-space into a lower-dimensional space. However, if some of our features are highly correleted to begin with, these relationships might create spurious clusters of data in our PCA.

The code to check for correlations in our data isn't long, but it takes too long (up to 10 to 20 minutes) to run for a course like this. Instead, the table below shows the output from that code:

:::image type="content" alt-text="A screenshot that shows the results of running nutr_df.head, in table format." source="../media/correlation.png" loc-scope="Azure":::

As it turns out, dropping Folate_DFE_(µg), Vit_A_RAE, and Vit_D_IU will eliminate the correlations enumerated in the table above:

```python
nutr_df.drop(['Folate_DFE_(Âµg)', 'Vit_A_RAE', 'Vit_D_IU'], 
        inplace=True, axis=1)
nutr_df.head()
```

This is the output:

:::image type="content" alt-text="A screenshot that shows the results of running nutr_df.head, in table format." source="../media/correlation-2.png" loc-scope="Azure":::
5 rows × 43 columns


