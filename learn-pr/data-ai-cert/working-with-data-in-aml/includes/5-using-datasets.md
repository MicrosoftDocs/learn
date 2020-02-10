You can read data directly from a dataset, or you can pass a dataset as a named *input* to a script configuration or estimator.

## Working with a Dataset Directly

If you have a reference to a dataset, you can access its contents directly.

For tabular datasets, most data processing begins by reading the dataset as a Pandas dataframe:

```python
df = tab_ds.to_pandas_dataframe()
# code to work with dataframe goes here
```

When working with a file dataset, you can use the **to_path()** method to return a list of the file paths encapsulated by the dataset:

```python
for file_path in file_ds.to_path():
    print(file_path)
```

## Passing a Dataset to an Experiment Script

When you need to access a dataset in an experiment script, you can pass the dataset as an *input* to a **ScriptRunConfig** or an **Estimator**. For example, the following code passes a tabular dataset to an estimator:

```python
estimator = SKLearn( source_directory='experiment_folder',
                     entry_script='training_script.py',
                     compute_target='local',
                     inputs=[tab_ds.as_named_input('csv_data')],
                     pip_packages=['azureml-dataprep[pandas]')
```

Since the script will need to work with a **Dataset** object, you must include either the full **azureml-sdk** package or the **azureml-dataprep** package with the **pandas** extra library in the script's compute environment.

In the experiment script itself, you can access the input and work with the **Dataset** object it references like this:

```python
run = Run.get_context()
data = run.input_datasets['csv_data'].to_pandas_dataframe()
```

When passing a file dataset, you must specify the access mode. For example:

```python
estimator = Estimator( source_directory='experiment_folder',
                     entry_script='training_script.py'
                     compute_target='local',
                     inputs=[img_ds.as_named_input('img_data').as_download(path_on_compute='data')],
                     pip_packages=['azureml-dataprep[pandas]')
```
