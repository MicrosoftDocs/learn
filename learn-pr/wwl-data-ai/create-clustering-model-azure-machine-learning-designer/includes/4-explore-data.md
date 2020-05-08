To train a clustering model, you need a dataset that includes multiple observations of the items you want to cluster, including numeric features that can be used to determine similarities between individual cases that will help separate them into clusters.

## Create a dataset

In Azure Machine Learning, data for model training and other operations is usually encapsulated in an object called a *dataset*. In this module, you'll use a well-known dataset that includes measurements for three species of iris flower.

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), view the **Datasets** page. Datasets represent specific data files or tables that you plan to work with in Azure ML.
2. Create a dataset from web files, using the following settings:
    * **Basic Info**:
        * **Web URL**: http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data
        * **Name**: iris
        * **Dataset type**: Tabular
        * **Description**: Iris data
    * **Settings and preview**:
        * **File format**: Delimited
        * **Delimiter**: Comma
        * **Encoding**: UTF-8
        * **Column headers**: No headers
        * **Skip rows**: None
    * **Schema**:
        * Include all columns other than **Path**
        * Review the automatically detected types
    * **Confirm details**:
        * Do not profile the dataset after creation
3. After the dataset has been created, open it and view the **Explore** page to see a sample of the data. This data represents measurements of the sepal length, sepal width, petal length, and petal width for multiple observations of iris flowers. There are three species of iris represented in the dataset, Setosa, Versicolor, and Virginica.

> [!NOTE]
> You can learn more about the Iris dataset at https://archive.ics.uci.edu/ml/datasets/Iris.

## Create a pipeline

To get started with Azure machine Learning designer, first you must create a pipeline and add the dataset you want to work with.

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true) for your workspace, view the **Designer** page and create a new pipeline.
2. In the **Settings** pane, change the default pipeline name (**Pipeline-Created-on-*date***) to **Iris Training** (if the **Settings** pane is not visible, click the **&#9881;** icon next to the pipeline name at the top).
3. Note that you need to specify a compute target on which to run the pipeline. In the **Settings** pane, click **Select compute target** and select the **aml-cluster** compute target you created in the previous lab.
4. On the left side of the designer, expand the **Datasets** section, and drag the **iris** dataset you created in the previous exercise onto the canvas.
5. Select the **iris** module on the canvas, and view its settings (the settings pane for the dataset may open automatically and cover the canvas). Then on the **outputs** tab, in the **Dataset output** section, click the **Visualize** icon (which looks like a column chart).
6. Review the schema of the data, noting that you can see the distributions of the various columns as histograms.
7. Close the iris visualization, and then close or resize its settings pane using the X or **<sub>&#8599;</sub><sup>&#8601;</sup>** icon so you can see the dataset on the pipeline canvas.

Now that you have the dataset, you're ready to use it to train a clustering model.
