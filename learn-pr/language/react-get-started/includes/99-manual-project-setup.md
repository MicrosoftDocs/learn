Just as there are numerous bundlers available, there are numerous ways to create a React project. You can use a templating tool to generate starter code and files automatically for you. From a learning perspective, it's often best to start from scratch so you can see the different parts. This knowledge allows you to confidently make changes as needed in the future.

## Initial project structure

Our core setup will have two main folders for storing code:

- **public**
  - Contains any HTML, CSS, images or other static files
  - Will store our **index.html** and **index.css** files
- **src**
  - Contains any files which need to be rendered
  - Will store all **.jsx** files

We'll also create two files to configure our application:

- **package.json**
  - Contains the list of packages and scripts for our application
- **snowpack.config.js**
  - Contains configuration options for Snowpack

We need three key packages for our application:

- **Snowpack**, which will be used to render **JSX** to HTML and JavaScript
- **React**, which will be used to create our components
- **ReactDOM**, which will be used to mount our application

## Creating the initial structure

We will start with an empty directory, and install the necessary components using `npm`. We will then configure Snowpack, and add the scripts to **package.json**.

1. Open a terminal or command window, and execute the following command to create the directory and **package.json** file for `npm`.

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

1. Execute the following code in the same terminal or command window

    ```bash
    npm install --save-dev snowpack
    npm install react react-dom
    ```

    > [!NOTE]
    > You will notice Snowpack is a "dev dependency", meaning it's not required for production. Snowpack generates the necessary JavaScript and HTML files during the build process. As a result, it's not needed for production.

1. Open the directory in Visual Studio Code by executing the following command

    ```bash
    code .
    ```

## Configuring Snowpack

One of the great advantages of using a tool like Snowpack is it's generally self-configuring. However, we do need to indicate the folder structure we will be using for our code. We do this by setting options in a file named **snowpack.config.json**.

1. Create a new file in Visual Studio Code by clicking **New File**
1. Name the file **snowpack.config.json**
1. Add the following to **snowpack.config.json**

    ```javascript
    module.exports = {
        mount: {
            'public': '/',
            'src': '/dist'
        }
    }
    ```

This tells Snowpack to use our **public** folder as the root of the application. It also sets the **src** directory as the virtual location for the JavaScript and HTML files it will generate.

## Create the npm scripts

To support our development work we will use two scripts with Snowpack. The first will launch the dev server, which will automatically refresh our page whenever we make a change to our application. The second will be used when we're ready to build all our files for deployment.

1. Open **package.json** in Visual Studio Code.
1. Locate the second to last `}` at the bottom of **package.json** (this should be line 12).
