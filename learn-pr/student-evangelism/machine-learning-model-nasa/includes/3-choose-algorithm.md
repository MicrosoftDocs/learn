After you have chosen which columns you want to use to predict whether a rocket would launch given certain weather conditions, you will need to chose which algorithm to use to make our model. Recall in LP3M1U6 you were introduced to the [Azure Maching Learning Algorithm Cheatsheet](https://docs.microsoft.com/azure/machine-learning/algorithm-cheat-sheet?azure-portal=true):

:::image type="content" source="../media/algorithm-cheat-sheet.png" alt-text="Algorithm Cheatsheet." lightbox="../media/algorithm-cheat-sheet-expanded.png" loc-scope="azure":::

Remember your question:  
*Can you predict whether a launch is likely to be able to happen given specific weather conditions?*  
This is a two-choice question: A rocket will launch - Yes or No. So this would be considered a two-class classification problem. 

Within this category of algorithm there are a lot of specific algorithms to choose from. In this case, you will be exploring a two-class decision tree. One of the biggest reasons it was chosen for this module is because visualizing the results of a decision tree yields insights that will help you iterate on future data collecting, cleansing, and manipulation in the future. 

## Create a Machine Learning Model in Python

Using [scikit-learn](https://scikit-learn.org/stable/index.html?azure-portal=true) it is actually very easy to create the machine learning model you need for this exercise! Paste this code into another cell in Visual Studio Code:

```python
# Create decision tree classifer 
tree_model = DecisionTreeClassifier(random_state=0,max_depth=5)
```

Let's take a look at the [documentation for the decision tree classifier](https://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeClassifier.html?highlight=decision%20tree%20classifier#sklearn.tree.DecisionTreeClassifier?azure-portal=true) and the importance of the parameteres we specified here. The two specified are `random_state` and `max_depth`. 

`random_state` will be a parameter for most machine learning algorithms; this controls the randomness of the algorithm - meaning when you use this estimator to split the data into data to train with and data to test with, the seed provided here will dictate the randomness of that split. The next unit will provide more information on data splitting.

`max_depth` is a tree-specific parameter that allows you to scope the output of the model. In this case, it isn't likely to be informative to get every possible probability of a specific weather condition and it's likely effect on the likelihood of a rocket launch. So the depth will be capped at 5 to reduce the knowledge gained to what is most practically related to the outcome.

## Further Exploration

If you're interested, you can try completing this module as is, then coming back and changing the parameter values to see what kind of new insights you might find.