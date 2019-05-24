## Advanced SVM’s

In a previous programming exercise we made a linear SVM because it fit well to our simple data set. SVMs also perform well with complex and unlabelled data sets because support vectors help optimize the margins to minimize misclassifications.

Previously we talked about having a hard margin - an area around the hyperplane where no data points pass through. Our previous SVM moved our hyperplane (line) to try to maximise how wide this margin could be. 

The problem with this approach is that real world data has noise, which means that it’s normal for the odd datapoint to fall near to ‘best’ hyperplane. If we are using a hard margin, we will move the hyperplane to avoid these noisy data points. This is akin to overfitting.

Instead, a soft-margin SVM can be used to increase your accuracy. Soft-margin uses a different cost function than the maximum margin method you have already used. This cost function gives a smaller penalty for stray data points.

![2.9 AdvancedSVMs-02](../media/2.9_AdvancedSVMs-02.png)

The plot above is an example of a hard-margin SVM. The hyperplane (black line) is currently doing a good job of separating blue and green dots. However, if the green dot labelled ‘violation’ was introduced and the SVM retrained, this line would have to move substantially, because it is within the margin. If it was moved even closer to the red dots, the SVM might fail to separate the dots properly and report that it ‘failed’, even though a 100% accuracy rate is unlikely on most datasets. A soft-margin SVM allows some degree of mis-labelling, and so may be more useful here.  
  
![2.9 AdvancedSVMs-01](../media/2.9_AdvancedSVMs-01.png)

The plot above is a soft-margin SVM, where the algorithm is penalised less for data points that fall within the margin. As such, it fits a sensible hyperplane to the data rather than being skewed by a few data points. In practice, it can be worth experimenting with both types of SVMs to try and achieve a higher accuracy.

Advanced SVMs are easy to use on complex data sets. You don’t need to know the details in depth, but it’s good to have an idea of what different tools can do if you run into a difficult data set. One of the most well known tools are kernels.

## Kernels

SVMs can optimize predictions by use of kernel methods - a type of algorithm that analyses patterns. The kernel trick is the most widely used kernel method. It uses calculus to separate the data and calculate a line of best fit that can be non-linear.

There are several types of kernels you can use for the kernel trick, including linear, polynomial, gaussian, and sigmoid (S-shaped) kernels. These have different properties which give different margins to separate your examples. While practitioners tend to try polynomial kernels and gaussian kernels first, there is no general best choice of kernel.

###### Linear Kernel

![3.0 Kernels-01](../media/3.0_Kernels-01.png)

###### Polynomial Kernel

![3.0 Kernels-02](../media/3.0_Kernels-02.png)

###### RBF Kernel

![3.0 Kernels-03](../media/3.0_Kernels-03.png)

You just need to know the different kernels exist, and you should try several of them to try to improve your models accuracy. Luckily, it’s very easy to try different kernels, so let’s give it a go.

:::tutorial-optional-section {tutorial-optional-section=Optional:&nbsp;Using&nbsp;a&nbsp;category&nbsp;as&nbsp;a&nbsp;feature&nbsp;-&nbsp;one-hot&nbsp;vectors}
Often you may have a category in your dataset you want to use as a feature – such as a products country of origin. To use a category as a feature you represent the category as a __one-hot vector__.

![3.2 OneHotVector](../media/3.2_OneHotVector.png)

A one-hot vector is a vector (list) where each position in the list represents a different category. The vector is filled with 0’s and with one 1. In the example above we are representing 4 animals, where a 1 in the first position represents a cat, and a 1 in the fourth position represents a rabbit. Now your category is useable by a machine learning model.
:::

## Programming exercise

> Next up we'll do a programming exercise making more advanced SVM models.  
>  
> We will walk through how easy it is to make an SVM model and change its kernel. We’re going to use SVM models to classify two types of protein based on their various characteristics.  
>  
> **Python users** click __[here](https://notebooks.azure.com/home/libraries/Python "here")__ to go to your library.  
> Select the exercise `07. Advanced SVMs - Python.ipynb` exercise.  
> Then click then click __'Run on Free Compute'__.  
>  
> **R users** click __[here](https://notebooks.azure.com/home/libraries/R-Exercises "here")__ to go to your library.  
> Select the exercise `07. Advanced SVMs - R.ipynb`.  
> Then click then click __'Run on Free Compute'__.  
>  
> If you haven’t set up your library and Azure Notebooks account the links above won't work. For instructions to get started click [__here__](https://aischool.microsoft.com/en-us/machine-learning/learning-paths/ml-crash-course/introduction-to-ai/introduction-to-azure-notebooks).