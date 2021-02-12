You've set up a dev container for one of your agency's projects. It will now "just work" for anyone who has Docker and the Remote - Containers extension. Almost. They'll still have to install dependences and be aware of the port forwarding. They might also need some Visual Studio Code extensions that they don't know about. 

Fortunately, you can fully customize and automate all the project setup by using the devcontainer.json file.

## A closer look at devcontainer.json

Let's look at the main options in the .devcontainer/devcontainer.json file from the Products Dashboard project. It's a bit long to look at all at once, so let's look at it in sections.

### Build configuration

The `build` section defines how the container will be created. You'll recognize the Dockerfile as being the other file in the .devcontainer folder. The `context` and `args` sections are options that get passed through to the Docker container when `docker build` is run.

```json
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
```

- The `context` section would allow you to specify which directory your project is in. By default, you don't need to touch this section because it already knows that your project is in the parent directory.

- The `args` section specifies some options that you can set to tweak the environment without touching the Dockerfile. For instance, you can change the Python version by changing the `variant` option. You can also have Node.js installed in the container by setting the `INSTALL_NODE` option to `true`. These `args` options are passed to the `docker build` command when the extension builds the container.

### Settings

The `settings` option copies machine-specific settings into the container.

```json
"settings": {
    "terminal.integrated.shell.linux": "/bin/bash",
    "python.pythonPath": "/usr/local/bin/python",
    "python.linting.enabled": true,
    ...
},
```

You might have these settings in your own Visual Studio Code setup. In this Python container, some of these settings are setting the terminal shell. Some are setting Python editing options in Visual Studio Code. These options will give the user an opinionated Python editing experience.

### Project settings

The last section of the file deals directly with project configuration.

```json
// Add the IDs of extensions you want installed when the container is created.
"extensions": [
    "ms-python.python"
]

// Use 'forwardPorts' to make a list of ports inside the container available locally.
// "forwardPorts": [],

// Use 'postCreateCommand' to run commands after the container is created.
// "postCreateCommand": "pip3 install --user -r requirements.txt",

// Comment out connect as root instead. More info: https://aka.ms/vscode-remote/containers/non-root.
"remoteUser": "vscode"
```

- You can use the `extensions` array to specify which Visual Studio Code extensions should be installed in Visual Studio Code when it connects to the container. Your normal Visual Studio Code setup and all the extensions that you already have won't be present when you're using Remote - Containers. Extensions are specified here with their ID. 

  You can find the ID by searching the extension gallery for an extension, right-clicking that extension, and selecting **Copy Extension ID**. When you have the Remote - Containers extension installed, you can also right-click an extension and choose **Add to devcontainer.json**.

- The `fowardPorts` section lets you specify up front which ports you want to forward. Although Visual Studio Code detects many ports automatically when you run a project, there are cases where you'll need to manually forward ports for an app to work.

- The `postCreateCommand` option lets you run any commands that you want after the container is created. If you remember from the first exercise, you had to run the `pip3` command to install dependencies. But how would you know to do that? You might not. You can configure it here so that it will happen automatically and others won't have to worry about it.

- The last option, `remoteUser`, lets you specify a different Linux user to run as. By default, the container runs as root. This option forces the container to run as the *vscode* user, which doesn't have the elevated access that root does. If you want to run the container as root, comment out this line.

In the next exercise, you'll modify the devcontainer.json file to automate several aspects of the project that will set up other developers for immediate success.
