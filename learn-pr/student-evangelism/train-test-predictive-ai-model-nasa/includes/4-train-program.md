We now have an AI model that incorporates a neural network. We provided some data to our program to teach it the different features of space rocks. The program has plenty of neurons and they're wired together in a deep learning network.

Now, it's time to train our program. We'll use our training data from NASA. We'll add code to help our program become accurate in classifying space rocks.


## Iterate on the data and increase the accuracy

In this section of code, look for the `epochs` variable. This variable tells the program how many times to search for associations in the features. In our example, we'll set the initial number of iterations to 5.

> [!Note]
> You can increase the number of iterations to further improve the accuracy of the model.
> Keep in mind that increasing the number of iterations makes the code run slower.

To train our model, we load the image input from the `trainloader` variable that we built in the [Analyze images of rocks with AI][AnalyzeMod] module. The data is stored to the already selected device. We call the `optimizer.zero_grad()` function to zero out gradients and avoid the accumulation of gradients across training iterations.

The image input is passed through the model by using the `model.forward(inputs)` function, which returns the log probabilities of each label. The `criterion(logps, labels)` function runs the log probabilities through the criterion to get the output graph. The `loss.backward()` function uses the loss graph to compute the gradients. The `optimizer.step()` function then updates the parameters based on the current gradient.

During the training and testing, we track the loss values for each iteration and the full batch. Every five `epochs`, we evaluate the model. We use the `model.eval()` function with the `torch.no_grad()` function to turn off parts of the model that behave differently during training versus evaluation. We use this pair of functions to refine the accuracy of the prediction without updating the gradients.

The `torch.exp(logps)` function is used to get a new tensor with the true probabilities. The largest probability and class of the new tensor along a given dimension is returned from the `ps.topk(1, dim=1)` function. The tensor is reshaped to match the same shape as the top class.

Finally, we compute the overall accuracy.


## Train the neural network

Follow these steps to train the neural network in your AI model.

1. Return to Visual Studio Code, and open your Jupyter Notebook file. In our example, we're using the file *ClassifySpaceRockProgram.ipynb*.

1. Make sure you're running the correct Jupyter kernel. At the upper-right and lower-left corners of Visual Studio, change to the Anaconda environment `('myenv')` that you created earlier.

1. Add the following code in a new cell, and then run the cell.

   ```python
   # Set the initial number of iterations to search for associations
   epochs = 5
   print_every = 5

   # Initialize the loss variables
   running_loss = 0
   train_losses, test_losses = [], []

   # Track the current training step, start at 0
   steps = 0

   # Search for associations in the features
   for epoch in range(epochs):

      # Count each epoch
      epoch += 1

      # Load in all of the image inputs and labels from the TRAIN loader 
      for inputs, labels in trainloader:
        
         # Count each training step
         steps += 1
         print('Training step ', steps)

         # Load the inputs and labels to the already selected device
         inputs, labels = inputs.to(device), labels.to(device)

         # Zero out gradients to avoid accumulations of gradiants across training iterations
         optimizer.zero_grad()

         # Pass the images through the model, return the log probabilities of each label
         logps = model.forward(inputs)

         # Run the log probabilities through the criterion to get the output graph
         loss = criterion(logps, labels)

         # Use the loss graph to compute gradients
         loss.backward()

         # Update the parameters based on the current gradient
         optimizer.step()

         # Add the actual loss number to the running loss total
         running_loss += loss.item()

         # Every 5 steps, evaluate the model
         if steps % print_every == 0:

            # Initialize loss and accuracy
            test_loss = 0
            accuracy = 0

            # Start the model evaluation
            model.eval()

            # Refine the accuracy of the prediction without updating the gradients
            with torch.no_grad():

               # Load in all of the image inputs and labels from the TEST loader 
               for inputs, labels in testloader:

                  # Load the inputs and labels to the already selected device
                  inputs, labels = inputs.to(device), labels.to(device)

                  # Pass the images through the model, return the log probabilities of each label
                  logps = model.forward(inputs)

                  # Run the log probabilities through the criterion to get the output graph
                  batch_loss = criterion(logps, labels)

                  # Add the actual loss number to the running loss total for the test batch
                  test_loss += batch_loss.item()

                  # Return a new tensor with the true probabilities
                  ps = torch.exp(logps)

                  # Return the largest probability and class of the new tensor along a given dimension
                  top_p, top_class = ps.topk(1, dim=1)

                  # Reshape the tensor to match the same shape as the top class
                  equals = top_class == labels.view(*top_class.shape)

                  # Compute the accuracy and add it to the running accuracy count for the test batch
                  accuracy += torch.mean(equals.type(torch.FloatTensor)).item()

            # Append the training and testing losses
            train_losses.append(running_loss/len(trainloader))
            test_losses.append(test_loss/len(testloader))  

            # Display the accuracy of the prediction with 3 digits in the fractional part of the decimal
            print(f"\n     Epoch {epoch}/{epochs}: "
                  f"Train loss: {running_loss/print_every:.3f}.. "
                  f"Test loss: {test_loss/len(testloader):.3f}.. "
                  f"Test accuracy: {accuracy/len(testloader):.3f}\n")

            # Train the model
            running_loss = 0
            model.train()

            # After 5 training steps, start the next epoch
            # Break here in case the trainloader has remaining data
            break
   ```

   As the build progresses, the output shows each training step and epoch completed:

   ```output
   Training step 1
   Training step 2
   Training step 3
   Training step 4
   Training step 5
    
        Epoch 1/5: Train loss: 0.550.. Test loss: 0.282.. Test accuracy: 0.902
    
   Training step 6
   Training step 7
   Training step 8
   Training step 9
   Training step 10
    
        Epoch 2/5: Train loss: 0.451.. Test loss: 0.311.. Test accuracy: 0.842
    
   Training step 11
   Training step 12
   Training step 13
   ...
   ```

   Do you notice the output for each successive epoch takes slightly longer to display than the previous one?


## Analyze the training output

After five epochs are complete, the system reaches our `epoch` limit. 

```output
...
Training step 19
Training step 20

     Epoch 4/5: Train loss: 0.216.. Test loss: 0.189.. Test accuracy: 0.906

Training step 21
Training step 22
Training step 23
Training step 24
Training step 25

     Epoch 5/5: Train loss: 0.234.. Test loss: 0.175.. Test accuracy: 0.935
```

The output shows the prediction accuracy for each epoch iteration with training and testing losses, and the test accuracy.

Here are the results from our test with five epochs. Your specific results will differ because the computer chooses a set of random images for each test run. The results reveal the training loss, testing loss, and accuracy, all depend on the chosen image.

Epoch | Training loss | Test loss | Test accuracy
:---:|:---:|:---:|:---:
1 | 0.550 | 0.282 | 0.902
2 | 0.451 | 0.311 | 0.842
3 | 0.342 | 0.233 | 0.902
4 | 0.216 | 0.189 | 0.906
5 | 0.234 | 0.175 | 0.935


<!-- Links -->
[AnalyzeMod]: https://docs.microsoft.com/learn/modules/analyze-rock-images-ai-nasa/4-import-and-clean-data?azure-portal=true
[CheckEnviron]: https://docs.microsoft.com/learn/modules/train-test-predictive-ai-model-nasa/3-build-neural-network?azure-portal=true
