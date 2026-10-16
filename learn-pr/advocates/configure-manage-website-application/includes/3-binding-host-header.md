IIS uses bindings to associate incoming HTTP and HTTPS requests with the correct website. Each binding specifies a protocol, an IP address, a port, and an optional host name. In this unit, you configure site bindings, use host headers to host multiple sites on ports 80 and 443, enable Server Name Indication (SNI) for multiple HTTPS sites, and resolve common binding conflicts.

## How IIS routes requests using bindings

An IIS binding specifies a protocol and binding information: an IP address, a port number, and an optional host name. For HTTP and HTTPS, these components are:

- **Protocol:** HTTP or HTTPS.
- **IP address:** A specific local IP address or `*`, shown as **All Unassigned** in IIS Manager.
- **Port:** The TCP port on which the site receives requests.
- **Host name (host header):** An optional host name that IIS matches to the HTTP Host header sent by the client.

Each site must have at least one binding. Configure bindings so that requests reach the intended site without an unintended duplicate. Changing the protocol alone doesn't let ordinary HTTP and HTTPS share the same IP address and TCP port; use separate endpoints, such as ports 80 and 443.

The table lists strategies for configuring bindings:

| Strategy | How it works | Typical use |
|---|---|---|
| **Unique ports** | Each site listens on a different port (for example, 80, 8080, 8081) | Development and testing environments |
| **Multiple IP addresses** | Each site is bound to a different IP on the server's NIC | Older hosting configurations |
| **Host headers (recommended)** | Sites share an IP address and port. DNS resolves each name to that address; the client sends the HTTP Host header, and IIS uses that header and its bindings to select the site. | Named sites such as `www.contoso.com` and `www.contoso2.com` on port 80 or 443 |

For HTTPS, TLS certificate selection happens before the HTTP Host header arrives. The SNI section explains how to select certificates by host name.

> [!TIP]
> Host-name bindings let sites share an IP address and port without additional IP addresses or nonstandard ports. Ensure DNS A records are properly configured for each host name before testing the sites.

These examples use the existing `Contoso` site from the previous unit. The IIS Manager and PowerShell procedures are alternatives; don't add a binding that's already present.

Before configuring HTTPS, obtain or import a currently valid server-authentication certificate with a private key into the local computer's Personal certificate store (`Cert:\LocalMachine\My`). Confirm that its subject alternative names cover the requested DNS name and that the intended clients trust its chain. A known thumbprint identifies a certificate but doesn't by itself prove these properties.

To add and edit site bindings in IIS Manager:

1. In the **Connections** pane, select **Contoso**.
1. In the **Actions** pane, select **Bindings**.
1. In the **Site Bindings** dialog, select **Add**.
1. In the **Add Site Binding** dialog, configure:
   - **Type:** Select **http** or **https**.
   - **IP address:** Select **All Unassigned** or a specific IP.
   - **Port:** Enter `80` for HTTP or `443` for HTTPS.
   - **Host name:** Enter the intended host name, for example `www.contoso.com`. Use distinct host-name bindings to distinguish HTTP sites that share the same IP address and port. Sites using different IP addresses can use the same port without relying on host names for that distinction.
   - For HTTPS bindings, select the installed certificate. For hostname-based certificate selection on a shared IP address and port, follow the SNI procedure in the next section.
1. Select **OK**, then **Close**.

To edit an existing binding, select it in the list and select **Edit**. To remove a binding, select it and select **Remove**. Removing the only binding makes the site inaccessible.

Manage bindings in PowerShell with the `WebBinding` cmdlets. First, list the site's existing bindings:

```powershell
Import-Module WebAdministration -ErrorAction Stop
Get-WebBinding -Name 'Contoso' -ErrorAction Stop
```

To add the following HTTP host-name binding, run this example only if the binding isn't already present:

```powershell
Import-Module WebAdministration -ErrorAction Stop
New-WebBinding -Name 'Contoso' -Protocol 'http' `
    -Port 80 -HostHeader 'www.contoso.com' -IPAddress '*' -ErrorAction Stop
```

To add a traditional HTTPS binding, run this example only if the exact binding isn't already present. It uses IP:port certificate selection rather than SNI:

```powershell
Import-Module WebAdministration -ErrorAction Stop
New-WebBinding -Name 'Contoso' -Protocol 'https' `
    -Port 443 -HostHeader 'www.contoso.com' -IPAddress '*' `
    -SslFlags 0 -ErrorAction Stop
