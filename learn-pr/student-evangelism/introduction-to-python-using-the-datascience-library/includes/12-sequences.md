``` {.python}
from datascience import *
path_data = '../../../data/'
```

## Sequences

Values can be grouped together into collections, which allows
programmers to organize those values and refer to all of them with a
single name. By grouping values together, we can write code that
performs a computation on many pieces of data at once.

Calling the function `make_array` on several values places them into an
*array*, which is a kind of sequential collection. Below, we collect
four different temperatures into an array called `highs`. These are the
[estimated average daily high
temperatures](http://berkeleyearth.lbl.gov/regions/global-land) over all
land on Earth (in degrees Celsius) for the decades surrounding 1850,
1900, 1950, and 2000, respectively, expressed as deviations from the
average absolute high temperature between 1951 and 1980, which was 14.48
degrees.

``` {.python}
baseline_high = 14.48
highs = make_array(baseline_high - 0.880, baseline_high - 0.093,
                   baseline_high + 0.105, baseline_high + 0.684)
highs
```

    array([ 13.6  ,  14.387,  14.585,  15.164])

Collections allow us to pass multiple values into a function using a
single name. For instance, the `sum` function computes the sum of all
values in a collection, and the `len` function computes its length.
(That's the number of values we put in it.) Using them together, we can
compute the average of a collection.

``` {.python}
sum(highs)/len(highs)
```

    14.434000000000001

The complete chart of daily high and low temperatures appears below.

### Mean of Daily High Temperature

![Mean of Daily High
Temperature](http://berkeleyearth.lbl.gov/auto/Regional/TMAX/Figures/global-land-TMAX-Trend.png)

### Mean of Daily Low Temperature

![Mean of Daily Low
Temperature](http://berkeleyearth.lbl.gov/auto/Regional/TMIN/Figures/global-land-TMIN-Trend.png)

``` {.python}
from datascience import *
path_data = '../../../../data/'
```

## Arrays

While there are many kinds of collections in Python, we will work
primarily with arrays in this class. We've already seen that the
`make_array` function can be used to create arrays of numbers.

Arrays can also contain strings or other types of values, but a single
array can only contain a single kind of data. (It usually doesn't make
sense to group together unlike data anyway.) For example:

``` {.python}
english_parts_of_speech = make_array("noun", "pronoun", "verb", "adverb", "adjective", "conjunction", "preposition", "interjection")
english_parts_of_speech
```

    array(['noun', 'pronoun', 'verb', 'adverb', 'adjective', 'conjunction',
           'preposition', 'interjection'], dtype='<U12')

Returning to the temperature data, we create arrays of average daily
[high
temperatures](http://berkeleyearth.lbl.gov/auto/Regional/TMAX/Text/global-land-TMAX-Trend.txt)
for the decades surrounding 1850, 1900, 1950, and 2000.

``` {.python}
baseline_high = 14.48
highs = make_array(baseline_high - 0.880, 
                   baseline_high - 0.093,
                   baseline_high + 0.105, 
                   baseline_high + 0.684)
highs
```

    array([13.6  , 14.387, 14.585, 15.164])

Arrays can be used in arithmetic expressions to compute over their
contents. When an array is combined with a single number, that number is
combined with each element of the array. Therefore, we can convert all
of these temperatures to Fahrenheit by writing the familiar conversion
formula.

``` {.python}
(9/5) * highs + 32
```

    array([56.48  , 57.8966, 58.253 , 59.2952])

<img src="../media/array-arithmetic.png" />

Arrays also have *methods*, which are functions that operate on the
array values. The `mean` of a collection of numbers is its average
value: the sum divided by the length. Each pair of parentheses in the
examples below is part of a call expression; it's calling a function
with no arguments to perform a computation on the array called `highs`.

``` {.python}
highs.size
```

    4

``` {.python}
highs.sum()
```

    57.736000000000004

``` {.python}
highs.mean()
```

    14.434000000000001

#### Functions on Arrays

The `numpy` package, abbreviated `np` in programs, provides Python
programmers with convenient and powerful functions for creating and
manipulating arrays.

``` {.python}
import numpy as np
```

For example, the `diff` function computes the difference between each
adjacent pair of elements in an array. The first element of the `diff`
is the second element minus the first.

``` {.python}
np.diff(highs)
```

    array([0.787, 0.198, 0.579])

The [full Numpy reference](http://docs.scipy.org/doc/numpy/reference/)
lists these functions exhaustively, but only a small subset are used
commonly for data processing applications. These are grouped into
different packages within `np`. Learning this vocabulary is an important
part of learning the Python language, so refer back to this list often
as you work through examples and problems.

However, you **don't need to memorize these**. Use this as a reference.

Each of these functions takes an array as an argument and returns a
single value.

  ----------------------------------------------------------------------------
  **Function**         Description
  -------------------- -------------------------------------------------------
  `np.prod`            Multiply all elements together

  `np.sum`             Add all elements together

  `np.all`             Test whether all elements are true values (non-zero
                       numbers are true)

  `np.any`             Test whether any elements are true values (non-zero
                       numbers are true)

  `np.count_nonzero`   Count the number of non-zero elements
  ----------------------------------------------------------------------------

Each of these functions takes an array as an argument and returns an
array of values.

  -----------------------------------------------------------------------
  **Function**    Description
  --------------- -------------------------------------------------------
  `np.diff`       Difference between adjacent elements

  `np.round`      Round each number to the nearest integer (whole number)

  `np.cumprod`    A cumulative product: for each element, multiply all
                  elements so far

  `np.cumsum`     A cumulative sum: for each element, add all elements so
                  far

  `np.exp`        Exponentiate each element

  `np.log`        Take the natural logarithm of each element

  `np.sqrt`       Take the square root of each element

  `np.sort`       Sort the elements
  -----------------------------------------------------------------------

Each of these functions takes an array of strings and returns an array.

  ---------------------------------------------------------------------------
  **Function**          **Description**
  --------------------- -----------------------------------------------------
  `np.char.lower`       Lowercase each element

  `np.char.upper`       Uppercase each element

  `np.char.strip`       Remove spaces at the beginning or end of each element

  `np.char.isalpha`     Whether each element is only letters (no numbers or
                        symbols)

  `np.char.isnumeric`   Whether each element is only numeric (no letters)
  ---------------------------------------------------------------------------

Each of these functions takes both an array of strings and a *search
string*; each returns an array.

  ------------------------------------------------------------------------------
  **Function**           **Description**
  ---------------------- -------------------------------------------------------
  `np.char.count`        Count the number of times a search string appears among
                         the elements of an array

  `np.char.find`         The position within each element that a search string
                         is found first

  `np.char.rfind`        The position within each element that a search string
                         is found last

  `np.char.startswith`   Whether each element starts with the search string
  ------------------------------------------------------------------------------
------
---
------
