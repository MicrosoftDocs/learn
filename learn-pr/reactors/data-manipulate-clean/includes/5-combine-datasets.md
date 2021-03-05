Your most interesting analyses often will come from data that's melded together from more than one source. Because of this, pandas provides several methods of merging and joining datasets to make this necessary job easier:

* `pandas.merge` connects rows in `DataFrames` based on one or more keys.
* `pandas.concat` concatenates or “stacks” together objects along an axis.
* The `combine_first` instance method enables you to splice together overlapping data to fill in missing values in one object with values from another.

Let's examine merging data first, because it will be the most familiar to those of you who are already familiar with SQL or other relational databases.

## Categories of joins

`merge` carries out several types of joins: one-to-one, many-to-one, and many-to-many. You use the same basic function call to implement all of them, and we will examine all three. You will need all three at some point, depending on the data. Let's start with one-to-one joins, because they are simple to demonstrate.

## One-to-one joins

Consider combining two `DataFrames` that contain different information about the same employees in a company.

You can group an example of four employees by the department they work in:

```python
df1 = pd.DataFrame({'employee': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'group': ['Accounting', 'Marketing', 'Marketing', 'HR']})
df1
```

Here's the output:

```Output
|   | employee | group      |
-----------------------------
| 0 | Gary     | Accounting |
| 1 | Stu      | Marketing  |
| 2 | Mary     | Marketing  |
| 3 | Sue      | HR         |
```

Next, let's look at the years that the same four employees were hired:

```python
df2 = pd.DataFrame({'employee': ['Mary', 'Stu', 'Gary', 'Sue'],
                    'hire_date': [2008, 2012, 2017, 2018]})
df2
```

This output is returned:

```Output
|   | employee | hire_date |
----------------------------
| 0 | Mary     | 2008      |
| 1 | Stu      | 2012      |
| 2 | Gary     | 2017      |
| 3 | Sue      | 2018      |
```

Combine this information in a single `DataFrame` by using the `merge` function:

```python
df3 = pd.merge(df1, df2)
df3
```

Here's the output:

```Output
|   | employee | group      | hire_date |
-----------------------------------------
| 0 | Mary     | Accounting | 2008      |
| 1 | Stu      | Marketing  | 2012      |
| 2 | Gary     | Marketing  | 2017      |
| 3 | Sue      | HR         | 2018      |
```

pandas joined on the employee column because it was the only column common to both df1 and df2. (Notice also that the original indices of df1 and df2 were discarded by `merge`. This is generally the case with merges unless you conduct them by index, which we will discuss later on.)

## Many-to-one joins

A many-to-one join is like a one-to-one join, except that one of the two key columns contains duplicate entries. The `DataFrame` that results from such a join will preserve those duplicate entries as appropriate. 

You can join two `DataFrames`:

```python
df4 = pd.DataFrame({'group': ['Accounting', 'Marketing', 'HR'],
                    'supervisor': ['Carlos', 'Giada', 'Stephanie']})
df4
```

Here's the output:

```Output
|   | group      | supervisor |
-------------------------------
| 0 | Accounting | Carlos     |
| 1 | Marketing  | Giada      |
| 2 | HR         | Stephanie  |
```

You also can join two data sources:

```python
pd.merge(df3, df4)
```

This output is returned:

```Output
|   | employee | group      | hire_date | supervisor |
------------------------------------------------------
| 0 | Gary     | Accounting | 2017      | Carlos     |
| 1 | Stu      | Marketing  | 2012      | Giada      |
| 2 | Mary     | Marketing  | 2008      | Giada      |
| 3 | Sue      | HR         | 2018      | Stephanie  |
```

The resulting `DataFrame` has an additional column for supervisor. That column has an extra occurrence of **Giada** that didn't occur in df4. This is because more than one employee in the merged `DataFrame` works in the **Marketing** group.

Notice that we didn’t specify which column to join on. When you don't specify that information, `merge` uses the overlapping column names as the keys. However, that can be ambiguous; several columns might meet that condition. For that reason, it's a good practice to explicitly specify on which key to join. You can do this with the `on` parameter. 

Here's an example:

```python
pd.merge(df3, df4, on='group')
```

This output is returned:

```Output
|   | employee | group      | hire_date | supervisor |
------------------------------------------------------
| 0 | Gary     | Accounting | 2017      | Carlos     |
| 1 | Stu      | Marketing  | 2012      | Giada      |
| 2 | Mary     | Marketing  | 2008      | Giada      |
| 3 | Sue      | HR         | 2018      | Stephanie  |
```

