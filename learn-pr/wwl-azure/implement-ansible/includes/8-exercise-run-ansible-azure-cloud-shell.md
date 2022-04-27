You can run Ansible playbooks on a Windows machine by using the Azure Cloud Shell with Bash.

It's the quickest and easiest way to begin using playbook's provisioning and management features in Azure.

## Run commands

Azure Cloud Shell has Ansible preinstalled. After you're signed into Azure Cloud Shell, specify the bash console.

You don't need to install or configure anything further to run Ansible commands from the Bash console in Azure Cloud Shell.

:::image type="content" source="../media/ansible-cloudshell-ab203da5.png" alt-text="Screenshot of Bash running in Azure Cloud Shell":::


## Editor

You can also use the Azure Cloud Shell editor to review, open, and edit your playbook .yml files.

You can open the editor by selecting the curly brackets icon on the Azure Cloud Shell taskbar.

:::image type="content" source="../media/ansible-cloud-shell-editor-7a2a84ba.png" alt-text="Screenshot of the Azure Editor running in Azure Cloud Shell with the curly brackets called out":::


## Create a resource group

The following steps outline how to create a resource group in Azure using Ansible in Azure Cloud Shell with bash:

1.  Go to the [Azure Cloud Shell](https://shell.azure.com). You can also launch Azure Cloud Shell from within the Azure portal by selecting the Azure PowerShell icon on the taskbar.
2.  Authenticate to Azure by entering your credentials, if prompted.
3.  On the taskbar, ensure **Bash** is selected as the shell.
4.  Create a new file using the following command:
    
    ```yml
    vi rg.yml
    
    ```

5.  Enter insert mode by selecting the **I** key.
6.  Copy and paste the following code into the file, and remove the, \#, comment character. (It's included here for displaying code in the learning platform.) The code should be aligned as in the previous screenshot.
    
    ```yml
      #---
    
        - hosts: localhost
          connection: local
          tasks:
    
            - name: Create a resource group
              azure_rm_resourcegroup:
                name: ansible-rg
                location: eastus
    
    ```

7.  Exit insert mode by selecting the **Esc** key.
8.  Save the file and exit the vi editor by entering the following command:
    
    ```
    :wq
    
    ```

9.  Run the playbook with the following command:
    
    ```yml
    ansible-playbook rg.yml
    
    ```

10. Verify that you receive output like the following code:
    
    ```yml
    PLAY [localhost] *********************************************************************************
    
    TASK [Gathering Facts] ***************************************************************************
    ok: [localhost]
    
    TASK [Create resource group] *********************************************************************
    changed: [localhost]
    
    TASK [debug] *************************************************************************************
    ok: [localhost] => {
        "rg": {
            "changed": true,
            "contains_resources": false,
            "failed": false,
            "state": {
                "id": "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/ansible-rg",
                "location": "eastus",
                "name": "ansible-rg",
                "provisioning_state": "Succeeded",
                "tags": null
            }
        }
    }
    
    PLAY RECAP ***************************************************************************************
    localhost                  : ok=3    changed=1    unreachable=0    failed=0
    
    ```

11. Open Azure portal and verify that the resource group is now available in the portal.
