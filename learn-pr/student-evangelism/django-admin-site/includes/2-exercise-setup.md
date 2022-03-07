In this module, we'll work on a website for dog shelters. This project focuses on collecting information on all existing dog shelters and the dogs they hope to place across the United States. The fictional hope for this app is that dogs would find suitable homes faster because they would have individuals looking to adopt them from around the United States and not just their local area.

Django is the perfect framework for this project. It provides a route for quickly developing a customer-facing app. Django also provides an established database and admin function that can easily be accessed by employees for quick updating. We've created the initial setup for this project, which allows us to focus on the concepts for this module.

## Requirements

You'll need the following resources installed on your computer to complete the exercises:

- [Python](https://python.org?azure-portal=true)
- [Git](https://git-scm.com/?azure-portal=true)
- A code editor such as [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)

## Clone the starter repository

1. Open a command window or terminal.
1. Run the following commands to clone the starter repository and change to the project's directory.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-django-admin-site
    cd mslearn-django-admin-site/starter
    ```

    > [!NOTE]
    > The solution for the exercises can be found in the *solution* directory.

## Open the project in Visual Studio Code

We'll use [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) as our code editor.

In the same command or terminal window, enter the following command to open the folder in Visual Studio Code.

```bash
code .
```

## Create the virtual environment

We'll follow the best practice of working with [virtual environments](https://docs.python.org/3/tutorial/venv.html?azure-portal=true) for our project.

1. Inside Visual Studio Code, open the terminal window by selecting **View** > **terminal**.
1. In the new **terminal** window, run the following commands to create and activate a virtual environment.

    ```bash
    # Windows
    py -3 -m venv venv
    .\\venv\\Scripts\\activate

    # macOS or Linux
    python3 -m venv venv
    source ./venv/bin/activate
    ```

## Install Django

The starter project uses a [requirements.txt](https://pip.pypa.io/en/latest/user_guide/?azure-portal=true#requirements-files) file to contain the list of all necessary packages. We can install them by using `pip`.

In the same **terminal** window, run the following command to install the required packages.

```bash
pip install -r requirements.txt
```

## Create the database

For development purposes, Django uses an instance of SQLite. You can use Django to create the database through its database migration tools.

In the same **terminal** window, run the following command to create the database.

```bash
python manage.py migrate
```

## Start the server

Django can host the application locally. We'll do this step by using the built-in terminal window in Visual Studio Code.

Enter the following command in the same **terminal** window.

```bash
python manage.py runserver
```
