> [!div class="alert is-tip"]
> ### Learning goal
>
> By the end of this unit, you should have a general knowledge of the various ways to combine DataFrames.

Your most interesting analyses often will come from data melded together from more than one source. Because of this, pandas provides several methods of merging and joining datasets to make this necessary job easier:

* `pandas.merge` connects rows in DataFrames based on one or more keys.
* `pandas.concat` concatenates or “stacks” together objects along an axis.
* The `combine_first` instance method enables you to splice together overlapping data to fill in missing values in one object with values from another.

Let's examine merging data first, because it will be the most familiar to those of you who are already familiar with SQL or other relational databases.

## Categories of joins

`merge` carries out several types of joins: one-to-one, many-to-one, and many-to-many. You use the same basic function call to implement all of them, and we will examine all three. You will need all three at some point in your data-delving, depending on the data.) We will start with one-to-one joins because they generally are the simplest example.

## One-to-one joins

Consider combining two DataFrames that contain different information about the same employees in a company.

We can group an example of four employees by the department they work in:

```python
df1 = pd.DataFrame({'employee': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'group': ['Accounting', 'Marketing', 'Marketing', 'HR']})
df1
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Next, let's look at the years that the same four employees were hired:

```python
df2 = pd.DataFrame({'employee': ['Mary', 'Stu', 'Gary', 'Sue'],
                    'hire_date': [2008, 2012, 2017, 2018]})
df2
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Combine this information in a single DataFrame by using the `merge` function:

```python
df3 = pd.merge(df1, df2)
df3
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

pandas joined on the employee column because it was the only column common to both df1 and df2. (Notice also that the original indices of df1 and df2 were discarded by merge; this is generally the case with merges unless you conduct them by index, which we will discuss later on.)

## Many-to-one joins

A many-to-one join is like a one-to-one join except that one of the two key columns contains duplicate entries. The DataFrame resulting from such a join will preserve those duplicate entries as appropriate:

```python
df4 = pd.DataFrame({'group': ['Accounting', 'Marketing', 'HR'],
                    'supervisor': ['Carlos', 'Giada', 'Stephanie']})
df4
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

*TBD* introduce the next code/commands:

```python
pd.merge(df3, df4)
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

The resulting DataFrame has an additional column for supervisor; that column has an extra occurrence of 'Giada' that did not occur in df4 because more than one employee in the merged DataFrame works in the 'Marketing' group.

Notice that we didn’t specify which column to join on. When you don't specify that information, merge uses the overlapping column names as the keys. However, that can be ambiguous; several columns might meet that condition. For that reason, it is a good practice to explicitly specify on which key to join. You can do this with the on parameter:

```python
pd.merge(df3, df4, on='group')
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

## Many-to-many joins

What happens if the key columns in both of the DataFrames you're joining contain duplicates? That gives you a many-to-many join:

```python
df5 = pd.DataFrame({'group': ['Accounting', 'Accounting',
                              'Marketing', 'Marketing', 'HR', 'HR'],
                    'core_skills': ['math', 'spreadsheets', 'writing', 'communication',
                               'spreadsheets', 'organization']})
df5
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

*TBD* introduce the next code/commands:

```python
pd.merge(df1, df5, on='group')
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Again, to avoid ambiguity about which column to join on, it's a good idea to explicitly tell `merge` which one to use with the `on` parameter.

## left_on and right_on keywords

What if you need to merge two datasets with no shared column names? For example, what if you are using a dataset in which the employee name is labeled **name** rather than **employee**? In such cases, you will need to use the **left_on** and **right_on** keywords in order to specify the column names on which to join:

```python
df6 = pd.DataFrame({'name': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'salary': [70000, 80000, 120000, 90000]})
df6
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

*TBD* introduce the next code/commands:

```python
pd.merge(df1, df6, left_on="employee", right_on="name")
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

### Exercise

Using the documentation, can you figure out how to use `.drop()` to get rid of the **name** column?

Hint: You will need to supply two parameters to `.drop()`.

## left_index and right_index keywords

Sometimes it can be more advantageous to merge on an index rather than on a column. The **left_index** and **right_index** keywords make it possible to join by index. Let's revisit some of our earlier example DataFrames to see what this looks like in action.

```python
df1a = df1.set_index('employee')
df1a
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

*TBD* introduce the next code/commands:

```python
df2a = df2.set_index('employee')
df2a
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

To merge on the index, specify the **left_index** and **right_index** parameters in merge:

```python
pd.merge(df1a, df2a, left_index=True, right_index=True)
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

### Exercise

What happens if you specify only **left_index** or **right_index**?

You can also use the join method for DataFrames, which produces the same effect but merges on indices by default:

```python
df1a.join(df2a)
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

You can also mix and match **left_index**/**right_index** with **right_on**/**left_on**:

```python
pd.merge(df1a, df6, left_index=True, right_on='name')
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

## Set arithmetic for joins

Let's return to many-to-many joins for a moment. A consideration that is unique to them is the arithmetic of the join, specifically the set arithmetic we use for the join. To illustrate what we mean by this, let's restructure an old example DataFrame:

```python
df5 = pd.DataFrame({'group': ['Engineering', 'Marketing', 'Sales'],
                    'core_skills': ['math', 'writing', 'communication']})
df5
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

*TBD* introduce the next code/commands:

```python
pd.merge(df1, df5, on='group')
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Notice that after we have restructured df5 and then rerun the merge with df1, we have only two entries in the result. This is because we merged on **group** and **Marketing** was the only entry that appeared in the **group** column of both DataFrames.

In effect, what we have gotten is the intersection of both DataFrames. This is know as the inner join in the database world and it is the default setting for merge although we can certainly specify it:

```python
pd.merge(df1, df5, on='group', how='inner')
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

