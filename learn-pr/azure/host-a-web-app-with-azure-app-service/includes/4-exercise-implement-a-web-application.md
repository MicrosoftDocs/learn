In this unit, you will use developer tools to create the code for a starter web application.

## Create a new web project

::: zone pivot="csharp"

The heart of the .NET CLI tools is the `dotnet` command line tool. Using this command, you will create a new ASP.NET Core web project.

In the Cloud Shell on the right, create a new ASP.NET Core MVC application. Name it "BestBikeApp".

```bash
dotnet new mvc --name BestBikeApp
```

The command will create a new folder named "BestBikeApp" to hold your project. `cd` there, then build and run the application to verify it is complete.

```bash
cd BestBikeApp
dotnet run
```

You should get something like:

```console
Using launch settings from /home/your-user/Documents/BestBikeApp/Properties/launchSettings.json...
...
Hosting environment: Production
Content root path: /home/your-user/BestBikeApp
Now listening on: http://localhost:5000
Application started.
```

The output describes the situation after starting your app: the application is running and listening at port 5000.

If were running the app on our own machine we'd be able to open a browser to http://localhost:5000. To make this accessible from outside of our own machine, we'll need to deploy the app to somewhere with a public endpoint. The App Service instance we created earlier is perfect for that.

::: zone-end

::: zone pivot="node"

To create a starter Node.js web application, we'll use the Node Package Manager (NPM) along with some basic JavaScript code to run the actual web page processing.

Run these commands in the Cloud Shell now to create a new `package.json` which will describe our Node.js application.

```console
cd ~
mkdir helloworld
cd helloworld
npm init
```

NPM will prompt you for a series of answers, use the following responses. Hit ENTER to accept the default response.

| Question | Answer |
|----------|--------|
| package name | helloworld |
| version | _default_ |
| description | A simple Hello World app |
| entry point | _default_ |
| test command | _default_ |
| git repository | _default_ |
| keywords | _default_ |
| author | your name |
| license | whatever you want, MIT, ISC, etc. |

This will create a new `package.json` file in the current folder - you should see it in the current folder if you type `ls` in the terminal window. We will need a JavaScript file to run our website logic - since this is just a basic example, we will only need one file - `index.js`. Use the following command in the terminal to create the file:

```bash
touch index.js
``` 

Now we have to make a few edits to both of our files. Type the following command into the terminal to open an interactive editor.

```console
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
    response.end("<html><h1>Hello World!</h1></html>");

});

var port = process.env.PORT || 1337;
server.listen(port);

console.log("Server running at http://localhost:%d", port);
```

Save the file and exit the editor. You can exit the editor through the "..." menu on the top right or through <kbd>Ctrl+Q</kbd>.

Now we are ready to package up the files to deploy to Azure. We need to create a ZIP archive of everything in the project. Type the following commands into the terminal window to create a ZIP file:

```bash
zip -r helloworld.zip .
```

When the command finishes running, type `ls`, you'll see a file named `helloworld.zip`. This is the web application package that we will deploy to App Service.

::: zone-end

::: zone pivot="java"

To create a starter web application, we'll use Maven, a commonly-used project management and build tool for Java apps. Maven includes a feature called *archetypes* that can quickly create starter code for different kinds of applications. We can use the `maven-archetype-webapp` template to generate the code for a simple web app that displays "Hello World!" on its homepage.

Run these commands in the Cloud Shell now to create a new web app:

```console
cd ~
mvn archetype:generate -DgroupId=example.demo -DartifactId=helloworld -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp
```

Now, run these commands to change to the new "helloworld" application directory and package the application for deployment:

```console
cd helloworld
mvn package
```

When the command finishes running, if you change to the `target` directory and run `ls`, you'll see one file listed called `helloworld.war`. This is the web application package that we will deploy to App Service.

::: zone-end