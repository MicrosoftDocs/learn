To create an Azure DSVM, you need an Azure subscription. You can create an Azure free account that includes $200 credit to spend for the first 30 days, free access to Azure's most popular products for 12 months and access to more than 25 products that are always free. (See [Get Azure free trial](https://azure.microsoft.com/free/)).

After signing into your account, go to [the DSVM product page](https://azure.microsoft.com/services/virtual-machines/data-science-virtual-machines/). Scroll down until you see the DSVM editions as shown below.
![Screenshot of DSVM Editions Panel](../media/2-DSVM-editions.png)

Click on the Data Science Virtual Machine – Windows 2016 link. You should then see the screen below.

![Screenshot of DSVM Windows 2016](../media/2-DSVM-windows2016.png)

When you see the screen below, click on the Continue button.

![Screenshot of DSVM Creation App](../media/2-DSVM-creation.png)

You will be logged into the Azure portal and shown the screen to provision a Data Science Virtual Machine – Windows 2016 as shown below. If you are prompted for your credentials, just enter then and continue.

![Screenshot of Create DSVM Azure Portal](../media/2-create-DSVM-azure-portal.png)

Click the blue button labeled "Create" to start to configure a VM. You need to fill out the following fields:

- **Subscription**. If you have more than one subscription, select the one on which the machine is to be created and billed.
- **Resource group**. A resource group is a container that holds related resources for an Azure solution. You can create a new one or use an existing group.
- **Virtual Machine name**. The name of the Data Science server you are creating. Win2016 will be used in the example.
- **Region**. Select the data center that's most appropriate. Far fastest network access, it's the data center that has most of your data or is closest to your physical locations.
- **Image**:  Do not change this. It should say "Data Science Virtual Machine – Windows 2016".
- **Size**. Select one of the server types that meets your functional requirements and cost constraints.
- **VM Disk Type**. Choose SSD (Solid-State Drive) or HDD (Hard Disk Drive).
- **User Name**. The administration account Id to access the VM. You will need this later to access the VM.
- **Password**. The administration account password. You will need this later to access the VM.
- **Already have a Windows license?**  Leave this as the default which is No.
- **Use Managed Disks**. Choose **Managed** if you want Azure to manage the disks for the VM. If not, you need to specify a new or existing storage account.

After filling out the fields, click the Disks button. Select the type of disks you want and click on the "Review and Create" button. Don't worry about the section stating **Subscription credits apply**. You will **not** be charged. You may have to wait a few seconds before Review and Create screen appears. Click on the "Create" button and the data science virtual machine will start being provisioned.

The VM provisioning takes a few minutes. You should see a blue line under the bell, ![Screenshot of Bell Icon](../media/2-bell-icon.png), icon which indicates that Azure is busy building the VM. When the VM is done being created, the VM main properties screen will appear.