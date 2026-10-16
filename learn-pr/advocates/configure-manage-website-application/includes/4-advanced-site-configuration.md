Beyond basic site creation and bindings, IIS provides a rich set of per-site and per-application configuration options that affect how content is served and how errors are handled. In this unit, you configure custom HTTP error pages, implement URL redirection, manage MIME types, enable HTTP compression, and configure request filtering to block unwanted or potentially harmful traffic.

## Custom error pages

By default, IIS uses `DetailedLocalOnly`: requests made on the local server receive detailed error information, while remote requests receive a custom error response. Customizing error pages improves the user experience and prevents accidental disclosure of internal diagnostic details.

IIS supports two types of error responses:

- **Detailed errors:** Full diagnostic information including stack traces. Appropriate only for local (same-machine) requests during development.
- **Custom error pages:** Static HTML or a redirect to a custom URL. Always use for production and remote requests.

Before using either procedure, deploy `/errors/404.html` to the target site and verify that it's accessible. For the `Contoso` site with content in `C:\inetpub\contoso`, the file is `C:\inetpub\contoso\errors\404.html`.

To configure custom error pages in IIS Manager:

1. Select the site (or application) in the Connections pane.
1. In the center features pane, double-click **Error Pages**.
1. Select the error code to customize (for example, `404`) and double-click it.
1. Select **Execute a URL on this site** and enter the path to your custom page (for example, `/errors/404.html`), or select **Respond with a 302 redirect** to redirect users to an absolute URL.
1. For the overall error policy: in the Actions pane, select **Edit Feature Settings**. Set the behavior to **Detailed errors for local requests** and **Custom error pages for remote requests** as this is the recommended production configuration.

The following PowerShell example updates the generic 404 mapping on `Contoso` if it exists, or adds it if it doesn't:

```powershell
Import-Module WebAdministration -ErrorAction Stop
$configuration = @{
    PSPath = 'MACHINE/WEBROOT/APPHOST'
    Location = 'Contoso'
    ErrorAction = 'Stop'
}
$filter = "system.webServer/httpErrors/error[@statusCode='404' and @subStatusCode='-1']"
$mapping = @{
    statusCode = 404
    subStatusCode = -1
    path = '/errors/404.html'
    responseMode = 'ExecuteURL'
}
$existing = Get-WebConfiguration @configuration -Filter $filter
if ($null -ne $existing) {
    Set-WebConfigurationProperty @configuration -Filter $filter `
        -Name 'path' -Value $mapping.path
    Set-WebConfigurationProperty @configuration -Filter $filter `
        -Name 'responseMode' -Value $mapping.responseMode
}
else {
    Add-WebConfigurationProperty @configuration `
        -Filter 'system.webServer/httpErrors' -Name '.' -Value $mapping
}
```

> [!NOTE]
> `subStatusCode="-1"` is the generic fallback. A deliberately configured mapping for a particular 404 substatus still takes precedence. Don't clear the whole error collection to change one response. With `DetailedLocalOnly`, use a remote test client to check the custom response; local requests can still show detailed errors.

Request `/errors/404.html` directly first, then request a known nonexistent URL from a remote client. Confirm the intended custom content and the resulting HTTP status. This example doesn't change `existingResponse`, which controls how IIS handles an application's existing error response. Review that setting before changing the behavior.

For more information, see [HTTP error mappings](/iis/configuration/system.webserver/httperrors/error) and [HTTP error response settings](/iis/configuration/system.webserver/httperrors/).

## MIME types

MIME types tell clients (browsers) how to interpret the content being served. If a file extension isn't registered in IIS, IIS returns a `404.3` error instead of serving the file, even if the file exists on disk.

To configure MIME Types in IIS Manager, perform the following steps:

1. Select the server node (for server-wide changes) or a specific site in the Connections pane.
1. Double-click **MIME Types** in the center features pane.
1. The list displays all registered extensions and their content types.
1. To add a new type: Select **Add** in the Actions pane, enter the file extension (for example, `.webp`) and MIME type (`image/webp`), then select **OK**.

To manage MIME Types with PowerShell, use the `Add-WebConfigurationProperty` cmdlet. For example, to add the webp image type, run the command:

```powershell
# Add a MIME type at the server level
Add-WebConfigurationProperty -PSPath "IIS:\" `
    -Filter "system.webServer/staticContent" `
    -Name "." `
    -Value @{ fileExtension = ".webp"; mimeType = "image/webp" }
# Add a MIME type at the site level only
Add-WebConfigurationProperty -PSPath "IIS:\Sites\Contoso" `
    -Filter "system.webServer/staticContent" `
    -Name "." `
    -Value @{ fileExtension = ".avif"; mimeType = "image/avif" }
```

## HTTP compression

HTTP compression reduces response size, improving page load times and reducing bandwidth consumption. IIS supports two compression types:

- **Static compression:** Compresses static files (HTML, CSS, JavaScript) and caches compressed versions on disk. Subsequent requests for the same file are served from the cache without recompressing.
- **Dynamic compression:** Compresses dynamically generated responses (ASP.NET output, API responses) per request. Higher CPU cost but reduces bandwidth for frequently changing content.

> [!NOTE]
> Both features must be installed as IIS role services: **Static Content Compression** and **Dynamic Content Compression**. Install via Server Manager under **Web Server (IIS) > Web Server > Performance**.

To enable compression at the server level in IIS Manager, perform the following steps:

1. Select the server node in the Connections pane.
1. Double-click **Compression** in the center features pane.
1. Check **Enable static content compression** and/or **Enable dynamic content compression**.
1. For static compression, configure the **Directory for temporary compressed files** and optionally set a **Per application pool disk space limit**.
1. Select **Apply**.

