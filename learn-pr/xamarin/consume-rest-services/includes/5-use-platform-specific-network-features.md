`HttpClient` is a managed implementation, which means that it's unaware of the native platform networking stack. As a result, `HttpClient` can't use the native networking features of each platform, which makes it not as efficient and less optimized.

In this unit, you take advantage of `HttpClient`'s extensibility and add support for the native platform's networking stack.

## Issues with HttpClient

By default, `HttpClient` uses a managed networking stack based on low-level operating system interfaces. For this reason, `HttpClient` is unaware of the networking stacks on each platform. Android and iOS both have native networking stacks, which are more efficient, but they have unique APIs that make it harder to use from C#.

As a result, `HttpClient` doesn't use the native platform fully. For example, a feature of the native networking stack is to automatically attempt to enable cellular data if it's turned off. Because `HttpClient` isn't using the native networking stack by default, it won't attempt to turn it on.

## What is a message handler?

`HttpClient` is designed to be extensible and supports message handlers to affect how it transfers information and deals with common HTTP scenarios. For example, Microsoft created a message handler called `HttpClientHandler`. You can use it to customize some features of `HttpClient`. Here's an example that shows the use of `HttpClientHandler`:

```csharp
var handler = new HttpClientHandler() {
   AllowAutoRedirect = false,
   UseProxy = true,
   AutomaticDecompression = DecompressionMethods.GZip,
   Credentials = new NetworkCredential("user", "passwd")
};

var client = new HttpClient(handler);
```

As you can see, `HttpClientHandler` has properties that you can set to customize the behavior of `HttpClient`. To apply the customizations to `HttpClient`, pass them into the constructor.

## What is NSUrlSessionHandler?

Xamarin.iOS includes a message handler called `NSUrlSessionHandler` that causes `HttpClient` to use its native networking stack. `NSUrlSessionHandler` provides benefits like:

- Automatically turning on the radio before starting a request.
- Utilizing iOS connection pooling.
- Using dispatch queues instead of managed threads.

The handler makes `HttpClient` work like a native application when it deals with the network.

To set `NSUrlSessionHandler` in code looks something like this example:

```csharp
var client = new HttpClient(new NSUrlSessionHandler());
```

Now, `HttpClient` has the benefits of the native networking stack.

## What is AndroidClientHandler?

Just like Xamarin.iOS, Xamarin.Android includes a message handler called `AndroidClientHandler`. `AndroidClientHandler` pushes the work of network communication onto the Android `UrlConnection` stack. This handler allows `HttpClient` to use any network protocol and encryption protocols that Android knows how to handle, such as TLS 1.2.

To set `AndroidClientHandler` in code looks something like this example:

```csharp
var client = new HttpClient(new AndroidClientHandler());
```

## When to use NSUrlSessionHandler and AndroidClientHandler

As general guidance, always use `NSUrlSessionHandler` and `AndroidClientHandler` when you use `HttpClient`. They both provide benefits from the native networking stack.

Using these handlers is the default for new Xamarin.Forms projects. There are project settings to change the `HttpClient` default.

To change the default HttpClient handler for Xamarin.iOS, open iOS project's properties. Under the **iOS Build** tab, there's an **HttpClient Implementation** option. If you set this option to `NSUrlSession`, HttpClient uses the native iOS handler without passing it into the constructor.

To change the default HttpClient handler for Xamarin.Android, open the Android project's properties. Under the **Android Options** tab, click the **Advanced** button at the bottom. In the **Advanced Android Options** dialog, there's an **SSL/TLS implementation** option. Setting this value to `Native TLS 1.2+` makes HttpClient default to using the message handler.

## What is App Transport Security?

Before we wrap up this unit, there's one more thing to keep in mind when you use the native networking stack on iOS. App Transport Security (ATS) is a feature that requires every network communication done through the native network stack to use TLS 1.2 or above. Modern encryption algorithms won't disclose information if one of the long-term keys is compromised.

If your app doesn't adhere to these rules, it's denied network access. If your application has this problem, you have two options. First, you can change your endpoint to adhere to the App Transport Security policy. Second, you can opt out of App Transport Security by setting some keys in your **Info.plist** file.

### Opt out of App Transport Security

To opt out of App Transport Security, add a new key to your **Info.plist** file called `NSAppTransportSecurity`. Inside that dictionary, add another key called `NSExceptionDomains`. It contains a child for each of the endpoints you want to target. Here's an example of what you add to opt out for one endpoint:

```xml
<key>NSAppTransportSecurity</key>
<dict>
   <key>NSExceptionDomains</key>
      <dict>
      <key>dotnet.microsoft.com</key>
      <dict>
         <!-- specific options here -->
      </dict>
   </dict>
</dict>
```

