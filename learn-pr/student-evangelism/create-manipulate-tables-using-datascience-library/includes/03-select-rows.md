``` python
from datascience import *
import numpy as np
path_data = '../../../../data/'
np.set_printoptions(threshold=50)
```

``` python
nba_salaries = Table.read_table(path_data + 'nba_salaries.csv')
nba = nba_salaries.relabeled("'15-'16 Salary", 'Salary')
```

Often, we would like to extract just those rows that correspond to
entries with a particular feature. For example, we might want only the
rows corresponding to the Warriors, or to players who earned more than
$\$10$ million. Or we might just want the top five earners.

### Specified rows

The Table method `take` does just that -- it takes a specified set of
rows. Its argument is a row index or array of indices, and it creates a
new table consisting of only those rows.

For example, if we wanted just the first row of `nba`, we could use
`take` as follows.

``` python
nba
```

| Player           | Position | Team          | Salary  |
|------------------|----------|---------------|---------|
| Paul Millsap     | PF       | Atlanta Hawks | 18.6717 |
| Al Horford       | C        | Atlanta Hawks | 12      |
| Tiago Splitter   | C        | Atlanta Hawks | 9.75625 |
| Jeff Teague      | PG       | Atlanta Hawks | 8       |
| Kyle Korver      | SG       | Atlanta Hawks | 5.74648 |
| Thabo Sefolosha  | SF       | Atlanta Hawks | 4       |
| Mike Scott       | PF       | Atlanta Hawks | 3.33333 |
| Kent Bazemore    | SF       | Atlanta Hawks | 2       |
| Dennis Schroder  | PG       | Atlanta Hawks | 1.7634  |
| Tim Hardaway Jr. | SG       | Atlanta Hawks | 1.30452 |


... (407 rows omitted)

``` python
nba.take(0)
```

| Player       | Position | Team          | Salary  |
|--------------|----------|---------------|---------|
| Paul Millsap | PF       | Atlanta Hawks | 18.6717 |


This is a new table with just the single row that we specified.

We could also get the fourth, fifth, and sixth rows by specifying a
range of indices as the argument.

``` python
nba.take(np.arange(3, 6))
```

| Player          | Position | Team          | Salary  |
|-----------------|----------|---------------|---------|
| Jeff Teague     | PG       | Atlanta Hawks | 8       |
| Kyle Korver     | SG       | Atlanta Hawks | 5.74648 |
| Thabo Sefolosha | SF       | Atlanta Hawks | 4       |


If we want a table of the top 5 highest paid players, we can first sort
the list by salary and then `take` the first five rows:

``` python
nba.sort('Salary', descending=True).take(np.arange(5))
```

| Player          | Position | Team                | Salary  |
|-----------------|----------|---------------------|---------|
| Kobe Bryant     | SF       | Los Angeles Lakers  | 25      |
| Joe Johnson     | SF       | Brooklyn Nets       | 24.8949 |
| LeBron James    | SF       | Cleveland Cavaliers | 22.9705 |
| Carmelo Anthony | SF       | New York Knicks     | 22.875  |
| Dwight Howard   | C        | Houston Rockets     | 22.3594 |


### Rows corresponding to a specified feature

More often, we will want to access data in a set of rows that have a
certain feature, but whose indices we don't know ahead of time. For
example, we might want data on all the players who made more than $\$10$
million, but we don't want to spend time counting rows in the sorted
table.

The method `where` does the job for us. Its output is a table with the
same columns as the original but only the rows *where* the feature
occurs.

The first argument of `where` is the label of the column that contains
the information about whether or not a row has the feature we want. If
the feature is "made more than $\$10$ million", the column is `Salary`.

The second argument of `where` is a way of specifying the feature. A
couple of examples will make the general method of specification easier
to understand.

In the first example, we extract the data for all those who earned more
than $\$10$ million.

``` python
nba.where('Salary', are.above(10))
```

| Player         | Position | Team              | Salary  |
|----------------|----------|-------------------|---------|
| Paul Millsap   | PF       | Atlanta Hawks     | 18.6717 |
| Al Horford     | C        | Atlanta Hawks     | 12      |
| Joe Johnson    | SF       | Brooklyn Nets     | 24.8949 |
| Thaddeus Young | PF       | Brooklyn Nets     | 11.236  |
| Al Jefferson   | C        | Charlotte Hornets | 13.5    |
| Nicolas Batum  | SG       | Charlotte Hornets | 13.1253 |
| Kemba Walker   | PG       | Charlotte Hornets | 12      |
| Derrick Rose   | PG       | Chicago Bulls     | 20.0931 |
| Jimmy Butler   | SG       | Chicago Bulls     | 16.4075 |
| Joakim Noah    | C        | Chicago Bulls     | 13.4    |