## Many-to-many joins

What happens if the key columns in both of the `DataFrames` you're joining contain duplicates? That gives you a many-to-many join:

```python
df5 = pd.DataFrame({'group': ['Accounting', 'Accounting',
                              'Marketing', 'Marketing', 'HR', 'HR'],
                    'core_skills': ['math', 'spreadsheets', 'writing', 'communication',
                               'spreadsheets', 'organization']})
df5
```

Here's the output:

```Output
|   | group      | core_skills   |
----------------------------------
| 0 | Accounting | math          |
| 1 | Accounting | spreadsheets  |
| 2 | Marketing  | writing       |
| 3 | Marketing  | communication |
| 4 | HR         | spreadsheets  |
| 5 | HR         | organization  |
```

Then, run this code in a cell:

```python
pd.merge(df1, df5, on='group')
```

This output is returned:

```Output
|   | employee | group      | core_skills   |
--------------------------------------------
| 0 | Gary     | Accounting | math          |
| 1 | Gary     | Accounting | spreadsheets  |
| 2 | Stu      | Marketing  | writing       |
| 3 | Stu      | Marketing  | communication |
| 4 | Mary     | Marketing  | writing       |
| 5 | Mary     | Marketing  | communication |
| 6 | Sue      | HR         | spreadsheets  |
| 7 | Sue      | HR         | organization  |
```

Again, to avoid ambiguity about which column to join on, it's a good idea to explicitly tell `merge` which one to use with the `on` parameter.

## left_on and right_on keywords

What if you need to merge two datasets with no shared column names? For example, what if you're using a dataset in which the employee name is labeled **name**, rather than **employee**? In such cases, use the `left_on` and `right_on` keywords to specify the column names on which to join:

```python
df6 = pd.DataFrame({'name': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'salary': [70000, 80000, 120000, 90000]})
df6
```

Here's the output:

```Output
|   | name | salary |
---------------------
| 0 | Gary | 7000   |
| 1 | Stu  | 8000   |
| 2 | Mary | 120000 |
| 3 | Sue  | 9000   |
```

Next, run this code in a cell:

```python
pd.merge(df1, df6, left_on="employee", right_on="name")
```

This output is returned:

```Output
|   | employee | group      | name | salary |
---------------------------------------------
| 0 | Gary     | Accounting | Gary | 7000   |
| 1 | Stu      | Marketing  | Stu  | 8000   |
| 2 | Mary     | Marketing  | Mary | 120000 |
| 3 | Sue      | HR         | Sue  | 9000   |
```

### Try it yourself

