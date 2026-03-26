IIS uses a combination of IP address, TCP port, and host name (host header) to route incoming HTTP and HTTPS requests to the correct website. When you host multiple sites on a single server, bindings are what allow IIS to distinguish between them. In this unit, you configure site bindings, use host headers to host multiple sites on port 80 and 443, enable Server Name Indication (SNI) for multiple HTTPS sites, and resolve common binding conflicts.

## How IIS routes requests using bindings

When a request arrives at the server, IIS evaluates three binding components in order:

1. **IP address:** Does this request target an IP address assigned to this site? An asterisk (\*) means any unassigned IP.
1. **Port:** Does the request arrive on the port configured for this site?
1. **Host name (host header):** Does the HTTP Host header value in the request match the host name configured for this binding?

A binding is the combination of these three values. Each site must have at least one binding. Bindings must be unique across all sites, IIS can't start two sites that share the same IP, port, and host name.

The table lists strategies for handing bindings:

| **Strategy** | **How It Works** | **Typical Use** |
|---|---|---|
| **Unique ports** | Each site listens on a different port (for example, 80, 8080, 8081) | Development and testing environments |
| **Multiple IP addresses** | Each site is bound to a different IP on the server's NIC | Older hosting configurations |
| **Host headers (recommended)** | All sites share IP and port; DNS differentiates them via the Host header | Production: `www.site1.com` and `www.site2.com` on port 80/443 |

> [!TIP]
> Host headers are the standard approach in production because they don't require additional IP addresses or nonstandard ports. Ensure DNS A records are properly configured for each host name before starting sites.

To add and edit site bindings in IIS Manager, perform the following steps:

1. In the Connections pane, select the site (for example, Contoso).
1. In the Actions pane, select Bindings.
1. In the Site Bindings dialog, select Add.
1. In the Add Site Binding dialog, configure:
   - Type: Select http or https.
   - IP address: Select All Unassigned or a specific IP.
   - Port: Enter 80 (for HTTP) or 443 (for HTTPS).
   - Host name: Enter the FQDN, for example `www.contoso.com`. Required when sharing a port with other sites.
   - For HTTPS bindings: select the certificate from the drop-down.
1. Select OK, then Close.

To edit an existing binding: select it in the list and select Edit. To remove a binding: select it and select Remove. Removing the only binding makes the site inaccessible.

You managing bindings in PowerShell with the `WebBinding` cmdlets. For example:

```powershell
# Add an HTTP binding with a host header
New-WebBinding -Name "Contoso" -Protocol "http" `
               -Port 80 -HostHeader "www.contoso.com" -IPAddress "*"
# Add an HTTPS binding
New-WebBinding -Name "Contoso" -Protocol "https" `
               -Port 443 -HostHeader "www.contoso.com" -IPAddress "*"
# List all bindings for a site
Get-WebBinding -Name "Contoso"
# Remove a specific binding
Remove-WebBinding -Name "Contoso" -Protocol "http" `
                  -Port 80 -HostHeader "www.contoso.com"
```

After adding an HTTPS binding via PowerShell, assign the certificate to the binding:

```powershell
$cert = Get-ChildItem -Path "Cert:\LocalMachine\My" |
        Where-Object { $_.Subject -like "*contoso.com*" }
$binding = Get-WebBinding -Name "Contoso" -Protocol "https"
$binding.AddSslCertificate($cert.Thumbprint, "My")
```

## Server Name Indication (SNI) for multiple HTTPS sites

Before SNI, hosting multiple HTTPS sites on a single IP address required a separate IP per site. The TLS handshake occurs before the HTTP Host header is transmitted, so IIS couldn't select the correct certificate. SNI resolves this: during the TLS handshake, the client sends the target hostname, allowing IIS to select the correct certificate for each site. All modern browsers and clients support SNI.

To enable SNI in IIS Manager:

1. Open the Add Site Binding or Edit Site Binding dialog for an HTTPS binding.
1. Check the Require Server Name Indication checkbox.
1. Select the appropriate certificate.
1. Select OK.

> [!NOTE]
> Every HTTPS site sharing the same IP and port 443 must have SNI enabled. If even one site on that IP/port doesn't use SNI, it conflicts with the others.

To enabling SNI with PowerShell, use the `WebBinding` cmdlets. For example:

```powershell
# SslFlags: 0 = no SNI, 1 = SNI, 2 = central certificate store
New-WebBinding -Name "Contoso2" `
               -Protocol "https" `
               -Port 443 `
               -HostHeader "www.contoso2.com" `
               -IPAddress "*" `
               -SslFlags 1
```

## Enforcing HTTPS with HTTP Strict Transport Security (HSTS)

To further enhance the security of HTTPS-enabled websites, IIS 10 on Windows Server 2019 and later supports native configuration of HTTP Strict Transport Security (HSTS). HSTS instructs browsers to always use HTTPS when connecting to your site, even if a user attempts to access it via HTTP. This helps prevent protocol downgrade attacks and ensures encrypted communication for all future requests.

To configure HSTS in IIS Manager:

1. Open IIS Manager and select the target site.
2. In the Actions pane, select **HSTS…**.
3. Check **Enable**.
4. Configure the following options as needed:
   - **max-age:** Duration (in seconds) that browsers should remember to enforce HTTPS (for example, `31536000` for one year).
   - **includeSubDomains:** Applies the policy to all subdomains.
   - **preload:** Indicates intent to submit the domain to the HSTS preload list.
   - **redirectHttpToHttps:** Automatically redirects HTTP requests to HTTPS.

To configure HSTS using PowerShell:

```powershell
# Set the site name
$siteName = "Contoso"
# Enable HSTS
Set-IISConfigAttributeValue -ConfigElement (
    Get-IISConfigElement -ConfigElement (
        Get-IISConfigCollectionElement -ConfigCollection (
            Get-IISConfigSection -SectionPath "system.applicationHost/sites" | Get-IISConfigCollection
        ) -ConfigAttribute @{"name"=$siteName}
    ) -ChildElementName "hsts"
) -AttributeName "enabled" -AttributeValue $true
# Set max-age to 1 year
Set-IISConfigAttributeValue -ConfigElement ... -AttributeName "max-age" -AttributeValue 31536000
# Enable includeSubDomains, preload, and redirectHttpToHttps
Set-IISConfigAttributeValue ... -AttributeName "includeSubDomains" -AttributeValue $true
Set-IISConfigAttributeValue ... -AttributeName "preload" -AttributeValue $true
Set-IISConfigAttributeValue ... -AttributeName "redirectHttpToHttps" -AttributeValue $true
```

> [!NOTE]
> HSTS should only be enabled on sites that are fully HTTPS-enabled and don't serve any content over HTTP. Misconfiguration can result in clients being unable to access your site if HTTPS isn't properly configured.
