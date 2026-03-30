
When you're asked to build a machine learning model, you rarely know up front which algorithm or preprocessing steps will give you the best results. Finding the right combination takes experimentation.

Azure Machine Learning gives you two ways to experiment efficiently. **Automated machine learning (AutoML)** searches through algorithms and preprocessing configurations automatically, running multiple training jobs in parallel. **Jupyter notebooks** let you write and iterate on your own training code, while **MLflow** tracks every run so you can compare results.

In this module, you work through three phases of experimentation. First, you use AutoML to quickly identify the optimal algorithm and featurization approach. Then, you use an interactive notebook to continue experimenting and track your results with MLflow. Finally, you compare performance metrics and the Responsible AI dashboard across all your trained models to select the best one.

## Learning objectives

In this module, you learn how to:

- Prepare your data to use AutoML for classification.
- Configure and run an AutoML experiment.
- Evaluate and compare AutoML models.
- Configure MLflow for model tracking in notebooks.
- Use MLflow for model tracking in notebooks.
- Evaluate a trained model using the Responsible AI dashboard.

Let's start by exploring how AutoML prepares your data before training begins.
