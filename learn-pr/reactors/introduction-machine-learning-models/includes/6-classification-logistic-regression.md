<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->
> [!Note]
> **Sarah: Conversion feedback**
> 
> Suggest moving the **Learning goal** to the list of Learning objectives in the Introduction unit or to the abstract summary in the module index.yml.
>

> [!Note]
> **Sarah: Action items**
> 
> - Try it yourself block needs Input and Output code, and Hint text. Search on TBD.
> - Missing some output cell content. Search on TBD.
>

> [!div class="alert is-tip"]
> ### Learning goal
>
> By the end of this unit, you should know how logistic regression differs from linear regression, be comfortable fitting logistic regression models, and have some familiarity with interpreting their output.

We'll now pivot to discussing classification. If our simple analogy of predictive analytics was drawing a line through points and extrapolating from that, then classification can be described in its simplest form as drawing lines around groups of points.

While linear regression is used to predict quantitative responses, _logistic_ regression is used for classification problems. Formally, logistic regression predicts the categorical response ($Y$) based on predictors ($X_s$). Logistic regression goes by several names, and it is also known in the scholarly literature as logit regression, maximum-entropy classification (MaxEnt), and the log-linear classifier. In this algorithm, the probabilities describing the possible outcomes of a single trial are modeled using a sigmoid (S-curve) function. Sigmoid functions take any value and transform it to be between 0 and 1, which can be used as a probability for a class to be predicted, with the goal of predictors mapping to 1 when something belongs in the class and 0 when they do not.

:::image type="content" alt-text="A graph showing logistic regression." source="../media/logistic-regression.png" loc-scope="azure":::

To show this in action, let's do something a little different and try a historical dataset: the fates of the passengers of the _RMS Titanic_, which is a popular dataset for classification problems in machine learning. In this case, the class we want to predict is whether a passenger survived the doomed liner's sinking.

The dataset has 12 variables:

- **PassengerId**
- **Survived**: 0 = No, 1 = Yes
- **Pclass**: Ticket class 1 = 1st, 2 = 2nd, 3 = 3rd
- **Sex**
- **Age**
- **Sibsp**: Number of siblings or spouses aboard the _Titanic_
- **Parch**: Number of parents or children aboard the _Titanic_
- **Ticket**: Passenger ticket number
- **Fare**: Passenger fare
- **Cabin**: Cabin number
- **Embarked**: Port of embarkation; C = Cherbourg, Q = Queenstown, S = Southampton

```python
df = pd.read_csv('./Data/train_data_titanic.csv')
df.head()
```

The output table looks like this:

```output
---------------------------------------------------------------------------------------------------------------------------------------
|   | PassengerId | Survived | Pclass | Name                 | Sex    | Age  | SibSp | Parch | Ticket    | Fare    | Cabin | Embarked | 
---------------------------------------------------------------------------------------------------------------------------------------
| 0	|      1      |    0     |    3   | Braund, Mr. Owen     | male   | 22.0 |   1   |   0   | A/5 21171 | 7.2500  |  NaN  |     S    |
| 	|             |          |        | Harris               |        |      |       |       |           |         |       |          |
---------------------------------------------------------------------------------------------------------------------------------------
| 1	|      2      |    1     |    1   | Cumings, Mrs. John   | female | 38.0 |   1   |   0   | PC 17599  | 71.2833 |  C85  |     C    |
|  	|             |          |        | Bradley (Florence    |        |      |       |       |           |         |       |          |
|  	|             |          |        | Briggs Th...         |        |      |       |       |           |         |       |          |---------------------------------------------------------------------------------------------------------------------------------------
| 2	|      3      |    1     |    3   | Heikkinen, Miss.     | female | 26.0 |   0   |   0   | STON/O2.  | 7.9250  |  NaN  |     S    |
|  	|             |          |        | Laina                |        |      |       |       | 3101282   |         |       |          |
---------------------------------------------------------------------------------------------------------------------------------------
| 3	|      4      |    1     |    1   | Futrelle, Mrs.       | female | 35.0 |   1   |   0   | 113803    | 53.1000 |  C123 |     S    |
|  	|             |          |        | Jacques Heath (Lily  |        |      |       |       |           |         |       |          |
|  	|             |          |        | May Peel)            |        |      |       |       |           |         |       |          |
---------------------------------------------------------------------------------------------------------------------------------------
| 4	|      5      |    0     |    3   | Allen, Mr. William   | male   | 35.0 |   0   |   0   | 373450    | 8.0500  |  NaN  |     S    |
|  	|             |          |        | Henry                |        |      |       |       |           |         |       |          |
---------------------------------------------------------------------------------------------------------------------------------------
```

