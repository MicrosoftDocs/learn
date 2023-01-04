Dev Container Features and a Dockerfile are excellent tool for adding new software to your container. You might find during a project that you want to include additional software in your dev container over time, like Node.js.

In this exercise, we'll look at how you can install a technology stack like Node in your container at any point.

## Option 1: Dev container Feature

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **explorer** and select **View: Show Explorer**.
1. Open the ".devcontainer" folder.
1. Locate and open the devcontainer.json.
1. Add the following code to install Node.js via a Feature.

```json
"features": {
		"ghcr.io/devcontainers/features/python:1": {}
	}
```

1. Save your project.
1. Open the Command Palette.
1. Type **rebuild** and select **Dev Containers: Rebuild Container**.

## Option 2: Dockerfile

### Create a Dockerfile

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **explorer** and select **View: Show Explorer**.
1. Open the ".devcontainer" folder.
1. Create a new file in the folder titled "Dockerfile."
1. Open your devcontainer.json and replace the `"image":` property with the below.

```json
{
    "build": {
        // Path is relataive to the devcontainer.json file.
        "dockerfile": "Dockerfile"
    }
}
```

### Add code to the Dockerfile

1. Add the following code to create a Python-based Dockerfile and install Node.js.

   ```yml
   FROM mcr.microsoft.com/devcontainers/python:0-3.11
   
   RUN apt-get update \
   && apt-get install -y curl ca-certificates \
   && curl -sL https://deb.nodesource.com/setup_14.x | bash \
   && apt-get install nodejs \
   && node -v \
   && npm -v
   ```

1. Save your project.

### Rebuild container

1. Open the Command Palette.
1. Type **rebuild** and select **Dev Containers: Rebuild Container**.

## Check the Node version

Regardless of how you added Node (via a Feature or Dockerfile), let's check to make sure it installed correctly.

1. Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the integrated terminal in Visual Studio Code.
1. Enter the following code to check your version of Node.

   ```bash
   node --version
   ```

1. You should see a version of Node as output in the terminal.

Congratulations! You customized your dev container even further by installing additional software.

Continue to the next unit for a quick knowledge check about dev containers in Visual Studio Code. After that, we'll summarize what we've covered in this Learn module.
