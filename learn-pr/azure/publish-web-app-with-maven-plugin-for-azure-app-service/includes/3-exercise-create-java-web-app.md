In the previous unit you learned that there are two common plugins that developers use to run web apps locally on their machines: _Eclipse Jetty_ and _Apache Tomcat_. The Azure App Service plugin supports both of these web servers, and your company has chosen to use Tomcat for its Java web projects because of its extensive industry adoption and support from the Apache foundation. To help you understand what your company needs to do to migrate existing Java projects to Azure, you've decided to create a test web app using Maven and archetypes.

In this exercise, you'll create a new Java web app using the `maven-archetype-webapp` archetype. After you create the web app, you'll update the `pom.xml` file to add the Tomcat plugin so you can test your app locally. Then you'll update it to provide more information about where the app is running.

## Create a Java web app

1. In the Azure Cloud Shell on the right, use the following Maven command to create a new Java web app.

    ```bash
    mvn archetype:generate \
      -DgroupId=com.microsoft.example \
      -DartifactId=MyWebApp \
      -DarchetypeArtifactId=maven-archetype-webapp \
      -DinteractiveMode=false
    ```

1. Switch to your project directory, and use `code` to edit the `pom.xml` file for your web app.

    ```bash
    cd MyWebApp
    code pom.xml
    ```

1. Locate the `<finalName>MyWebApp</finalName>` element in the `pom.xml` file, and append the following XML underneath that line to add the Tomcat plugin to your project, which will allow you to run a local web server to test your web app.

    ```xml
    <plugins>
      <plugin>
        <groupId>org.apache.tomcat.maven</groupId>
        <artifactId>tomcat7-maven-plugin</artifactId>
        <version>2.2</version>
        <configuration>
          <!-- http port needed in the sandbox is 8000 -->
          <port>8000</port>
        </configuration>
      </plugin>
    </plugins>  
    ```

1. Save your changes by typing <kbd>Ctrl</kbd>+<kbd>S</kbd>.

1. Quit the code editor by typing <kbd>Ctrl</kbd>+<kbd>Q</kbd>.

1. Use Maven to package your new web app.

    ```bash
    mvn package
    ```

    Maven will display a series of messages in the console while it builds your web app. The build should conclude with a status message that is similar to the following example:

    ```output
    [INFO] Packaging webapp
    [INFO] Assembling webapp [MyWebApp] in [/home/~/MyWebApp/target/MyWebApp]
    [INFO] Processing war project
    [INFO] Copying webapp resources [/home/~/MyWebApp/src/main/webapp]
    [INFO] Webapp assembled in [23 msecs]
    [INFO] Building war: /home/~/MyWebApp/target/MyWebApp.war
    [INFO] WEB-INF/web.xml already added, skipping
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 3.052 s
    [INFO] Finished at: 2020-02-12T21:12:00+00:00
    [INFO] Final Memory: 15M/122M
    [INFO] ------------------------------------------------------------------------
    ```

## Test the sample web app

1. For this exercise, you'll need to open a port to make the local web server available to view in a browser. To do so, use the following `curl` command in the Cloud Shell.

    ```bash
    curl -X POST http://localhost:8888/openPort/8000;
    ```

1. The `curl` command returns a JSON object like the following example, which contains a URL that you'll use later in this exercise to view the web server.

    ```json
    {"message":"Port 8000 is open","url":"https://gateway18.westeurope.console.azure.com/n/cc-1829663c/cc-1829663c/proxy/8000/"}
    ```

1. Start the Tomcat web server with Maven.

    ```bash
    mvn tomcat7:run
    ```

1. Open a new browser tab by using the URL from the JSON that was returned by the `curl` command you ran earlier, appending `MyWebApp/` to the end of the URL. For example, using the above illustration, that URL would be https:\//gateway18.westeurope.console.azure.com/n/cc-1829663c/cc-1829663c/proxy/8000/MyWebApp/. You should see **Hello World!** displayed in your browser.

    :::image type="content" source="../media/3-tomcat-server-response.png" alt-text="Example web app running on Tomcat in a web browser." loc-scope="other"::: <!-- no-loc -->

1. Quit the web server by typing <kbd>Ctrl</kbd>+<kbd>C</kbd> in the Cloud Shell.

In the next unit, you'll learn how to deploy your web app to Azure App Service.