Let's look at the `DataFrame` information for that dataset:

```python
df.info()
```

Here's what the output looks like:

```output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 891 entries, 0 to 890
Data columns (total 12 columns):
PassengerId    891 non-null int64
Survived       891 non-null int64
Pclass         891 non-null int64
Name           891 non-null object
Sex            891 non-null object
Age            714 non-null float64
SibSp          891 non-null int64
Parch          891 non-null int64
Ticket         891 non-null object
Fare           891 non-null float64
Cabin          204 non-null object
Embarked       889 non-null object
dtypes: float64(2), int64(5), object(5)
memory usage: 83.6+ KB
```

One reason that the _Titanic_ data set is a popular classification set is that it provides opportunities to prepare data for analysis. To prepare this dataset for analysis, we need to perform a number of tasks:

- Remove extraneous variables
- Check for multicollinearity
- Handle missing values

We will touch on each of these steps in turn.

## Remove extraneous variables

The name of individual passengers and their ticket numbers will clearly do nothing to help our model, so we can drop those columns to simplify matters.

```python
df.drop(['Name','Ticket'],axis=1,inplace=True)
```

There are additional variables that will not add classifying power to our model, but to find them we will need to look for correlation between variables.

## Check for multicollinearity

If one or more of our predictors can themselves be predicted from other predictors, it can produce a state of _multicollinearity_ in our model. Multicollinearity is a challenge because it can skew the results of regression models (both linear and logistic) and reduce the predictive or classifying power of a model.

To help combat this problem, we can start to look for some initial patterns. For example, do any correlations between **Survived** and **Fare** jump out?

```python
sns.pairplot(df[['Survived','Fare']], dropna=True)
```

The pair plot output for data in the columns **Survived** and **Fare**:

```output
<seaborn.axisgrid.PairGrid at 0x7f58facc2f28>
```
:::image type="content" alt-text="A graph showing the pair plot output for data in the Survived column and the Fare column." source="../media/output-pair-plot-2.png" loc-scope="azure":::

### Try it yourself

Try running `sns.pairplot` twice more on some other combinations of columns and see if any patterns emerge.

<details> 

  <summary>Hint - TBD<i>(expand to reveal)</i></summary>

  ```python
  TBD
  ```

  ```output
  TBD
  ```
  
</details>

We can also use `groupby` to look for patterns. Consider the mean values for the various variables when we group by **Survived**:

```python
df.groupby('Survived').mean()
```

Here's the `groupby` output for the **Survived** data:

```output
-----------------------------------------------------------------------------------
|          | PassengerId | Pclass   | Age       | SibSp    | Parch    | Fare      |
-----------------------------------------------------------------------------------
| Survived |             |          |           |          |          |           |
-----------------------------------------------------------------------------------
|    0     | 447.016393  | 2.531876 | 30.626179 | 0.553734 | 0.329690 | 22.117887 |
-----------------------------------------------------------------------------------
|    1     | 444.368421  | 1.950292 | 28.343690 | 0.473684 | 0.464912 | 48.395408 |
-----------------------------------------------------------------------------------
```

```python
df.groupby('Age').mean()
```

Here's the `groupby` output for the **Age** data:

