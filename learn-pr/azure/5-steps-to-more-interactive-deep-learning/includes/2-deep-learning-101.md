# Intro to deep learning.

The goal of Machine Learning ML is to find features to train a model that transforms input data (such as pictures, time series, or audio) to a given output (eg captions, price values, transcriptions). In traditional data science these features are often hand selected.

![Put picture here of a canonical example of a feed forward deep neural network.](http://www.texample.net/media/tikz/examples/PNG/neural-network.png)

In Deep Learning (DL) we learn to extract these features by representing our inputs as vectors and transforming them with a series of clever linear algebra operations into a given output. 

We then evaluate whether our output is what we expected using an equation called a loss function. The goal of the process is to use the result of the loss function from each training input to guide our model to extract features that result in a lower loss value on the next pass. 

The series of matrix opperations that we computer as part of the linear algebra component tend to be computational expensive and heavily parallelized requiring specialized compute such as Graphics Processing Units GPU's.   

# Data Science Virtual Machine

![](https://azurecomcdn.azureedge.net/cvt-569abacd3eadc3d5032bef3afa7f751fe0d36630318be7d55ce9732a37e0c116/images/page/services/virtual-machines/data-science-virtual-machines/diagram-1.jpg)

DSVMs are Azure Virtual Machine images, pre-installed, configured and tested with several popular tools that are commonly used for data analytics, machine learning and deep learning training.

They provide
- Consistent setup across team, promote sharing and collaboration, Azure scale and management, Near-Zero Setup, full cloud-based desktop for data science.

- On-demand elastic capacity Ability to run analytics on all Azure hardware configurations with vertical and horizontal scaling. Pay only for what you use, when you use it.


- Deep Learning with GPUs Readily available GPU clusters with Deep Learning tools already pre-configured. Specialized Deep Learning Virtual Machines with samples and workflows.

The DSVM contains several tools for AI including popular GPU editions of deep learning frameworks and tools such as Microsoft R Server Developer Edition, Anaconda Python, Jupyter notebooks for Python and R, IDEs for Python and R, SQL database and many other data science and ML tools.

The DSVM can run on Azure GPU NC-series VM instances. These GPUs use discrete device assignment, resulting in performance close to bare-metal, and are well-suited to deep learning problems.

### Py Torch
![](https://notebooks.azure.com/goldengrape/libraries/pytorch-tutorial/raw/logo/pytorch_logo.png)

Typically deep learning engineers don't hard code matrix algebra operations all by hand. They instead use frameworks such as PyTorch or TensorFlow. 

PyTorch is a python based framewok that provides flexibility as a deep learning development platform. PyTorch's workflow is built on top of python scientific computing library numpy.

Now you might ask, why would we use PyTorch to build deep learning models? 

- Easy to use API – It is as simple as python can be.

- Python support – PyTorch smoothly integrates with the scientific computing stack.

- Dynamic computation graphs – Instead of predefined graphs with specific functionalities, PyTorch build computational graphs dynamically that can be modified during runtime. This is valuable for nested batching and when one a developer doesn't know how memory is going to be needed for creating a network.


Quiz?

What is the goal of machine learning?

How is traditional machine learning different from deep learning?

Why are GPU's often used for deep learning?

What does the DSVM provide?

What is pytorch?