You want to train deep learning models using the open-source frameworks TensorFlow, Keras, or PyTorch in Azure Databricks. You tried using a single-node cluster but your model or data is too large for the cluster. In that case, you may choose to use Horovod on top of your work so far to distribute the training. Let's explore how we can do that using **HorovodRunner**.

## Trigger Horovod in Azure Databricks with HorovodRunner

HorovodRunner is a general API, which triggers Horovod jobs. The benefit of using HorovodRunner instead of the Horovod framework directly, is that HorovodRunner has been designed to distribute deep learning jobs across *Spark* workers. As a result, HorovodRunner is more stable for long-running deep learning training jobs on Azure Databricks.

## Horovod process

To distribute the training of a deep learning model using HorovodRunner, you should do the following:

- Prepare and test single-node code with TensorFlow, Keras, or PyTorch.
- Migrate the code to Horovod.
- Use HorovodRunner to run the code and distribute your work.

### Run single-node training

Before working with Horovod and HorovodRunner, the code used to train the deep learning model should be tested on a single-node cluster. Once it works, make sure to wrap the main training procedure into a single Python function. This function will be used later on to initiate the distributed execution of your code.

### Migrate to Horovod

Once you have tested your single-node code to train a deep learning model, you have to migrate it to Horovod before you can trigger the job with HorovodRunner.

1. Import the Horovod framework as `hvd`.
1. Initialize the Horovod library with `hvd.init()`.
1. Pin one GPU per process. Pinning is necessary to disable random mapping of workers and avoid clashes. Pinning is skipped when using CPUs.
1. Specify how you want to partition or sample the data so that each worker uses a unique subset of the data to train a model. As a best practice, make sure the subsets are all the same size. Depending on the input dataset, there are several techniques to do the sampling. For example, you could use Petastorm to work with datasets in Apache Parquet format. Learn more about the open-source library Petastorm [here](https://github.com/uber/petastorm).
1. Scale the learning rate by the number of workers to make sure the weights are adjusted correctly after each epoch.
1. Use the Horovod distributed optimizer to handle the communication between workers.
1. Broadcast the initial parameters so all workers start with the same parameters.
1. Save checkpoints only on worker 0 to prevent conflicts between workers.

### Use HorovodRunner

To run HovorodRunner, you have to create a `HorovodRunner` instance in which you specify how many nodes (defined by the argument `np`) you want to distribute your work to. You can specify to use one node if you want to test on a single-node cluster with `np=-1`. Finally, you can trigger the Horovod training job with HorovodRunner by invoking the Python function you created for your training code.