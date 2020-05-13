> [!NOTE]
> You can find an interactive version of this unit named **example-gender-ratio-in-the-us-population.ipynb** in your virtual environment

If you haven't set up your online Visual Studio Codespaces environment for the Learning Path "Foundations of Data Science", please refer to the first unit **Setup**

Open [Visual Studio Codespaces](https://online.visualstudio.com/environments)


``` python
from datascience import *
import numpy as np
path_data = '../../../../data/'
import matplotlib
matplotlib.use('Agg', warn=False)
%matplotlib inline
import matplotlib.pyplot as plots
plots.style.use('fivethirtyeight')

import warnings
warnings.simplefilter(action="ignore", category=FutureWarning)
```

``` python
# As of Jan 2017, this census file is online here: 
data = 'http://www2.census.gov/programs-surveys/popest/datasets/2010-2015/national/asrh/nc-est2015-agesex-res.csv'

# A local copy can be accessed here in case census.gov moves the file:
# data = path_data + 'nc-est2015-agesex-res.csv'

full_census_table = Table.read_table(data)
full_census_table

partial_census_table = full_census_table.select('SEX', 'AGE', 'POPESTIMATE2010', 'POPESTIMATE2014')
partial_census_table

us_pop = partial_census_table.relabeled('POPESTIMATE2010', '2010').relabeled('POPESTIMATE2014', '2014')
```

## Example: Trends in Gender

We are now equipped with enough coding skills to examine features and
trends in subgroups of the United States population. In this example, we will
look at the distribution of males and females across age groups. We will
continue using the `us_pop` table from the previous section.

``` python
us_pop
```

|SEX|AGE|2010|2014|
|--- |--- |--- |--- |
|0|0|3951330|3949775|
|0|1|3957888|3949776|
|0|2|4090862|3959664|
|0|3|4111920|4007079|
|0|4|4077551|4005716|
|0|5|4064653|4006900|
|0|6|4073013|4135930|
|0|7|4043046|4155326|
|0|8|4025604|4120903|
|0|9|4125415|4108349|

... (296 rows omitted)

As we know from having examined this dataset earlier, a [description of
the
table](http://www2.census.gov/programs-surveys/popest/datasets/2010-2015/national/asrh/nc-est2015-agesex-res.pdf)
appears online. Here is a reminder of what the table contains.

Each row represents an age group. The `SEX` column contains numeric
codes: `0` stands for the total, `1` for male, and `2` for female. The
`AGE` column contains ages in completed years, but the special value
`999` represents the entire population regardless of age. The rest of
the columns contain estimates of the US population.

### Understanding `AGE` = 100

As a preliminary, let's interpret data in the final age category in the
table, where `AGE` is 100. The code below extracts the rows for the
combined group of men and women (`SEX` code 0) for the highest ages.

``` python
us_pop.where('SEX', are.equal_to(0)).where('AGE', are.between(97, 101))
```

|SEX|AGE|2010|2014|
|--- |--- |--- |--- |
|0|97|68893|83089|
|0|98|47037|59726|
|0|99|32178|41468|
|0|100|54410|71626|

Not surprisingly, the numbers of people are smaller at higher ages --
for example, there are fewer 99-year-olds than 98-year-olds.

It does come as a surprise, though, that the numbers for `AGE` 100 are
quite a bit larger than those for age 99. A closer examination of the
documentation shows that it's because the Census Bureau used 100 as the
code for everyone aged 100 or more.

The row with `AGE` 100 doesn't just represent 100-year-olds -- it also
includes those who are older than 100. That is why the numbers in that
row are larger than in the row for the 99-year-olds.

### Overall Proportions of Males and Females

We will now begin looking at gender ratios in 2014. First, let's look at
all the age groups together. Remember that this means looking at the
rows where the "age" is coded 999. The table `all_ages` contains this
information. There are three rows: one for the total of both genders,
one for males (`SEX` code 1), and one for females (`SEX` code 2).

``` python
us_pop_2014 = us_pop.drop('2010')
all_ages = us_pop_2014.where('AGE', are.equal_to(999))
all_ages
```

|SEX|AGE|2014|
|--- |--- |--- |
|0|999|318907401|
|1|999|156955337|
|2|999|161952064|

Row 0 of `all_ages` contains the total United States population in each of the
two years. The United States had just under 319 million in 2014.

Row 1 contains the counts for males and Row 2 for females. Compare these
two rows to see that in 2014, there were more females than males in the
United States.

The population counts in Row 1 and Row 2 add up to the total population
in Row 0.

For comparability with other quantities, we will need to convert these
counts to percents out of the total population. Let's access the total
for 2014 and name it. Then, we'll show a population table with a
proportion column. Consistent with our earlier observation that there
were more females than males, about 50.8% of the population in 2014 was
female and about 49.2% male in each of the two years.

``` python
pop_2014 = all_ages.column('2014').item(0)
all_ages.with_column(
    'Proportion', all_ages.column('2014')/pop_2014
).set_format('Proportion', PercentFormatter)
```

|SEX|AGE|2014|Proportion|
|--- |--- |--- |--- |
|0|999|318907401|100.00%|
|1|999|156955337|49.22%|
|2|999|161952064|50.78%|

### Proportions of Boys and Girls among Infants

When we look at infants, however, the opposite is true. Let's define
infants to be babies who have not yet completed one year, represented in
the row corresponding to `AGE` 0. Here are their numbers in the
population. You can see that male infants outnumbered female infants.

``` python
infants = us_pop_2014.where('AGE', are.equal_to(0))
infants
```

|SEX|AGE|2014|
|--- |--- |--- |
|0|0|3949775|
|1|0|2020326|
|2|0|1929449|

As before, we can convert these counts to percents out of the total
numbers of infants. The resulting table shows that in 2014, just over
51% of infants in the United States were male.

``` python
infants_2014 = infants.column('2014').item(0)
infants.with_column(
    'Proportion', infants.column('2014')/infants_2014
).set_format('Proportion', PercentFormatter)
```

|SEX|AGE|2014|Proportion|
|--- |--- |--- |--- |
|0|0|3949775|100.00%|
|1|0|2020326|51.15%|
|2|0|1929449|48.85%|

In fact, it has long been observed that the proportion of boys among
newborns is slightly more than 1/2. The reason for this is not
thoroughly understood, and [scientists are still working on
it](http://www.npr.org/sections/health-shots/2015/03/30/396384911/why-are-more-baby-boys-born-than-girls).

### Female:Male Gender Ratio at Each Age

We have seen that while there are more baby boys than baby girls, there
are more females than males overall. So it's clear that the split
between genders must vary across age groups.

To study this variation, we will separate out the data for the females
and the males, and eliminate the row where all the ages are aggregated
and `AGE` is coded as 999.

The tables `females` and `males` contain the data for each the two
genders.

``` python
females_all_rows = us_pop_2014.where('SEX', are.equal_to(2))
females = females_all_rows.where('AGE', are.not_equal_to(999))
females
```

|SEX|AGE|2014|
|--- |--- |--- |
|2|0|1929449|
|2|1|1931375|
|2|2|1935991|
|2|3|1957483|
|2|4|1961199|
|2|5|1962561|
|2|6|2024870|
|2|7|2032494|
|2|8|2015285|
|2|9|2010659|

... (91 rows omitted)

``` python
males_all_rows = us_pop_2014.where('SEX', are.equal_to(1))
males = males_all_rows.where('AGE', are.not_equal_to(999))
males
```

|SEX|AGE|2014|
|--- |--- |--- |
|1|0|2020326|
|1|1|2018401|
|1|2|2023673|
|1|3|2049596|
|1|4|2044517|
|1|5|2044339|
|1|6|2111060|
|1|7|2122832|
|1|8|2105618|
|1|9|2097690|

... (91 rows omitted)

The plan now is to compare the number of women and the number of men at
each age, for each of the two years. Array and Table methods give us
straightforward ways to do this. Both of these tables have one row for
each age.

``` python
males.column('AGE')
```

array(\[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100\])

``` python
females.column('AGE')
```

array(\[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100\])

For any given age, we can get the Female:Male gender ratio by dividing
the number of females by the number of males. To do this in one step, we
can use `column` to extract the array of female counts and the
corresponding array of male counts, and then simply divide one array by
the other. Elementwise division will create an array of gender ratios
for all the years.

``` python
ratios = Table().with_columns(
    'AGE', females.column('AGE'),
    '2014 F:M RATIO', females.column('2014')/males.column('2014')
)
ratios
```

|AGE|2014 F:M RATIO|
|--- |--- |
|0|0.955019|
|1|0.956884|
|2|0.956672|
|3|0.955058|
|4|0.959248|
|5|0.959998|
|6|0.959172|
|7|0.957445|
|8|0.957099|
|9|0.958511|

... (91 rows omitted)

You can see from the display that the ratios are all around 0.96 for
children aged nine or younger. When the Female:Male ratio is less than
1, there are fewer females than males. Thus what we are seeing is that
there were fewer girls than boys in each of the age groups 0, 1, 2, and
so on through 9. Moreover, in each of these age groups, there were about
96 girls for every 100 boys.

So how can the overall proportion of females in the population be higher
than the males?

Something extraordinary happens when we examine the other end of the age
range. Here are the Female:Male ratios for people aged more than 75.

``` python
ratios.where('AGE', are.above(75)).show()
```

|AGE|2014 F:M RATIO|
|--- |--- |
|76|1.23487|
|77|1.25797|
|78|1.28244|
|79|1.31627|
|80|1.34138|
|81|1.37967|
|82|1.41932|
|83|1.46552|
|84|1.52048|
|85|1.5756|
|86|1.65096|
|87|1.72172|
|88|1.81223|
|89|1.91837|
|90|2.01263|
|91|2.09488|
|92|2.2299|
|93|2.33359|
|94|2.52285|
|95|2.67253|
|96|2.87998|
|97|3.09104|
|98|3.41826|
|99|3.63278|
|100|4.25966|

Not only are all of these ratios greater than 1, signifying more women
than men in all of these age groups, many of them are considerably
greater than 1.

- At ages 89 and 90 the ratios are close to 2, meaning that there were
    about twice as many women as men at those ages in 2014.
- At ages 98 and 99, there were about 3.5 to 4 times as many women as
    men.

If you are wondering how many people there were at these advanced ages,
you can use Python to find out:

``` python
males.where('AGE', are.between(98, 100))
```

|SEX|AGE|2014|
|--- |--- |--- |
|1|98|13518|
|1|99|8951|

``` python
females.where('AGE', are.between(98, 100))
```

|SEX|AGE|2014|
|--- |--- |--- |
|2|98|46208|
|2|99|32517|

The graph below shows the gender ratios plotted against age. The blue
curve shows the 2014 ratio by age.

The ratios are almost 1 (signifying close to equal numbers of males and
females) for ages 0 through 60, but they start shooting up dramatically
(more females than males) starting at about age 65.

That females outnumber males in the United States is partly due to the marked
gender imbalance in favor of women among senior citizens.

``` python
ratios.plot('AGE')
```

![png](../media/30-example-gender-ratio-us-population-34-0.png)
