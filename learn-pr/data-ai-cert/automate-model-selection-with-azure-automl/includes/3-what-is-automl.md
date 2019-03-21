Data science involves model selection and determination of hyperparameter values. Consider a house price prediction problem.  There are multiple model choices, such as linear regression, random forest, and so on. Which model should the data scientist select?  Often many models may be good options so the data scientist must try each one and compare results. AutoML provides an automated solution, let Azure Machine Learning Services run all the models concurrently, compare the results, and recommend the best model for the job.

Many models include parameters that cannot be learned from the model training process. These are called hyperparameters and usually have a large impact on model accuracy. Data scientists typically experiment with different values until they find the optimal values.  This is a time-consuming manual process. The AutoML HyperDrive service provides the ability to automate finding the optimal values for hyperparameters.

![Screenshot of Azure AutoML Framework](../media/3-automl-framework.png)

The steps to use the AutoML capability of Azure Machine Learning is straightforward:

- Define the machine learning objective and constraints
- Launch the AutoML process
- AutoML concurrently runs multiple model training processes with different models and hyperparameter values
- AutoML evaluations the model executions and recommends the best model and hyperparameter values