Eclipse provides project templates for building static and dynamic web projects. Static web projects include files that contain HTML and client-side JavaScript code. Dynamic web projects typically include files that contain Java Server Pages (JSP), which run on the server. Azure App Service supports both static and dynamic web projects.

In this unit, you learn the basics of how to use Eclipse to create dynamic web projects. In the next unit, you complete an exercise where you create a dynamic web project, which you can deploy as an Azure web app.

## How to create dynamic web apps

To create a dynamic web app, on the **File** menu in Eclipse, select **New**, and then select **Dynamic Web Project**.

:::image type="content" source="../media/2-new-dynamic-web-project.png" alt-text="Screenshot of the New menu in Eclipse with Dynamic Web Project selected." loc-scope="third-party"::: <!-- Eclipse, no-loc -->

The **Dynamic Web Project** wizard prompts you for the basic details of the project. The only required item is the project name. The wizard provides default values for all the other properties and configuration details. Verify the target runtime in order to determine the functionality that you want to use in your web app. In the following screenshot, the user selects the **Apache Tomcat v8.0** server. Use this server to test and debug locally. You can deploy the web app to Azure after you test it.

:::image type="content" source="../media/2-dynamic-web-app-wizard.png" alt-text="Screenshot of the Dynamic Web Project wizard in Eclipse." loc-scope="third-party"::: <!-- Eclipse, no-loc -->

## How to create static and dynamic web pages

After you create a dynamic web app, add resources to the project using the **Project Explorer** window. Resources include HTML files, JSP files, and CSS style sheets. For example, to add a new JSP page to the project, right-click the project name in the **Project Explorer** window, select **New**, and then select **JSP File**.

:::image type="content" source="../media/2-new-jsp-file.png" alt-text="Screenshot of Eclipse with the user creating a new JSP file for the dynamic web project." loc-scope="third-party"::: <!-- Eclipse, no-loc -->

Eclipse generates the basic boilerplate code for a web page. Use the HTML editor to create the HTML markup that defines the main part of your web page. To help you, the editor includes IntelliSense-style prompts and code completion.

:::image type="content" source="../media/2-html-editor.png" alt-text="Screenshot of the HTML editor in Eclipse, showing IntelliSense-style prompts." loc-scope="third-party"::: <!-- Eclipse, no-loc -->

A dynamic web page contains a mixture of HTML markup and Java code. You add Java code to a web page using JSP tags. 

- To import Java libraries, use the `<%@ page ... %>` directive. In the following example, the *java.util* library is imported by adding the directive to the start of the page:

    ```java
    <%@ page import ="java.util.*" %>
    ```

- To declare static variables, use a pair of `<%!` and `%>` tags. You can initialize the variables at the same time. For example, in the following code excerpt, `counter` is an integer variable. The value `currencies` is a set that contains the details of each currency that is available in the *java.util* library.
  
    ```java
    <%! int counter;
        Set<Currency> currencies = Currency.getAvailableCurrencies(); %>
    ```

  The values of these static variables are only initialized once. They're preserved between invocations of the web app.

- To add procedural code, include your code in a pair of `<%` and `%>` tags. Procedural code can be wrapped around regular HTML markup. For example, in the following code excerpt, the `for` loop iterates through the contents of the `currencies` set and outputs an HTML paragraph during each iteration. The `counter` variable keeps track of the number of iterations made. "NNN" is a temporary placeholder that is replaced in the next code excerpt:

    ```java
    <% counter = 1;
       for(Currency currency : currencies){ %>
        <p>Currency is NNN </p>
    <%  counter++;
      } %>
    ```

- To display the results of a Java function or expression, use a pair of `<%=` and `%>` expression tags. For example, the following code excerpt replaces the "NNN" placeholder in the previous code excerpt with a string representation of the currency:

    ```java
    <% counter = 1;
       for(Currency currency : currencies){ %>
       <p>Currency is <%= currency.toString() %> </p>
    <%   counter++;
      } %>
    <p> There are <%= counter %> currencies available.</p>
    ```

The following JSP page shows a complete example. This code retrieves a list of currencies using the `Currency.getAvailableCurrencies` method from the *java.util* library. The code generates HTML markup that displays the currencies as a set of HTML paragraphs, with a summary at the end that counts the number of currencies displayed:

```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Currency Lister</title>
</head>
<body>
  <%! int counter;
      Set<Currency> currencies = Currency.getAvailableCurrencies(); %>
  
  <% counter = 1;
   for(Currency currency : currencies){ %>
        <p>Currency is <%= currency.toString() %> </p>
  <%    counter++;
    } %>
  <p> There are <%= counter %> currencies available.</p>

</body>
</html>
```

The next section shows the output that this code generates.

## How to test a web app locally

To test a web app, on the **Run** menu, select **Run**, or select the **Run** button in the toolbar. Eclipse prompts you for the server to use to run the web app. The default is the same as the server runtime that you specified when you created the project.

:::image type="content" source="../media/2-select-tomcat-server.png" alt-text="Screenshot of the Run On Server window in Eclipse with the local Tomcat server selected." loc-scope="third-party":::

Select **Finish** to start the web app. If the server is currently stopped, it starts. Then, the web app runs, and the results appear in a browser window in Eclipse. The results should look similar to the following output:

:::image type="content" source="../media/2-dynamic-app-results.png" alt-text="Screenshot of the static web app running in the browser window in Eclipse." loc-scope="third-party":::

In the next unit, you use Eclipse to create a Java web app that uses Java Server Pages to generate dynamic content for a web page.
