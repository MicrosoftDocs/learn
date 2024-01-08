In this unit, you'll learn how to create the code for your web application and integrate it into a source-control repository.

## Bootstrap a web application

Now that you've created the resources for deploying your web application, you have to prepare the code you want to deploy. There are many ways to bootstrap a new web application, so what we'll learn here might be different to what you're used to. The goal is to quickly provide you a starting point to complete a full cycle up to the deployment.

> [!NOTE]
> All the code and commands shown on this page are only for explanation purposes; **you do not need to execute any of them**. We'll use them in a subsequent exercise.

::: zone pivot="csharp"

The `dotnet` command-line tool that's part of the .NET SDK allows you to directly create the code for a new web application. In particular, you can use the `dotnet new` command to generate a new application from a template:

```bash
dotnet new mvc --name <YourAppName>
```

This command creates a new ASP.NET Core MVC application in a new folder with the name specified.

::: zone-end

::: zone pivot="java"

To quickly create a starter web application, you can use the Maven (`mvn`) command-line tool commonly used in the Java ecosystem. In particular, Maven includes a feature called *archetypes* that can quickly create starter code for different kinds of applications using templates. You can use the `maven-archetype-webapp` template to generate the code for a simple web app that displays "Hello World!" on its homepage.

```bash
mvn archetype:generate -DgroupId=example.webapp -DartifactId=helloworld -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp
```

This command creates a `helloworld` folder that contains the source code for your application.

::: zone-end

::: zone pivot="node"

You can use the Node Package Manager (`npm`) command-line tool that comes bundled with Node.js to create a new application. The `init` command creates a new `package.json` required for your application:

```bash
npm init -y
```

If you open the `package.json` file that was created on the current folder, you can add a `start` entry to the `scripts` section to describe how your web application should run:

```json
...
  "scripts": {
    "start": "node index.js"
  },
...
```

After you've done that, you can write the actual code of your web application in a new `index.js` file:

```javascript
const http = require('http');
const port = process.env.PORT || 3000;

http.createServer(function(request, response) {
  response.writeHead(200, { 'Content-Type': 'text/plain' });
  response.end('Hello World!');
}).listen(port);

console.log(`Server running at http://localhost:${port}`);
```

This example code creates a server that listens on port 3000 of your computer and answers every request with a "Hello World!" message.

::: zone-end

::: zone pivot="python"

To create a new web application starter using a few lines of code, you can use Flask, which is a commonly used web-application framework. You can install Flask using the following command:

```bash
pip install flask
```

After Flask is available in your environment, you can create a minimal web application using this code:

```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!\n"
```

This example code creates a server that answers every request with a "Hello World!" message.

::: zone-end

## Adding your code to source control

After your web application code is ready, the next step is usually to put the code into a source-control repository such as Git. If you have Git installed on your machine, running these commands in your source-code folder will initialize the repository.

```bash
git init
git add .
git commit -m "Initial commit"
```

These commands allow you to initialize a local Git repository and create a first commit with your code. You immediately gain the benefit of keeping a history of your changes with commits. Later on, you'll also be able to synchronize your local repository with a remote repository; for example, hosted on GitHub. This allows you to set up continuous integration and continuous deployment (CI/CD). While we recommend using a source-control repository for production applications, it's not a requirement to be able to deploy an application to Azure App Service.

> [!NOTE]
> Using CI/CD enables more frequent code deployment in a reliable manner by automating builds, tests, and deployments for every code change. It enables delivering new features and bug fixes for your application faster and more effectively.
