Getting into the deep learning space can be costly and time consuming. You need the right software stack and hardware to train your models. As we saw in this module, Azure can help on multiple fronts. The Data Science Virtual Machine comes preinstalled with a number of deep learning frameworks and tools to help build Artificial Intelligence (AI) applications. The DSVM runs seamlessly on a CPU-based virtual machine. If you want to isolate your development environment, you can containerize it with Docker, which is already installed. The same DSVM runs seamlessly on GPU-based virtual machines and includes nvidia-docker to containerize your GPU-accelerated stack and run your models on those powerful processors. This flexibility in software and hardware means that you can dynamically change your deep learning investment as needed. 

As a next step, you can explore more of the tools available on the DSVM or run more of the sample notebooks. 

## Clean up resources

In this module you created resources using your Azure subscription. You want to clean up these resources so that you will not continue to be charged for them. Run the following command in the cloud shell to delete all the resources.

```azurecli
az group delete --name learn-deep-dsvm
```

Type `y` to confirm.

## Further Reading

- [Get to know your Data Science Virtual Machine](https://docs.microsoft.com/azure/machine-learning/data-science-virtual-machine/dsvm-tools-overview)
- [Introduction to Azure Data Science Virtual Machine for Linux and Windows](https://docs.microsoft.com/azure/machine-learning/data-science-virtual-machine/overview)
- [NVIDIA Docker Container documentation](https://www.nvidia.com/object/docker-container.html)