Using the documentation, can you figure out how to use `.drop()` to get rid of the **name** column? You will need to supply two parameters to `.drop()`.

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  pd.merge(df1, df6, left_on="employee", right_on="name").drop("name", axis=1)
  ```

  ```Output
  |   | employee | group      | salary |
  ---------------------------------------------
  | 0 | Gary     | Accounting | 7000   |
  | 1 | Stu      | Marketing  | 8000   |
  | 2 | Mary     | Marketing  | 120000 |
  | 3 | Sue      | HR         | 9000   |
  ```

</details>

<br /><br />

***

## left_index and right_index keywords

Sometimes it can be more advantageous to merge on an index rather than on a column. The `left_index` and `right_index` keywords make it possible to join by index. Let's revisit some of our earlier example `DataFrames` to see what this looks like in action.

```python
df1a = df1.set_index('employee')
df1a
```

Here's the output:

```Output
|          | group      | 
-------------------------
| employee |            |
| Gary     | Accounting | 
| Stu      | Marketing  |
| Mary     | Marketing  |
| Sue      | HR         | 
```

Next, run this code in a cell:

```python
df2a = df2.set_index('employee')
df2a
```

This output is returned:

```Output
|          | hire_date | 
------------------------
| employee |           |
| Mary     | 2008      | 
| Stu      | 2012      |
| Gary     | 2017      |
| Sue      | 2018      | 
```

To merge on the index, specify the `left_index` and `right_index` parameters in `merge`:

```python
pd.merge(df1a, df2a, left_index=True, right_index=True)
```

Here's the output:

```Output
|          | group      | hire_date |
-------------------------------------
| employee |            |           |
| Gary     | Accounting | 2017      | 
| Stu      | Marketing  | 2012      |
| Mary     | Marketing  | 2008      |
| Sue      | HR         | 2018      | 
```

### Try it yourself

What happens if you specify only `left_index` or `right_index`?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  pd.merge(df1a, df2a, left_index=True)
  ```

  ```Output
  ---------------------------------------------------------------------------
  MergeError                                Traceback (most recent call last)
  <ipython-input-40-41267a9d884c> in <module>()
        1 # What happens if you specify only left_index or right_index?
  ----> 2 pd.merge(df1a, df2a, left_index=True)
  
~/anaconda3_420/lib/python3.5/site-packages/pandas/tools/merge.py in merge(left, right, how, on, left_on,   right_on, left_index, right_index, sort, suffixes, copy, indicator)
       59                          right_on=right_on, left_index=left_index,
       60                          right_index=right_index, sort=sort, suffixes=suffixes,
  ---> 61                          copy=copy, indicator=indicator)
       62     return op.get_result()
       63 if __debug__:
  
~/anaconda3_420/lib/python3.5/site-packages/pandas/tools/merge.py in __init__(self, left, right, how, on,   left_on, right_on, axis, left_index, right_index, sort, suffixes, copy, indicator)
      536             warnings.warn(msg, UserWarning)
      537 
  --> 538         self._validate_specification()
      539 
      540         # note this function has side effects
  
  ~/anaconda3_420/lib/python3.5/site-packages/pandas/tools/merge.py in _validate_specification(self)
      872             elif self.left_index:
      873                 if self.right_on is None:
  --> 874                     raise MergeError('Must pass right_on or right_index=True')
      875             elif self.right_index:
      876                 if self.left_on is None:
  
  MergeError: Must pass right_on or right_index=True
  ```

</details>

<br /><br />

***


You can also use the `join` method for `DataFrames`, which produces the same effect but merges on indices by default:

```python
df1a.join(df2a)
```

This output is returned:

```Output
|          | group      | hire_date |
-------------------------------------
| employee |            |           |
| Gary     | Accounting | 2017      | 
| Stu      | Marketing  | 2012      |
| Mary     | Marketing  | 2008      |
| Sue      | HR         | 2018      | 
```

You can also mix and match `left_index`/`right_index` with `right_on`/`left_on`:

```python
pd.merge(df1a, df6, left_index=True, right_on='name')
```

Here's the output:

```Output
|   | group      | name | salary |
----------------------------------
| 0 | Accounting | Gary | 7000   |
| 1 | Marketing  | Stu  | 8000   |
| 2 | Marketing  | Mary | 12000  | 
| 3 | HR         | Sue  | 9000   | 
```

## Set arithmetic for joins

Let's return to many-to-many joins for a moment. A consideration that is unique to them is the arithmetic of the join, specifically the set arithmetic you use for the join. To illustrate this, let's restructure an old example `DataFrame`:

```python
df5 = pd.DataFrame({'group': ['Engineering', 'Marketing', 'Sales'],
                    'core_skills': ['math', 'writing', 'communication']})
df5
```

Here's the output:

```Output
|   | group       | core_skills   |
-----------------------------------
| 0 | Engineering | math          |
| 1 | Marketing   | writing       | 
| 2 | Sales       | communication |
```

Run this code in a cell:

```python
pd.merge(df1, df5, on='group')
```

Here's the output:

```Output
|   | employee | group     | core_skills |
------------------------------------------
| 0 | Stu      | Marketing | writing     |
| 1 | Mary     | Marketing | writing     |
```

Notice that after you restructured df5 and then reran the merge with df1, there are only two entries in the result. This is because you merged on `group`, and **Marketing** was the only entry that appeared in the **group** column of both `DataFrames`.

In effect, you have the intersection of both `DataFrames`. This is known as the inner join in the database world, and it's the default setting for `merge` (you can also explicitly specify it):

```python
pd.merge(df1, df5, on='group', how='inner')
```

Here's the output:

```Output
|   | employee | group     | core_skills |
------------------------------------------
| 0 | Stu      | Marketing | writing     |
| 1 | Mary     | Marketing | writing     |
```

The complement of the inner join is the outer join, which returns the union of the two `DataFrames`.

### Try it yourself

