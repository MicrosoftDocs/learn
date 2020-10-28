Now we need to address missing values. First, let's look to see which columns have more than half of their values missing:

```python
# Missing values
df.isnull().sum()>(len(df)/2)
```

The output is:

```Output
PassengerId    False
Survived       False
Pclass         False
Gender         False
Age            False
SibSp          False
Parch          False
Fare           False
Cabin           True
Embarked       False
dtype: bool
```

Let's break down the code in the call just a bit. The `df.isnull().sum()` portion tells pandas to take the sum of all of the missing values for each column. And `len(df)/2` is another way of expressing half the number of rows in `DataFrame`. Taken together with the angle bracket symbol `>`, this line of code looks for any columns with more than half of their entries missing. One column meets this criteria, and it's **Cabin**.

We could try to do something about those missing values. But if any pattern emerges in the data that involves **Cabin**, it will be highly cross-correlated with both **Pclass** and **Fare**. This situation occurs because higher-fare, better-class accommodations were grouped together on the _Titanic_. Given that too much cross-correlation can be detrimental to a model, it's probably better for us to drop **Cabin** from `DataFrame`:

```python
df.drop('Cabin',axis=1,inplace=True)
```

Now let's run `info` to see if there are columns with only a few null values.

```python
df.info()
```

```Output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 891 entries, 0 to 890
Data columns (total 9 columns):
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   PassengerId  891 non-null    int64  
 1   Survived     891 non-null    int64  
 2   Pclass       891 non-null    int64  
 3   Gender       891 non-null    object 
 4   Age          714 non-null    float64
 5   SibSp        891 non-null    int64  
 6   Parch        891 non-null    int64  
 7   Fare         891 non-null    float64
 8   Embarked     889 non-null    object 
dtypes: float64(2), int64(5), object(2)
memory usage: 62.8+ KB
```

Note this point about the data. Given that 1,503 people died in the _Titanic_ tragedy, and that we know that some people survived, this dataset clearly doesn't include every passenger on the ship. Also, the dataset includes none of the crew. Remember that **Survived** is a variable that includes both the people who survived and the people who perished.

Let's return to missing values. The **Age** column is missing several values, and so is **Embarked**. Let's see how many values are missing from **Age**:

```python
df['Age'].isnull().value_counts()
```

The output is:

```Output
False    714
True     177
Name: Age, dtype: int64
```

As we saw, **Age** doesn't correlate with **Fare**, so it's a variable that we want to eventually use in our model. That means that we need to do something with those missing values. Before we decide on a strategy, we should check to see if our median age is the same for both genders.

```python
df.groupby('Gender')['Age'].median().plot(kind='bar')
```

The output is:

```Output
<matplotlib.axes._subplots.AxesSubplot at 0x1aeb58d0ec8>
```

:::image type="content" alt-text="A bar graph showing the median age for each gender." source="../media/output-bar-graph-1.png" loc-scope="azure":::

The median ages are different for men and women sailing on the _Titanic_, which means that we should handle the missing values accordingly. A sound strategy is to replace the missing ages for passengers with the median age _for the genders for each passenger_.

```python
df['Age'] = df.groupby('Gender')['Age'].apply(lambda x: x.fillna(x.median()))
```

Are there any other missing values?

```python
df.isnull().sum()
```

The output is:

```Output
PassengerId      0
Survived         0
Pclass           0
Gender           0
Age              0
SibSp            0
Parch            0
Fare             0
Cabin          687
Embarked         2
dtype: int64
```

We're missing two values for **Embarked**. Check to see how that variable breaks down:

```python
df['Embarked'].value_counts()
```

The output is:

```Output
S    644
C    168
Q     77
Name: Embarked, dtype: int64
```

The vast majority of passengers embarked on the _Titanic_ from Southampton. We'll fill in the two missing values with the most statistically likely value (the median result), which is Southampton.

```python
df['Embarked'].fillna(df['Embarked'].value_counts().idxmax(), inplace=True)
df['Embarked'].value_counts()
```

The output is:

```Output
S    646
C    168
Q     77
Name: Embarked, dtype: int64
```

Next, convert the categorical data in the **Gender** and **Embarked** columns into indicator data by using the `get_dummies` method.

```python
df = pd.get_dummies(data=df, columns=['Gender', 'Embarked'],drop_first=True)
df.head()
```

```Output
-------------------------------------------------------------------------------------------------------------------
|    |  PassengerId | Survived | Pclass | Age  | SibSp | Parch |   Fare   | Gender_male | Embarked_Q | Embarked_S |
-------------------------------------------------------------------------------------------------------------------
| 0  |       1      |     0    |    3   | 22.0 |   1   |   0   |  7.2500  |      1      |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------
| 1  |       2      |     1    |    1   | 38.0 |   1   |   0   | 71.2833  |      0      |      0     |      0     |
-------------------------------------------------------------------------------------------------------------------
| 2  |       3      |     0    |    3   | 26.0 |   0   |   0   |  7.9250  |      0      |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------
| 3  |       4      |     0    |    1   | 35.0 |   1   |   0   | 53.100   |      0      |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------
| 4  |       5      |     0    |    3   | 35.0 |   0   |   0   |  8.0500  |      1      |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------
```

