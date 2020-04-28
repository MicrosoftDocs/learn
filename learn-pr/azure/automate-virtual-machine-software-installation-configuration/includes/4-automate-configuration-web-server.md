In the previous exercise, you learned how to create a virtual machine using a base image that was provided by Azure. However, since the base image didn't have a web server installed by default, your next task is to research how to automate the installation of a web server when you create your virtual machines.

Azure provides several options for Linux and Windows virtual machines to help you create your required configuration.

- For Linux virtual machines, the `az vm create` command allows you to provide a *cloud-init* configuration file with your requisite installation instructions.

- For Windows virtual machines, the `az vm extension` command allows you to provide a PowerShell script to apply your necessary configuration changes.

Your operations team manages dynamic websites on both Windows and Linux virtual machines, and your team doesn't consider that a virtual machine is deployed and ready to use until they can view a PHP page that uses the `phpinfo()` function to demonstrate that a web server and PHP have been installed and configured correctly.

In this unit, you'll learn about the steps you'll to automate the installation of a web server that runs PHP on a virtual machine.

::: zone pivot="linux-cloud"

## Using cloud-init to install Nginx on a Linux virtual machine

**Cloud-init** is a GitHub-based project that was originally developed by Canonical to help them initialize Ubuntu machines. Cloud-init now supports most of the major Linux distributions, and it is cloud-aware, meaning that you can configure machines based on metadata that is read from cloud providers.

The core features of cloud-init that your team needs to use are:

- Specify additional packages to install

- Create files and with custom contents

- Run additional Linux commands

Cloud-init uses a simple configuration file in YAML format. To customize the installation of your Linux virtual machine, you create a YAML file that specifies the tasks that you want to run as part of the installation process for your virtual machine. You supply this configuration file to the `az cm create` command, and cloud-init will use it to initialize your virtual machine.

### Use cloud-init to install and configure Nginx

On Linux, you use the Advanced Package Tool (`apt`) management system on the command line to manage and install additional software. To customize your Linux virtual machine creation, you add the names of the packages that you would add with the `apt` command to your cloud-init configuration file, and cloud-init will take care of the rest. There's also a useful configuration setting that updates the packages that are installed on your virtual machine, and retrieves the latest list of available packages.

For example, following excerpt from a cloud-init configuration file updates the software packages that have already been installed, and installs the Nginx package for the Linux distribution that you're using:

```yaml
package_upgrade: true
packages:
  - nginx
```

As part of your Nginx installation, you can configure additional options, such as configuring Nginx to respond to HTTP requests with a default webpage. For example: the following configuration excerpt instructs cloud-init to create a path `/etc/nginx/sites-available/default` and sets the owner to `www-data`, then it tells Nginx to listen on port 80 and look for files in the `/home/azureuser/serverInfo` folder.

```yaml
write_files:
  - owner: www-data:www-data
    path: /etc/nginx/sites-available/default
    content: |
        server {
            listen 80 default_server;
            listen [::]:80 default_server;
            root /home/azureuser/serverInfo;
            index index.php index.html index.htm;
            location / {
                try_files $uri $uri/ =404;
            }
        }
```

### Use cloud-init to install and configure PHP

In order to configure cloud-init to install PHP, you need to modify your cloud-init file to include the list of PHP packages you need. For example: the following configuration excerpt instructs cloud-init to install version 7.2 of PHP and the FastCGI Process Manager (FPM), which will enable Nginx to process PHP code in webpages.

```yaml
package_upgrade: true
packages:
  - nginx
  - php7.2  
  - php7.2-fpm
```

Now that you've instructed cloud-init to install PHP, you need to modify your cloud-init file to configure Nginx to process PHP pages. For example: the following configuration excerpt adds FastCGI definitions for Nginx that instruct it to process webpages ending in php with the package you just installed.

```yaml
write_files:
  - owner: www-data:www-data
    path: /etc/nginx/sites-available/default
    content: |
        server {
            listen 80 default_server;
            listen [::]:80 default_server;
            root /home/azureuser/serverInfo;
            index index.php index.html index.htm;
            location / {
                try_files $uri $uri/ =404;
            }
            location ~* \.php$ {
                fastcgi_index   index.php;
                fastcgi_pass    unix:/run/php/php7.2-fpm.sock;
                include         fastcgi_params;
                fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
                fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
            }        
        }
```

Once you have configured all of the preceding options, your cloud-init configuration is ready to set up a web server that can use use Nginx to process PHP requests.

### Use cloud-init to create a default webpage

Thus far you have created a cloud-init file that has the necessary settings for installing the Nginx web server and PHP, and configuring Nginx to run PHP pages. Your remaining task is to instruct cloud-init to create a default status page for your web server, which uses the `write-files` syntax that you saw earlier to create a *index.php* file. For example: the following configuration excerpt instructs cloud-init to create a default status page at `/home/azureuser/serverInfo/index.php`.

```yaml
  - owner: azureuser:azureuser
    path: /home/azureuser/serverInfo/index.php
    content: |
        <!DOCTYPE html>
        <html lang="en">
            <head>
                <meta charset="UTF-8">
                <title>PHP Status Page</title>
                <meta name="description" contents="Default home page for deployed virtual machines">
            </head>
            <body>
              <div>
                <h2>Client information</h2>
                <p><strong>Browser client:</strong><?php echo $_SERVER['HTTP_USER_AGENT']; ?></p>
              </div>
              <div>
                <h2>Server information</h2>
                <p><strong>PHP info:</strong></p>
                <div>
                  <?php phpinfo(); ?>
                </div>
              </div>
              <footer>
                  Server name: <?php echo php_uname("n"); ?>
              </footer>
            </body>
        </html>
```

