## Training

So in the programming exercise, how did the models we built ‘train’ themselves to improve their accuracy?

![3.3 ClassificationTraining](../media/3.3_ClassificationTraining.gif)

The diagram above shows an algorithm trying to find the line which best separates the blue from the green dots. As you can see above, the algorithm changes its variables (the starting point and gradient of the line) until it finds the line that most accurately does so. This process of adjusting these variables is called __training__. Once the algorithm has completed training and we can use it to predict new examples it’s called a model.

There are lots of different ways training can work. One common method is to start with a random guess (in this case, a random line), and see whether adjustments (e.g. a more or less steep gradient) give a better result. This is repeated until adjustments do not  improve the model any further, until the improvements for a change are very small, or some sort of attempt limit is hit.


## Error

It is important to understand that all data has variability. This means that usually models cannot reach 100% accuracy.

![3.3 Error](../media/3.3_Error.png)

Please note the outlier data points (indicated by the red dashes around them.) These are examples of data that the model can not possibly predict accurately. This is known as “irreducible error” or “Bayes error”.

:::tutorial-optional-section {tutorial-optional-section=Optional:&nbsp;Data&nbsp;quality}
A lot of the work in building an AI system is thinking about what data we need, how to get it, and - this is vitally important - evaluating the data quality. Checking for missing or incorrect values and removing or correcting data is called **data cleaning**. 

It is common in machine learning and statistics to have datasets that have missing values. It is important, however, to be careful about how we deal with these. For example, let’s say we are working with medical test results. Not all possible medical tests are run on each person, which leaves blanks in our dataset. It is important that we are careful with these empty entries. If we use a 0, for example, where no blood-pressure test was taken, and feed this to an AI model, that model will assume that some people had blood pressure measurements of 0mmHg. This is likely to mean that the machine learning model will not perform well.
:::

### Outro

Now you’ve been walked through the basics of classification algorithms, and used logistic regression to predict the probability of a team winning a football (soccer) match! We’ve also covered training a model, and error. Well done.