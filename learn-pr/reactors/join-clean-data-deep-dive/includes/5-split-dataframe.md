
It might seem strange to discuss splitting a `DataFrame` in a course section on joining them, but we'll do so here to create the `DataFrame`s that we'll join later on. We take this approach for two reasons:

1. Creating our own `DataFrame`s gives us easy control over the content of the child `DataFrame`s to best demonstrate aspects of joining datasets.
1. Because we have a baseline, joined `DataFrame` (`df`), it's easy to see how different methods of joining the child `DataFrame`s produce different results.

We're going to create two child `DataFrame`s, `df1` and `df2`. `df1` will contain the first 35 columns of our data, while `df2` will contain the rest. This will allow us to explore how we can manipulate and manage columns in a dataset, and to simulate a common scenario where some of the data you need is in one location, while the rest is in a different location.

```python
df1 = df.iloc[:,:35]
```

The output is:

```Output
TBD
```

### Try it yourself

- Why did we use syntax `df1 = df.iloc[:,:35]` to capture the first 35 columns of `df`?
- What does the first `:` (colon) in the square brackets do?

Experiment with `df3 = df.iloc[:35]` in a code cell and compare `df3.info()` with `df1.info()` to satisfy yourself as to why we need to use this syntax.

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

  The output is:

  ```Output
  TBD
  ```

  Now look at:

  ```python
  df1.info()
  ```

  The output is:

  ```Output
  TBD
  ```

</details>

<br /><br />

***

## Let's create df2

We'll create `df2` in a similar manner to `df1`, but we need to do things a little differently here to ensure that the first columne (`NDB_No`) makes it into `df2`. This is going to serve as the column that's common to both child `DataFrame`s when we join them later in this section.

We also want to populate `df2` with a different number of rows than `df1`, again simulating real world scenarios. Doing so will make is easier to demonstrate what goes on with some of the join techniques shown below.

```python
df2 = df.iloc[0:2000, [0]+[i for i in range(35,53)]]
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Question
>
> If you're unsure about why we use `[0] + [i for i in range(35,53)]` in the list comprehension above, review the documentation for the `range()` function using `range?` in the code cell below. You may want to run `[0] + [i for i in range(35,53)]` in the cell below as part of your exploration, and play around with adding (or concatenating) arrays. And remember Python uses zero-based indexing.

```python
TBD
```

The output is:

```Output
TBD
```

We can examine `df2` by using the `head()` and `info()` methods.

```python
df2.head()
```

The output is:

```Output
TBD
```

Now use `info()`

```python
df2.info()
```

The output is:

```Output
TBD
```

Let's take a look at `df1`.

```python
df1.head()
```

The output is:

```Output
TBD
```

You'll notice on that both `DataFrame`s have their old indices indexes that they inherited from `df`. We can fix that by using the `reset_index()` method, but then we run into a problem.

```python
df1 = df1.reset_index()
df1.head()
```

The output is:

```Output
TBD
```

Our old indexes are still there for `df1`, but now they're in a new column titled `index`. pandas doesn't want to delete data we might need. We can instruct pandas to remove the column, which we know is unnecessary, by using the `drop=True` parameter for the method. (We also need to drop the `index` column we just created in the prior step.)

```python
df1 = df1.drop(['index'], axis=1) #remove the index we created previously
df1 = df1.reset_index(drop=True) #reset the index and tell pandas not to create the copy
df1.head()
```

The output is:

```Output
TBD
```

Now let's do the same thing to `df2`.

```python
df2 = df2.reset_index(drop=True)
df2.head()
```

The output is:

```Output
TBD
```

For practice, let's export these `DataFrame`s to CSV files by using the `to_csv()` method. Note that unless we explicitly tell pandas not to, it will also export the index as a column in the CSV file. We will also need to be careful to explicitly encode our CSV to UTF-8.

```python
df1.to_csv('Data/NNDB1.csv', sep=',', encoding='utf-8',index=False)
```

The output is:

```Output
TBD
```

### Try it yourself

How would you export df2 to a CSV file?

**SARAH - TBD** - ADD HINT.

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

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

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Although it's not common in the real world to split `DataFrame`s only to re-merge them later, you'll need to drop columns or create new `DataFrame`s that contain only the information you need. With truly large datasets, this is not just a convenience for you analysis, but a necessity for memory and performance!
