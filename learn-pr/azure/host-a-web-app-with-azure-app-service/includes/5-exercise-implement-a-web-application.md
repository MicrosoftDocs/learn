In this unit, you use developer tools to create the code for a starter web application.

## Create a new web project

::: zone pivot="csharp"

The heart of the .NET CLI tools is the `dotnet` command-line tool. Using this command, you create a new ASP.NET Core web project.

Run the following command to create a new ASP.NET Core Model-View Cotroller (MVC) application named "BestBikeApp":

```bash
dotnet new mvc --name BestBikeApp
```

The command creates a new folder named "BestBikeApp" to hold your project. To test your app locally, you need the .NET SDK installed on your system.

::: zone-end

::: zone pivot="java"

To create a starter web application, we use Maven, a commonly used project-management and build tool for Java apps. We use the `maven-archetype-webapp` template to generate the code for our web application.

1. Run the following commands in Azure Cloud Shell now to create a new web app:

    ```bash
    cd ~
    mvn archetype:generate -DgroupId=example.demo -DartifactId=helloworld -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp -DarchetypeVersion=1.5
    ```

1. Now, run these commands to change to the new "helloworld" application directory and package the application for deployment:

    ```bash
    cd helloworld
    mvn package
    ```

1. When the command finishes running, run these commands to open the *target* directory and list its content:

    ```bash
    cd target
    ls
    ```

You now have a file called `helloworld.war` that's the web application package we're going to deploy to App Service.

::: zone-end

::: zone pivot="node"

To create a starter Node.js web application, we use Node Package Manager (`npm`) along with some JavaScript code to run the actual web page processing.

1. Run the following commands in the terminal to create a new `package.json` file that describes our Node.js application:

    ```bash
    cd ~
    mkdir helloworld
    cd helloworld
    cat >package.json <<EOL
    {
      "name": "helloworld",
      "version": "1.0.0",
      "scripts": {
        "start": "node index.js"
      }
    }
    EOL
    ```

A new `package.json` file is created in the current folder. You should find it in the current folder if you enter `ls` in the terminal window. We need a JavaScript file to run our website logic. For this basic example, we only need one file: `index.js`.

1. Create the file by running the following command in the terminal:

    ```bash
    cat >index.js <<EOL
    const http = require('http');
    
    const server = http.createServer(function(request, response) { 
        response.writeHead(200, { "Content-Type": "text/html" });
        response.end("<html><body><h1>Hello World!</h1></body></html>");
    });
    
    const port = process.env.PORT || 1337;
    server.listen(port);
    
    console.log(\`Server running at http://localhost:\${port}\`);
    EOL
    ```

To test your app locally, you need Node.js and npm installed on your system.

::: zone-end

::: zone pivot="python"

To create a starter web application, we use the Flask web-application framework.

1. Run the following commands in Azure Cloud Shell to set up a virtual environment and install Flask in your profile:

    ```bash
    python3 -m venv venv
    source venv/bin/activate
    pip install flask
    ```

1. Run these commands to create and switch to your new web app directory:

    ```bash
    mkdir ~/BestBikeApp
    cd ~/BestBikeApp
    ```

1. Create a new file called *application.py* with a basic HTML response:

    ```bash
    cat >application.py <<EOL
    from flask import Flask
    app = Flask(__name__)
    
    @app.route("/")
    def hello():
        return "<html><body><h1>Hello Best Bike App!</h1></body></html>\n"
    EOL
    ```

1. To deploy your application to Azure, you need to save the list of application requirements you made for it in a *requirements.txt* file. To do so, run the following command:

    ```bash
    pip freeze > requirements.txt
    ```

To test your app locally, you need Python 3 and Flask installed on your system.

::: zone-end