```output
--------------------------------------------------------------------------------
|       | PassengerId | Survived |  Pclass  | SibSp    | Parch    | Fare       |
--------------------------------------------------------------------------------
| Age   |             |          |          |          |          |            |
--------------------------------------------------------------------------------
|  0.42 | 804.000000  | 1.000000 | 3.000000 | 0.000000 | 1.000000 | 8.516700   |
|  0.67 | 756.000000  | 1.000000 | 2.000000 | 1.000000 | 1.000000 | 14.500000  |
|  0.75 | 557.500000  | 1.000000 | 3.000000 | 2.000000 | 1.000000 | 19.258300  |
|  0.83 | 455.500000  | 1.000000 | 2.000000 | 0.500000 | 1.500000 | 23.875000  |
|  0.92 | 306.000000  | 1.000000 | 1.000000 | 1.000000 | 2.000000 | 151.550000 |
|  1.00 | 415.428571  | 0.714286 | 2.714286 | 1.857143 | 1.571429 | 30.005957  |
|  2.00 | 346.900000  | 0.300000 | 2.600000 | 2.100000 | 1.300000 | 37.536250  |
|  3.00 | 272.000000  | 0.833333 | 2.500000 | 1.833333 | 1.333333 | 25.781950  |
|  4.00 | 466.100000  | 0.700000 | 2.600000 | 1.600000 | 1.400000 | 29.543330  |
|  5.00 | 380.000000  | 1.000000 | 2.750000 | 1.750000 | 1.250000 | 22.717700  |
|  6.00 | 762.333333  | 0.666667 | 2.666667 | 1.333333 | 1.333333 | 25.583333  |
|  7.00 | 288.666667  | 0.333333 | 2.666667 | 2.666667 | 1.333333 | 31.687500  |
|  8.00 | 400.250000  | 0.500000 | 2.500000 | 2.000000 | 1.250000 | 28.300000  |
|  9.00 | 437.250000  | 0.250000 | 3.000000 | 2.500000 | 1.750000 | 27.938538  |
| 10.00 | 620.000000  | 0.000000 | 3.000000 | 1.500000 | 2.000000 | 26.025000  |
| 11.00 | 534.500000  | 0.250000 | 2.500000 | 2.500000 | 1.500000 | 54.240625  |
| 12.00 | 126.000000  | 1.000000 | 3.000000 | 1.000000 | 0.000000 | 11.241700  |
| 13.00 | 614.000000  | 1.000000 | 2.500000 | 0.000000 | 0.500000 | 13.364600  |
| 14.00 | 312.000000  | 0.500000 | 2.500000 | 2.000000 | 0.833333 | 42.625700  |
| 14.50 | 112.000000  | 0.000000 | 3.000000 | 1.000000 | 0.000000 | 14.454200  |
| 15.00 | 554.600000  | 0.800000 | 2.600000 | 0.400000 | 0.400000 | 49.655020  |
| 16.00 | 422.294118  | 0.352941 | 2.529412 | 0.764706 | 0.529412 | 25.745100  |
| 17.00 | 423.000000  | 0.461538 | 2.384615 | 0.615385 | 0.384615 | 28.389423  |
| 18.00 | 516.269231  | 0.346154 | 2.461538 | 0.384615 | 0.423077 | 38.063462  |
| 19.00 | 389.400000  | 0.360000 | 2.360000 | 0.320000 | 0.200000 | 27.869496  |
| 20.00 | 493.066667  | 0.200000 | 3.000000 | 0.200000 | 0.066667 | 8.624173   |
| 20.50 | 228.000000  | 0.000000 | 3.000000 | 0.000000 | 0.000000 | 7.250000   |
| 21.00 | 390.208333  | 0.208333 | 2.583333 | 0.333333 | 0.208333 | 31.565621  |
| 22.00 | 365.740741  | 0.407407 | 2.555556 | 0.148148 | 0.222222 | 25.504781  |
| 23.00 | 510.266667  | 0.333333 | 2.133333 | 0.400000 | 0.266667 | 37.994720  |
| ...   | ...         | ...      |  ...     | ...      |...       | ...        |
| 44.00 | 437.111111  | 0.333333 | 2.111111 | 0.444444 | 0.222222 | 29.758333  |
| 45.00 | 367.500000  | 0.416667 | 2.000000 | 0.333333 | 0.583333 | 36.818408  |
| 45.50 | 268.000000  | 0.000000 | 2.000000 | 0.000000 | 0.000000 | 17.862500  |
| 46.00 | 427.000000  | 0.000000 | 1.333333 | 0.333333 | 0.000000 | 55.458333  |
| 47.00 | 534.666667  | 0.111111 | 1.777778 | 0.222222 | 0.111111 | 27.601389  |
| 48.00 | 663.111111  | 0.666667 | 1.666667 | 0.555556 | 0.555556 | 37.893067  |
| 49.00 | 533.500000  | 0.666667 | 1.333333 | 0.666667 | 0.166667 | 59.929183  |
| 50.00 | 457.200000  | 0.500000 | 1.600000 | 0.400000 | 0.200000 | 64.025830  |
| 51.00 | 456.142857  | 0.285714 | 2.000000 | 0.142857 | 0.142857 | 28.752386  |
| 52.00 | 589.500000  | 0.500000 | 1.333333 | 0.500000 | 0.333333 | 51.402783  |
| 53.00 | 572.000000  | 1.000000 | 1.000000 | 2.000000 | 0.000000 | 51.479200  |
| 54.00 | 383.625000  | 0.375000 | 1.500000 | 0.500000 | 0.500000 | 44.477087  |
| 55.00 | 254.500000  | 0.500000 | 1.500000 | 0.000000 | 0.000000 | 23.250000  |
| 55.50 | 153.000000  | 0.000000 | 3.000000 | 0.000000 | 0.000000 | 8.050000   |
| 56.00 | 542.750000  | 0.500000 | 1.000000 | 0.000000 | 0.250000 | 43.976025  |
| 57.00 | 700.000000  | 0.000000 | 2.000000 | 0.000000 | 0.000000 | 11.425000  |
| 58.00 | 325.000000  | 0.600000 | 1.000000 | 0.000000 | 0.600000 | 93.901660  |
| 59.00 | 164.000000  | 0.000000 | 2.500000 | 0.000000 | 0.000000 | 10.375000  |
| 60.00 | 583.750000  | 0.500000 | 1.250000 | 0.750000 | 0.500000 | 55.000000  |
| 61.00 | 374.666667  | 0.000000 | 1.666667 | 0.000000 | 0.000000 | 24.019433  |
| 62.00 | 552.500000  | 0.500000 | 1.250000 | 0.000000 | 0.000000 | 35.900000  |
| 63.00 | 380.000000  | 1.000000 | 2.000000 | 0.500000 | 0.000000 | 43.772900  |
| 64.00 | 492.500000  | 0.000000 | 1.000000 | 0.500000 | 2.000000 | 144.500000 |
| 65.00 | 264.333333  | 0.000000 | 1.666667 | 0.000000 | 0.333333 | 32.093067  |
| 66.00 | 34.000000   | 0.000000 | 2.000000 | 0.000000 | 0.000000 | 10.500000  |
| 70.00 | 709.500000  | 0.000000 | 1.500000 | 0.500000 | 0.500000 | 40.750000  |
| 70.50 | 117.000000  | 0.000000 | 3.000000 | 0.000000 | 0.000000 | 7.750000   |
| 71.00 | 295.500000  | 0.000000 | 1.000000 | 0.000000 | 0.000000 | 42.079200  |
| 74.00 | 852.000000  | 0.000000 | 3.000000 | 0.000000 | 0.000000 | 7.775000   |
| 80.00 | 631.000000  | 1.000000 | 1.000000 | 0.000000 | 0.000000 | 30.000000  |
--------------------------------------------------------------------------------
88 rows x 6 columns
```

