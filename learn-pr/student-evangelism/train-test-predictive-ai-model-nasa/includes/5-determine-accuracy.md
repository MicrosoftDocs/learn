A large part of AI is its degree of accuracy in predicting the correct outcome. In our case, accuracy is how likely the computer is to correctly identify a rock that's shown in an image as being the type that scientists have manually determined it is. An accuracy of 0.96 means that 96% of rock types are predicted correctly and that 4% are misclassified.

The following code calculates the accuracy of our AI system in classifying rocks:

```python
print(accuracy/len(testloader))
```

As you can see, the accuracy of this model is very high. This is what we want, because it means that the model does a good job of making predictions.

Even though 96% is high, you can take a couple more steps to increase accuracy even further:

- Add more images, for training the AI models.
- Increase the epoch (number of training iterations for deep learning).

Now that we have created the neural network and tested the accuracy, let's save it:

```python
torch.save(model, 'aerialmodel.pth')
```
