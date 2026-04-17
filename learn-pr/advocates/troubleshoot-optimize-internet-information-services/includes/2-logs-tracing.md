Every IIS troubleshooting investigation follows the same pattern: a symptom is reported, you collect the relevant log data, you narrow the cause, and you fix it. This unit covers the three primary log sources (IIS request logs, HTTP.sys error logs, and Failed Request Tracing) and walks through a realistic diagnostic scenario.

## IIS request logs

IIS writes one W3C log entry per completed HTTP request. The default log directory is `%SystemDrive%\inetpub\logs\LogFiles`, with a subfolder per site (for example, `W3SVC1`). Each log file covers a configurable time period, daily by default.

The fields that matter most for troubleshooting:

| Field | Description |
|-------|-------------|
| `sc-status` | HTTP status code returned to the client (200, 404, 500, etc.) |
| `sc-substatus` | IIS-specific substatus code (for example, 19 in 500.19), not sent to the client |
| `sc-win32-status` | Windows error code for the underlying failure (0 = success) |
| `time-taken` | Total request duration in milliseconds, from when IIS receives the first byte of the request to when it sends the last byte of the response |
| `cs-uri-stem` | The requested URL path |
| `cs(User-Agent)` | Client identifier, useful for isolating bot traffic or specific client issues |

### Analyzing logs with PowerShell

W3C log files use space-delimited format with comment header lines. The following command parses a log file and shows the top 10 status codes by frequency:

```powershell
Get-Content "C:\inetpub\logs\LogFiles\W3SVC1\u_ex260410.log" |
    Where-Object { $_ -notmatch '^#' } |
    ConvertFrom-Csv -Delimiter ' ' -Header 'date','time','s-ip','cs-method','cs-uri-stem','cs-uri-query','s-port','cs-username','c-ip','cs(User-Agent)','cs(Referer)','sc-status','sc-substatus','sc-win32-status','time-taken' |
    Group-Object 'sc-status' |
    Sort-Object Count -Descending |
    Select-Object -First 10 Count, Name
```

> [!TIP]
> The `-Header` parameter in these examples assumes the default IIS W3C log fields. If you've added or removed logged fields in IIS, verify your field list by checking the `#Fields:` comment line near the top of the log file and adjust the `-Header` parameter to match.

To find slow requests (over 5 seconds):

```powershell
$logs = Get-Content "C:\inetpub\logs\LogFiles\W3SVC1\u_ex260410.log" |
    Where-Object { $_ -notmatch '^#' } |
    ConvertFrom-Csv -Delimiter ' ' -Header 'date','time','s-ip','cs-method','cs-uri-stem','cs-uri-query','s-port','cs-username','c-ip','cs(User-Agent)','cs(Referer)','sc-status','sc-substatus','sc-win32-status','time-taken'

$logs | Where-Object { [int]$_.'time-taken' -gt 5000 } |
    Select-Object 'cs-uri-stem', 'sc-status', 'time-taken' |
    Sort-Object { [int]$_.'time-taken' } -Descending
```

> [!TIP]
> The `time-taken` field measures total elapsed time, including time the client spends receiving the response. A large `time-taken` with a 200 status code can indicate a slow client connection, not necessarily a server problem. Correlate with PerfMon counters to distinguish.

### Interpreting substatus codes

The substatus code narrows the diagnosis significantly. A 500 without a substatus is generic: something failed. A 500.19 points to a configuration problem. A 500.0 is a general internal server error that can come from application code, a module, or an ISAPI extension.

Common patterns:

- **404.0** vs. **404.13**: The first is a missing file or route. The second means the request body exceeded `maxAllowedContentLength`, a request filtering limit, not a missing resource.
- **500.19** vs. **500.21**: Both are configuration-related errors. 500.19 means IIS couldn't apply the configuration because of malformed XML, duplicate entries, locked sections, permission issues, or unrecognized elements. 500.21 means a handler is mapped to a module that isn't loaded.
- **401.1** vs. **401.2**: Both are authentication failures. 401.1 means the credentials were rejected. 401.2 means the authentication method itself failed (often a Kerberos configuration issue).

## HTTP.sys error log

HTTP.sys is the kernel-mode HTTP listener that sits in front of IIS worker processes. When HTTP.sys rejects a request because the target application pool's queue is full, the app pool is offline, or the request is malformed, it writes an entry to `%SystemRoot%\System32\LogFiles\HTTPERR\httperr*.log`. These requests never appear in IIS request logs because they never reach a worker process.

