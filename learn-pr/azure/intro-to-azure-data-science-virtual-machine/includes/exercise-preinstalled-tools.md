Now that you're connected to your Data Science Virtual Machine, you can begin using it to do data science.

The Data Science Virtual Machine comes with tools preinstalled for:

- Python
- R
- Julia
- Node.js
- Java

You can add more programming languages, desktop applications, database tools, and so forth.

## Run RStudio remotely

From the Data Science Virtual Machine desktop running in your XFCE client, double-click the RStudio icon. 

![Screenshot that shows the XFCE client, with RStudio highlighted.](../media/desktop-ubuntu.png)

When RStudio finishes startup, enter `demo(graphics)` in the console window to see a demonstration of RStudio's graphing capabilities. 

![Screenshot that shows the RStudio interface.](../media/rstudio.png)

The free Azure resources used for this learning module don't have permission to access the internet, unlike those you create with your own account. Because the Data Science Virtual Machine can't access the internet in this context, it can't download the data files needed for the included Python Jupyter notebook tutorials.

In our scenario, your local data disk might be mounted as a remote disk on the virtual machine. If so, you can begin your analysis immediately.

## List and activate a Python conda environment

The conda package manager is a popular way to manage Python programming environments. It's the default environment manager that the Data Science Virtual Machine uses. The Data Science Virtual Machine comes with several environments configured to work with popular data science and machine learning packages. As an example, let's run through initializing, activating, and using PyTorch running with Python 3.6.

To activate the desired conda environment:

1. Select the terminal emulator icon on the toolbar of the Data Science Virtual Machine's desktop.

    ![Screenshot of the Ubuntu desktop with the terminal highlighted.](../media/desktop-ubuntu-terminal.png)

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

   The asterisk indicates that the `base` environment is currently active. 

1. Run `python --version`, and you should see that the base environment is running Python 3.7. You can see what packages are installed by running `conda list`. To get a full list of dependencies, run `conda env export -n base`.

1. Activate the environment that we want to use by running: 

    ```bash
    conda activate azureml_py36_pytorch
    ```

1. Run `python --version` and `conda list` again to confirm that the Python environment has changed. 

To start a Jupyter server, run: 

```bash
jupyter notebook
```

After startup, the Firefox browser on your Data Science Virtual Machine should start. It should open to `localhost:8888/tree` and show the home directory of your Data Science Virtual Machine user. Although the **notebooks** directory contains a number of tutorials on the various installed frameworks, almost all require downloading data from external sources. Because your Data Science Virtual Machine is running in a free, restricted Azure environment in this module, you can't access that data at this time.

Feel free to try other software on the machine, although the sandbox restrictions will affect programs that rely on internet access.
