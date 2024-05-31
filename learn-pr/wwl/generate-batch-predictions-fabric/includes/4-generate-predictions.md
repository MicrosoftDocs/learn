To generate predictions, you need to apply a trained model to new data. The data you want to apply the model to should be stored in a Delta table, and the model should be saved in the Microsoft Fabric workspace. You can then use the PREDICT function to apply the model to the data and get batch predictions.

## Use the wizard to generate the PREDICT function

An easy way to develop the code to generate the batch predictions is to use the wizard available in Microsoft Fabric.

Once you've saved a model, you can navigate to the model's page in Microsoft Fabric. When you select the option to **Apply this version in wizard**, a pop-up appears:

:::image type="content" source="../media/custom-wizard.png" alt-text="Screenshot of model wizard for a custom model.":::

Through the wizard you can select the input table, map the input columns to the model's expected inputs, and define the output table and columns. Finally, the code you need to run the batch predictions is generated for you.

## Run the PREDICT function to apply the model

You can use the wizard or directly create the code to generate predictions. To apply a model in a notebook, you create the `MLFlowTransformer` object with the following parameters:

- `inputCols`: The column names of the dataframe passed as model inputs.
- `outputCols`: The column(s) name of the output or predictions.
- `modelName`: The name of the saved model in Microsoft Fabric.
- `modelVersion`: The version of the saved model.

```python
from synapse.ml.predict import MLFlowTransformer

model = MLFlowTransformer(
    inputCols=["AGE","SEX","BMI","BP","S1","S2","S3","S4","S5","S6"],
    outputCol='predictions',
    modelName='diabetes-model',
    modelVersion=1
)
```

After creating the `MLFlowTransformer` object, you can use it to generate the batch predictions on the dataframe `df` by running the following code:

```python
model.transform(df).show()
```

Finally, you can save the predictions to a Delta table. You can choose to save it to a new table, or append the predictions to an existing table. If you want to specify an existing table:

```python
df.write.format("delta").mode("overwrite").save(f"Tables/your_delta_table")
```

> [!Note]
> When accessing a Delta table through the user interface of the Microsoft Fabric workspace, you can easily copy the path of a Delta table. The path's format should be similar to `abfss://XXXX@msit-onelake.dfs.fabric.microsoft.com/XXX/Tables/your_delta_table` and can be used whenever you want to read data from or write data to the table.
