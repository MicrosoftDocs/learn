![](https://c1.staticflickr.com/2/1600/25660808075_c8190290f7_b.jpg)

Nvidia-Docker enables developers to easily pack, ship, and run any GPU intensive application as a lightweight, portable, self-sufficient container, which can run virtually anywhere. 

You might be thinking to yourself, if the DLVM base image comes with the most popular deep learning frameworks pre-installed, why should we even bother with containerization clients such as Nvidia-Docker?

Often when attempting to run deep learning tasks developers find themselves facing dependency nightmares, such as:

 - Having to build custom packages - Deep learning researchers tend to think less about production when they publish code to Git Hub. If they can get a package working on their own development environment, they often just assume that others will be able to do so as well.

 - GPU driver versioning - CUDA is a parallel computing platform and application programming interface (API) developed by Nvidia. It allows software developers and software engineers to use a CUDA-enabled graphics processing unit (GPU) for general purpose processing. Certain versions of Tensorflow won’t work with versions of CUDA above 9.1 but other frameworks such as PyTorch seem to perform better with later versions of CUDA.

To get around these issues and to increase the usability of code, you can use Nvidia-Docker to manage and run deep learning projects.


Quiz

- What is CUDA?
- What versioning issues do deep learning engineers deal with?

