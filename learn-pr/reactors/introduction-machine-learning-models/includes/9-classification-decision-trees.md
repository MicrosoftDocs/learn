If logistic regression uses observations about variables to swing a metaphorical needle between 0 and 1, classification based on decision trees programmatically builds a Yes/No decision to classify items.

:::image type="content" alt-text="A decision tree graph." source="../media/decision-tree.png" loc-scope="azure":::

Let's look at decision tree classification in practice with the same _Titanic_ dataset we used with logistic regression.

```python
from sklearn import tree
```

```python
tr = tree.DecisionTreeClassifier()
```

### Try it yourself

Using the same split data as with the logistic regression, can you fit the decision tree model?

<br />

<details> 

  <summary>Hint: Refer to the code snippet for fitting the logistic regression in the unit "Logistic regression: Handle missing values."<i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  tr.fit(X_train, y_train)
  ```
  
  The output is:
  
  ```Output
  DecisionTreeClassifier(ccp_alpha=0.0, class_weight=None, criterion='gini',
                       max_depth=None, max_features=None, max_leaf_nodes=None,
                       min_impurity_decrease=0.0, min_impurity_split=None,
                       min_samples_leaf=1, min_samples_split=2,
                       min_weight_fraction_leaf=0.0, presort='deprecated',
                       random_state=None, splitter='best')
  ```
  
</details>

<br /><br />

***

After the decision tree model is fitted, we get our predictions like we did in the previous logistic regression example:

```python
tr_predictions = tr.predict(X_test)
```

```python
pd.DataFrame(confusion_matrix(y_test, tr_predictions), 
             columns=['True Survived', 'True Not Survived'], 
             index=['Predicted Survived', 'Predicted Not Survived'])
```

The output is:

```Output
--------------------------------------------------------------
|                        | True Survived | True Not Survived |
--------------------------------------------------------------
| Predicted Survived     |      130      |         32        |
--------------------------------------------------------------
| Predicted Not Survived |       37      |         69        |   
--------------------------------------------------------------
```

```python
print(accuracy_score(y_test,tr_predictions))
```

The output is:

```Output
0.7425373134328358
```

One of the great attractions of decision trees is that people can read the models. Let's visualize to see it in action. The generated graphic can be large, so scroll to the right if the generated graphic looks blank at first.

```python
import graphviz 

dot_file = tree.export_graphviz(tr, out_file=None, 
                                feature_names=X.columns, 
                                class_names='Survived',  
                                filled=True,rounded=True)  
graph = graphviz.Source(dot_file)  
graph
```

The output is:

:::image type="content" alt-text="A decision tree graph." source="../media/output-graphviz-tree.png" loc-scope="azure":::

There are many other machine learning (ML) models that we could explore. You learned about some of the most common models. Now you're ready to learn what automated, cloud-based ML and AI services are doing and how to intelligently apply them to data-science problems. This subject is discussed in the next section.
