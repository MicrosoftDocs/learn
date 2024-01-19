Dev Container Features and a Dockerfile are excellent tool for adding new software to your container. You might find during a project that you want to include additional software in your dev container over time, like Node.js.

In this exercise, we'll look at how you can install a technology stack like Node in your container at any point.

## Dev container Feature

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **explorer** and select **View: Show Explorer**.
1. Open the `.devcontainer` folder.
1. Locate and open the `devcontainer.json` file.
1. Add the following code to install Node.js via a Feature.

    ```json
    "features": {
    	"ghcr.io/devcontainers/features/node:1": {
    		"version": "18"
    	}
    }
    ```

1. Save your project.
1. Open the Command Palette.
1. Type **rebuild** and select **Dev Containers: Rebuild Container**.

## Check the Node version

Let's check to make sure Node installed correctly.

1. Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the integrated terminal in Visual Studio Code.
1. Enter the following code to check your version of Node:

   ```bash
   node --version
   ```

1. You should see a version of Node as output in the terminal.

Congratulations! You customized your dev container even further by installing additional software.

Continue to the next unit for a quick knowledge check about dev containers in Visual Studio Code. After that, we'll summarize what we've covered in this Learn module.
