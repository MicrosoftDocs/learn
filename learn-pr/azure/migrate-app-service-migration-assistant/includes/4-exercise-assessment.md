Now that you've deployed the Virtual Machines containing your web application to the sandbox environment, you'll use the Azure App Service Migration Assistant to perform an assessment and migration to Azure App Services.

> [!Important]
> This module assumes you've successfully completed the steps in a previous unit and you're using Remote Desktop to view the Virtual Machine running in our sandboxed Azure Virtual Machine environment.  If not, please make sure you complete those steps before continuing on to this unit.

## Exercse steps

1. In the Virtual Machine, open a web browser and navigate to: http://localhost.  Confirm that the web site is running locally.

2. On the Windows desktop, double-click the icon to launch the Azure App Service Migration Assistant.  Once launched, the user interface lists the Migration Assistant's steps with the first step highlighted, "Choose a Site".  In the main area, the Migration Assistant lets you know that it found one site to assess.  

3. Select the radio button next to "my_migration_app".  Then, select the Next button at the bottom of the dialog.  This will begin the assessment of the site.

4. After a moment, the Assessment Report step should complete and you should see that all 13 assessments were successful with no warnings or errors.  You may take a moment to expand the chevron icon next to the label "Success (13)" to see the types of assessments it performed.  We covered some of these previously in an earlier unit.