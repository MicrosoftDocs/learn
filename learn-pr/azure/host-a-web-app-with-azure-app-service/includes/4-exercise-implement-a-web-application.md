In this unit, you will use developer tools to create the code for a starter web application.

## Create a new web project

::: zone pivot="csharp"

The heart of the .NET CLI tools is the `dotnet` command-line tool. Using this command, you will create a new ASP.NET Core web project.

First, let's install the appropriate version of `dotnet` into the Cloud Shell. For this exercise, we'll be using SDK version 3.1.102. Run the following commands in the Cloud Shell panel on the right to install it.

```bash
wget -q -O - https://dot.net/v1/dotnet-install.sh | bash -s -- --version 3.1.102
export PATH="~/.dotnet:$PATH"
echo "export PATH=~/.dotnet:\$PATH" >> ~/.bashrc
```

Next, run the following commands to create a new ASP.NET Core MVC application named "BestBikeApp".

```bash
dotnet new mvc --name BestBikeApp
```

The command will create a new folder named "BestBikeApp" to hold your project. Run the following commands to change to the project folder, then build and run the application to verify it is complete.

```bash
cd BestBikeApp
dotnet run
```

You should get something like:

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

If we were running the app on our own machine, we'd be able to open a browser to `http://localhost:5000` and see our site. To make this accessible from outside of our own machine, we'll need to deploy the app to somewhere with a public endpoint. The App Service instance we created earlier is perfect for that.

Press <kbd>Ctrl+C</kbd> to shut down the running app.

::: zone-end

::: zone pivot="node"

To create a starter Node.js web application, we'll use Node Package Manager (`npm`) along with some basic JavaScript code to run the actual web page processing.

Run these commands in the Cloud Shell now to create a new `package.json` that will describe our Node.js application.

```bash
cd ~
mkdir helloworld
cd helloworld
npm init -y
```

This will create a new `package.json` file in the current folder - you should see it in the current folder if you type `ls` in the terminal window. We will need a JavaScript file to run our website logic - since this is just a basic example, we will only need one file - `index.js`. Use the following command in the terminal to create the file:

```bash
touch index.js
```

Now we have to make a few edits to both of our files. Type the following command into the terminal to open an interactive editor.

```bash
code .
```

Select the `package.json` file and make the following edits to the `scripts` section to use Node.js to launch the web app. You can also remove the `main` entry.

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

Save the file.

> [!IMPORTANT]
> Whenever you paste or change code into a file in the editor, make sure to save afterwards using the "..." menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Command+S</kbd> on macOS).

Switch to the `index.js` file and add the following contents to it. This is a simple node program to always respond with "Hello World!" when any GET request is made to the server.

```javascript
var http = require('http');

var server = http.createServer(function(request, response) {

    response.writeHead(200, { "Content-Type": "text/html" });
    response.end("<html><body><h1>Hello World!</h1></body></html>");

});

var port = process.env.PORT || 1337;
server.listen(port);

console.log("Server running at http://localhost:%d", port);
```

Save the file and exit the editor. You can exit the editor through the "..." menu on the top right or through <kbd>Ctrl+Q</kbd>.

::: zone-end

::: zone pivot="java"

To create a starter web application, we'll use Maven, a commonly used project management and build tool for Java apps. Maven includes a feature called *archetypes* that can quickly create starter code for different kinds of applications. We can use the `maven-archetype-webapp` template to generate the code for a simple web app that displays "Hello World!" on its homepage.

Run these commands in the Cloud Shell now to create a new web app:

```bash
cd ~
mvn archetype:generate -DgroupId=example.demo -DartifactId=helloworld -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp
```

Now, run these commands to change to the new "helloworld" application directory and package the application for deployment:

```bash
cd helloworld
mvn package
```

When the command finishes running, if you change to the `target` directory and run `ls`, you'll see a file listed called `helloworld.war`. This is the web application package that we will deploy to App Service.

::: zone-end

::: zone pivot="python"

To create a starter web application, we'll use Flask, which is a commonly used web application framework. Run the following commands to set up a virtual environment and install Flask in your profile:

```bash
python3 -m venv venv
source venv/bin/activate
pip install flask
```

Run these commands in the Cloud Shell to create the directory for your new web app:

```bash
mkdir ~/BestBikeApp
cd ~/BestBikeApp
```

Open the web-based Visual Studio Code editor to create and edit the *application.py* for your web app:

```bash
code application.py
```

Copy and paste the following Python code to create the main web app functionality:

```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "<html><body><h1>Hello Best Bike App!</h1></body></html>\n"
```

Save the file and exit the editor. You can save the file and exit the editor through the "..." menu on the top right, or press <kbd>Ctrl+S</kbd> and <kbd>Ctrl+Q</kbd>.

In order to deploy your application to Azure, you will need to save your list of application requirements in a *requirements.txt* file. To do so, run the following command:

```bash
pip freeze > requirements.txt
```

### Optionally test your web app

If you open a second command shell session, for example by browsing to <https://shell.azure.com/>, you can test your application locally on Azure. To do so, use the following steps:

1. From your primary command shell session, run the following commands to start your web application:

    ```bash
    cd ~/BestBikeApp
    export FLASK_APP=application.py
    flask run
    ```

1. From your second command shell session, run the following command to browse to your web application:

    ```bash
    curl http://127.0.0.1:5000/
    ```

    You should see the following displayed:

    ```html
    <html><body><h1>Hello Best Bike App!</h1></body></html>
    ```

1. From your primary command shell session, press <kbd>Ctrl+C</kbd> to quit your web app.

::: zone-end
