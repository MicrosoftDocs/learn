The Dockerfile is the best tool for adding new software to your container. You might remember that you had the option to install Node.js while adding your container configuration files at the beginning of this process. You didn't choose that option, but now you want to include Node.js as part of your dev container. 

In this exercise, we'll look at how you can install a technology stack like Node in your container at any point.

## Open the Dockerfile

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **explorer** and select **View: Show Explorer**.
1. Open your .devcontainer folder.
1. Locate and open the Dockerfile.

## Add code to the Dockerfile

1. Add the following code to install Node.js.

   ```yml
   RUN apt-get update \
     && apt-get install -y curl ca-certificates \
     && curl -sL https://deb.nodesource.com/setup_14.x | bash \
     && apt-get install nodejs \
     && node -v \
     && npm -v \
   ```

1. Save your project.

## Rebuild container

1. Open the Command Palette.
1. Type **rebuild** and select **Remote-Containers: Rebuild Container**.

## Check the Node version

1. Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the integrated terminal in Visual Studio Code.
1. Enter the following code to check your version of Node.

   ```bash
   node --version
   ```

1. You should see a version of Node as output in the terminal.

Congratulations! You just customized your dev container even further by installing additional software.

Continue to the next unit for a quick knowledge check about dev containers in Visual Studio Code. After that, we'll summarize what we've covered in this Learn module.
