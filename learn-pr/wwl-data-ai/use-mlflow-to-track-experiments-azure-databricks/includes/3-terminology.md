There are several terms, which will be important to understand when working with MLflow. Most of these terms are fairly common in the data science space. Other products, such as Azure Machine Learning, use very similar terminology to allow for simplified cross-product development of skills. The following sections include key terms and concepts for each MLflow product.

## MLflow Tracking

MLflow Tracking is built around **runs**, that is, executions of code for a data science task. Each run contains several key attributes, including:

- **Parameters**: Key-value pairs, which represent inputs. Use parameters to track **hyperparameters**, that is, inputs to functions, which affect the machine learning process.
- **Metrics**: Key-value pairs, which represent how the model is performing. This can include evaluation measures such as Root Mean Square Error, and metrics can be updated throughout the course of a run. This allows a data scientist, for example, to track Root Mean Square Error for each epoch of a neural network.
- **Artifacts**: Output files. Artifacts may be stored in any format, and can include models, images, log files, data files, or anything else, which might be important for model analysis and understanding.

These runs can be combined together into **experiments**, which are intended to collect and organize runs. For example, a data scientist may create an experiment to train a classifier against a particular data set. Each run might try a different algorithm or different set of inputs. The data scientist can then review the individual runs in order to determine which run generated the best model.

## MLflow Projects

A **project** in MLflow is a method of packaging data science code. This allows other data scientists or automated processes to use the code in a consistent manner.

Each project includes at least one **entry point**, which is a file (either **.py** or **.sh**) that is intended to act as the starting point for project use. Projects also specify details about the **environment**. This includes the specific packages (and versions of packages) used in developing the project, as new versions of packages may include breaking changes.

## MLflow Models

A **model** in MLflow is a directory containing an arbitrary set of files along with an **MLmodel** file in the root of the directory.

MLflow allows models to be of a particular **flavor**, which is a descriptor of which tool or library generated a model. This allows MLflow to work with a wide variety of modeling libraries, such as `scikit-learn`, `Keras`, `MLlib`, `ONNX`, and many more. Each model has a **signature**, which describes the expected inputs and outputs for the model.

## MLflow Model Registry

The MLflow Model Registry allows a data scientist to keep track of a **model** from MLflow Models. In other words, the data scientist **registers** a model with the Model Registry, storing details such as the name of the model. Each registered model may have multiple **versions**, which allow a data scientist to keep track of model changes over time.

It is also possible to **stage** models. Each model version may be in one stage, such as **Staging**, **Production**, or **Archived**. Data scientists and administrators may **transition** a model version from one stage to the next.
