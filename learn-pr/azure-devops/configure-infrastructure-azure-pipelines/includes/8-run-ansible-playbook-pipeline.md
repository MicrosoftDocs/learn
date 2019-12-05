TODO: Add intro

TODO: No "Space Game" -> Microsoft Learn - Ansible

## Create your repository on GitHub

1. In a web browser, go to [GitHub](https://github.com?azure-portal=true) and sign in.
1. From the **Repositories** pane, select **New**.
1. Under **Repository name** name, enter *mslearn-ansible*.
1. Select **Create repository**.

## Push your local Git repository to GitHub

1. In VS Code, go to your Bash session.
1. Add and commit your inventory file, *azure_rm.yml*, and your playbook, *users.yml*, to your repository.

    ```bash
    git add azure_rm.yml users.yml
    git commit -m "Initial"
    ```
1. Add a remote named *origin* that points to your GitHub repository. Replace `<you>` with your GitHub username.

    ```bash
    git remote add origin https://github.com/<you>/mslearn-ansible.git
    ```

1. Push your `master` branch to GitHub.

    ```bash
    git push -u origin master
    ```

1. Refresh your repository on GitHub.

    You see *azure_rm.yml* and *users.yml* listed under your `master` branch.

## Create the project in Azure DevOps

1. Go to [Azure DevOps](https://dev.azure.com?azure-portal=true) and sign in.
1. Select your Azure DevOps organization.
1. Select **New project**.
1. Name your project *Microsoft Learn - Ansible* and then select **Create**.

## Turn off the new service connections experience in Azure DevOps

The new service connections experience is a preview feature of Azure Pipelines. Preview features provide early access to features that will soon become part of Azure DevOps. For now, you need to ensure this feature is turned off.

From Azure DevOps:

1. Select your profile from the upper-right corner.
1. Select the ellipsis (...) button, then select **User settings**, and then select **Preview features**.
1. Turn off **New service connections experience**.

    ![Turning off the new service connections experience from Azure DevOps](../media/8-new-service-connection-experience.png)

## Create a service connection

Here, you create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to TODO:

1. In Azure DevOps, go to your **Microsoft Learn - Ansible** project.
1. Select **Project settings** from the bottom corner of the page.
1. Under **Pipelines**, select **Service connections**.
1. Select **New service connection** and then choose **SSH**.

    The **New SSH service connection** dialog appears.
1. From the dialog, fill in these fields:

    | Field               | Value |
    |---------------------|-------|
    | **Connection name** | **SSH - Ansible VM** |
    | **Host name**       | Your control machine's hostname, for example, *test1234.northeurope.cloudapp.azure.com* |
    | **Port number**     | **22** |
    | **User name**       | **azureuser** |
    | **Password or passphrase**        | Leave blank |
    | **Private key**     | The contents of your SSH private key, *ansible_rsa*. |

1. Select **OK**.

## Install the Ansible extension for Azure Pipelines

Install add-in that provides access to the `Ansible@0` task in Azure Pipelines.

Knowledge: This add-in (could use commands or use this task, which handles many of the details for you.)

1. From a new browser tab, go to [marketplace.visualstudio.com](https://marketplace.visualstudio.com?azure-portal=true).
1. On the **Azure DevOps** tab, search for "Ansible."
1. Select the **Ansible** extension.

    ![](../media/8-marketplace-ansible.png)
1. Select **Get it free**.
1. Select your Azure DevOps organization.
1. Select **Install**.

## Create the pipeline in Azure Pipelines

1. In Azure DevOps, go to your project.
1. Select **Pipelines**, either from the project page or from the left pane.
1. Select **Create Pipeline**.
1. On the **Connect** tab, select **GitHub**.

    If prompted, enter your GitHub credentials.
1. On the **Select** tab, select your **mslearn-ansible** repository.

    You might be redirected to GitHub to install the Azure Pipelines app. If so, select **Approve and install**.
1. On the **Configure** tab, select **Starter pipeline**.
1. On the **Review** tab, note the starter code for your pipeline configuration. Move your cursor to the bottom of the file.
1. On the **Review** tab, select **Show assistant**.
1. Select **Ansible** from the list of tasks shown. Then fill in these fields:

    * **Ansible location**: **Remote machine**
    * **Ansible SSH endpoint**: **SSH - Ansible VM**
    * **Playbook**:
      * **Source**: **Agent machine**
      * **Root**: *$(System.DefaultWorkingDirectory)*
      * **File path**: *users.yml*
    * **Inventory**:
      * **Inventory location**: **File**
      * **File source**: **Agent machine**
      * **File path**: *azure_rm.yml*
    * **Advanced**:
      * **Additional parameters**: *--private-key ~/.ssh/ansible_rsa*

1. Select **Add**.
1. As an optional step, remove the automatically generated comments and the tasks you don't need.

    Here's what the most basic configuration looks like:

    ```yml
    trigger:
    - master

    pool:
      vmImage: 'ubuntu-latest'

    steps:
    - task: Ansible@0
      inputs:
        ansibleInterface: 'remoteMachine'
        connectionOverSsh: 'SSH - Ansible VM'
        playbookSourceRemoteMachine: 'agentMachine'
        playbookRootRemoteMachine: '$(System.DefaultWorkingDirectory)'
        playbookPathLinkedArtifactOnRemoteMachine: 'users.yml'
        inventoriesRemoteMachine: 'file'
        inventoryFileSourceRemoteMachine: 'agentMachine'
        inventoryFileLinkedArtifactOnRemoteMachine: 'azure_rm.yml'
        args: '--private-key ~/.ssh/ansible_rsa'
    ```

1. Select **Save and run**. Then select **Save and run** again.

## Watch the pipeline run

On the build screen, select the job and trace the pipeline as it runs.

You see that the **Ansible** task runs and produces the same output as before:

![](../media/8-pipeline-ansible-task.png)

## See repair in action

From CloudShell, remove user

1. Get IP address.

    ```azurecli
    IP_ADDRESS=$(az vm list-ip-addresses \
      --resource-group learn-ansible-rg \
      --name vm1 \
      --query [0].virtualMachine.network.publicIpAddresses[0].ipAddress \
      --output tsv)
    ```

1. See the user.

    ```bash
    ssh -i ~/.ssh/ansible_rsa azureuser@$IP_ADDRESS "/usr/bin/getent passwd testuser1"
    ```

1. Remove the user.

    ```bash
    ssh -i ~/.ssh/ansible_rsa azureuser@$IP_ADDRESS "sudo /usr/sbin/userdel testuser1"
    ```

1. Verify user not present

    ```bash
    ssh -i ~/.ssh/ansible_rsa azureuser@$IP_ADDRESS "/usr/bin/getent passwd testuser1"
    ```

    You don't see any output, which tells you the user is not present.

1. Manually run pipeline. To do so, go to your pipeline in Azure Pipelines and select **Run pipeline**. Make sure **master** is selected branch and then select **Run**.

    You see that the user added once again to the VM:

    ![](../media/8-pipeline-ansible-task-repair.png)

    Ansible does not make configuration changes to the other VM because you removed *testuser1* only from the first VM.