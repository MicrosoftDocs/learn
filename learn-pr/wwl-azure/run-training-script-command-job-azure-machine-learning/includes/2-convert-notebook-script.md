When you've used notebooks for experimentation and development, you'll first need to convert a notebook to a script. Alternatively, you might choose to skip using notebooks and work only with scripts. Either way, there are some recommendations when creating scripts to have production-ready code.

Scripts are ideal for testing and automation in your production environment. To create a production-ready script, you'll need to:

- Remove nonessential code.
- Refactor your code into functions.
- Test your script in the terminal.

## Remove all nonessential code

The main benefit of using notebooks is being able to quickly explore your data. For example, you can use `print()` and `df.describe()` statements to explore your data and variables. When you create a script that will be used for automation, you want to avoid including code written for exploratory purposes. 

The first thing you therefore need to do to convert your code to production code is to remove the nonessential code. Especially when you'll run the code regularly, you want to avoid executing anything nonessential to reduce cost and compute time.

## Refactor your code into functions

When using code in business processes, you want the code to be easy to read so that anyone can maintain it. One common approach to make code easier to read and test is to use functions. 

For example, you might have used the following example code in a notebook to read and split the data:

```python
# read and visualize the data
print("Reading data...")
df = pd.read_csv('diabetes.csv')
df.head()

# split data
print("Splitting data...")
X, y = df[['Pregnancies','PlasmaGlucose','DiastolicBloodPressure','TricepsThickness','SerumInsulin','BMI','DiabetesPedigree','Age']].values, df['Diabetic'].values

from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30, random_state=0)
```

As functions also allow you to test parts of your code, you might prefer to create *multiple smaller functions*, rather than one large function. If you want to test a part of your code, you can choose to only test a small part and avoid running more code than necessary. 

You can refactor the code shown in the example into two functions: 

- Read the data
- Split the data

An example of refactored code might be the following:

```python
def main(csv_file):
    # read data
    df = get_data(csv_file)

    # split data
    X_train, X_test, y_train, y_test = split_data(df)

# function that reads the data
def get_data(path):
    df = pd.read_csv(path)
    
    return df

# function that splits the data
def split_data(df):
    X, y = df[['Pregnancies','PlasmaGlucose','DiastolicBloodPressure','TricepsThickness',
    'SerumInsulin','BMI','DiabetesPedigree','Age']].values, df['Diabetic'].values

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30, random_state=0)

    return X_train, X_test, y_train, y_test
```

> [!Note]
> You may have noticed that nonessential code was also omitted in the refactored code. You may choose to use `print` statements in production code if you'll review the script's output and you want to ensure all code ran as expected. However, when you know you're not going to review the output of a script in a terminal, it's best to remove any code that has no purpose.

## Test your script

Before using scripts in production environments, for example by integrating them with automation pipelines, you'll want to test whether the scripts work as expected.

One simple way to test your script, is to run the script in a terminal. Within the Azure Machine Learning workspace, you can quickly run a script in the terminal of the compute instance. 

When you open a script in the **Notebooks** page of the Azure Machine Learning studio, you can choose to **save and run the script in the terminal**. 

Alternatively, you can navigate directly to the terminal of the compute instance. Navigate to the **Compute** page and select the **Terminal** of the compute instance you want to use. You can use the following command to run a Python script named `train.py`:

```
python train.py
```

Outputs of `print` statements will show in the terminal. Any possible errors will also appear in the terminal. 
