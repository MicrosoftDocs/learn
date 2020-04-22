<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

Now, it's time to train our naive Bayes model. For our model, we will use the multinomial naive Bayes classifier. "Multinomial" in this case derives from our assumption that, for our bag of $n$ words: $P({\rm S}\mid {\rm word_1}, {\rm word_2},\ldots, {\rm word}_n)=P({\rm S})P({\rm word_1}\mid {\rm S})P({\rm word_2}\mid {\rm S})\cdots P({\rm word}_n\mid {\rm S})$. We don't assume that our word likelihoods follow a normal distribution.

```Python
from sklearn.naive_bayes import MultinomialNB
```

```Python
naivebayes_model = MultinomialNB()
naivebayes_model.fit(X_train_data,y_train)
```

Our model is now fitted. However, before we run our predictions on all of our test data, let's see what our model says about some artificial data in order to get a better sense of what our model will do with all of the messages in our test dat. From the word clouds we constructed earlier, we can see that "call" and "free" are both prominent words among our spam messages, so let's create our own spam message and see how our model classifies it.

```Python
pred = naivebayes_model.predict(CountVect.transform(['Call for a free offer!']))
pred
```

TBD output

As we expected, our model correctly classified this message as spam.

### Try it yourself

Review the ham word cloud above, construct a ham message, and then run it against the model to see how it is classified.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Possible exercise solution:

```Python
pred2 = naivebayes_model.predict(CountVect.transform(['Let me know what time we should go.']))
pred2
```

TBD output

---

</details>

Now let's run our test data through the model. First, we need to transform it to a document-term matrix.

```Python
X_test_data = CountVect.transform(X_test)
X_test_data.shape
```

TBD output

### Try it yourself

Run the predictions for the test data.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Exercise solution

```Python
predictions = naivebayes_model.predict(X_test_data)
predictions
```

TBD output

---

</details>

Now it's time to evaluate our model's performance.

```Python
from sklearn.metrics import classification_report, confusion_matrix

print(classification_report(predictions, y_test))
```

### Try it yourself

Overall, our model is good for spam detection, but our recall score (the proportion of actual positives that were identified correctly) is surprisingly low. Why might this be? What implications does it have for spam detection?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Use the scikit-learn `confusion_matrix()` function to better understand the specific performance of the model. Get help [interpreting the confusion matrix](https://wikipedia.org/wiki/Confusion_matrix)].

Possible exercise solution:

```Python
print(confusion_matrix(y_test, predictions))
```

TBD output

---

</details>


> [!div class="alert is-tip"]
> ### Takeaway
>
>The performance of our naive Bayes model helps underscore the algorithm's popularity, particularly for spam detection. Even untuned, we got good performance, performance that would only continue to improve in production as users submitted more examples of spam messages.
>

