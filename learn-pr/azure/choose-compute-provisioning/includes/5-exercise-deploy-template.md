Your organization grows, and demand rises in Europe and Asia. Your organization is based in the USA. Most of your infrastructure is cloud-based. Your European users are reporting a slow website. To provide better service to the customers in Europe, your company has asked you to create a new and improved web server for Europe. The machine must be configured as an IIS web server when it's provisioned.

You have been asked to choose appropriate provisioning tools. Your tools should also be easy to use and easily customizable.

In this exercise, you'll provision a web server to meet the requirements.

## Provision a web server

You'll use a couple of tools together. Azure Resource Manager templates will enable you to create a template outlining the environment for your web server. Your Azure Resource Manager template can also help you define a state that you apply to your web server at the point of provisioning. You can apply your desired state by linking to a DSC extension handler inside of your Azure Resource Manager template. The DSC handler helps you enforce a state that you define in a DSC configuration.

In the following exercise, you'll use an Azure Resource Manager template to provision a virtual machine. The DSC extension handler that will be included in the template will enforce your state on the virtual machine. You'll use an Azure storage account to host your DSC configuration file.

## Clone the configuration and template

Let's start by obtaining a configuration file and Azure Resource Manager (ARM) template from GitHub:

1. In the Cloud Shell on the right, to clone the GitHub repository, run these commands:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-choose-compute-provisioning.git
    ```

## Examine and compress the state configuration file

The state configuration is defined in the Webserver.ps1 file, which includes the IIS web server on your virtual machine. Let's examine that file:

1. To open the file, run these commands:

    ```bash
    cd mslearn-choose-compute-provisioning
    code Webserver.ps1
    ```

1. The configuration file includes the following code. Notice that it installs IIS, ASP.NET, and the IIS Management console:

    ```powershell
    Configuration Webserver
    {
        param ($MachineName)

        Node $MachineName
        {
            #Install the IIS Role
            WindowsFeature IIS
            {
                Ensure = "Present"
                Name = "Web-Server"
            }

            #Install ASP.NET 4.5
            WindowsFeature ASP
            {
                Ensure = "Present"
                Name = "Web-Asp-Net45"
            }

            WindowsFeature WebServerManagementConsole
            {
                Name = "Web-Mgmt-Console"
                Ensure = "Present"
            }
        }
    }
    ```

1. To close the `code` editor, press <kbd>CTRL + Q</kbd>.
1. To see the contents of the `git` repository, type this command:

    ```bash
    ls
    ```

    Notice that the repository contains both the **Webserver.ps1** file, and the **Webserver.zip** compressed file. You'll use the zipped file later in this exercise.

## Configure the template

The GitHub repository that you cloned also contains an ARM template. Let's add the location of the zipped configuration file to it:

1. In the Cloud Shell, use this command to open the template:

    ```bash
    code template.json
    ```

1. In the **template.json** code file, in the `<parameters>` section, notice that some properties, such as `vmName`, don't include default values. You'll be prompted to enter values for those properties, when you use the template.
1. To provide a default value for the configuration file URL, in the **template.json** code file, locate this code:

    ```json
    "modulesUrl": {
        "type": "string",
        "metadata": {
            "description": "URL for the DSC configuration module."
        }
    },
    ```

1. Replace that code with this code:

<!-- NOTE: this URL won't work until my PR is merged into the repo. If you want to test it before merging, use https://github.com/alistairmatthews/mslearn-choose-compute-provisioning/raw/master/Webserver.zip -->

    ```json
    "modulesUrl": {
        "type": "string",
        "defaultValue": "https://github.com/MicrosoftDocs/mslearn-choose-compute-provisioning/raw/master/Webserver.zip",
        "metadata": {
            "description": "URL for the DSC configuration module."
        }
    },
    ```

1. To save the template, press <kbd>CTRL + S</kbd>.
1. In the `<variables>` section of the **template.json**, notice that values are stored to configure networking for the virtual machine.
1. In the `<resources>` section, notice that the template will create an IP address, a virtual network, and other resources, as well as the virtual machine itself.
1. To close the `code` editor, press <kbd>CTRL + Q</kbd>.

## Validate your template

Now that you have a completed ARM template and zipped configuration file, you can use the Azure CLI to perform a deployment. Before you deploy, you can validate your files to see if the deployment would be successful:

1. In the Cloud Shell to the right, to validate your deployment, run this command:

    ```bash
    az group deployment validate \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --template-file template.json
    ```

1. You'll be prompted to enter a **vmName**.  This name will be given to the virtual machine. Type **hostVM1** and then press <kbd>Enter</kdb>.
1. When you are asked for **adminUsername** and **adminPassword**, use a username that has at least one uppercase letter, a symbol, and a number. Remember that the password you use must be between 8-123 characters long and must satisfy at least 3 of these requirements:

    - Contains an uppercase character
    - Contains a lowercase character
    - Contains a numeric digit
    - Contains a special character
    - Control characters are not allowed

1. If your deployment is validated, you'll see information about your deployment. Pay special attention to the `error` property, which can be found by scrolling back through the output text. It should be null.

    ![No error](../media/5-error-null.png)

1. If there are no errors, your template has been validated and can be deployed.

## Deploy your template

Now that we know the template is valid, we can perform the deployment:

1. To deploy the template, run this command:

    ```bash
    az group deployment create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --template-file template.json
    ```

1. Follow the prompts to complete your deployment. If you are running on a sandbox, this deployment will take around 10 minutes.  As long as you see the response "Running.." the deployment is still busy.
1. Once everything has been set up, you will have a virtual machine configured as an IIS web server. To list all of the resources in the resource group and confirm that everything has been set up, run this command:

    ```bash
    az resource list \
      --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

1. You'll see all of your resources listed, which means your deployment was successful.
1. To test if your IIS server is running, run this command in the shell:

    ```bash
    az vm show -d \
      -g <rgn>[sandbox resource group name]</rgn> \
      -n hostVM1 --query publicIps -o tsv
    ```

1. Copy the IP address that is returned, and paste it into a new browser window. You should see your IIS server running:

    ![IIS server](../media/5-iis-server-runs.png)

You've provisioned a web server using Azure Resource Manager templates and enforced a desired state configuration on your machine through a DSC extension handler.
