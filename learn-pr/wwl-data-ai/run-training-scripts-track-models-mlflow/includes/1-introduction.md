A common challenge when developing machine learning models is to prepare for production scenarios. When you write code to process data and train models, you want the code to be scalable, repeatable, and ready for automation.

Though notebooks are ideal for experimentation and development, scripts are a better fit for production workloads. In Azure Machine Learning, you can run a script as a **command job**. When you submit a command job, you can configure various parameters like the input data and the compute environment.

Once your training script runs as a job, you also want to monitor the model's performance over time. You can use **MLflow** to track metrics, parameters, and artifacts directly from your scripts. MLflow is an open-source platform integrated with Azure Machine Learning that lets you compare runs and decide on next steps.

## Learning objectives

In this module, you learn how to:

- Convert a notebook to a script.
- Test scripts in a terminal.
- Run a script as a command job.
- Use parameters in a command job.
- Use MLflow when you run a script as a job.
- Review metrics, parameters, artifacts, and models from a run.

Let's start by exploring why scripts are a better choice than notebooks for production machine learning workloads. And how to convert your existing notebooks into reusable, production-ready scripts.
