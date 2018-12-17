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