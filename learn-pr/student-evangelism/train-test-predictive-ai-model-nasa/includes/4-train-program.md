We now have an AI model that incorporates a neural network. We provided some data to our program to teach it the different features of space rocks. The program has plenty of neurons and they're wired together in a deep learning network.

Now, it's time to train our program. We'll use our training data from NASA. We'll add code to help our program become accurate in classifying space rocks.


### Check your working environment

Before you can add new code to your AI model, we need to make sure your development environment is still active.

If you closed your Anaconda prompt, or Visual Studio Code, follow the steps in [Check your working environment][CheckEnviron] in the previous unit. After your working environment is ready, continue to the next section in this unit.

If your Anaconda prompt and Visual Studio Code are still open from the last exercise, continue to the next section.


## Iterate on the data and increase the accuracy

In this section of code, look for the `epochs` variable. This variable tells the program how many times to search for associations in the features. In our example, we'll set the initial number of iterations to 5.

> [!Note]
> You can increase the number of iterations to further improve the accuracy of the model.
> Keep in mind that increasing the number of iterations makea the code run slower.

We'll use data structures from the NumPy library to store parameters. We'll use algorithms and calculations from the PyTorch library and torchvision package to refine the prediction accuracy.

> [!Note]
> **Sarah ToDo**
> - Describe some of the NumPy structures.
> - Describe some of the PyTorch and torchvision APIs.
> 

## Train the neural network

Follow these steps to train the neural network in your AI model.

1. Return to Visual Studio Code, and open your Jupyter Notebook file. In our example, we're using the file *ClassifySpaceRockProgram.ipynb*.

1. Make sure you're running the correct Jupyter kernel. At the upper-right and lower-left corners of Visual Studio, change to the Anaconda environment `('myenv')` that you created earlier.

1. Add the following code in a new cell, and then run the cell.

   > [!Note]
   > **Sarah - ToDo**
   > - Add more comments to the code.
   > 

   ```python
   # Set the initial number of iterations to search for associations
   epochs = 5
   steps = 0
   running_loss = 0
   print_every = 5
   train_losses, test_losses = [], []

   # Search for associations in the features
   for epoch in range(epochs):
       for inputs, labels in trainloader:

           steps += 1
           print('Training step ', steps)
           inputs, labels = inputs.to(device), labels.to(device)
           optimizer.zero_grad()
           logps = model.forward(inputs)
           loss = criterion(logps, labels)
           loss.backward()
           optimizer.step()
           running_loss += loss.item()

           if steps % print_every == 0:
               test_loss = 0
               accuracy = 0
               model.eval()

               # Refine the accuracy of the prediction
               with torch.no_grad():
                   for inputs, labels in testloader:
                       inputs, labels = inputs.to(device), labels.to(device)
                       logps = model.forward(inputs)
                       batch_loss = criterion(logps, labels)
                       test_loss += batch_loss.item()
                    
                       ps = torch.exp(logps)
                       top_p, top_class = ps.topk(1, dim=1)
                       equals = top_class == labels.view(*top_class.shape)
                       accuracy += torch.mean(equals.type(torch.FloatTensor)).item()

               train_losses.append(running_loss/len(trainloader))
               test_losses.append(test_loss/len(testloader))  
            
               # Display the accuracy of the prediction
               print(f"Epoch {epoch+1}/{epochs}.. "
                     f"Train loss: {running_loss/print_every:.3f}.. "
                     f"Test loss: {test_loss/len(testloader):.3f}.. "
                     f"Test accuracy: {accuracy/len(testloader):.3f}")

               # Train the model
               running_loss = 0
               model.train()
   ```

   When the build completes, the output for the command shows training for five steps:

   ```output
   Training step  1
   Training step  2
   Training step  3
   Training step  4
   Training step  5
   ```

Did you notice the output for each successive step took longer to display than the previous step? As noted earlier, the more iterations we run to train the model, the longer the training takes to complete.


<!-- Links -->
[CheckEnviron]: https://docs.microsoft.com/learn/modules/train-test-predictive-ai-model-nasa/3-build-neural-network?azure-portal=true
