Support vector machines (SVMs) are one of the most elegant solutions in machine learning. They can be used for both classification and regression problems, and can be easily coded in Python and R. In this course we'll use them for classification.

SVMs are vital tools in biology, and many other areas of science and industry. Let's take a look at how they work, then make a model using one line of code.

### Hyperplanes

A hyperplane is a boundary that divides data points - SVMs can try to find a hyperplane that separates different kinds of data points as accurately as possible. In the example below, it has separated the dots on the bottom left (blue) from those in the top right (green) using the black line (hyperplane). Data points are classified based on which side of the black line they fall upon.

![2.4 LinearSupportVectorMachine](../media/2.4_LinearSupportVectorMachine.png)

This is like our logistic regression programming exercise, but the SVM tries to make the margin between the two lines as large as possible. This is known as a maximum margin SVM. This is done so the SVM is as accurate as possible when you introduce new data.

### Support vectors and margins

The SVM calculates the hyperplanes and margins by using the data points from the different categories which are closest together.  
  
These data points are called support vectors - this is where SVMs get their name from.
  
![2.4 SupportVectorMachines-01](../media/2.4_SupportVectorMachines-01.png)

Data points on the margin are called support vectors (hence, the model is called a support vector machine). SVMs can perform well with large, non-linear, complex data sets too.

![2.4 SupportVectorMachines-02](../media/2.4_SupportVectorMachines-02.png)

New examples introduced to an SVM model are labelled with a category based on which side of the margin they fall upon. If desired, the number of hyperplanes can be increased, allowing many different types of labels. This is useful in text and image classification. SVMs have been widely applied in biology in areas such as accurately classifying proteins and DNA sequences.    
  
## Programming exercise

> Let’s open up Azure Notebooks and try out a basic SVM.  
>   
> **Python users** click __[here](https://notebooks.azure.com/home/libraries/Python "here")__ to go to your library.  
> Select the exercise `06. Support Vector Machines - Python.ipynb`.  
> Then click then click __'Run on Free Compute'__.  
>  
> **R users** click __[here](https://notebooks.azure.com/home/libraries/R-Exercises "here")__ to go to your library.  
> Select the exercise `06. Support Vector Machines - R.ipynb` exercise.  
> Then click then click __'Run on Free Compute'__.  
>  
> If you haven’t set up your library and Azure Notebooks account the links above won't work. For instructions to get started click [__here__](https://aischool.microsoft.com/en-us/machine-learning/learning-paths/ml-crash-course/introduction-to-ai/introduction-to-azure-notebooks).

## Summary

Well done! That's support vector machines done for now!  
  
Here we covered:
* __Hyperplanes__ - the line separating categories for SVMs.
* __Support vectors__ - the data points from different categories that are closest to those of the other category.
* __Margin__ - the boundary between categories in which no data points are placed - decided by the support vectors.  
  
Next up we cover how we test models and two common problems models face - overfitting and underfitting.