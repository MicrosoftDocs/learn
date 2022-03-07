Creating a Django project is similar to creating any Python application. We start by creating a folder, and then we install the package by using `pip`.

## Installation overview

Before you install Django, first make sure the correct Python version is installed for the framework. To check your installed version, go to your command prompt and enter the following command:

```bash
# Windows
python --version 

# macOS or Linux
python3 --version 
```

After the command runs, the Python version that's installed on your computer appears. For this module, we're using the latest official version of Django. Use Python 3 for access to the latest Python features. If you don't have Python installed, go to the [Python website](https://www.python.org?azure-portal=true) to download the correct version.

## Create the project folder

Before you download Django, create a virtual environment to isolate it from other applications. If a virtual environment isn't created and the framework is installed globally, it could cause a conflict with other Python applications and cause them to fail.

Start by creating a folder to contain the new project. It will also hold the folder for the virtual environment.

1. Open a command or terminal window.
1. Create a new directory named **hello_django**, and change directories into it.

    ```bash
    # Windows
    md hello_django
    cd hello_django

    #macOS or Linux
    mkdir hello_django
    cd hello_django
    ```

1. Open the folder in [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) by using the following command:

    ```bash
    code .
    ```

## Create and activate the virtual environment

We'll use the integrated terminal in Visual Studio Code to avoid changing windows while we run the necessary commands to create the resources we need. We'll start by creating a [virtual environment](https://packaging.python.org/tutorials/installing-packages/?azure-portal=true#creating-virtual-environments) and activating it.

1. Inside **Visual Studio Code**, select **Terminal** > **New Terminal**.
1. Inside the **terminal** window at the bottom of **Visual Studio Code**, run the following commands to create and activate your virtual environment.

    ```bash
    # Windows
    python -m venv venv
    .\\venv\\Scripts\\Activate

    # macOS or Linux
    python3 -m venv venv
    source ./venv/bin/activate
    ```

    The name of the virtual environment will be in parentheses followed by the path that you're in currently. This command prompt is where you'll begin to install the Django framework.

## Django installation

The most common way to manage Python packages is by using a [requirements or requirements.txt file](https://pip.pypa.io/en/latest/user_guide/?azure-portal=true#requirements-files). The **requirements.txt** file lists the packages your application uses. Let's create our **requirements.txt** file, add Django, and then install the library.

1. Inside Visual Studio Code, create a new file named **requirements.txt** inside your **hello_django** folder.
1. Add the following text to **requirements.txt**.

    ```text
    Django
    ```

1. Inside the **terminal** window, run the following command to install Django and any other packages listed in **requirements.txt**.

    ```bash
    pip install -r requirements.txt
    ```

With this command, the Django framework will begin to download. After the download is finished, we can start developing our app.
