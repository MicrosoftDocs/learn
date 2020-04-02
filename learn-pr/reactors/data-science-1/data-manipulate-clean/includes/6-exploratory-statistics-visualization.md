
An old joke goes: “What does a data scientist see when they look at a dataset? A bunch of numbers.” There is more than a little truth in that joke. Visualization often is the key to finding patterns and correlations in your data. Although a visualization often can't deliver precise results, it can point you in the right direction to ask better questions and efficiently find value in the data.

Learning goal: By the end of this subsection, you should be familiar with some of the ways to visually explore the data that's stored in a pandas DataFrame.

Often when probing a new data set, it is invaluable to get high-level information about what the dataset holds. Earlier in this section, we discussed using methods like `DataFrame.info`, `DataFrame.head`, and `DataFrame.tail` to examine some aspects of a DataFrame. Although these methods are critical, on their own they often are insufficient to get enough information to know how to approach a new dataset. This is where exploratory statistics and visualizations for datasets come in.

To see what we mean in terms of gaining exploratory insight (both visually and numerically), let's dig into one of the datasets that come with the scikit-learn library, the Boston Housing Dataset (you will load it from a CSV file):

```output
df = pd.read_csv('Data/housing_dataset.csv')
df.head()
```

This dataset contains information that was collected from the U.S Census Bureau about housing in the area of Boston, Massachusetts. The dataset was first published in 1978. The dataset has 14 columns:

* **CRIM**: Per-capita crime rate by town
* **ZN**: Proportion of residential land zoned for lots over 25,000 square feet
* **INDUS**: Proportion of non-retail business acres per town
* **CHAS**: Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
* **NOX**: Nitric oxides concentration (parts per 10 million)
* **RM**: Average number of rooms per dwelling
* **AGE**: Proportion of owner-occupied units built prior to 1940
* **DIS**: Weighted distances to five Boston employment centers
* **RAD**: Index of accessibility to radial highways
* **TAX**: Full-value property-tax rate per \$10,000
* **PTRATIO**: Pupil-teacher ratio by town
* **LSTAT**: Percent of lower-status portion of the population
* **MEDV**: Median value of owner-occupied homes in \$1,000s

One of the first methods we can use to better understand this dataset is `DataFrame.shape`:

```output
df.shape
```

The dataset has 506 rows and 13 columns.

To get a better idea of the contents of each column we can use DataFrame.describe, which returns the maximum value, minimums value, mean, and standard deviation of numeric values in each column, in addition to the quartiles for each column:

```output
df.describe()
```

Because dataset can have so many columns in them, it can often be useful to transpose the results of DataFrame.describe to better use them:

Note that you can also examine specific descriptive statistics for columns without having to invoke DataFrame.describe:

```output
df['MEDV'].mean()
```

```output
df['MEDV'].max()
```

```output
df['AGE'].median()
```

### Exercise

Now find the maximum value in df['AGE'].

Other information that you will often want to see is the relationship between different columns. You do this with the DataFrame.groupby method. For example, you could examine the average MEDV (median value of owner-occupied homes) for each value of AGE (proportion of owner-occupied units built prior to 1940):

```output
df.groupby(['AGE'])['MEDV'].mean()
```

### Exercise

Now try to find the median value for AGE for each value of MEDV.

You can also apply a lambda function to each element of a DataFrame column by using the apply method. For example, say you wanted to create a new column that flagged a row if more than 50 percent of owner-occupied homes were build before 1940:

```output
df['AGE_50'] = df['AGE'].apply(lambda x: x>50)
```

Once applied, you also see how many values returned true and how many false by using the value_counts method:

```output
df['AGE_50'].value_counts()
```

You can also examine figures from the `groupby` statement you created earlier:

```output
df.groupby(['AGE_50'])['MEDV'].mean()
```

You can also group by more than one variable, such AGE_50 (the one you just created), CHAS (whether a town is on the Charles River), and RAD (an index measuring access to the Boston-area radial highways), and then evaluate each group for the average median home price in that group:

```output
groupby_twovar=df.groupby(['AGE_50','RAD','CHAS'])['MEDV'].mean()
```

You can then see what values are in this stacked group of variables:

## `groupby_twovar`

Let's take a moment to analyze these results in a little depth. The first row reports that communities with less the half of houses built before 1940, with a highway-access index of 1, and that are not situated on the Charles River have a mean house price of \$24,667 (1970s dollars); the next row shows that for communities similar to the first row except for being located on the Charles River have a mean house price of \$50,000.

