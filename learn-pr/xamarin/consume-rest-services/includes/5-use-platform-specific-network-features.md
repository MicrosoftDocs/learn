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

Before we wrap up this unit, there's one more thing to keep in mind when you use the native networking stack on iOS. App Transport Security is a feature that requires every network communication done through the native network stack to use TLS 1.2 or above. Modern encryption algorithms won't disclose information if one of the long-term keys is compromised.

If your app doesn't adhere to these rules, it's denied network access. If your application has this problem, you have two options. First, you can change your endpoint to adhere to the App Transport Security policy. Second, you can opt out of App Transport Security by setting some keys in your **Info.plist** file.

### Opt out of App Transport Security

To opt out of App Transport Security, add a new key to your **Info.plist** file called `NSAppTransportSecurity`. Inside that dictionary, add another key called `NSExceptionDomains`. It contains a child for each of the endpoints you want to target. Here's an example of what you add to opt out for one endpoint:

```xml
<key>NSAppTransportSecurity</key>
<dict>
   <key>NSExceptionDomains</key>
      <dict>
      <key>xam150.azurewebsites.net</key>
      <dict>
         <!-- specific options here -->
      </dict>
   </dict>
</dict>
```

In this example, we added an exception to the endpoint at `xam150.azurewebsites.net`. There are options that you can add to be more specific about how you want to opt out. That guidance is outside the scope of this module. The options are documented on Apple's website.

Finally, if you can't identify all your endpoints, disable App Transport Security for all unspecified endpoints by using the `NSAllowsArbitraryLoads` key. Here's an example in code:

```xml
<key>NSAppTransportSecurity</key>
<dict>
   <key>NSAllowsArbitraryLoads</key>
   <true/>
</dict>
```
