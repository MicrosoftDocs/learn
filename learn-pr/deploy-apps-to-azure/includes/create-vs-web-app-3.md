You manage your code commits in the **Team Explorer** window. Create a local copy of your new project, then create an ASP.NET web application as follows:

1. Select **Clone** to create a local git repo of your Team Services project:

    ![Clone repo from Team Services project](../media/clone-repo.png)

2. Under **Solutions**, select **New**:

    ![Create web application solution](../media/new-solution.png)

3. Select **Web** templates, and then choose the **ASP.NET Web Application** template.
    1. Enter a name for your application, such as *myWebApp*, and uncheck the box for **Create directory for solution**.
    2. If the option is available, uncheck the box to **Add Application Insights to project**. Application Insights requires you to authorize your web application with Azure Application Insights. To keep it simple in this tutorial, skip this process.
    3. Select **OK**.

4. Choose **MVC** from the template list.
    1. Select **Change Authentication**, choose **No Authentication**, then select **OK**.
    2. Select **OK** to create your solution.

Now, let's deploy our app to Azure from Visual Studio.