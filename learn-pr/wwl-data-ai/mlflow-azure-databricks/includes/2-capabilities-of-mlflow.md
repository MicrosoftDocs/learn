
There are four components to MLflow: 
- MLflow Tracking
- MLflow Projects
- MLflow Models
- MLflow Model Registry

## MLflow Tracking

MLflow Tracking allows data scientists to work with experiments in which they process and analyze data or train machine learning models. For each run in an experiment, a data scientist can log parameter values, versions of libraries used, model evaluation metrics, and generated output files; including images of data visualizations and model files. This ability to log important details about experiment runs provides the ability to audit and compare the results of prior model training executions.  

## MLflow Projects

An MLflow Project is a way of packaging up code for consistent deployment and reproducibility of results.  MLflow supports several environments for projects, including the use of Conda and Docker to define consistent Python code execution environments.

## MLflow Models

MLflow offers a standardized format for packaging models for distribution. This standardized model format allows MLflow to work with models generated from several popular libraries, including *Scikit-Learn*, *PyTorch*, *MLlib*, and others.

> [!TIP]
> Review the [MLflow Models documentation](https://mlflow.org/docs/latest/models.html) for information on the full set of supported model flavors.

## MLflow Model Registry

The MLflow Model Registry allows data scientists to register trained models. MLflow Models and MLflow Projects use the MLflow Model Registry to enable machine learning engineers to deploy and serve models for client applications to consume.
