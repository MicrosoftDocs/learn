In this unit, you'll add a machine learning model to a .NET class library and choose your scenario.

## Create C# Class Library

With Model Builder, you can add machine learning to an existing project or a new project. Since you're starting from scratch, create a new C# class library project.

1. Start Visual Studio
1. On the Start Window, choose **Create a new project**
1. In the Create a new project dialog, type "class library" into the search bar.
1. Select **Class Library** from the list of options. Make sure that the language is C# and select **Next**.

:::image type="content" source="../media/create-class-library-project.png" alt-text="Create class library project":::

1. In the Project name text box, type "PredictiveMaintenance". Leave the defaults for all other fields and select **Next**
1. Select **.NET 6.0 (Preview)** from the Framework dropdown and select **Create** to scaffold your C# class library.

Portability is one of the benefits that class libraries provide you. Once you're done training your model, class libraries make it easy to reference any models that are part of it from console, desktop, web, and any other type of .NET application. Therefore, if you need to reference your models in various places, it's recommended to add your models to a class library.

## Add machine learning to your project

Once your class library project opens in Visual Studio, it's time to add machine learning to it.

1. In Visual Studio's solution explorer, right-click your project.
1. Select **Add > Machine Learning Model...**.

    :::image type="content" source="../media/add-machine-learning-model.png" alt-text="Add machine learning model to project":::

1. From the list of new items in the Add New Item dialog, select **Machine Learning Model (ML.NET)**.
1. In the Name text box, use the name "PredictiveMaintenanceModel.mbconfig" for your model and select **Add**.

    :::image type="content" source="../media/create-class-library-project.png" alt-text="Create new MBConfig item":::

After a few seconds, a file called *PredictiveMaintenanceModel.mbconfig* is added to your project. Files that use the *.mbconfig* extension are Model Builder configuration files authored in JSON that allow you to:

- Provide a name for your model.
- Collaborate with others on your team via source control.
- Persist state. If at any point in the training process you need to close Model Builder, your state is saved and you can pick up right where you left off.

## Choose your scenario

In addition to adding *PredictiveMaintenanceModel.mbconfig*, the first time you add a machine learning model to a project, the Model Builder screen opens. Now it's time to select your scenario:

For our use case, we're trying to determine whether a machine is broken or not. Since there are only two options and we want to determine which state a machine is in, the data classification scenario makes the most sense.

In the Scenario step of the Model Builder screen, select the **Data classification** scenario. Once you've selected this scenario, you're immediately advanced to the Environment screen.

:::image type="content" source="../media/choose-scenario.png" alt-text="Choose data classification scenario":::

In the next unit, we'll learn some more about supported compute environments in Model Builder.

In this unit, you'll choose the compute environment to train your machine learning model

## Choose your environment

For data classification scenarios, only local environments that use your CPU are supported.

1. In the Environment step of the Model Builder screen, select **Local**
1. Select **Next step**.

:::image type="content" source="../media/choose-environment.png" alt-text="Choose local compute training environment":::

In the next unit, you'll learn how to load data into Model Builder.

In this module you'll load the predictive maintenance dataset into Model Builder

## Download the data

[Download the dataset](https://archive.ics.uci.edu/ml/machine-learning-databases/00601/) and save it anywhere on your computer.

After some time, a file with the name *ai4i2020.csv* should appear in the location you specified.

## Choose your data source type

The predictive maintenance dataset is a CSV file.

In the Data step of the Model Builder screen, select **File (csv, tsv, txt)** for Data source type.

## Provide the location of your data

Select the **Browse** button and use the file explorer to provide the location of your *ai4i2020.csv* dataset.

## Choose your label column

Choose **Machine failure** from the Column to predict (Label) dropdown

:::image type="content" source="../media/load-training-data.png" alt-text="Load predictive maintenance csv file dataset":::

## Advanced data options

By default, all columns that are not the label are used as features. As previously mentioned though, some columns contain redundant information while others don't inform the prediction. Therefore, you want to ignore those columns. To do so, use the advanced data options.

1. Select **Advanced data options...**.
1. In the Advanced data options dialog, select the **Column settings** tab.

    :::image type="content" source="../media/configure-advanced-data-options.png" alt-text="Configure advanced data options for predictive maintenance dataset":::

1. Configure the column settings as follows:

    | Columns | Purpose | Data type | Categorical |
    | --- | --- | --- | --- |
    | UDI | Ignore | Single | |
    | Product ID | Feature | String | |
    | Type | Feature | String | X |
    | Air temperature [K]| Feature | Single | |
    | Process temperature [K]| Feature | Single | |
    | Rotational speed [rpm]| Feature | Single | |
    | Torque [Nm]| Feature | Single | |
    | Tool wear [min]| Feature | Single | |
    | Machine failure| Label | Single | X |
    | TWF | Ignore | Single | X |
    | HDF | Ignore | Single | X |
    | PWF | Ignore | Single | X |
    | OSF | Ignore | Single | X |
    | RNF | Ignore | Single | X |

1. Select **Save**.
1. In the Data step of the Model Builder screen, select **Next step**.

In the next unit, you'll learn about training with Model Builder.

In this unit, you'll train a predictive maintenance model in Model Builder

## Set your training time

Model Builder automatically sets how long you should train for based on the size of your file. In this case, to help Model Builder explore more models, provide a higher number.

1. In the Train step of the Model Builder screen, set the Time to train (seconds) to 30. 
1. Select **Train**

## Tracking the training process

:::image type="content" source="../media/train-machine-learning-model.png" alt-text="Train predictive maintenance classificaiton model":::

Once the training process kicks off, Model Builder explores various models. Your training process is tracked in the Training results and in the Visual Studio output window. The training results provide information about the best model that's been found throughout the training process and the output window provides detailed information like the name of the algorithm used, how long it took to train, and the performance metrics for that model. You may see the same algorithm name appear multiple times. This happens because in addition to trying different algorithms, Model Builder is also trying different hyperparameter configurations for those algorithms. Therefore it's normal to see the same algorithm appear multiple times.

In the next unit, you'll learn how to evaluate how well your model performs.

In this unit, you'll evaluate your predictive maintenance model.

## Inspect your model

The evaluate step in the Model Screen allows you to inspect the evaluation metrics and algorithm chosen for the best model. Remember that it's okay if your results are different from those mentioned in this module since the algorithm and hyperparameters chosen may be different. 

## Test your model

In the test your model section of the evaluate step, you can provide new data and evaluate the results of your prediction.

:::image type="content" source="../media/evaluate-machine-learning-model.png" alt-text="Make predictions with your trained model":::

### Sample data

The sample data section is where you provide input data for your model to make predictions. Each field corresponds to the columns used to train your model. This is a convenient way to verify that the model behaves as expected. By default, Model Builder prepopulates with the first row from your dataset.

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

The results section displays the prediction made by your model and how confident it is in its prediction.

If you look at the Machine failure column of UID 161 in your dataset, you'll notice that the value is 1. This is the same as the predicted value with the highest confidence in the results section.

If you'd like, you can continue trying out your model with different input values.

In the next unit, you'll learn how to consume models in Model Builder.