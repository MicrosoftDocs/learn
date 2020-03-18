To train a classification model, you need a dataset that includes historical *features* (characteristics of the entity for which you want to make a prediction) and known *label* values (the class indicator that you want to train a model to predict).

## Create a dataset

In Azure Machine Learning, data for model training and other operations is usually encapsulated in an object called a *dataset*.

1. In [Azure Machine Learning studio](https://ml.azure.com), view the **Datasets** page. Datasets represent specific data files or tables that you plan to work with in Azure ML.
2. Create a dataset from web files, using the following settings:
    * **Basic Info**:
        * **Web URL**: https://aka.ms/diabetes-data
        * **Name**: diabetes-data
        * **Dataset type**: Tabular
        * **Description**: Diabetes data
    * **Settings and preview**:
        * **File format**: Delimited
        * **Delimiter**: Comma
        * **Encoding**: UTF-8
        * **Column headers**: Use headers from first file
        * **Skip rows**: None
    * **Schema**:
        * Include all columns other than **Path**
        * Review the automatically detected types
    * **Confirm details**:
        * Do not profile the dataset after creation
3. After the dataset has been created, open it and view the **Explore** page to see a sample of the data. This data represents details from patients who have been tested for diabetes.

## Create a pipeline

To get started with Azure Machine Learning designer, first you must create a pipeline and add the dataset you want to work with.

1. In [Azure Machine Learning studio](https://ml.azure.com) for your workspace, view the **Designer** page and select **+** to create a new pipeline.
2. In the **Settings** pane, change the default pipeline name (**Pipeline-Created-on-*date***) to **Diabetes Training** (if the **Settings** pane is not visible, click the **&#9881;** icon next to the pipeline name at the top).
3. Note that you need to specify a compute target on which to run the pipeline. In the **Settings** pane, click **Select compute target** and select the **aml-cluster** compute target you created previously.
4. On the left side of the designer, expand the **Datasets** section, and drag the **diabetes-data** dataset you created in the previous exercise onto the canvas.
5. Select the **diabetes-data** dataset on the canvas, and view its settings (the settings pane for the dataset may open automatically and cover the canvas). On the **outputs** tab, select the **Visualize** icon (which looks like a column chart).
6. Review the schema of the data, noting that you can see the distributions of the various columns as histograms.
7. Scroll to the right and select the column heading for the **Diabetic** column, and note that it contains two values **0** and **1**. These values represent the two possible classes for the *label* that your model will predict, with a value of **0** meaning that the patient does not have diabetes, and a value of **1** meaning that the patient is diabetic.
8. Scroll back to the left and review the other columns, which represent the *features* that will be used to predict the label. Note that most of these columns are numeric, but each feature is on its own scale. For example, **Age** values range from 21 to 77, while **DiabetesPedigree** values range from 0.078 to 2.3016. When training a machine learning model, it is sometimes possible for larger values to dominate the resulting predictive function, reducing the influence of features that on a smaller scale. Typically, data scientists mitigate this possible bias by *normalizing* the numeric columns so they're on the similar scales.
9. Close the **diabetes-data result visualization** window, and then close or resize the settings pane using the X or **<sub>&#8599;</sub><sup>&#8601;</sup>** icon.

## Add Transformations

Before you can train a model, you typically need to apply some preprocessing transformations to the data.

1. In the pane on the left, collapse the **Datasets** section if it is still expanded, and expand the **Data Transformation** section, which contains a wide range of modules you can use to transform data before model training.
2. Drag a **Normalize Data** module to the canvas, below the **diabetes-data** dataset. Then connect the output from the **diabetes-data** dataset to the input of the **Normalize Data** module.
3. Select the **Normalize Data** module and view its settings, noting that it requires you to specify the transformation method and the columns to be transformed.
4. Set the transformation to **MinMax** and edit the columns to include the following columns by name, as shown in the image:
    - **Pregnancies**
    - **PlasmaGlucose**
    - **DiastolicBloodPressure**
    - **TricepsThickness**
    - **SerumInsulin**
    - **BMI**
    - **DiabetesPedigree**
    - **Age**

> [!div class="centered"]
> ![columns selected for normalization](../media/normalize-data.png)

The data transformation is normalizing the numeric columns to put them on the same scale, which should help prevent columns with large values from dominating model training. You'd usually apply a whole bunch of pre-processing transformations like this to prepare your data for training, but we'll keep things simple in this exercise.

## Run the pipeline

To see the effect of your data transformations, you need to run the pipeline as an experiment.

1. Ensure your pipeline looks similar to this:

> [!div class="centered"]
> ![diabetes-data dataset with Normalize Data module](../media/data-prep-pipeline.png)

2. Select **Submit**, and run the pipeline as a new experiment named **diabetes-training**.
3. Wait for the run to complete - this may take a few minutes.
4. When the run has completed (indicated by a &#x2705; icon for each module other than the dataset), select the **Normalize Data** module and in the settings pane, on the **Outputs + Logs** tab, under **Port outputs** in the **Transformed dataset** section, use the **Visualize** icon to view the transformed columns.
5. Close the **Normalize Data** visualization, then close or resize the settings pane using the X or **<sub>&#8599;</sub><sup>&#8601;</sup>** icon.

The dataset is now prepared for model training.