The key field in httperr entries is the **reason code**:

| Reason code | Meaning |
|-------------|---------|
| `QueueFull` | The application pool's request queue reached its maximum length. The worker process can't drain requests fast enough. |
| `AppOffline` | The application was taken offline and HTTP.sys returned a 503 before the request reached a worker process. |
| `Timer_AppPool` | The request timed out waiting in the application pool queue for a worker process to pick it up. The worker process is too busy or unresponsive. |
| `ConnLimit` | The server or site connection limit has been reached. |
| `Timer_ConnectionIdle` | The client's keep-alive connection was idle for longer than the configured timeout. |
| `Timer_EntityBody` | The client didn't send the request body within the allowed time. |
| `Disabled` | HTTP.sys returned 503 because an administrator or policy took the application out of service and it isn't accepting new requests. |

### When to check httperr.log

Check the HTTP.sys error log whenever:

- Users report "Service Unavailable" (503) errors, but your IIS request logs show no matching entries.
- You suspect the request queue is overflowing, and `QueueFull` entries confirm this.
- An application pool appears to be running, but clients still get 503s. Check `httperr.log` for the exact reason code to determine whether the pool is overloaded, the queue is full, or the application was taken out of service.

Correlate the timestamp and client IP from httperr.log with Event Viewer entries (System log, source: WAS) to determine *why* the app pool was offline or full.

## Failed Request Tracing (FREB)

Failed Request Tracing (also termed Failed Request Event Buffering (FREB)) captures a detailed trace of the IIS request pipeline. Each trace records every module that processed the request, how long each module took, and where a failure or delay occurred. The output is written as XML files with XSLT stylesheets that you can open in a browser.

Failed Request Tracing is valuable when:

- An error is intermittent or difficult to reproduce on demand.
- A request is slow but returns a 200, and you need to know *where* in the pipeline the time is spent.
- IIS request logs tell you *what* happened but not *why*.

### Enabling Failed Request Tracing

**Using IIS Manager:**

1. Select the site in the Connections pane.
2. Open **Failed Request Tracing Rules** in the Features view.
3. In the Actions pane, select **Edit Site Tracing** and enable tracing. Set the log directory and maximum number of trace files (default: 50).
4. Select **Add** to create a rule. Specify the content type (all content, ASP.NET, or a custom extension), then define the trigger condition:
   - **Status codes:** for example, `500,502,503`. Traces any request returning these codes.
   - **Time taken:** for example, `30` seconds. Traces any request exceeding this duration regardless of status code.

**Using AppCmd (`failureDefinitions.timeTaken` is specified in milliseconds):**

> [!NOTE]
> The following commands use `::` comment syntax and must be run in a Command Prompt window (`cmd.exe`), not PowerShell.

```cmd
:: Enable Failed Request Tracing on the "Default Web Site"
%SystemRoot%\System32\inetsrv\appcmd set config "Default Web Site" /section:system.applicationHost/sites /"[name='Default Web Site'].traceFailedRequestsLogging.enabled:true" /commit:apphost

:: Add a rule for all content
%SystemRoot%\System32\inetsrv\appcmd set config "Default Web Site" -section:system.webServer/tracing/traceFailedRequests /+"[path='*']"

:: Capture verbose pipeline events from the WWW Server provider
%SystemRoot%\System32\inetsrv\appcmd set config "Default Web Site" -section:system.webServer/tracing/traceFailedRequests /+"[path='*'].traceAreas.[provider='WWW Server',areas='RequestNotifications,Module',verbosity='Verbose']"

:: Trace requests that take longer than 30 seconds (30,000 ms)
%SystemRoot%\System32\inetsrv\appcmd set config "Default Web Site" -section:system.webServer/tracing/traceFailedRequests /[path='*'].failureDefinitions.timeTaken:"30000"
```

To trace status-code failures instead, set `failureDefinitions.statusCodes:"500-599"` on the same rule.

### Reading Failed Request Tracing output

Trace files are written to the directory you configured (default: `%SystemDrive%\inetpub\logs\FailedReqLogFiles\W3SVC<siteId>`). Open the XML file in a browser. The XSLT stylesheet formats it into a navigable report.

Key sections to examine:

- **Request Summary:** shows the final status code, time taken, and the trigger that activated the trace.
- **Compact View / Complete Request Trace:** lists every event in pipeline order. Look for:
  - Large time gaps between consecutive events. This indicates a slow module or handler.
  - `MODULE_SET_RESPONSE_ERROR_STATUS` events, which show the module that actually set the error status code.
  - `GENERAL_REQUEST_END`, which confirms the total elapsed time.

