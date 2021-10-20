## What is Model Builder?

Model Builder is a graphical Visual Studio extension to build, train, and deploy custom machine learning models with ML.NET.

Model Builder uses automated machine learning (AutoML) to find the "best" model to solve your problem.

AutoML automates the process of applying machine learning to data. Given a dataset, you can run an AutoML experiment to iterate over different data transformations, machine learning algorithms, and settings to select the best model.

As a result, you don't need machine learning expertise to use Model Builder. All you need is some data, and a problem to solve.

Generally the process of adding machine learning to your applications consists of the following steps

- Training
- Consumption

### Training

During the training phase you:

- Choose a scenario. What problem am I trying to solve?
- Choose an environment. Where do I want to train my model? On-Premises, in the cloud, do I want to use GPUs?
- Load your data. Load the dataset, define the columns you want to predict, and choose the columns you want to use as inputs for your prediction.
- Train your model. Let AutoML choose the best algorithm for your dataset based on the scenario you've chosen.
- Evaluate your model. Compare how well your model performs and makes predictions on  

### Consumption

After training your model,