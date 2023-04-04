This category describes situations whenever a web application is fetching a remote resource without validating the user-supplied URL. It allows an attacker to coerce the application to send a crafted request to an unexpected destination.

Let's consider a crafted or modified URL supplied by the attacker. The server code will read or submit data included in the URL.
With carefully formulated URL, the attacker may be able to:
- read server configuration such as metadata,
- connect to internal services like http enabled databases,
- perform POST requests to an internal service, which aren't intended to be exposed.

Attacker may also use this functionality to import untrusted data into code that expects to only read data from trusted sources, and as such circumvent input validation.

Let's consider a seemingly harmless REST web GET request:

```csharp
string url = Request.Form["url"];
var client = new HttpClient();
HttpResponseMessage response = await client.GetAsync(url);
```

Without validation of the supplied url the attacker can hijack the network connection and control the request schema by supplying **ldap://**, **jar://** or **file://** instead of **https://**. Furthermore, with POST method, this will allow the attacker to force the application to send a crafted request to an unexpected destination.

> [!WARNING]
> User-controlled data should not be trusted. Validate all input to  and ensure that the request is being sent to the expected destination.

An allowlist or blocklist should be enforced (like IP addresses and host names).

Correct user input validation can protect your application from a few OWASP Top 10 items.


### Code Review Notes

Once again you were reminded of the importance of input validation. Luckily, .NET has built-in [IPAddress.TryParse](/dotnet/api/system.net.ipaddress.tryparse) or [Uri.CheckHostName](/dotnet/api/system.uri.checkhostname) methods for input and configuration validation.

To summarize, prevention from SSRF attacks in your .NET applications may involve:

- validation of user input and only allowing expected values
- use of allow list with approved domains and protocols for network communication.