You can also run **Ansible** playbooks on a Windows machine using Visual Studio Code. It applies to other services that can also be integrated using Visual Studio Code.

## Create network resources in Azure using Visual Studio Code

Complete the following steps to create network resources in Azure using Visual Studio Code:

1.  If not already installed, install Visual Studio Code by downloading it from the [https://code.visualstudio.com/](https://code.visualstudio.com/) page. You can install it on the Windows, Linux, or macOS operating systems.
2.  Go to **File** &gt; **Preferences** &gt; **Extensions**.
3.  Search for and install the extension **Azure Account**.<br><br>:::image type="content" source="../media/visual-studio-code-extension-azure-3ff579dc.png" alt-text="Screenshot of Visual Studio Code with the Extensions Azure Account tab displaying. The Azure Account is highlighted, and extensions are listed.":::
    <br><br>
4.  Search for and install the extension **Ansible**.<br><br>:::image type="content" source="../media/ansible-extension-00e20de4.png" alt-text="Screenshot of the Ansible extension highlighted":::
    <br><br>You can also view details of this extension on the Visual Studio Marketplace Ansible page.<br><br>
5.  In Visual Studio Code, go to **View** &gt; **Command Palette...** Instead, you can select the **settings** (cog) icon in the bottom-left corner of the **Visual Studio Code** window and then choose **Command Palette**.<br><br>:::image type="content" source="../media/command-palette-814ddc54.png" alt-text="Screenshot of View menu with Command Palette highlighted":::
    <br><br>
6.  In the Command Palette, Type **Azure:** select **Azure: Sign in**.<br><br>:::image type="content" source="../media/visual-studio-code-command-palette-d816addb.png" alt-text="Screenshot of Visual Studio Code command palette with the Azure command entered, and Azure Sign in highlighted":::
    <br><br>
7.  When a browser launches and prompts you to sign in, select your Azure account. Verify that a message displays stating that you're now signed in and can close the page.<br><br>:::image type="content" source="../media/visual-studio-code-message-4ba32ff9.png" alt-text="Screenshot of the Visual Studio Code window with the message, You're signed in now and can close this page.":::
    <br><br>
8.  Verify that your Azure account now displays at the bottom of the Visual Studio Code window.
9.  Create a new file and paste in the following playbook text:
    
    ```Yml
    
    - name: Create Azure VM.
      hosts: localhost
      connection: local
      tasks:
    
      - name: Create resource group.
        azure_rm_resourcegroup:
          name: myResourceGroup
          location: eastus
    
      - name: Create virtual network.
        azure_rm_virtualnetwork:
          resource_group: myResourceGroup
          name: myVnet
          address_prefixes: "10.0.0.0/16"
    
      - name: Add subnet.
        azure_rm_subnet:
          resource_group: myResourceGroup
          name: mySubnet
          address_prefix: "10.0.1.0/24"
          virtual_network: myVnet
    
      - name: Create public IP address.
        azure_rm_publicipaddress:
          resource_group: myResourceGroup
          allocation_method: Static
          name: myPublicIP
        register: output_ip_address
    
      - name: Dump public IP for VM, which will be created.
        debug:
          msg: "The public IP is {{ output_ip_address.state.ip_address }}."
    
      - name: Create Network Security Group that allows SSH.
        azure_rm_securitygroup:
          resource_group: myResourceGroup
          name: myNetworkSecurityGroup
          rules:
    
            - name: SSH
              protocol: Tcp
              destination_port_range: 22
              access: Allow
              priority: 1001
              direction: Inbound
    
      - name: Create virtual network interface card.
        azure_rm_networkinterface:
          resource_group: myResourceGroup
          name: myNIC
          virtual_network: myVnet
          subnet: mySubnet
          public_ip_name: myPublicIP
          security_group: myNetworkSecurityGroup
    
      - name: Create VM.
        azure_rm_virtualmachine:
          resource_group: myResourceGroup
          name: myVM
          vm_size: Standard_DS1_v2
          admin_username: azureuser
          ssh_password_enabled: true
          admin_password: Password0134
          network_interfaces: myNIC
          image:
            offer: CentOS
            publisher: OpenLogic
            sku: '7.5'
            version: latest
    
    ```

10. Save the file locally, and name it **createavm.yml**.
11. Right-click on the file name in the tab at the top of Visual Studio Code, and review the available options available to run the Ansible playbook:
    
     -  Run Ansible Playbook in Docker.
     -  Run Ansible Playbook in Local Ansible.
     -  Run Ansible Playbook Cloud Shell.
     -  Run Ansible Playbook Remotely via ssh.<br>
12. Select the third option, **Run Ansible Playbook Cloud Shell**.<br><br>:::image type="content" source="../media/visual-studio-code-ansible-7e5a2fe3.png" alt-text="Screenshot of Visual Studio Code with the options to run the file in Ansible in the file context menu. Run Ansible Playbook Cloud Shell is selected.":::
    <br><br>
13. A notice might appear in the bottom, left side, informing you that the action could incur a small charge as it will use some storage when the playbook is uploaded to Cloud Shell. Select **Confirm &amp; Don't show this message again**.<br><br>:::image type="content" source="../media/message-potential-charge-incurred-03f1409b.png" alt-text="Screenshot of the message informing you of a potential charge incurred and asking if you wish to proceed.":::
    <br><br>
14. Verify that the Azure Cloud Shell pane now displays at the bottom of Visual Studio Code and runs the playbook.<br><br>:::image type="content" source="../media/visual-studio-code-azure-cloud-shell-0df71b15.png" alt-text="Screenshot of Visual Studio Code with Azure Cloud Shell running the created playbook at the bottom.":::
    <br><br>
15. When the playbook finishes running, open Azure and verify the resource group, resources, and VM have all been created. If you have time, sign in with the username and password specified in the playbook to verify.<br>

    :::image type="content" source="../media/deployed-resources-azure-d57ca495.png" alt-text="Screenshot of deployed resources in Azure.":::


> [!NOTE]
> If you want to use a public or private key pair to connect to the Linux VM, instead of a username and password, you could use the following code in the previous Create VM module steps:

```Yml
    admin_username: adminUser
    ssh_password_enabled: false
    ssh_public_keys:

    - path: /home/adminUser/.ssh/authorized_keys
      key_data: < insert your ssh public key here... >

```
