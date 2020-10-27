So far, you've set up a dev container for one of your agency's projects so that it will run on anyone's machine without any setup on their end. Almost. They still have to install dependences, be aware of the port forwarding, and if they want to do some real Python development, they might need some VS Code extensions that they don't know about. Fortunately, you can solve all this by customizing the project settings in a dev container. This is done with the `devcontainer.json` file.

## A closer look at devcontainer.json

Let's look at the main options in the `devcontainer.json` file from the Products Dashboard project. It's a bit long to look at all at once, so let's look at in sections.

### Build Configuration

This section specifies machine specific settings that will be copied into the container and which file to use as the Dockerfile. You'll recognize the `Dockerfile` as being the other file in the ".devcontainer" folder. The context and args are options that get passed through to the Docker container when it gets built.

    "build": {
        "dockerfile": "Dockerfile",
        "context": "..",
        "args": {
            // Update 'VARIANT' to pick a Python version: 3, 3.6, 3.7, 3.8, 3.9
            "VARIANT": "3",
            // Options
            "INSTALL_NODE": "false",
            "NODE_VERSION": "lts/*"
        }
    },

- The "context" would allow you to specify which directory your project is in. By default, you don't need to touch this because it already knows that your project is in the parent directory.

- The "args" section specifies some options that you can set to tweak the environment without touching the Dockerfile. For instance, you can change the Python version by changing the "variant" option. You could also have Node.js installed in the container by setting the "INSTALL_NODE" option to "true". These args are passed to the "docker build" command when the container is built by the extension.

### Settings

The "settings" option copies machine specific settings into the container. This section has been truncated here for brevity.

    "settings": {
    	"terminal.integrated.shell.linux": "/bin/bash",
    	"python.pythonPath": "/usr/local/bin/python",
    	"python.linting.enabled": true,
    	...
    },

These are settings that you might have in your own VS Code setup. In the case of this Python container, some of these settings are setting the terminal shell, and some are setting Python options which will be turned on to give the user an opinionated Python editing experience.

### Project settings

The last section of the file deals directly with project configuration.

    // Add the IDs of extensions you want installed when the container is created.
    "extensions": [
    	"ms-python.python"
    ]

    // Use 'forwardPorts' to make a list of ports inside the container available locally.
    // "forwardPorts": [],

    // Use 'postCreateCommand' to run commands after the container is created.
    // "postCreateCommand": "pip3 install --user -r requirements.txt",

    // Uncomment to connect as a non-root user. See https://aka.ms/vscode-remote/containers/non-root.
    // "remoteUser": "vscode"

- The "extensions" array allows you to specify which VS Code extensions should be installed in VS Code when it connects to the container. Your normal VS Code setup and all the extensions you already have won't be present when you are using Remote-Containers. Extensions are specified here with their ID. The ID can be found by searching the extension gallery for an extension, right-clicking that extension and selecting "Copy Extension ID." When you have the Remote-Containers extension installed, you can also right-click an extension and choose "Add to devcontainer.json."

- The "fowardPorts" section lets you specify up front which ports you would like to forward. While VS Code detects many ports automatically when you run a project, there are cases where you will need to manually forward ports for an app to work.

- The "postCreateCommand" lets you run any commands that you want after the container is created. If you remember from the first exercise, you had to run the "pip3" command to install dependencies. But how would you know to do that? You might not. So you can configure it here so that it will happen automatically and others won't have to worry about it.

- The last option, "remoteUser," lets you specify a different Linux user to run as. By default, the container runs as root. This is fine for more scenarios, but should you have a case where you wanted to run as different user, the built-in "vscode" user is provided, which does not have root access.

In the next exercise, you'll modify the `devcontainer.json` file to automate several aspects of the project that will set other developers up for immediate success.
