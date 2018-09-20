The goal of Machine Learning (ML) is to find features to train a model that transforms input data (such as pictures, time series, or audio) to a given output (for example captions, price values, transcriptions). In traditional data science, features are often handcrafted. These handcrafted features are fed into a shallow learning algorithm, such as the network shown in the following diagram. 

![Canonical example of a feed forward deep neural network.](../media/2-image1.PNG)

In Deep Learning (DL), the process of feature extraction is learned through representing inputs as vectors and transforming them, with a series of clever linear algebra operations, into a given output.  The model output is compared against the expected output using an equation called a loss function. The value returned by the loss function of each training input is used to guide the model to extract features that will result in a lower loss value on the next pass. This process is called *training*. 

Through training, these algorithms learn the best performing and most appropriate features for the given dataset. They are called deep because of the number of layers in the network.  

The series of matrix operations that we compute as part of the linear algebra component are computationally expensive. These operations can often be processed in parallel, making them great candidates for specialized compute such as Graphics Processing Units (GPUs) to compute efficiently.

Setting up an environment to do deep learning is non-trivial. What's the hardware setup, do you train your model with CPUs or GPUs, and how much memory should these machines have? Creating and training a deep learning network needs the right software to be installed. You've lots of  deep learning frameworks to choose from, but need to be mindful of dependencies between each component. After all of this setup, you might find a great model created on another framework and would like to try it out. You don’t want the overhead of getting a new deep learning framework with all of its dependencies set up on your machine. The Data Science Virtual Machine can help solve these problems. 

## What is a Data Science Virtual Machine (DSVM)?

![Data Science Virtual Machine infographic depicting how it is pre-installed, configured, and tested with several popular tools that are commonly used for data analytics, machine learning and AI training.](../media/2-image2.PNG)

The Data Science Virtual Machine is a virtual machine (VM) image on Azure. It has many popular data science and deep learning tools already installed and configured. These images come with popular data science and machine learning tools, including Microsoft R Server Developer Edition, Microsoft R Open, Anaconda Python, Julia, Jupyter notebooks, Visual Studio Code, RStudio, xgboost, and many more.  Instead of rolling out a comparable workspace on your own, you can provision a DSVM - saving you lots of time on the installation, configuration, and package management processes. Once your DSVM has been deployed, you can immediately begin working on your data science project.

The DSVM can be used for training models using deep learning algorithms on Graphics processing units (GPUs) hardware. Utilizing VM scaling capabilities of Azure cloud, DSVM helps you use GPU-based hardware on the cloud as per need. You can switch to a GPU-based VM when training large models or need high-speed computations while keeping the same OS disk. The Windows Server 2016 edition of DSVM comes pre-installed with GPU drivers, frameworks, and GPU versions of deep learning frameworks. On the Linux, deep learning on GPU is enabled on both the CentOS and Ubuntu DSVMs. You can also deploy the Ubuntu, CentOS, or Windows 2016 edition of the Data Science VM to CPU-based Azure virtual machines, in which case all the deep learning frameworks will fallback to CPU mode. 

For more information on what you can do with a DSVM, see [Data science with a Linux Data Science Virtual Machine on Azure](https://docs.microsoft.com/azure/machine-learning/data-science-virtual-machine/linux-dsvm-walkthrough)



