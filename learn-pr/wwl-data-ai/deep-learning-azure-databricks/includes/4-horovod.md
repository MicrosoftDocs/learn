
PyTorch, in common with other common deep learning frameworks like TensorFlow, is designed to scale across multiple processors (CPUs or GPUs) on a single computer. In most cases, this approach to scaling *up* by using computers with more or faster processors provides adequate training performance. However, when you need to work with extremely complex neural networks or large volumes of training data, you may benefit from Apache Spark's inherent ability to scale *out* processing tasks across multiple worker nodes.

Azure Databricks uses Spark clusters that can include multiple worker nodes. Additionally, the **ML** databricks runtimes in Azure Databricks include *Horovod*, and open source library that enables you to distribute machine learning training tasks across the nodes in a cluster.

## Create a training function

The first step to use Horovod is to create a function that encapsulates the code you use to call your train function. The code in this "outer" function can take advantage of various Horovod classes and functions to distribute data and optimizer state across all of the nodes involved in the training process.

The following code example shows a function for managing a distributed training run.

```python
import horovod.torch as hvd
from sparkdl import HorovodRunner

def train_hvd(model):
    from torch.utils.data.distributed import DistributedSampler
    
    hvd.init()
    
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    if device.type == 'cuda':
        # Pin GPU to local rank
        torch.cuda.set_device(hvd.local_rank())
    
    # Configure the sampler so that each worker gets a distinct sample of the input dataset
    train_sampler = DistributedSampler(train_ds, num_replicas=hvd.size(), rank=hvd.rank())
    # Use train_sampler to load a different sample of data on each worker
    train_loader = torch.utils.data.DataLoader(train_ds, batch_size=20, sampler=train_sampler)
    
    loss_criteria = nn.CrossEntropyLoss()
    # Scale the learning_rate based on the number of nodes
    learning_rate = 0.001 * hvd.size()
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
    
    # Wrap the local optimizer with hvd.DistributedOptimizer so that Horovod handles the distributed optimization
    optimizer = hvd.DistributedOptimizer(optimizer, named_parameters=model.named_parameters())

    # Broadcast initial parameters so all workers work with the same parameters
    hvd.broadcast_parameters(model.state_dict(), root_rank=0)
    hvd.broadcast_optimizer_state(optimizer, root_rank=0)

    # Train over 50 epochs
    epochs = 50
    for epoch in range(1, epochs + 1):
        print('Epoch: {}'.format(epoch))
        # Feed training data into the model to optimize the weights
        train_loss = train(model, train_loader, optimizer)

    # Save the model weights
    if hvd.rank() == 0:
        model_file = '/dbfs/myModel_hvd.pkl'
        torch.save(model.state_dict(), model_file)
        print('model saved as', model_file)
```

## Run the function on multiple nodes

After you've defined the function to call your training function, you can use the **HorovodRunner** class to run it across multiple nodes in your cluster, as shown here:

```python
# Create a new model
hvd_model = MyNet()

# Run the distributed training function on 2 nodes
hr = HorovodRunner(np=2) 
hr.run(train_hvd, model=hvd_model)
```