In this example, we added an exception to the endpoint at `dotnet.microsoft.com`. If you are debugging a service locally on your development machine you can opt-out for local traffic with the `NSAllowsLocalNetworking` key.

```xml
<key>NSAppTransportSecurity</key>    
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
</dict>
```

Finally, if you can't identify all your endpoints, disable App Transport Security for all unspecified endpoints by using the `NSAllowsArbitraryLoads` key. Here's an example in code:

```xml
<key>NSAppTransportSecurity</key>
<dict>
   <key>NSAllowsArbitraryLoads</key>
   <true/>
</dict>
```

There are additional options that you can add to be more specific about how you want to opt out. That guidance is outside the scope of this module. The options are documented on the [Xamarin.iOS ATS documentation](https://docs.microsoft.com/xamarin/ios/app-fundamentals/ats).

## What is Android Network Security Configuration?

Like iOS, Android has a similar security model around network communication that was introduced with Android 9 (API level 28). Cleartext (non-HTTPS) traffic is disabled by default when your application is run on and targeting Android 9 (API Level 28) or higher. This policy may have an impact on your development cycle if your app needs to download an image or file on a server hasn’t been configured for HTTPS. Also, you may just be trying to debug your application locally and don’t want to install development certs. You may have strong business requirements that all web traffic on all versions of Android is always HTTPS. This is where the new Network Security Configuration feature of Android comes in, to help us finely tune network traffic security in our app.

### Permit Cleartext Traffic

To permit cleartext traffic you will need to create a network security configuration. First, you will create a new xml file under `Resources/xml` named `network_security_config.xml`. Inside of this file you will add a `network-security-config` with `domain-config` settings. The following configuration will enable cleartext traffic to be allowed for a specific domain and for an IP address:

```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
  <domain-config cleartextTrafficPermitted="true">
    <domain includeSubdomains="true">10.0.2.2</domain> <!-- Debug port -->
    <domain includeSubdomains="true">xamarin.com</domain>
  </domain-config>
</network-security-config>
```

You can strengthen the security of your app by also restricting cleartext traffic on all versions of Android regardless of the compile and target framework. This is accomplished by setting `cleartextTrafficPermitted` to `false`. Enabling this will restrict any traffic that is non-HTTPS at all times.

The last thing that needs to be done is to configure the `networkSecurityConfig` property on the `application` node in the `AndroidManifest.xml` located in the **Properties** folder:

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest>
    <application android:networkSecurityConfig="@xml/network_security_config">
        ...
    </application>
</manifest>
```

There are additional options that you can add to be more specific about how you want to opt out. That guidance is outside the scope of this module. The options are documented in [Google's network security configuration guide](https://developer.android.com/training/articles/security-config).

## Debug service and apps locally

Finally, a benefit of building mobile applications with C# and .NET is that you can shared code and knowledge with other .NET applications such as the ASP.NET Core Web API backend that was provided here. Additionally, mobile applications running in the iOS Simulator or Android emulator can consume ASP.NET Core web services that are running locally, and exposed over HTTP, as follows:

Applications running in the iOS Simulator can connect to local HTTP web services via your machines IP address, or via the localhost hostname. The application must opt-out of ATS specifying a minimum of `NSAllowsLocalNetworking`. For example, given a local HTTP web service that exposes a GET operation via the /api/todoitems/ relative URI, an application running in the iOS Simulator can consume the operation by sending a GET request to ``http://localhost:<port>/api/todoitems/``.

Applications running in the Android emulator can connect to local HTTP web services via the 10.0.2.2 address, which is an alias to your host loopback interface (127.0.0.1 on your development machine). A network security configuration must also be set up for this specific IP address. For example, given a local HTTP web service that exposes a GET operation via the /api/todoitems/ relative URI, an application running in the Android emulator can consume the operation by sending a GET request to http://10.0.2.2:<port>/api/todoitems/.

ASP.NET Core web services must disable HTTPS redirects by commenting out `app.UseHttpsRedirection();` in the **Startup.cs** file. 

### Detect the operating system

The [`DeviceInfo`](xref:Xamarin.Essentials.DeviceInfo) class can be used to detect the platform the application is running on. The appropriate hostname, that enables access to local secure web services, can then be set as follows:

```csharp
public static string BaseAddress =
    DeviceInfo.Platform == DevicePlatform.Android ? "``http://10.0.2.2:5000``" : "``http://localhost:5000``";
public static string TodoItemsUrl = $"{BaseAddress}/api/todoitems/";
```

To learn more, visit the [connect to a local web service](https://docs.microsoft.com/xamarin/cross-platform/deploy-test/connect-to-local-web-services) documentation.
