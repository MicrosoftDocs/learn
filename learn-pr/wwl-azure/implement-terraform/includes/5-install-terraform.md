To get started, you must install Terraform on the machine from which you're running the Terraform commands.

Terraform can be installed on Windows, Linux, or macOS environments. Go to the [Download Terraform](https://www.terraform.io/downloads.html) page and choose the appropriate download package for your environment.

## Windows operating system

If you download Terraform for the Windows operating system:

1.  Find the install package, which is bundled as a zip file.
2.  Copy files from the zip to a local directory such as C:\\terraform. It's the Terraform `PATH`, so make sure that the Terraform binary is available on the `PATH`.
3.  To set the PATH environment variable, run the command **set PATH=%PATH%;C:\\terraform**, or point to wherever you've placed the Terraform executable.
4.  Open an administrator command window at `C:\Terraform` and run the command **Terraform** to verify the installation. You should view the terraform help output.

    :::image type="content" source="../media/terraform-windows-cli-bba8d230.png" alt-text="Screenshot of a Windows CLI with the command Terraform run and the help output displayed":::


## Linux

1.  Download Terraform using the following command:
    
    ```Bash
    wget https://releases.hashicorp.com/terraform/0.xx.x/terraform_0.xx.x_linux_amd64.zip
    
    ```

2.  Install Unzip using the command:
    
    ```Bash
    sudo apt-get install unzip
    
    ```

3.  Unzip and set the path using the command:
    
    ```Bash
    unzip terraform_0.11.1_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    
    ```

4.  Verify the installation by running the command **Terraform**. Verify that the Terraform helps output displays.

    :::image type="content" source="../media/terraform-linux-cli-bbc59b70.png" alt-text="Screenshot of a Linux bash with the command Terraform run and the help output displayed":::


## Authenticating Terraform with Azure

Terraform supports several different methods for authenticating to Azure. You can use:

 -  The Azure CLI
 -  A Managed Service Identity (MSI)
 -  A service principal and a client certificate
 -  A service principal and a client secret

When running Terraform as part of a continuous integration pipeline, you can use either an Azure service principal or MSI to authenticate.

To configure Terraform to use your Azure Active Directory (Azure AD) service principal, set the following environment variables:

 -  ARM\_SUBSCRIPTION\_ID
 -  ARM\_CLIENT\_ID
 -  ARM\_CLIENT\_SECRET
 -  ARM\_TENANT\_ID
 -  ARM\_ENVIRONMENT

The Azure Terraform modules then use these variables. You can also set the environment if you work with an Azure cloud other than an Azure public cloud.

Use the following sample shell script to set these variables:

```Bash
#!/bin/sh
echo "Setting environment variables for Terraform"
export ARM_SUBSCRIPTION_ID=your_subscription_id
export ARM_CLIENT_ID=your_appId
export ARM_CLIENT_SECRET=your_password
export ARM_TENANT_ID=your_tenant_id

# Not needed for public, required for usgovernment, german, china
export ARM_ENVIRONMENT=public

```

> [!NOTE]
> After you install Terraform before you can apply config .tf files, you must run the following command to initialize Terraform for the installed instance:

```Yml
Terraform init

```
