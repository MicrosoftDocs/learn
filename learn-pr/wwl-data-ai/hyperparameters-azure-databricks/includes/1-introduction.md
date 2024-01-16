
In machine learning, algorithms are used to train models that predict unknown labels for new data based on correlations between known labels and features found in the training data. Depending on the algorithm used, you may need to specify *hyperparameters* to configure how the model is trained. For example, the logistic regression algorithm uses a *regularization* rate hyperparameter to counteract overfitting; and deep learning neural network models use hyperparameters like *learning rate* to control how weights are adjusted during training.

> [!NOTE]
> Machine Learning is an academic field with its own particular terminology. Data scientists refer to the values determined from the training features as *parameters*, so a different term is required for values that are used to configure training behavior but which are not derived from the training data - hence the term *hyperparameter*.

The hyperparameter values you select for a given algorithm can have a significant effect on the model it trains; so choosing the right hyperparameter values can make the difference between a model that predicts well when used with new data, and a model that doesn't.

In Azure Databricks, you can use the **Hyperopt** library to automate hyperparameter tuning; a process in which you repeatedly train and evaluate models using different combinations of hyperparameters until you find the values that work best for your data.
