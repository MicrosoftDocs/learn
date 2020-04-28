
> **Learning goal:** By the end of this subsection, you should be comfortable performing simple exploration of your data and performing simple cleaning steps on it to prepare it for later analysis.

Data you'll be working with is typically in formats not necessarily designed for human consumption. Fortunately, `DataFrame` offers several tools for exploring the data. Let's explore the data we imported.

```python
df.head()
```

The output is:

```Output
TBD
```

We can get some aggregated information about the `DataFrame` by using its `info()` method:

```python
df.info()
```

The output is:

```Output
TBD
```

Just quickly inspecting the columns from `df` we can see that almost all of the columns have a number of null values. Those missing values are not an issue for us right now, but they will pose a challenge in future sections (but we will deal with them in those sections).

Let's also check to see if this `DataFrame` has any duplicate values in it. Let's start by exploring the `duplicated` method.

```python
df.duplicated?
```

The output is:

```Output
TBD
```

```python
df.duplicated()
```

The output is:

```Output
TBD
```

You'll notice the results from `duplicated` shows the result on a row by row basis. Not exactly the most efficient way of determining if there's duplicated rows. One quick trick we can use is to call `sum`, which will add the values of the results, where `False` will be **0** and `True` will be **1**. The end result will be we will get a rough sense if there's any duplicated rows.

```python
df.duplicated().sum()
```

The output is:

```Output
TBD
```

Given the nature of the data source (a government reference database) it makes sense that there are no duplicate entries. For purposes of learning more about cleaning data, let's make a mess so we can see how we can clean it up! Let's start by duplicating data by using the `append()` method.

```python
df = df.append(df, ignore_index=True)
```

The output is:

```Output
TBD
```

The `append()` method has basically stacked the `DataFrame` by appending a copy of `df` to the end of the `DataFrame`. (In SQL terms, we performed a [UNION](https://www.w3schools.com/sql/sql_union.asp)). The `ignore_index=True` parameter means that the internal index numbering for the newly doubled `DataFrame` continues seamlessly.

Now let's look directly at how many times individual values in a column (such as `NDB_No`, which is a key) are duplicated. We'll use the `groupby` function to create a "group" for each instance of `NDB_No`, and then we'll count each instance.

```python
df.groupby('NDB_No')['NDB_No'].count()
```

The output is:

```Output
TBD
```

Given that we duplicated the original dataset, two duplicates of everything is not unexpected. However, these duplicate values will pose a problem for us later in the section if not dealt with, so let's take care of them now:

```python
df = df.drop_duplicates('NDB_No', keep="last")
df.info()
```

The output is:

```Output
TBD
```

The `DataFrame` is now half of its previous size, which is what we would expect. However, look at this line in the `df.info()` output:

`Int64Index: 8790 entries, 8790 to 17579`

Remember, counting starts with zero. But while there are only now 8790 entries per column, the indexing for the DataFrame does not run 0 through 8789, as we might have expected. We can see this more directly by looking at the `head` of the redacted `DataFrame`:

```python
df.head()
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Is this behavior of the `drop_duplicates()` method not updating the index values of the `DataFrame` surprising or unexpected for you? Can you explain why this method behaves as it does in this case? If not, study the documentation for this method by using `df.drop_duplicates?` in the code cell below until you're satisfied with your understanding of this behavior.

```python

```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Duplicate, `Null`, and `NaN` values can all complicate (if not derail) your analysis. Learning how to identify and remove these problems is a huge part of successfully performing data science.
