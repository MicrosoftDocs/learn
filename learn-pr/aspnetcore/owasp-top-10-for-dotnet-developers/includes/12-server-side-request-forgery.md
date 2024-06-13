Server-side forgery (SSRF) describes situations when a web application is fetching a remote resource without validating the user-supplied URL. It allows an attacker to coerce the application to send a crafted request to an unexpected destination.

Attackers might also use this functionality to import untrusted data into code that expects to only read data from trusted sources, and as such circumvent input validation.

A URL or query string seen in web browser's address bar, when used as input parameter, could be a perfect example of user input needing sanitization.

During code review, you came across a seemingly harmless REST web GET request:

```csharp
string url = Request.Form["url"];
var client = new HttpClient();
HttpResponseMessage response = await client.GetAsync(url);
```

Without validating the supplied URL, an attacker can hijack the network connection and control the request schema by supplying **ldap://**, **jar://** or **file://** instead of **https://**. Furthermore, the POST method allows an attacker to force the application to send a crafted request to an unexpected destination.

In certain situations, with carefully formulated URL, an attacker might be able to:

- Read server configurations such as metadata.
- Connect to internal services like http-enabled databases.
- Perform POST requests to an internal service that isn't intended to be exposed.

> [!IMPORTANT]
> User-controlled data shouldn't be trusted. Validate all input and ensure that the request is being sent to the expected destination.

You should enforce an allowlist or blocklist (like IP addresses and host names).

Correct user input validation can protect your application from a few OWASP Top 10 items.

### Code review notes

Once again, you were reminded of the importance of input validation. Luckily, .NET has built-in [IPAddress.TryParse](/dotnet/api/system.net.ipaddress.tryparse) or [Uri.CheckHostName](/dotnet/api/system.uri.checkhostname) methods for input and configuration validation.

To summarize, prevention from SSRF attacks in your .NET applications might involve:

- Validating user input and only allowing expected values.
- Using an allowlist with approved domains and protocols for network communication.
