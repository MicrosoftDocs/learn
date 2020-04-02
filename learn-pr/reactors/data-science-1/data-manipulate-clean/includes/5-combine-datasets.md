By the end of this subsection, you should have a general knowledge of the various ways to combine DataFrames.

Your most interesting analyses will often come from data melded together from more than one source. Because of this, pandas provides several methods of merging and joining datasets to make this necessary job easier:

pandas.merge connects rows in DataFrames based on one or more keys.
pandas.concat concatenates or “stacks” together objects along an axis.
The combine_first instance method enables you to splice together overlapping data to fill in missing values in one object with values from another.
Let's examine merging data first, because it will be the most familiar to course attendees who are already familiar with SQL or other relational databases.

## Categories of joins

merge carries out several types of joins: one-to-one, many-to-one, and many-to-many. You use the same basic function call to implement all of them and we will examine all three (because you will need all three as some point in your data delving depending on the data). We will start with one-to-one joins because they are generally the simplest example.

## One-to-one joins

Consider combining two DataFrames that contain different information on the same employees in a company:

```output
df1 = pd.DataFrame({'employee': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'group': ['Accounting', 'Marketing', 'Marketing', 'HR']})
df1
```

```output
df2 = pd.DataFrame({'employee': ['Mary', 'Stu', 'Gary', 'Sue'],
                    'hire_date': [2008, 2012, 2017, 2018]})
df2
```

Combine this information into a single DataFrame using the `merge` function:

```output
df3 = pd.merge(df1, df2)
df3
```

pandas joined on the employee column because it was the only column common to both df1 and df2. (Notice also that the original indices of df1 and df2 were discarded by merge; this is generally the case with merges unless you conduct them by index, which we will discuss later on.)

## Many-to-one joins

A many-to-one join is like a one-to-one join except that one of the two key columns contains duplicate entries. The DataFrame resulting from such a join will preserve those duplicate entries as appropriate:

```output
df4 = pd.DataFrame({'group': ['Accounting', 'Marketing', 'HR'],
                    'supervisor': ['Carlos', 'Giada', 'Stephanie']})
df4
```

```output
pd.merge(df3, df4)
```

The resulting DataFrame has an additional column for supervisor; that column has an extra occurrence of 'Giada' that did not occur in df4 because more than one employee in the merged DataFrame works in the 'Marketing' group.

Notice that we didn’t specify which column to join on. When you don't specify that information, merge uses the overlapping column names as the keys. However, that can be ambiguous; several columns might meet that condition. For that reason, it is a good practice to explicitly specify on which key to join. You can do this with the on parameter:

```output
pd.merge(df3, df4, on='group')
```

## Many-to-many joins

What happens if the key columns in both of the DataFrames you are joining contain duplicates? That gives you a many-to-many join:

```output
df5 = pd.DataFrame({'group': ['Accounting', 'Accounting',
                              'Marketing', 'Marketing', 'HR', 'HR'],
                    'core_skills': ['math', 'spreadsheets', 'writing', 'communication',
                               'spreadsheets', 'organization']})
df5
```

```output
pd.merge(df1, df5, on='group')
```

Again, in order to avoid ambiguity as to which column to join on, it is a good idea to explicitly tell `merge` which one to use with the `on` parameter.

## left_on and right_on keywords

What if you need to merge two datasets with no shared column names? For example, what if you are using a dataset in which the employee name is labeled as 'name' rather than 'employee'? In such cases, you will need to use the left_on and right_on keywords in order to specify the column names on which to join:

```output
df6 = pd.DataFrame({'name': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'salary': [70000, 80000, 120000, 90000]})
df6
```

```output
pd.merge(df1, df6, left_on="employee", right_on="name")
```

### Exercise

Using the documentation, can you figure out how to use `.drop()` to get rid of the **name** column?

Hint: You will need to supply two parameters to `.drop()`.

## left_index and right_index keywords

Sometimes it can be more advantageous to merge on an index rather than on a column. The left_index and right_index keywords make it possible to join by index. Let's revisit some of our earlier example DataFrames to see what this looks like in action.

```output
df1a = df1.set_index('employee')
df1a
```

```output
df2a = df2.set_index('employee')
df2a
```

To merge on the index, specify the left_index and right_index parameters in merge:

```output
pd.merge(df1a, df2a, left_index=True, right_index=True)
```

### Exercise

What happens if you specify only left_index or right_index?

You can also use the join method for DataFrames, which produces the same effect but merges on indices by default:

```output
df1a.join(df2a)
```

You can also mix and match left_index/right_index with right_on/left_on:

```output
pd.merge(df1a, df6, left_index=True, right_on='name')
```

## Set arithmetic for joins

Let's return to many-to-many joins for a moment. A consideration that is unique to them is the arithmetic of the join, specifically the set arithmetic we use for the join. To illustrate what we mean by this, let's restructure an old example DataFrame:

```output
df5 = pd.DataFrame({'group': ['Engineering', 'Marketing', 'Sales'],
                    'core_skills': ['math', 'writing', 'communication']})
df5
```

```output
pd.merge(df1, df5, on='group')
```


Notice that after we have restructured df5 and then rerun the merge with df1, we have only two entries in the result. This is because we merged on group and 'Marketing' was the only entry that appeared in the group column of both DataFrames.

