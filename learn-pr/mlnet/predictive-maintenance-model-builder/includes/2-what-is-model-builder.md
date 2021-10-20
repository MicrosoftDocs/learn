Model Builder is a graphical Visual Studio extension to train and deploy custom machine learning models with ML.NET.

Machine learning is a technique that uses mathematics and statistics to identify patterns within data without being explicitly programmed. For example, let's say you wanted to predict the price of a home. If you were using a single feature such as number of rooms to estimate its price, you could probably program a heuristic that correlates a larger number of rooms to a higher price. As you know though, the world isn't that simple and there are many variables that influence the price of a home. It's in those cases that coming up with a simple heuristic that captures edge cases  becomes difficult and machine learning may be a better solution. With machine learning, instead of explicitly programming rules, you use historical data to identify these rules based on actual observations.

The patterns found using machine learning are then used to create an artifact known as a model to make predictions using new and previously unseen data.

ML.NET is an open-source, cross-platform, machine learning framework for .NET. This means you can use apply your existing .NET skills and use the tools you're familiar with like Visual Studio to train machine learning models.

## What types of problems can I solve with ML.NET and Model Builder?

Model Builder can be used to solve many common machine learning problems such as:

- Categorizing data (organize news articles by topic)
- Predicting a numerical value (estimate the price of a home)
- Recommending items (recommend movies)
- Grouping items with similar characteristics (customer segmentation)
- Classifying images (tag an image based on its contents)
- Detecting objects in an image (detect pedestrians and bicycles at an intersection)

## How can I build models with Model Builder?

Generally the process of adding machine learning models to your applications consists of the following steps:

- Training
- Consumption

### Training

Training is the process by which you apply algorithms to historical data in order to create an artifact or model that captures underlying patterns and can be used to make predictions on new data.

Model Builder uses automated machine learning (AutoML) to find the "best" model for your data.

AutoML automates the process of applying machine learning to data. Given a dataset, you can run an AutoML experiment to iterate over different data transformations, machine learning algorithms, and settings to select the best model.

As a result, you don't need machine learning expertise to use Model Builder. All you need is some data, and a problem to solve.

The model training process can be further broken down into the following steps:

- **Choose a scenario**. What problem am I trying to solve? The scenario you choose depends on your data and what you're trying to predict.
- **Choose an environment**. Where do I want to train my model? Depending on available compute resources, cost, privacy requirements, and a series of other factors you may choose to train models locally on your computer or the cloud.
- **Load your data**. Load the dataset to use for training, define the columns you want to predict, and choose the columns you want to use as inputs for your prediction.
- **Train your model**. Let AutoML choose the best algorithm for your dataset based on the scenario you've chosen.
- **Evaluate your model**. Use evaluation metrics to compare how well your model performs and makes predictions on new data.

### Consumption

Once you train a machine learning model, it's time to put it to use. With ML.NET, machine learning models are serialized and saved to a file.

The model file can then be loaded into any .NET application and used to make predictions using ML.NET APIs. Some of these application types include:

- ASP.NET Core Web API
- Azure Functions
- Blazor
- WPF / WinForms
- Console
- Class library