Survivors appear to be slightly younger on average with higher-cost fare.

```python
df.head()
```

Here's the output:

```output
---------------------------------------------------------------------------------------------------------------------------------------
|   | PassengerId | Survived | Pclass | Sex    | Age  | SibSp | Parch | Fare    | Cabin | Embarked | 
---------------------------------------------------------------------------------------------------------------------------------------
| 0	|      1      |    0     |    3   | male   | 22.0 |   1   |   0   | 7.2500  |  NaN  |     S    |
---------------------------------------------------------------------------------------------------------------------------------------
| 1	|      2      |    1     |    1   | female | 38.0 |   1   |   0   | 71.2833 |  C85  |     C    |---------------------------------------------------------------------------------------------------------------------------------------
| 2	|      3      |    1     |    3   | female | 26.0 |   0   |   0   | 7.9250  |  NaN  |     S    |
---------------------------------------------------------------------------------------------------------------------------------------
| 3	|      4      |    1     |    1   | female | 35.0 |   1   |   0   | 53.1000 |  C123 |     S    |
---------------------------------------------------------------------------------------------------------------------------------------
| 4	|      5      |    0     |    3   | male   | 35.0 |   0   |   0   | 8.0500  |  NaN  |     S    |
---------------------------------------------------------------------------------------------------------------------------------------
```

Value counts can also help us get a sense of the data before us, such as numbers for siblings and spouses on the _Titanic_, in addition to the sex split of passengers:

```python
df['SibSp'].value_counts()
```

The value counts output for the **SibSp** column data (passenger had a sibling or spouse on board) is:

```output
TBD
```

```python
df['Parch'].value_counts()
```

The value counts output for the **Parch** column data (passenger had a parent or child on board) is:

```output
TBD
```

```python
df['Sex'].value_counts()
```

The value counts output for the **Sex** gender column data is:

```output
TBD
```
