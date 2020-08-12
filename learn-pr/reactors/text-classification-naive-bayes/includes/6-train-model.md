<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

It's time to train our Naive Bayes model. For our model, we'll use the multinomial Naive Bayes classifier. 

*Multinomial* in this case derives from our assumption that for our bag of $n$ words:

$P({\rm S}\mid {\rm word_1}, {\rm word_2},\ldots, {\rm word}_n)=P({\rm S})P({\rm word_1}\mid {\rm S})P({\rm word_2}\mid {\rm S})\cdots P({\rm word}_n\mid {\rm S})$ 

We don't assume that our word likelihoods follow a normal distribution.

```python
from sklearn.naive_bayes import MultinomialNB
```

Then, run the following command:

```python
naivebayes_model = MultinomialNB()
naivebayes_model.fit(X_train_data,y_train)
```

The output is:

```Output
MultinomialNB(alpha=1.0, class_prior=None, fit_prior=True)
```

Our model is now fitted. Before we run our predictions on all of our test data, let's see what our model says about some artificial data in order to get a better sense of what our model will do with all of the messages in our test data. From the word clouds that we constructed earlier, we can see that _call_ and _free_ are both prominent words among our spam messages. So let's create our own spam message and see how our model classifies it:

```python
pred = naivebayes_model.predict(CountVect.transform(['Get 50% off your next purchase. Call now']))
pred
```

The output is:

```Output
array(['spam'], dtype='<U4')
```

As we expected, our model correctly classified the message as spam.

### Try it yourself

Review the ham word cloud, construct a ham message, and then run it against the model to see how it's classified.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's a possible exercise solution:

  ```Python
  pred2 = naivebayes_model.predict(CountVect.transform(['Let me know what time we should go.']))
  pred2
  ```

  The output is:

  ```Output
  array(['ham'], dtype='<U4')
  ```

</details>

<br /><br />

***

Let's run our test data through the model. First, we need to transform it to a document-term matrix.

```Python
X_test_data = CountVect.transform(X_test)
X_test_data.shape
```

The output is:

```Output
(1672, 11425)
```

### Try it yourself

Run the predictions for the test data.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's a possible solution:

  ```python
  predictions = naivebayes_model.predict(X_test_data)
  predictions
  ```

  The output is:

  ```Output
  array(['spam', 'ham', 'ham', ..., 'spam', 'ham', 'spam'], dtype='<U4')
  ```

</details>

<br /><br />

***

It's time to evaluate our model's performance.

```python
from sklearn.metrics import classification_report, confusion_matrix
print(classification_report(predictions, y_test))
```

The output is:

```Output
             precision    recall  f1-score   support
        ham       0.97      0.99      0.98      1430
       spam       0.95      0.79      0.86       242
avg / total       0.96      0.96      0.96      1672
```

### Try it yourself

Overall, our model is good for spam detection. But our recall score (the proportion of actual positives that were identified correctly) is low. Why might this be? What implications does it have for spam detection?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Use the scikit-learn `confusion_matrix()` function to better understand the specific performance of the model. Get help [interpreting the confusion matrix](https://wikipedia.org/wiki/Confusion_matrix?azure-portal=true).

  Here's a possible solution:

  ```python
  print(confusion_matrix(y_test, predictions))
  ```

  The output is:

  ```Output
  [[1419   50]
  [  11  192]]
  ```

</details>

<br /><br />

***

> [!div class="alert is-tip"]
> ### Takeaway
>
>The performance of our Naive Bayes model helps underscore the algorithm's popularity, particularly for spam detection. Even untuned, we got good performance. This performance would only continue to improve in production as users submitted more examples of spam messages.
>