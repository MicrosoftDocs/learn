We can assess our classification models in terms of the kinds of mistakes that they make, such as false negatives and false positives. This can give insight into the kinds of mistakes a model makes but doesn't necessarily give deep information on how the model could perform if slight adjustments were made to its decision criteria. Here we'll discuss receiver operator characteristic (ROC) curves, which build on the idea of a confusion matrix but provide us with deeper information that lets us improve our models to a greater degree.

## Scenario:

Throughout this module, we’ll be using the following example scenario to explain and practice working with ROC curves.

Your avalanche-rescue charity has successfully built a machine learning model that can estimate whether an object detected by lightweight sensors is a hiker or a natural object, such as a tree or rock. This lets you keep track of how many people are on the mountain, so you know whether a rescue team is needed when an avalanche strikes. The model does reasonably well, though you wonder if there's room for improvement. Internally, the model must make a binary decision as to whether an object is a hiker or not, but this is based on probabilities. Can this decision-making process be tweaked to improve its performance?

## Prerequisites

* Familiarity with machine learning models

## Learning objectives

In this module, you will:

* Understand how to create ROC curves
* Explore how to assess and compare models using these curves
* Practice fine-tuning a model using characteristics plotted on ROC curves
