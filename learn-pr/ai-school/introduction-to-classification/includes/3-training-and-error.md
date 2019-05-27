## Training

So in the programming exercise, how did the models we built ‘train’ themselves to improve their accuracy?

![3.3 ClassificationTraining](../media/3.3_ClassificationTraining.gif)

The diagram above shows an algorithm trying to find the line which best separates the blue from the green dots. As you can see above, the algorithm changes its variables (the starting point and gradient of the line) until it finds the line that most accurately does so. This process of adjusting these variables is called __training__. Once the algorithm has completed training, and we can use it to predict new examples, it’s called a model.

There are lots of different ways training can work. One common method is to start with a random guess (in this case, a random line), and see whether adjustments (for example, a more or less steep gradient) give a better result. This is repeated until adjustments do not  improve the model any further, until the improvements for a change are very small, or some sort of attempt limit is hit.


## Error

It is important to understand that all data has variability. This means that usually models cannot reach 100% accuracy.

![3.3 Error](../media/3.3_Error.png)

Note the outlier data points (indicated by the red dashes around them.) These are examples of data that the model cannot possibly predict accurately. This is known as “irreducible error” or “Bayes error”.

:::tutorial-optional-section {tutorial-optional-section=Optional:&nbsp;Data&nbsp;quality}
A lot of the work in building an AI system is thinking about what data we need, how to get it, and - this is vitally important - evaluating the data quality. Checking for missing or incorrect values and removing or correcting data is called **data cleaning**. 

It is common in machine learning and statistics to have datasets that have missing values. It is important, however, to be careful about how we deal with these. For example, let’s say we are working with medical test results. Not all possible medical tests are run on each person, which leaves blanks in our dataset. It is important that we are careful with these empty entries. If we use a 0, for example, where no blood-pressure test was taken, and feed this to an AI model, that model will assume that some people had blood pressure measurements of 0mmHg. This is likely to mean that the machine learning model will not perform well.
:::

## Summary

Now you’ve been walked through the basics of classification algorithms, and used logistic regression to predict the probability of a team winning a football (soccer) match! We’ve also covered training a model, and error. Well done.

That's the end of this section and this module! During this section we learned:

* __Training__ - the AI algorithm changes the variables it uses to make predictions until it reaches its lowest error rate.
* __Irreducible error__ - examples that the model cannot possibly predict accurately.
* __Bayes error__ - the lowest possible error rate, where an algorithm cannot become any more accurate.  

During this module we walked through the basics of classification algorithms, and learned:

__Classification__

* __Classification__ is assigning labels to new data. For example, predicting whether a future soccer match will be a “win” or “loss”.

__Logistic regression__

* Is a classification algorithm.  
* Produces a line of best fit to data from previous events.  
* Can be used to give us the probability that something is true, or an event will happen.  
  
__Models__

* __AI often learns iteratively__ - starting with a bad approximation and changing variables (like line-slope) until a model becomes accurate.
* The real world is very variable, and so __we cannot expect our models to become 100% accurate__.
  
Up next is advanced classification models. We’ll walk you through using one of the most powerful and elegant AI models, support vector machines. Let's go!