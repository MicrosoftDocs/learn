Cloud Shell offers a browser-accessible, preconfigured shell experience for managing Azure resources without the overhead of installing, versioning, and maintaining a machine yourself.

Cloud Shell provisions machines on a per-request basis, and as a result, machine state won't persist across sessions. Cloud Shell is built for interactive sessions, and therefore, shells automatically terminate after 20 minutes of shell inactivity.

## Secure automatic authentication

Cloud Shell securely and automatically authenticates account access for the Azure CLI and Azure PowerShell. This helps you gain quick and more secure access to your resources.

## $HOME persistence across sessions

To persist files across sessions, Cloud Shell moves through attaching an Azure file share on the first launch. When this completes, Cloud Shell will automatically attach your storage (mounted as `$HOME\clouddrive`) for all future sessions. Additionally, your `$HOME` directory is persisted as an .img in your Azure file share. Files outside of $HOME and machine state aren't persisted across sessions. Depending on the scenario, you should use recommended best practices when storing secrets such as SSH keys. Services such as Azure Key Vault have tutorials for setup.

## Azure drive (Azure:)

PowerShell in Cloud Shell provides the Azure drive (Azure:). You can switch to the Azure drive with **cd Azure:** and back to your home directory with **cd ~**. The Azure drive enables easier discovery and navigation of Azure resources such as compute, network, and storage, similar to file system navigation. You can continue to use familiar Azure PowerShell cmdlets to manage these resources, regardless of the drive you're in. Any changes to the Azure resources, whether they're made directly in the Azure portal or by using Azure PowerShell cmdlets, are reflected in the Azure drive. You can run **dir -Force** to refresh your resources.

## Manage Exchange Online

PowerShell in Cloud Shell contains a private build of the Exchange Online module. Run **Connect-EXOPSSession** to get your Exchange cmdlets. By using these cmdlets, you can manage your Exchange Online instance running in the Microsoft 365 environment.

## Deep integration with open-source tooling

Cloud Shell includes preconfigured authentication for various open-source tools. The following table lists the various tool categories and interfaces you can use.

*Table 1: Tool categories and interfaces*

| Category       | Names                                                         |
| -------------- | ------------------------------------------------------------ |
| Linux tools    | bash, zsh, sh, tmux, and dig                        |
| Azure tools    | Azure CLI and Azure classic CLI, AzCopy, Azure Functions CLI, Service Fabric CLI, Batch Shipyard, and blobxfer |
| Text editors   | code (Cloud Shell editor), vim, nano, and emacs         |
| Source control | git                                                          |
| Build tools    | make, maven, npm, and pip                               |
| Containers     | Docker Machine, Kubectl, Helm, and DC/OS CLI            |
| Databases      | MySQL client, PostgreSql client, sqlcmd Utility, and mssql-scripter |
| Other          | iPython Client, Cloud Foundry CLI, Terraform, Ansible, Chef InSpec, Puppet Bolt, HashiCorp Packer, and Office 365 CLI |
