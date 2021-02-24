Creating a Django project is similar to creating any Python application. We start by creating a folder and then installing the package by using `pip`.

## Installation overview

Before installing Django we first need to make sure the correct Python version is installed for the framework. In order to check your installed version navigate to your command prompt and type the following.

```bash
# Windows
python --version 

# macOS or Linux
python3 --version 
```

By executing this command it will display what Python version is installed on your computer. For this module we are using the latest official version of Django and they recommend using Python 3 in order to have access to the latest Python features. If you do not have Python installed then proceed to the [Python website](https://www.python.org?azure-portal=true) to download the correct version.

## Create the project folder

Before downloading Django it is a good idea to create a virtual environment in order to isolate it from other applications. If a virtual environment is not created and the framework is installed globally it could cause a conflict with other Python applications causing them to fail. 

Start by creating a folder that will contain the new project as this will also hold the folder for the virtual environment. 

1. Open a command or terminal window
1. Create a new directory named **hello_django** and change directories into it

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

We will use the integrated terminal in Visual Studio Code to avoid changing windows as we execute the necessary commands to create the resources we need. We will start by creating a [virtual environment](https://packaging.python.org/tutorials/installing-packages/?azure-portal=true#creating-virtual-environments) and activating it.

1. Inside **Visual Studio Code**, click **Terminal > New Terminal**
1. Inside the **terminal** window at the bottom of **Visual Studio Code**, execute the following commands to create and activate your virtual environment:

    ```bash
    # Windows
    python -m venv venv
    .\\venv\\Scripts\\Activate

    # macOS or Linux
    python3 -m venv venv
    source ./venv/bin/activate
    ```

    The name of the virtual environment will be in parentheses followed by the path that you are in currently. This command prompt is where you will begin installing the Django framework.


## Django installation

The most common way to manage Python packages is through the use of a [requirements or requirements.txt file](https://pip.pypa.io/en/latest/user_guide/?azure-portal=true#requirements-files). **requirements.txt** is a text file which lists the packages your application uses. Let's create our **requirements.txt** file, add Django, and then install the library.

1. Inside Visual Studio Code, create a new file named **requirements.txt** inside your **hello_django** folder
1. Add the following to **requirements.txt**

    ```text
    Django
    ```

1. Inside the **terminal** window, execute the following command to install Django (and any other packages listed in **requirements.txt**)

    ```bash
    pip install -r requirements.txt
    ```

With this command the Django framework will begin to download, and once completed we can start developing our app!
