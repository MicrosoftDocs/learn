Starting with the first step, you want to **define the problem** the model should solve, by understanding:

- What the model’s output should be.
- What type of machine learning task you use.
- What criteria make a model successful.

Depending on the data you have and the expected output of the model, you can identify the machine learning task. The task determines which types of algorithms you can use to **train the model**.

Some common machine learning tasks are:

:::image type="content" source="../media/02-01-overview-tasks.png" alt-text="Diagram of an overview of the five common machine learning tasks.":::

1. **Classification**: Predict a categorical value.
2. **Regression**: Predict a numerical value.
3. **Time-series forecasting**: Predict future numerical values based on time-series data.
4. **Computer vision**: Classify images or detect objects in images.
5. **Natural language processing** (**NLP**): Extract insights from text.

To train a model, you have a set of algorithms that you can use, depending on the task you want to perform. To evaluate the model, you can calculate performance metrics such as accuracy or precision. The metrics available also depend on the task your model needs to perform and help you to decide whether a model is successful in its task.

## Explore an example

Consider a scenario where you want to determine if patients have diabetes. The problem you're trying to solve and the type of data available determines the machine learning task you choose. In this case, the available data are other health data points from patients. We can represent the output we want as *categorical* information that either the patient has diabetes or doesn't have diabetes. Thus, the machine learning task is *classification*.

Understanding the entire process before you start gives you an opportunity to map out the decisions you need to make to design a successful machine learning solution. Following, is a diagram showing one way to approach the problem of identifying diabetes in a patient. In the diagram, the data is prepped, split, and trained using specific algorithms. Afterward, the model is evaluated for quality.

:::image type="content" source="../media/train-model-process.png" alt-text="Diagram showing the seven steps to train a model.":::

1. **Load data**: Import and inspect the dataset.
1. **Preprocess data**: Normalize and clean for consistency.
1. **Split data**: Separate into training and test sets.
1. **Choose model**: Select and configure an algorithm.
1. **Train model**: Learn patterns from the training data.
1. **Score model**: Generate predictions on test data.
1. **Evaluate**: Calculate performance metrics.

