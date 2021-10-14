In this unit, you'll evaluate your predictive maintenance model.

## Inspect your model

The evaluate step in the Model Screen allows you to inspect the evaluation metrics and algorithm chosed for the best model. In this example, . Remember that it's okay if your results are different from those mentioned in this module since the algorithm and hyperparameters chosen may be different. 

## Test your model

In the test your model section of the evaluate step, you can provide new data and evaluate the results of your prediction.

:::image type="content" source="../media/evaluate-machine-learning-model.png" alt-text="Make predictions with your trained model":::

### Sample data

The sample data section is where you provide input data for your model to make predictions. Each field corresponds to the columns used for your This is a convenient way to verify that the model behaves as expected. By default, Model Builder prepopulates with the first row from your dataset.

Let's test out your model to see whether it produces the expected results. 

1. In the sample data section, enter the following data:

    The data below comes from the row in your dataset with UID 161.

    | Column | Value |
    | --- | --- |
    | Product ID | L47340 |
    | Type | L |
    | Air temperature [K] | 298.4 |
    | Process temperature [K] | 308.2 |
    | Rotational speed [rpm] | 1282 |
    | Torque [Nm] | 60.7 |
    | Tool wear [min] | 216 |

1. Select **Predict**

### Results

The results section displays the prediction made by your model as well as how confident it is in its prediction.

If you look at the Machine Machine failure column of UID 161 in your dataset, you'll notice that the value is 1. This is the same as the predicted value with the highest confidence in the results section.

If you'd like, you can continue trying out your model with different input values.

In the next unit, you'll learn how to consume models in Model Builder.