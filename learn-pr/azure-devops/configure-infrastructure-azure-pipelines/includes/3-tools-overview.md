In this part, you learn about these popular configuration management tools:

* Ansible
* Azure Automation
* Azure Custom Script Extension
* Chef
* Cloud-init
* PowerShell DSC
* Puppet

For each tool, you'll get a general sense for how it works, which programming languages are involved, and how it integrates with Azure. At the end, Andy and Tim will choose one to try.

## Ansible

Ansible is an open-source product, sponsored by Red Hat, that automates cloud provisioning, configuration management, and application deployments. You can use Ansible to provision Azure resources such as virtual machines, containers, networks, and even complete cloud infrastructures. You can also use Ansible to configure your Azure resources after they're provisioned, which is the focus in this module.

In addition to Azure, Ansible supports other public clouds as well as private cloud frameworks.

With Ansible, you write _playbooks_ that express your desired configuration. A playbook is a YAML file, making it a form of declarative automation.

A playbook is made up of _modules_. Ansible provides built-in module types that configure various parts of the system. For example, the `file` module enables you to manage a file. The `user` module enables you to manage a user account.

Here's a basic example that you'll work with later. It defines service accounts for users named *testuser1* and *testuser2*.

```yml
---
- hosts: all
  become: yes
  tasks:
  - name: Add service accounts
    user:
      name: "{{ item }}"
      comment: service account
      create_home: no
      shell: /usr/sbin/nologin
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
  --private-key ~/.ssh/ansible_rsa \
  --limit=tag_Ansible_test1 \
  ./users.yml \
```

You'll see this process in greater detail later in this module.

If you run this command multiple times, Ansible configures the user accounts only if they don't exist or have changed. This command is therefore an idempotent operation.

Ansible is also agentless, so you don't have to install Ansible software on the managed machines. However, you do need to install Python on your managed machines. By default, Ansible connects to Linux machines over the SSH protocol, and Windows machines over WinRM.

You typically use a _control machine_ to manage your systems. A control machine includes the Ansible software and the playbooks you need to run. The control machine pushes configuration changes to your nodes. Later in this module, you'll set up a control machine and run Ansible playbooks from that control machine in Azure Pipelines.

Although Ansible is agentless, both the control machine and managed nodes require Python to enable Ansible to connect to remote systems and issue commands on those systems.

### Ansible inventories

In Ansible, the _inventory_ is a file that defines the hosts upon which the tasks in a playbook operate. Ansible represents what systems it manages by using an _.ini_ or YAML file that puts all of your managed machines in groups of your own choosing.

For a VM deployment on Azure, you *could* define each VM and its IP address or hostname, similar to this:

```yml
hosts:
  vm1:
    ansible_host: 13.79.22.89
  vm2:
    ansible_host: 40.87.135.194
```

This is an example of a _static inventory_. If these IP addresses change, or if you add or remove systems, you'd need to update this inventory file over time.

A more flexible approach is to use a _dynamic inventory_. A dynamic inventory enables Ansible to discover which systems to configure at runtime.

Here's the dynamic inventory file you're going to use in this module:

```yml
plugin: azure_rm
include_vm_resource_groups:
- learn-ansible-rg
auth_source: auto
keyed_groups:
- prefix: tag
  key: tags
```

This inventory specifies that each VM in the `learn-ansible-rg` resource group belongs to the inventory. The `keyed_groups` part groups VMs by their tag names. You'll work with a complete example later in this module.

### Ansible on Azure

There are a number of ways you can use Ansible on Azure.

On [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?azure-portal=true), you'll find a number of images that you can use. They include:

