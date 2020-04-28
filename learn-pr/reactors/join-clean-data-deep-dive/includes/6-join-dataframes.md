
We'll examine the most commonly used `DataFrame` function for joining datasets: `merge()`. But first, let's refresh ourselves on the shapes of our two `DataFrame`s so that the output of our joining makes more sense. This will display the number of rows and columns in each `DataFrame`.

```python
df1.shape
```

The output is:

```Output
TBD
```

```python
df2.shape
```

The output is:

```Output
TBD
```

The type of dataset join that's most widely used by practicing data scientists is the left join. If you already have some experience with SQL, you know what this refers to. Basically, a left join is a join that takes all of the data from one `DataFrame` (think of it as the left set in a Venn diagram) and merges it with everything that it has in common with another `DataFrame` (the intersection with the right set in the same Venn diagram).

We do this using the `merge()` function. We also need to specify the type of join we want to perform by using the `how` parameter, as well as the index on which to join the `DataFrames` by using the `on` parameter.

```python
# Similar to the SQL:
# FROM df1 LEFT JOIN df2 ON df1.NBD_No = df2.NBD_No

left_df = pd.merge(df1, df2, how='left', on='NDB_No')
left_df.shape
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Is the shape of the resulting `DataFrame` what you were expecting? Why or why not?

Now let's compare this to the original `df` `DataFrame`.

```python
df.shape
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Question
>
> The shapes are the same, but do you expect `df` and `left_df` to be identical? If so, why? If not, what differences do you expect there to be between them?

Let's check to see what the differences between these `DataFrame`s might be.

```python
df.head()
```

The output is:

```Output
TBD
```

```python
left_df.head()
```

The output is:

```Output
TBD
```

The indexes notwithstanding, the first five rows of both `DataFrame`s are the same. Let's check the last five rows.

```python
df.tail()
```

The output is:

```Output
TBD
```

```python
left_df.tail()
```

The output is:

```Output
TBD
```

There are differences here in the last five rows. Notice that the right-most columns of `left_df` contain have Not a Number (`NaN`) values. This is because the left `DataFrame` was larger than the right `DataFrame`. If you recall, we only took the first 2,000 rows from `df2`.

### Try it yourself

A right join is simply the mirror image of a left join in which those entries from the left `DataFrame` that are common with the right `DataFrame` are merged with the right `DataFrame`.

Perform a right join of `df1` and `df2` in the code cell below. But before you do that, ask yourself what shape you expect the resulting `DataFrame` to have? Do you expect it to have any `NaN` values?

<br/>

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  The parameter for the right join is `how='right'`
  
  ```python
  TBD
  ```

  The output is:

  The output is:

```Output
  TBD
  ```

</details>

<br /><br />

Another intuitive and widely used type of join is the inner join. This join simply merges entries that are common to both `DataFrame`s, resulting in a `DataFrame` that has no `NaN` values.

```python
inner_df = pd.merge(df1, df2, how='inner', on='NDB_No')
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Before we examine the shape of the resulting `DataFrame`, what do you predict it will be? Why?

```python
inner_df.shape
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Why are there only 2,000 rows after performing an inner join between `df1` and `df2`?

Did `inner_df` behave as you expected it would? Let's briefly examine it by using the `head()` and `tail()` methods.

```python
inner_df.head()
```

The output is:

```Output
TBD
```

```python
inner_df.tail()
```

The output is:

```Output
TBD
```

The resulting `DataFrame` is essentially the first 2000 rows of the original `df` `DataFrame`.

### Try it yourself

An outer join is the union of two `DataFrame`s; anything that is in either `DataFrame` with be in the resultant one. Perform an outer join of `df1` and `df2`. What shape do you expect the resulting `DataFrame` to have? How does it differ from the right join of `df1` and `df2`? What differences would there have to be in the shape or content of either `DataFrame` for the outer join of the two to be different from their right join?
