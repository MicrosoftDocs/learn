Machine learning is a technique that uses mathematics and statistics to identify patterns in data without being explicitly programmed. Model Builder is a graphical Visual Studio extension to train and deploy custom machine learning models by using ML.NET.

:::image type="content" source="../media/model-builder-extension.png" alt-text="Screenshot that shows the Model Builder Visual Studio extension for M L dot NET." lightbox="../media/model-builder-extension.png":::

For example, let's say you want to predict the price of a home. If you're using a single feature such as the size of a home in square feet to estimate its price, you could probably program a heuristic that correlates larger homes to a higher price.

:::image type="content" source="../media/linear-regression-model.svg" alt-text="Graph that shows a linear regression model for house price." lightbox="../media/linear-regression-model.svg":::

The world isn't always that simple, though. Many variables influence the price of a home. In cases like this, coming up with a simple heuristic that captures edge cases becomes difficult, and machine learning might be a better solution. 

With machine learning, instead of explicitly programming rules, you use historical data to identify these rules based on actual observations. The patterns found through machine learning are then used to create an artifact called a model to make predictions by using new and previously unseen data.

ML.NET is an open-source, cross-platform machine learning framework for .NET. So you can apply your existing .NET skills and use the tools you're familiar with (like Visual Studio) to train machine learning models.

## What types of problems can I solve by using Model Builder?

You can use Model Builder to solve many common machine learning problems, such as:

- **Categorizing data**: Organize news articles by topic.
- **Predicting a numerical value**: Estimate the price of a home.
- **Grouping items with similar characteristics**: Segment customers.
- **Recommending items**: Recommend movies.
- **Classifying images**: Tag an image based on its contents.
- **Detecting objects in an image**: Detect pedestrians and bicycles at an intersection.

## How can I build models by using Model Builder?

Generally, the process of adding machine learning models to your applications consists of two steps: training and consumption.

### Training

Training is the process of applying algorithms to historical data to create a model that captures underlying patterns. You can then use the model to make predictions on new data.

Model Builder uses automated machine learning (AutoML) to find the best model for your data. AutoML automates the process of applying machine learning to data. You can run an AutoML experiment on a dataset to iterate over different data transformations, machine learning algorithms, and settings, and then select the best model.

You don't need machine learning expertise to use Model Builder. All you need is some data and a problem to solve.

The model training process consists of the following steps:

1. **Choose a scenario**: What problem are you trying to solve? The scenario that you choose depends on your data and what you're trying to predict.
1. **Choose an environment**: Where do you want to train your model? Depending on available compute resources, cost, privacy requirements, and other factors, you might choose to train models locally on your computer or in the cloud.
1. **Load your data**: Load the dataset to use for training. Define the columns that you want to predict, and then choose the columns that you want to use as inputs for your prediction.
1. **Train your model**: Let AutoML choose the best algorithm for your dataset based on the scenario you've chosen.
1. **Evaluate your model**: Use metrics to evaluate how well your model performs and makes predictions on new data.

### Consumption

After you train a machine learning model, it's time to use it to make predictions. Consumption is the process of using a trained machine learning model to make predictions on new and previously unseen data. With Model Builder, you can consume machine learning models from new and existing .NET projects.

ML.NET-based machine learning models are serialized and saved to a file. The model file can then be loaded into any .NET application and used to make predictions through ML.NET APIs. These application types include:

- ASP.NET Core Web API
- Azure Functions
- Blazor
- Windows Presentation Foundation (WPF) or Windows Forms (WinForms)
- Console
- Class library

In the next unit, you'll learn about the process of training a machine learning model in Model Builder.
