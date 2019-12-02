TODO: INTRO

* Ansible
* Azure Automation
* Azure Custom Script Extension
* Chef
* Cloud-init 
* PowerShell DSC
* Puppet

## Ansible

TODO: Knowledge: ad-hoc commmands vs plays/playbooks
TODO: Knowledge: modules (-m ping example)
https://docs.ansible.com/ansible/latest/user_guide/intro_adhoc.html

TODO: Facts

TODO: "The Ansible inventory file defines the hosts and groups of hosts upon which commands, modules, and tasks in a playbook operate. The file can be in one of many formats depending on your Ansible environment and plugins."

TODO:

* basic concepts https://docs.ansible.com/ansible/latest/user_guide/basic_concepts.html
* inventory https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html


Ansible is an open-source product, sponsored by Red Hat, that automates cloud provisioning, configuration management, and application deployments. You can use Ansible to provision Azure resources such as virtual machines, containers, networks, and even complete cloud infrastructures. You can also use Ansible to configure your Azure resources after they're provisioned, which is the focus in this module.

In addition to Azure, Ansible supports other public clouds and private cloud frameworks.

You can run Ansible commands directly to configure your systems. But a more common approach is to write _playbooks_ to deploy more complex configurations. A playbook is a YAML file, making it a form of declarative automation.

A playbook is made up of _modules_. Ansible provides built-in modules that enable you to configure various parts of the system. For example, the `file` module enables you to manage a file. The `user` module enables you to manage a user account.

Here's a basic example that you'll work with later. It defines service accounts for users named "testuser1" and "testuser2".

```yml
---
- hosts: all
  remote_user: azureuser
  become: yes
  tasks:
  - name: Add service accounts
    user:
      name: "{{ item }}"
      comment: service account
      create_home: no
      shell: /usr/sbin/nologin
      password: '*'
      state: present
    loop:
    - testuser1
    - testuser2
```

You use the `ansible-playbook` command to apply this configuration, like this:

```bash
ansible-playbook \
  --inventory ./azure_rm.yml \
  --user azureuser \
  --private-key ~/.ssh/id_ansible-vm \
  --limit=tag_Ansible_test1 \
  ./users.yml \
```

You'll see this process in greater detail later in this module.

If you run this command multiple times, Ansible configures the user accounts only if they do not exist or have changed. This makes this process an idempotent operation.

Ansible is also agentless, so you do not have to install Ansible software on the managed machines. However, you do need to install Python on your managed machines. By default, Ansible connects to Linux machines over the SSH protocol and Windows machines over WinRM.

You typically use a _control machine_ to manage your systems. A control machine includes the Ansible software and the playbooks you need to run. Later in this module, you'll set up a control machine and run Ansible playbooks from that machine in Azure Pipelines to manage your systems.

Although Ansible is agentless, both the control machine and managed nodes require Python to enable Ansible to connect to remote systems and issue commands on those systems.

### Facts

_Facts_ are data points about the remote system that Ansible is managing. When you run a playbook, Ansible gathers facts about the state of the environment to determine the state before executing the playbook.

### Inventory

TODO: Fix this; show example with static inventory; talk about dynamic inventories; show example.

The _inventory_ is a list of managed nodes. Ansible represents what machines it manages by using an _.ini_ file that puts all of your managed machines in groups of your own choosing. When adding new machines, you do not need to use additional SSL-signing servers, thus avoiding Network Time Protocol (NTP) and Domain Name System (DNS) issues. You can create the inventory manually, or for Azure, Ansible supports dynamic inventories, which means that the host inventory is dynamically generated at runtime. Ansible supports host inventories for other managed hosts as well.

### Ansible on Azure

There are a number of ways you can use Ansible on Azure.

On the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?azure-portal=true), you'll find a number of images that you can use. They include:

