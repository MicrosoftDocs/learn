# Add IIS, CGI, and IIS Manager to the web server
Install-WindowsFeature -Name "Web-Server";
Install-WindowsFeature -Name "Web-CGI";
Install-WindowsFeature -Name "Web-Mgmt-Console";

# Install the WebPlatform installer
New-Item -ItemType Directory -Path 'c:\temp\wpi'
Invoke-WebRequest -Uri 'https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_amd64_en-US.msi' -OutFile 'c:\temp\wpi\WebPlatformInstaller_amd64_en-US.msi'
Start-Process msiexec.exe -Wait -ArgumentList '/I c:\temp\wpi\WebPlatformInstaller_amd64_en-US.msi /quiet'

# Install PHP
& (Join-Path "$env:programfiles" "microsoft\Web Platform Installer\webpicmd.exe") /Install /Products:"PHP72x64,VC12Redist" /AcceptEula

# Add index.php to the Default Documents.
Add-WebConfiguration -Filter /system.webServer/defaultDocument/files -AtIndex 0 -PSPath IIS:\ -Value @{value="index.php"}

# remove the default IIS page
Remove-Item -Path C:\inetpub\wwwroot\iisstart.htm -Force

# Create index.php
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