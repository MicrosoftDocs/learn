[1]: https://git-scm.com/downloads "Git website downloads"
[2]: https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/cloning-a-repository "Clone GutHub repository"
[3]: https://www.python.org/  "Install Python"

In this module we will work on a website for dog shelters. This project focuses on collecting information of all existing dog shelters and the dogs they are hoping to adopt across the United States. The fictional hope for this app is dogs would be able to find suitable homes faster because they would have individuals looking to adopt them from around the U.S. and not just their local area.

Django is the perfect framework for this project, as it provided a route for quickly developing a customer facing app while providing an established database and admin function that could easily be accessed by employees for quick updating. We have created the initial setup for this project, allowing us to focus on the concepts for this module.

## Requirements

You will need the following installed on your computer to complete the exercises:

- [Python](https://python.org/?azure-portal=true)
- [Git](https://git-scm.com/?azure-portal=true)
- A code editor such as [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true)

## Clone the starter repository

1. Open a command or terminal window.
1. Execute the following commands to clone the starter repository and change directory to the project:

    ```bash
    git clone [URL HERE]
    cd [FOLDER HERE]
    ```

## Open the project in Visual Studio Code

We will be using [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true) as our code editor.
:

```bash
code .
```

## Create the virtual environment

We will follow the best practice of working with [virtual environments](https://docs.python.org/3/tutorial/venv.html/?azure-portal=true) for our project.

1. Inside Visual Studio Code, open the terminal window by selecting **View** > **terminal**.
1. In the new **terminal** window, execute the following commands to create and activate a virtual environment:

    ```bash
    # Windows
    py -3 -m venv venv
    .\\venv\\Scripts\\activate

    # macOS or Linux
    python3 -m venv venv
    source ./venv/bin/activate
    ```

## Install Django

The starter project uses a [requirements.txt](https://pip.pypa.io/en/latest/user_guide/#requirements-files/?azure-portal=true) file to contain the list of all necessary packages. We can install them by using `pip`.

In the same **terminal** window, execute the following command to install the required packages:

```bash
pip install -r requirements.txt
```

## Start the server

Django has the ability to host the application locally. We will do this by using the built-in terminal window in Visual Studio Code.

Enter the following command in the same **terminal** window

```bash
python manage.py runserver
```
