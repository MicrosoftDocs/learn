You can install Microsoft Office quickly and efficiently by using an FSLogix application container as a template for the other virtual machines (VMs) in your host pool.

Here's why using an FSLogix app container can help make installation faster:

 -  Offloading your Office apps to an app container reduces the requirements for your C drive size.
 -  Snapshots or backups of your VM takes less resources.
 -  Having an automated pipeline through updating a single image makes updating your VMs easier.
 -  You only need one image to install Office (and other apps) onto all the VMs in your Azure Virtual Desktop deployment.

This unit will show you how to set up an FSLogix application container with Office.

You'll need the following things to set up the rule editor:

 -  a VM running Windows without Office installed
 -  a copy of Office
 -  a copy of FSLogix installed on your deployment
 -  a network share that all VMs in your host pool have read-only access to

## Install Office

Install Office on your VHD or VHDX, enable the Remote Desktop Protocol in your VM, then follow the instructions in [Install Office on a VHD master image](/azure/virtual-desktop/install-office-on-wvd-master-image).

> [!NOTE]
> Azure Virtual Desktop requires Share Computer Activation (SCA).

## Install FSLogix

Install FSLogix and the Rule Editor, follow the instructions in [Download and install FSLogix](/fslogix/install-ht).

## Create and prepare a VHD to store Office

Next, you'll need to create and prepare a VHD image to use the Rule Editor on:

1.  Open a command prompt as an administrator. and run the following command:
    
    ```
    taskkill /F /IM MSEdge.exe /T
    ```
    
    > [!NOTE]
    > Make sure to keep the blank spaces you see in this command.
2.  Run the command shown below:
    
    ```
    sc queryex type=service state=all | find /i "ClickToRunSvc"
    ```
    
    If you find the service, restart the VM before continuing with step 3.
    
    ```
    net stop ClickToRunSvc
    
    ```
3.  Go to **Program Files,** select **FSLogix,** select **Apps** and run the command seen below to create the target VHD:
    
    ```
    frx moveto-vhd -filename path\office.vhdx -src "C:\Program Files\Microsoft Office" -size-mbs 5000
    ```
    
    The VHD you create with this command should contain the **C:\\Program Files\\Microsoft Office** folder.<br>

## Configure the Rule Editor

Now that you've prepared your image, you'll need to configure the Rule Editor and create a file to store your rules in.

1.  Go to **Program Files,** select **FSLogix ,** select **Apps** and run **RuleEditor.exe.**
2.  Select **File,** select **New,** select **Create** to make a new rule set, then save that rule set to a local folder.
3.  Select **Blank Rule Set**, then select **OK**.
4.  Select the **+** button to open the **Add Rule** window. to update the options in the Add Rule dialog.
5.  From the drop-down menu, select **App Container (VHD) Rule**.
6.  Enter **C:\\Program Files\\Microsoft Office** into the **Folder** field.
7.  For the Disk file field, select `<path>\office.vhd`from the Create target VHD section.
8.  Select **OK**.
9.  Go to the working folder at`C:\Users\<username>\Documents\FSLogix Rule Sets`and find **.frx** and **.fxa** files. You need to move these files to the **Rules** folder located at **C:\\Program Files\\FSLogix\\Apps\\Rules** in order for the rules to start working.
10. Select **Apply Rules to System** for the rules to take effect.
