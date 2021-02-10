In this unit, you will use developer tools to create the code for a starter web application.

## Create a new web project

::: zone pivot="csharp"

The heart of the .NET CLI tools is the `dotnet` command-line tool. Using this command, you will create a new ASP.NET Core web project.

First, let's install the appropriate version of `dotnet` into the Cloud Shell. For this exercise, we'll be using SDK version 3.1.102.

1. Run the following commands in the Cloud Shell panel on the right to install it.

    ```bash
    wget -q -O - https://dot.net/v1/dotnet-install.sh | bash -s -- --version 3.1.102
    export PATH="~/.dotnet:$PATH"
    echo "export PATH=~/.dotnet:\$PATH" >> ~/.bashrc
    ```

1. Next, run the following commands to create a new ASP.NET Core MVC application named "BestBikeApp".

    ```bash
    dotnet new mvc --name BestBikeApp
    ```

The command will create a new folder named "BestBikeApp" to hold your project.

### Optionally test your web app

If you open a second command shell session, for example by browsing to <https://shell.azure.com/>, you can test your application locally on Azure. To do so, use the following steps:

1. From your primary command shell session, run the following commands to build and run your web application.

    ```bash
    cd BestBikeApp
    dotnet run
    ```

    You should get something like the following.

    ```console
    info: Microsoft.Hosting.Lifetime[0]
          Now listening on: https://localhost:5001
    info: Microsoft.Hosting.Lifetime[0]
          Now listening on: http://localhost:5000
    info: Microsoft.Hosting.Lifetime[0]
          Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
          Hosting environment: Development
    info: Microsoft.Hosting.Lifetime[0]
          Content root path: /home/user/BestBikeApp
    ```

    The output describes the situation after starting your app: the application is running and listening at port 5000.

1. From your second command shell session, run the following command to browse to your web application.

    ```bash
    curl -kL http://127.0.0.1:5000/
    ```

    You should see some HTML appear.

1. From your primary command shell session, press <kbd>Ctrl+C</kbd> to quit your web app.

::: zone-end

::: zone pivot="java"

To create a starter web application, we'll use Maven, a commonly used project management and build tool for Java apps. We'll use the `maven-archetype-webapp` template to generate the code for our web application.

1. Run the following commands in the Cloud Shell now to create a new web app.

    ```bash
    cd ~
    mvn archetype:generate -DgroupId=example.demo -DartifactId=helloworld -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp
    ```

1. Now, run these commands to change to the new "helloworld" application directory and package the application for deployment:

    ```bash
    cd helloworld
    mvn package
    ```

1. When the command finishes running, enter these commands to open the "target" directory and list its content.

    ```bash
    cd target
    ls
    ```

You'll see a file listed called `helloworld.war`. This is the web application package that we will deploy to App Service.

::: zone-end

::: zone pivot="node"

To create a starter Node.js web application, we'll use Node Package Manager (`npm`) along with some JavaScript code to run the actual web page processing.

1. Run the following commands in the Cloud Shell to create a new `package.json` that will describe our Node.js application.

    ```bash
    cd ~
    mkdir helloworld
    cd helloworld
    npm init -y
    ```

This will create a new `package.json` file in the current folder. You should see it in the current folder if you enter `ls` in the terminal window. We will need a JavaScript file to run our website logic. Because this is just a basic example, we will only need one file `index.js`.

1. Run the following command in the terminal to create the file.

    ```bash
    touch index.js
    ```

1. Now we have to make a few edits to both of our files. Enter the following command into the terminal to open an interactive editor.

    ```bash
    code .
    ```

1. Select the `package.json` file and make the following edits to the `scripts` section to use Node.js to launch the web app.

    ```json
    {
      "name": "helloworld",
      ...
      "scripts": {
        "start": "node index.js"
      },
      ...
    }
    ```

1. Save the file by selecting the **...** menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Command+S</kbd> on macOS).

> [!IMPORTANT]
> Whenever you paste or change code into a file in the editor, make sure to save afterwards by selecting the **...** menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Command+S</kbd> on macOS).

1. Switch to the `index.js` file, and add the following contents to it. This is a small Node.js program that always responds with "Hello World!" when any GET request is made to the server.

    ```javascript
    const http = require('http');
    
    const server = http.createServer(function(request, response) {
        response.writeHead(200, { "Content-Type": "text/html" });
        response.end("<html><body><h1>Hello World!</h1></body></html>");
    });
    
    const port = process.env.PORT || 1337;
    server.listen(port);
    
    console.log(`Server running at http://localhost:${port}`);
    ```

1. Save the file and exit the editor. Exit the editor by selecting the **...** menu on the top right, or by pressing <kbd>Ctrl+Q</kbd>.

### Optionally test your web app

If you open a second command shell session, for example, by browsing to <https://shell.azure.com/>, you can test your application locally on Azure. To do so, perform the following steps.

1. From your primary command shell session, run the following commands to start your web application.

    ```bash
    cd ~/helloworld
    npm start
    ```

1. From your second command shell session, run the following command to browse to your web application.

    ```bash
    curl http://127.0.0.1:1337/
    ```

    You should see the following.

    ```html
    <html><body><h1>Hello World!</h1></body></html>
    ```

1. From your primary command shell session, press <kbd>Ctrl+C</kbd> to quit your web app.

::: zone-end

::: zone pivot="python"

To create a starter web application, we'll use the web application framework Flask.

1. Run the following commands to set up a virtual environment, and install Flask in your profile.

    ```bash
    python3 -m venv venv
    source venv/bin/activate
    pip install flask
    ```

1. Run these commands in the Cloud Shell to create the directory for your new web app.

    ```bash
    mkdir ~/BestBikeApp
    cd ~/BestBikeApp
    ```

1. Open the interactive editor to create and edit the *application.py* for your web app.

    ```bash
    code application.py
    ```

1. Copy and paste the following Python code to create the main web app functionality.

    ```python
    from flask import Flask
    app = Flask(__name__)
    
    @app.route("/")
    def hello():
        return "<html><body><h1>Hello Best Bike App!</h1></body></html>\n"
    ```

1. Save the file and exit the editor. You can save the file and exit the editor by selecting the **...** menu on the top right, or use shortcuts (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Command+S</kbd> on macOS).

1. To deploy your application to Azure, you will need to save your list of application requirements in a *requirements.txt* file. To do so, run the following command.

    ```bash
    pip freeze > requirements.txt
    ```

### Optionally test your web app

If you open a second command shell session, for example by browsing to <https://shell.azure.com/>, you can test your application locally on Azure. To do so, perform the following steps.

1. From your primary command shell session, run the following commands to start your web application.

    ```bash
    cd ~/BestBikeApp
    export FLASK_APP=application.py
    flask run
    ```

1. From your second command shell session, run the following command to browse to your web application.

    ```bash
    curl https://127.0.0.1:5000/
    ```

    You should see the following line appear.

    ```html
    <html><body><h1>Hello Best Bike App!</h1></body></html>
    ```

1. From your primary command shell session, press <kbd>Ctrl+C</kbd> to quit your web app.

::: zone-end
