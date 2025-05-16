In this module, we used a starter project to get up and running quickly. This setup allowed us to focus on React and some of the new syntax. You're free to use the starter project for your own work.

You might want to try building a project from scratch. To start from an empty folder, follow the steps in this unit. The steps use Snowpack, just like in the starter project.

This unit is optional. If you don't need to create your own project, continue to the next unit.

## Understand the project structure

Our core setup has two main folders that store code:

- **public**
  - Contains any HTML, CSS, images, or other static files
  - Stores our *index.html* and *index.css* files
- **src**
  - Contains any files that need to be rendered
  - Stores all *.jsx* files

We also create two files to configure our application:

- **package.json**: Contains the list of packages and scripts for our application
- **snowpack.config.js**: Contains configuration options for Snowpack

We need three main packages for our application:

- **Snowpack**: Used to render JSX to HTML and JavaScript
- **React**: Used to create our components
- **React-DOM**: Used to mount our application

## Create the initial structure

In an empty directory, start by installing the necessary components by using npm. Then configure Snowpack and add the scripts to the *package.json* file.

1. Open a terminal or command window. Then, run the following commands to create the directory, and the *package.json* file for npm. On Mac or Linux, use `mkdir`, and on Windows, use `md` to create a directory.

    ```bash
    # Windows
    md react-recipes && cd react-recipes
    md src
    md public
    touch package.json
    echo "{}" > package.json

    # Linux or macOS
    mkdir react-recipes && cd react-recipes
    mkdir src
    mkdir public
    touch package.json
    echo "{}" > package.json
    ```

1. Run the following code in the same terminal or command window.

    ```bash
    npm install --save-dev snowpack
    npm install react react-dom
    ```

    > [!NOTE]
    > Snowpack is a *dev dependency*. It isn't required for production because it generates the necessary JavaScript and HTML files during the build process.

1. Open the directory in Visual Studio Code by running the following command.

    ```bash
    code .
    ```

## Set up Snowpack

One of the advantages of a tool like Snowpack is that it's mostly self-configuring. However, we do need to indicate our code's folder structure. To indicate the folder structure, we set options in the `snowpack.config.js` file.

1. In Visual Studio Code, create a new file by selecting **File** > **New File**.

1. Name the file `snowpack.config.js`.

1. In the new file, add the following code.

    ```javascript
    module.exports = {
        mount: {
            'public': '/',
            'src': '/dist'
        }
    }
    ```

This code tells Snowpack to use our *public* folder as the root of the application. It also sets the *src* directory as the virtual location for the JavaScript files and HTML files it generates.

## Create the npm scripts

To support our development work, we use two scripts with Snowpack. The first script starts the development server. This action automatically refreshes our page when we modify our application. The second script is used when we're ready to build all our files for deployment.

1. In Visual Studio Code, open the *package.json* file.

1. At the bottom of the file, above the last curly bracket (`}`), add the following code. This code creates the **start** and **build** scripts.

    ```json
    {
        "scripts": {
            "start": "snowpack dev",
            "build": "snowpack build"
        }
    }
    ```

    Your *entire* file should now look like the following code.

    ```json
    {
      "devDependencies": {
        "snowpack": "^2.18.5"
      },
      "dependencies": {
        "react": "^17.0.1",
        "react-dom": "^17.0.1"
      },
      "scripts": {
          "start": "snowpack dev",
          "build": "snowpack build"
      }
    }
    ```

1. Save all files by selecting **File** > **Save all**.

Your starter project is now set up! You can add *index.html*, *App.jsx*, and other files just as you did in the previous units.
