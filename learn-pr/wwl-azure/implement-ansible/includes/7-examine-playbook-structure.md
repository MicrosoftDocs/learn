Playbooks are the language of Ansible's configurations, deployments, and orchestrations.

You use them to manage configurations of and deployments to remote machines.

Playbooks are structured with YAML (a data serialization language) and support variables.

Playbooks are declarative and include detailed information about the number of machines to configure at a time.

## YML structure

YAML is based on the structure of key-value pairs. In the following example, the key is `name`, and the value is `namevalue`:

```YAML
Name: namevalue

```

In the YAML syntax, a child key-value pair is placed on a new and indented line below its parent key.

Each sibling key-value pair occurs on a new line at the same indentation level as it.

```YAML
Parent:
  Children:
    First-sibling: value01
    Second-sibling: value02

```

The specific number of spaces used for indentation isn't defined. You can indent each level by as many spaces as you want.

However, the number of spaces used for indentations at each level must be uniform throughout the file.

When there's an indentation in a YAML file, the indented key-value pair is the value of its parent key.

## Playbook components

The following list is of some of the playbook components:

 -  `Name`. The name of the playbook. It can be any name you wish.
 -  `Hosts`. Lists where the configuration is applied or machines being targeted. Hosts can be a list of one or more groups or host patterns, separated by colons. It can also contain groups such as web servers or databases, providing that you've defined these groups in your inventory.
 -  `Connection`. Specifies the connection type.
 -  `remote_user`. Specifies the user that will be connected to for completing the tasks.
 -  `var`. Allows you to define the variables that can be used throughout your playbook.
 -  `gather_facts`. Determines whether to gather node data or not. The value can be `yes` or `no`.
 -  `Tasks`. Indicates the start of the modules where the actual configuration is defined.

## Running a playbook

You run a playbook using the following command:

```Python
Ansible-playbook < playbook name >

```

You can also check the syntax of a playbook using the following command.

```Yml
ansible-playbook --syntax-check

```

The syntax check command runs a playbook through the parser.

It's to verify it has included items. For example, files and roles, and that the playbook has no syntax errors.

You can also use the `--verbose` command.

 -  To see a list of hosts that would be affected by running a playbook, run the command:

```Yml
Ansible-playbook playbook.yml --list-hosts

```

## Sample playbook

The following code is a sample playbook that will create a Linux virtual machine in Azure:

```Yml

- name: Create Azure VM.
  hosts: localhost
  connection: local
  vars:
  resource_group: ansible_rg5
  location: westus
  tasks:
    - name: Create resource group.
      azure_rm_resourcegroup:
        name: "{{ resource_group  }}"
        location: "{{ location  }}"
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
        ssh_password_enabled: false
        ssh_public_keys:
          - path: /home/azureuser/.ssh/authorized_keys
            key_data: <your-key-data>
        network_interfaces: myNIC
        image:
          offer: CentOS
          publisher: OpenLogic
          sku: "7.5"
          version: latest
```

> [!NOTE]
> Ansible Playbook samples for Azure are available on GitHub on the [Ansible Playbook Samples for Azure](https://github.com/Azure-Samples/ansible-playbooks) page.
