A big aspect of Artificial Intelligence is the accuracy that our program predicts the right outcome. In our case, accuracy is how likely the computer is to correctly identify a rock as being its true type. For Example 0.96 means 96% of rock types are predicted correctly and 4% are miss-classified.

The accuracy of AI in classification of rocks is shown below:

```python
print(accuracy/len(testloader))
```

As you can see, the accuracy of this model is very high. This is what we want because it means the model will be able to make predictions fairly well.

Even though it is pretty high, there are a few other ways to increase the accuracy:

1. Adding more images for training the AI models
2. Increasing the epoch (number of training iterations for deep learning)

Now that we have created the neural network and tested the accuracy, let's save it.

```python
torch.save(model, 'aerialmodel.pth')
```
