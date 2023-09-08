MLflow uses the MLModel format to store all relevant model assets in a folder or directory. One essential file in the directory is the `MLmodel` file. The `MLmodel` file is the single source of truth about how the model should be loaded and used.

## Explore the MLmodel file format

The `MLmodel` file may include:

- `artifact_path`: During the training job, the model is logged to this path.
- `flavor`: The machine learning library with which the model was created.
- `model_uuid`: The unique identifier of the registered model.
- `run_id`: The unique identifier of job run during which the model was created.
- `signature`: Specifies the schema of the model's inputs and outputs:
    - `inputs`: Valid input to the model. For example, a subset of the training dataset.
    - `outputs`: Valid model output. For example, model predictions for the input dataset.

An example of a MLmodel file created for a computer vision model trained with `fastai` may look like: 

```yml
artifact_path: classifier
flavors:
  fastai:
    data: model.fastai
    fastai_version: 2.4.1
  python_function:
    data: model.fastai
    env: conda.yaml
    loader_module: mlflow.fastai
    python_version: 3.8.12
model_uuid: e694c68eba484299976b06ab9058f636
run_id: e13da8ac-b1e6-45d4-a9b2-6a0a5cfac537
signature:
  inputs: '[{"type": "tensor",
             "tensor-spec": 
                 {"dtype": "uint8", "shape": [-1, 300, 300, 3]}
           }]'
  outputs: '[{"type": "tensor", 
              "tensor-spec": 
                 {"dtype": "float32", "shape": [-1,2]}
            }]'

```

The most important things to set are the **flavor** and the **signature**. 

### Choose the flavor

A **flavor** is the machine learning library with which the model was created. 

For example, to create an image classification model to detect breast cancer you're using `fastai`. Fastai is a flavor in MLflow that tells how you how a model should be persisted and loaded. Because each model flavor indicates how they want to persist and load models, the MLModel format doesn't enforce a single serialization mechanism that all the models need to support. Such a decision allows each flavor to use the methods that provide the best performance or best support according to their best practices - without compromising compatibility with the MLModel standard. 

`Python function` flavor is the *default* model interface for models created from an MLflow run. Any MLflow python model can be loaded as a `python_function` model, which allows for workflows like deployment to work with any python model regardless of which framework was used to produce the model. This interoperability is immensely powerful as it reduces the time to operationalize in multiple environments.

An example of the Python function flavor may look like:

```yml

artifact_path: pipeline
flavors:
  python_function:
    env:
      conda: conda.yaml
      virtualenv: python_env.yaml
    loader_module: mlflow.sklearn
    model_path: model.pkl
    predict_fn: predict
    python_version: 3.8.5
  sklearn:
    code: null
    pickled_model: model.pkl
    serialization_format: cloudpickle
    sklearn_version: 1.2.0
mlflow_version: 2.1.0
model_uuid: b8f9fe56972e48f2b8c958a3afb9c85d
run_id: 596d2e7a-c7ed-4596-a4d2-a30755c0bfa5
signature:
  inputs: '[{"name": "age", "type": "long"}, {"name": "sex", "type": "long"}, {"name":
    "cp", "type": "long"}, {"name": "trestbps", "type": "long"}, {"name": "chol",
    "type": "long"}, {"name": "fbs", "type": "long"}, {"name": "restecg", "type":
    "long"}, {"name": "thalach", "type": "long"}, {"name": "exang", "type": "long"},
    {"name": "oldpeak", "type": "double"}, {"name": "slope", "type": "long"}, {"name":
    "ca", "type": "long"}, {"name": "thal", "type": "string"}]'
  outputs: '[{"name": "target", "type": "long"}]'
```

### Configure the signature

Apart from flavors, the `MLmodel` file also contains signatures that serve as data contracts between the model and the server running your model.
 
There are two types of signatures:

- **Column-based**: used for tabular data with a `pandas.Dataframe` as inputs.
- **Tensor-based**: used for n-dimensional arrays or tensors (often used for unstructured data like text or images), with `numpy.ndarray` as inputs.

As the `MLmodel` file is created when you register the model, the signature also is created when you register the model. When you enable MLflow's autologging, the signature is inferred in the best effort way. If you want the signature to be different, you need to manually log the model. 

The signature's inputs and outputs are important when deploying your model. When you use Azure Machine Learning's no-code deployment for MLflow models, the inputs and outputs set in the signature will be enforced. In other words, when you send data to a deployed MLflow model, the expected inputs and outputs need to match the schema as defined in the signature.

> [!Tip]
> Learn more about [model signatures in MLflow](https://www.mlflow.org/docs/latest/models.html#model-signature?azure-portal=true).