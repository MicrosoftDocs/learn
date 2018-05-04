To use your Web App staging slot, update the build definition in VSTS project:

1. In your VSTS project browser open, choose **Build & Release**, then select **Builds**.
2. Choose your build definition, such as *myWebApp-Azure Web App-CI*, then select **Edit**.
3. On the left-hand side of your build definition, select **Azure App Service Deploy: myWebApp**.
4. Check the box *Deploy to slot*, then select your resource group from the drop-down list, such as *myResourceGroup*.
5. From the *Slot* drop-down menu, select your Web App staging slot, such as *staging*:

    ![Update VSTS build definition to use Web App staging slot](../media/update-vsts-build-definition-staging-slot.png)

6. To save the updated build definition, select **Save & queue**, then choose **Save**. Add a comment, such as *Updating to use staging slot*, then select **Save**.