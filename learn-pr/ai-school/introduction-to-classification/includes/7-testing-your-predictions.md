We need training data to train a model. Once trained, we need to check how well our model will work with other similar datasets. To test a model for this, we need separate *test data*.

We can evaluate the predictions of trained models using test data. As we have real labels for the test data, we can compare the label a model predicts to the real label. This gives us the accuracy of the model on data it hasn't trained on, telling us if our model is as good on new data as it was on the training data.

The larger our training set is, the more accurate our model can be overall. The larger our test set is, the more confident we can be in the model’s accuracy with new data. So, the more data the better.

![Diagram representing the 80% to 20% data split of training set and test set. In the middle of the diagram, there is a blue circle, which represents the machine learning model. The model is joined to the training set, which is labeled with 80%, by a line labeled with 'training'. The model is also joined to the test set, which is labeled with 20%, by a line labeled with 'evaluation'.](../media/28-tv-ts-01.png)

Normally, we start with a large dataset and split it into training data and test data. How much data goes to testing and training is different for each application, but it’s normal to start out by assigning about 80% of your data to training, and 20% to testing.

## Overfitting

Most datasets have noise - irregular fluctuations that we are not interested in and can obscure what we are trying to measure or visualize. If we collect two datasets of the same thing (for example, leaf size versus trunk girth), these datasets should have approximately the same relationship between variables, but different noise. *Overfitting* occurs when a model is trained so intensely on training data that it not only learns the pattern we are interested in, but it also learns the noise of that particular dataset. Because noise is completely different between datasets, this means that model will not work well on other datasets. **In practice, overfitting is shown by a model having high accuracy on a training set, but low accuracy on the test set**.

The black line in the graph below is an example of overfitting. The *__red__* line is more generalized. Although the red line may be less accurate than the green line on the *training* set, on the test set and future datasets it will give a much better result.  
  
![Scatter plot showing overfitting. The Y-axis represents independent variable 2 and the X-axis represents independent variable 1. The plot has two classes of data points - green and blue data points. They are on opposite diagonal sides of the plot, divided by a non-linear black line that represents overfitting and a red line that is closer to being linear. The black line attempts to perfectly label all the data points into their correct categories, which would give a bad result on the test set. Whereas, the red line is a much more generalized line, far closer to linear than the variable black line. The red line would give a slightly lower result for accuracy on the training set, but a far higher result for accuracy on the test set.](../media/43-o.png)

Overfitting tends to be encouraged by two major factors. Firstly, it can be more likely when training datasets are too small, and/or do not have enough variance, to be properly representative of ‘real world’ data. Secondly, overfitting is more likely to occur in models that are complex than in models that are simple. Roughly speaking, the more complex a model is, the more training data is needed to avoid overfitting.  
  
A balance has to be struck, however, because if a model becomes too simple, it won’t fit either training or test data well.

## Underfitting

Models that are too simple or undertrained fail to find true relationships in our data. This is called *underfitting* and reflected by poor accuracy in both training and test data. Underfitting typically occurs when there is not enough training data, when useful features are not used, or when the type of model is not suitable for the data at hand. For example, the graph below shows underfitting occurring in a linear model that is trying to predict a non-linear problem. While the line does separate the green and blue dots somewhat, a non-linear line is likely to do a better job.
  
![Scatter plot titled 'underfitting'. The Y-axis is labeled 'independent variable 2', and the X-axis is labeled 'independent variable 1'. The plot has two classes of data points - green and blue data points. They are on opposite diagonal sides of the plot, with a trend line attempting to separate them which represents underfitting. The black line does not separate the two classes with a high accuracy - if it had a sharper gradient this would dramatically increase its accuracy.](../media/2567-oru-03.png)

To address underfitting problems you may move onto a more complex algorithm (such as an SVM), get more training data, or add more features to your data set.

## Data quality

Much of the work in building an AI system is thinking about what data we need, how to get it, and - this is vitally important - evaluating the data quality. Checking for missing or incorrect values and removing or correcting data is called **data cleaning**.

It is common in machine learning and statistics to have datasets that have missing values. It is important, however, to be careful about how we deal with these missing values. For example, let’s say we are working with medical test results. Not all possible medical tests are run on each person, which leaves blanks in our dataset. It is important that we are careful with these empty entries. If we use a 0, for example, where no blood-pressure test was taken, and feed this data to an AI model, that model will assume that some people had blood pressure measurements of 0mmHg. This is likely to mean that the machine learning model will not perform well.
