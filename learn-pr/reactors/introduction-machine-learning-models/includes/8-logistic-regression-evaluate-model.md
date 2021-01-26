In contrast to linear regression, logistic regression doesn't produce an $R^2$ score that we can use to assess the accuracy of our model. To evaluate our model's accuracy, we'll use a classification report, a confusion matrix, and the accuracy score.

## Classification report

The classification report gives the proportions of both survivors and non-survivors.

```python
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
```

The classification report gives the proportions with four scores:

- **Precision**: The number of true positives divided by the sum of true positives and false positives. A number closer to 1 is better.
- **Recall**: The true-positive rate, which is the number of true positives divided by the sum of the true positives and the false negatives.
- **F1 score**: The harmonic mean (the average for rates) of precision and recall.
- **Support**: The number of true instances for each label.

Why are there so many ways of measuring accuracy for a model? Because success means different things in different contexts. Imagine that we had a model to diagnose infectious disease. In such a case, we might want to tune our model to maximize recall and as a result minimize our false-negative rate. Even high precision might miss many infected people. In a different example, a weather-forecasting model might be interested in maximizing precision because the cost of false negatives is so low. For other uses, striking a balance between precision and recall by maximizing the F1 score might be the best choice. Run the classification report:

```python
print(classification_report(y_test,predictions))
```

The output is:

```Output
precision     recall  f1-score   support

           0       0.83      0.90      0.86       162
           1       0.82      0.72      0.76       106

    accuracy                           0.82       268
   macro avg       0.82      0.81      0.81       268
weighted avg       0.82      0.82      0.82       268
```

## Confusion matrix

The confusion matrix is another way to present this same information, but this time with raw scores. The columns show the true condition, with positive on the left and negative on the right. The rows show predicted conditions, with positive on the top and negative on the bottom. The following matrix shows that our model correctly predicted 146 survivors (true positives) and incorrectly predicted another 16 (false positives). Our model also correctly predicted 30 non-survivors (true negatives) and incorrectly predicted 76 more (false negatives).

```python
print(confusion_matrix(y_test,predictions))
```

The output is:

```Output
[[145  17]
 [ 30  76]]
```

Let's dress up the confusion matrix a bit to make it a little easier to read:

```python
pd.DataFrame(confusion_matrix(y_test, predictions), columns=['True Survived', 'True Not Survived'], index=['Predicted Survived', 'Predicted Not Survived'])
```

The output is:

```Output
--------------------------------------------------------------
|                        | True Survived | True Not Survived |
--------------------------------------------------------------
| Predicted Survived     |      145      |         17        |
--------------------------------------------------------------
| Predicted Not Survived |       30      |         76        |   
--------------------------------------------------------------
```

## Accuracy score

Finally, our accuracy score tells us the fraction of correctly classified samples. In this case, it's $(146 + 76) / (146 + 76 + 30 + 16)$.

```python
print(accuracy_score(y_test,predictions))
```

The output is:

```Output
0.8246268656716418
```

That's not bad for an off-the-shelf model with no tuning!