To enable both static and dynamic compression for the existing `Contoso` site, use PowerShell:

```powershell
Import-Module WebAdministration -ErrorAction Stop
$compression = @{
    PSPath = 'MACHINE/WEBROOT/APPHOST'
    Location = 'Contoso'
    Filter = 'system.webServer/urlCompression'
    ErrorAction = 'Stop'
}
Set-WebConfigurationProperty @compression -Name doStaticCompression -Value $true
Set-WebConfigurationProperty @compression -Name doDynamicCompression -Value $true
Get-WebConfigurationProperty @compression -Name doStaticCompression
Get-WebConfigurationProperty @compression -Name doDynamicCompression
```

Both returned enablement values should be `True`. `-Location 'Contoso'` targets that site; omitting the location at `MACHINE/WEBROOT/APPHOST` changes server defaults.

To verify actual compression, request eligible content with an `Accept-Encoding` header, such as `Accept-Encoding: gzip`, and inspect the response's `Content-Encoding` header. Eligibility depends on configured MIME types, size limits, CPU thresholds, and static-content hit-frequency rules. A small file or its first request isn't a reliable negative test.

For more information, see [URL compression](/iis/configuration/system.webserver/urlcompression/) and [HTTP compression settings](/iis/configuration/system.webserver/httpcompression/).

## Request filtering

Request filtering is a built-in IIS security module that inspects incoming requests and blocks those that match defined rules. It's installed by default and runs early in the request pipeline, before most application code executes.

Request filtering can block:

- Specific file extensions (for example, block requests for `.config` or `.bak` files).
- Requests that exceed size limits (maximum URL length, query string length, content length).
- Specific HTTP verbs not required by your application.
- Double-encoded requests and high-bit characters.

To configure Request Filtering in IIS Manager, perform the following steps:

1. Select the site in the Connections pane.
1. Double-click **Request Filtering** in the center features pane.
1. Use the tabs to configure different filter types:
   - **File Name Extensions** tab: Select **Deny Extension** to block a file type. For example, deny `.exe`, `.bat`, and `.ps1`.
   - **Rules** tab: Select **Add Filtering Rule** to block requests matching a specific URL string, extension, or HTTP header.
   - **HTTP Verbs** tab: Select **Deny Verb** to block specific HTTP methods (for example, deny `TRACE` and `TRACK`).
1. In the **Actions** pane, select **Edit Feature Settings**. In **Edit Request Filtering Settings**, configure the maximum allowed content length, URL length, and query string length, and then select **OK**.

For more information, see [General request-filter settings](/iis/manage/configuring-security/configure-request-filtering-in-iis#general-request-filter-settings).

You configure request filtering with the `Add-WebConfigurationProperty` cmdlet. For example, to block `.exe`, `.bat`, and `.ps1` files, run the following commands:

```powershell
$sitePath = "IIS:\Sites\Contoso"
# Deny specific file extensions
Add-WebConfigurationProperty -PSPath $sitePath `
    -Filter "system.webServer/security/requestFiltering/fileExtensions" `
    -Name "." -Value @{ fileExtension = ".exe"; allowed = $false }
Add-WebConfigurationProperty -PSPath $sitePath `
    -Filter "system.webServer/security/requestFiltering/fileExtensions" `
    -Name "." -Value @{ fileExtension = ".bat"; allowed = $false }
Add-WebConfigurationProperty -PSPath $sitePath `
    -Filter "system.webServer/security/requestFiltering/fileExtensions" `
    -Name "." -Value @{ fileExtension = ".ps1"; allowed = $false }
# Restrict maximum URL length
Set-WebConfigurationProperty -PSPath $sitePath `
    -Filter "system.webServer/security/requestFiltering/requestLimits" `
    -Name "maxUrl" -Value 2048
# Deny the TRACE HTTP verb
Add-WebConfigurationProperty -PSPath $sitePath `
    -Filter "system.webServer/security/requestFiltering/verbs" `
    -Name "." -Value @{ verb = "TRACE"; allowed = $false }
```

> [!NOTE]
> Overly aggressive request filtering can cause legitimate requests to fail. Test filtering rules in a staging environment before deploying to production. Review IIS logs for `404.x` and `400` errors that may indicate blocked legitimate traffic.

## Using the built-In HTTP redirect feature

For simple whole-site redirects, IIS includes a built-in HTTP Redirect feature that doesn't require the URL Rewrite module.

> [!NOTE]
> HTTP Redirection is an optional IIS role service; it isn't installed by every IIS installation. In **Server Manager > Manage > Add Roles and Features**, select the target server, expand **Web Server (IIS) > Web Server > Common HTTP Features**, select **HTTP Redirection**, and finish installation. Refresh or reopen IIS Manager before continuing.

As a Windows PowerShell alternative, install the role service with:

```powershell
Install-WindowsFeature -Name Web-Http-Redirect -ErrorAction Stop
```

Check the installation result and any restart requirement, then refresh or reopen IIS Manager.

After installation, configure the redirect in IIS Manager:

1. Select the site, double-click **HTTP Redirect**.
1. Check **Redirect requests to this destination** and enter the target URL.
1. Select the redirect status code (**301 Permanent** or **302 Found**).
1. Select **Apply**.

Use an HTTP client with automatic redirects disabled to inspect the response status and `Location` header. Confirm that the status matches your selected 301 or 302 response and that `Location` identifies the intended destination. Request the destination separately and check any subsequent redirects to confirm that they don't lead back to the original URL or form another loop.

For more information, see [HTTP Redirection setup and configuration](/iis/configuration/system.webserver/httpredirect/).
