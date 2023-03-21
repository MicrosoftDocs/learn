
*PyTorch* is a commonly used machine learning framework for training deep learning models. In Azure Databricks, PyTorch is preinstalled in **ML** clusters.

> [!NOTE]
> The code snippets in this unit are provided as examples to emphasize key points. You'll have a chance to run code for a full, working example in the exercise later in this module.

## Define a PyTorch network

In PyTorch, models are based on a network that you define. The network consists of multiple layers, each with specified inputs and outputs. Additionally, the work defines a **forward** function that applies functions to each layer as data is passed through the network.

The following example code defines a network.

```python
import torch
import torch.nn as nn
import torch.nn.functional as F

class MyNet(nn.Module):
    def __init__(self):
        super(MyNet, self).__init__()
        self.layer1 = nn.Linear(4, 5)
        self.layer2 = nn.Linear(5, 5)
        self.layer3 = nn.Linear(5, 3)

    def forward(self, x):
        layer1_output = torch.relu(self.layer1(x))
        layer2_output = torch.relu(self.layer2(layer1_output))
        y = self.layer3(layer2_output)
        return y
```

While the code may seem complex at first, this class defines a relatively simple network with three layers:

- An input layer that accepts four input values and generates five output values for the next layer.
- A layer that accepts five inputs and generates five outputs.
- A final output layer that accepts five inputs and generates three outputs.

The **forward** function applies the layers to the input data (***x***), passing the output from each layer to the next and finally returning the output from the last layer (which contains the label prediction vector, ***y***). A *rectified linear unit* (*ReLU*) activation function is applied to the outputs of layers 1 and 2 to constrain the output values to positive numbers.

> **Note** Depending on the type of loss criterion used, you may choose to apply an activation function such as a *log_softmax* to the return value to force it into the range 0 to 1. However, some loss criteria (such as *CrossEntropyLoss*, which is commonly used for multiclass classification) automatically apply a suitable function.

To create a model for training, you just need to create an instance of the network class like this:

```python
myModel = MyNet()
```

## Prepare data for modeling

PyTorch layers work on data that is formatted as *tensors* - matrix-like structures. There are various functions to convert other common data formats to tensors, and you can define a PyTorch *data loader* to read data tensors into a model for training or inferencing.

As with most supervised machine learning techniques, you should define separate datasets for training and validation. This separation enables you to validate that the model predicts accurately when presented with data on which it wasn't trained.

The following code defines two data loaders; one for training and the other for testing. The source data for each loader in this example is assumed to be a Numpy array of feature values and a Numpy array of corresponding label values.

```python
# Create a dataset and loader for the training data and labels
train_x = torch.Tensor(x_train).float()
train_y = torch.Tensor(y_train).long()
train_ds = td.TensorDataset(train_x,train_y)
train_loader = td.DataLoader(train_ds, batch_size=20,
    shuffle=False, num_workers=1)

# Create a dataset and loader for the test data and labels
test_x = torch.Tensor(x_test).float()
test_y = torch.Tensor(y_test).long()
test_ds = td.TensorDataset(test_x,test_y)
test_loader = td.DataLoader(test_ds, batch_size=20,
    shuffle=False, num_workers=1)
```

The loaders in this example split the data into batches of 30, which are passed to the **forward** function during training or inference.

## Choose a loss criterion and optimizer algorithm

The model is trained by feeding the training data into the network, measuring the loss (the aggregated difference between predicted and actual values), and optimizing the network by adjusting the weights and balances to minimize loss. The specific details of how loss is calculated and minimized is governed by the loss criterion and optimizer algorithm you choose.

### Loss criteria

PyTorch supports multiple loss criteria functions, including (among many others):

- **cross_entropy**: A function that measures the aggregate difference between predicted and actual values for multiple variables (typically used to measure loss for class probabilities in multiclass classification).
- **binary_cross_entropy**: A function that measures the difference between predicted and actual probabilities (typically used to measure loss for class probabilities in binary classification).
- **mse_loss**: A function that measures the mean square error loss for predicted and actual numeric values (typically used for regression).

To specify the loss criterion you want to use when training your model, you create an instance of the appropriate function; like this:

```python
import torch.nn as nn

loss_criteria = nn.CrossEntropyLoss
```

