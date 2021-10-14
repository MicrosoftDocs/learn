In this unit, you'll learn about the training process in Model Builder.

## Training in Model Builder

Training is the process by which a series of algorithms for the scenario you've chosen are applied to your dataset. The goal is to find the "best"
model. We'll get into what "best" means in later units.

In most cases, to train machine learning models in Model Builder, you only have to provide the amount of time you want to let Model Builder search for the best model for your data.

## How long should I train for?

Longer training periods allow Model Builder to explore more models with a wider range of settings.

The table below summarizes the average time taken to get good performance for a suite of example datasets, on a local machine.

|Dataset size|Average time to train|
|------------|---------------------|
|0 - 10 MB|10 sec|
|10 - 100 MB|10 min|
|100 - 500 MB|30 min|
|500 - 1 GB|60 min|
|1 GB+|3+ hours|

These numbers are a guide only. The exact length of training is dependent on:

- the number of features (columns) being used as input to the model
- the type of columns
- the machine learning task
- the CPU, disk, and memory performance of the machine used for training

It's generally advised that you use more than 100 rows as datasets with less than that may not produce any results.

## How does Model Builder find the best model?

You've probably heard machine learning can be complex and involves lots of math. So how is it that Model Builder is able to train a machine learning model if you've only provided a scenario, a dataset, and how long you want Model Builder to train for?

Model Builder uses automated machine learning (AutoML) to identify the set of transformations to prepare your data for training, select an algorithm, and tune the settings (also known as hyperparameters) of the algorithm to create a model that most suits your data. Using evaluation metrics specific to the machine learning task selected, Model Builder is able to determine which model performs "best" for your data.

## What happens when training completes

<!-- INSERT CODEGEN INFO -->

In the next unit you'll use Model Builder to train your predictive maintenance model.