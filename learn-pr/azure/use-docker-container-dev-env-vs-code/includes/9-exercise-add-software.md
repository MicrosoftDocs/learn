You may remember you were given the option to install Node.js while adding your container configuration files at the beginning of this process. You didn't check yes, but now you realize you'd like to include Node.js as part of your dev container. 

No need to worry - in this exercise, we'll take a look at how you can install a tech stack like Node in your container at any point!

## Open the Dockerfile

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type "explorer" and select "View: Show Explorer."
1. Open your ".devcontainer" folder.
1. Locate and open the Dockerfile.

## Add code to Dockerfile

1. Add the following to install Node.js.

        RUN apt-get update \
            && apt-get install curl \
            && curl -sL https://deb.nodesource.com/setup_14.x | bash \
            && apt-get install nodejs \
            && node -v \
            && npm -v \

1. Save your project.

## Rebuild container

1. Open the Command Palette.
1. Type "rebuild" and select "Remote-Containers: Rebuild Container."

## Check Node version

1. Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the integrated terminal in VS Code.
1. Type the following to check your version of Node.

        node --version

1. You should see a version of Node output to the terminal!

Congratulations, you just customized your dev container even further by installing additional software!

Continue to the next section for a quick knowledge check about dev containers in VS Code, followed by a summary of what we've covered in this Learn module.