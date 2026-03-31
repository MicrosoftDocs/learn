Unencrypted HTTP communication can be intercepted, read, or modified by anyone on the network path between client and server. A way of mitigating this is using SSL/TLS certificates to enable HTTPS communication. An SSL/TLS certificate is a digital credential that enables HTTPS by providing server authentication and encryption of data in transit using public-key cryptography.

The following table lists common certificate types:

| **Type** | **Description** | **Use case** |
|---|---|---|
| Domain Validation (DV) | Verifies domain ownership only | General-purpose public websites |
| Organization Validation (OV) | Verifies domain and organization identity | Business websites |
| Extended Validation (EV) | Thorough identity verification | High-assurance sites |
| Wildcard | Covers a domain and all first-level subdomains (\*.contoso.com) | Multiple subdomains |
| SAN (Subject Alternative Name) | Single certificate for multiple specific domain names | Multi-domain hosting |

For production environments you can obtain a certificate from the following locations:

- Public Certificate Authority (CA): Obtain a certificate from a trusted public CA. The certificate will be trusted by all standard browsers without additional client configuration.
- Internal (Enterprise) CA: If you have Active Directory Certificate Services (AD CS), you can issue certificates from your internal CA. These are automatically trusted by domain-joined machines but won't be trusted by non-domain-joined machines unless you take special steps.

To request a certificate or generate a certificate request file:

1. In IIS Manager, select the server node in the Connections pane.
1. Double-select Server Certificates in the Features View.
1. In the Actions pane, choose:
   - Create Domain Certificate: For requesting from an internal Active Directory Enterprise CA.
   - Create Certificate Request: To generate a CSR for submission to a public CA.
   - Create Self-Signed Certificate: For development/testing only—not trusted by browsers.
1. Provide the necessary certificate details.

## Installing a certificate

If your computer is domain joined and you have requested a certificate from an Enterprise CA, then the certificate is deployed through Active Directory.

If you received a certificate from a public CA as a .pfx file:

1. In IIS Manager, select the server node.
1. Double-select Server Certificates.
1. In the Actions pane, select Import.
1. Enter the path to the .pfx file, enter the password, and optionally check Allow this certificate to be exported.
1. Select OK.

You can import a PFX certificate using the Import-PfxCertificate PowerShell cmdlet. For example, to import the `www.contoso.com.pfx` certificate with the password DoNotUsePlainTextCertificatePasswordsInCodeEverThisIsAnExample123, run the following code:

```powershell
# Import a PFX certificate into the Local Machine Personal certificate store
$certPath = "C:\certs\www.contoso.com.pfx"
$certPassword = ConvertTo-SecureString -String "DoNotUsePlainTextCertificatePasswordsInCodeEverThisIsAnExample123" -AsPlainText -Force
Import-PfxCertificate -FilePath $certPath `
    -CertStoreLocation Cert:\LocalMachine\My `
    -Password $certPassword
```

## Server name indication (SNI)

SNI is a TLS extension that allows the client to specify the target hostname at the beginning of the TLS handshake. This enables IIS to host multiple HTTPS sites on a single IP address, each with its own certificate.

Without SNI, IIS can only present one certificate per IP/port combination. With SNI, IIS selects the appropriate certificate based on the hostname in the client's request.

> [!TIP]
> When adding HTTPS bindings for multiple sites on the same IP address, always enable Require Server Name Indication to ensure the correct certificate is presented for each site.

## Configuring HTTPS bindings

Once a certificate is installed, you should create an HTTPS binding for your site to associate the certificate with incoming connections on port 443. To add an HTTPS binding in IIS Manager, perform the following steps:

1. In IIS Manager, select your site in the Connections pane.
1. In the Actions pane, select Bindings.
1. In the Site Bindings dialog box, select Add.
1. In the Add Site Binding dialog box, configure:
   - **Type:** Select https.
   - **IP address:** Select the IP address, or All Unassigned for all IPs.
   - **Port:** Enter 443.
   - **Host name:** Enter the domain name (for example, www.contoso.com). Required when hosting multiple HTTPS sites.
   - **Require Server Name Indication:** Check this box when multiple HTTPS sites share one IP address.
   - **SSL certificate:** Select the installed certificate from the dropdown.