... (59 rows omitted)

The use of the argument `are.above(10)` ensured that each selected row
had a value of `Salary` that was greater than 10.

There are 69 rows in the new table, corresponding to the 69 players who
made more than $10$ million dollars. Arranging these rows in order makes
the data easier to analyze. DeMar DeRozan of the Toronto Raptors was the
"poorest" of this group, at a salary of just over $10$ million dollars.

``` python
nba.where('Salary', are.above(10)).sort('Salary')
```

| Player          | Position | Team                 | Salary  |
|-----------------|----------|----------------------|---------|
| DeMar DeRozan   | SG       | Toronto Raptors      | 10.05   |
| Gerald Wallace  | SF       | Philadelphia 76ers   | 10.1059 |
| Luol Deng       | SF       | Miami Heat           | 10.1516 |
| Monta Ellis     | SG       | Indiana Pacers       | 10.3    |
| Wilson Chandler | SF       | Denver Nuggets       | 10.4494 |
| Brendan Haywood | C        | Cleveland Cavaliers  | 10.5225 |
| Jrue Holiday    | PG       | New Orleans Pelicans | 10.5955 |
| Tyreke Evans    | SG       | New Orleans Pelicans | 10.7346 |
| Marcin Gortat   | C        | Washington Wizards   | 11.2174 |
| Thaddeus Young  | PF       | Brooklyn Nets        | 11.236  |


... (59 rows omitted)

How much did Stephen Curry make? For the answer, we have to access the
row where the value of `Player` is equal to `Stephen Curry`. That is
placed a table consisting of just one line:

``` python
nba.where('Player', are.equal_to('Stephen Curry'))
```

| Player        | Position | Team                  | Salary  |
|---------------|----------|-----------------------|---------|
| Stephen Curry | PG       | Golden State Warriors | 11.3708 |


Curry made just under $\$11.4$ million dollars. That's a lot of money,
but it's less than half the salary of LeBron James. You'll find that
salary in the "Top 5" table earlier in this section, or you could find
it replacing `'Stephen Curry'` by `'LeBron James'` in the line of code
above.

In the code, `are` is used again, but this time with the *predicate*
`equal_to` instead of `above`. Thus for example you can get a table of
all the Warriors:

``` python
nba.where('Team', are.equal_to('Golden State Warriors')).show()
```

| Player            | Position | Team                  | Salary   |
|-------------------|----------|-----------------------|----------|
| Klay Thompson     | SG       | Golden State Warriors | 15.501   |
| Draymond Green    | PF       | Golden State Warriors | 14.2609  |
| Andrew Bogut      | C        | Golden State Warriors | 13.8     |
| Andre Iguodala    | SF       | Golden State Warriors | 11.7105  |
| Stephen Curry     | PG       | Golden State Warriors | 11.3708  |
| Jason Thompson    | PF       | Golden State Warriors | 7.00847  |
| Shaun Livingston  | PG       | Golden State Warriors | 5.54373  |
| Harrison Barnes   | SF       | Golden State Warriors | 3.8734   |
| Marreese Speights | C        | Golden State Warriors | 3.815    |
| Leandro Barbosa   | SG       | Golden State Warriors | 2.5      |
| Festus Ezeli      | C        | Golden State Warriors | 2.00875  |
| Brandon Rush      | SF       | Golden State Warriors | 1.27096  |
| Kevon Looney      | SF       | Golden State Warriors | 1.13196  |
| Anderson Varejao  | PF       | Golden State Warriors | 0.289755 |


This portion of the table is already sorted by salary, because the
original table listed players sorted by salary within the same team. The
`.show()` at the end of the line ensures that all rows are shown, not
just the first 10.

It is so common to ask for the rows for which some column is equal to
some value that the `are.equal_to` call is optional. Instead, the
`where` method can be called with only a column name and a value to
achieve the same effect.

``` python
nba.where('Team', 'Denver Nuggets') # equivalent to nba.where('Team', are.equal_to('Denver Nuggets'))
```

