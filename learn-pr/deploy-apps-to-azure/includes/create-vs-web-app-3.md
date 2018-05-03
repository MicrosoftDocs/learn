You manage your code commits in the Team Explorer window. Create a local copy of your new project, and then create an ASP.NET web application:

1. Select **Clone** to create a local Git repo of your Team Services project:

    ![Clone repo from the Team Services project](../media/clone-repo.png)

2. Under **Solutions**, select **New**:

    ![Create a web application solution](../media/new-solution.png)

3. Select **Web** templates, and then select the **ASP.NET Web Application** template.
    1. Enter a name for your application, such as *myWebApp*. Clear the **Create directory for solution** check box.
    2. If the option is available, clear the **Add Application Insights to project** check box. Azure Application Insights requires you to authorize your web application with Application Insights. To keep it simple in this tutorial, skip this process.
    3. Select **OK**.

4. Select **MVC** from the template list.
    1. Select **Change Authentication**, select **No Authentication**, and then select **OK**.
    2. Select **OK** to create your solution.

Now, deploy the app to Azure from Visual Studio.