Let's take a final look at the correlation matrix to see if there's anything else we should remove.

```python
df.corr()
```

The output is:

```Output
---------------------------------------------------------------------------------------------------------------------------------------------
|             | PassengerId | Survived  |   Pclass  |    Age    |   SibSp   |   Parch   |    Fare   | Gender_male | Embarked_Q | Embarked_S |
---------------------------------------------------------------------------------------------------------------------------------------------
| PassengerId |   1.000000  | -0.005007 | -0.035144 |  0.035734 | -0.057527 | -0.001652 |  0.012658 |   0.042939  | -0.033606  |  0.022204  |
---------------------------------------------------------------------------------------------------------------------------------------------
| Survived    |  -0.005007  |  1.000000 | -0.338481 | -0.073296 | -0.035322 |  0.081629 |  0.257307 |  -0.543351  |  0.003650  | -0.149683  |
---------------------------------------------------------------------------------------------------------------------------------------------
| Pclass      |  -0.035144  | -0.338481 |  1.000000 | -0.338056 |  0.083081 |  0.018443 | -0.549500 |   0.131900  |  0.221009  |  0.074053  |
---------------------------------------------------------------------------------------------------------------------------------------------
| Age         |   0.035734  | -0.073296 | -0.338056 |  1.000000 | -0.236376 | -0.176038 |  0.094161 |   0.095256  | -0.032994  | -0.005855  |
---------------------------------------------------------------------------------------------------------------------------------------------
| SibSp       |  -0.057527  | -0.035322 |  0.083081 | -0.236376 |  1.000000 |  0.414838 |  0.159651 |  -0.114631  | -0.026354  |  0.068734  |
---------------------------------------------------------------------------------------------------------------------------------------------
| Parch       |  -0.001652  |  0.081629 |  0.018443 | -0.176038 |  0.414838 |  1.000000 |  0.216225 |  -0.245489  | -0.081228  |  0.060814  |
---------------------------------------------------------------------------------------------------------------------------------------------
| Fare        |   0.012658  |  0.257307 | -0.549500 |  0.094161 |  0.159651 |  0.216225 |  1.000000 |  -0.182333  | -0.117216  | -0.162184  |
---------------------------------------------------------------------------------------------------------------------------------------------
| Gender_male |   0.042939  | -0.543351 |  0.131900 |  0.095256 | -0.114631 | -0.245489 | -0.182333 |   1.000000  | -0.074115  |  0.119224  |
---------------------------------------------------------------------------------------------------------------------------------------------
| Embarked_Q  |  -0.033606  |  0.003650 |  0.221009 | -0.032994 | -0.026354 | -0.081228 | -0.117216 |  -0.074115  |  1.000000  | -0.499421  |
---------------------------------------------------------------------------------------------------------------------------------------------
| Embarked_S  |   0.022204  | -0.149683 |  0.074053 | -0.005855 |  0.068734 |  0.060814 | -0.162184 |   0.119224  | -0.499421  |  1.000000  |
---------------------------------------------------------------------------------------------------------------------------------------------
```

**Pclass** and **Fare** have some amount of correlation, so we can probably get rid of one of them. In addition, we need to remove **Survived** from our **X** `DataFrame` because it will be our response `DataFrame`, **Y**:

```python
X = df.drop(['Survived','Pclass'],axis=1)
y = df['Survived']
```

### Try it yourself

Now we need to split the training and test data, which you'll do as an exercise.

```python
from sklearn.model_selection import train_test_split
```

Review how we used `train_test_split` in the [Linear regression: Fitting the model](../4-linear-regression-fit-model.yml?azure-portal=true) unit.

Set `test_size = 0.3` and `random_state = 67` to get the same results as here when you run through the rest of the code example.

<details> 

  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  from sklearn.linear_model import LogisticRegression

  X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3,random_state=67)
  ```
 
</details>

<br /><br />

***

Now you'll import and fit the logistic regression model.

Here's the input:

```python
from sklearn.linear_model import LogisticRegression
lr = LogisticRegression()
```

The output is:

```Output
LogisticRegression(C=1.0, class_weight=None, dual=False, fit_intercept=True,
                 intercept_scaling=1, l1_ratio=None, max_iter=100,
                 multi_class='auto', n_jobs=None, penalty='l2',
                 random_state=None, solver='lbfgs', tol=0.0001, verbose=0,
                 warm_start=False)
```

And then you'll save the predictions to compare with the y_test values (also known as the true output).

```python
predictions = lr.predict(X_test)
```