| Player            | Position | Team           | Salary  |
|-------------------|----------|----------------|---------|
| Danilo Gallinari  | SF       | Denver Nuggets | 14      |
| Kenneth Faried    | PF       | Denver Nuggets | 11.236  |
| Wilson Chandler   | SF       | Denver Nuggets | 10.4494 |
| JJ Hickson        | C        | Denver Nuggets | 5.6135  |
| Jameer Nelson     | PG       | Denver Nuggets | 4.345   |
| Will Barton       | SF       | Denver Nuggets | 3.53333 |
| Emmanuel Mudiay   | PG       | Denver Nuggets | 3.10224 |
| Darrell Arthur    | PF       | Denver Nuggets | 2.814   |
| Jusuf Nurkic      | C        | Denver Nuggets | 1.842   |
| Joffrey Lauvergne | C        | Denver Nuggets | 1.70972 |

... (4 rows omitted)

### Multiple features

You can access rows that have multiple specified features, by using
`where` repeatedly. For example, here is a way to extract all the Point
Guards whose salaries were over $\$15$ million.

``` python
nba.where('Position', 'PG').where('Salary', are.above(15))
```

| Player            | Position | Team                  | Salary  |
|-------------------|----------|-----------------------|---------|
| Derrick Rose      | PG       | Chicago Bulls         | 20.0931 |
| Kyrie Irving      | PG       | Cleveland Cavaliers   | 16.4075 |
| Chris Paul        | PG       | Los Angeles Clippers  | 21.4687 |
| Russell Westbrook | PG       | Oklahoma City Thunder | 16.7442 |
| John Wall         | PG       | Washington Wizards    | 15.852  |


### General form

By now you will have realized that the general way to create a new table
by selecting rows with a given feature is to use `where` and `are` with
the appropriate condition:

`original_table_name.where(column_label_string, are.condition)`

``` python
nba.where('Salary', are.between(10, 10.3))
```

| Player         | Position | Team               | Salary  |
|----------------|----------|--------------------|---------|
| Luol Deng      | SF       | Miami Heat         | 10.1516 |
| Gerald Wallace | SF       | Philadelphia 76ers | 10.1059 |
| Danny Green    | SG       | San Antonio Spurs  | 10      |
| DeMar DeRozan  | SG       | Toronto Raptors    | 10.05   |


Notice that the table above includes Danny Green who made $\$10$
million, but *not* Monta Ellis who made $\$10.3$ million. As elsewhere
in Python, the range `between` includes the left end but not the right.

If we specify a condition that isn't satisfied by any row, we get a
table with column labels but no rows.

``` python
nba.where('Player', are.equal_to('Barack Obama'))
```

| Player | Position |  Team | Salary |
|--------|----------|------|--------|

### Some more conditions

Here are some predicates of `are` that you might find useful. Note that
`x` and `y` are numbers, `STRING` is a string, and `Z` is either a
number or a string; you have to specify these depending on the feature
you want.

| Predicate                       | Description                                                 |
|---------------------------------|-------------------------------------------------------------|
| `are.equal_to(Z)`               | Equal to `Z`                                                |
| `are.above(x)`                  | Greater than `x`                                            |
| `are.above_or_equal_to(x)`      | Greater than or equal to `x`                                |
| `are.below(x)`                  | Less than `x`                                               |
| `are.below_or_equal_to(x)`      | Less than or equal to `x`                                   |
| `are.between(x, y)`             | Greater than or equal to `x`, and less than `y`             |
| `are.strictly_between(x, y)`    | Greater than `x` and less than `y`                          |
| `are.between_or_equal_to(x, y)` | Greater than or equal to `x`, and less than or equal to `y` |
| `are.containing(S)`             | Contains the string `S`                                     |

You can also specify the negation of any of these conditions, by using
`.not_` before the condition:

| Predicate             | Description      |
|-----------------------|------------------|
| `are.not_equal_to(Z)` | Not equal to `Z` |
| `are.not_above(x)`    | Not above `x`    |

... and so on. The usual rules of logic apply -- for example, "not above
x" is the same as "below or equal to x".

We end the section with a series of examples.

The use of `are.containing` can help save some typing. For example, you
can just specify `Warriors` instead of `Golden State Warriors`:

``` python
nba.where('Team', are.containing('Warriors')).show()
```

