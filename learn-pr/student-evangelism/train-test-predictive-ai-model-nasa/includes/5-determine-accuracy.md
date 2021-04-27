The reason we use AI to help with our space rock research is to improve predictions. When a model sees new pictures of rocks, it should predict the correct rock type based on pictures it's already seen. We want the prediction to be as close to 100% accurate as possible. An AI model that's well trained should more accurately predict the outcome than humans.


## Show the model accuracy

In our example, the `accuracy` command reveals how likely the computer can correctly identify the type of rock in an image based on the scientific definition. An accuracy value of 0.96 means 96% of rock types are predicted correctly and 4% are misclassified.

The following code calculates and displays the accuracy of our AI model to classify the rock type. You might recognize this statement from the last code we added to your Jupyter Notebook file.

- Add this code in a new cell in your Jupyter Notebook file, and then run the cell:

   ```python
   print(accuracy/len(testloader))
   ```

The output displays the accuracy with 16 digits in the fractional part of the decimal:

```output
0.935
```

The output shows our model has 93.5% accuracy in making predictions. We want a high value. The higher the accuracy means the model is doing a good job of making predictions.

Even though 93.5% is high, you can do a few things to increase the accuracy even more:

- Add more images and continue training the AI model.
- Increase the number of `epoch` training iterations for deep learning.

> [!Note]
> **Sarah ToDo**
> - 80% does not seem high to me... Original text said 96%, but didn't show any output
> The output from the previous unit showed the following accuracies:
> Epoch 1/5.. Train loss: 1.990.. Test loss: 0.472.. Test accuracy: 0.810
> Epoch 2/5.. Train loss: 0.679.. Test loss: 0.372.. Test accuracy: 0.935
> Epoch 2/5.. Train loss: 0.648.. Test loss: 0.595.. Test accuracy: 0.644
> Epoch 3/5.. Train loss: 0.463.. Test loss: 0.444.. Test accuracy: 0.835
> Epoch 4/5.. Train loss: 0.310.. Test loss: 0.202.. Test accuracy: 0.935
> Epoch 4/5.. Train loss: 0.261.. Test loss: 0.184.. Test accuracy: 0.967
> Epoch 5/5.. Train loss: 0.271.. Test loss: 0.172.. Test accuracy: 0.933
> Epoch 5/5.. Train loss: 0.263.. Test loss: 0.372.. Test accuracy: 0.802
> The highest accuracy in the output is 96.7%.
> Not sure how to handle this one.
> Should we just report the highest value to the students?


## Save the model

Now that you've created the neural network and tested the accuracy, save your model.

- Add the following code in a new cell in your Jupyter Notebook file, and then run the cell:

   ```python
   torch.save(model, 'aerialmodel.pth')
   ```
