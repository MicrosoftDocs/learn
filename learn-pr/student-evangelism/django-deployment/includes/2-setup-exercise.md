In this module, you'll work on a website for dog shelters. This project collects information about all dog shelters and their adoption-ready dogs across the country. The fictional goal of this app is to find suitable homes for the dogs quickly. The app reaches individuals who want to adopt, not just in the shelters' local areas but across the country.

Django is the perfect framework for this project. It allows you to quickly develop a customer-facing app. It also provides an established database and admin function that shelter employees can easily update. 

We've created the initial setup for this project so you can focus on the concepts for this module.

## Requirements

To complete the exercise, you need the following tools installed on your computer:

- [Python](https://python.org/?azure-portal=true)
- [Git](https://git-scm.com/?azure-portal=true)
- A code editor such as [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true)

## Clone the starter repository

1. Open a command window or terminal.
1. Run the following commands to clone the starter repository and change to the project's directory.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-django-deployment
    cd mslearn-django-deployment/starter
    ```

    > [!NOTE]
    > The solution for the exercises can be found in the *solution* directory.

## Open the project in Visual Studio Code

You'll use [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true) as your code editor.

```bash
code .
```

## Create the virtual environment

You'll follow the best practice of working with [virtual environments](https://docs.python.org/3/tutorial/venv.html?azure-portal=true) for this project:

1. In **Visual Studio Code**, open the terminal by selecting **View** > **Terminal**.
1. In the **Terminal** pane, run the following commands to create and activate a virtual environment.

    ```bash
    # Windows
    py -3 -m venv venv
    .\\venv\\Scripts\\activate

    # macOS or Linux
    python3 -m venv venv
    source ./venv/bin/activate
    ```

## Install Django

The starter project uses a [*requirements.txt*](https://pip.pypa.io/en/latest/user_guide/#requirements-files/?azure-portal=true) file to contain the list of all necessary packages. You can install them by using `pip`.

In the **Terminal** pane, run the following command to install the required packages.

```bash
pip install -r requirements.txt
```

## Start the server

Django can host the application locally. Set up the hosting from the terminal pane.

Enter the following command in the **Terminal** pane.

```bash
python manage.py runserver
```
