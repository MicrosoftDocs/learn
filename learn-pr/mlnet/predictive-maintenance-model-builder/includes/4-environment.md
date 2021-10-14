In this unit, you'll learn about the computing environments supported by Model Builder

## What are compute environments?

Compute environments describes to the compute resources you'll use to train your machine learning model. 

## Which environments are supported in Model Builder?

Model Builder supports the following environment options:

| Scenario | Compute | CPU | GPU |
| --- | --- | --- |
| Data classification | Local | X | |
| Value prediction | Local | X | |
| Image classification | Local, Azure | X | X |
| Recommendation | Local | X | |
| Object detection | Azure | | X |

Note that for the image classification scenario, GPU training is supported for local and Azure environments.

Depending on your use case and support, there are various reasons why you might choose one over the other.

### Local compute environments

Some reasons why you might consider local compute environments include:

- Training locally doesn't cost you anything since you're using your computer's resources.
- For scenarios where you don't want your data to leave your computer or data center, training locally is a good option.

### Azure compute environments

Scenarios like image classification and object detection are resource intensive. Using a GPU can often speed up the training process. If you don't have a GPU a computer with enough CPU or RAM, offloading the training process to Azure can lighten the load on your system.

In the next unit, you'll choose the compute environment for your predictive maintenance model.
