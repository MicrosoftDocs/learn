You can increase the flexibility of your scripts by using parameters. For example, you might have created a script that trains a machine learning model. You can use the same script to train a model on different datasets, or using various hyperparameter values. 

## Working with script arguments

To use parameters in a script, you must use a library such as `argparse` to read arguments passed to the script and assign them to variables. 

For example, the following script reads an arguments named `training_data`, which specifies the path to the training data.

```python
# import libraries
import argparse
import pandas as pd
from sklearn.linear_model import LogisticRegression

def main(args):
    # read data
    df = get_data(args.training_data)

# function that reads the data
def get_data(path):
    df = pd.read_csv(path)
    
    return df

def parse_args():
    # setup arg parser
    parser = argparse.ArgumentParser()

    # add arguments
    parser.add_argument("--training_data", dest='training_data',
                        type=str)

    # parse args
    args = parser.parse_args()

    # return args
    return args

# run script
if __name__ == "__main__":

    # parse args
    args = parse_args()

    # run main function
    main(args)
```

Any parameters you expect should be defined in the script. In the script, you can specify what type of value you expect for each parameter and whether you want to set a default value.

## Passing arguments to a script

To pass parameter values to a script, you need to provide the argument value in the command. 

For example, if you would pass a parameter value when running a script in a terminal, you would use the following command:

```
python train.py --training_data diabetes.csv
```

In the example, `diabetes.csv` is a local file. Alternatively, you could specify the path to a data asset created in the Azure Machine Learning workspace.

Similarly, when you want to pass a parameter value to a script you want to run as a command job, you'll specify the values in the command:

```python
from azure.ai.ml import command

# configure job
job = command(
    code="./src",
    command="python train.py --training_data diabetes.csv",
    environment="AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest",
    compute="aml-cluster",
    display_name="train-model",
    experiment_name="train-classification-model"
    )
```

After submitting a command job, you can review the input and output parameters you specified. 