In effect, what we have gotten is the intersection of both DataFrames. This is know as the inner join in the database world and it is the default setting for merge although we can certainly specify it:

```output
pd.merge(df1, df5, on='group', how='inner')
```

The complement of the inner join is the outer join, which returns the union of the two DataFrames.

### Exercise

The keyword for perfoming an outer join is how='outer'. How would you perform it?

What do you expect the output of an outer join of df1 and df5 to be?

Notice in your resulting DataFrame that not every row in df1 and df5 had a value that corresponds to the union of the key values (the 'group' column). Pandas fills in these missing values with NaNs.

Inner and outer joins are not your only options. A left join returns all of the rows in the first (left-side) DataFrame supplied to merge along with rows from the other DataFrame that match up with the left-side key values (and NaNs rows with respective values):

```output
pd.merge(df1, df5, how='left')
```

### Exercise

Now run the right merge between df1 and df5.

What do you expect to see?

## suffixes keyword: dealing with conflicting column names

Because you can join datasets, you will eventually join two with conflicting column names. Let's look at another example to see what we mean:

```output
df7 = pd.DataFrame({'name': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'rank': [1, 2, 3, 4]})
df7
```

```output
df8 = pd.DataFrame({'name': ['Gary', 'Stu', 'Mary', 'Sue'],
                    'rank': [3, 1, 4, 2]})
df8
pd.merge(df7, df8, on='name')
```


Each column name in a DataFrame must be unique, so in cases where two joined DataFrames share column names (aside from the column serving as the key), the merge function automatically appends the suffix _x or _y to the conflicting column names in order to make them unique. In cases where it is best to control your column names, you can specify a custom suffix for merge to append through the suffixes keyword:

```output
pd.merge(df7, df8, on='name')
pd.merge(df7, df8, on='name', suffixes=['_left', '_right'])
```

These suffixes work if there are multiple conflicting columns.

## Concatenation in NumPy

Concatenation in pandas is built off of the concatenation functionality for NumPy arrays. Here is what NumPy concatenation looks like:

* For one-dimensional arrays:
   
   ```output
   x = [1, 2, 3]
   y = [4, 5, 6]
   z = [7, 8, 9]
   np.concatenate([x, y, z])
   ```

* For two-dimensional arrays:

   ```output
   x = [[1, 2],
   [3, 4]]
   np.concatenate([x, x], axis=1)
   ```

Notice that the axis=1 parameter makes the concatenation occur along columns rather than rows. Concatenation in pandas looks similar to this.

## Concatenation in pandas

pandas has a function, pd.concat() that can be used for a simple concatenation of Series or DataFrame objects in similar manner to np.concatenate() with `ndarrays`.

```output
ser1 = pd.Series(['a', 'b', 'c'], index=[1, 2, 3])
ser2 = pd.Series(['d', 'e', 'f'], index=[4, 5, 6])
pd.concat([ser1, ser2])
```

It also concatenates higher-dimensional objects, such as DataFrames:

```output
df9 = pd.DataFrame({'A': ['a', 'c'],
                    'B': ['b', 'd']})
df9
```

```output
pd.concat([df9, df9])
```

Notice that pd.concat has preserved the indexing even though that means that it has been duplicated. You can have the results reindexed (and avoid potential confusion down the road) like so:

```output
pd.concat([df9, df9], ignore_index=True)
```

By default, pd.concat concatenates row-wise within the DataFrame (that is, axis=0 by default). You can specify the axis along which to concatenate:

```output
pd.concat([df9, df9], axis=1)
```

Although pandas display the output without error, you will get an error message if you try to assign this result as a new DataFrame. Column names in DataFrames must be unique.

## Concatenation with joins

Just as you did with merge above, you can use inner and outer joins when concatenating DataFrames with different sets of column names.

```output
df10 = pd.DataFrame({'A': ['a', 'd'],
                     'B': ['b', 'e'],
                     'C': ['c', 'f']})
df10
```

```output
df11 = pd.DataFrame({'B': ['u', 'x'],
                     'C': ['v', 'y'],
                     'D': ['w', 'z']})
df11
```

```output
pd.concat([df10, df11])
```

As we saw earlier, the default join for this is an outer join and entries for which no data is available are filled with NaN values. You can also do an inner join:

```output
pd.concat([df10, df11], join='inner')
```

Another option is to directly specify the index of the remaining columns using the `join_axes` argument, which takes a list of index objects. Here, we will specify that the returned columns should be the same as those of the first input `(df10)`:

```output
pd.concat([df10, df11], join_axes=[df10.columns])
append()
```

Because direct array concatenation is so common, Series and DataFrame objects have an append method that can accomplish the same thing in fewer keystrokes. For example, rather than calling `pd.concat([df9, df9])`, you can call `df9.append(df9)`:

```output
df9.append(df9)
```

> [!IMPORTANT]
> Unlike the `append()` and `extend()` methods of Python lists, the `append()` method in pandas does not modify the original object. Instead, it creates a new object with the combined data.

> **Takeaway**: A large part of the value you can provide as a data scientist comes from connecting multiple, often disparate datasets to find new insights. Learning how to join and merge data is thus an essential part of your skill set.