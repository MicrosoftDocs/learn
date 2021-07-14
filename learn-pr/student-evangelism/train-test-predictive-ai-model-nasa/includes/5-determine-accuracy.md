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
0.9354166686534882
```

The output shows our model has 93.5% accuracy in making predictions. We want a high value. The higher the accuracy means the model is doing a good job of making predictions.

Even though 93.5% is high, you can do a few things to increase the accuracy even more:

- Add more images and continue training the AI model.
- Increase the number of `epoch` training iterations for deep learning.


## Save the model

Now that you've created the neural network and tested the accuracy, save your model.

- Add the following code in a new cell in your Jupyter Notebook file, and then run the cell:

   ```python
   torch.save(model, 'aerialmodel.pth')
   ```
