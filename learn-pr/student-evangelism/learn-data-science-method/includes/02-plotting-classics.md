``` {.python}
from datascience import *
from datascience.predicates import are
path_data = '../../../../data/'
import numpy as np
import matplotlib
matplotlib.use('Agg', warn=False)
%matplotlib inline
import matplotlib.pyplot as plots
plots.style.use('fivethirtyeight')
import warnings
warnings.simplefilter(action="ignore", category=FutureWarning)

from urllib.request import urlopen
import re
def read_url(url):
    return re.sub('\\s+', ' ', urlopen(url).read().decode())
```

In this example, we will explore statistics for two classic novels: *The
Adventures of Huckleberry Finn* by Mark Twain, and *Little Women* by
Louisa May Alcott. The text of any book can be read by a computer at
great speed. Books published before 1923 are currently in the *public
domain*, meaning that everyone has the right to copy or use the text in
any way. [Project Gutenberg](http://www.gutenberg.org/) is a website
that publishes public domain books online. Using Python, we can load the
text of these books directly from the web.

This example is meant to illustrate some of the broad themes of this
text. Don't worry if the details of the program don't yet make sense.
Instead, focus on interpreting the images generated below. Later
sections of the text will describe most of the features of the Python
programming language used below.

First, we read the text of both books into lists of chapters, called
`huck_finn_chapters` and `little_women_chapters`. In Python, a name
cannot contain any spaces, and so we will often use an underscore `_` to
stand in for a space. The `=` in the lines below give a name on the left
to the result of some computation described on the right. A *uniform
resource locator* or *URL* is an address on the Internet for some
content; in this case, the text of a book. The `#` symbol starts a
comment, which is ignored by the computer but helpful for people reading
the code.

``` {.python}
# Read two books, fast!

huck_finn_url = 'https://www.inferentialthinking.com/data/huck_finn.txt'
huck_finn_text = read_url(huck_finn_url)
huck_finn_chapters = huck_finn_text.split('CHAPTER ')[44:]

little_women_url = 'https://www.inferentialthinking.com/data/little_women.txt'
little_women_text = read_url(little_women_url)
little_women_chapters = little_women_text.split('CHAPTER ')[1:]
```

While a computer cannot understand the text of a book, it can provide us
with some insight into the structure of the text. The name
`huck_finn_chapters` is currently bound to a list of all the chapters in
the book. We can place them into a table to see how each chapter begins.

``` {.python}
# Display the chapters of Huckleberry Finn in a table.

Table().with_column('Chapters', huck_finn_chapters)
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
Chapters
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
I. YOU don't know about me without you have read a book ...
</td>
</tr>
<tr>
<td>
II. WE went tiptoeing along a path amongst the trees bac ...
    </td>
        </tr>
        <tr>
            <td>III. WELL, I got a good going-over in the morning from o ...</td>
        </tr>
        <tr>
            <td>IV. WELL, three or four months run along, and it was wel ...</td>
        </tr>
        <tr>
            <td>V. I had shut the door to. Then I turned around and ther ...</td>
        </tr>
        <tr>
            <td>VI. WELL, pretty soon the old man was up and around agai ...</td>
        </tr>
        <tr>
            <td>VII. "GIT up! What you 'bout?" I opened my eyes and look ...</td>
        </tr>
        <tr>
            <td>VIII. THE sun was up so high when I waked that I judged  ...</td>
        </tr>
        <tr>
            <td>IX. I wanted to go and look at a place right about the m ...</td>
        </tr>
        <tr>
            <td>X. AFTER breakfast I wanted to talk about the dead man a ...</td>
        </tr>

    </tbody>
    </table>
    <p>
    ... (33 rows omitted)
    </p>

Each chapter begins with a chapter number in Roman numerals, followed by
the first sentence of the chapter. Project Gutenberg has printed the
first word of each chapter in upper case.

``` {.python}
from datascience import *
import numpy as np
path_data = '../../../../../data/'
import matplotlib
matplotlib.use('Agg', warn=False)
%matplotlib inline
import matplotlib.pyplot as plots
plots.style.use('fivethirtyeight')
import warnings
warnings.simplefilter(action="ignore", category=FutureWarning)

from urllib.request import urlopen
import re
def read_url(url):
    return re.sub('\\s+', ' ', urlopen(url).read().decode())
```

``` {.python}

# Read two books, fast (again)!

huck_finn_path = path_data + 'huck_finn.txt'
with open(huck_finn_path, 'r') as ff:
    huck_finn_text = ff.read()
huck_finn_chapters = huck_finn_text.split('CHAPTER ')[44:]

little_women_path = path_data + 'little_women.txt'
with open(little_women_path, 'r') as ff:
    little_women_text = ff.read()
little_women_chapters = little_women_text.split('CHAPTER ')[1:]
```

## Literary Characters

*The Adventures of Huckleberry Finn* describes a journey that Huck and
Jim take along the Mississippi River. Tom Sawyer joins them towards the
end as the action heats up. Having loaded the text, we can quickly
visualize how many times these characters have each been mentioned at
any point in the book.

``` {.python}
# Count how many times the names Jim, Tom, and Huck appear in each chapter.

counts = Table().with_columns([
        'Jim', np.char.count(huck_finn_chapters, 'Jim'),
        'Tom', np.char.count(huck_finn_chapters, 'Tom'),
        'Huck', np.char.count(huck_finn_chapters, 'Huck')
    ])

# Plot the cumulative counts:
# how many times in Chapter 1, how many times in Chapters 1 and 2, and so on.

cum_counts = counts.cumsum().with_column('Chapter', np.arange(1, 44, 1))
cum_counts.plot(column_for_xticks=3)
plots.title('Cumulative Number of Times Each Name Appears', y=1.08);
```

![png](../media/5-literary-characters-3-0.png)

In the plot above, the horizontal axis shows chapter numbers and the
vertical axis shows how many times each character has been mentioned up
to and including that chapter.

You can see that Jim is a central character by the large number of times
his name appears. Notice how Tom is hardly mentioned for much of the
book until he arrives and joins Huck and Jim, after Chapter 30. His
curve and Jim's rise sharply at that point, as the action involving both
of them intensifies. As for Huck, his name hardly appears at all,
because he is the narrator.

*Little Women* is a story of four sisters growing up together during the
civil war. In this book, chapter numbers are spelled out and chapter
titles are written in all capital letters.

``` {.python}
# The chapters of Little Women, in a table

Table().with_column('Chapters', little_women_chapters)
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
Chapters
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
ONE

PLAYING PILGRIMS

\"Christmas won't be Christmas wit ...
</td>
</tr>
<tr>
<td>
TWO

A MERRY CHRISTMAS

Jo was the first to wake in the ...
</td>
</tr>
<tr>
<td>
THREE

THE LAURENCE BOY

"Jo! Jo! Where are you?" crie ...
</td>
</tr>
<tr>
<td>
FOUR

BURDENS

\"Oh, dear, how hard it does seem to take ...
</td>
</tr>
<tr>
<td>
FIVE

BEING NEIGHBORLY

\"What in the world are you going ...
</td>
</tr>
<tr>
<td>
SIX

BETH FINDS THE PALACE BEAUTIFUL

The big house did ...
</td>
</tr>
<tr>
<td>
SEVEN

AMY'S VALLEY OF HUMILIATION

\"That boy is a perfe ...
</td>
</tr>
<tr>
<td>
EIGHT

JO MEETS APOLLYON

"Girls, where are you going?" ...
</td>
</tr>
<tr>
<td>
NINE

MEG GOES TO VANITY FAIR

\"I do think it was the mo ...
</td>
</tr>
<tr>
<td>
TEN

THE P.C. AND P.O.

As spring came on, a new set of ...
</td>
</tr>
</tbody>
</table>
<p>
... (37 rows omitted)
</p>
We can track the mentions of main characters to learn about the plot of
this book as well. The protagonist Jo interacts with her sisters Meg,
Beth, and Amy regularly, up until Chapter 27 when she moves to New York
alone.

``` {.python}
# Counts of names in the chapters of Little Women

counts = Table().with_columns([
        'Amy', np.char.count(little_women_chapters, 'Amy'),
        'Beth', np.char.count(little_women_chapters, 'Beth'),
        'Jo', np.char.count(little_women_chapters, 'Jo'),
        'Meg', np.char.count(little_women_chapters, 'Meg'),
        'Laurie', np.char.count(little_women_chapters, 'Laurie'),

    ])

# Plot the cumulative counts.

cum_counts = counts.cumsum().with_column('Chapter', np.arange(1, 48, 1))
cum_counts.plot(column_for_xticks=5)
plots.title('Cumulative Number of Times Each Name Appears', y=1.08);
```

![png](../media/5-literary-characters-8-0.png)

Laurie is a young man who marries one of the girls in the end. See if
you can use the plots to guess which one.

``` {.python}
from datascience import *
import numpy as np
path_data = '../../../../../data/'
import matplotlib
matplotlib.use('Agg', warn=False)
%matplotlib inline
import matplotlib.pyplot as plots
plots.style.use('fivethirtyeight')
import warnings
warnings.simplefilter(action="ignore", category=FutureWarning)

from urllib.request import urlopen
import re
def read_url(url):
    return re.sub('\\s+', ' ', urlopen(url).read().decode())
```

``` {.python}

# Read two books, fast (again)!

huck_finn_url = 'https://www.inferentialthinking.com/data/huck_finn.txt'
huck_finn_text = read_url(huck_finn_url)
huck_finn_chapters = huck_finn_text.split('CHAPTER ')[44:]

little_women_url = 'https://www.inferentialthinking.com/data/little_women.txt'
little_women_text = read_url(little_women_url)
little_women_chapters = little_women_text.split('CHAPTER ')[1:]
```

## Another Kind of Character

In some situations, the relationships between quantities allow us to
make predictions. This text will explore how to make accurate
predictions based on incomplete information and develop methods for
combining multiple sources of uncertain information to make decisions.

As an example of visualizing information derived from multiple sources,
let us first use the computer to get some information that would be
tedious to acquire by hand. In the context of novels, the word
"character" has a second meaning: a printed symbol such as a letter or
number or punctuation symbol. Here, we ask the computer to count the
number of characters and the number of periods in each chapter of both
*Huckleberry Finn* and *Little Women*.

``` {.python}
# In each chapter, count the number of all characters;
# call this the "length" of the chapter.
# Also count the number of periods.

chars_periods_huck_finn = Table().with_columns([
        'Huck Finn Chapter Length', [len(s) for s in huck_finn_chapters],
        'Number of Periods', np.char.count(huck_finn_chapters, '.')
    ])
chars_periods_little_women = Table().with_columns([
        'Little Women Chapter Length', [len(s) for s in little_women_chapters],
        'Number of Periods', np.char.count(little_women_chapters, '.')
    ])
```

Here are the data for *Huckleberry Finn*. Each row of the table
corresponds to one chapter of the novel and displays the number of
characters as well as the number of periods in the chapter. Not
surprisingly, chapters with fewer characters also tend to have fewer
periods, in general: the shorter the chapter, the fewer sentences there
tend to be, and vice versa. The relation is not entirely predictable,
however, as sentences are of varying lengths and can involve other
punctuation such as question marks.

``` {.python}
chars_periods_huck_finn
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
Huck Finn Chapter Length
</th>
<th>
Number of Periods
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
7026
</td>
<td>
66
</td>
</tr>
<tr>
<td>
11982
</td>
<td>
117
</td>
</tr>
<tr>
<td>
8529
</td>
<td>
72
</td>
</tr>
<tr>
<td>
6799
</td>
<td>
84
</td>
</tr>
<tr>
<td>
8166
</td>
<td>
91
</td>
</tr>
<tr>
<td>
14550
</td>
<td>
125
</td>
</tr>
<tr>
<td>
13218
</td>
<td>
127
</td>
</tr>
<tr>
<td>
22208
</td>
<td>
249
</td>
</tr>
<tr>
<td>
8081
</td>
<td>
71
</td>
</tr>
<tr>
<td>
7036
</td>
<td>
70
</td>
</tr>
</tbody>
</table>
<p>
... (33 rows omitted)
</p>
Here are the corresponding data for *Little Women*.

``` {.python}
chars_periods_little_women
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
Little Women Chapter Length
</th>
<th>
Number of Periods
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
21759
</td>
<td>
189
</td>
</tr>
<tr>
<td>
22148
</td>
<td>
188
</td>
</tr>
<tr>
<td>
20558
</td>
<td>
231
</td>
</tr>
<tr>
<td>
25526
</td>
<td>
195
</td>
</tr>
<tr>
<td>
23395
</td>
<td>
255
</td>
</tr>
<tr>
<td>
14622
</td>
<td>
140
</td>
</tr>
<tr>
<td>
14431
</td>
<td>
131
</td>
</tr>
<tr>
<td>
22476
</td>
<td>
214
</td>
</tr>
<tr>
<td>
33767
</td>
<td>
337
</td>
</tr>
<tr>
<td>
18508
</td>
<td>
185
</td>
</tr>
</tbody>
</table>
<p>
... (37 rows omitted)
</p>
You can see that the chapters of *Little Women* are in general longer
than those of *Huckleberry Finn*. Let us see if these two simple
variables--the length and number of periods in each chapter--can
tell us anything more about the two books. One way to do this is to plot
both sets of data on the same axes.

In the plot below, there is a dot for each chapter in each book. Blue
dots correspond to *Huckleberry Finn* and gold dots to *Little Women*.
The horizontal axis represents the number of periods and the vertical
axis represents the number of characters.

``` {.python}
plots.figure(figsize=(6, 6))
plots.scatter(chars_periods_huck_finn.column(1),
              chars_periods_huck_finn.column(0),
              color='darkblue')
plots.scatter(chars_periods_little_women.column(1),
              chars_periods_little_women.column(0),
              color='gold')
plots.xlabel('Number of periods in chapter')
plots.ylabel('Number of characters in chapter');
```

![png](../media/6-another-kind-character-9-0.png)

The plot shows us that many but not all of the chapters of *Little
Women* are longer than those of *Huckleberry Finn*, as we had observed
by just looking at the numbers. But it also shows us something more.
Notice how the blue points are roughly clustered around a straight line,
as are the yellow points. Moreover, it looks as though both colors of
points might be clustered around the *same* straight line.

Now look at all the chapters that contain about 100 periods. The plot
shows that those chapters contain about 10,000 characters to about
15,000 characters, roughly. That's about 100 to 150 characters per
period.

Indeed, it appears from looking at the plot that on average both books
tend to have somewhere between 100 and 150 characters between periods,
as a rough estimate. Perhaps these two great 19th century novels
were signaling something so familiar to us now: the 140-character
limit of Twitter.
