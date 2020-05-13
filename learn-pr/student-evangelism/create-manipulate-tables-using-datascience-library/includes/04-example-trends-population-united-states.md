> [!NOTE]
> You can find an interactive version of this unit named **example-trends-in-the-population-of-the-united-states.ipynb** in your virtual environment

If you haven't set up your online Visual Studio Codespaces environment for the Learning Path "Foundations of Data Science", please refer to the first unit **Setup**

Open [Visual Studio Codespaces](https://online.visualstudio.com/environments)


``` python
from datascience import *
import numpy as np
path_data = '../../../../data/'
np.set_printoptions(threshold=50)
```

## Example: population trends

We are now ready to work with large tables of data. The file below
contains "Annual Estimates of the Resident Population by Single Year of
AGE and SEX for the United States." Notice that `read_table` can read
data directly from a URL.

``` python
# As of Jan 2017, this census file is online here: 
data = 'http://www2.census.gov/programs-surveys/popest/datasets/2010-2015/national/asrh/nc-est2015-agesex-res.csv'

# A local copy can be accessed here in case census.gov moves the file:
# data = path_data + 'nc-est2015-agesex-res.csv'

full_census_table = Table.read_table(data)
full_census_table
```

|SEX|AGE|CENSUS2010POP|ESTIMATESBASE2010|POPESTIMATE2010|POPESTIMATE2011|POPESTIMATE2012|POPESTIMATE2013|POPESTIMATE2014|POPESTIMATE2015|
|--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |
|0|0|3944153|3944160|3951330|3963087|3926540|3931141|3949775|3978038|
|0|1|3978070|3978090|3957888|3966551|3977939|3942872|3949776|3968564|
|0|2|4096929|4096939|4090862|3971565|3980095|3992720|3959664|3966583|
|0|3|4119040|4119051|4111920|4102470|3983157|3992734|4007079|3974061|
|0|4|4063170|4063186|4077551|4122294|4112849|3994449|4005716|4020035|
|0|5|4056858|4056872|4064653|4087709|4132242|4123626|4006900|4018158|
|0|6|4066381|4066412|4073013|4074993|4097605|4142916|4135930|4019207|
|0|7|4030579|4030594|4043046|4083225|4084913|4108349|4155326|4148360|
|0|8|4046486|4046497|4025604|4053203|4093177|4095711|4120903|4167887|
|0|9|4148353|4148369|4125415|4035710|4063152|4104072|4108349|4133564|

... (296 rows omitted)

Only the first 10 rows of the table are displayed. Later we will see how
to display the entire table; however, this is typically not useful with
large tables.

a [description of the
table](http://www2.census.gov/programs-surveys/popest/datasets/2010-2015/national/asrh/nc-est2015-agesex-res.pdf)
appears online. The `SEX` column contains numeric codes: `0` stands for
the total, `1` for male, and `2` for female. The `AGE` column contains
ages in completed years, but the special value `999` is a sum of the
total population. The rest of the columns contain estimates of the US
population.

Typically, a public table will contain more information than necessary
for a particular investigation or analysis. In this case, let us suppose
that we are only interested in the population changes from 2010 to 2014.
Let us `select` the relevant columns.

``` python
partial_census_table = full_census_table.select('SEX', 'AGE', 'POPESTIMATE2010', 'POPESTIMATE2014')
partial_census_table
```

|SEX|AGE|POPESTIMATE2010|POPESTIMATE2014|
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

We can also simplify the labels of the selected columns.

``` python
us_pop = partial_census_table.relabeled('POPESTIMATE2010', '2010').relabeled('POPESTIMATE2014', '2014')
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

We now have a table that is easy to work with. Each column of the table
is an array of the same length, and so columns can be combined using
arithmetic. Here is the change in population between 2010 and 2014.

``` python
us_pop.column('2014') - us_pop.column('2010')
```

array(\[ -1555, -8112, -131198, ..., 6443, 12950, 4693244\])

Let us augment `us_pop` with a column that contains these changes, both
in absolute terms and as percents relative to the value in 2010.

``` python
change = us_pop.column('2014') - us_pop.column('2010')
census = us_pop.with_columns(
    'Change', change,
    'Percent Change', change/us_pop.column('2010')
)
census.set_format('Percent Change', PercentFormatter)
```

|SEX|AGE|2010|2014|Change|Percent Change|
|--- |--- |--- |--- |--- |--- |
|0|0|3951330|3949775|-1555|-0.04%|
|0|1|3957888|3949776|-8112|-0.20%|
|0|2|4090862|3959664|-131198|-3.21%|
|0|3|4111920|4007079|-104841|-2.55%|
|0|4|4077551|4005716|-71835|-1.76%|
|0|5|4064653|4006900|-57753|-1.42%|
|0|6|4073013|4135930|62917|1.54%|
|0|7|4043046|4155326|112280|2.78%|
|0|8|4025604|4120903|95299|2.37%|
|0|9|4125415|4108349|-17066|-0.41%|

... (296 rows omitted)

**Sorting the data.** Let us sort the table in decreasing order of the
absolute change in population.

``` python
census.sort('Change', descending=True)
```

|SEX|AGE|2010|2014|Change|Percent Change|
|--- |--- |--- |--- |--- |--- |
|0|999|309346863|318907401|9560538|3.09%|
|1|999|152088043|156955337|4867294|3.20%|
|2|999|157258820|161952064|4693244|2.98%|
|0|67|2693707|3485241|791534|29.38%|
|0|64|2706055|3487559|781504|28.88%|
|0|66|2621335|3347060|725725|27.69%|
|0|65|2678525|3382824|704299|26.29%|
|0|71|1953607|2519705|566098|28.98%|
|0|34|3822189|4364748|542559|14.19%|
|0|23|4217228|4702156|484928|11.50%|

... (296 rows omitted)

Not surprisingly, the top row of the sorted table is the line that
corresponds to the entire population: both sexes and all age groups.
From 2010 to 2014, the population of the United States increased by
about 9.5 million people, a change of just over 3%.

The next two rows correspond to all the men and all the women
respectively. The male population grew more than the female population,
both in absolute and percentage terms. Both percent changes were around
3%.

Now take a look at the next few rows. The percent change jumps from
about 3% for the overall population to almost 30% for the people in
their late sixties and early seventies. This stunning change contributes
to what is known as the greying of America.

By far the greatest absolute change was among those in the 64-67
age group in 2014. What could explain this large increase? We can explore
this question by examining the years in which the relevant groups were
born.

- Those who were in the 64-67 age group in 2010 were born in the years
    1943 to 1946. The attack on Pearl Harbor was in late 1941, and by
    1942 United States forces were heavily engaged in a massive war that ended
    in 1945.

- Those who were 64 to 67 years old in 2014 were born in the years
    1947 to 1950, at the height of the post-WWII baby boom in the United
    States.

The post-war jump in births is the major reason for the large changes
that we have observed.