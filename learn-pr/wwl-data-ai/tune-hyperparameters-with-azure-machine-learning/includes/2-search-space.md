The set of hyperparameter values tried during hyperparameter tuning is known as the *search space*. The definition of the range of possible values that can be chosen depends on the type of hyperparameter.

## Discrete hyperparameters

Some hyperparameters require *discrete* values - in other words, you must select the value from a particular set of possibilities. You can define a search space for a discrete parameter using a **choice** from a list of explicit values, which you can define as a Python **list** (`choice([10,20,30])`), a **range** (`choice(range(1,10))`), or an arbitrary set of comma-separated values (`choice(30,50,100)`)

You can also select discrete values from any of the following discrete distributions:

- qnormal
- quniform
- qlognormal
- qloguniform

## Continuous hyperparameters

Some hyperparameters are *continuous* - in other words you can use any value along a scale. To define a search space for these kinds of value, you can use any of the following distribution types:

- normal
- uniform
- lognormal
- loguniform

## Defining a search space

To define a search space for hyperparameter tuning, create a dictionary with the appropriate parameter expression for each named hyperparameter.  For example, the following search space indicates that the **batch_size** hyperparameter can have the value 16, 32, or 64, and the **learning_rate** hyperparameter can have any value from a normal distribution with a mean of 10 and a standard deviation of 3.

```python
from azureml.train.hyperdrive import choice, normal

param_space = {
                 '--batch_size': choice(16, 32, 64),
                 '--learning_rate': normal(10, 3)
              }
```
