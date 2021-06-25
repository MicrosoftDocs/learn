In the past few units we’ve started to see a divide in cost functions – which teach the model – and evaluation metrics – which is how we assess the model ourselves.

## All cost functions can be evaluation metrics

All cost functions can be evaluation metrics, though not necessarily intuitive ones.
Log loss as example. Values are not intuitive.

## Some evaluation metrics cannot be cost functions

- It is difficult for some evaluation metrics to become cost functions.
- This is due to practical and mathematical constraints.
- Sometimes things are not easy to calculate (e.g. “how doggy something is”)
- Cost functions are ideally smooth. E.g. accuracy is useful, but if we change our model slightly, it won’t notice it. Given that fitting is a procedure with lots of small changes, this gives the impression that alterations will not lead to improvement.
- Cost function graph with lots of flat bits
- Refresh on ROC curves from earlier. This requires changing the threshold to all sorts of values but at the end of the day, our model will only have one (0.5)
 
## It’s not all bad!

- Having different evaluation metrics can be a sanity check that we’re not “overfitting to the cost function”