As a final step, you should restart Nginx and the FastCGI Process Manager to ensure that the configuration is loaded correctly by Nginx, and that the PHP service is ready to process requests. For example: the following configuration excerpt instructs cloud-init to restart the reqsuite services.

```yaml
runcmd:
  - service nginx restart
  - service php7.2-fpm restart
```

In the next exercise, you will use the knowledge from this unit to install Nginx and PHP on a Linux virtual machine.

::: zone-end

::: zone pivot="windows-cloud"

## Using PowerShell to install IIS on a Windows virtual machine

Azure makes it easy for you to automate the configuration of your Windows virtual machine by calling a Azure CLI command that runs a custom PowerShell script. This Azure CLI functionality enables you to take advantage of PowerShell's features to install and configure the software you need.

The relevant PowerShell commands that you can use when setting up your virtual machine are:

| Command | Description |
| --- | --- |
| `Add-WindowsFeature` | Allows you to install Windows features, such as IIS. |
| `Invoke-WebRequest` | Allows you to download additional software via the web. |
| `Add-WebConfiguration` | Allows you to configure IIS. |
| `Remove-Item` and `New-Item` | Allows you to delete and create files. |

When you are setting up your Windows virtual machines, you'll add custom commands with the installation and configuration steps for your virtual machines to a PowerShell script, and then you'll run the `az vm extension` command to run your script.

### Using PowerShell to install and configure IIS

As you learned in the previous exercise, when you've created a new virtual machine, it doesn't have IIS and the CGI components installed. However, Windows Server has a PowerShell cmdlet to add additional features to Windows. The following PowerShell commands install IIS, then the FastCGI component (which is necessary for PHP), and then the IIS Manager:

```powershell
Install-WindowsFeature -Name "Web-Server";
Install-WindowsFeature -Name "Web-CGI";
Install-WindowsFeature -Name "Web-Mgmt-Console";
```

After you have installed IIS with the components you need, you need to configure IIS to use a default PHP webpage. The following PowerShell command adds *index.php* to the list of default webpages:

```powershell
Add-WebConfiguration -Filter /system.webServer/defaultDocument/files -AtIndex 0 -PSPath IIS:\ -Value @{value="index.php"}
```

> [!NOTE]
>
> Like many web servers, IIS uses a list of default files to return when a web client requests a folder path on the web server without a specific page. Adding *index.php* to the list of default webpages means that web clients do not have to explicitly add a page name to root-level requests.

### Using PowerShell to install and configure PHP

There are several options for installing and configuring PHP with IIS. For example, you *could* log into your virtual machine after it has been created and run the installation process manually, but that would not fullfill your team's desire to automate the installation and configuration of your virtual machines.

One of the easiest ways to install extra features on IIS is to use the Web Platform Installer (WPI), which you can use to install PHP. The WPI will install PHP, as well as any necessary dependencies. While the WPI can be run interactively, you can also automate the WPI with PowerShell.

In simplest terms, the process for installing the WPI consists of three steps:

1. Creating a temporary directory for downloading files

1. Downloading the MSI file for WPI from Microsoft

1. Automating the installation of WPI

The following PowerShell commands accomplish the steps listed above to install the WPI:

```powershell
New-Item -ItemType Directory -Path 'c:\temp\wpi'

Invoke-WebRequest -Uri 'https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_amd64_en-US.msi' -OutFile 'c:\temp\wpi\WebPlatformInstaller_amd64_en-US.msi'

Start-Process msiexec.exe -Wait -ArgumentList '/I c:\temp\wpi\WebPlatformInstaller_amd64_en-US.msi /quiet'
```

After WPI has been downloaded and installed onto your virtual machine, you can use WPI's `webpicmd.exe` command-line tool to install PHP and the Visual C++ runtime:

```powershell
& (Join-Path "$env:programfiles" "microsoft\Web Platform Installer\webpicmd.exe") /Install /Products:"PHP72x64,VC12Redist" /AcceptEula
```

### Using PowerShell to create a default webpage

Thus far you have created a PowerShell script that has the necessary settings for installing IIS and PHP, and configuring IIS to run PHP pages. Your remaining task is to instruct PowerShell to create a default status page for your web server, which uses the `New-Item` cmdlet to create a *index.php* file. For example: the following configuration excerpt instructs PowerShell to create a default status page at `C:\inetpub\wwwroot\index.php`.

```powershell
New-Item -ItemType File -Path "C:\inetpub\wwwroot\" -Name index.php -Value @'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>PHP Status Page</title>
    <meta name="description" contents="Default home page for deployed virtual machines">
  </head>
  <body>
    <div>
      <h2>Client information</h2>
      <p><strong>Browser client:</strong><?php echo $_SERVER['HTTP_USER_AGENT']; ?></p>
    </div>
    <div>
      <h2>Server information</h2>
      <p><strong>PHP info:</strong></p>
      <div>
        <?php phpinfo(); ?>
      </div>
    </div>
    <footer>
        Server name: <?php echo php_uname("n"); ?>
    </footer>
  </body>
</html>
'@
```

The **C:\inetpub\wwwroot** folder also contains an *iisstart.htm* file by default, which IIS will use to respond to web requests. The easiest way to prevent that HTML file being used instead of your new *index.php* file is to delete it using PowerShell's `Remove-Item` cmdlet:

```powershell
Remove-Item -Path C:\inetpub\wwwroot\iisstart.htm -Force
```

In the next exercise, you will use the knowledge from this unit to install IIS and PHP on a Windows virtual machine.

::: zone-end
