In a previous programming exercise, we made a linear SVM because it fit well to our simple data set. SVMs also perform well with complex and unlabeled data sets because support vectors help optimize the margins to minimize misclassifications.

Previously we talked about having a hard margin - an area around the hyperplane where no data points pass through. Our previous SVM moved our hyperplane (line) to try to maximize how wide this margin could be.

The problem with this approach is that real world data has noise, which means that it’s normal for the odd datapoint to fall near to ‘best’ hyperplane. If we are using a hard margin, we will move the hyperplane to avoid these noisy data points. This is akin to overfitting.

Instead, a soft-margin SVM can be used to increase your accuracy. Soft-margin uses a different cost function than the maximum margin method you have already used. This cost function gives a smaller penalty for stray data points.

![Scatter plot showing a hard margin support vector machine. The plot has two classes of data points - green and blue data points. They are on opposite diagonal sides of the plot, divided by a black line, which represents the hyperplane. There are two red lines either side of the black line, which intersects with several of the data points on each side - these are margins. There is a green data point inside the margins, and it is labeled as a violation.](../media/29-asvm-02.png)

The plot above is an example of a hard-margin SVM. The hyperplane (black line) is currently doing a good job of separating blue and green dots. However, if the green dot labeled ‘violation’ was introduced and the SVM retrained, this line would have to move substantially, because it is within the margin. If it was moved even closer to the red dots, the SVM might fail to separate the dots properly and report that it ‘failed’, even though a 100% accuracy rate is unlikely on most datasets. A soft-margin SVM allows some degree of mislabeling, and so may be more useful here.  
  
![Scatter plot showing a soft margin support vector machine. The plot has two classes of data points - green and blue data points. They are on opposite diagonal sides of the plot, divided by a black line, which represents the hyperplane. There are two red lines either side of the black line, which intersects with several of the data points on each side - these are margins. There are two green data points inside the margins, but unlike the hard margin SVM, they are not labeled as violations.](../media/29-asvm-01.png)

The plot above is a soft-margin SVM, where the algorithm is penalized less for data points that fall within the margin. As such, it fits a sensible hyperplane to the data rather than being skewed by a few data points.

In practice, it is recommended to experiment with several different types of models to try and achieve higher accuracy. Advanced SVMs are easy to use on complex data sets. You don’t need to know the details in depth, but it’s good to have an idea of what different tools can do if you run into a difficult data set. One of the most well known tools are kernels.

## Kernels

SVMs can optimize predictions by use of kernel methods - a type of algorithm that analyzes patterns. The kernel trick is the most widely used kernel method. It uses calculus to separate the data and calculate a line of best fit that can be non-linear.

There are several types of kernels you can use for the kernel trick, including linear, polynomial, gaussian, and sigmoid (S-shaped) kernels. These have different properties that give different margins to separate your examples. While practitioners tend to try polynomial kernels and gaussian kernels first, there is no general best choice of kernel.

Parameters, such as kernels, that you can set before training a model are known **hyperparameters**. They change the way an algorithm trains and operates, so practitioners often change them to *tune* a model so it has better performance. While practitioners tend to try certain hyperparameters first, such as polynomial kernels and gaussian kernels, there is no general best choice for hyperparameters.

###### Linear kernel

![Scatter plot showing a linear kernel. The plot has two classes of data points - green and blue data points. They are on opposite diagonal sides of the plot, divided by a linear black line, which represents the hyperplane. There are two red lines either side of the black line, which intersects with several of the data points on each side - these are margins.](../media/30-k-01.png)

###### Polynomial kernel

![Scatter plot showing a polynomial kernel. The plot has two classes of data points - green and blue data points. They are on opposite diagonal sides of the plot, divided by a black line that is primarily linear, but there is a dip in the middle to accommodate several stray data points and classify them correctly. There are two red lines either side of the black line, which intersects with several of the data points on each side - these are margins.](../media/30-k-02.png)

###### RBF kernel

![Scatter plot showing an RBF kernel. The plot has three classes of data points - green, yellow, and blue data points. They are roughly in a circle shape divided into three. There is a non-linear black line which divides the three - with there being three lines coming from the center of the plot in order to classify the data points correctly. There are two red lines either side of the black line, which intersects with several of the data points on each side - these are margins. There are several data points that are within the margin.](../media/30-k-03.png)

You just need to know the different kernels exist, and you should try several of them to try to improve your models accuracy. Luckily, it’s very easy to try different hyperparameters, so let’s give it a go.
