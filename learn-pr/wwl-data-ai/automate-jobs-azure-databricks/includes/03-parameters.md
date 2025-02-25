When you want to scale your data engineering processes, you can run the same code with varying inputs to optimize your workflows for different datasets, environments, or use cases. To create dynamic and reusable workflows, you can pass different **parameters** to your notebooks or jobs.

## Understand the benefit of parameters

The primary benefit of parameters is the enhancement of reusability and maintainability of your code. By decoupling the logic from the data or environment-specific values, you can develop more modular and scalable workflows.

Parameterization also simplifies testing and debugging, as you can easily switch between different parameter sets to validate your code's behavior under various conditions. Parameterization also supports better collaboration among team members, as they can use the same notebook or job with their own parameter values.

Let's explore how you can use parameters in notebooks, jobs, and job templates within Azure Databricks.

## Use parameters in notebooks

When you're working in notebooks in Azure Databricks, you can use **widgets** to define and retrieve parameters.

In notebooks, widgets act as input fields that allow you to specify parameter values before running a notebook. You can create text boxes, drop-down lists, and other types of input widgets.

For example, you can create a text widget with `dbutils.widgets.text("param_name", "default_value")`. You can then retrieve the widget's value with `dbutils.widgets.get("param_name")`.

:::image type="content" source="../media/widget.png" alt-text="Screenshot of widget in a notebook in Azure Databricks." lightbox="../media/widget.png":::

When you use widgets to define and retrieve parameters, your notebooks are more interactive and adaptable to different scenarios.

## Pass parameters to jobs

When you define a job in Azure Databricks, you can pass parameters to the job, making it possible to run the same job with different configurations.

You can define a job's parameters through the Azure Databricks UI or by using the REST API.

:::image type="content" source="../media/job-parameter.png" alt-text="Screenshot of parameter in jobs in Azure Databricks." lightbox="../media/job-parameter.png":::

When you use parameters when running a job, you ensure that a job run can be tailored to specific requirements without needing to modify the underlying code. Especially in production environments where jobs need to be triggered with varying inputs based on external factors or schedules, this can be useful.
