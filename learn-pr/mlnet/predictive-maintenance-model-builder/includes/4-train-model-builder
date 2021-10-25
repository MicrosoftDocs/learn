In this unit you'll learn how to train and evaluate machine learning models in Model Builder.

The next steps after preparing your data for training are:

- **Train your model**
- **Evaluate your model**

During training, Model Builder applies algorithms to your data and using evaluation metrics for the specific scenario, you measure how well your model performs.

## Training in Model Builder

Now that you've selected your scenario, training environment, and loaded your data, it's time to start training your model.

Training is the process by which a series of algorithms for the scenario you've chosen are applied to your dataset in order to find the "best" model. We'll go over what best means in the evaluation step.

In most cases, to train machine learning models in Model Builder, you only have to provide the amount of time you want to train for.

## How long should I train for?

Longer training periods allow Model Builder to explore more models with a wider range of settings.

The table below summarizes the average time taken to get good performance for a suite of example datasets, on a local machine using CPU.

|Dataset size|Average time to train|
|------------|---------------------|
|0 - 10 MB|10 sec|
|10 - 100 MB|10 min|
|100 - 500 MB|30 min|
|500 - 1 GB|60 min|
|1 GB+|3+ hours|

These numbers are a guide only. The exact length of training depends on:

- the number of features (columns) being used as input to the model
- the type of columns
- the machine learning task
- the CPU, GPU, disk, and memory performance of the machine used for training

> [!TIP]
> It's generally advised that you use more than 100 rows as datasets with less than that may not produce any results.

### How does Model Builder find the best model?

You've probably heard machine learning involves complex math. So how is it that Model Builder is able to train a machine learning model if you've only provided a scenario, a dataset, and how long you want Model Builder to train for?

Model Builder uses automated machine learning (AutoML) to identify the set of transformations to prepare your data for training, select an algorithm, and tune the settings (also known as hyperparameters) of the algorithm to create a model that most suits your data. Using evaluation metrics specific to the machine learning task selected, Model Builder is able to determine which model performs "best" for your data.

### Training and consumption code

Once your model is done training, Model Builder generates a few files prefixed with your model's name and adds them to your project. These files are nested under your *.mbconfig* file.

- **\<MODEL-NAME\>.zip**: The machine learning model artifact. This file contains a serialized version of your model.
- **\<MODEL-NAME\>.training.cs**: This file contains the model training pipeline. Your model training pipeline is made up of the data transformations and algorithm used to train your machine learning model. See [data transforms](/dotnet/machine-learning/resources/transforms) and [how to choose an ML.NET algorithm](/dotnet/machine-learning/how-to-choose-an-ml-net-algorithm) for more details.
- **\<MODEL-NAME\>.consumption.cs**: This file contains the classes that define the schema of your model input and output. It also contains the `Predict` method, that uses your model to create a `PredictionEngine` and make predictions. The `PredictionEngine` is a convenience API, which allows you to perform a prediction on a single instance of data.

## Evaluate your model

Now that you've found the "best" model for your data, it's time to test how well it makes predictions. One way to evaluate how well your model performs is by using evaluation metrics. Evaluation metrics are specific to the type of machine learning task that a model performs. For each task, there are various metrics you can look at to determine the performance of your model. Depending on the scenario selected in Model Builder, it uses the evaluation metrics for that scenario to choose the "best" model.

This table shows the evaluation metrics used by Model Builder to choose the best model.

| Scenario | Evaluation metrics | Look for |  
| --- | --- | --- |
| Data classification | Binary (Accuracy) / Multiclass (MicroAccuracy) |  The closer to 1.00, the better.
| Value prediction | R-Squared | The closer to 1.00, the better |
| Recommendation | R-Squared | The closer to 1.00, the better |
| Image classification | Accuracy | The closer to 1.00, the better |
| Object detection | Accuracy | The closer to 1.00, the better |

For more information on ML.NET evaluation metrics, see [Model evaluation metrics](/dotnet/machine-learning/resources/metrics)

### Choosing the model with the highest metrics

Your model has achieved perfect evaluation metrics. Does that mean that you have the perfect model? Not exactly. In fact, if you end up with a "perfect" model as specified by your evaluation metrics, you should be skeptical. In machine learning, there is a concept known as overfitting and it's something you should watch out for. Overfitting is when your model learns the patterns in your training dataset too well. However, when you try to use the model with new data, it doesn't provide accurate results.

Here's a scenario may help illustrate overfitting. Imagine you're studying for an exam. Somehow you have the questions to the exam and the answers ahead of time. As you study for the exam, you focus on memorizing the answers to the questions. When you take the exam and receive the results, you get a high grade. A high grade may signal you know the subject matter you were just evaluated on. However, if someone were to ask you a question on one of the subjects that was not directly on the test, you may get it wrong because you haven't learned the subject, you just memorized the answers. Overfitting works in a similar way.

### Improve your model

If you're not satisfied with the evaluation metrics of your model, there are a few things you can try to improve your model.

- **Provide more representative data observations** - Experience is the best teacher. When it comes to machine learning, the concept also applies. The more data observations, the broader set of patterns your model is able to recognize.
- **Provide more context** - Adding columns that add context to your data helps your model identify patterns. For example, let's say you're trying to predict the price of a home and the only data point you have is number of rooms. That by itself may not tell you much. However, what if you knew that the home is located in a suburban neighborhood outside of a major metropolitan area, average household income is $80,000, and schools are in the top 20th percentile. Now you have more information that can help inform the model's decision.
- **Use meaningful data and features** - Although more data samples and features can help improve the accuracy of the model, they may also introduce noise since not all data and features are meaningful. Therefore, it is important to understand which features are the ones that most heavily impact decisions made by the algorithm.
- **Explore more algorithms** - Providing Model Builder with more type to allow it to explore more algorithms and hyperparameters may help improve your model.

In the next unit, you'll use Model Builder to train a machine learning model.
