## Learning objectives

In this module, you will:

- Choose a machine learning scenario to solve your problem
- Choose a computing environment to train your model
- Load data to train your model
- Train a machine learning model for predictive maintenance
- Evaluate how well your machine learning model performs
- Consume your machine learning model in a .NET application

## Prerequisites

> [!NOTE]
> Visual Studio 2022 and .NET 6 are currently in preview.

- Introductory knowledge of .NET
- Visual Studio 2022
    - .NET SDK 6 or later
- ML.NET Model Builder extension. The ML.NET Model Builer Visual Studio extension is included in Visual Studio. For more information, see [How to install ML.NET Model Builder](https://docs.microsoft.com/dotnet/machine-learning/how-to-guides/install-model-builder)

## Learn the scenario

Imagine you work for a manufacturing company that uses industrial machines as part of its operations. When one of these machines breaks, it costs your company time and money. That's why proactively maintaining these machines is important. However, there are many different factors like usage that affect the need for maintenance. What if you could predict when a machine is going to need maintenance using sensor data?

Machine learning may be able to help by analyzing historical data from these sensors and learning patterns to help you predict whether a machine needs maintenance or not.

You'd like to take advantage of your .NET skills and use familiar tools like Visual Studio to build a machine learning solution, but don't have a lot of experience with machine learning. As a result, you've decided to use ML.NET, an open-source machine learning framework for .NET and its Visual Studio extension, Model Builder, to help you build your machine learning model.

## The first step

The first step to train a machine learning model is deciding which scenario and machine learning task is the most appropriate to solve it given what you're trying to predict. In the next unit, you'll choose a scenario for your predictive maintenance model.