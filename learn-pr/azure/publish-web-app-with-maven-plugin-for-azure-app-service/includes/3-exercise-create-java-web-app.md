In the previous unit, you learned that there are two common plugins that developers use to run web apps locally on their machines: _Eclipse Jetty_ and _Apache Tomcat_. The Azure App Service plugin supports both of these web servers, and your company has chosen to use Tomcat for its Java web projects because of its extensive industry adoption and support from the Apache foundation. To help you understand what your company needs to do to migrate existing Java projects to Azure, you've decided to create a test web app using Maven and archetypes.

In this exercise, you'll create a new Java web app using the `maven-archetype-webapp` archetype. After you create the web app, you'll update the `pom.xml` file to add the Tomcat plugin so you can test your app locally. Then, you'll update it to provide more information about where the app is running.

## Create a Java web app

1. In the Azure Cloud Shell on the right, use the following Maven command to create a new Java web app:

    ```bash
    mvn archetype:generate \
      -DgroupId=com.microsoft.example \
      -DartifactId=MyWebApp \
      -DarchetypeArtifactId=maven-archetype-webapp \
      -DarchetypeVersion=1.4 \
      -DinteractiveMode=false
    ```

1. Switch to your project directory and use `code` to edit the `pom.xml` file for your web app:

    ```bash
    cd MyWebApp
    code pom.xml
    ```

1. Locate the `<plugins>` element in the `pom.xml` file, and add the following `<plugin>` below the existing plugins`, which allows you to run a local web server to test your web app:

    ```xml
    <plugin>
      <groupId>org.codehaus.cargo</groupId>
      <artifactId>cargo-maven3-plugin</artifactId>
      <version>1.10.13</version>
      <configuration>
        <container>
          <containerId>tomcat11x</containerId>
        </container>
        <configuration>
          <properties>
            <!-- http port needed in the sandbox is 8000 -->
            <cargo.servlet.port>8000</cargo.servlet.port>
          </properties>
        </configuration>
      </configuration>
    </plugin>
    ```

1. Save your changes by typing <kbd>Ctrl</kbd>+<kbd>S</kbd>.

1. Quit the code editor by typing <kbd>Ctrl</kbd>+<kbd>Q</kbd>.

1. Use Maven to package your new web app:

    ```bash
    mvn package
    ```

## Test the sample web app

1. For this exercise, you'll need to open a port to make the local web server available to view in a browser. To do so, use the following `curl` command in the Cloud Shell:

    ```bash
    curl -X POST http://localhost:8888/openPort/8000;
    ```

1. The `curl` command returns a JSON object like the following example, which contains a URL that you'll use later in this exercise to view the web server:

    ```json
    {"message":"Port 8000 is open","url":"https://gateway18.westeurope.console.azure.com/n/cc-1829663c/cc-1829663c/proxy/8000/"}
    ```

1. Start the Tomcat web server with Maven:

    ```bash
    mvn cargo:run
    ```

1. Open a new browser tab by using the URL from the JSON that was returned by the `curl` command you ran earlier, appending `MyWebApp/` to the end of the URL. For example, using the above illustration, that URL would be https:\//gateway18.westeurope.console.azure.com/n/cc-1829663c/cc-1829663c/proxy/8000/MyWebApp/. You should see **Hello World!** displayed in your browser:

    :::image type="content" source="../media/3-tomcat-server-response.png" alt-text="Screenshot fo the example web app running on Tomcat in a web browser." loc-scope="other"::: <!-- no-loc -->

1. Quit the web server by typing <kbd>Ctrl</kbd>+<kbd>C</kbd> in the Cloud Shell.

In the next unit, you'll learn how to deploy your web app to Azure App Service.
