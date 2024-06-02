We're building hybrid apps with .NET, which means we have access to all of the .NET class libraries. In addition to these APIs, building Blazor Hybrid apps with .NET MAUI not only allows you to deploy to multiple platforms, it also allows access to each platform's native APIs. This means that if you need to integrate platform capabilities of iOS, Android, macOS, or Windows, you can do it all in C#. You can access these APIs directly from your Blazor components or create shared .NET MAUI class libraries.

## Platform integration

Each platform that .NET MAUI supports offers unique operating system and platform APIs that you can access from C#. .NET MAUI provides cross-platform APIs to access much of this platform functionality, which includes access to sensors, accessing information about the device on which an app is running, checking network connectivity, storing data securely, and initiating browser-based authentication flows.

.NET MAUI separates these cross-platform APIs into different areas of functionality:

- **Application Model**: App functionality, including app actions, application information, opening the browser, opening URIs, opening maps, handling permissions, and version tracking
- **Communication**: Access to contacts, email, networking, phone dialer, sms messaging, and web authentication
- **Device Features**: Information and access to battery, display info, device info, sensors, flashlight, geocoding, geolocation, haptic feedback, and vibration
- **Media**: Including media picker, screenshots, text to speech, and unit converters
- **Sharing**: Including access to the clipboard and sharing files or text to other applications
- **Storage**: APIs for picking files, file system helpers, preferences, and secure storage

If an application needed to detect if internet access was available on the device, it could use the `Connectivity` API in `Microsoft.Maui.Networking`:

```csharp
var accessType = Connectivity.Current.NetworkAccess;
if (accessType is NetworkAccess.Internet)
{
    // Connection to internet is available
}
```

## Access platform APIs

.NET MAUI platform-specifics allow you to consume specific functionality that's only available on a specific platform. For more information, reference [Android platform-specifics](/dotnet/maui/android/platform-specifics/), [iOS platform-specifics](/dotnet/maui/ios/platform-specifics/), and [Windows platform-specifics](/dotnet/maui/windows/platform-specifics/).

In situations where .NET MAUI doesn't provide any APIs for accessing specific platform APIs, you can write your own code to access the required platform APIs. For more information, reference [Invoke platform code](/dotnet/maui/platform-integration/invoke-platform-code).

You can invoke platform code from cross-platform code by using conditional compilation to target different platforms.

The following example shows the `DeviceOrientation` enumeration, which you use to specify your device orientation:

```csharp
namespace InvokePlatformCodeDemos.Services
{
    public enum DeviceOrientation
    {
        Undefined,
        Landscape,
        Portrait
    }
}
```

Retrieving your device orientation requires writing platform code. You can accomplish this by writing a method that uses conditional compilation to target different platforms:

```csharp
#if ANDROID
using Android.Content;
using Android.Views;
using Android.Runtime;
#elif IOS
using UIKit;
#endif

using InvokePlatformCodeDemos.Services;

namespace InvokePlatformCodeDemos.Services.ConditionalCompilation
{
    public class DeviceOrientationService
    {
        public DeviceOrientation GetOrientation()
        {
#if ANDROID
            IWindowManager windowManager = Android.App.Application.Context.GetSystemService(Context.WindowService).JavaCast<IWindowManager>();
            SurfaceOrientation orientation = windowManager.DefaultDisplay.Rotation;
            bool isLandscape = orientation == SurfaceOrientation.Rotation90 || orientation == SurfaceOrientation.Rotation270;
            return isLandscape ? DeviceOrientation.Landscape : DeviceOrientation.Portrait;
#elif IOS
            UIInterfaceOrientation orientation = UIApplication.SharedApplication.StatusBarOrientation;
            bool isPortrait = orientation == UIInterfaceOrientation.Portrait || orientation == UIInterfaceOrientation.PortraitUpsideDown;
            return isPortrait ? DeviceOrientation.Portrait : DeviceOrientation.Landscape;
#else
            return DeviceOrientation.Undefined;
#endif
        }
    }
}
```

A .NET MAUI app project contains a *Platforms* folder, with each child folder representing a platform that .NET MAUI can target. Each target-platform folder contains platform-specific code that starts the app on that platform, plus any another platform code you add. At build time, the build system only includes the code from each folder when building for that specific platform. For example, when you build for Android, the files in the *Platforms* > *Android* folder are built into the app package, but the files in the other Platforms folders aren't. This approach uses a feature called multitargeting to target multiple platforms from a single project. You can combine multitargeting with partial classes and partial methods to invoke platform functionality from cross-platform code.

In the next exercise, we'll use a combination of .NET APIs and .NET MAUI APIs to save and load our todo list.
