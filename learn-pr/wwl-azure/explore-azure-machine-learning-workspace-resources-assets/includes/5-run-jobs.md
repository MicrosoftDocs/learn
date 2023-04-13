

To train models with the Azure Machine Learning workspace, you have several options:

- Use the **designer** in the Azure Machine Learning studio.
- Use **Automated Machine Learning**.
- Run a Jupyter notebook.
- Run a script as a job.

## Author and run a pipeline with the designer

In the Azure Machine Learning studio, you can use the designer when you want to use a drag and drop web-based user interface (UI) to create and run pipelines. 

You can create a pipeline by using the built-in or custom components. 

:::image type="content" source="../media/designer-canvas.png" alt-text="Screenshot of a sample pipeline created in the Designer." lightbox="../media/designer-canvas.png":::

The designer is ideal for easy and quick exploration during the initial phase of training machine learning models. 

You can also use the designer to swiftly create pipelines using components you've created and registered in the workspace.

## Explore algorithms and hyperparameter values with Automated Machine Learning

When you have a training dataset and you're tasked with finding the best performing model, you may want to experiment with various algorithms and hyperparameter values. 

Manually experimenting with different configurations to train a model may take long. Alternatively, you can use Automated Machine Learning to speed up the process. 

Automated Machine Learning iterates through algorithms paired with feature selections to find the best performing model for your data.

:::image type="content" source="../media/automated-machine-learning.png" alt-text="Screenshot of a task selection when configuring Automated Machine Learning.":::

## Run a Jupyter notebook

When you prefer to develop by running code in notebooks, you can use the built-in notebook feature in the workspace. 

The **Notebooks** page in the studio allows you to edit and run Jupyter notebooks. 

:::image type="content" source="../media/notebooks.png" alt-text="Screenshot of an open notebook in the Azure Machine Learning studio.":::

All files you clone or create in the notebooks section are stored in the file share of the Azure Storage account created with the workspace.

To run notebooks, you'll use a compute instance as they're ideal for development and work similar to a virtual machine.

You can also choose to edit and run notebooks in Visual Studio Code, while still using a compute instance to run the notebooks.

## Run a script as a job

When you want to prepare your code to be production ready, it's better to use scripts. You can easily automate the execution of script to automate any machine learning workload.

You can run a script as a **job** in Azure Machine Learning. When you submit a job to the workspace, all inputs and outputs will be stored in the workspace.

:::image type="content" source="../media/job-overview.png" alt-text="Screenshot of the overview of a command job showing the properties, inputs, and outputs.":::

There are different types of jobs depending on how you want to execute a workload:

- **Command**: Execute a single script.
- **Sweep**: Perform hyperparameter tuning when executing a single script.
- **Pipeline**: Run a pipeline consisting of multiple scripts or components.

> [!Note]
> When you submit a pipeline you created with the designer it will run as a pipeline job. When you submit an Automated Machine Learning experiment, it will also run as a job. 
