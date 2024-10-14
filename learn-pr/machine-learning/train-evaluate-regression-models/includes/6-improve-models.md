Simple models with small datasets can often be fit in a single step, while larger datasets and more complex models must be fit by repeatedly using the model with training data and comparing the output with the expected label. If the prediction is accurate enough, we consider the model trained. If not, we adjust the model slightly and loop again.

Hyperparameters are values that change the way that the model is fit during these loops. Learning rate, for example, is a hyperparameter that sets how much a model is adjusted during each training cycle. A high learning rate means a model can be trained faster; but if it’s too high, the adjustments can be so large that the model is never "finely tuned" and not optimal.

## Preprocessing data

Preprocessing refers to changes you make to your data before it's passed to the model. We've previously read that preprocessing can involve cleaning your dataset. While this is important, preprocessing can also include changing the format of your data so it's easier for the model to use. For example, data described as "red," "orange," "yellow," "lime," and "green" might work better if converted into a format more native to computers, such as numbers stating the amount of red and the amount of green.

### Scaling features

The most common preprocessing step is to scale features so they fall between zero and one. For example, the weight of a bike and the distance a person travels on a bike may be two very different numbers, but by scaling both numbers to between zero and one allows models to learn more effectively from the data.

### Using categories as features

In machine learning, you can also use categorical features such as "bicycle," "skateboard," or "car." These features are represented by 0 or 1 values in **one-hot vectors**; vectors that have a 0 or 1 for each possible value. For example, bicycle, skateboard, and car might respectively be (1,0,0), (0,1,0), and (0,0,1).