> [!TIP]
> For more information about available loss criteria in PyTorch, see [Loss functions](https://pytorch.org/docs/stable/nn.functional.html?azure-portal=true#loss-functions) in the PyTorch documentation.

### Optimizer algorithms

Having calculated the loss, an optimizer is used to determine how best to adjust the weights and balances in order to minimize it. Optimizers are specific implementations of a *gradient descent* approach to minimizing a function. Available optimizers in PyTorch include (among others):

- **Adadelta**: An optimizer based on the [Adaptive Learning Rate](https://arxiv.org/abs/1212.5701?azure-portal=true) algorithm.
- **Adam**: A computationally efficient optimizer based on the [Adam](https://arxiv.org/abs/1212.5701?azure-portal=true) algorithm.
- **SGD**: An optimizer based on the [stochastic gradient descent](https://en.wikipedia.org/wiki/Stochastic_gradient_descent?azure-portal=true) algorithm.

To use any of these algorithms to train a model, you need to create an instance of the optimizer and set any required parameters. The specific parameters vary depending on the optimizer chosen, but most require you to specify a **learning rate** that governs the size of adjustments made with each optimization.

The following code creates an instance of the **Adam** optimizer.

```python
import torch.optim as opt

learning_rate = 0.001
optimizer = opt.Adam(model.parameters(), lr=learning_rate)
```

> [!TIP]
> For more information about available optimizers in PyTorch, see [Algorithms](https://pytorch.org/docs/stable/optim.html?azure-portal=true#algorithms) in the PyTorch documentation.

## Create train and test functions

After you've defined a network and prepared data for it, you can use the data to train and test a model by passing the training data through the network, calculating the loss, optimizing the network weights and biases, and validating the performance of the network with the test data. It's common to define a function that passes data through the network to *train* the model with the training data, and a separate function to *test* the model with the test data.

### Create a train function

The following example shows a function to train a model.

```python
def train(model, data_loader, optimizer):

    # Use GPU if available, otherwise CPU
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    model.to(device)
    
    # Set the model to training mode (to enable backpropagation)
    model.train()
    train_loss = 0
    
    # Feed the batches of data forward through the network
    for batch, tensor in enumerate(data_loader):
        data, target = tensor # Specify features and labels in a tensor
        optimizer.zero_grad() # Reset optimizer state
        out = model(data) # Pass the data through the network
        loss = loss_criteria(out, target) # Calculate the loss
        train_loss += loss.item() # Keep a running total of loss for each batch

        # backpropagate adjustments to weights/bias
        loss.backward()
        optimizer.step()

    #Return average loss for all batches
    avg_loss = train_loss / (batch+1)
    print('Training set: Average loss: {:.6f}'.format(avg_loss))
    return avg_loss
```

The following example shows a function to test the model.

```python
def test(model, data_loader):
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    model.to(device)
    # Switch the model to evaluation mode (so we don't backpropagate)
    model.eval()
    test_loss = 0
    correct = 0

    # Pass the data through with no gradient computation
    with torch.no_grad():
        batch_count = 0
        for batch, tensor in enumerate(data_loader):
            batch_count += 1
            data, target = tensor
            # Get the predictions
            out = model(data)

            # calculate the loss
            test_loss += loss_criteria(out, target).item()

            # Calculate the accuracy
            _, predicted = torch.max(out.data, 1)
            correct += torch.sum(target==predicted).item()
            
    # Calculate the average loss and total accuracy for all batches
    avg_loss = test_loss/batch_count
    print('Validation set: Average loss: {:.6f}, Accuracy: {}/{} ({:.0f}%)\n'.format(
        avg_loss, correct, len(data_loader.dataset),
        100. * correct / len(data_loader.dataset)))
    return avg_loss
```

## Train the model over multiple epochs

To train a deep learning model, you typically run the training function multiple times (referred to as *epochs*), with the goal of reducing the loss calculated from the training data each epoch. You can use your testing function to validate that the loss from the test data (on which the model wasn't trained) is also reducing in line with the training loss -  in other words that the model training isn't producing a model that is *overfitted* to the training data.

> [!TIP]
> You don't need to run the test function for every epoch. You might choose to run it every second epoch, or once at the end. However, testing the model as it is trained can be helpful in determining after how many epochs a model starts to become overfitted.

The following code trains a model over 50 epochs.

```python
epochs = 50
for epoch in range(1, epochs + 1):

    # print the epoch number
    print('Epoch: {}'.format(epoch))
    
    # Feed training data into the model to optimize the weights
    train_loss = train(model, train_loader, optimizer)
    print(train_loss)
    
    # Feed the test data into the model to check its performance
    test_loss = test(model, test_loader)
    print(test_loss)
```

## Save the trained model state

After you've successfully trained a model, you can save its weights and biases like this:

```python
model_file = '/dbfs/my_model.pkl'
torch.save(model.state_dict(), model_file)
```

To load and use the model at a later time, create an instance of the network class on which the model is based and load the saved weights and biases.

```python
model = myNet()
model.load_state_dict(torch.load(model_file))
```
