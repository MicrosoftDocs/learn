


Create an MLFlowTransformer object to load the model for inferencing. To create an MLFlowTransformer object for generating batch predictions, you must do the following:

specify which columns from the test DataFrame you need as model inputs (in this case, all of them),
choose a name for the new output column (in this case, predictions), and
provide the correct model name and model version for generating those predictions.
If you're using your own model, substitute the values for the input columns, output column name, model name, and model version.

Python

Copy
from synapse.ml.predict import MLFlowTransformer

# You can substitute values below for your own input columns,
# output column name, model name, and model version
model = MLFlowTransformer(
    inputCols=test.columns,
    outputCol='predictions',
    modelName='diabetes-model',
    modelVersion=1
)
Generate predictions using the PREDICT function. To invoke the PREDICT function, you can use the Transformer API, the Spark SQL API, or a PySpark user-defined function (UDF). The following sections show how to generate batch predictions with the test data and model defined in the previous steps, using the different methods for invoking PREDICT.

PREDICT with the Transformer API
The following code invokes the PREDICT function with the Transformer API. If you've been using your own model, substitute the values for the model and test data.

Python

Copy
# You can substitute "model" and "test" below with values  
# for your own model and test data 
model.transform(test).show()