In this unit you'll learn what makes a model the best model.

## Evaluation metrics

One way to evaluate how well your model performs is by using evaluation metrics. Evaluation metrics are specific to the type of machine learning task that a model performs. For each task, there is a variety of metrics you can look at to determine the performance of your model. Depending on the scenario chosen in Model Builder, it uses the evaluation metrics for that scenario to choose the "best" model.

This table shows the evaluation metrics used by Model Builder to choose the best model.

| Scenario | Evaluation metrics | Look for |  
| --- | --- | --- |
| Data classification | Binary (Accuracy) / Multiclass (MicroAccuracy) |  The closer to 1.00, the better.
| Value prediction | R-Squared | The closer to 1.00, the better |
| Recommendation | R-Squared | The closer to 1.00, the better |
| Image classification | Accuracy | The closer to 1.00, the better |
| Object detection | Accuracy | The closer to 1.00, the better |

For more information on ML.NET evaluation metrics, see [Model evaluation metrics](/dotnet/machine-learning/resources/metrics)

## Choosing the model with the highest metrics

Your model has achieved perfect evaluation metrics. Does that mean that you have the perfect model? Not exactly. In fact, if you end up with a "perfect" model as specified by your evaluation metrics, you should be skeptical. In machine learning, there is a concept known as overfitting and it's something you should watch out for. Overfitting is when your model learns the patterns in your training dataset too well. However, when you try to use the model with new data, it doesn't provide accurate results.

Here's a scenario may help illustrate overfitting. Imagine you're studying for an exam. Somehow you have the questions to the exam as well as the answers ahead of time. As you study for the exam, you focus on memorizing the answers to the questions. When you take the exam and receive the results, you get a high grade. A high grade may signal you know the subject matter you were just evaluated on. However, if someone were to ask you a question on one of the subjects that was not directly on the test, you may get it wrong because you haven't learned the subject, you just memorized the answers. Overfitting works in a similar way.

## Improve your model

If you're not satisfied with the evaluation metrics of your model, there are a few things you can try to improve your model.

- Provide more representative data observations. Experience is the best teacher. When it comes to machine learning, the concept also applies. The more data observations, the broader set of patterns your model is able to recognize.
- Provide more context. Adding columns that add context to your data helps your model identify patterns. For example, let's say you're trying to predict the price of a home and the only data point you have is number of rooms. That by itself may not tell you much. However, what if you knew that the home is located in a suburban neighborhood outside of a major metropolitan area, average household income is $80,000, and schools are in the top 20th percentile. Now you have more information that can help inform the model's decision.
- Use meaningful data and features. Although more data samples and features can help improve the accuracy of the model, they may also introduce noise since not all data and features are meaningful. Therefore, it is important to understand which features are the ones that most heavily impact decisions made by the algorithm 
- Explore more algorithms. Providing model builder with more type to allow it to explore more algorithms and hyperparameters may help improve your model.

In the next unit, you'll evaluate your predictive maintenance model.