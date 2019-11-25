Suppose you're a new database administrator for a law firm with branch offices across the country. You're going to use the **Microsoft Assessment and Planning (MAP)** toolkit to create an inventory of all the SQL Server instances in the organization. As a first step You'll install the toolkit on test machine, and configure the toolkit to use a sample MAP database.

In this exercise, you'll install the Microsoft Assessment and Planning Toolkit a test computer, and then restore the sample backup database.

## Install the Microsoft Assessment and Planning Toolkit

Start by using the installer to set up the Microsoft Assessment and Planning Toolkit.

<!-- replaced in the YAML https://labondemand.com/AuthenticatedLaunch/46781?providerId=4. -->
1. Sign into the VM with a Microsoft account, or create a new account.
1. Click **Commands**, and then click **CTRL+ALT+DEL**, and login with the Administrator password: **Pa55w.rd**.
1. Close the Server Manager window.
1. Double-click on the **MAPSetup.exe** shortcut on your desktop.
1. In the **Microsoft Assessment and Planning Toolkit** window, click **Next**.
1. On the **License Agreement** page, click **I accept the terms in the License Agreement**, and then click **Next**.
1. On the **Installation Folder** page, leave the default location as **C:\Program Files\Microsoft Assessment and Planning Toolkit**, and click **Next**.
1. On the **Begin the installation** page, click **Install**.
1. The **Configuring Microsoft Assessment and Planning Toolkit** page displays the progress of the installation.
1. On the **Completed the Setup Wizard for Microsoft Assessment and Planning Toolkit** page, click **Finish**.

## Connect to the sample MAP database

Now that MAP is installed, you can use it to analyze a database. Follow these steps:

1. On the **Start** menu, click **Microsoft Assessment and Planning Toolkit**.
1. The toolkit opens, if the **Microsoft Assessment and Planning Toolkit** dialog box does not automatically open, on the **File** menu, click **Create/Select Database**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, click **Manage**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, click **Import**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, next to **Backup File**, click **Browse**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, navigate to **`C:\MAP_Training_Kit`**, click the **MAP_SampleDB.bak** file, and then click **Open**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, in the **Database Name** box, type **`MapTrainingDatabase`**, and then click **OK**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, note the **Successfully imported the database. Database name: MapTrainingDatabase** message, and then click **OK**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, click **Close**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, click **Use an existing database**, click **MapTrainingDatabase**, and then click **OK**.
1. Close the Microsoft Assessment and Planning Toolkit.

## Summary

You setup the Microsoft Assessment and Planning Toolkit, and connected to the sample training database. You can use the toolkit locally to familiarize yourself with its functionality using the sample database, before running it on your production servers.