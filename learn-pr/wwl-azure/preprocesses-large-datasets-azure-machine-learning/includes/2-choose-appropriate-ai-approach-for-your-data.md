Machine learning and deep learning are two approaches to analyze your data. Using GPU-optimized virtual machines in Azure Machine Learning can speed up training when using both machine learning or deep learning algorithms.

The company you work for as a data scientist has given you a large amount of data. You want to analyze the data to make any insights available to the analytics team. You've heard about machine learning and deep learning, but are unsure which approach to use in this situation.

You'll learn about the difference between machine learning and deep learning. And when to use CPU or GPU virtual machine types in Azure Machine Learning.

## Machine learning or deep learning

**Machine learning** and **deep learning** are both data science fields that allow you to build models on data to make predictions or decisions. Let's review what each of these fields are used for.

### Machine learning

Machine learning is the practice of using algorithms to analyze data. By training a model on a large dataset, we can derive predictions or decisions from the data.

Some examples of what machine learning can be used for:

- **Classification**: predict a categorical value.
- **Regression**: predict a numerical value.
- **Time-series forecasting**: predict future numerical values based on time-stamped data.

### Deep learning

**Deep learning** is an advanced form of machine learning that tries to mimic the way the human brain learns.

The human brain works by examples. We experience what input corresponds to what output. For example, we see round and red shapes in an image, and learn that the shapes correspond to an apple. By experiencing similar inputs and outputs, we improve over time and eventually are able to correctly identify an apple. 

A deep learning algorithm works in a similar way. The list of examples is the dataset a model uses during training time. The model takes the input and tries to guess what the output should be during an epoch. At the end of an epoch, the model finds out if the answer was correct and takes that learning to improve over time.

Some examples of what deep learning can be used for:

- **Computer vision**: classify images or detect objects in images.
- **Voice recognition**: transcribe speech to text and identify the individual speaker.
- **Real-time language translation**: translate text in real time for automatic subtitles.

> [!NOTE]
> If you're new to deep learning, explore it in more depth by going through Microsoft's learn module about how to [train and evaluate deep learning models](/learn/modules/train-evaluate-deep-learn-models/) and NVIDIA's course on [building a brain in 10 minutes](https://courses.nvidia.com/courses/course-v1:DLI+T-FX-01+V1/about).

Whether working with machine learning or deep learning algorithms, it's important to have a good *quality* dataset to improve your model's performance. Next to quality, data scientists also strive for large datasets as more data *can* result in a more representative model. 

Both the amount of data you use and the algorithm you choose requires enough compute power. Within Azure Machine Learning, you can easily choose the compute that suits your workload best.

## CPU or GPU compute

Azure Machine Learning supports the use of both CPU, and GPU virtual machines when creating compute instances or clusters. You can run a script with either compute type, but when should you use which?

For standard workloads, a CPU virtual machine type is likely to be sufficient. For example, if you have a small dataset and you want to manipulate the data with the *pandas* library, use CPU. 

> [!NOTE]
> Some frameworks and libraries only work with either CPU or GPU compute. Be aware of the restrictions of the framework or library you want to work with to avoid paying for unused resources. For example, *scikit-learn* is only compatible with CPU compute.

Alternatively, GPU-optimized compute is more powerful, which results in faster processing. The performance GPU offers however, comes at a larger cost. If you want to train a deep learning model with the *TensorFlow* or *PyTorch* library, for example, you’ll need GPU compute to do it efficiently.

Whether you should use GPU instead of CPU compute depends on the data you work with and the processing you want to do. In general, GPUs can be more cost-efficient when:

- You use a large dataset for training, slowing down model training.
- You train deep learning models.

Whenever CPUs appear to increase the processing time significantly, GPUs can minimize costs by running the workload in a fraction of the time. 

> [!TIP]
> Learn more about [GPU optimized virtual machine sizes](/azure/virtual-machines/sizes-gpu).
