After review of your app in staging, you can swap the Web App deployments to make your site live in production. To keep an audit trail in the CI/CD process, you could update your VSTS project to use approval rules. For this tutorial, lets manually swap the staging slot and production:

1. In the Azure portal for your Web App staging slot, select **Swap**
2. For **Source**, choose your staging slot, such as *staging*.
3. Choose *production* as the **Destination**, then select **OK**.
4. It takes a few seconds for the Web App deployment slots to swap. Once finished, refresh your production web site in a browser:

    ![ASP.NET web app running in Azure Web App production](media/running-web-app-production.png)