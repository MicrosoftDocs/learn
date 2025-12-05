
In machine learning, models are trained to predict unknown outcomes by learning patterns from labeled training data. The way a model learns is influenced not only by the data itself but also by hyperparameters—settings that control the training process. These aren't learned from the data but are manually set before training begins, for example:

- In logistic regression, the regularization rate helps prevent overfitting by penalizing overly complex models.
- In neural networks, the learning rate determines how quickly the model updates its weights, affecting both speed and accuracy.

> [!NOTE]
> In machine learning terminology, values learned from the data are called parameters. To distinguish them from the values that configure the training process, we use the term hyperparameters.

Choosing the right hyperparameters is crucial. Poor choices can lead to models that underperform or fail to generalize to new data. On the other hand, well-tuned hyperparameters can significantly improve a model’s accuracy, robustness, and efficiency.

That’s where hyperparameter tuning comes in—a process of systematically testing different combinations of hyperparameter values to find the best-performing setup for your specific data and task.

In Azure Databricks, you can use the **Optuna** library to automate this process. Optuna intelligently explores the hyperparameter space, training and evaluating models repeatedly until it identifies the most effective configuration. This helps you build models that not only perform well but also generalize better to unseen data.

In Azure Databricks, you can use libraries like **Optuna** or **Ray Tune** for hyperparameter optimization. While both are powerful tools, in this module we focus on **Optuna**. Optuna intelligently explores the hyperparameter space, training and evaluating models repeatedly until it identifies the most effective configuration. This helps you build models that not only perform well but also generalize better to unseen data.