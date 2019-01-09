In this unit, you'll use an Azure Resource Manager template to decrypt our Windows VM we created earlier. We encrypted the OS drive on our Windows VM. However, the OS drive won't have any confidential information on it, so we could leave it unencrypted. Let's use a template to decrypt the OS drive.

## Decrypt a VM using an Azure Resource Manager template

We're going to use a template Microsoft has published on GitHub that is specifically designed to decrypt a running Windows VM.

1. Sign into the [Azure Portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account you activated the sandbox with.

1. Click **Create a Resource** in the left sidebar.

1. Type **Template** in the search box.

1. Select **Template Deployment** from the resulting list and click **Create**.

    ![Screenshot showing the Template Deployment item selected with the Create button highlighted](../media/6-create-template.png)

1. In the **Select a template** search box, start typing "201-decrypt" and select the "201-decrypt-running-windows-vm-without-aad" template.

    ![Screenshot showing the Select a Template search box with auto-completion](../media/6-custom-deployment.png)

1. Click **Select Template** to launch the template runner.

1. In the settings view, enter the following information:
    - Select _Concierge Subscription_ for the **Subscription**.
    - Select the sandbox resource group <rgn>Sandbox RG</rgn>. This will auto-select the region as well.
    - Enter "fmdata-vm01" for the **VM Name**.
    - Leave the **Volume Type** as _All_.

1. Select the **I agree to the terms and conditions** check box.
1. Click **Purchase** to run the template. Note that there is no cost to this - it's a standard button.

The deployment may take a few minutes to complete.

## Verify the encryption status of the VM

1. In the sidebar of the Azure portal, click **Virtual machines** and select your VM **fmdata-vm01**. Alternatively, you can search for your VM by name from **All Resources**.

1. On the **Virtual machine** blade, under **SETTINGS**, click **Disks**.

1. On the **Disks** blade, notice the OS disk encryption status is now **Disabled**.
