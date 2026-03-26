Beyond basic site creation and bindings, IIS provides a rich set of per-site and per-application configuration options that affect how content is served and how errors are handled. In this unit, you configure custom HTTP error pages, implement URL redirection, manage MIME types, enable HTTP compression, and configure request filtering to block unwanted or potentially harmful traffic.

## Custom error pages

By default, IIS returns a generic HTTP error page when a client encounters a `4xx` or `5xx` status code. Customizing error pages improves the user experience and prevents accidental disclosure of internal diagnostic details.

IIS supports two types of error responses:

- **Detailed errors:** Full diagnostic information including stack traces. Appropriate only for local (same-machine) requests during development.
- **Custom error pages:** Static HTML or a redirect to a custom URL. Always use for production and remote requests.

To configure custom error pages in IIS Manager:

1. Select the site (or application) in the Connections pane.
1. In the center features pane, double-click **Error Pages**.
1. Select the error code to customize (for example, `404`) and double-click it.
1. Select **Execute a URL on this site** and enter the path to your custom page (for example, `/errors/404.html`), or select **Respond with a 302 redirect** to redirect users to an absolute URL.
1. For the overall error policy: in the Actions pane, select **Edit Feature Settings**. Set the behavior to **Detailed errors for local requests** and **Custom error pages for remote requests** as this is the recommended production configuration.

To configure custom error pages with PowerShell:

```powershell
Set-WebConfiguration `
  -Filter "system.webServer/httpErrors/error[@statusCode='404']" `
  -PSPath "IIS:\Sites\Contoso" `
  -Value @{
      statusCode    = 404
      subStatusCode = 0
      path          = "/errors/404.html"
      responseMode  = "ExecuteURL"
  }
```

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

To enable compression in IIS Manager, perform the following steps:

1. Select the server node in the Connections pane.
1. Double-click **Compression** in the center features pane.
1. Check **Enable static content compression** and/or **Enable dynamic content compression**.
1. For static compression, configure the **Directory for temporary compressed files** and optionally set a **Per application pool disk space limit**.
1. Select **Apply**.

You enable compression with the `Set-WebConfigurationProperty` PowerShell cmdlet. For example, to enable static compression, run the following command:

```powershell
Set-WebConfigurationProperty `
    -Filter "system.webServer/httpCompression" `
    -PSPath "IIS:\" -Name "staticCompressionEnabled" -Value $true
Set-WebConfigurationProperty `
    -Filter "system.webServer/urlCompression" `
    -PSPath "IIS:\" -Name "doStaticCompression" -Value $true
Set-WebConfigurationProperty `
    -Filter "system.webServer/urlCompression" `
    -PSPath "IIS:\" -Name "doDynamicCompression" -Value $true
```

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
   - **Request Limits** tab: Set maximum allowed values for URL length, query string length, and content length.

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

For simple whole-site redirects, IIS includes a built-in HTTP Redirect feature that doesn't require the URL Rewrite module:

1. Select the site, double-click **HTTP Redirect**.
1. Check **Redirect requests to this destination** and enter the target URL.
1. Select the redirect status code (**301 Permanent** or **302 Found**).
1. Select **Apply**.