```

Associate one verified certificate with the exact HTTPS binding `*:443:www.contoso.com`. For a non-SNI binding, first confirm that changing the certificate on its IP:port endpoint is intended and won't replace a certificate relied on by another site. For different certificates on a shared IP address and port, use the SNI workflow in the next section instead.

```powershell
Import-Module WebAdministration -ErrorAction Stop
$siteName = 'Contoso'
$hostName = 'www.contoso.com'
$bindingInformation = "*:443:$hostName"
$thumbprint = (Read-Host 'Enter the verified certificate thumbprint') -replace '\s', ''
if ($thumbprint -notmatch '^[0-9A-Fa-f]{40}$') {
    throw 'Enter the 40 hexadecimal characters of the certificate thumbprint.'
}
$cert = Get-Item -LiteralPath "Cert:\LocalMachine\My\$thumbprint" -ErrorAction Stop
$now = Get-Date
if (-not $cert.HasPrivateKey -or $cert.NotBefore -gt $now -or $cert.NotAfter -le $now) {
    throw 'The certificate must have a private key and be within its validity period.'
}
$bindings = @(Get-WebBinding -Name $siteName -Protocol 'https' -ErrorAction Stop |
    Where-Object { $_.bindingInformation -eq $bindingInformation })
if ($bindings.Count -ne 1) {
    throw "Expected exactly one HTTPS binding for $siteName at $bindingInformation."
}
$bindings[0].AddSslCertificate($cert.Thumbprint, 'My')
```

From an intended client, verify that `https://www.contoso.com/` returns the expected site's content with the intended certificate and no name, trust, or expiry error. Don't disable certificate validation to make the test pass.

To remove only the HTTP binding shown earlier, use the following command. Don't run it if you need to retain that endpoint, for example to redirect HTTP requests to HTTPS:

```powershell
Import-Module WebAdministration -ErrorAction Stop
Remove-WebBinding -Name 'Contoso' -Protocol 'http' `
    -Port 80 -HostHeader 'www.contoso.com' -IPAddress '*' -ErrorAction Stop
```

## Server Name Indication (SNI) for multiple HTTPS sites

The TLS handshake occurs before the HTTP Host header is transmitted, so that header can't select the server certificate. With SNI, a supporting client sends the requested server name during TLS negotiation, allowing IIS to select a certificate by host name. Modern browsers support SNI; verify support in any other clients that need to use your sites.

To enable SNI in IIS Manager:

1. Open the **Add Site Binding** or **Edit Site Binding** dialog for an HTTPS binding.
1. Enter the intended **Host name**.
1. Select **Require Server Name Indication**.
1. Select the appropriate certificate.
1. Select **OK**.

> [!NOTE]
> Traditional IP:port HTTPS bindings and SNI hostname:port bindings are designed to coexist. A non-SNI binding uses the certificate associated with its IP:port endpoint. In either case, the certificate presented to the client must be valid for the requested host name.
>
> Use SNI when the deployment requires hostname-based certificate selection on a shared IP address and port. Mixing traditional and SNI bindings doesn't inherently create a conflict. Check the actual IIS and HTTP.sys binding configuration when troubleshooting.

For the following PowerShell example, the `Contoso2` site must already exist, and `www.contoso2.com` must resolve to this server. Install a currently valid server-authentication certificate with a private key in `Cert:\LocalMachine\My`, verify that its subject alternative names cover `www.contoso2.com`, and confirm that the intended clients trust its chain.

The example creates the exact SNI binding only if it's absent and reuses it only when `sslFlags` is `1`. It stops instead of overwriting different TLS settings. This guard prevents duplicate IIS bindings; it isn't an automated certificate-renewal workflow. Inspect an existing endpoint's certificate registration before changing it.

```powershell
Import-Module WebAdministration -ErrorAction Stop
$siteName = 'Contoso2'
$hostName = 'www.contoso2.com'
if (-not (Test-Path -LiteralPath 'IIS:\Sites\Contoso2' -ErrorAction Stop)) {
    throw 'Create the Contoso2 site before adding its HTTPS binding.'
}
$bindingInformation = "*:443:$hostName"
$existingBindings = @(Get-WebBinding -Name $siteName -Protocol 'https' -ErrorAction Stop |
    Where-Object { $_.bindingInformation -eq $bindingInformation })
