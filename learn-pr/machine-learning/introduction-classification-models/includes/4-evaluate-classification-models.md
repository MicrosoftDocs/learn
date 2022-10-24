The training accuracy of a classification model is much less important than how well that model works when it's given new, unseen data. After all, you train models so that they can be used on new data that you find in the real world. So, after you've trained a classification model, you should evaluate how well it performs on a set of new, unseen data.

Earlier, you created a model that predicts whether a patient has diabetes based on their blood glucose level. Now, if you apply this model to some data that wasn't part of the training set, you get the following predictions:

| *x* | *y* | *ŷ* |
| --- | ---  | --- |
| 83 | 0 | 0 |
| 119 | 1 | 1 |
| 104 | 1 | 0 |
| 105 | 0 | 1 |
| 86 | 0 | 0 |
| 109 | 1 | 1 |

Recall that *x* refers to blood glucose level, *y* refers to whether the patient is actually diabetic, and *ŷ* refers to the model's prediction as to whether the patient is diabetic.

Simply calculating the number of correct predictions is sometimes misleading or too simplistic to help you understand the kinds of errors it will make in the real world. To get more detailed information, you can tabulate the results in a structure called a *confusion matrix*, as shown here:

:::image type="content" source="../media/confusion-matrix.png" alt-text="Diagram of a confusion matrix, showing test results for true negatives, true positives, false negatives, and false positives.":::

The confusion matrix shows the total number of cases where:

- The model predicted 0 and the actual label is 0 (true negatives [TN], top left)
- The model predicted 1 and the actual label is 1 (true positives [TP], bottom right)
- The model predicted 0 and the actual label is 1 (false negatives [FN], bottom left)
- The model predicted 1 and the actual label is 0 (false positives [FP], top right)

The cells in the confusion matrix are often shaded so that higher values have a deeper shade. This makes it easier to see a strong diagonal trend from top-left to bottom-right, highlighting the cells where the predicted value and actual value are the same.

From these core values, you can calculate a range of other metrics that can help you evaluate the performance of the model. For example:

- **Accuracy**: *(TP+TN)/(TP+TN+FP+FN)*; of all the predictions, how many were correct?
- **Recall**: *TP/(TP+FN)*; of all the cases that are positive, how many did the model identify?
- **Precision**: *TP/(TP+FP)*; of all the cases that the model predicted to be positive, how many actually are positive?