The keyword for perfoming an outer join is `how`='outer'. How would you perform it? What do you expect the output of an outer join of df1 and df5 to be?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  pd.merge(df1, df5, on='group', how='outer')
  ```

  ```Output
  |   | employee | group       | core_skills   |
  ----------------------------------------------
  | 0 | Gary     | Accounting  | NaN           |
  | 1 | Stu      | Marketing   | writing       |
  | 2 | Mary     | Marketing   | writing       |
  | 3 | Sue      | HR          | NaN           |
  | 4 | NaN      | Engineering | math          |
  | 5 | NaN      | Sales       | communication |
  ```

</details>

<br /><br />

***

Notice in your resulting `DataFrame` that not every row in df1 and df5 had a value that corresponds to the union of the key values (the **group** column). pandas fills in these missing values with NaNs.

Inner and outer joins aren't your only options. A left join returns all of the rows in the first (left-side) `DataFrame` supplied. The join merges these with rows from the other `DataFrame` that match up with the left-side key values (and NaNs rows with respective values):

```python
pd.merge(df1, df5, how='left')
```

Here's the output:

```Output
|   | employee | group      | core_skills |
-------------------------------------------
| 0 | Gary     | Accounting | NaN         |
| 1 | Stu      | Marketing  | writing     |
| 2 | Mary     | Marketing  | writing     | 
| 3 | Sue      | HR         | NaN         | 
```

### Try it yourself

Now run the right merge between df1 and df5. What do you expect to see?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  pd.merge(df1, df5, how='right')
  ```

  ```Output
  |   | employee | group       | core_skills   |
  ----------------------------------------------
  | 0 | Stu      | Marketing   | writing       |
  | 1 | Mary     | Marketing   | writing       |
  | 2 | NaN      | Engineering | math          | 
  | 3 | NaN      | Sales       | communication | 
  ```

</details>

<br /><br />

***

## suffixes keyword: dealing with conflicting column names

Because you can join datasets, you'll eventually join two with conflicting column names. Let's look at another example:

```python
df7 = pd.DataFrame({'name': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'rank': [1, 2, 3, 4]})
df7
```

Here's the output:

```Output
|   | name | rank |
-------------------
| 0 | Gary | 1    |
| 1 | Stu  | 2    | 
| 2 | Mary | 3    |
| 3 | Sue  | 4    | 
```

Next, run this code in a cell:

```python
df8 = pd.DataFrame({'name': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'rank': [3, 1, 4, 2]})
df8
pd.merge(df7, df8, on='name')
```

Here's the output:

```Output
|   | name | rank |
-------------------
| 0 | Gary | 3    |
| 1 | Stu  | 1    | 
| 2 | Mary | 4    |
| 3 | Sue  | 2    | 
```

Run this code in a cell:

```python
pd.merge(df7, df8, on='name')
```

Output:

```Output
|   | name | rank_x | rank_y |
------------------------------
| 0 | Gary | 1      | 3      |
| 1 | Stu  | 2      | 1      |
| 2 | Mary | 3      | 4      |
| 3 | Sue  | 4      | 2      |
```

Each column name in a `DataFrame` must be unique. Where two joined `DataFrames` share column names (aside from the column serving as the key), the `merge` function automatically appends the suffix **_x** or **_y** to the conflicting column names. This makes them unique. In cases where it's best to control your column names, you can specify a custom suffix for `merge` to append through the suffixes keyword:

```python
pd.merge(df7, df8, on='name')
pd.merge(df7, df8, on='name', suffixes=['_left', '_right'])
```

Here's the output:

```Output
|   | name | rank_left | rank_right |
-------------------------------------
| 0 | Gary | 1         | 3          |
| 1 | Stu  | 2         | 1          |
| 2 | Mary | 3         | 4          |
| 3 | Sue  | 4         | 2          |
```

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

   ```Output
   array([1, 2, 3, 4, 5, 6, 7, 8, 9])
   ```

* For two-dimensional arrays:

   ```python
   x = [[1, 2],
   [3, 4]]
   np.concatenate([x, x], axis=1)
   ```

   Here's the output:

   ```Output
   array([[1, 2, 1, 2],
       [3, 4, 3, 4]])
   ```

Notice that the `axis=1` parameter makes the concatenation occur along columns rather than rows. Concatenation in pandas looks similar to this.

## Concatenation in pandas

pandas has a function, `pd.concat()`, that can be used for a simple concatenation of `Series` or `DataFrame` objects, similar to `np.concatenate()` with `ndarrays`.