1. Select OK, then Close.

You can add an HTTPS binding with SNI using the New-WebBinding PowerShell cmdlet. The following code adds the binding for www.contoso.com:

```powershell
# Get the thumbprint of the installed certificate
$cert = Get-ChildItem Cert:\LocalMachine\My |
    Where-Object { $_.Subject -match "www.contoso.com" }
$thumbprint = $cert.Thumbprint
 
# Add HTTPS binding with SNI enabled (SslFlags 1 = SNI enabled)
New-WebBinding -Name "MySite" -Protocol "https" -Port 443 `
    -HostHeader "www.contoso.com" -SslFlags 1
 
# Associate the certificate with the binding
$binding = Get-WebBinding -Name "MySite" -Protocol "https"
$binding.AddSslCertificate($thumbprint, "My")
```

## Enforcing strong encryption

Installing a certificate is only part of securing TLS. You must also ensure the server uses only modern protocol versions and strong cipher suites.

### Disabling outdated TLS protocol versions

TLS 1.0 and TLS 1.1 are deprecated. TLS 1.0 is susceptible to known attacks such as BEAST, and both versions lack support for modern authenticated encryption cipher suites. You should disable these on production servers. Protocol version support is controlled by the Windows SChannel security provider through registry settings.

To disable TLS 1.0 and TLS 1.1, and explicitly enable TLS 1.2/1.3, run the following code to update the registry:

```powershell
# Disable TLS 1.0 for Server
$tls10Path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server"
New-Item -Path $tls10Path -Force | Out-Null
New-ItemProperty -Path $tls10Path -Name "Enabled" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $tls10Path -Name "DisabledByDefault" -Value 1 -PropertyType DWord -Force
 
# Disable TLS 1.1 for Server
$tls11Path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server"
New-Item -Path $tls11Path -Force | Out-Null
New-ItemProperty -Path $tls11Path -Name "Enabled" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $tls11Path -Name "DisabledByDefault" -Value 1 -PropertyType DWord -Force
# Explicitly enable TLS 1.2 for Server
$tls12Path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"
New-Item -Path $tls12Path -Force | Out-Null
New-ItemProperty -Path $tls12Path -Name "Enabled" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path $tls12Path -Name "DisabledByDefault" -Value 0 -PropertyType DWord -Force
 
# Explicitly enable TLS 1.3 for Server
$tls13Path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server"
New-Item -Path $tls13Path -Force | Out-Null
New-ItemProperty -Path $tls13Path -Name "Enabled" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path $tls13Path -Name "DisabledByDefault" -Value 0 -PropertyType DWord -Force
 
# A server restart is required for SChannel changes to take effect
# Uncomment the following line during a planned maintenance window
# Restart-Computer -Force
```

Although modern Windows Server versions disable SSL 2.0 and SSL 3.0 by default, run the following commands to explicitly disable these protocols and confirm their configuration:

```powershell
# Disable SSL 2.0 for Server
$ssl20Path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server"
New-Item -Path $ssl20Path -Force | Out-Null
New-ItemProperty -Path $ssl20Path -Name "Enabled" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $ssl20Path -Name "DisabledByDefault" -Value 1 -PropertyType DWord -Force
 
# Disable SSL 3.0 for Server
$ssl30Path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server"
New-Item -Path $ssl30Path -Force | Out-Null
New-ItemProperty -Path $ssl30Path -Name "Enabled" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $ssl30Path -Name "DisabledByDefault" -Value 1 -PropertyType DWord -Force
 
# Verify SSL 2.0 is disabled
$ssl20 = Get-ItemProperty -Path $ssl20Path -ErrorAction SilentlyContinue
if ($ssl20.Enabled -eq 0) {
    Write-Host "SSL 2.0 is disabled - OK" -ForegroundColor Green
} else {
    Write-Host "SSL 2.0 is NOT disabled - ACTION REQUIRED" -ForegroundColor Red
}
 
