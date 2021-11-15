In this unit, you'll learn how to train and evaluate machine learning models in Model Builder.

During training, Model Builder applies algorithms to your data. By using evaluation metrics for the specific scenario, you measure how well your model performs.

## Training in Model Builder

Now that you've selected your scenario, selected your training environment, and loaded your data, it's time to start training your model. Training consists of applying algorithms for the chosen scenario to your dataset in order to find the best model. We'll go over what "best" means in the evaluation step.

In most cases, to train machine learning models in Model Builder, you only have to provide the amount of time that you want to train for.

## How long should I train for?

Longer training periods allow Model Builder to explore more models with a wider range of settings.

The following table summarizes the average time taken to get good performance for a suite of example datasets on a local machine, by using CPU:

|Dataset size|Average time to train|
|------------|---------------------|
|0 MB to 10 MB   |10 seconds               |
|10 MB to 100 MB |10 minutes               |
|100 MB to 500 MB|30 minutes               |
|500 MB to 1 GB  |60 minutes               |
|1 GB+       |3+ hours             |

These numbers are a guide only. The exact length of training depends on:

- The number of features (columns) being used as input to the model.
- The type of columns.
- The machine learning task.
- The CPU, GPU, disk, and memory performance of the machine that's used for training.

> [!TIP]
> Use more than 100 rows as datasets. Fewer than that might not produce any results.

### How does Model Builder find the best model?

You've probably heard that machine learning involves complex math. So how can Model Builder train a machine learning model if you've only provided a scenario, a dataset, and the length of time that you want Model Builder to train for?

Model Builder uses automated machine learning (AutoML) to identify the set of transformations to prepare your data for training, select an algorithm, and tune the settings (also known as hyperparameters) of the algorithm. By using evaluation metrics that are specific to the selected machine learning task, Model Builder can determine which model performs best for your data.

### Training and consumption code

After your model is done training, Model Builder generates the following files and adds them to your project. These files are nested under your *.mbconfig* file.

- *\<MODEL-NAME\>.zip*: The artifact for the machine learning model. This file contains a serialized version of your model.
- *\<MODEL-NAME\>.training.cs*: This file contains the model training pipeline. Your model training pipeline consists of the data transformations and algorithm that are used to train your machine learning model. For more information, see [Data transforms](/dotnet/machine-learning/resources/transforms?azure-portal=true) and [How to choose an ML.NET algorithm](/dotnet/machine-learning/how-to-choose-an-ml-net-algorithm?azure-portal=true).
- *\<MODEL-NAME\>.consumption.cs*: This file contains the classes that define the schema of your model input and output. It also contains the `Predict` method, which uses your model to create a `PredictionEngine` API and make predictions. `PredictionEngine` is a convenience API that allows you to perform a prediction on a single instance of data.

## Evaluate your model

Now that you've found the best model for your data, it's time to test how well it makes predictions. One way to evaluate how well your model performs is by using metrics. 

Evaluation metrics are specific to the type of machine learning task that a model performs. For each task, you can look at various metrics to determine the performance of your model. 

This table shows the evaluation metrics that Model Builder uses to choose the best model, based on scenario:

| Scenario             | Evaluation metrics                             | Look for                       |  
| ---                  | ---                                            | ---                            |
| Data classification  | Binary (Accuracy) / Multiclass (MicroAccuracy) | The closer to 1.00, the better |
| Value prediction     | R-Squared                                      | The closer to 1.00, the better |
| Image classification | Accuracy                                       | The closer to 1.00, the better |
| Recommendation       | R-Squared                                      | The closer to 1.00, the better |
| Object detection     | Accuracy                                       | The closer to 1.00, the better |

For more information on ML.NET evaluation metrics, see [Model evaluation metrics](/dotnet/machine-learning/resources/metrics).

### Choosing the model with the highest metrics

Your model has achieved perfect evaluation metrics. Does that mean that you have the perfect model? Not exactly. In fact, if you end up with a "perfect" model as specified by your evaluation metrics, you should be skeptical. 

In machine learning, there's a concept called *overfitting*, and it's something you should watch out for. Overfitting is when your model learns the patterns in your training dataset too well. When you try to use the model with new data, it doesn't provide accurate results.

Here's a scenario to help illustrate overfitting. Imagine you're studying for an exam. Somehow you have the questions to the exam and the answers ahead of time. As you study for the exam, you focus on memorizing the answers to the questions. When you take the exam and receive the results, you get a high grade. A high grade might signal that you know the subject matter well. However, if someone were to ask you a question on one of the subjects that was not directly on the test, you might get it wrong because you haven't learned the subject, you just memorized the answers. Overfitting works in a similar way.

### Improving your model

If you're not satisfied with the evaluation metrics of your model, you can try these things to improve your model:

- **Provide more representative data observations**: Experience is the best teacher. The concept also applies to machine learning. The more data observations you can provide, the broader the set of patterns that your model can recognize.
- **Provide more context**: Adding columns that add context to your data helps your model identify patterns. For example, let's say you're trying to predict the price of a home and the only data point you have is number of rooms. That by itself might not tell you much. However, what if you knew that the home is located in a suburban neighborhood outside a major metropolitan area, where average household income is $80,000 and schools are in the top 20th percentile? Now you have more information that can help inform the model's decision.
- **Use meaningful data and features**: Although more data samples and features can help improve the accuracy of the model, they can also introduce noise because not all data and features are meaningful. It's important to understand which features most heavily affect the algorithm's decisions.
- **Explore more algorithms**: Providing Model Builder with more time to allow it to explore more algorithms and hyperparameters might help improve your model.

In the next unit, you'll use Model Builder to train a machine learning model.
