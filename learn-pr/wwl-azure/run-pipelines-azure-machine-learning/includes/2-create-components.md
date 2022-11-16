

**Components** allow you to create reusable scripts that can easily be shared across users within the same Azure Machine Learning workspace. You can also use components to build an Azure Machine Learning pipeline.

## Use a component

There are two main reasons why you'd use components:

- To build a pipeline.
- To share ready-to-go code.

You'll want to create components when you're *preparing your code for scale*. When you're done with experimenting and developing, and ready to move your model to production. 

Within Azure Machine Learning, you can create a component to store code (in your preferred language) within the workspace. Ideally, you design a component to perform a specific action that is relevant to your machine learning workflow. 

For example, a component may consist of a Python script that normalizes your data, trains a machine learning model, or evaluates a model.

Components can be easily shared to other Azure Machine Learning users, who can reuse components in their own Azure Machine Learning pipelines. 

:::image type="content" source="../media/01-01-components.png" alt-text="Screenshot of available components in the Azure Machine Learning workspace.":::


## Create a component

A component consists of three parts:

- **Metadata**: Includes the component's name, version, etc.
- **Interface**: Includes the expected input parameters (like a dataset or hyperparameter) and expected output (like metrics and artifacts).
- **Command, code and environment**: Specifies how to run the code.
 
To create a component, you need two files:

- A script that contains the workflow you want to execute. 
- A YAML file to define the metadata, interface, and command, code, and environment of the component.

You can create the YAML file, or use the `command_component()` function as a decorator to create the YAML file.

> [!Tip]
> Here, we'll focus on creating a YAML file to create a component. Alternatively, learn more about [how to create components using `command_component()`](/azure/machine-learning/how-to-create-component-pipeline-python?azure-portal=true). 

For example, you may have a Python script `prep.py` that prepares the data by removing missing values and normalizing the data:

```python
# import libraries
import argparse
import pandas as pd
import numpy as np
from pathlib import Path
from sklearn.preprocessing import MinMaxScaler

# setup arg parser
parser = argparse.ArgumentParser()

# add arguments
parser.add_argument("--input_data", dest='input_data',
                    type=str)
parser.add_argument("--output_data", dest='output_data',
                    type=str)

# parse args
args = parser.parse_args()

# read the data
df = pd.read_csv(args.input_data)

# remove missing values
df = df.dropna()

# normalize the data    
scaler = MinMaxScaler()
num_cols = ['feature1','feature2','feature3','feature4']
df[num_cols] = scaler.fit_transform(df[num_cols])

# save the data as a csv
output_df = df.to_csv(
    (Path(args.output_data) / "prepped-data.csv"), 
    index = False
)
```

To create a component for the `prep.py` script, you'll need a YAML file `prep.yml`:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/commandComponent.schema.json
name: prep_data
display_name: Prepare training data
version: 1
type: command
inputs:
  input_data: 
    type: uri_file
outputs:
  output_data:
    type: uri_file
code: ./src
environment: azureml:AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest
command: >-
  python prep.py 
  --input_data ${{inputs.input_data}}
  --output_data ${{outputs.output_data}}
```

Notice that the YAML file refers to the `prep.py` script, which is stored in the `src` folder. You can load the component with the following code:

```python
from azure.ai.ml import load_component
parent_dir = ""

loaded_component_prep = load_component(source=parent_dir + "./prep.yml")
```

When you've loaded the component, you can use it in a pipeline or register the component.

## Register a component

To use components in a pipeline, you'll need the script and the YAML file. To make the components accessible to other users in the workspace, you can also register components to the Azure Machine Learning workspace.

You can register a component with the following code:

```python
prep = ml_client.components.create_or_update(prepare_data_component)
```