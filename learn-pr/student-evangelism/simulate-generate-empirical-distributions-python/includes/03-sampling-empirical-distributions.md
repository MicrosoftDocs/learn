``` {.python}

from datascience import *
path_data = '../../../data/'
import numpy as np
import matplotlib.pyplot as plots
plots.style.use('fivethirtyeight')
%matplotlib inline
```

An important part of data science consists of making conclusions based
on the data in random samples. In order to correctly interpret their
results, data scientists have to first understand exactly what random
samples are.

In this chapter we will take a more careful look at sampling, with
special attention to the properties of large random samples.

Let's start by drawing some samples. Our examples are based on the
imdb data set.

``` {.python}
top1 = Table.read_table(path_data + 'top_movies.csv')
top2 = top1.with_column('Row Index', np.arange(top1.num_rows))
top = top2.move_to_start('Row Index')

top.set_format(make_array(3, 4), NumberFormatter)
```

|Row Index|Title|Studio|Gross|Gross (Adjusted)|Year|
|--- |--- |--- |--- |--- |--- |
|0|Star Wars: The Force Awakens|Buena Vista (Disney)|906,723,418|906,723,400|2015|
|1|Avatar|Fox|760,507,625|846,120,800|2009|
|2|Titanic|Paramount|658,672,302|1,178,627,900|1997|
|3|Jurassic World|Universal|652,270,625|687,728,000|2015|
|4|Marvel's The Avengers|Buena Vista (Disney)|623,357,910|668,866,600|2012|
|5|The Dark Knight|Warner Bros.|534,858,444|647,761,600|2008|
|6|Star Wars: Episode I - The Phantom Menace|Fox|474,544,677|785,715,000|1999|
|7|Star Wars|Fox|460,998,007|1,549,640,500|1977|
|8|Avengers: Age of Ultron|Buena Vista (Disney)|459,005,868|465,684,200|2015|
|9|The Dark Knight Rises|Warner Bros.|448,139,099|500,961,700|2012|

... (190 rows omitted)

### Sampling Rows of a Table

Each row of a data table represents an individual; in `top`, each
individual is a movie. Sampling individuals can thus be achieved by
sampling the rows of a table.

The contents of a row are the values of different variables measured on
the same individual. So the contents of the sampled rows form samples of
values of each of the variables.

### Deterministic Samples

When you simply specify which elements of a set you want to choose,
without any chances involved, you create a *deterministic sample*.

You have done this many times, for example by using `take`:

``` {.python}
top.take(make_array(3, 18, 100))
```

|Row Index|Title|Studio|Gross|Gross (Adjusted)|Year|
|--- |--- |--- |--- |--- |--- |
|3|Jurassic World|Universal|652,270,625|687,728,000|2015|
|18|Spider-Man|Sony|403,706,375|604,517,300|2002|
|100|Gone with the Wind|MGM|198,676,459|1,757,788,200|1939|

You have also used `where`:

``` {.python}
top.where('Title', are.containing('Harry Potter'))
```

|Row Index|Title|Studio|Gross|Gross (Adjusted)|Year|
|--- |--- |--- |--- |--- |--- |
|22|Harry Potter and the Deathly Hallows Part 2|Warner Bros.|381,011,219|417,512,200|2011|
|43|Harry Potter and the Sorcerer's Stone|Warner Bros.|317,575,550|486,442,900|2001|
|54|Harry Potter and the Half-Blood Prince|Warner Bros.|301,959,197|352,098,800|2009|
|59|Harry Potter and the Order of the Phoenix|Warner Bros.|292,004,738|369,250,200|2007|
|62|Harry Potter and the Goblet of Fire|Warner Bros.|290,013,036|393,024,800|2005|
|69|Harry Potter and the Chamber of Secrets|Warner Bros.|261,988,482|390,768,100|2002|
|76|Harry Potter and the Prisoner of Azkaban|Warner Bros.|249,541,069|349,598,600|2004|

While these are samples, they are not random samples. They don't involve
chance.

## Probability Samples

For describing random samples, some terminology will be helpful.

