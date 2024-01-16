Your organization grows, and demand rises in Europe and Asia. Your organization is based in the United States. Most of your infrastructure is cloud based. Your European users are reporting a slow website. To provide better service to the customers in Europe, your company has asked you to create a new and improved web server for Europe. The machine must be configured as an IIS web server when it's provisioned.

You've been asked to choose appropriate provisioning tools. Your tools should also be easy to use and easily customizable.

In this exercise, you provision a web server to meet the requirements.

## Provision a web server

You need to use several tools to provision a web server. Using an Azure Resource Manager template, you can define the environment for your web server. The Resource Manager template can also help you define a desired state configuration (DSC) for your web server. When you link to a DSC extension handler in the Resource Manager template, both the environment and the desired state are applied when you provision the web server. The DSC extension handler helps enforce the DSC state that you defined.

In the following exercise, you use a Resource Manager template to provision a virtual machine. The DSC extension handler that's included in the template enforces your state on the virtual machine. You use an Azure storage account to host your DSC configuration file.

## Clone the configuration and template

Let's start by obtaining a configuration file and an Azure Resource Manager template from GitHub.

1. In Azure Cloud Shell instance on the right, run the following command to clone the GitHub repository.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-choose-compute-provisioning.git
    ```

## Examine and compress the State Configuration file

The State Configuration is defined in the *Webserver.ps1* file, which includes the IIS web server on your virtual machine. Let's examine that file.

1. To open the file, run these commands:

    ```bash
    cd mslearn-choose-compute-provisioning
    code Webserver.ps1
    ```

    The configuration file includes the following code. Notice that it installs IIS, ASP.NET, and the IIS Management Console.

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

1. To close the code editor, press <kbd>Ctrl+Q</kbd>.

1. To see the contents of the cloned repository, run this command:

    ```bash
    ls -al
    ```

    Notice that the repository contains both the *Webserver.ps1* file, and the *Webserver.zip* compressed file. You use the zipped file later in this exercise.

## Configure the template

The GitHub repository that you cloned, also contains a Resource Manager template. Let's edit the template to add the location of the zipped configuration file to it.

1. In Cloud Shell, run this command to open the template:

    ```bash
    code template.json
    ```

1. In the *template.json* file, look for the `<parameters>` element. Notice that some members, such as `vmName`, don't have default values. When you use the template, you're prompted to enter values for those properties.

1. You can also provide a default value for the configuration file URL. In the *template.json* code file, locate this code:

    ```json
    "modulesUrl": {
        "type": "string",
        "metadata": {
            "description": "URL for the DSC configuration module."
        }
    },
    ```

1. Add the default value as follows so that it looks like this code:

    ```json
    "modulesUrl": {
        "type": "string",
        "defaultValue": "https://github.com/MicrosoftDocs/mslearn-choose-compute-provisioning/raw/master/Webserver.zip",
        "metadata": {
            "description": "URL for the DSC configuration module."
        }
    },
    ```

1. Save the template by pressing <kbd>Ctrl+S</kbd>.

    In the `<variables>` section of the *template.json* file, notice that values are stored to configure networking for a virtual machine.

    In the `<resources>` section, notice that the template defines an IP address, a virtual network, a virtual machine, and other related resources.

1. Close the code editor by pressing <kbd>Ctrl+Q</kbd>.

## Validate your template

Now that you have a completed template and a zipped configuration file, you can use the Azure CLI to deploy them. Before you deploy, validate your files to see if the deployment can succeed.

1. In Cloud Shell, run this command to validate your deployment. When prompted for a password, enter a complex password of your choice.

    ```azurecli
    az deployment group validate \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --template-file template.json \
        --parameters vmName=hostVM1 adminUsername=serveradmin
    ```

1. If your deployment is validated, the output shows information about your deployment. Pay special attention to the `error` property, which is near the beginning of the output and can be found by scrolling back through the output text. It should be `null`.

    :::image type="content" source="../media/5-error-null.png" alt-text="Screenshot of Cloud Shell showing a successful template validation with a callout highlighting the error property set to null." loc-scope="other"::: <!-- no-loc -->

    If there are no errors, your template was validated and can be deployed.

## Deploy your template

Now that you know the template is valid, you can deploy it.

1. To deploy the template, run the following command. When prompted for a password, enter the password you defined in the previous task.

    ```azurecli
    az deployment group create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --template-file template.json \
        --parameters vmName=hostVM1 adminUsername=serveradmin
    ```

    It may take several minutes for deployment to complete.

1. When the deployment is completed, you should have a virtual machine configured as an IIS web server. To confirm it has been set up, run the following command to list all of the resources in the resource group.

    ```azurecli
    az resource list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --output table \
        --query "[*].{Name:name, Type:type}"
    ```

    The output should show your host, extension, network interface, public address, virtual network, and storage account. If you see all of these resources listed, your deployment was successful.

1. Run the following command to generate the URL for your web server. The output IP address confirms that IIS was successfully installed.

    ```azurecli
    echo http://$(az vm show \
        --show-details \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name hostVM1 \
        --query publicIps \
        --output tsv)
    ```

1. Select the URL, or copy and paste it into a new browser window. You should see the default IIS page.

    :::image type="content" source="../media/5-iis-server-runs.png" alt-text="Screenshot of the default IIS page on the virtual machine that was deployed." loc-scope="other" lightbox="../media/5-iis-server-runs.png" :::

Congratulations! You successfully provisioned a web server using a Resource Manager template, and enforced a Desired State Configuration (DSC) on your virtual machine using a DSC extension handler.
