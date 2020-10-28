> [!NOTE]
> You can find an interactive version of this unit named **central-limit-theorem.ipynb** in your virtual environment. If you haven't set up your online Visual Studio Codespaces environment for the Learning Path "Foundations of Data Science", please refer to the first unit **Setup.**

Open [Visual Studio Codespaces](https://online.visualstudio.com/environments) please refer to unit 1, for guidance on setting up your environment.


``` python
import numpy as np
np.set_printoptions(threshold=50)
path_data = '../../../data/'
```

## Introduction to Tables

Tables are a fundamental object type for representing data sets. A table
can be viewed in two ways:

- A sequence of named columns that each describe a single aspect of all entries in a data set
- A sequence of rows that each contain all information about a single entry in a data
set.

In order to use tables, import all of the module called `datascience`, a
module created for this text.

``` python
from datascience import *
```

Empty tables can be created using the `Table` function. An empty table
is useful because it can be extended to contain new rows and columns.

``` python
Table()
```

The `with_columns` method on a table constructs a new table with
additional labeled columns. Each column of a table is an array. To add
one new column to a table, call `with_columns` with a label and an
array. (The `with_column` method can be used with the same effect.)

``` python
Table().with_columns('Number of petals', make_array(8, 34, 5))
```

``` output
| Number of petals |
|------------------|
| 8                |
| 34               |
| 5                |  

```

To add two (or more) new columns, provide the label and array for each
column. All columns must have the same length, or an error will occur.

``` python
Table().with_columns(
    'Number of petals', make_array(8, 34, 5),
    'Name', make_array('lotus', 'sunflower', 'rose')
)
```

``` output
| Number of petals | Name      |
|------------------|-----------|
| 8                | lotus     |
| 34               | sunflower |
| 5                | rose      |  

```

We can give this table a name, and then extend the table with another
column.

``` python
flowers = Table().with_columns(
    'Number of petals', make_array(8, 34, 5),
    'Name', make_array('lotus', 'sunflower', 'rose')
)

flowers.with_columns(
    'Color', make_array('pink', 'yellow', 'red')
)
```

``` output
| Number of petals | Name      | Color  |
|------------------|-----------|--------|
| 8                | lotus     | pink   |
| 34               | sunflower | yellow |
| 5                | rose      | red    |  

```

The `with_columns` method creates a new table each time it is called, so
the original table is not affected. For example, the table `flowers`
still has only the two columns that it had when it was created.

``` python
flowers
```

``` output
| Number of petals | Name      |
|------------------|-----------|
| 8                | lotus     |
| 34               | sunflower |
| 5                | rose      |  

```

Creating tables in this way involves a lot of typing. If the data has
already been entered somewhere, it is usually possible to use Python to
read it into a table, instead of typing it all in cell by cell.

Often, tables are created from files that contain comma-separated
values. Such files are called CSV files.

Below, we use the Table method `read_table` to read a CSV file that
contains some of the data used by Minard in his graphic about Napoleon's
Russian campaign. The data is placed in a table named `minard`.

``` python
minard = Table.read_table(path_data + 'minard.csv')
minard
```

``` output
| Longitude | Latitude | City        | Direction | Survivors |
|-----------|----------|-------------|-----------|-----------|
| 32        | 54.8     | Smolensk    | Advance   | 145000    |
| 33.2      | 54.9     | Dorogobouge | Advance   | 140000    |
| 34.4      | 55.5     | Chjat       | Advance   | 127100    |
| 37.6      | 55.8     | Moscou      | Advance   | 100000    |
| 34.3      | 55.2     | Wixma       | Retreat   | 55000     |
| 32        | 54.6     | Smolensk    | Retreat   | 24000     |
| 30.4      | 54.4     | Orscha      | Retreat   | 20000     |
| 26.8      | 54.3     | Moiodexno   | Retreat   | 12000     |  

```

We will use this small table to demonstrate some useful Table methods.
We will then use those same methods, and develop other methods, on much
larger tables of data.

### Get the table size

The method `num_columns` gives the number of columns in the table, and
`num_rows` the number of rows.

``` python
minard.num_columns
```

``` output
5
```

``` python
minard.num_rows
```

``` output
8
```

### List the column labels

The method `labels` can be used to list the labels of all the columns.
With `minard` we don't gain much by this, but it can be very useful for
tables that are so large that not all columns are visible on the screen.

``` python
minard.labels
```

``` output
('Longitude', 'Latitude', 'City', 'Direction', 'Survivors')
```

We can change column labels using the `relabeled` method. This creates a
new table and leaves `minard` unchanged.

``` python
minard.relabeled('City', 'City Name')
```

``` output
| Longitude | Latitude | City Name   | Direction | Survivors |
|-----------|----------|-------------|-----------|-----------|
| 32        | 54.8     | Smolensk    | Advance   | 145000    |
| 33.2      | 54.9     | Dorogobouge | Advance   | 140000    |
| 34.4      | 55.5     | Chjat       | Advance   | 127100    |
| 37.6      | 55.8     | Moscou      | Advance   | 100000    |
| 34.3      | 55.2     | Wixma       | Retreat   | 55000     |
| 32        | 54.6     | Smolensk    | Retreat   | 24000     |
| 30.4      | 54.4     | Orscha      | Retreat   | 20000     |
| 26.8      | 54.3     | Moiodexno   | Retreat   | 12000     |  

```

However, this method does not change the original table.

``` python
minard
```

``` output
| Longitude | Latitude | City        | Direction | Survivors |
|-----------|----------|-------------|-----------|-----------|
| 32        | 54.8     | Smolensk    | Advance   | 145000    |
| 33.2      | 54.9     | Dorogobouge | Advance   | 140000    |
| 34.4      | 55.5     | Chjat       | Advance   | 127100    |
| 37.6      | 55.8     | Moscou      | Advance   | 100000    |
| 34.3      | 55.2     | Wixma       | Retreat   | 55000     |
| 32        | 54.6     | Smolensk    | Retreat   | 24000     |
| 30.4      | 54.4     | Orscha      | Retreat   | 20000     |
| 26.8      | 54.3     | Moiodexno   | Retreat   | 12000     |  


```

A common pattern is to assign the original name `minard` to the new
table, so that all future uses of `minard` will refer to the relabeled
table.

``` python
minard = minard.relabeled('City', 'City Name')
minard
```

``` output
| Longitude | Latitude | City Name   | Direction | Survivors |
|-----------|----------|-------------|-----------|-----------|
| 32        | 54.8     | Smolensk    | Advance   | 145000    |
| 33.2      | 54.9     | Dorogobouge | Advance   | 140000    |
| 34.4      | 55.5     | Chjat       | Advance   | 127100    |
| 37.6      | 55.8     | Moscou      | Advance   | 100000    |
| 34.3      | 55.2     | Wixma       | Retreat   | 55000     |
| 32        | 54.6     | Smolensk    | Retreat   | 24000     |
| 30.4      | 54.4     | Orscha      | Retreat   | 20000     |
| 26.8      | 54.3     | Moiodexno   | Retreat   | 12000     |  

```

### Access data in a column

We can use a column's label to access the array of data in the column.

``` python
minard.column('Survivors')
```

``` output

array(\[145000, 140000, 127100, 100000, 55000, 24000, 20000, 12000\])
```

The 5 columns are indexed 0, 1, 2, 3, and 4. The column `Survivors` can
also be accessed by using its column index.

``` python
minard.column(4)
```

``` output
array(\[145000, 140000, 127100, 100000, 55000, 24000, 20000, 12000\])
```

The 8 items in the array are indexed 0, 1, 2, and so on, up to 7. The
items in the column can be accessed using `item`, as with any array.

``` python
minard.column(4).item(0)
```

``` output
145000
```

``` python
minard.column(4).item(5)
```

``` output
24000
```

### Work with data in a column

Because columns are arrays, we can use array operations on them to
discover new information. For example, we can create a new column that
contains the percent of all survivors at each city after Smolensk.

``` python
initial = minard.column('Survivors').item(0)
minard = minard.with_columns(
    'Percent Surviving', minard.column('Survivors')/initial
)
minard
```

``` output
| Longitude | Latitude | City Name   | Direction | Survivors | Percent Surviving |
|-----------|----------|-------------|-----------|-----------|-------------------|
| 32        | 54.8     | Smolensk    | Advance   | 145000    | 1                 |
| 33.2      | 54.9     | Dorogobouge | Advance   | 140000    | 0.965517          |
| 34.4      | 55.5     | Chjat       | Advance   | 127100    | 0.876552          |
| 37.6      | 55.8     | Moscou      | Advance   | 100000    | 0.689655          |
| 34.3      | 55.2     | Wixma       | Retreat   | 55000     | 0.37931           |
| 32        | 54.6     | Smolensk    | Retreat   | 24000     | 0.165517          |
| 30.4      | 54.4     | Orscha      | Retreat   | 20000     | 0.137931          |
| 26.8      | 54.3     | Moiodexno   | Retreat   | 12000     | 0.0827586         |  

```

To make the proportions in the new columns appear as percents, we can
use the method `set_format` with the option `PercentFormatter`. The
`set_format` method takes `Formatter` objects, which exist for dates
(`DateFormatter`), currencies (`CurrencyFormatter`), numbers, and
appears as percentages.

``` python
minard.set_format('Percent Surviving', PercentFormatter)
```

``` output
| Longitude | Latitude | City Name   | Direction | Survivors | Percent Surviving |
|-----------|----------|-------------|-----------|-----------|-------------------|
| 32        | 54.8     | Smolensk    | Advance   | 145000    | 100.00%           |
| 33.2      | 54.9     | Dorogobouge | Advance   | 140000    | 96.55%            |
| 34.4      | 55.5     | Chjat       | Advance   | 127100    | 87.66%            |
| 37.6      | 55.8     | Moscou      | Advance   | 100000    | 68.97%            |
| 34.3      | 55.2     | Wixma       | Retreat   | 55000     | 37.93%            |
| 32        | 54.6     | Smolensk    | Retreat   | 24000     | 16.55%            |
| 30.4      | 54.4     | Orscha      | Retreat   | 20000     | 13.79%            |
| 26.8      | 54.3     | Moiodexno   | Retreat   | 12000     | 8.28%             |  

```

### Choose sets of columns

The method `select` creates a new table that contains only the specified
columns.

``` python
minard.select('Longitude', 'Latitude')
```

``` output
| Longitude | Latitude |
|-----------|----------|
| 32        | 54.8     |
| 33.2      | 54.9     |
| 34.4      | 55.5     |
| 37.6      | 55.8     |
| 34.3      | 55.2     |
| 32        | 54.6     |
| 30.4      | 54.4     |
| 26.8      | 54.3     |  

```

The same selection can be made using column indices instead of labels.

``` python
minard.select(0, 1)
```

``` output
| Longitude | Latitude |
|-----------|----------|
| 32        | 54.8     |
| 33.2      | 54.9     |
| 34.4      | 55.5     |
| 37.6      | 55.8     |
| 34.3      | 55.2     |
| 32        | 54.6     |
| 30.4      | 54.4     |
| 26.8      | 54.3     |  


```

The result of using `select` is a new table, even when you select just
one column.

``` python
minard.select('Survivors')
```

``` output
| Survivors |
|-----------|
| 145000    |
| 140000    |
| 127100    |
| 100000    |
| 55000     |
| 24000     |
| 20000     |
| 12000     |  

```

Notice that the result is a table, unlike the result of `column`, which
is an array.

``` python
minard.column('Survivors')
```

``` output
array(\[145000, 140000, 127100, 100000, 55000, 24000, 20000, 12000\])
```

Another way to create a new table consisting of a set of columns is to
`drop` the columns you don't want.

``` python
minard.drop('Longitude', 'Latitude', 'Direction')
```

``` output
| City Name   | Survivors | Percent Surviving |
|-------------|-----------|-------------------|
| Smolensk    | 145000    | 100.00%           |
| Dorogobouge | 140000    | 96.55%            |
| Chjat       | 127100    | 87.66%            |
| Moscou      | 100000    | 68.97%            |
| Wixma       | 55000     | 37.93%            |
| Smolensk    | 24000     | 16.55%            |
| Orscha      | 20000     | 13.79%            |
| Moiodexno   | 12000     | 8.28%             |  

```

Neither `select` nor `drop` change the original table. Instead, they
create new smaller tables that share the same data. The fact that the
original table is preserved is useful! You can generate multiple
different tables that only consider certain columns without worrying
that one analysis will affect the other.

``` python
minard
```

``` output
| Longitude | Latitude | City Name   | Direction | Survivors | Percent Surviving |
|-----------|----------|-------------|-----------|-----------|-------------------|
| 32        | 54.8     | Smolensk    | Advance   | 145000    | 100.00%           |
| 33.2      | 54.9     | Dorogobouge | Advance   | 140000    | 96.55%            |
| 34.4      | 55.5     | Chjat       | Advance   | 127100    | 87.66%            |
| 37.6      | 55.8     | Moscou      | Advance   | 100000    | 68.97%            |
| 34.3      | 55.2     | Wixma       | Retreat   | 55000     | 37.93%            |
| 32        | 54.6     | Smolensk    | Retreat   | 24000     | 16.55%            |
| 30.4      | 54.4     | Orscha      | Retreat   | 20000     | 13.79%            |
| 26.8      | 54.3     | Moiodexno   | Retreat   | 12000     | 8.28%             |  

```

All of the methods that we have used above can be applied to any table.

## Learning objectives

In the rest of this module, you will learn:

- Understand tables as a fundamental object type used for representing data sets.
- Make Tables in Python using the Python datascience library.
- Explore different datasets using the Python datascience library.
- How to manipulate tables and wrangle data using various Python datascience library functions.
