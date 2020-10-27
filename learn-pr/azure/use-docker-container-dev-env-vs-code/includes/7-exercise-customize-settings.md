So far you've been able to configure a dev container for a Python project at your agency so that any developer can open it, run it, and work on it - regardless of their machine's configuration. But there are still some rough edges and items that you can further automate. In this exercise, you'll use the `devcontainer.json` file to smooth these edges and make the project work with no setup steps from the developer.

## Reopen project locally

Before you make tweaks to the container configuration, you need to reopen the project locally. This is because you are making changes to the container configuration.

1. Press <kbd>F1</kbd> to open the Command Palette
1. Type "locally" and select "Remote-Containers: Reopen Locally"
1. Open the `devcontainer.json` file in the ".devcontainer" folder if it is not open already

## Install VS Code extensions

The container comes with the Microsoft Python extension, which enables snippets, linting and intellisense in Python files. But the "index.html" file the in "templates" folder is a Jinja template, and a different extension needs to be installed to get syntax highlighting in that file.

1.  Open the Command Palette
1.  Type "extension" and select "Extesions: Install Extensions"
1.  In the extension explorer on the right, search for "jinja"
1.  Right-click the "Jinja" extension from "wholroyd" and select "Add to devcontainer.json"
1.  Notice that the extension ID has been added to the "extensions" option

        // Add the IDs of extensions you want installed when the container is created.
        "extensions": [
            "ms-python.python",
            "wholroyd.jinja"
        ],

## Forward port 5000

While VS Code automatically detects and forwards port 5000, it's a good practice to manually forward ports to ensure that it's included as part of the explicit project configuration.

1. Open the `devcontainer.json` file in the ".devcontainer" folder
1. Uncomment out the "forwardPorts" option, and add 5000 to the array

        // Use 'forwardPorts' to make a list of ports inside the container available locally
        "forwardPorts": [5000],

## Automate dependency installation

Right now, a developer setting up the project for the first time has to know to run "pip3 install --user -r requirements.txt" to install dependencies. Without these dependencies, the project won't run, and other developers might not know why.

1.  Uncomment out the "postCreateCommand" option

        "postCreateCommand": "pip3 install --user -r requirements.txt"

## Rebuild the new container

1. Open the Command Palette
1. Type "rebuild" and select "Remote-Containers: Rebuild and Reopen in Container"

This will cause the container to be rebuilt with the changes you've specified here in the file. This might take some time as you've issued a full rebuild command.

## Examine the fowarded port

1. Open the Command Palette
1. Type "remote explorer" and select "View: Show Remote Explorer"
1. Notice that port 5000 is already forwarded, even though you haven't started the app yet

## Examine syntax highlighting provided by Jinja extension

1. Open the "template/index.html" file
1. Scroll down to line 33 and notice that their is syntax highlighting on the "for" loop
   :::image type="content" source="../media/for-loop.jpg" alt-text="for loop with syntax highlighting":::

## Run the app

1.  Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the VS Code Terminal
1.  Run the app with the following command...

        python app.py

1.  Notice that you did not have to install any dependencies this time. The application simply runs.

This container is now customized and automated for your agency. Any developer who opens this with Remote-Containers will be able to immediately run it and get to work writing code.

In the next section, you'll learn how to install software in the dev container.
