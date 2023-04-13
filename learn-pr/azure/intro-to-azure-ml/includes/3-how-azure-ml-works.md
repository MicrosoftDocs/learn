Using Azure Machine Learning requires an Azure account and Azure subscription. The subscription has standard and free pricing tiers and provides an endpoint and subscription key to access the service.

You can access Azure ML on the cloud or on your local machine through the R or Python software development kit (SDK), REST API, and Command Line Interface (CLI) extension. If you prefer low or no-code options, then Azure ML studio can be used to quickly train and deploy machine learning models.

Azure ML manages all the resources you need for the ML lifecycle inside a Workspace. Workspaces can be shared by multiple people and include things like the computing resources available for your notebooks, training clusters, and pipelines. Workspaces are also the logical containers for your data stores and a repository for models and anything else within the model life cycle.

![azure ml lifecycle.](../media/3-people.gif)

## How to create machine learning models

Models can be created using the SDK, imported from ML frameworks, or without code using the Azure ML studio. When you connect to a workspace, you can select various development environments with preloaded packages that contain curated environments for popular frameworks, such as TensorFlow and PyTorch. Compute targets can then be chosen to run a training script locally or on a virtual machine to create a model. Compute targets within Azure ML can automatically scale up and manage jobs to use GPU and CPU resources efficiently.

The status of runs can be logged and monitored natively via the SDK, Azure Monitor, and Azure ML studio—or by installing packages to run MLFlow and TensorBoard. These monitor requests can be set up to email information for each iteration, like completed and failed runs, or trigger another function like model registration. Visualization of training runs can then be viewed within the Azure studio or Workspace to drill down on results and metrics.

In the following example, we can see how Azure ML studio’s visualization can be customized to add charts, compare data, and apply filters to better analyze your results and metrics.

:::image type="content" source="../media/3-studio-chart.gif" alt-text="azure ml studio visualization example." lightbox="../media/3-studio-chart.gif":::

### Experiments

To train a model in Azure ML, you run an **experiment**—which is when a training script is run that can generate metrics and outputs that are tracked. You can run the same experiment multiple times with different hyperparameters, data, code, or settings. The Workspace keeps a history of all training runs, including logs, metrics, outputs, and a snapshot of your scripts within the environment. In a collaborative project, experiment logs are a great way to review and track progress. They can show who is publishing or changing models, why changes were made, and when models were deployed or used in production.

### Pipelines

A pipeline is a workflow of a complete machine learning task that can include data preparation, training, testing, and deployment. Pipelines have many uses. You can make a pipeline that trains models, makes predictions in real-time, or one that only cleans data. Because each step in a pipeline is independent, multiple people can work on different steps within the same pipeline at once. _Azure ML Pipelines_ can save you time by only rerunning steps whose inputs have changed—drastically reducing runtimes if you're simply tweaking hyperparameters or other steps. Both _Azure Data Factory_ and Azure Pipelines provide out-of-the-box pipelines for Azure ML, so you can focus on machine learning instead of infrastructure.

### Datasets

You can create datasets from datastores, public URLs, and Azure Open Datasets. By creating a dataset, you reference the data source location—so data from training sets and pipelines will be stored without altering the original dataset. Datasets can then be registered, versioned, tracked, and traced to permit reuse and sharing across teams, roles, and experiments quickly. The versioning of reproducible experiments is also possible, allowing better analysis of dataset viability and model performance.

Azure ML can periodically check for newly stored data with an **incremental refresh,** enabling datasets to be updated automatically when new data is added to the datastore. The service can also analyze data for changes over time—known as **data drift**—and trigger an alert. Datasets and features can then be viewed in the dashboard to analyze the data drift, as seen in the following example.

:::image type="content" source="../media/3-datadrifts.gif" alt-text="azure ml data drifts dashboard." lightbox="../media/3-datadrifts.gif":::

### Labeling

_Labeling Projects_ is a centralized place to create, manage, and monitor labeling tasks. All data labeling projects can be administered via the Azure ML studio or Workspace dashboard, where team members can view progress and assist in collaborative labeling projects. Human-in-the-loop labeling can take place here, allowing team members to manually add tags to train the ML-labeling models. After enough labels are submitted, a classification model is used to predict tags. Team members can then accept or reject instances of ML-tagged data to help train the labeling model’s accuracy. Eventually, the model will be capable of labeling the data without assistance.

Below we can see an example of a labeling task underway in Azure ML studio.

:::image type="content" source="../media/3-labeling.gif" alt-text="azure ml studio labeling." lightbox="../media/3-labeling.gif":::

## Deploying machine learning models

There are three primary paths to deploy and publish models. With the first way, you can use Azure ML studio’s built-in service to assign appropriate compute resources and package your models to push to an app service or function. In the second way, Azure ML can package and run models in Docker containers for deployment. These containers are separate from the run script, so you can quickly swap or update your models with improved ones while leaving the script unmodified. The final way to publish your models is to download the model into the _Open Neural Network Exchange (ONNX)_ format, which imparts broad flexibility in potential deployment platforms and devices—such as iOS, Android, and Linux.

Azure ML provides pre-packaged container images that include stable environments, with preloaded Python packages and settings. These container images help you deploy to popular machine learning frameworks such as TensorFlow and PyTorch with minimal setup.