* [Red Hat Ansible instance on Linux](https://azuremarketplace.microsoft.com/marketplace/apps/redhat.ansible-tower?tab=Overview), published by Microsoft.

    You can use this image to bring up a control machine, which includes Ansible, the Azure CLI, and other tools, to manage your fleet.

* [Ansible Tower](https://azuremarketplace.microsoft.com/marketplace/apps/redhat.ansible-tower?azure-portal=true), published by Red Hat. 

    Ansible Tower helps organizations scale IT automation and manage complex deployments across physical, virtual, and cloud infrastructures. With Ansible Tower, you can:

    * Provision Azure environments using pre-built Ansible playbooks.
    * Use role-based access control (RBAC) to define who or what can see, change, or delete objects, or utilize specific capabilities.
    * Maintain centralized logging for complete auditability and compliance.
    * Use the many content resources available on Ansible Galaxy.

You can also set up Ansible on a Linux VM running on Azure, or in your datacenter, and use that as your control machine. Although Ansible doesn't support Windows as the control machine, you can run Ansible from Windows through Windows Subsystem for Linux, Azure Cloud Shell, or Visual Studio Code.

## Azure Automation

Azure Automation is a service in Azure that helps you automate manual tasks. Automation has the concept of a _runbook_, which is a set of tasks that perform some automated procedure in Automation. Tasks in a runbook are written in PowerShell, [PowerShell Workflow](https://docs.microsoft.com/system-center/sma/overview-powershell-workflows?azure-portal=true), or Python. You can run a runbook either manually or on a schedule.

Here's a basic example that uses PowerShell Workflow to stop a running service:

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

Although the name implies that you can use Azure Automation only on Azure, it's more flexible than that. Automation has a feature called hybrid runbook worker. This feature gives Automation access to resources in other clouds or in your on-premises environment that would otherwise be blocked by a firewall.

Automation also provides a Desired State Configuration (DSC) pull server that enables you to create definitions for how a specified set of VMs should be configured. DSC then ensures that the required configuration is applied and that the VM stays consistent. Automation DSC runs on both Windows and Linux.

## Azure Custom Script Extension

The Custom Script Extension is a way to download and run scripts on your Azure VMs. You can run the extension when you create a VM, or any time after the VM is in use.

You can store your scripts in Azure Storage or in a public location, such as GitHub. You can run scripts manually or as part of a more automated deployment.

You can use the Custom Script Extension with Windows or Linux VMs. Here's an example that uses the `az vm extension set` command to run a Bash script that installs Nginx web server on a Linux VM.

```azurecli
az vm extension set \
  --resource-group my-rg \
  --vm-name my-vm \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.1 \
  --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' \
  --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```

## Chef

Chef is an infrastructure automation tool that enables you to configure and manage your systems.

Chef helps you to manage your infrastructure in the cloud, on-premises, or in a hybrid environment. You express your configurations by writing _recipes_ that describe everything your systems need to run your application. Chef recipes use a declarative syntax that's based on the Ruby programming language. A recipe uses the *.rb* file extension.

A Chef recipe is made up of _resources_. Chef provides built-in resource types that enable you to configure various parts of the system. For example, the `package` resource enables you to install or remove a package. The `service` resource enables you to manage a service.

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

Most Chef resources are idempotent, meaning you can apply the same configuration repeatedly.

You can package multiple recipes into a _cookbook_. A cookbook might contain recipes that configure the various parts of MySQL, Nginx, OpenSSL, or any other kind of software.

Building on the previous code example, an IIS cookbook might contain recipes that configure application pools, virtual directories, and virtual sites. You can define _roles_ to specify which recipes are applied to a system based on that system's function. For example, you might define the "webserver" role to run recipes that install and configure IIS, Apache, or Nginx web servers. The "database" role might run recipes that install and configure MySQL or Microsoft SQL Server.

Chef and the Chef community maintain cookbooks on [Chef Supermarket](https://supermarket.chef.io/?azure-portal=true).

### Chef on Azure

There are a number of ways you can use Chef on Azure.

On [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?azure-portal=true), you'll find a number of images that you can use. They include:

* [Chef Extension](https://docs.chef.io/azure_portal/) for Windows and Linux, published by Chef Software.

    These images come with the Chef Client. Chef Client is an agent that runs on each node that's managed through Chef. Chef Client applies the cookbooks and recipes you specify. Chef Client can also send reporting data back to a Chef Server or a Chef Automate server, so that you can track and audit your configuration runs over time.

* [Chef Automate](https://azuremarketplace.microsoft.com/marketplace/apps/chef-software.chef-automate?azure-portal=true), published by Chef Software.

  Chef Automate enables you to package and test your applications, and provision and update your infrastructure. Using Chef, you can manage all of it with compliance and security checks, and dashboards that give you visibility into your entire stack.

You can also set up Chef on a Linux or Windows VM running on Azure, or in your datacenter.

### Cloud-init

Cloud-init, by Canonical, is a way to customize a Linux VM as it boots for the first time. You can use cloud-init to install packages, write files, and configure users.

You write cloud-init files by using YAML. Consider this basic cloud-init configuration that installs PIP, the package manager for Python, and NumPy, a package for scientific computing with Python.

```yml
#cloud-config
packages:
  - python-pip
runcmd:
  - pip install numpy
```

In this example, `packages` specifies the list of packages to install. Here, we install **python-pip**. `runcmd` specifies the list of commands to run on first boot. Here, we use PIP to install the NumPy package.

This configuration is declarative, meaning you don't need to specify _how_ to install **python-pip**. Cloud-init recognizes the Linux distribution that's running, and can use the appropriate package manager to install the **python-pip** package. For example, it can install **apt** on Debian-based systems or **yum** on Red Hat Enterprise Linux.

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

DSC configurations define what to install and configure on a machine. A local configuration manager (LCM) engine runs on each target node that processes requested actions based on pushed configurations. A pull server is a web service that runs on a central host to store the DSC configurations and associated resources. The pull server communicates with the LCM engine on each target node to provide the required configurations and report on compliance.

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

The first line makes the configuration function available in the console. The second line runs the configuration. The result is a folder, named *MyWebsite*, which contains a file named *localhost.mof*.

To apply the configuration, you run the `Start-DscConfiguration` cmdlet, like this:

```powershell
Start-DscConfiguration .\MyWebsite
```

## Puppet

Puppet is an automation platform that handles the application delivery and deployment process. Agents are installed on target machines to allow Puppet Master to run manifests that define the desired configuration of your infrastructure.

You express your configurations by writing manifest files known as Puppet Program files. Manifests describe everything your systems need to run your application. Puppet manifests use a declarative syntax that's based on the Ruby programming language. A manifest uses the *.pp* file extension.

A Puppet manifest is made up of _resources_. Puppet provides built-in resource types that enable you to configure various parts of the system. For example, the `file` resource enables you to manage a file. The `service` resource enables you to manage a service.

Here's a basic Puppet manifest that installs IIS web server on Windows:

```ruby
$iis_features = ['Web-WebServer']

iis_feature { $iis_features:
  ensure => 'present'
}
```

You can package multiple manifests into a _module_. Puppet and their partners maintain modules at [Puppet Forge](https://forge.puppet.com/?azure-portal=true).

In this example, the `iis_feature` resource is provided by the [puppetlabs-iis](https://forge.puppet.com/puppetlabs/iis?azure-portal-true) module, which helps you manage IIS sites and application pools.

### Puppet on Azure

There are a number of ways you can use Puppet on Azure.

On [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?azure-portal=true), you'll find a number of images that you can use. They include:

* [Puppet Agent](https://puppet.com/docs/puppet/5.5/install_windows.html), published by Puppet, is a virtual machine extension that installs the Puppet agent on your Windows VM.

* [Puppet Enterprise](https://azuremarketplace.microsoft.com/marketplace/apps/puppet.puppet-enterprise-201818?azure-portal=true), published by Puppet, enables you to automate the entire lifecycle of your infrastructure.

You can also set up Puppet on a Linux or Windows VM running on Azure, or in your datacenter.

## The decision

In [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true), the Tailspin team chose Terraform to provision Azure resources. Now they need to make a decision on which configuration management tool to use to configure their virtual machines. Let's join the conversation.

_Andy looks at Tim._

**Andy:** What do you think? Do you have any preferences?

**Tim:** I like many of these options. Can we continue to use Terraform to configure our systems?

**Andy:** Terraform is great for building infrastructure. It's designed, out of the box, to interact directly with cloud providers, to help you plan that infrastructure, and then to build it. However, Terraform is not a configuration management tool. That said, you can use Terraform to build your infrastructure, and then use what's called a _provisioner_ to configure your infrastructure by using your favorite tools.

_Tim thinks for a minute._

**Tim:** Let's go with Ansible. Maybe we can tie it in with Terraform at some point, but for now, I'd like to see it working and then add it to Azure Pipelines. Perhaps we can build a basic prototype, and then later we can add in our details.

**Andy:** Sounds great. Let's get to work.
