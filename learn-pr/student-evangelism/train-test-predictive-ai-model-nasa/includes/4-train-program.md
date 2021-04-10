We now have an AI model that incorporates a neural network. We provided some data to our program to teach it the different features of space rocks. The program has plenty of neurons and they're wired together in a deep learning network.

Now, it's time to train our program. We'll use our training data from NASA. We'll add code to help our program become accurate in classifying space rocks.


## Iterate on the data and increase the accuracy

In this section of code, look for the `epochs` variable. This variable tells the program how many times to search for associations in the features. In our example, we'll set the initial number of iterations to 5.

> [!Note]
> You can increase the number of iterations to further improve the accuracy of the model.
> Keep in mind that increasing the number of iterations makes the code run slower.

We'll use data structures from the NumPy library to store parameters. We'll use algorithms and calculations from the PyTorch library and torchvision package to refine the prediction accuracy.

> [!Note]
> **Sarah ToDo**
> - Describe some of the NumPy structures, and PyTorch and torchvision APIs
> - For example:
> train_loss and test_loss
> optimizer.zero_grad
> loss = criterion(logps, labels)
> model.eval()
> torch.mean(equals.type(torch.FloatTensor)).item()
> and so on


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
            
               # Display the accuracy of the prediction with 3 digits in the fractional part of the decimal
               print(f"Epoch {epoch+1}/{epochs}.. "
                     f"Train loss: {running_loss/print_every:.3f}.. "
                     f"Test loss: {test_loss/len(testloader):.3f}.. "
                     f"Test accuracy: {accuracy/len(testloader):.3f}")

               # Train the model
               running_loss = 0
               model.train()
   ```

   As the build progresses, the output shows each training step and epoch completed:

    ```output
    Training step  1
    Training step  2
    Training step  3
    Training step  4
    Training step  5
    Epoch 1/5.. Train loss: 1.990.. Test loss: 0.472.. Test accuracy: 0.810
    Training step  6
    Training step  7
    Training step  8
    Training step  9
    Training step  10
    Epoch 2/5.. Train loss: 0.679.. Test loss: 0.372.. Test accuracy: 0.935
    Training step  11
    Training step  12
    ...
    ```

   Do you notice the output for each successive epoch takes slightly longer to display than the previous one?


## Analyze the training output

After five epochs are complete, the system reaches our `epoch` limit. 

    ```output
    ...
    Training step  31
    Training step  32
    Training step  33
    Training step  34
    Training step  35
    Epoch 5/5.. Train loss: 0.271.. Test loss: 0.172.. Test accuracy: 0.933
    Training step  36
    Training step  37
    Training step  38
    Training step  39
    Training step  40
    Epoch 5/5.. Train loss: 0.263.. Test loss: 0.372.. Test accuracy: 0.802
    ```

The output shows the prediction accuracy for each epoch iteration with training and testing losses, and the test accuracy.

In the first epoch, we see a training loss of 1.990, a test loss of 0.472, and a test accuracy of 0.810.
For the final epoch, we see a training loss of 0.263, a test loss of 0.372, and a test accuracy of 0.802.

> [!Note]
> **Sarah ToDo**
> - Describe the two loss values and the accuracy value in more detail.
> - Describe why the accuracy does not get better from epoch to epoch. Why does it fluctuate?
> - In the output, why do we see two sets of "Ephoch 2/5," "Epoch 4/5," and "Epoch 5/5"?


<!-- Links -->
[CheckEnviron]: https://docs.microsoft.com/learn/modules/train-test-predictive-ai-model-nasa/3-build-neural-network?azure-portal=true
