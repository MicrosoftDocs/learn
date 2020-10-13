With the ability to configure dev containers as you want and access resources within them, let's take a look at how you can further customize settings within your container.

## Post build commands

You may want to install additional software in your dev container. Once VS Code is connected to the container, you can open a VS Code terminal and execute any command against the OS inside the container. This allows you to install new command-line utilities and spin up databases or application services from inside the Linux container.

Let's say you want to install Git. You could run the following commands in the integrated terminal in VS Code:

```bash
# If running as root
apt-get update
apt-get install <package>
```

However, if you rebuild the container, you will have to reinstall anything you've installed manually. To avoid this problem, you can use the `postCreateCommand` property in `devcontainer.json`.

The `postCreateCommand` is run once the container is running, so you can also use the property to run commands like `npm install`.

## Installing extensions 

VS Code runs extensions in one of two places: locally on the UI / client side, or in the container. While extensions that affect the VS Code UI, like themes and snippets, are installed locally, most extensions will reside inside a particular container. This allows you to install only the extensions you need for a given task in a container and seamlessly switch your entire tool-chain just by connecting to a new container.

### Extension view

If you install an extension from the Extensions view, it will automatically be installed in the correct location. You can tell where an extension is installed based on the category grouping. There will be a Local - Installed category and also one for your container.

### Extensions in devcontainer.json

You can set up extensions to be automatically installed in VS Code any time someone connects to your dev container. For instance:

```json
{
    "build": { "dockerFile": "Dockerfile" },
    "forwardPorts": [ 3000 ],
    "extensions": ["dbaeumer.vscode-eslint"]
}
```

## Change the default terminal 

Opening a terminal in a container from VS Code is simple. Once you've opened a folder in a container, any terminal window you open in VS Code (Terminal > New Terminal) will automatically run in the container rather than locally.

You can change the default terminal in `devcontainer.json` too:


```json
{
    "build": { "dockerFile": "Dockerfile" },
    "forwardPorts": [ 3000 ],
    "extensions": ["dbaeumer.vscode-eslint"],
    "settings": {
        "terminal.integrated.shell.linux": "/bin/zsh"
    }
}
```

## Container specific settings

VS Code's local user settings are also reused when you are connected to a dev container. While this keeps your user experience consistent, you may want to vary some of these settings between your local machine and each container. 

Fortunately, once you have connected to a container, you can also set container-specific settings by running the **Preferences: Open Remote Settings** command from the Command Palette (F1) or by selecting the Remote tab in the Settings editor. These will override any local settings you have in place whenever you connect to the container.