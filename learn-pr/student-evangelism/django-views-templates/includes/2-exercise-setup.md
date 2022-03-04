In this module, we'll work on a website for dog shelters. This project focuses on collecting information for all existing dog shelters and the dogs they're hoping to place across the country. The fictional hope for this app is that dogs will be able to find suitable homes faster because they'll have individuals looking to adopt them from around the United States and not just their local area.

Django is a good framework for this project because it provides a route for quickly developing a customer-facing app. It also provides an established database and admin function that employees can easily access for quick updating. We've created the initial setup for the project, so we can focus on the concepts for this module.

## Requirements

To complete the exercises, you'll need the following items installed on your computer:

- [Python](https://python.org?azure-portal=true)
- [Git](https://git-scm.com/?azure-portal=true)
- A code editor such as [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)

## Clone the starter repository

1. Open a command window or terminal.
1. Run the following commands to clone the starter repository and change to the project's directory.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-django-views-templates
    cd mslearn-django-views-templates/starter
    ```

    > [!NOTE]
    > The solution for the exercises can be found in the *solution* directory.

## Open the project in Visual Studio Code

We'll use [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) as our code editor.

In the same command or terminal window, enter the following command to open the folder in Visual Studio Code:

```bash
code .
```

## Create the virtual environment

We'll follow the best practice of working with [virtual environments](https://docs.python.org/3/tutorial/venv.html?azure-portal=true) for our project.

1. In Visual Studio Code, open the terminal window by selecting **View** > **terminal**.
1. In the new terminal window, run the following commands to create and activate a virtual environment:

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

In the same terminal window, run the following command to install the required packages:

```bash
pip install -r requirements.txt
```

## Start the server

Django can host the application locally. We'll do this by using the built-in terminal window in Visual Studio Code.

Enter the following command in the same terminal window:

```bash
python manage.py runserver
```
