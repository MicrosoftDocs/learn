
Even though Intune offers a simple and easy approach for installing Microsoft 365 Apps on Windows and macOS devices other deployment options may be needed depending on your requirements.

If you need complete control of the Microsoft 365 Apps deployment, you can choose what deployment tool to use and whether to install the Office files directly from the cloud or from a local source on your network. You have the following options for preparing and deploying Microsoft 365:

 -  Configuration Manager
 -  The Office Deployment Tool
 -  The Office Customization Tool
 -  End-user installation

#### Configuration Manager

Configuration Manager is usually a good choice for organizations that already use it to distribute and manage software. Configuration Manager scales for large environments; enables extensive control over installation, updates, and settings; and has built-in features for deploying and managing Office.

#### Use the Office Deployment Tool

For organizations that don't have Configuration Manager but still want to manage their deployment, the Office Deployment Tool (ODT) can be used. You can use the ODT as a standalone tool or you can use it to download installation files that can be deployed using Intune or a third-party software deployment tool. In either case, the ODT provides rich control over installation, updates, and settings.

#### Use the Office Customization Tool

Another option is to use the Office Customization Tool. With this new web-based tool you can easily customize the deployment of Microsoft 365 Apps and other Select-to-Run managed Office products using a simple, intuitive, and web-based interface. The tool is an Azure-based cloud service, which allows you to create XML configuration files that are used with the Office Deployment Tool. In the past, you needed to create the configuration files in Notepad or another text editor. The Office Customization Tool makes this part of the deployment process easier and less likely to introduce errors.

This tool provides a simple experience, which allows you to create a configuration file for use with the Office Deployment Tool, for scenarios where you need to customize the installation of Microsoft 365 Apps. Common scenarios include:

 -  Initial installation of Microsoft 365 Apps and Office 2021 suites, with the ability to include standalone products such as Visio and Project and various language packs.
 -  Adding additional products after the initial installation of the Office suite.
 -  Adding additional language packs by configuring a ‘Language Only’ configuration after the installation of the Office suite or standalone products
 -  Standalone installation of Microsoft 365 Access Runtime.
 -  Installation of volume licensed products with automatic KMS and MAK activation.
 -  Automatic removal of previous MSI based Office products.

You can also use the Office Customization Tool to alter existing config files. This tool is helpful when you have to change the Office setup on already-installed and setup devices, or if you're creating a second or third setup and want to use your own baseline. Use Import to select the config file you want to adjust, alter it as you need, then Export to get a new config file.

#### End-user installation

Your users can download Microsoft 365 apps from the Microsoft 365 portal. This method involves the least amount of administrative preparation, but furnishes you with the least amount of control over the deployment. You can still decide how often your users get feature updates. Users need to have admin rights on their devices for this option.
