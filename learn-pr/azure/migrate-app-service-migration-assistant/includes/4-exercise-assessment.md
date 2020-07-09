Now that you've deployed the virtual machine that contains your web application to the sandbox environment, you'll use the Azure App Service Migration Assistant to perform an assessment and migration to Azure App Service.

> [!Important]
> This module assumes you've successfully completed the steps in unit 2 and have activated the sandbox and run the first setup script. If you haven't, go back and complete the unit titled "Exercise - Set up the environment" before continuing.

## Exercise steps

In this exercise, you'll complete the setup steps, sign in to your Azure account, and work in a sandbox environment provisioned for you. You'll remotely connect to the VM that was set up for this exercise, and perform an assessment by using the Azure App Service Migration Assistant already installed on the VM.

1. Copy and paste the following script into Azure Cloud Shell on the right, and then run the script by selecting <kbd>Enter</kbd>.

    ```bash
    ./finish.sh
    ```

    This script will wait for the previous script (from the second unit) to finish, so you might see the following message:

    "Waiting for provisioning to complete ..."

    When that script is finished, you should see the credentials for the VM that was provisioned in the sandbox.

2. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) on a new browser tab. Sign in with the same username and password that you used to sign in to activate the sandbox.

    In the upper-right corner, under your account username, you should see that you're logged in to the directory **Microsoft Learn Sandbox**.

3. Select the **Virtual machines** icon under **Azure services**. You should see a single VM named **webvm** listed.

    ![Screenshot of the Azure portal listing of virtual machines displaying webvm.](../media/4-exercise-assessment-01.png)

4. Select the **webvm** item in the list. This will display the details for the VM.

5. On the details toolbar, select the **Connect** icon, and then select **RDP**.  

    ![Screenshot of the webvm detail screen with Connect and RDP options selected.](../media/4-exercise-assessment-02.png)

    On the **Connect** page, select **Download RDP File**.

    ![Screenshot of the Connect page with a callout highlighting the Download RDP File button.](../media/4-exercise-assessment-03.png)

    The file webvm.rdp is downloaded to your local computer.

6. Open the webvm.rdp file. You'll be prompted for the VM's security credentials in the **Windows Security** dialog box. Select **Use a different account**. Copy and paste the username and password from step 1 into the dialog box, and select **OK**. 

   When the **Remote Desktop Connection** dialog box appears and warns you about the remote computer's security certificate, select **Yes**. The remote desktop will open for the VM.

7. On the remote desktop, open Internet Explorer and go to `http://localhost`. Confirm that the Parts Unlimited website is successfully running. This site is hosted in IIS in the virtual machine and connects to an Azure SQL database. Over the course of this exercise, you'll perform a migration assessment on this site and then migrate it to App Service.

    ![Screenshot of the Parts Unlimited website running on the remote VM at localhost.](../media/4-exercise-assessment-04.png)

8. On the remote VM's desktop, double-click the icon to open the Azure App Service Migration Assistant. The user interface then lists the Migration Assistant's steps with the first step highlighted, **Choose a Site**. In the main area, the Migration Assistant says that it found one site to assess.  

9. Select the **Default Web Site** option.  

    ![Screenshot of the first page of the Migration Assistant with a callout highlighting the option next to Default Web Site.](../media/4-exercise-assessment-05.png)

    Then, select the **Next** button at the bottom of the dialog box. This will begin the assessment of the site.

10. After a moment, the assessment report step should finish. You should see that all 13 assessments were successful with no warnings or errors. 

    You might take a moment to expand the chevron icon next to the label **Success (13)** to see the types of assessments that the Migration Assistant performed. We covered some of these in an earlier unit.

You have successfully completed the exercise setup and the assessment of the website. Next, you'll learn about migration.
