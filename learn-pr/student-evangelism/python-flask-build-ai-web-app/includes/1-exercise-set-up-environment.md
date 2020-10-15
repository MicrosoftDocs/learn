The first order of business is to configure a development environment for a website that's written by using Python and Flask. You can use the environment to build and test Contoso Travel locally before you deploy it to Azure and make it publicly available.

In this unit, you'll learn how to create a virtual Python environment. You'll install Flask and the Python SDK for the Computer Vision API in Azure Cognitive Services. The SDK makes it easy to call the Computer Vision API from Python applications. Finally, you'll install the Azure CLI, which gives you a command-line interface to Azure.

> [!Important]
> In this module, you install and configure a variety of software packages and create a Python virtual environment.
> After the virtual environment is activated in your Command Prompt window or terminal, keep the window or terminal open.
> If you close your window or terminal, be sure to restart your *same* Python virtual environment in the new window or terminal.
> It's important to do all of your work in the same Python virtual environment that you create at the beginning of this module.
>

## Use a Python virtual environment

To run Flask websites on your computer, both Flask and Python must be installed. In this exercise, you create a virtual Python environment that isolates the packages you install from other items on your computer. Then you install Flask and the Python SDK for the Computer Vision API in that environment.

> [!Note]
> To complete this unit, Python 3.6 or later must already be installed on your computer. You can check to see if it's installed.
> - For Windows, enter the command `python --version` in the Command Prompt window.
> - If you're running Linux or macOS, run the command `python3 --version` in the terminal.
> If Python is installed, the output shows the Python version number. 
>
> If you need to install Python, you can follow the steps in the [Install Python 3](https://docs.microsoft.com/learn/modules/python-install-vscode/3-exercise-install-python3?azure-portal=true) module. At the top of the article, choose the instructions for your configuration: Windows, Linux, or Mac.
>
> Verify that your Python install location is added to your PATH system environment variable. A common install location is `C:\Users\<username>\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.6_qbz5n2kfra8p0\LocalCache\local-packages\Python36\Scripts`.
>

<!--- REMOVE pip install instructions. REMOVE PATH env var section.

### Install pip

Start by installing the latest version of **pip**, the Python package manager.

> [!Important]
> It's important to make sure you're using the latest version of pip.
> Older versions of pip can miss dependencies that are required to run Python in Azure.
> The following commands help to ensure you're using the most recent version.

**Windows**

If you're running Windows, enter the following command in the Command Prompt window:

```console
python -m pip install --upgrade pip
```

**macOS or Linux**

If you're running macOS or Linux, enter this command in the terminal:

```console
python3 -m pip install --user --upgrade pip
```

### Update the PATH environment variable

After you install Python, check your **PATH** environment variable. The PATH needs to include the location where you installed Python on your machine.

Common install locations for Python:
- \Users\<username>\AppData\Local\Microsoft\WindowsApps\PythonSoftwareFoundation.Python.3.6_qbz5n2kfra8p0
- /Library/Frameworks/Python.Framework/Versions/3.6/
- /usr/local/python-3.6.3/

Common install locations for pip:
- C:\Users\<username>\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.6_qbz5n2kfra8p0\LocalCache\local-packages\Python36\site-packages
- /Library/Frameworks/Python.Framework/Versions/3.6/bin/python3.6/site-packages/pip (python 3.6)
- /usr/local/python-3.6.3/bin/python

Update your PATH variable as needed. You can update the PATH at the system level, or locally in your Command Prompt window or terminal.

-->


### Create the project directory

Next, create a directory on your hard disk in the location of your choice. The directory will be the *project directory* that holds all the files for the Contoso Travel website. This directory is also where your virtual Python environment will be created.


### Create a Python virtual environment

Choose a name for your virtual environment, such as **ContosoTravelEnv**. After the virtual environment is created, you'll see a subfolder with the virtual environment name in your project directory.

1. In your Command Prompt window or terminal, change (`cd`) to your project directory.

1. Enter the following command to create a virtual environment. Replace `<your-virtual-environment>` with the name that you chose for your virtual Python environment, such as "ContosoTravelEnv".

   **Windows**
   
   ```console
   python -m venv <your-virtual-environment>
   ```

   **macOS or Linux**
   
   ```console
   python3 -m venv <your-virtual-environment>
   ```


### Activate your virtual environment

After the Python virtual environment is created, it needs to be activated. 

In your Command Prompt window or terminal, enter the following command to activate the environment. Replace `<your-virtual-environment>` with the name of your virtual environment, such as "ContosoTravelEnv".

- **Windows**

   ```console
   <your-virtual-environment>\scripts\activate
   ```

- **macOS or Linux**

   ```console
   source <your-virtual-environment>/bin/activate
   ```

After you run the `activate` command, you'll notice that the prompt changes. The prompt now begins with a prefix enclosed in parenthesis. The prefix is the name of your virtual environment. The special prompt helps to remind you that you're working in a virtual environment.


## Install Flask

The next step is to install Flask in your virtual environment. 

Run the following command in your Command Prompt window or terminal:

```console
pip install Flask
```

The command downloads the required packages: Flask, Werkzeug, Jinja, click, itsdangerous, and MarkupSafe. After the download completes, the packages are installed.

> [!Note]
> If you receive a warning that your pip version is not the most recent, use the following to upgrade your version of pip.
> 
> - **Windows**: In your Command Prompt window, enter the command `python -m pip install --upgrade pip`.
> - **macOS or Linux**: In your terminal, enter the command  `python3 -m pip install --user --upgrade pip`.
>


## Install the Computer Vision API    

Now install the Python SDK for the Azure Cognitive Services Computer Vision API in your virtual environment.

Run the following command in your Command Prompt window or terminal:

```console
pip install azure-cognitiveservices-vision-computervision
```

The command downloads and installs the required packages.


## Install the Azure CLI

The Azure CLI is a command-line environment where you can create and manage Azure resources. Versions are available for Windows, macOS, and Linux. In later units, you'll use the Azure CLI to create various Azure resources, including an Azure App Service instance to host a website. In this exercise, you install the Azure CLI and sign in for the first time.

1. If the Azure CLI isn't installed on your computer, go to [Install the Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest?azure-portal=true) and install it now. You can determine whether it's installed by running an `az -v` command in a Command Prompt window or terminal. If the Azure CLI is installed, the output from the command shows the Azure CLI version number.

1. In the Command Prompt window or terminal, sign in to Azure by using the following command:

    ```console
    az login
    ```

    A browser window opens. In the browser window, sign in with your Microsoft account. Then close the browser window and return to the Azure CLI.

1. In the Command Prompt window or terminal, enter the following command to list the Azure subscriptions associated with your Microsoft account:

    ```console
    az account list
    ```

    The default subscription is marked `isDefault=true`. This is the subscription that's used to create resources with the Azure CLI. If the subscription that's marked as the default is the one you want to use, or if it's the only subscription in the list, you're done. Otherwise, use the following command to designate another subscriptions as the default. Replace `<subscription-ID>` with the `id` of the subscription that you want to use. 

    ```console
    az account set -s subscription-ID
    ```

Leave the Command Prompt window or terminal open. We'll return to it in a later unit.

If you're not familiar with the Azure CLI, you can learn more about it and the numerous commands that it supports in [Get started with the Azure CLI](https://docs.microsoft.com/cli/azure/get-started-with-azure-cli?view=azure-cli-latest?azure-portal=true). Most operations that you perform in Azure can be performed with the Azure CLI or through the Azure portal. Power users tend to prefer the Azure CLI because Azure CLI commands can be used in scripts to automate repetitive tasks.
