In this unit, you'll train a predictive maintenance model in Model Builder

## Set your training time

Model Builder automatically automatically sets how long you should train for based on the size of your file. In this case, to help Model Builder explore more models, provide a higher number.

1. In the Train step of the Model Builder screen, set the Time to train (seconds) to 30. 
1. Select **Train**

## Tracking the training process

:::image type="content" source="../media/train-machine-learning-model.png" alt-text="Train predictive maintenance classificaiton model":::

Once the training process kicks off, Model Builder explores various models. Your training process is tracked in the Training results as well as in the Visual Studio output window. The training results provide information about the best model that's been found throughout the training process and the output window provides detailed information like the name of the algorithm used, how long it took to train, and the performance metrics for that model. You may see the same algorithm name appear multiple times. This happens because in addition to trying different algorithms, Model Builder is also trying different hyperparameter configurations for those algorithms. Therefore it's normal to see the same algorithm appear multiple times.

In the next unit, you'll learn how to evaluate how well your model performs.