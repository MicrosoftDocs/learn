Now that you're connected to your DSVM, you can begin using it to do data science.

The DSVM comes with tools preinstalled for:

- Python
- R
- Julia
- Node.js
- Java

You can add more programming languages, desktop applications, database tools, and so forth.

## Activate a Python conda environment

The conda package manager is a popular way to manage Python programming environments. It's the default environment manager that the DSVM uses. The DSVM comes with several environments configured to work with popular data science and machine learning packages. As an example, let's run through initializing, activating, and using PyTorch running with Python 3.6.

To activate the desired conda environment:

1. Select the terminal emulator icon on the toolbar of the DSVM's desktop.

    :::image type="content" source="../media/desktop-ubuntu-terminal.png" alt-text="Screenshot of the Ubuntu desktop with the terminal highlighted.":::

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
   azureml_py310_sdkv2      /anaconda/envs/azureml_py310_sdkv2
   azureml_py38             /anaconda/envs/azureml_py38
   azureml_py38_PT_and_TF     /anaconda/envs/azureml_py38_PT_and_TF
   py38_default             /anaconda/envs/py37_default
   ```

   The asterisk indicates that the `base` environment is currently active.

1. Run `python --version`, and you should see that the base environment is running Python 3.7. You can see what packages are installed by running `conda list`. To get a full list of dependencies, run `conda env export -n base`.

1. Activate the environment that we want to use by running:

    ```bash
    conda activate azureml_py38_PT_and_TF
    ```

1. Run `python --version` and `conda list` again to confirm that the Python environment has changed.

To start a Jupyter server, run:

```bash
jupyter notebook
```

After startup, the Firefox browser on your DSVM should start. It should open to `localhost:8888/tree` and show the home directory of your DSVM user. Although the **notebooks** directory contains tutorials on the various installed frameworks, almost all require downloading data from external sources. Because your DSVM is running in a free, restricted Azure environment in this module, you can't access that data at this time.

Feel free to try other software on the machine, although the sandbox restrictions affect programs that rely on internet access.