If you see a large time gap after an event from a specific module (for example, `ManagedPipelineHandler`), the bottleneck is in that module's processing, typically in application code or an external dependency the application is calling.

> [!WARNING]
> Disable Failed Request Tracing as soon as you've captured the data you need. In production, use specific status codes or time-taken thresholds instead of tracing all requests, and set a maximum trace file count (for example, 50) to prevent unbounded growth. Failed Request Tracing writes one XML file per traced request, so high traffic can fill disk quickly and degrade performance.

## Walkthrough: 503 errors after deployment

This walkthrough ties together the log sources into a single diagnostic flow.

**Symptom:** After deploying a new version of a web application, users report intermittent "Service Unavailable" errors. The errors aren't consistent. Some requests succeed while others fail.

**Step 1: Check the application pool state.**

```powershell
Import-Module WebAdministration
Get-Item "IIS:\AppPools\MyAppPool" | Select-Object Name, State, managedRuntimeVersion
```

The application pool is in **Stopped** state.

**Step 2: Check Event Viewer.**

In the System Event Log, you find recent events from source **WAS** (Windows Process Activation Service):

- **Event ID 5002:** Application pool `MyAppPool` is being automatically disabled because of a series of failures in the process(es) serving that pool.
- **Event ID 5011:** A process serving application pool `MyAppPool` suffered a fatal communication error with the Windows Process Activation Service.

This tells you: the worker process suffered a fatal communication error (Event ID 5011), and IIS triggered rapid-fail protection (Event ID 5002), automatically stopping the app pool to prevent a crash loop.

**Step 3: Find the underlying crash cause.**

Look for earlier entries in the Application Event Log with source **ASP.NET** or **.NET Runtime**. In this scenario, you find an unhandled `FileNotFoundException`. The new deployment is missing a required DLL. If the event log doesn't provide enough detail to identify the crash cause, use **Debug Diagnostics (DebugDiag)** to capture a crash dump of the worker process for deeper analysis.

**Step 4: Verify with httperr.log.**

Open the most recent httperr file. You see entries like:

```
2026-04-10 14:32:15 10.0.0.50 52431 10.0.0.10 80 HTTP/1.1 GET /app/home 503 1 AppOffline MyAppPool
```

The `AppOffline` reason code confirms that HTTP.sys was rejecting requests because the application had been taken out of service after repeated failures.

**Step 5: Resolve and verify.**

1. Copy the missing DLL into the application's `bin` folder.
1. Start the app pool:

    ```powershell
    Start-WebAppPool -Name "MyAppPool"
    ```

1. Monitor the IIS request log for the next few minutes. Confirm that requests are returning 200 status codes and that no new 503 entries appear in httperr.log.

> [!NOTE]
> Rapid-fail protection is configured per application pool. The defaults are 5 failures in a 5-minute window. You can adjust these values in the application pool's advanced settings under **Rapid-Fail Protection**, but don't disable the feature entirely. It exists to prevent crash loops from consuming server resources indefinitely.

## Common IIS error reference

Use this table as a quick-reference during investigations. It maps common status/substatus codes to their typical root cause and the first diagnostic action to take.

| Status code | Typical root cause | First diagnostic step |
|-------------|-------------------|----------------------|
| 401.1 | Credentials rejected by the configured authentication provider | Verify the authentication method is enabled for the site and the credentials are valid |
| 401.2 | Authentication handshake failed (often Kerberos SPN or delegation issue) | Check SPN registration and delegation trust settings |
| 403.14 | No default document and directory browsing disabled | Add a default document to the site or the directory |
| 404.0 | File or route not found | Verify physical path and check URL Rewrite rules if applicable |
| 404.13 | Request body exceeded `maxAllowedContentLength` | Increase the request filtering limit in `web.config` or `applicationHost.config` |
| 500.0 | General internal server error in application code, a module, or an ISAPI extension | Check the Application Event Log for exception details, review module mappings, and enable FREB for the request URL |
| 500.19 | Configuration problem such as malformed XML, duplicate entries, locked sections, permission issues, or unrecognized elements | Validate `web.config` syntax, check locked configuration sections, permissions, and required modules |
| 500.21 | Handler is mapped to a module that isn't installed or loaded | Verify the required module is installed (for example, the ASP.NET Core Module) |
| 503 | Application pool stopped, queue full, or rapid-fail protection triggered | Check app pool state, review httperr.log for the reason code, and check Event Viewer for WAS events |