# Verify SSL 3.0 is disabled
$ssl30 = Get-ItemProperty -Path $ssl30Path -ErrorAction SilentlyContinue
if ($ssl30.Enabled -eq 0) {
    Write-Host "SSL 3.0 is disabled - OK" -ForegroundColor Green
} else {
    Write-Host "SSL 3.0 is NOT disabled - ACTION REQUIRED" -ForegroundColor Red
}
```

> [!IMPORTANT]
> Changes to SChannel registry settings require a server restart to take effect. Plan this change during a maintenance window.

### Configuring strong cipher suites

Cipher suites define the algorithms used for key exchange, authentication, encryption, and message authentication in a TLS session. TLS 1.3 cipher suites (used automatically when TLS 1.3 is negotiated and can't be individually disabled):

- TLS_AES_256_GCM_SHA384
- TLS_AES_128_GCM_SHA256
- TLS_CHACHA20_POLY1305_SHA256

TLS 1.2 recommended cipher suites (prioritize ECDHE for forward secrecy):

- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256

If your IIS server uses ECDSA certificates (rather than RSA certificates), also include the following ECDSA cipher suites. Organizations deploying ECDSA certificates require these to negotiate TLS 1.2 connections with clients:

- TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
- TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
- TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256

You can configure cipher suite priority using PowerShell.

```powershell
# Define the preferred cipher suite order
$cipherSuites = @(
    "TLS_AES_256_GCM_SHA384",
    "TLS_AES_128_GCM_SHA256",
    "TLS_CHACHA20_POLY1305_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256"
)
$cipherSuitesString = $cipherSuites -join ","
 
# Set cipher suite order via registry (applies when Group Policy is not managing this)
$sslConfigPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
New-Item -Path $sslConfigPath -Force | Out-Null
New-ItemProperty -Path $sslConfigPath -Name "Functions" `
    -Value $cipherSuitesString -PropertyType String -Force
```

> [!NOTE]
> You can also manage cipher suite order using the Local Group Policy Editor (gpedit.msc) under: Computer Configuration > Administrative Templates > Network > SSL Configuration Settings > SSL Cipher Suite Order.

### Disabling weak cipher suites

The NSA identifies NULL, RC2, RC4, DES, IDEA, and 3DES as especially weak encryption algorithms. The CIS IIS 10 Benchmark items 7.7-7.9 require NULL, DES, and RC4 cipher suites to be disabled; item 7.10 requires AES 128/128 to be disabled. Although the recommended cipher list above implicitly excludes these, Windows default cipher suite order may still include some of them. Explicitly disable known-weak ciphers with the following commands:

```powershell
# Disable NULL cipher suite
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_NULL_SHA256" -ErrorAction SilentlyContinue
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_NULL_SHA" -ErrorAction SilentlyContinue
 
# Disable RC4 cipher suites
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_RC4_128_MD5" -ErrorAction SilentlyContinue
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_RC4_128_SHA" -ErrorAction SilentlyContinue
 
# Disable DES and 3DES cipher suites
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_3DES_EDE_CBC_SHA" -ErrorAction SilentlyContinue
 
# Disable static-RSA AES 128/128 cipher suites (CIS item 7.10)
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_CBC_SHA256" -ErrorAction SilentlyContinue
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_CBC_SHA" -ErrorAction SilentlyContinue
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_GCM_SHA256" -ErrorAction SilentlyContinue
 
# Verify no weak ciphers are still active
Get-TlsCipherSuite | Where-Object { $_.Name -match "NULL|RC4|DES|RC2|TLS_RSA_WITH_AES_128" } | Select-Object Name
```

> [!NOTE]
> Use Disable-TlsCipherSuite (available in PowerShell 5.0 and later on Windows Server 2016+) rather than registry manipulation for per-suite disablement. Run as Administrator. Changes take effect without a restart.

