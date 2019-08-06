Container images allow users to deploy models reliably since the machine learning model always depends on some other dependencies such as [PyTorch](https://pytorch.org/). Using containers to deploy machine learning models can avoid dependency issues.

A container image has the following items packaged, which you need to prepare:

- The model itself
- The inference engine, such as PyTorch
- The scoring file (`score.py`) or other application consuming the model
- Any dependencies needed

The first step is to create the `score.py` file that consumes the model, like below. You only need to define two functions: `init`, which loads the model and `run`, which does the inference:

```python
%%writefile score.py
from sklearn.externals import joblib
from sklearn.linear_model import Ridge
from azureml.core.model import Model
import json

def init():
    global model
    model_path = Model.get_model_path('sklearn_regression_model.pkl')
    # deserialize the model file back into a sklearn model
    model = joblib.load(model_path)
# note you can pass in multiple rows for scoring
def run(raw_data):
    try:
        data = json.loads(raw_data)['data']
        data = numpy.array(data)
        result = model.predict(data)
        # you can return any datatype if it is JSON-serializable
        return result.tolist()
    except Exception as e:
        error = str(e)
        return error
```