A *population* is the set of all elements from whom a sample will be
drawn.

A *probability sample* is one for which it is possible to calculate,
before the sample is drawn, the chance with which any subset of elements
will enter the sample.

In a probability sample, all elements need not have the same chance of
being chosen.

### A Random Sampling Scheme

For example, suppose you choose two people from a population that
consists of three people A, B, and C, according to the following scheme:

- Person A is chosen with probability 1.
- One of Persons B or C is chosen according to the toss of a coin: if
    the coin lands heads, you choose B, and if it lands tails you
    choose C.

This is a probability sample of size 2. Here are the chances of entry
for all non-empty subsets:

- A: 1
- B: 1/2
- C: 1/2
- AB: 1/2
- AC: 1/2
- BC: 0
- ABC: 0

Person A has a higher chance of being selected than Persons B or C;
indeed, Person A is certain to be selected. Since these differences are
known and quantified, they can be taken into account when working with
the sample.

### A Systematic Sample

Imagine all the elements of the population listed in a sequence. One
method of sampling starts by choosing a random position early in the
list, and then evenly spaced positions after that. The sample consists
of the elements in those positions. Such a sample is called a
*systematic sample*.

Here we will choose a systematic sample of the rows of `top`. We will
start by picking one of the first 10 rows at random, and then we will
pick every 10th row after that.

``` {.python}
"""Choose a random start among rows 0 through 9;
then take every 10th row."""

start = np.random.choice(np.arange(10))
top.take(np.arange(start, top.num_rows, 10))
```

|Row Index|Title|Studio|Gross|Gross (Adjusted)|Year|
|--- |--- |--- |--- |--- |--- |
|2|Titanic|Paramount|658,672,302|1,178,627,900|1997|
|12|The Hunger Games: Catching Fire|Lionsgate|424,668,047|444,697,400|2013|
|22|Harry Potter and the Deathly Hallows Part 2|Warner Bros.|381,011,219|417,512,200|2011|
|32|American Sniper|Warner Bros.|350,126,372|374,796,000|2014|
|42|Iron Man|Paramount|318,412,101|385,808,100|2008|
|52|Skyfall|Sony|304,360,277|329,225,400|2012|
|62|Harry Potter and the Goblet of Fire|Warner Bros.|290,013,036|393,024,800|2005|
|72|Jaws|Universal|260,000,000|1,114,285,700|1975|
|82|Twister|Warner Bros.|241,721,524|475,786,700|1996|
|92|Ghost|Paramount|217,631,306|447,747,400|1990|

... (10 rows omitted)

Run the cell a few times to see how the output varies.

This systematic sample is a probability sample. In this scheme, all rows
have chance $1/10$ of being chosen. For example, Row 23 is chosen if and
only if Row 3 is chosen, and the chance of that is $1/10$.

But not all subsets have the same chance of being chosen. Because the
selected rows are evenly spaced, most subsets of rows have no chance of
being chosen. The only subsets that are possible are those that consist
of rows all separated by multiples of 10. Any of those subsets is
selected with chance 1/10. Other subsets, like the subset containing the
first 11 rows of the table, are selected with chance 0.

### Random Samples Drawn With or Without Replacement

In this course, we will mostly deal with the two most straightforward
methods of sampling.

The first is random sampling with replacement, which (as we have seen
earlier) is the default behavior of `np.random.choice` when it samples
from an array.

The other, called a "simple random sample", is a sample drawn at random
*without* replacement. Sampled individuals are not replaced in the
population before the next individual is drawn. This is the kind of
sampling that happens when you deal a hand from a deck of cards, for
example.

In this chapter, we will use simulation to study the behavior of large
samples drawn at random with or without replacement.

Drawing a random sample requires care and precision. It is not
haphazard, even though that is a colloquial meaning of the word
"random". If you stand at a street corner and take as your sample the
first ten people who pass by, you might think you're sampling at random
because you didn't choose who walked by. But it's not a random sample --
it's a *sample of convenience*. You didn't know ahead of time the
probability of each person entering the sample; perhaps you hadn't even
specified exactly who was in the population.
