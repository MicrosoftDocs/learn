


[Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) is an open-source platform by Red Hat that automates cloud provisioning, configuration management, and application deployments. Using Ansible, you can deploy VMs, containers, and your entire cloud infrastructure. In addition to provisioning and configuring applications and their environments, Ansible enables you to automate deployment and configuration of resources in your environment such as virtual networks, storage, subnets, and resources groups. Ansible is also combined with other deployment tools such as Terraform. Terraform calls Ansible in the [SAP on Azure Deployment Automation Framework](https://github.com/Azure/sap-hana/blob/beta/documentation/SAP_Automation_on_Azure/table_of_contents.md) where Ansible is used after infrastructure deployment to install the SAP software.

## Ansible components

Ansible models your IT infrastructure by describing how all your systems interrelate, rather than just managing one system at a time. The core components of Ansible are:

- **Control Machine**: the machine from which the configurations are run. It can be any machine with Ansible installed on it.

- **Managed Nodes**: the devices and machines (or just machines) and environments that are being managed. Ansible isn't installed on nodes.

- **Playbooks**. Playbooks are ordered lists of tasks that have been saved so you can run them repeatedly in the same order. Playbooks are Ansible’s language for configuration, deployment, and orchestration. 

    - When you create a playbook, you do so by using YAML, which defines a declarative model of a configuration or process. Elements such as **name**, **hosts**, and **tasks** reside within playbooks.

- **Modules**. Ansible works by connecting to your nodes, and then pushing small programs (or units of code)—called modules—out to the nodes. Modules are the units of code that define the configuration. They're modular and can be reused across playbooks. They represent the desired state of the system (declarative), are executed over SSH by default, and are removed when finished.

    - A playbook is typically made up of many modules. For example, you could have one playbook containing three modules: a module for creating an Azure Resource group, a module for creating a virtual network, and a module for adding a subnet.

    - You can preview Ansible Azure modules on the Ansible Azure preview modules webpage for many examples including specifically for SAP.

- **Inventory**. An inventory is a list of managed nodes. Ansible represents what machines it's managing by using a .INI file that puts all your managed machines in groups of your own choosing. When adding new machines, you don't need to use additional SSL-signing servers, thus avoiding Network Time Protocol (NTP) and Domain Name System (DNS) issues. You can create the inventory manually, or for Azure, Ansible supports dynamic inventories. This means that the host inventory is dynamically generated at runtime. Ansible supports host inventories for other managed hosts as well.

- **Roles**. Roles are predefined file structures that allow automatic loading of certain variables, files, tasks, and handlers, based on the file's structure. It allows for easier sharing of roles. You might, for example, create roles for a web server deployment.

- **Facts**. Facts are data points about the remote system that Ansible is managing. When a playbook is run against a machine, Ansible gathers facts about the state of the environment to determine the state before executing the playbook.

- **Plug-ins**. Plug-ins are code that supplements Ansible's core functionality.

## Ansible deployment workflow

Ansible is designed for multiple tier deployments, meaning you don't have to install software on the managed machines. Ansible also models your IT infrastructure by describing how all your systems interrelate, rather than managing just one system at a time.

The following workflow and component diagram outlines how playbooks can run in different circumstances, one after another. 

:::image type="content" source="../media/ansible-workflow.png" alt-text="Workflow and component diagram outlining how playbooks can run in different circumstances.":::

In the workflow, Ansible playbooks:

1. **Provision resources**. Playbooks can provision resources. In the diagram, playbooks create load-balancer virtual networks, network security groups, and Virtual Machine Scale Sets on Azure.

2. **Configure the application**. Playbooks can deploy applications to run services, such as installing Apache Tomcat on a Linux machine to allow you to run a web application.

3. **Manage future configurations to scale**. Playbooks can alter configurations when they're applied to existing resources and applications—in this instance to scale the VMs.

In all cases, Ansible makes use of core components such as roles, modules, APIs, plugins, and inventory.

> [!NOTE]
>- By default, Ansible manages machines using the `ssh` protocol.
>- You don't need to maintain and run commands from any central server. Instead, there is a control machine such as an Azure Linux VM "jumpbox," with Ansible installed, and from which playbooks are run.

## Installing Ansible

To enable a machine to act as the control machine from which to run playbooks, you need to install both Python and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

### Python

When you install Python, you must install either Python 2 (version 2.7), or Python 3 (versions 3.5 and later). You can use **pip**, the Python package manager, to install Python, or you can use other installation methods.

### Ansible installation characteristics

An Ansible installation has the following characteristics:

- You only need to install Ansible on one machine, which could be a workstation or a laptop. You can manage an entire fleet of remote machines from that central point.

- No database is installed as part of the Ansible setup.

- No daemons are required to start or keep Ansible running.

### Ansible on Linux/WSL

You can use the appropriate package manager software to install Ansible and Python, such as **yum**, **apt**, or **pip**. For example, to install Ansible on Ubuntu, run the following command:

```bash
## Install pre-requisite packages
sudo apt-get update && sudo apt-get install -y libssl-dev libffi-dev python-dev python-pip
## Install Ansible and Azure SDKs via pip
sudo pip install ansible[azure] 
```

> [!NOTE]
> The Windows operating system is not supported as a control machine. However, you can run Ansible from a Windows machine by utilizing other services and products such as Windows Subsystem for Linux, Azure Cloud Shell, and Visual Studio Code.
You can find out more about installing Ansible on the [Install Ansible on Azure virtual machines](/azure/virtual-machines/linux/ansible-install-configure) page.

### Azure Marketplace

You can use one of the following images available as part of the Azure Marketplace:

- Red Hat Ansible on Azure is available as an image on Azure Marketplace, and it provides a fully configured version. This enables easier adoption for anyone looking to use Ansible as their provisioning and configuration management tool. This solution template installs Ansible on a Linux VM along with tools configured to work with Azure

- Ansible Tower (by Red Hat). Ansible Tower by Red Hat helps organizations scale IT automation and manage complex deployments across physical, virtual, and cloud infrastructures. Built on the proven open-source Ansible automation engine, Ansible Tower includes capabilities that provide additional levels of visibility, control, security, and efficiency necessary for today's enterprises. With Ansible Tower you can utilize the large community of content available on Ansible Galaxy. This offering requires the use of an available Ansible Tower subscription eligible for use in Azure. If you don't currently have a subscription, you can obtain one directly from Red Hat.

## Playbook structure

Playbooks are the language of Ansible's configurations, deployments, and orchestrations. You use them to manage configurations of and deployments to remote machines. Playbooks are structured with YAML (a data serialization language) and support variables. Playbooks are declarative and include detailed information regarding the number of machines to configure at a time.

### YAML structure

YAML is based around the structure of key-value pairs. In the following example, the key is `name`, and the value is `namevalue`:

```yaml
name: namevalue
```

In the YAML syntax, a child key value pair is placed on a new, indented line below its parent key. Each sibling key value pair occurs on a new line at the same level of indentation as its sibling key value pair.

```yaml
parent:
  children:
    first-sibling: value01
    second-sibling: value02
```

The specific number of spaces used for indentation isn't defined. You can indent each level by as many spaces as you want. However, the number of spaces used for indentations at each level must be uniform throughout the file.

When there's indentation in a YAML file, the indented key value pair is the value of its parent key.

### Playbook components

The following list is of some of the playbook components:

- **name**. The name of the playbook. This can be any name you wish.

- **hosts**. Lists where the configuration is applied, or the machines being targeted. Hosts can be a list of one or more groups or host patterns, separated by colons. It can also contain groups such as web servers or databases, providing that you have defined these groups in your inventory.

- **connection**. Specifies the connection type.

- **remote_user**. Specifies the user that will be connected to for completing the tasks.

- **var**. Allows you to define the variables that can be used throughout your playbook.

- **gather_facts**. Determines whether to gather node data or not. The value can be yes or no.

- **tasks**. Indicates the start of the modules where the actual configuration is defined.

### Running a playbook

You run a playbook using the following command:

```python
ansible-playbook < playbook name >
```

You can also check the syntax of a playbook using the following command:

```yaml
ansible-playbook --syntax-check
```

The `syntax-check` command runs a playbook through the parser to verify that it has included items, such as files and roles, and that the playbook has no syntax errors. You can also use the `--verbose` command.

To see a list of hosts that would be affected by running a playbook, run the command:

```yaml
ansible-playbook playbook.yml --list-hosts
```

### Sample playbook

The following code is a sample playbook that creates a Linux virtual machine in Azure:

```yaml
- name: Create Azure VM
  hosts: localhost
  connection: local
  vars:
   resource_group: ansible_rg5
   location: westus
  tasks:
  - name: Create resource group
    azure_rm_resourcegroup:
      name: "{{ resource_group  }}"
      location: "{{ location  }}"
  - name: Create virtual network
    azure_rm_virtualnetwork:
      resource_group: myResourceGroup
      name: myVnet
      address_prefixes: "10.0.0.0/16"
  - name: Add subnet
    azure_rm_subnet:
      resource_group: myResourceGroup
      name: mySubnet
      address_prefix: "10.0.1.0/24"
      virtual_network: myVnet
  - name: Create public IP address
    azure_rm_publicipaddress:
      resource_group: myResourceGroup
      allocation_method: Static
      name: myPublicIP
    register: output_ip_address
  - name: Dump public IP for VM which will be created
    debug:
      msg: "The public IP is {{ output_ip_address.state.ip_address }}."
  - name: Create Network Security Group that allows SSH
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
  - name: Create virtual network interface card
    azure_rm_networkinterface:
      resource_group: myResourceGroup
      name: myNIC
      virtual_network: myVnet
      subnet: mySubnet
      public_ip_name: myPublicIP
      security_group: myNetworkSecurityGroup
  - name: Create VM
    azure_rm_virtualmachine:
      resource_group: myResourceGroup
      name: myVM
      vm_size: Standard_DS1_v2
      admin_username: azureuser
      ssh_password_enabled: false
      ssh_public_keys:
        - path: /home/azureuser/.ssh/authorized_keys
          key_data: <your-key-data>
      network_interfaces: myNIC
      image:
        offer: CentOS
        publisher: OpenLogic
        sku: '7.5'
        version: latest
```

> [!NOTE]
> Ansible playbook samples for Azure are available on GitHub on the [Ansible Playbook Samples for Azure](https://github.com/Azure-Samples/ansible-playbooks) page.

## Demonstration: Run Ansible in Azure Cloud Shell

You can run Ansible playbooks on a Windows machine by using the Azure Cloud Shell with Bash. This is the quickest and easiest way to begin using playbook's provisioning and management features in Azure.

### Run commands

Azure Cloud Shell has Ansible preinstalled. After you're signed into Azure Cloud Shell, specify the bash console. You don't need to install or configure anything further to run Ansible commands from the Bash console in Azure Cloud Shell.

### Editor

You can also use the Azure Cloud Shell editor to review, open, and edit your playbook .yml files. You can open the editor by selecting the curly brackets icon on the Azure Cloud Shell taskbar.

### Create a resource group

The following steps outline how to create a resource group in Azure using Ansible in Azure Cloud Shell with bash:

1. Go to the Azure Cloud Shell. You can also launch Azure Cloud Shell from within the Azure portal by selecting the Azure PowerShell icon on the taskbar.

2. Authenticate to Azure by entering your credentials, if prompted.

3. On the taskbar, ensure **Bash** is selected as the shell.

4. Create a new file using the following command:

    ```bash
    vi rg.yml
    ```

5. Enter insert mode by pressing the I key.

6. Copy and paste the following code into the file, and remove the **#** comment character. (It's included here for displaying code in the learning platform.) The code should be aligned as previously described.

    ```yml
      #---
        - hosts: localhost
          connection: local
          tasks:
            - name: Create resource group
              azure_rm_resourcegroup:
                name: ansible-rg
                location: eastus
    ```

7. Exit insert mode by pressing the Esc key.

8. Save the file and exit the vi editor by entering the following command:

    ```bash
    :wq
    ```

9. Run the playbook with the following command:

    ```yml
    ansible-playbook rg.yml
    ```

10. Verify that you receive output like the following code:

    ```output
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

11. Open the Azure portal and verify that the resource group is now available in the portal.