| Player            | Position | Team                  | Salary   |
|-------------------|----------|-----------------------|----------|
| Klay Thompson     | SG       | Golden State Warriors | 15.501   |
| Draymond Green    | PF       | Golden State Warriors | 14.2609  |
| Andrew Bogut      | C        | Golden State Warriors | 13.8     |
| Andre Iguodala    | SF       | Golden State Warriors | 11.7105  |
| Stephen Curry     | PG       | Golden State Warriors | 11.3708  |
| Jason Thompson    | PF       | Golden State Warriors | 7.00847  |
| Shaun Livingston  | PG       | Golden State Warriors | 5.54373  |
| Harrison Barnes   | SF       | Golden State Warriors | 3.8734   |
| Marreese Speights | C        | Golden State Warriors | 3.815    |
| Leandro Barbosa   | SG       | Golden State Warriors | 2.5      |
| Festus Ezeli      | C        | Golden State Warriors | 2.00875  |
| Brandon Rush      | SF       | Golden State Warriors | 1.27096  |
| Kevon Looney      | SF       | Golden State Warriors | 1.13196  |
| Anderson Varejao  | PF       | Golden State Warriors | 0.289755 |

You can extract data for all the guards, both Point Guards and Shooting
Guards:

``` python
nba.where('Position', are.containing('G'))
```

| Player           | Position | Team           | Salary   |
|------------------|----------|----------------|----------|
| Jeff Teague      | PG       | Atlanta Hawks  | 8        |
| Kyle Korver      | SG       | Atlanta Hawks  | 5.74648  |
| Dennis Schroder  | PG       | Atlanta Hawks  | 1.7634   |
| Tim Hardaway Jr. | SG       | Atlanta Hawks  | 1.30452  |
| Jason Richardson | SG       | Atlanta Hawks  | 0.947276 |
| Lamar Patterson  | SG       | Atlanta Hawks  | 0.525093 |
| Terran Petteway  | SG       | Atlanta Hawks  | 0.525093 |
| Avery Bradley    | PG       | Boston Celtics | 7.73034  |
| Isaiah Thomas    | PG       | Boston Celtics | 6.91287  |
| Marcus Smart     | PG       | Boston Celtics | 3.43104  |


... (171 rows omitted)

You can get all the players who were not Cleveland Cavaliers and had a
salary of no less than $\$20$ million:

``` python
other_than_Cavs = nba.where('Team', are.not_equal_to('Cleveland Cavaliers'))
other_than_Cavs.where('Salary', are.not_below(20))
```

| Player          | Position | Team                  | Salary  |
|-----------------|----------|-----------------------|---------|
| Carmelo Anthony | SF       | New York Knicks       | 22.875  |
| Chris Bosh      | PF       | Miami Heat            | 22.1927 |
| Chris Paul      | PG       | Los Angeles Clippers  | 21.4687 |
| Derrick Rose    | PG       | Chicago Bulls         | 20.0931 |
| Dwight Howard   | C        | Houston Rockets       | 22.3594 |
| Dwyane Wade     | SG       | Miami Heat            | 20      |
| Joe Johnson     | SF       | Brooklyn Nets         | 24.8949 |
| Kevin Durant    | SF       | Oklahoma City Thunder | 20.1586 |
| Kobe Bryant     | SF       | Los Angeles Lakers    | 25      |

The same table can be created in many ways. Here is another, and no
doubt you can think of more.

``` python
other_than_Cavs.where('Salary', are.above_or_equal_to(20))
```

| Player          | Position | Team                  | Salary  |
|-----------------|----------|-----------------------|---------|
| Joe Johnson     | SF       | Brooklyn Nets         | 24.8949 |
| Derrick Rose    | PG       | Chicago Bulls         | 20.0931 |
| Dwight Howard   | C        | Houston Rockets       | 22.3594 |
| Chris Paul      | PG       | Los Angeles Clippers  | 21.4687 |
| Kobe Bryant     | SF       | Los Angeles Lakers    | 25      |
| Chris Bosh      | PF       | Miami Heat            | 22.1927 |
| Dwyane Wade     | SG       | Miami Heat            | 20      |
| Carmelo Anthony | SF       | New York Knicks       | 22.875  |
| Kevin Durant    | SF       | Oklahoma City Thunder | 20.1586 |

As you can see, the use of `where` with `are` gives you great
flexibility in accessing rows with features that interest you. Don't hesitate to experiment!

## Check your knowledge

Select one of the following table commands with a description of its effect. Assume that it is a table that has already been loaded.