if ($existingBindings.Count -gt 1) {
    throw "More than one HTTPS binding matches $bindingInformation. Inspect the configuration."
}
if ($existingBindings.Count -eq 0) {
    # SslFlags: 0 = no SNI, 1 = SNI, 2 = central certificate store
    New-WebBinding -Name $siteName -Protocol 'https' -Port 443 `
        -HostHeader $hostName -IPAddress '*' -SslFlags 1 -ErrorAction Stop
}
elseif ($existingBindings[0].sslFlags -ne 1) {
    throw "The binding at $bindingInformation has different TLS settings. Inspect them before continuing."
}

$thumbprint = (Read-Host 'Enter the verified certificate thumbprint') -replace '\s', ''
if ($thumbprint -notmatch '^[0-9A-Fa-f]{40}$') {
    throw 'Enter the 40 hexadecimal characters of the certificate thumbprint.'
}
$cert = Get-Item -LiteralPath "Cert:\LocalMachine\My\$thumbprint" -ErrorAction Stop
$now = Get-Date
if (-not $cert.HasPrivateKey -or $cert.NotBefore -gt $now -or $cert.NotAfter -le $now) {
    throw 'The certificate must have a private key and be within its validity period.'
}
$bindings = @(Get-WebBinding -Name $siteName -Protocol 'https' -ErrorAction Stop |
    Where-Object { $_.bindingInformation -eq $bindingInformation })
if ($bindings.Count -ne 1) {
    throw "Expected exactly one HTTPS binding for $siteName at $bindingInformation."
}
$bindings[0].AddSslCertificate($cert.Thumbprint, 'My')
```

If certificate association fails, stop and use the binding-conflict workflow at the end of this unit to inspect the configuration. Don't delete HTTP.sys registrations indiscriminately.

From an intended client, verify that `https://www.contoso2.com/` returns the expected site's content with the intended certificate and no name, trust, or expiry error. Don't disable certificate validation to make the test pass.

For more information, see [SNI certificate selection and coexistence](/iis/get-started/whats-new-in-iis-8/iis-80-server-name-indication-sni-ssl-scalability).

## Enforcing HTTPS with HTTP Strict Transport Security (HSTS)

IIS 10 on Windows Server 2019 and later supports native configuration of HTTP Strict Transport Security (HSTS). After a supporting browser receives a valid HSTS header over HTTPS, it upgrades subsequent HTTP attempts to HTTPS for the advertised `max-age`. A later HSTS response refreshes that policy lifetime. Unless an applicable preload policy is already present in the browser, HSTS doesn't protect the first HTTP connection. Clients that don't enforce HSTS aren't protected by this policy.

HSTS is separate from a server-side HTTP-to-HTTPS redirect. A redirect helps clients reach HTTPS, but the initial HTTP request is still clear text.

These alternatives configure a new lab policy on the existing `Contoso` site on Windows Server 2019 or later. Use a controlled test hostname, and first establish and test trusted HTTPS on port 443. Stop if HSTS is already enabled; changing an existing policy requires a separate plan. Don't weaken a production policy just to run this example.

> [!IMPORTANT]
> Enable `includeSubDomains` only when every affected subdomain of the policy host supports HTTPS. A policy sent by `www.contoso.com` applies to that host and its subdomains, not automatically to sibling hosts such as `api.contoso.com`.
>
> Leave `preload` disabled for this lab. Adding the directive doesn't submit or enroll a domain in browser preload lists. Production preloading requires a deliberate enrollment decision and satisfaction of the preload program's requirements.
>
> IIS's native `redirectHttpToHttps` ignores a nonstandard port in the original URI. Confirm that the destination serves valid HTTPS on port 443 before enabling it. A site that serves HTTPS only on another port needs a different redirection design.
>
> Start with a short test policy and increase `max-age` only after validating the deployment. Disabling the server setting doesn't immediately remove policies already cached by clients. Retain working HTTPS while changing or retiring a policy.

To configure this new lab policy in IIS Manager:

1. Select **Contoso**.
1. In the **Actions** pane, select **HSTS**.
1. If **Enable** is already selected, stop and review the existing policy instead of replacing it. For a new policy, select **Enable**, then configure:
   - **max-age:** Enter `300`, the number of seconds browsers remember this initial test policy.
   - **includeSubDomains:** Leave this option cleared.
   - **preload:** Leave this option cleared.
   - **redirectHttpToHttps:** Select this option after testing HTTPS on port 443.
1. Review the settings, then select **OK** to apply the new policy.

To configure the same new lab policy using PowerShell:

```powershell
Import-Module IISAdministration -ErrorAction Stop
$siteName = 'Contoso'
$sites = Get-IISConfigSection -SectionPath 'system.applicationHost/sites' `
    -ErrorAction Stop | Get-IISConfigCollection -ErrorAction Stop
$site = Get-IISConfigCollectionElement -ConfigCollection $sites `
    -ConfigAttribute @{ name = $siteName } -ErrorAction Stop
if ($null -eq $site) {
    throw "The IIS site does not exist: $siteName"
}
$hstsElement = Get-IISConfigElement -ConfigElement $site `
    -ChildElementName 'hsts' -ErrorAction Stop
if (Get-IISConfigAttributeValue -ConfigElement $hstsElement `
        -AttributeName 'enabled' -ErrorAction Stop) {
    throw 'Review the existing HSTS policy instead of replacing it with lab settings.'
}
Set-IISConfigAttributeValue -ConfigElement $hstsElement `
    -AttributeName 'max-age' -AttributeValue 300 -ErrorAction Stop
Set-IISConfigAttributeValue -ConfigElement $hstsElement `
    -AttributeName 'includeSubDomains' -AttributeValue $false -ErrorAction Stop
Set-IISConfigAttributeValue -ConfigElement $hstsElement `
    -AttributeName 'preload' -AttributeValue $false -ErrorAction Stop
Set-IISConfigAttributeValue -ConfigElement $hstsElement `
    -AttributeName 'redirectHttpToHttps' -AttributeValue $true -ErrorAction Stop
Set-IISConfigAttributeValue -ConfigElement $hstsElement `
    -AttributeName 'enabled' -AttributeValue $true -ErrorAction Stop
```

The 300-second lifetime is an initial lab or staging value, not a universal production recommendation. The options are configured before this new policy is enabled. `Start-IISCommitDelay` and `Stop-IISCommitDelay` can optionally batch updates, but individual setter calls don't require them.

Inspect an HTTPS response for `Strict-Transport-Security: max-age=300`. Inspect an HTTP response without following redirects and verify that its `Location` uses the intended host and HTTPS port 443.

Enable HSTS only when application content is fully available over HTTPS. You can retain an HTTP binding solely to redirect clients to HTTPS. Misconfiguration can prevent clients from accessing the site if HTTPS isn't working.

For more information, see [IIS HSTS configuration](/iis/configuration/system.applicationhost/sites/site/hsts).

## Resolve binding conflicts

Use this workflow to identify the affected binding before making a targeted correction:

1. In IIS Manager, inspect **Bindings** for the affected site. Compare its protocol, IP address, port, host name, and SNI setting with other sites.
1. Inventory the stored bindings without changing them:

   ```powershell
   Import-Module WebAdministration -ErrorAction Stop
   Get-Website -ErrorAction Stop | ForEach-Object {
       $siteName = $_.Name
       Get-WebBinding -Name $siteName -ErrorAction Stop |
           Select-Object @{ Name = 'Site'; Expression = { $siteName } },
               protocol, bindingInformation, sslFlags
   }
   ```

1. For HTTPS certificate-selection problems, inspect HTTP.sys registrations:

   ```powershell
   netsh.exe http show sslcert
   ```

   Compare the certificate thumbprint and store for the relevant IP:port or hostname:port registration with the intended certificate.

1. Distinguish a genuine duplicate or incorrect registration from valid coexistence of traditional and SNI bindings. Confirm the intended certificate and host-name ownership before changing anything.
1. Correct only the identified site's binding through **Bindings** > **Edit** or the exact corresponding management command. Don't delete all SSL registrations, stop the shared HTTP service, or remove unrelated sites.
1. Test each affected host name from an intended client. Confirm the expected content and, for HTTPS, the intended certificate with no name, trust, or expiry error. Recheck unaffected sites that share the server.
