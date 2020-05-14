"The NBA is the highest paying professional sports league in the world,"
[reported
CNN](http://edition.cnn.com/2015/12/04/sport/gallery/highest-paid-nba-players/)
in March 2016. The table `nba_salaries` contains the salaries of all
National Basketball Association players in 2015-2016.

Each row represents one player. The columns are:

``` python
from datascience import *
import numpy as np
path_data = '../../../../data/'
np.set_printoptions(threshold=50)
```

``` output
|                    |                                                      |
|--------------------|------------------------------------------------------|
| **Player**         | Player's name                                        |
| **Position**       | Player's position on team                            |
| **Team**           | Team name                                            |
| **'15-'16 Salary** | Player's salary in 2015-2016, in millions of dollars |
```

The code for the positions is PG (Point Guard), SG (Shooting Guard), PF
(Power Forward), SF (Small Forward), and C (Center). But what follows
doesn't involve details about how basketball is played.

The first row shows that Paul Millsap, Power Forward for the Atlanta
Hawks, had a salary of almost $18.7 million in 2015-2016.

``` python
# This table can be found online: https://www.statcrunch.com/app/index.php?dataid=1843341
nba_salaries = Table.read_table(path_data + 'nba_salaries.csv')
nba_salaries
```

``` output
| Player           | Position | Team          | '15-'16 Salary |
|------------------|----------|---------------|----------------|
| Paul Millsap     | PF       | Atlanta Hawks | 18.6717        |
| Al Horford       | C        | Atlanta Hawks | 12             |
| Tiago Splitter   | C        | Atlanta Hawks | 9.75625        |
| Jeff Teague      | PG       | Atlanta Hawks | 8              |
| Kyle Korver      | SG       | Atlanta Hawks | 5.74648        |
| Thabo Sefolosha  | SF       | Atlanta Hawks | 4              |
| Mike Scott       | PF       | Atlanta Hawks | 3.33333        |
| Kent Bazemore    | SF       | Atlanta Hawks | 2              |
| Dennis Schroder  | PG       | Atlanta Hawks | 1.7634         |
| Tim Hardaway Jr. | SG       | Atlanta Hawks | 1.30452        |  


... (407 rows omitted)
```

The table contains 417 rows, one for each player. Only 10 of the rows
are displayed. The `show` method allows us to specify the number of
rows, with the default (no specification) being all the rows of the
table.

``` python
nba_salaries.show(3)
```

``` output
| Player         | Position | Team          | '15-'16 Salary |
|----------------|----------|---------------|----------------|
| Paul Millsap   | PF       | Atlanta Hawks | 18.6717        |
| Al Horford     | C        | Atlanta Hawks | 12             |
| Tiago Splitter | C        | Atlanta Hawks | 9.75625        |  


... (414 rows omitted)
```

Glance through about 20 rows or so, and you will see that the rows are
in alphabetical order by team name. It's also possible to list the same
rows in alphabetical order by player name using the `sort` method. The
argument to `sort` is a column label or index.

``` python
nba_salaries.sort('Player').show(5)
```

``` output
| Player         | Position | Team                   | '15-'16 Salary |
|----------------|----------|------------------------|----------------|
| Aaron Brooks   | PG       | Chicago Bulls          | 2.25           |
| Aaron Gordon   | PF       | Orlando Magic          | 4.17168        |
| Aaron Harrison | SG       | Charlotte Hornets      | 0.525093       |
| Adreian Payne  | PF       | Minnesota Timberwolves | 1.93884        |
| Al Horford     | C        | Atlanta Hawks          | 12             |  


... (412 rows omitted)
```

To examine the players' salaries, it would be much more helpful if the
data were ordered by salary.

To do this, we will first simplify the label of the column of salaries
(just for convenience), and then sort by the new label `Salary`.

This arranges all the rows of the table in *increasing* order of salary,
with the lowest salary appearing first. The output is a new table with
the same columns as the original but with the rows rearranged.

``` python
nba = nba_salaries.relabeled("'15-'16 Salary", 'Salary')
nba.sort('Salary')
```

``` output
| Player                 | Position | Team                 | Salary   |
|------------------------|----------|----------------------|----------|
| Thanasis Antetokounmpo | SF       | New York Knicks      | 0.030888 |
| Jordan McRae           | SG       | Phoenix Suns         | 0.049709 |
| Cory Jefferson         | PF       | Phoenix Suns         | 0.049709 |
| Elliot Williams        | SG       | Memphis Grizzlies    | 0.055722 |
| Orlando Johnson        | SG       | Phoenix Suns         | 0.055722 |
| Phil Pressey           | PG       | Phoenix Suns         | 0.055722 |
| Keith Appling          | PG       | Orlando Magic        | 0.061776 |
| Sean Kilpatrick        | SG       | Denver Nuggets       | 0.099418 |
| Erick Green            | PG       | Utah Jazz            | 0.099418 |
| Jeff Ayres             | PF       | Los Angeles Clippers | 0.111444 |  

... (407 rows omitted)
```

These figures are somewhat difficult to compare as some of these players
changed teams during the season and received salaries from more than one
team; only the salary from the last team appears in the table. Point
Guard Phil Pressey, for example, moved from Philadelphia to Phoenix
during the year, and might be moving yet again to the Golden State
Warriors.

The CNN report is about the other end of the salary scale -- the players
who are among the highest paid in the world.

To order the rows of the table in *decreasing* order of salary, we must
use `sort` with the option `descending=True`.

``` python
nba.sort('Salary', descending=True)
```

``` output
| Player          | Position | Team                  | Salary  |
|-----------------|----------|-----------------------|---------|
| Kobe Bryant     | SF       | Los Angeles Lakers    | 25      |
| Joe Johnson     | SF       | Brooklyn Nets         | 24.8949 |
| LeBron James    | SF       | Cleveland Cavaliers   | 22.9705 |
| Carmelo Anthony | SF       | New York Knicks       | 22.875  |
| Dwight Howard   | C        | Houston Rockets       | 22.3594 |
| Chris Bosh      | PF       | Miami Heat            | 22.1927 |
| Chris Paul      | PG       | Los Angeles Clippers  | 21.4687 |
| Kevin Durant    | SF       | Oklahoma City Thunder | 20.1586 |
| Derrick Rose    | PG       | Chicago Bulls         | 20.0931 |
| Dwyane Wade     | SG       | Miami Heat            | 20      |  

... (407 rows omitted)
```

Kobe Bryant, in his final season with the Lakers, was the highest paid
at a salary of $25 million. Notice that the MVP Stephen Curry doesn't
appear among the top 10. He is quite a bit further down the list, as we
will see later.

### Named arguments

The `descending=True` portion of this call expression is called a *named
argument*. When a function or method is called, each argument has both a
position and a name. Both are evident from the help text of a function
or method.

``` python
help(nba.sort)
```

``` python
  Help on method sort in module datascience.tables:
 
  sort(column_or_label, descending=False, distinct=False) method of datascience.tables.Table instance
      Return a Table of rows sorted according to the values in a column.
    
    Args:
        ``column_or_label``: the column whose values are used for sorting.
    
        ``descending``: if True, sorting will be in descending, rather than
            ascending order.
    
        ``distinct``: if True, repeated values in ``column_or_label`` will
            be omitted.
    
    Returns:
        An instance of ``Table`` containing rows sorted based on the values
        in ``column_or_label``.
    
    >>> marbles = Table().with_columns(
    ...    "Color", make_array("Red", "Green", "Blue", "Red", "Green", "Green"),
    ...    "Shape", make_array("Round", "Rectangular", "Rectangular", "Round","Rectangular", "Round"),
    ...    "Amount", make_array(4, 6, 12, 7, 9, 2),
    ...    "Price", make_array(1.30, 1.30, 2.00, 1.75, 1.40, 1.00))
```

``` output

    >>> marbles
    Color | Shape       | Amount | Price
    Red   | Round       | 4      | 1.3
    Green | Rectangular | 6      | 1.3
    Blue  | Rectangular | 12     | 2
    Red   | Round       | 7      | 1.75
    Green | Rectangular | 9      | 1.4
    Green | Round       | 2      | 1
    >>> marbles.sort("Amount")
    Color | Shape       | Amount | Price
    Green | Round       | 2      | 1
    Red   | Round       | 4      | 1.3
    Green | Rectangular | 6      | 1.3
    Red   | Round       | 7      | 1.75
    Green | Rectangular | 9      | 1.4
    Blue  | Rectangular | 12     | 2
    >>> marbles.sort("Amount", descending = True)
    Color | Shape       | Amount | Price
    Blue  | Rectangular | 12     | 2
    Green | Rectangular | 9      | 1.4
    Red   | Round       | 7      | 1.75
    Green | Rectangular | 6      | 1.3
    Red   | Round       | 4      | 1.3
    Green | Round       | 2      | 1
    >>> marbles.sort(3) # the Price column
    Color | Shape       | Amount | Price
    Green | Round       | 2      | 1
    Red   | Round       | 4      | 1.3
    Green | Rectangular | 6      | 1.3
    Green | Rectangular | 9      | 1.4
    Red   | Round       | 7      | 1.75
    Blue  | Rectangular | 12     | 2
    >>> marbles.sort(3, distinct = True)
    Color | Shape       | Amount | Price
    Green | Round       | 2      | 1
    Red   | Round       | 4      | 1.3
    Green | Rectangular | 9      | 1.4
    Red   | Round       | 7      | 1.75
    Blue  | Rectangular | 12     | 2
  ```

At the very top of this `help` text, the *signature* of the `sort`
method appears:

``` python
sort(column\_or\_label, descending=False, distinct=False)
```

This describes the positions, names, and default values of the three
arguments to `sort`. When calling this method, you can use either
positional arguments or named arguments, so the following three calls do
exactly the same thing.

``` python
sort('Salary', True) sort('Salary', descending=True)
sort(column\_or\_label='Salary', descending=True)
```

When an argument is simply `True` or `False`, it's a useful convention
to include the argument name so that it's more obvious what the argument
value means.

## Check your knowledge

Suppose you have a table called students with columns labeled name, age, and email. Select the best table expression for the following statements.