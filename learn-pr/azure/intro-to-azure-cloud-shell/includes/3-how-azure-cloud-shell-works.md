As an IT admin for Contoso Corporation, you're frequently on-call to perform administrative tasks and resolve workload disruptions to resources in your organization's Azure subscriptions. When visiting a family member during a weekend that you're on call, you're notified by the development team that an Azure VM became non-responsive during scheduled maintenance for the upgrade of an application running on the VM. Because the developers haven't been granted access to the underlying Azure virtual machine hosting infrastructure, and are only able to remotely access the VM when it's operating normally, you're being called to diagnose and remediate the problem.

Since you're visiting family, you don’t have access to your administrative workstation and diagnostic scripts. You do have access to a laptop with an internet browser. Using the laptop, you browse to the Azure portal, authenticate against your organization’s Azure subscription, open Azure Cloud Shell, mount an Azure File Share, access your diagnostic scripts, and diagnose and remediate the problems with the VM, returning it to operation.

## Access Cloud Shell

You have a few different options for accessing Azure Cloud Shell:

- From a direct link: <https://shell.azure.com>

  :::image type="content" source="../media/access-cloud-shell-directly.png" alt-text="A screenshot of Cloud Shell accessed directly from a link." lightbox="../media/access-cloud-shell-directly.png":::

- From the Azure portal

  :::image type="content" source="../media/access-cloud-shell-from-azure-portal.png" alt-text="A screenshot of Cloud Shell accessed from Azure portal." lightbox="../media/access-cloud-shell-from-azure-portal.png":::

- From code snippets when accessing Microsoft Learn:

  :::image type="content" source="../media/access-cloud-shell-from-code-snippets.png" alt-text="A screenshot of Cloud Shell accessed from code snippets." lightbox="../media/access-cloud-shell-from-code-snippets.png":::

When you open a Cloud Shell session, a temporary host is allocated to your session. This VM is pre-configured with the latest versions of PowerShell and Bash. You can then select the command-line experience you want to use:

:::image type="content" source="../media/select-cli-experience.png" alt-text="A screenshot of how to choose a command-line experience in a Cloud Shell session." lightbox="../media/select-cli-experience.png":::

After you select the shell experience you want to use, you can start managing your Azure resources:

:::image type="content" source="../media/manage-azure-resources-in-cloud-shell.png" alt-text="A screenshot of how to use Cloud Shell to manage Azure resources." lightbox="../media/manage-azure-resources-in-cloud-shell.png":::

Cloud Shell sessions terminate after 20 minutes of inactivity. When a session terminates, files on your CloudDrive are persisted, but you’ll have to start a new session to access the Cloud Shell environment.

## Access your own scripts and files

When using Cloud Shell, you might also need to run scripts or use files for different actions. You can persist files on Cloud Shell by using the Azure CloudDrive:

:::image type="content" source="../media/use-azure-cloud-drive.png" alt-text="A screenshot of how to access CloudDrive in a Cloud Shell session." lightbox="../media/use-azure-cloud-drive.png":::

After uploading files, you can interact with them as you would in a regular PowerShell or Bash session:

:::image type="content" source="../media/manage-files-in-cloud-drive.png" alt-text="A screenshot of how to manage files in CloudDrive." lightbox="../media/manage-files-in-cloud-drive.png":::

Now that your file resides on CloudDrive, you can close the session and open another session on a different device and still access the same file. Cloud Shell also lets you map an Azure Storage File Share, which is tied to a specific region. Access to an Azure File Share lets you work with the contents of that share through Cloud Shell.

If you need to edit scripts hosted on the CloudDrive or File Share, you can use the Cloud Shell editor. Select the curly brackets {} icon on the browser and open the file you want to edit, or use the command `code` and specify the filename; for example:

```bash
code temp.txt
```

:::image type="content" source="../media/cloud-shell-edit-scripts.png" alt-text="A screenshot of how to access the Cloud Shell editor mode." lightbox="../media/cloud-shell-edit-scripts.png":::

## Cloud Shell tools

If you need to manage resources (such as Docker containers or Kubernetes Clusters) or want to use third-party tools (such as Ansible and Terraform) in Cloud Shell, the Cloud Shell session comes with these add-ons already pre-configured.

Here’s a list of all add-ons available to you within a Cloud Shell session:

| Category | Name |
|---|---|
| **Linux tools** | bash<br>zsh<br>sh<br>tmux<br>dig |
| **Azure tools** | Azure CLI and [Azure classic CLI](https://github.com/Azure/azure-xplat-cli)<br>AzCopy<br>Azure Functions CLI<br>Service Fabric CLI<br>Batch Shipyard<br>blobxfer |
| **Text editors** | code (Cloud Shell editor)<br>vim<br>nano<br>emacs |
| **Source control** | git |
| **Build tools** | make<br>maven<br>npm<br>pip |
| **Containers** | Docker Machine<br>Kubectl<br>Helm<br>DC/OS CLI |
| **Databases** | MySQL client<br>PostgreSql client<br>sqlcmd Utility<br>mssql-scripter |
| **Other** | iPython Client<br>Cloud Foundry CLI<br>Terraform<br>Ansible<br>Chef InSpec<br>Puppet Bolt<br>HashiCorp Packer<br>Office 365 CLI |