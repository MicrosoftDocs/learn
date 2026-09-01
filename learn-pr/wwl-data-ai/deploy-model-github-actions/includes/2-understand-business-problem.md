To get value from a machine learning model, you **deploy** it so it can generate predictions whenever the business needs them. Before you deploy, though, you make a few decisions that shape how the rest of the pipeline works.

At Proseware, a health care technology company, the data science team trains a classification model that predicts whether a patient is likely to miss an upcoming clinic appointment. Clinic staff use this no-show risk score to decide which patients to call ahead of time to confirm, so the clinic can fill slots that would otherwise go empty. The model is accurate enough for production use. Your challenge is to get it serving predictions reliably, in a process the team can repeat every time the model gets retrained.

## Choose an endpoint type

Azure Machine Learning supports two endpoint types, and the choice depends on how the prediction gets consumed. A **batch endpoint** generates predictions for a large set of records on a schedule, which suits periodic scoring jobs. An **online endpoint** returns a prediction synchronously, with low latency, the moment it receives a request.

Proseware's scheduling system calls the model as soon as staff book or reschedule an appointment, so it can immediately flag high-risk appointments for a confirmation call that day. Because the prediction needs to come back right away, the team deploys the model to a managed **online endpoint**.

## Register the model with MLflow

The data science team trains the no-show risk model and packages it with **MLflow**, an open-source platform for tracking machine learning experiments and packaging models in a standard format. When the training script calls `mlflow.autolog()`, MLflow automatically logs the model, its parameters, and its metrics as part of the training job's output.

Because the model is packaged as an MLflow model, you can register it directly from the job's output without writing a custom scoring script or defining an environment yourself. Azure Machine Learning generates both from the model's MLflow metadata during deployment, a capability known as **no-code deployment**. A team working with a custom model format, such as a pickle file, would need to author and maintain that scoring script and environment.

> [!TIP]
> Learn more about [deploying MLflow models in Azure Machine Learning](/azure/machine-learning/how-to-deploy-mlflow-models).

To register the model, you point to either a completed training job's output or a model file stored in a workspace datastore. Once registered, the model becomes a versioned asset in the workspace that you, or an automated workflow, can reference by name and version when you create a deployment.

As the model evolves, register changed artifacts as new versions instead of replacing an existing version. You can update a version's description and tags, but other changes require a new version. Archive versions that you no longer want in default lists. Archiving doesn't delete a model, and workflows can still reference an archived version when necessary.

> [!TIP]
> Learn more about [managing registered models](/azure/machine-learning/how-to-manage-models).

## Plan for repeatable deployment

Registering and deploying a model manually works for a first release, but Proseware expects to retrain the no-show model regularly as new appointment data comes in. Repeating the same manual steps for every new version is slow and error-prone, so the team's goal is to automate registration, deployment, and testing through a pipeline, which is what the rest of this module builds toward.