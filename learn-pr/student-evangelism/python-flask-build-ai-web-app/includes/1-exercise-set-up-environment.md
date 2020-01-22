The first order of business is to set up a development environment for websites written in Python and Flask. You can use the environment to build and test Contoso Travel locally before you deploy it to Azure and make it publicly available.

In this unit, you will install Python on your computer if it isn't already installed. Then you will create a [virtual Python environment](https://docs.python.org/3/library/venv.html) and install Flask and the [Python SDK for the Computer Vision API](https://pypi.org/project/azure-cognitiveservices-vision-computervision/). The SDK makes it easy to call Azure's Computer Vision API from Python applications. Finally, you will install the [Azure CLI](https://docs.microsoft.com/cli/azure/get-started-with-azure-cli?view=azure-cli-latest), which provides a command-line interface to Azure.

## Create a virtual Python environment

To run Flask websites on your computer, both Flask and Python must be installed. In this exercise, you create a virtual Python environment that isolates the packages you install from others on your computer. Then you install Flask and the Python SDK for the Computer Vision API in that environment.

1. If Python 3.6 or higher isn't installed on your computer, go to https://www.python.org/ and install it now. You can determine whether it's installed on Windows by executing the following command in a Command Prompt window:

	```bash
	python --version
	```

	Similarly, you can check to see whether it's installed on macOS or Linux by executing the following command in a terminal:

	```bash
	python3 --version
	```

	If Python is installed, the version number will appear in the output. If you install Python and are asked during the installation process whether Python should be added to the system's PATH, answer yes.

	![Add Python to the PATH](../media/add-to-path.png)

	_Add Python to the PATH_

1. If you are running Windows, execute the following command to install the latest version of pip, the Python package manager:

	```bash
	python -m pip install --upgrade pip
	```

	If you are running macOS or Linux, use this command:

	```bash
	python3 -m pip install --user --upgrade pip
	```

	This command is important because older versions of pip might miss some of the dependencies needed to run Python in Azure.

1. Create a directory on your hard disk in the location of your choice. The directory will be the *project directory* and will hold all of the files that comprise the Contoso Travel website. It's also where your virtual Python environment will be created.

1. In a Command Prompt window or terminal, `cd` to the project directory. If you are running Windows, use the following commands to create a virtual environment in the "env" subdirectory and activate the environment:

	```bash
	python -m venv env
	env\scripts\activate
	```

	If you are running macOS or Linux, use these commands:

	```bash
	python3 -m venv env
	source env/bin/activate
	```

1. Now execute the following commands to install Flask and the Python SDK for Azure's Computer Vision API in the virtual environment:

	```bash
	pip install Flask
	pip install azure-cognitiveservices-vision-computervision
	```

Leave the Command Prompt window or terminal open so you can easily return to it later. When you run the website, you will want to run it from this directory with the virtual environment active.

## Install the Azure CLI

The [Azure CLI](https://docs.microsoft.com/cli/azure/get-started-with-azure-cli?view=azure-cli-latest) is a command-line environment for creating and managing Azure resources. Versions are available for Windows, macOS, and Linux. In subsequent units, you will use the Azure CLI to create various Azure resources, including an [Azure App Service](https://azure.microsoft.com/services/app-service/) to host a website. In this exercise, you will install the Azure CLI and sign in to it for the first time.

1. If the Azure CLI isn't installed on your computer, go to https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest and install it now. You can determine whether it's installed by executing an `az -v` command in a Command Prompt window or terminal. If the CLI is installed, a version number will appear in the output.

1. In a Command Prompt window or terminal, sign in to Azure with the following command:

	```
	az login
	```

	In the ensuing browser window, sign in using your Microsoft account. Then close the browser and return to the CLI.

1. Type the following command to list the Azure subscriptions associated with your Microsoft account:

	```
	az account list
	``` 

	The default subscription—the one used to create resources created with the CLI—is marked `isDefault=true`. If that's the subscription you want to use, or if it's the only subscription in the list, you're done. Otherwise, use the following command to designate one of the other subscriptions as the default, replacing SUBSCRIPTION_ID with the ID of that subscription: 

	```
	az account set -s SUBSCRIPTION_ID
	```

If you aren't familiar with the Azure CLI, you can learn more about it and the numerous commands it supports in [Get started with the Azure CLI](https://docs.microsoft.com/cli/azure/get-started-with-azure-cli?view=azure-cli-latest). Most operations that you perform in Azure can be performed with the CLI or through the [Azure portal](https://portal.azure.com). Power users tend to prefer the CLI, in part because CLI commands can be used in scripts to automate repetitive tasks.