The complement of the inner join is the outer join, which returns the union of the two DataFrames.

### Exercise

The keyword for perfoming an outer join is `how='outer'`. How would you perform it?

What do you expect the output of an outer join of df1 and df5 to be?

Notice in your resulting DataFrame that not every row in df1 and df5 had a value that corresponds to the union of the key values (the **group** column). Pandas fills in these missing values with NaNs.

Inner and outer joins are not your only options. A left join returns all of the rows in the first (left-side) DataFrame supplied to merge along with rows from the other DataFrame that match up with the left-side key values (and NaNs rows with respective values):

```python
pd.merge(df1, df5, how='left')
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

### Exercise

Now run the right merge between df1 and df5.

What do you expect to see?

## suffixes keyword: dealing with conflicting column names

Because you can join datasets, you will eventually join two with conflicting column names. Let's look at another example to see what we mean:

```python
df7 = pd.DataFrame({'name': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'rank': [1, 2, 3, 4]})
df7
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

*TBD* introduce the next code/commands:

```python
df8 = pd.DataFrame({'name': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'rank': [3, 1, 4, 2]})
df8
pd.merge(df7, df8, on='name')
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Each column name in a DataFrame must be unique, so in cases where two joined DataFrames share column names (aside from the column serving as the key), the `merge` function automatically appends the suffix **_x** or **_y** to the conflicting column names in order to make them unique. In cases where it is best to control your column names, you can specify a custom suffix for merge to append through the suffixes keyword:

```python
pd.merge(df7, df8, on='name')
pd.merge(df7, df8, on='name', suffixes=['_left', '_right'])
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

These suffixes work if there are multiple conflicting columns.

## Concatenation in NumPy

Concatenation in pandas is built by using the concatenation functionality for NumPy arrays. Here is what NumPy concatenation looks like:

* For one-dimensional arrays:
   
   ```python
   x = [1, 2, 3]
   y = [4, 5, 6]
   z = [7, 8, 9]
   np.concatenate([x, y, z])
   ```

   Here's the output:

  > [!NOTE]
  > 
  > **SARAH** - *Insert image*: Add screenshot of the output table.
  >

* For two-dimensional arrays:

   ```python
   x = [[1, 2],
   [3, 4]]
   np.concatenate([x, x], axis=1)
   ```

  Here's the output:

  > [!NOTE]
  > 
  > **SARAH** - *Insert image*: Add screenshot of the output table.
  >

Notice that the `axis=1` parameter makes the concatenation occur along columns rather than rows. Concatenation in pandas looks similar to this.

## Concatenation in pandas

pandas has a function, `pd.concat()` that can be used for a simple concatenation of `Series` or `DataFrame` objects similar to `np.concatenate()` with `ndarrays`.

```python
ser1 = pd.Series(['a', 'b', 'c'], index=[1, 2, 3])
ser2 = pd.Series(['d', 'e', 'f'], index=[4, 5, 6])
pd.concat([ser1, ser2])
```

Here's the output:

```output
1    a
2    b
3    c
4    d
5    e
6    f
dtype: object
```

It also concatenates higher-dimensional objects, such as DataFrames:

```python
df9 = pd.DataFrame({'A': ['a', 'c'],
                    'B': ['b', 'd']})
df9
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

*TBD* introduce the next code/commands:

```python
pd.concat([df9, df9])
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Notice that `pd.concat` has preserved the indexing, even though that means that it has been duplicated. You can have the results reindexed (and avoid potential confusion down the road), like this:

```python
pd.concat([df9, df9], ignore_index=True)
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

By default, `pd.concat` concatenates row-wise within the DataFrame (that is, axis=0 by default). You can specify the axis along which to concatenate:

```python
pd.concat([df9, df9], axis=1)
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Although pandas display the output without error, you will get an error message if you try to assign this result as a new DataFrame. Column names in DataFrames must be unique.

## Concatenation with joins

Just as you did with merge above, you can use inner and outer joins when concatenating DataFrames with different sets of column names.

```python
df10 = pd.DataFrame({'A': ['a', 'd'],
                     'B': ['b', 'e'],
                     'C': ['c', 'f']})
df10
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

```python
df11 = pd.DataFrame({'B': ['u', 'x'],
                     'C': ['v', 'y'],
                     'D': ['w', 'z']})
df11
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

```python
pd.concat([df10, df11])
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

As we saw earlier, the default join for this is an outer join and entries for which no data is available are filled with **NaN** values. You can also do an inner join:

```python
pd.concat([df10, df11], join='inner')
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Another option is to directly specify the index of the remaining columns using the `join_axes` argument, which takes a list of index objects. Here, we will specify that the returned columns should be the same as those of the first input `(df10)`:

```python
pd.concat([df10, df11], join_axes=[df10.columns])
append()
```

Here's the output:

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.
>

Because direct array concatenation is so common, `Series` and `DataFrame` objects have an `append` method that can accomplish the same thing in fewer keystrokes. For example, rather than calling `pd.concat([df9, df9])`, you can call `df9.append(df9)`:

```python
df9.append(df9)
```

Here's the output:

![Output from the call df9.append command](../media/call-df-append.png)

> [!NOTE]
> 
> **SARAH** - *Insert image*: Add screenshot of the output table.


> [!IMPORTANT]
> Unlike the `append()` and `extend()` methods of Python lists, the `append()` method in pandas does not modify the original object. Instead, it creates a new object with the combined data.

> **Takeaway**: A large part of the value you can provide as a data scientist comes from connecting multiple, often disparate datasets to find new insights. Learning how to join and merge data is thus an essential part of your skill set.