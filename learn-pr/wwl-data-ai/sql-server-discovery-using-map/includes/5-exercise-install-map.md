Suppose you're a new database administrator for a law firm with branch offices across the country/region. You're going to use the **Microsoft Assessment and Planning (MAP)** toolkit to create an inventory of all the SQL Server instances in the organization. First, you'll install the toolkit on a test machine and configure it to use a sample MAP database.

In this exercise, you'll install the MAP toolkit on a test computer, then restore the sample backup database.

> [!NOTE]
> Before beginning this exercise, you must complete the **Prepare for the exercises** steps in the unit **Decide if MAP is right for your task**.

## Download the RDP connection file from Azure

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account with which you activated the sandbox.
1. In the search box, search for and select **Virtual Machines**.
1. In the list, select **ReportingServer**.
1. On the **Overview** page, at the top, select **Connect**.
1. In the drop-down, select **RDP**.
1. Select **Download RDP File**, and, when it's downloaded, open the file.

## Connect to the SQL Server

1. In the **Remote Desktop Connection** dialog box, select **Connect**.
1. In the **Windows Security** dialog box, select **More choices**, and then select **Use a different account**.
1. Sign in with the username **azureadmin**, and the admin password you used when you created the original virtual machine. Select **OK**.
    > [!NOTE]
    > You can use the **echo $PASSWORD** command to show you the password.
1. In the **Remote Desktop Connection** dialog box, select **Yes** to continue.
1. You should be logged on to the VM.

## Download the Microsoft Assessment and Planning (MAP) toolkit

1. On the VM's Start menu, select **Microsoft Edge**.
1. If you're downloading MAP outside of this exercise, you'd go to [https://www.microsoft.com/download/details.aspx?id=7826](https://www.microsoft.com/download/details.aspx?id=7826). However, this exercise has the following limitation:

    > [!IMPORTANT]
    > Due to sandbox restrictions, you need to download a backed up version of the MAP toolkit from this Git repo instead.
    > Go to [https://github.com/MicrosoftDocs/mslearn-sql-server-discovery-using-map/blob/master/MAPSetup.exe](https://github.com/MicrosoftDocs/mslearn-sql-server-discovery-using-map/blob/master/MAPSetup.exe) and select the **Download** button.

1. Outside of this exercise, select **Download** on the **Microsoft Assessment and Planning Toolkit** page.
1. In the pop-up, select **Save**.

## Install the MAP toolkit

Start by using the installer to set up the MAP toolkit.

1. Use File Explorer to go to **C:\Users\azureadmin\Downloads**.
1. Double-click the **MAPSetup.exe** shortcut.
1. In the **Microsoft Assessment and Planning Toolkit** window, select **Next**.
1. On the **License Agreement** page, select **I accept the terms in the License Agreement**, and then select **Next**.
1. On the **Installation Folder** page, leave the default location as **C:\Program Files\Microsoft Assessment and Planning Toolkit**, and select **Next**.
1. On the **Begin the installation** page, select **Install**.
1. The **Configuring Microsoft Assessment and Planning Toolkit** page displays the progress of the installation.
1. On the **Completed the Setup Wizard for Microsoft Assessment and Planning Toolkit** page, select **Finish**.

## Download the sample MAP database

1. Use **Microsoft Edge** to go to [https://github.com/MicrosoftDocs/mslearn-sql-server-discovery-using-map/blob/master/MAP_updatedDB.bak](https://github.com/MicrosoftDocs/mslearn-sql-server-discovery-using-map/blob/master/MAP_updatedDB.bak).
1. Select **Download**.

## Connect to the sample MAP database

Now that MAP is installed, you can use it to analyze a database. Follow these steps:

1. On the **Start** menu, select **Microsoft Assessment and Planning Toolkit**.
1. The toolkit opens. If the **Microsoft Assessment and Planning Toolkit** dialog box doesn't automatically open, on the **File** menu, select **Create/Select Database**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, select **Manage**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, select **Import**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, next to **Backup File**, select **Browse**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, go to **`C:\Users\azureadmin\Downloads`**, select the **MAP_updatedDB.bak** file, and then select **Open**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, in the **Database Name** box, type **`MapTrainingDatabase`**, and then select **OK**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, note the **Successfully imported the database. Database name: MapTrainingDatabase** message, and then select **OK**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, select **Close**.
1. In the **Microsoft Assessment and Planning Toolkit** dialog box, select **Use an existing database**, select **MapTrainingDatabase**, and then select **OK**.