* [Red Hat Ansible instance on Linux](https://azuremarketplace.microsoft.com/marketplace/apps/azure-oss.ansible?azure-portal=true), published by Microsoft.

    You can use this image to bring up a control machine, which includes Ansible, the Azure CLI, and other tools, to manage your fleet.

* [Ansible Tower](https://azuremarketplace.microsoft.com/marketplace/apps/redhat.ansible-tower?azure-portal=true), published by Red Hat. Ansible Tower helps organizations scale IT automation and manage complex deployments across physical, virtual, and cloud infrastructures. With Ansible Tower, you can:

  * Provision Azure environments using pre-built Ansible playbooks.
  * Use role-based access control (RBAC) for secure, efficient management.
  * Maintain centralized logging for complete auditability and compliance.
  * Utilize the large community of content available on Ansible Galaxy.

You can also set up Ansible on a Linux VM running on Azure or in your datacenter and use that as your control machine. Although Ansible does not support Windows as the control machine, you can run Ansible from Windows through Windows Subsystem for Linux, Cloud Shell, or Visual Studio Code.

## Azure Automation

Azure Automation is an Azure service that helps you automate manual tasks. Azure Automation has the concept of a _runbook_, which is a set of tasks that perform some automated procedure in Azure Automation. Tasks in a runbook are written in PowerShell, [Powershell Workflow](https://docs.microsoft.com/system-center/sma/overview-powershell-workflows?azure-portal=true), or Python. You can run a runbook either manually or on a defined schedule.

Here's a basic example that uses Powershell Workflow to stop a running service:

```powershell
Workflow Stop-MyService
{
    $Output = InlineScript {
        $Service = Get-Service -Name MyService
        $Service.Stop()
        $Service
    }

    $Output.Name
}
```

Although the name implies that you can use Azure Automation only on Azure, it's more flexible than that. Azure Automation has a feature called Hybrid Runbook Worker. Hybrid Runbook Worker gives Azure Automation access to resources in other clouds or in your on-premises environment that would otherwise be blocked by a firewall.

Azure Automation also provides a Desired State Configuration (DSC) service that allows you to create definitions for how a given set of VMs should be configured. DSC then ensures that the required configuration is applied and the VM stays consistent. Azure Automation DSC runs on both Windows and Linux machines.

## Azure Custom Script Extension

The Custom Script Extension is a way to download and run scripts on your Azure VMs. You can run the extension when you create a VM, or any time after the VM is in use.

You can store your scripts in Azure storage or in a public location such as GitHub. You can run scripts manually or as part of a more automated deployment.

You can use the Custom Script Extension with Windows or Linux VMs. Here's an example that uses the `az vm extension set` command to run a Bash script that installs Nginx web server on a Linux VM.

```azurecli
az vm extension set \
  --resource-group my-rg \
  --vm-name my-vm \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' \
  --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```

## Chef

Chef is an infrastructure automation tool helps you to configure and manage your systems.

Chef helps you to manage your infrastructure in the cloud, on-premises, or in a hybrid environment. You express you configurations by writing _recipes_ that describe everything your systems need to run your application. Chef recipes use a declarative syntax that's based on the Ruby programming language. A recipe uses the *.rb* file extension.

A Chef recipe is made up of _resources_. Chef provides built-in resource types that enable you to configure various parts of the system. For example, the `file` resource enables you to manage a file. The `service` resource enables you to manage a service.

Here's the Chef recipe that installs Internet Information Services (IIS) web server on Windows, which you saw earlier in this module:

```ruby
powershell_script 'Install IIS' do
  action :run
  code 'Add-WindowsFeature Web-Server'
end

service 'w3svc' do
  action [ :enable, :start ]
end

template 'c:\inetpub\wwwroot\Default.htm' do
  source 'Default.htm.erb'
  rights :read, 'Everyone'
end
```

You can package multiple recipes into a _cookbook_. A cookbook might contain recipes that configure the various parts of MySQL, Nginx, OpenSSL, or any other kind of software.

Building on the previous code example, an IIS cookbook might contains recipes that configure application pools, virtual directories, virtual sites, and so on. You can define a _role_ to specify which recipes are applied to your systems.

You can find cookbooks that are maintained by Chef and the Chef community at [Chef Supermarket](https://supermarket.chef.io/?azure-portal=true).

### Chef on Azure

There are a number of ways you can use Chef on Azure.

On the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?azure-portal=true), you'll find a number of images that you can use. They include:

* Chef Extension for [Windows](https://azuremarketplace.microsoft.com/marketplace/apps/chef-software.chef-client-windows-arm?tab=Overview?azure-portal=true) and [Linux](https://azuremarketplace.microsoft.com/marketplace/apps/chef-software.chef-client-linux?azure-portal=true), published by Chef Software.

    These images come with the Chef Client. Chef Client is an agent that runs on each node that's managed through Chef. Chef Client applies the cookbooks and recipes you specify. Chef Client can also send reporting data back to a Chef Server or a Chef Automate server so that you can track and audit your configuration runs over time.

* [Chef Automate](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/chef-software.chef-automate?azure-portal=true), published by Chef Software. Chef Automate enables you to package and test your applications, and provision and update your infrastructure. Using Chef, you can manage all of it with compliance and security checks, and dashboards that give you visibility into your entire stack.

You can also set up Chef on a Linux or Windows VM running on Azure or in your datacenter.

### Cloud-init

Cloud-init, by Canonical, is a way to customize a Linux VM as it boots for the first time. You can use cloud-init to install packages, write files, and configure users and more.

You write cloud-init files by using YAML. Consider this basic cloud-init configuration that installs PIP, the package manager for Python, and NumPy, a package for scientific computing with Python.

```yml
#cloud-config
packages:
  - python-pip
runcmd:
  - pip install numpy
```

In this example, `packages` specifies the list of packages to install. Here, we install **python-pip**. `runcmd` specifies the list of commands to run on first boot. Here, we use PIP to install the NumPy package.

This configuration is declarative, meaning you don't need to specify _how_ to install **python-pip**. Cloud-init understands the Linux distribution that's running and can use the appropriate package manager to install the **python-pip** package, for example, **apt** on Debian-based systems or **yum** on Red Hat Enterprise Linux.

Here's an example that uses the Azure CLI to bring up an Ubuntu VM on Azure and apply this configuration.

```azurecli
az vm create \
  --resource-group my-rg \
  --name my-vm \
  --admin-username azureuser \
  --image UbuntuLTS \
  --custom-data cloud-init.txt \
  --generate-ssh-keys
```

The `--custom-data` argument specifies the cloud-init configuration to run when the VM boots for the first time. The cloud-init configuration is located in *cloud-init.txt*.

## PowerShell DSC

PowerShell Desired State Configuration (DSC) is a management platform that defines the configuration of target machines. You can use PowerShell DSC to manage Windows or Linux systems.

DSC configurations define what to install on a machine and how to configure the host. A Local Configuration Manager (LCM) engine runs on each target node that processes requested actions based on pushed configurations. A pull server is a web service that runs on a central host to store the DSC configurations and associated resources. The pull server communicates with the LCM engine on each target node to provide the required configurations and report on compliance.

Here's a basic example that uses PowerShell DSC to configure IIS on Windows.

```powershell
Configuration MyWebsite {

  Import-DscResource -ModuleName PsDesiredStateConfiguration

  Node "localhost" {
    WindowsFeature WebServer {
      Ensure = "Present"
      Name   = "Web-Server"
    }
  }
}
```

You would then compile this configuration into a Management Object Format (MOF) file, which is the format that DSC can consume. To do this, you run the configuration like a function. Here's an example:

```powershell
. .\MyWebsite.ps1
MyWebsite
```

The first line makes the configuration function available in the console. The second line runs the configuration. The result is that a new folder, named *MyWebsite*, which contains a file named *localhost.mof*.

To apply the configuration, you run the `Start-DscConfiguration` cmdlet, like this:

```powershell
Start-DscConfiguration .\MyWebsite
```

## Puppet

Puppet is an automation platform that handles the application delivery and deployment process. Agents are installed on target machines to allow Puppet Master to run manifests that define the desired configuration of the Azure infrastructure and VMs.

You express you configurations by writing manifest files known as Puppet Program files. Manifests describe everything your systems need to run your application. Puppet manifests use a declarative syntax that's based on the Ruby programming language. A manifest uses the *.pp* file extension.

A Puppet manifest is made up of _resources_. Puppet provides built-in resource types that enable you to configure various parts of the system. For example, the `file` resource enables you to manage a file. The `service` resource enables you to manage a service.

Here's a basic Puppet manifest that installs IIS web server on Windows:

```ruby
$iis_features = ['Web-WebServer']

iis_feature { $iis_features:
  ensure => 'present'
}
```

You can package multiple manifests into a _module_. You can find modules that are maintained by Puppet and their partners at [Puppet Forge](https://forge.puppet.com/?azure-portal=true).

In this example, the `iis_feature` resource is provided by the [puppetlabs-iis](https://forge.puppet.com/puppetlabs/iis?azure-portal-true) module, which helps you manage IIS sites and application pools.

### Puppet on Azure

There are a number of ways you can use Puppet on Azure.

On the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?azure-portal=true), you'll find a number of images that you can use. They include:

* [Puppet Agent](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/Puppet.puppet-agent-windows-arm?azure-portal=true), published by Puppet, is a virtual machine extension that image installs the Puppet agent on your Windows VM.

* [Puppet Enterprise](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/puppet.puppet-enterprise?azure-portal=true), published by Puppet, Puppet Enterprise enables you to automate the entire lifecycle of your Azure infrastructure. 

You can also set up Puppet on a Linux or Windows VM running on Azure or in your datacenter.

## The decision

In [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true), the Tailspin team chose Terraform to provision Azure resources. Now they need to make a decision on which configuration management tool to use to configure their virtual machines. Let's join the conversation.

_Andy looks at Tim._

**Andy:** What do you think? Do you have any preferences?

**Tim:** I like many of these options. Can we continue to use Terraform to configure our systems?

**Andy:** Terraform is great for building infrastructure. It's designed, out of the box, to interact directly with cloud providers, to help you plan that infrastructure and then to build it. However, Terraform is not a configuration management tool. That said, you can use Terraform to build your infrastructure, and then use what's called a _provisioner_ to configure your infrastructure using your favorite tools.

_Tim thinks for a minute._

**Tim:** Let's go with Ansible. Maybe we can tie it in with Terraform at some point, but for now, I'd like to see it working and then add it to Azure Pipelines. Perhaps we can build a basic prototype and then later we can add in our details.

**Andy:** Sounds great. Let's get to work.