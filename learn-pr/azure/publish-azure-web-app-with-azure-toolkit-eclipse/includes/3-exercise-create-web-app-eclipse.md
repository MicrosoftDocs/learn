After you install the Azure Toolkit for Eclipse, you have an environment that you can use to build and deploy Java web apps to Azure.

In this exercise, you use Eclipse to create a Java web app that uses Java Server Pages (JSP) to generate dynamic content for a web page. The page displays the current date and time, together with the IP address of the client computer running the web browser that connects to the web app. Test the web app locally using the Apache Tomcat server.

## Create a new web app

1. Start Eclipse if it isn't already running.

1. On the **File** menu, select **New**, and then select **Dynamic Web Project**.

   :::image type="content" source="../media/3-new-web-project-menu.png" alt-text="Screenshot of the File menu in Eclipse with Dynamic Web Project selected." loc-scope="third-party":::

   If you don't see **Dynamic Web Project**, try **File** > **Other** > **Web** > **Dynamic Web Project**. If the wizard isn't there, make sure that you installed *Eclipse IDE for Enterprise Java and Web Developers*.

1. In the **New Dynamic Web Project** wizard, on the **Dynamic Web Project** page, in **Project name**, enter  *SampleWebApp*. Make sure the **Target runtime** is set to **Apache Tomcat v10.1**, and then select **Finish**.

   :::image type="content" source="../media/3-dynamic-web-project.png" alt-text="Screenshot of the Dynamic Web Project page in the New Dynamic Web Project wizard, in Eclipse." loc-scope="third-party":::

   > [!NOTE]
   > If the **Apache Tomcat v10.1** runtime isn't listed, select **New Runtime**, and download it.

1. In the **Project Explorer** pane, expand **SampleWebApp**, expand **Java Resources**, right-click **src**, select **New**, and then select **JSP File**.

   :::image type="content" source="../media/3-new-jsp-file.png" alt-text="Screenshot of the New menu for a source code item with JSP File selected." loc-scope="third-party":::

1. In the **New JSP File** wizard, on the **JSP** page, verify that the parent folder is set to **SampleWebApp/WebContent**. For **File name**, enter *index.jsp*, and then select **Finish**.

   :::image type="content" source="../media/3-jsp-file.png" alt-text="Screenshot of the New JSP File wizard in Eclipse, showing the JSP page." loc-scope="third-party":::

1. A code editor window appears that displays the *index.jsp* file. In the head section of the page, change the HTML markup for the title to *Sample Web App*.

   ```html
   <head>
       <meta charset="UTF-8">
       <title>Sample Web App</title>
   </head>
   ```

1. In the body section of the page, add this code:

   ```html
   <body>
       <%! DateFormat fmt = new SimpleDateFormat("dd/MM/yy HH:mm:ss"); %>
       <p>Today's date is <%= fmt.format(new Date()) %></p>
       <p>Your IP address is <%= request.getRemoteAddr() %></p>
   </body>
   ```

   This code retrieves the current date then formats and displays it. The code also extracts the IP address of the client from the request message and prints it.

1. Near the top of the page, after the first `@page` directive that specifies the language and content type of the page, add the two `@page` directives shown in the following code:

   ```html
   <%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
   <%@ page import ="java.util.*" %>
   <%@ page import ="java.text.*" %>
   ```

   These directives import the *java.util* and *java.text* libraries. The code in the body of the page uses these libraries.

   The completed code should look like this example:

   ```html
   <%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
   <%@ page import ="java.util.*" %>
   <%@ page import ="java.text.*" %>
   <!DOCTYPE html>
   <html>
   <head>
   <meta charset="UTF-8">
   <title>Sample Web App</title>
   </head>
   <body>
       <%! DateFormat fmt = new SimpleDateFormat("dd/MM/yy HH:mm:ss"); %> 
       <p>Today's date is <%= fmt.format(new Date()) %></p>
       <p>Your IP address is <%= request.getRemoteAddr() %></p>
   </body>
   </html>
   ```

1. On the **File** menu, select **Save**.

## Test the web app locally

1. On the **Run** menu, select **Run**.

   :::image type="content" source="../media/3-run-app.png" alt-text="Screenshot of the Run menu in Eclipse with the Run command selected." loc-scope="third-party":::

1. In the **Run On Server** wizard, select **Tomcat v10.1 Server at localhost**, and then select **Finish**.

   :::image type="content" source="../media/3-run-on-server.png" alt-text="Screenshot of the Run On Server wizard in Eclipse with the Tomcat v10.1 Server at localhost server selected." loc-scope="third-party":::

   > [!NOTE]
   > If you have recently installed Tomcat, there might not be an existing server available. Select **Manually define a new server**, and select **Tomcat v10.1 Server**.

1. When the Tomcat server starts, you see a few messages. Eclipse shows the output of the web application in a browser window inside the IDE, which should look similar to this image.

   :::image type="content" source="../media/3-results.png" alt-text="Screenshot of the output from the sample web application in Eclipse." loc-scope="third-party":::

1. Select the **Go to the selected URL** button, which is the green arrow next to the URL in the **Sample Web App** window, to refresh the page. You should see the time change as the page regenerated and the Java code runs again.

Congratulations! You created a sample web app and deployed it locally using Eclipse. In the next exercise, you deploy the web app to Azure.