### Verifying TLS configuration

You can use the following PowerShell code to verify that TLS 1.0 is disabled and that TLS 1.2 is enabled.

```powershell
# Verify TLS 1.0 is disabled
$tls10 = Get-ItemProperty `
    -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" `
    -ErrorAction SilentlyContinue
if ($tls10.Enabled -eq 0) {
    Write-Host "TLS 1.0 is disabled - OK" -ForegroundColor Green
} else {
    Write-Host "TLS 1.0 is NOT disabled - ACTION REQUIRED" -ForegroundColor Red
}
 
# Verify TLS 1.2 is enabled
$tls12 = Get-ItemProperty `
    -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" `
    -ErrorAction SilentlyContinue
if ($tls12.Enabled -eq 1) {
    Write-Host "TLS 1.2 is enabled - OK" -ForegroundColor Green
} else {
    Write-Host "TLS 1.2 may need configuration" -ForegroundColor Yellow
}
```

## HTTP strict transport security (HSTS)

HTTP Strict Transport Security (HSTS) is a web security policy mechanism that instructs browsers to only connect to a site over HTTPS, even if the user enters an HTTP URL. Once a browser has received the HSTS response header, it refuses to connect to that hostname over plain HTTP for the duration of the max-age period, protecting users from protocol downgrade attacks and cookie hijacking. 

IIS in Windows Server 2019 and later support HSTS natively at the site level using the \<hsts> element in ApplicationHost.config.

To enable HSTS in IIS Manager, perform the following steps:

1. In IIS Manager, select your site in the Connections pane.
1. In the Actions pane, select Bindings, confirm an HTTPS binding on port 443 exists, then close.
1. In the Features View, under the Management section, double-select Configuration Editor.
1. In the Section dropdown, navigate to system.applicationHost/sites.
1. Expand the site collection, locate your site, and expand its hsts element.
1. Set the following attributes:
   - enabled: True
   - max-age: 31536000 (one year in seconds)
   - includeSubDomains: (Optional) True if all subdomains also support HTTPS
   - redirectHttpToHttps: True (automatically redirects HTTP requests to HTTPS)
1. Select Apply in the Actions pane.

> [!NOTE]
> The `includeSubDomains` attribute extends the HSTS policy to every subdomain of the site's hostname. Only enable this when you have confirmed that all subdomains are served over HTTPS, because browsers will refuse plain HTTP connections to any subdomain for the duration of the max-age period.

You can enable HSTS using the IISAdministration module in PowerShell:

```powershell
# Enable HSTS for a site using the IISAdministration module
Import-Module IISAdministration
 
$siteName = "MySite"
$mgr = Get-IISServerManager
$site = $mgr.Sites[$siteName]
$hsts = $site.GetChildElement("hsts")
$hsts.SetAttributeValue("enabled", $true)
$hsts.SetAttributeValue("max-age", 31536000)
$hsts.SetAttributeValue("includeSubDomains", $true)  # Optional: enable only if all subdomains support HTTPS
$hsts.SetAttributeValue("redirectHttpToHttps", $true)
$mgr.CommitChanges()
```

The resulting site configuration looks like:

```xml
<hsts enabled="true" max-age="31536000" includeSubDomains="true" redirectHttpToHttps="true" />
```

> [!IMPORTANT]
> Don't enable HSTS until HTTPS is fully configured and verified on the site. Once a browser caches the HSTS policy, it refuses HTTP connections for the max-age duration, which can cause access problems if HTTPS is later misconfigured.

## HTTP/3 and QUIC support on Windows Server 2022 and later

HTTP/3 is the latest version of the HTTP protocol, built on QUIC (Quick UDP Internet Connections) rather than TCP. It offers:

- Faster connection establishment (0-RTT or 1-RTT)
- Elimination of head-of-line blocking found in TCP-based protocols
- Built-in TLS 1.3 encryption (QUIC requires TLS 1.3)
- Connection migration (connections survive IP address changes)

Windows Server 2022 and later supports HTTP/3 in IIS using the built-in MsQuic QUIC implementation. To use HTTP/3 in IIS with built-in MsQuic QUIC, you need to ensure that:

- TLS 1.3 must be enabled
- HTTPS is configured on the site
- The Alt-Svc response header must be configured to advertise HTTP/3 to clients

You can enable HTTP3 with the following PowerShell code:

```powershell
# Enable HTTP/3 (QUIC) support in IIS
$http3RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\HTTP\Parameters"
New-ItemProperty -Path $http3RegistryPath -Name "EnableHttp3" `
    -Value 1 -PropertyType DWord -Force
 
# Add the Alt-Svc header to advertise HTTP/3 availability to clients
# This tells supporting browsers that HTTP/3 is available on port 443
Set-WebConfigurationProperty -PSPath "IIS:\Sites\MySite" `
    -Filter "system.webServer/httpProtocol/customHeaders" `
    -Name "." -Value @{name="Alt-Svc"; value='h3=":443"; ma=86400'}
```

