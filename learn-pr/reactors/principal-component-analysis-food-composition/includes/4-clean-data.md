We know from experience that we probably will need to do some cleanup of our data before we can run the machine learning algorithms we want to run.

## Handle `null` values

Because this is a real-world dataset, it is a safe bet that it contains `null` values. Later in this module, we will have to transform our data by using a function that cannot use NaN values. Let's drop rows that contain those values now.

### Try it yourself

Drop rows from the DataFrame that contain NaN values.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  If you need help remembering which method to use, see the [pandas documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.dropna.html?azure-portal=true).

  ```python
  df.dropna()
  ```

  The output is 2190 rows × 54 columns:

  :::image type="content" alt-text="A screenshot that shows the table output of running df.dropna()" source="../media/df-drop-na.png" loc-scope="Azure":::

</details>

<br /><br />

***

Now, let’s see how many rows we have left.

```python
df.shape
```

The output TBD--doesn't match:

```Output
(8989, 54)
```

Dropping those rows eliminated 76 percent of our data (from 8989 entries to 2190). An imperfect state of affairs, but we still have enough for our purposes in this section.

> [!div class="alert is-tip"]
> ### Key takeaway
>
> Another solution to removing `null` values is to impute values for them, but this can be tricky. Should we handle missing values as equal to 0? What about a fatty food with `NaN` for `Lipid_Tot_(g)`? We could try taking the averages of values surrounding a `NaN`, but what about foods that are right next to rows containing foods from radically different food groups? It is possible to make justifiable imputations for missing values, but it can be important to involve subject-matter experts (SMEs) in that process.

## Split off descriptive columns

Our descriptive columns (such as FoodGroup and Shrt_Desc) pose challenges for us when it comes time to perform PCA because they are categorical rather than numerical features, so we will split our DataFrame in to one containing the descriptive information and one containing the nutritional information.

```python
desc_df = df.iloc[:, [0, 1, 2]+[i for i in range(50,54)]]
desc_df.set_index('NDB_No', inplace=True)
desc_df.head()
```

Here's the output:

```Output
	FoodGroup	Shrt_Desc	GmWt_Desc1	GmWt_2	GmWt_Desc2	Refuse_Pct
NDB_No						
1001	Dairy and Egg Products	BUTTER,WITH SALT	1 pat, (1" sq, 1/3" high)	14.2	1 tbsp	0.0
1002	Dairy and Egg Products	BUTTER,WHIPPED,W/ SALT	1 pat, (1" sq, 1/3" high)	9.4	1 tbsp	0.0
1003	Dairy and Egg Products	BUTTER OIL,ANHYDROUS	1 tbsp	205.0	1 cup	0.0
1004	Dairy and Egg Products	CHEESE,BLUE	1 oz	17.0	1 cubic inch	0.0
1005	Dairy and Egg Products	CHEESE,BRICK	1 cup, diced	113.0	1 cup, shredded	0.0
```

### Try it yourself

Why was it necessary to structure the `iloc` method call the way we did in the code cell above? What did it accomplish? Why was it necessary set the `desc_df` index to `NDB_No`?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Use one of the attributes of the <code>DataFrame</code>.

TBD output

</details>

<br /><br />

***

Next, run this input:

```python
nutr_df = df.iloc[:, :-5] # Remove the last five columns
nutr_df.head()
```

The output is 5 rows × 49 columns:

:::image type="content" alt-text="A screenshot that shows the table output of running nutr_df.head()" source="../media/nutr-df-head.png" loc-scope="Azure":::


### Try it yourself

What did the `iloc` syntax do in the preceding code cell?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Use one of the attributes of the DataFrame.

  TBD output

</details>

<br /><br />

***

Next, run this in a cell:

```python
nutr_df = nutr_df.drop(['FoodGroup', 'Shrt_Desc'], axis=1)
```

This is the output - TBD, I get an error

```Output
TBD
```

### Try it yourself

Now set the index of `nutr_df` to use `NDB_No`.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  The correct code for students to use here is `nutr_df.set_index('NDB_No', inplace=True)`.

  ```python
  TBD
  ```

This is the output - TBD, I get an error

```Output
TBD
```
  ```Output
  TBD - error
  ```
</details>

<br /><br />

***


Now let’s take a look at `nutr_df`.

```python
nutr_df.head()
```

TBD output
