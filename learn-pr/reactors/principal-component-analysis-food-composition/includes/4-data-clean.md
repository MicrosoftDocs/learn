Because this is a real-world dataset, it is a safe bet that it has null values in it. We could first check to see if this is true. However, later on in this section, we will have to transform our data using a function that cannot use NaN values, so we might as well drop rows containing those values.


### Try it yourself

Drop rows from the DataFrame that contain NaN values.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

If you need help remembering which method to use, see the [pandas documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.dropna.html?azure-portal=true).

```python
# Run the code to drop all null and NaN values
```

TBD output

---

</details>


Now let’s see how many rows we have left.

```python
df.shape
```

TBD Output

Dropping those rows eliminated 76 percent of our data (from 8989 entries to 2190). An imperfect state of affairs, but we still have enough for our purposes in this section.

> [!div class="alert is-tip"]
> ### Key takeaway
>
> Another solution to removing null values is to impute values for them, but this can be tricky. Should we handle missing values as equal to 0? What about a fatty food with NaN for Lipid_Tot_(g)? We could try taking the averages of values surrounding a NaN, but what about foods that are right next to rows containing foods from radically different food groups? It is possible to make justifiable imputations for missing values, but it can be important to involve subject-matter experts (SMEs) in that process.

## Split off descriptive columns

Our descriptive columns (such as FoodGroup and Shrt_Desc) pose challenges for us when it comes time to perform PCA because they are categorical rather than numerical features, so we will split our DataFrame in to one containing the descriptive information and one containing the nutritional information.

```python
desc_df = df.iloc[:, [0, 1, 2]+[i for i in range(50,54)]]
desc_df.set_index('NDB_No', inplace=True)
desc_df.head()
```

TBD output

### Try it yourself

Can you think of a more concise way to check the number of rows and columns in a DataFrame?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Use one of the attributes of the DataFrame.

TBD output

---

</details>

Question

Why was it necessary to structure the iloc method call the way we did in the code cell above? What did it accomplish? Why was it necessary set the desc_df index to NDB_No?

```python
nutr_df = df.iloc[:, :-5] # Remove the last five columns
nutr_df.head()
```

### Try it yourself

Can you think of a more concise way to check the number of rows and columns in a DataFrame?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Use one of the attributes of the DataFrame.

TBD output

---

</details>

Question

What did the iloc syntax do in the code cell above?

```python
nutr_df = nutr_df.drop(['FoodGroup', 'Shrt_Desc'], axis=1)
```


### Try it yourself

Can you think of a more concise way to check the number of rows and columns in a DataFrame?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Use one of the attributes of the DataFrame.

TBD output

---

</details>


Exercise

Now set the index of nutr_df to use NDB_No.

In [ ]:

Exercise solution

The correct code for students to use here is `nutr_df.set_index('NDB_No', inplace=True)`.

Now let’s take a look at `nutr_df`.

```python
nutr_df.head()
```

TBD output