One insight that pops out from continuing down this is that, all else being equal, being located next to the Charles River can significantly increase the value of newer housing stock. The story is more ambiguous for communities dominated by older houses: proximity to the Charles significantly increases home prices in one community (and that one presumably farther away from the city); for all others, being situated on the river either provided a modest increase in value or actually decreased mean home prices.

While groupings like this can be a great way to begin to interrogate your data, you might not care for the 'tall' format it comes in. In that case, you can unstack the data into a "wide" format:

```output
groupby_twovar.unstack()
```

### Exercise

How could you use `groupby` to get a sense of the proportion of residential land zoned for lots over 25,000 sq.ft., the proportion of non-retail business acres per town, and the distance of towns from employment centers in Boston?

It is also often valuable to know how many unique values a column has in it with the `nunique` method:

```output
df['CHAS'].nunique()
```

Complementary to that, you will also likely want to know what those unique values are, which is where the unique method helps:

```output
df['CHAS'].unique()
```

You can use the value_counts method to see how many of each unique value there are in a column:

```output
df['CHAS'].value_counts()
```

Or you can easily plot a bar graph to visually see the breakdown:

```output
%matplotlib inline
df['CHAS'].value_counts().plot(kind='bar')
```

Note that the IPython magic command %matplotlib inline enables you to view the chart inline.

Let's pull back to the dataset as a whole for a moment. Two major things that you will look for in almost any dataset are trends and relationships. A typical relationship between variables to explore is the Pearson correlation, or the extent to which two variables are linearly related. The corr method will show this in table format for all of the columns in a DataFrame:

```output
df.corr(method='pearson')
```

Suppose you just wanted to look at the correlations between all of the columns and just one variable? Let's examine just the correlation between all other variables and the percentage of owner-occupied houses build before 1940 (AGE). We will do this by accessing the column by index number:

```output
corr = df.corr(method='pearson')
corr_with_homevalue = corr.iloc[-1]
corr_with_homevalue[corr_with_homevalue.argsort()[::-1]]
```

With the correlations arranged in descending order, it's easy to start to see some patterns. Correlating AGE with a variable we created from AGE is a trivial correlation. However, it is interesting to note that the percentage of older housing stock in communities strongly correlates with air pollution (NOX) and the proportion of non-retail business acres per town (INDUS); at least in 1978 metro Boston, older towns are more industrial.

Graphically, we can see the correlations using a heatmap from the Seaborn library:

```input
import seaborn as sns
sns.heatmap(df.corr(),cmap=sns.cubehelix_palette(20, light=0.95, dark=0.15))
```

Histograms are another valuable tool for investigating your data. For example, what is the overall distribution of prices of owner-occupied houses in the Boston area?

```input
import matplotlib.pyplot as plt
plt.hist(df['MEDV'])
```

The default bin size for the matplotlib histogram (essentially big of buckets of percentages that you include in each histogram bar in this case) is pretty large and might mask smaller details. To get a finer-grained view of the AGE column, you can manually increase the number of bins in the histogram:

```output
plt.hist(df['MEDV'],bins=50)
```

Seaborn has a somewhat more attractive version of the standard matplotlib histogram: the distribution plot. This is a combination histogram and kernel density estimate (KDE) plot (essentially a smoothed histogram):

```output
sns.distplot(df['MEDV'])
```

Another commonly used plot is the Seaborn `jointplot`, which combines histograms for two columns along with a scatterplot:

```output
sns.jointplot(df['RM'], df['MEDV'], kind='scatter')
```

Unfortunately, many of the dots print over each other. You can help address this by adding some alpha blending, a figure that sets the transparency for the dots so that concentrations of them drawing over one another will be apparent:

```output
sns.jointplot(df['RM'], df['MEDV'], kind='scatter', alpha=0.3)
```

Another way to see patterns in your data is with a two-dimensional KDE plot. Darker colors here represent a higher concentration of data points:

```output
sns.kdeplot(df['RM'], df['MEDV'], shade=True)
```

Note that although the KDE plot is very good at showing concentrations of data points, finer structures like linear relationships (such as the clear relationship between the number of rooms in homes and the house price) are lost in the KDE plot.

Finally, `pairplot` in Seaborn allows you to see scatterplots and histograms for several columns in one table. Here we have played with some of the keywords to produce a more sophisticated and easier-to-read `pairplot` that incorporates both alpha blending and linear regression lines for the scatterplots.

```output
sns.pairplot(df[['RM', 'AGE', 'LSTAT', 'DIS', 'MEDV']], kind="reg", plot_kws={'line_kws':{'color':'red'}, 'scatter_kws': {'alpha': 0.1}})
```

Visualization is the start of the really cool, fun part of data science. So play around with these visualization tools and see what you can learn from the data!