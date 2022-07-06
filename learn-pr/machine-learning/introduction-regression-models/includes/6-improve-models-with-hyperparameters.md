Simple models with small datasets can often be fit in a single step. Larger datasets and more complex models must be fit by repeatedly using the model with training data and comparing the output with the expected label. If the prediction is accurate enough, you can consider the model trained. If not, you adjust the model slightly and loop again.

Hyperparameters are values that change the way the model is fit during these loops. Learning rate, for example, is a hyperparameter that sets how much a model is adjusted during each training cycle. A high learning rate means a model can be trained faster. But if the rate is too high, the adjustments can be so large that the model is never finely tuned and not optimal.

## Preprocess data

Preprocessing refers to changes you make to your data before it's passed to the model. You've previously read that preprocessing can involve cleaning your dataset. Preprocessing can also include changing the format of your data so that it's easier for the model to use.

For example, data described as red, orange, yellow, lime, and green might work better if converted into a format more native to computers. This format might be numbers that state the amount of red and the amount of green.

## Scale features

The most common preprocessing step is to scale features so they fall between 0 and 1. For example, the weight of a bike and the distance a person travels on a bike might be two very different numbers. Scaling both numbers to between 0 and 1 allows models to learn more effectively from the data.

## Use categories as features

In machine learning, you can also use categorical features such as bicycle, skateboard, or car. These features are represented by 0 or 1 values in one-hot vectors. These vectors have a 0 or 1 for each possible value. For example, bicycle, skateboard, and car might be (1,0,0), (0,1,0), and (0,0,1), respectively.