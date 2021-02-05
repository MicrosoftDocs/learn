You've chosen which columns you want to use to predict whether a rocket would launch given certain weather conditions. Now, you'll need to choose which algorithm to use to make our model. Recall that you were introduced to the [Azure Machine Learning Algorithm Cheat Sheet](https://docs.microsoft.com/azure/machine-learning/algorithm-cheat-sheet?azure-portal=true).

:::image type="content" source="../media/algorithm-cheat-sheet.png" alt-text="Flowchart-style diagram of the Machine Learning Algorithm Cheat Sheet." loc-scope="azure":::

Remember your question:
*Can you predict whether a launch is likely to be able to happen given specific weather conditions?*
This question has two choices. A rocket will launch, either yes or no. This question is considered a two-class classification problem.

Within this category of algorithm, there are many specific algorithms to choose from. In this case, you'll be exploring a two-class decision tree. Visualizing the results of a decision tree yields insights that will help you iterate on data collecting, cleansing, and manipulation in the future.

## Create a machine learning model in Python

Using [scikit-learn](https://scikit-learn.org/stable/index.html?azure-portal=true), it's easy to create the machine learning model you need for this exercise. Paste this code into another cell in Visual Studio Code:

```python
# Create decision tree classifier 
tree_model = DecisionTreeClassifier(random_state=0,max_depth=5)
```

Let's take a look at the [documentation for the decision tree classifier](https://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeClassifier.html?highlight=decision%20tree%20classifier#sklearn.tree.DecisionTreeClassifier?azure-portal=true) and the importance of the parameters we specified here. The two parameters we specified are `random_state` and `max_depth`.

The `random_state` parameter will be used for most machine learning algorithms. It controls the randomness of the algorithm. When you use this estimator to split the data into data to train with and data to test with, the seed provided here dictates the randomness of that split. The next unit will provide more information on data splitting.

The `max_depth` parameter is a tree-specific parameter that allows you to scope the output of the model. In this case, it isn't likely to be informative to get every possible probability of a specific weather condition and its likely effect on the likelihood of a rocket launch. The depth will be capped at five to reduce the knowledge gained to what is most practically related to the outcome.

## Further exploration

If you're interested, you can try finishing this module as is. Then you can come back and change the parameter values to see what kind of new insights you might find.