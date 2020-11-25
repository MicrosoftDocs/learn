To get started writing our Flask application with Python we need to setup our development environment, which will require a couple of items installed. Fortunately, the tools we'll use are relatively common, so they will serve you well even beyond this module; you might even have them installed! We'll use these tools to develop and test your application locally.

In this unit, you'll learn how to install Python tooling and create a virtual Python environment. You'll install Flask, which is the framework we'll use for creating the website.

> [!Important]
> In this module, you install and configure a variety of software packages and create a Python virtual environment. After the virtual environment is activated in your Command Prompt window or terminal, keep the window or terminal open. If you close your window or terminal, be sure to restart your *same* Python virtual environment in the new window or terminal. It's important to do all of your work in the same Python virtual environment that you create at the beginning of this module.

At a high level, we will perform the following steps:

- Install Visual Studio Code (if not already installed)
- Install Python (if not already installed)
- Create a directory for your code
- Create a virtual environment
- Install Flask and other libraries

## Install Visual Studio Code

Visual Studio Code is an open source code editor which allows you to create almost any type of application you might like. Backed by a robust extension marketplace you can find add-ons to help make your life as a developer easier.

- [Install Visual Studio Code](https://code.visualstudio.com?WT.mc_id=python-11210-chrhar)

## Install Python

To complete this unit, Python 3.6 or later must already be installed on your computer. There's a chance you might already have this installed, especially if you've already used Python. You can confirm this by executing one of the following commands:

```bash
# Windows:
python --version

#macOS or Linux
python3 --version
```

If Python is installed, the output shows the Python version number. If you need to install Python, you can follow the steps in the [Install Python 3](https://docs.microsoft.com/learn/modules/python-install-vscode/3-exercise-install-python3?azure-portal=true&WT.mc_id=python-11210-chrhar) documentation for Visual Studio Code. At the top of the article, choose the instructions for your configuration: Windows, Linux, or Mac.

> [!IMPORTANT]
> If you are using Windows, make sure you select the **Add to PATH** option on the installer. If you miss this step you will receive an error message Python isn't found even after performing the installation.

## Create the project directory

Create a directory in the location of your choice. This directory will be your **project directory**, and will contain all of the code we will create. You can perform this from a command or terminal window with one of the following commands:

```bash
# Windows
md contoso
cd contoso

## macOS or Linux
mkdir contoso
cd contoso
```

> [!IMPORTANT]
> Keep your command or terminal window open for the entirety of the module.

## Create a Python virtual environment

A Python virtual environment is not necessarily as complex as it sounds. Rather than creating a virtual machine or container, a virtual environment is a folder in which all of the libraries we need to run our application, including the Python runtime itself. By using a virtual environment we make our applications modular, allowing us to keep them separate from one another avoiding versioning issues. As a best practice you should always use virtual environments when working with Python.

To use a virtual environment, we will create and activate it. We create it by using the `venv` module, which you installed earlier. When we activate it we tell our system to use the folder we created for all of its Python needs.

```bash
# Windows
# Create the environment
python -m venv venv
# Activate the environment
.\\venv\\scripts\\activate

# macOS or Linux
# Create the environment
python3 -m venv venv
# Activate the environment
source ./venv/bin/activate
```

## Install Flask and other libraries

With our virtual environment created and activated, we can now install the library we need for our website - Flask. We'll do this by following a common convention, creating a **requirements.txt** file. The **requirements.txt** file isn't special in and of itself; it's a text file where we list the libraries required for our application. But it is the convention typically used by developers, and makes it easier to manage applications where numerous libraries are dependencies. In fact, when we deploy to Azure the process will look for a **requirements.txt** file and automatically install the packages listed there.

During later exercises we will use a couple of other libraries including **requests** (to call Translator service), and **python-dotenv** (to manage our keys). While we don't need them quite yet, we're going to make our lives a little easier by installing them now.

1. In the command or terminal window, execute the following command to open the directory in Visual Studio Code

```bash
code .
```

2. In Visual Studio Code, in the **Explorer** window, click **New File**

![New file button in Visual Studio Code](../media/create-file.png)

3. Name the file **requirements.txt**, and add the following:

```text
flask
python-dotenv
requests
```

4. Save the file by clicking **Ctl-S** or **Cmd-S** on a Mac
5. Return to the command or terminal window and perform the installation using **pip** by executing the following command

```bash
pip install -r requirements.txt
```

The command downloads the necessary libraries and their dependencies.

> [!NOTE]
> You may receive an error message your version of **pip** is not the most recent. You can follow the instructions on the error message to perform the upgrade; it is not required for this module.

Congratulations! You've now setup your environment for development!
