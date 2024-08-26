PyTorch, in common with other deep learning frameworks like TensorFlow, is designed to scale across multiple processors (CPUs or GPUs) on a single computer. In most cases, this approach to scaling *up* by using computers with more or faster processors provides adequate training performance.

However, when you need to work with complex neural networks or large volumes of training data, you can benefit from Apache Spark's inherent ability to scale *out* processing tasks across multiple worker nodes.

Azure Databricks uses Spark clusters that can include multiple worker nodes. To make optimal use of those clusters, you can use **TorchDistributor**, an open-source library that enables you to distribute PyTorch training jobs across the nodes in a cluster. TorchDistributor is available on Databricks Runtime ML 13.0 and above.

When you already trained a model with PyTorch, you can convert your single process training to distributed training with TorchDistributor by:

1. **Adapt your existing code**: Modify your single-node training code to be compatible with distributed training. Ensure that your training logic is encapsulated within a single function.
1. **Move imports within the training function**: Place necessary imports, such as `import torch`, inside the training function to avoid common pickling errors.
1. **Prepare the training function**: Include your model, optimizer, loss function, and training loop within the training function. Ensure that the model and data are moved to the appropriate device (CPU or GPU).
1. **Instantiate and run TorchDistributor**: Create an instance of `TorchDistributor` with the desired parameters and call `.run(*args)` to launch the distributed training.

## Adapt your existing code

First, you need to modify your single-node training code to be compatible with distributed training. When you modify your code, you need to ensure that your training logic is encapsulated within a single function. This function is used by **TorchDistributor** to distribute the training across multiple nodes.

```python
import torch.nn as nn

class SimpleModel(nn.Module):
    def __init__(self):
        super(SimpleModel, self).__init__()
        self.fc = nn.Linear(10, 1)
    
    def forward(self, x):
        return self.fc(x)
```

Now you can prepare your dataset that is in a format compatible with PyTorch using `torch.utils.data.DataLoader`.

```python
# Sample data
inputs = torch.randn(100, 10)
targets = torch.randn(100, 1)

# Create dataset and dataloader
from torch.utils.data import DataLoader, TensorDataset
dataset = TensorDataset(inputs, targets)
dataloader = DataLoader(dataset, batch_size=10)
```

## Move imports within the training function

To avoid common pickling errors, place necessary imports, such as `import torch`, inside the training function. Placing all imports within the training function ensures that all required modules are available when the function is distributed across multiple nodes.

## Prepare the training function

Include your model, optimizer, loss function, and training loop within the training function. Ensure that the model and data are moved to the appropriate device (CPU or GPU).

```python
def train_model(dataloader):
    import torch
    import torch.nn as nn
    from torch.optim import SGD

    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model = SimpleModel().to(device)
    optimizer = SGD(model.parameters(), lr=0.01)
    loss_fn = nn.MSELoss()
    
    for epoch in range(10):
        for batch in dataloader:
            inputs, targets = batch
            inputs, targets = inputs.to(device), targets.to(device)
            optimizer.zero_grad()
            outputs = model(inputs)
            loss = loss_fn(outputs, targets)
            loss.backward()
            optimizer.step()
```

## Instantiate and run TorchDistributor

Create an instance of `TorchDistributor` with the desired parameters and call `.run(*args)` to launch the distributed training. Running TorchDistributor distributes the training tasks across multiple nodes.

```python
from pyspark.ml.torch.distributor import TorchDistributor

# Distribute the training
distributor = TorchDistributor(num_workers=4)
distributor.run(train_model, dataloader)
```

## Monitor and evaluate your training job

You can use the built-in tools to monitor your cluster's performance, including CPU or GPU usage, and memory utilization. When training is complete, you can evaluate the model on a validation or test dataset using PyTorch evaluation techniques to assess your model's performance.

```python
# Evaluate the model (after distributed training is complete)
model.eval()
with torch.no_grad():
    for inputs, targets in dataloader:
        outputs = model(inputs)
        # Perform evaluation logic
```

> [!Tip]
> Learn more about [distributed training with TorchDistributor](/azure/databricks/machine-learning/train-model/distributed-training/spark-pytorch-distributor?azure-portal=true).