```python
ser1 = pd.Series(['a', 'b', 'c'], index=[1, 2, 3])
ser2 = pd.Series(['d', 'e', 'f'], index=[4, 5, 6])
pd.concat([ser1, ser2])
```

Here's the output:

```Output
1    a
2    b
3    c
4    d
5    e
6    f
dtype: object
```

It also concatenates higher-dimensional objects, such as `DataFrames`:

```python
df9 = pd.DataFrame({'A': ['a', 'c'],
                    'B': ['b', 'd']})
df9
```

Here's the output:

```Output
|   | A | B |
-------------
| 0 | a | b |
| 1 | c | d | 
```

Run this code in a cell:

```python
pd.concat([df9, df9])
```

Here's the output:

```Output
|   | A | B |
-------------
| 0 | a | b |
| 1 | c | d |
| 0 | a | b |
| 1 | c | d |
```

Notice that `pd.concat` has preserved the indexing, even though that means that it has been duplicated. You can have the results reindexed (and avoid potential confusion down the road), like this:

```python
pd.concat([df9, df9], ignore_index=True)
```

Here's the output:

```Output
|   | A | B |
-------------
| 0 | a | b |
| 1 | c | d | 
| 2 | a | b |
| 3 | c | d | 
```

By default, `pd.concat` concatenates row-wise within the `DataFrame` (that is, axis=0 by default). You can specify the axis along which to concatenate:

```python
pd.concat([df9, df9], axis=1)
```

Here's the output:

```Output
|   | A | B | A | B |
---------------------
| 0 | a | b | a | b |
| 1 | c | d | c | d |
```

Although pandas display the output without error, you'll get an error message if you try to assign this result as a new `DataFrame`. Column names in `DataFrames` must be unique.

## Concatenation with joins

Just as you did with `merge` earlier, you can use inner and outer joins when you're concatenating `DataFrames` with different sets of column names.

```python
df10 = pd.DataFrame({'A': ['a', 'd'],
                     'B': ['b', 'e'],
                     'C': ['c', 'f']})
df10
```

Here's the output:

```Output
|   | A | B | C |
-----------------
| 0 | a | b | c |
| 1 | d | e | f |
```

Run this code in a cell:

```python
df11 = pd.DataFrame({'B': ['u', 'x'],
                     'C': ['v', 'y'],
                     'D': ['w', 'z']})
df11
```

Here's the output:

```Output
|   | B | C | D |
-----------------
| 0 | u | v | w |
| 1 | x | y | z |
```

Run this code in a cell:

```python
pd.concat([df10, df11])
```

Here's the output:

```Output
|   | A   | B | C | D   |
-------------------------
| 0 | a   | b | c | NaN |
| 1 | d   | e | f | NaN |
| 0 | NaN | u | v | w   |
| 1 | NaN | x | y | z   |
```

As you saw earlier, the default join for this is an outer join, and entries for which no data is available are filled with NaN values. You can also do an inner join:

```python
pd.concat([df10, df11], join='inner')
```

Here's the output:

```Output
|   |  B | C |
--------------
| 0 | b  | c |
| 1 | e  | f |
| 0 | u  | v |
| 1 | x  | y |
```

Another option is to directly specify the index of the remaining columns by using the `join_axes` argument, which takes a list of index objects. Here, you'll specify that the returned columns should be the same as those of the first input `(df10)`:

```python
pd.concat([df10, df11], join_axes=[df10.columns])
append()
```

Here's the output:

```Output
|   | A   | B | C |
-------------------
| 0 | a   | b | c |
| 1 | d   | e | f |
| 0 | NaN | u | v |
| 1 | NaN | x | y |
```

### `append()`

Because direct array concatenation is so common, `Series` and `DataFrame` objects have an `append` method that can accomplish the same thing in fewer keystrokes. For example, rather than calling `pd.concat([df9, df9])`, you can call `df9.append(df9)`:

```python
df9.append(df9)
```

Here's the output:

```Output
|   | A | B |
-------------
| 0 | a | b |
| 1 | c | d |
| 0 | a | b |
| 1 | c | d |
```

> [!IMPORTANT]
> Unlike the `append()` and `extend()` methods of Python lists, the `append()` method in pandas doesn't modify the original object. Instead, it creates a new object with the combined data.

> [!div class="alert is-tip"]
> ### Takeaway
>
> A large part of the value you can provide as a data scientist comes from connecting multiple, often disparate datasets to find new insights. Learning how to join and merge    data is thus an essential part of your skill set.
