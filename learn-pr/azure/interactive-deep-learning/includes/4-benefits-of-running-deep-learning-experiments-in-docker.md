![Docker logo](../media/3-image1.PNG)

Docker is a tool that allows you to deploy your applications in a sandbox to run on a host operating system of your choice. It allows you to package your app with all of its dependencies in a standardized unit. But if the DSVM base image comes with the most popular deep learning frameworks already pre-installed, why would you use Docker?

When attempting to run deep learning tasks, developers find themselves facing dependency issues. For example: 

- Having to build custom packages - Deep learning researchers tend to think less about production when they publish code to GitHub. If they can get a package working on their own development environment, they often just assume that others will be able to do so as well.
- GPU driver versioning - CUDA is a parallel computing platform and application programming interface (API) developed by NVIDIA. It allows developers to use a CUDA-enabled graphics processing unit (GPU) for general-purpose processing. Certain versions of Tensorflow will not work with versions of CUDA above 9.1. Other frameworks, such as PyTorch, seem to perform better with later versions of CUDA.

To get around these issues and to increase the usability of code, you can use Docker or its GPU variant NVIDIA Docker to manage and run deep learning projects. 

<!--Quiz 
What is CUDA? 
What versioning issues do deep learning engineers deal with? -->