Now that you are connected to your Data Science Virtual Machine, you can begin using it to do data science. 

The Data Science Virtual Machine comes with tools preinstalled for:

- Python
- R
- Julia
- Node.js
- Java

You can, of course, add additional programming languages, desktop applications, database tools, and so forth.

## Run a Jupyter server from a custom Python environment

In the last unit, you connected to the desktop of your Ubuntu Data Science Virtual Machine. One of the icons on the desktop is labeled "Jupyter." If you run this, it will start a Jupyter notebook server using the base environment provided by conda. 

The conda package manager is a popular way to manage Python programming environments. It is the default environment manager used by the Data Science Virtual Machine and the Data Science Virtual Machine comes with several environments preconfigured to work with popular data science and ML packages. As an example, let's run through initializing, activating, and using PyTorch running with Python 3.6.

To activate the desired conda environment:

1. Click the terminal emulator icon on the toolbar of the Data Science Virtual Machine's desktop

    ![Ubuntu desktop with terminal highlighted](../media/desktop-ubuntu.png)

1. To initialize conda and activate it, run:

```bash
conda init && source ~/.bashrc
```

1. To list the installed conda environments, run: 

```bash
conda info --envs
```

You should see output similar to: 


```bash
# conda environments:
#
base                  *  /anaconda
azureml_py36_automl      /anaconda/envs/azureml_py36_automl
azureml_py36_pytorch     /anaconda/envs/azureml_py36_pytorch
azureml_py36_tensorflow     /anaconda/envs/azureml_py36_tensorflow
py37_default             /anaconda/envs/py37_default
py37_pytorch             /anaconda/envs/py37_pytorch
py37_tensorflow          /anaconda/envs/py37_tensorflow
```

The asterisk indicates the `base` environment is currently active. 

1. Run `python --version` and you should see that the base environment is running Python 3.7. You can see what packages are installed with `conda list` or, to get a full list of dependencies, `conda env export -n base`

1. Activate the environment we want to use with: 

```bash
conda activate azureml_py36_pytorch
```

Running `python --version` and `conda list` again to confirm that the python environment has changed. 

To start a Jupyter server, run: 

```bash
jupyter notebook
```

After startup, the Firefox browser on your Data Science Virtual Machine should start and open to `localhost:8888/tree`, showing the home directory of your Data Science Virtual Machine user. 

1. Click on the **notebooks** folder and, from there, the **pytorch** and **beginner** folders
1. Open the **nn_tutorial.ipynb** notebook. You may receive a warning that the notebook expects a `py37_pytorch` kernel and that you should select a kernel. Select the `Python 3` kernel and press **Select kernel**.

You should see something similar to:

![tk](tk)

1. Choose **cell** **Run all** to execute the notebook

Scroll down to the "Using your GPU" section (near executable cell 45). The sandboxed workspace you are using does not provide GPU support, so `torch.cuda.is_available()` is `False`. 

It is possible to "resize" a virtual machine so that the image runs on more or less powerful hardware. If you had created the a non-GPU Data Science Virtual Machine in your own subscription and that subscription included GPU resources, you could switch to the more powerful hardware without losing any of your data or configuration. 

The following video shows this. It begins with the **nn_tutorial.ipynb** notebook running on "Standard D2s v3" hardware and GPU acceleration with CUDA is not available. In the Azure Portal, click on **Size** and choose a GPU-enabled size, such as a "Standard NC6". Click "Resize" and restart the VM. After logging in, the Jupyter notebook is once again available, but this time, when run, CUDA acceleration _is_ available. 