> [!NOTE]
> After enabling HTTP/3, clients that support it will upgrade on subsequent requests via the Alt-Svc header. The initial request uses HTTP/2 or HTTP/1.1 over TCP; the browser then switches to QUIC/UDP on the next visit.

### Alternative: EnableAltSvc registry key

Rather than adding the Alt-Svc header manually per site, you can configure http.sys to automatically send ALTSVC frames in HTTP/2 responses by setting the EnableAltSvc registry key. This is the method recommended by Microsoft's networking team:

```powershell
# Enable automatic Alt-Svc ALPN frame advertisement by http.sys
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\HTTP\Parameters" `
    -Name "EnableAltSvc" -Value 1 -PropertyType DWord -Force
```

When this key is set, http.sys automatically advertises HTTP/3 availability in HTTP/2 responses without requiring per-site custom header configuration.

### Verifying firewall rules for QUIC (UDP 443)

QUIC operates over UDP port 443 rather than TCP. Many network firewall configurations allow only TCP 443, which causes HTTP/3 to fail silently. Clients fall back to HTTP/2 or HTTP/1.1 without an error. Before deploying HTTP/3, verify that the Windows Defender Firewall rule for QUIC is enabled:

```powershell
# Check whether the QUIC inbound firewall rule is enabled
Get-NetFirewallRule | Where-Object { $_.DisplayName -eq "World Wide Web Services (QUIC Traffic-In)" }
 
# Enable the IIS QUIC inbound rule if it is disabled
Get-NetFirewallRule -Name "IIS-WebServerRole-QUIC-In-UDP" | Enable-NetFirewallRule
```

> [!NOTE]
> Also verify that any external network firewalls or load balancers permit inbound and outbound UDP traffic on port 443. Without this, HTTP/3 connections are silently dropped.

### Verifying TLS_CHACHA20_POLY1305_SHA256 for QUIC

QUIC requires TLS 1.3, and if changes were made to the default cipher suite list, you must ensure TLS_CHACHA20_POLY1305_SHA256 is active. Some Windows Server configurations may not have this cipher suite enabled by default. Verify and enable it if necessary:

```powershell
# Verify TLS_CHACHA20_POLY1305_SHA256 is active
$chacha = Get-TlsCipherSuite -Name "TLS_CHACHA20_POLY1305_SHA256" -ErrorAction SilentlyContinue
if ($chacha) {
    Write-Host "TLS_CHACHA20_POLY1305_SHA256 is active - OK" -ForegroundColor Green
} else {
    Write-Host "Enabling TLS_CHACHA20_POLY1305_SHA256..." -ForegroundColor Yellow
    Enable-TlsCipherSuite -Name "TLS_CHACHA20_POLY1305_SHA256" -Position 0
}
```

You can verify HTTP/3 is active, by using browser developer tools. You can access these by pressing F12 and then selecting the Network tab. In the protocol column, connections using HTTP/3 show as h3. Microsoft Edge and current versions of supported browsers can negotiate HTTP/3 connections.