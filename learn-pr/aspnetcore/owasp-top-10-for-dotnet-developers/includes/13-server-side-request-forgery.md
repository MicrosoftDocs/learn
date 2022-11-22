# A10 - Server-Side Request Forgery

A10:2021 - Server-Side Request Forgery

This is the third and final new entry into the Top 10 in 2021.
Occur whenever a web application is fetching a remote resource without validating the user-supplied URL. It allows an attacker to coerce the application to send a crafted request to an unexpected destination

The attacker can supply or modify a URL which the code running on the server will read or submit data to, and by carefully selecting the URLs, the attacker may be able to read server configuration such as AWS metadata, connect to internal services like http enabled databases or perform post requests towards internal services which are not intended to be exposed.
attacker may also use this functionality to import untrusted data into code that expects to only read data from trusted sources, and as such circumvent input validation.

Let's consider a seemingly harmless REST web GET request:

```csharp
string url = Request.Form["url"];
var client = new HttpClient();
HttpResponseMessage response = await client.GetAsync(url);
```

Without validation of the supplied url the attacker can hijack the network connection and control the request schema by supplying **ldap://**, **jar://** or **file://** instead of **https://**. Furthermore, with POST method, this will allow the attacker to force the application to send a crafted request to an unexpected destination.

> [!WARNING]
> User-controlled data should not be trusted. Validate all input to  and ensure that the request is being sent to the expected destination.

An only-allowed or not-allowed should be enforces (like IP addresses and host names)

> [!TIP]
> Use built-in [IPAddress.TryParse](/dotnet/api/system.net.ipaddress.tryparse) or [Uri.CheckHostName](/dotnet/api/system.uri.checkhostname) methods for input and configuration validation.
