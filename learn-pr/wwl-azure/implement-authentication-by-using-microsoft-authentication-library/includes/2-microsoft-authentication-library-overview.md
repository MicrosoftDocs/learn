
The Microsoft Authentication Library (MSAL) can be used to provide secure access to Microsoft Graph, other Microsoft APIs, third-party web APIs, or your own web API. MSAL supports many different application architectures and platforms including .NET, JavaScript, Java, Python, Android, and iOS.

MSAL gives you many ways to get tokens, with a consistent API for a number of platforms. Using MSAL provides the following benefits:

* No need to directly use the OAuth libraries or code against the protocol in your application.
* Acquires tokens on behalf of a user or on behalf of an application (when applicable to the platform).
* Maintains a token cache and refreshes tokens for you when they are close to expire. You don't need to handle token expiration on your own.
* Helps you specify which audience you want your application to sign in.
* Helps you set up your application from configuration files.
* Helps you troubleshoot your app by exposing actionable exceptions, logging, and telemetry.

 ## Application types and scenarios

Using MSAL, a token can be acquired from a number of application types: web applications, web APIs, single-page apps (JavaScript), mobile and native applications, and daemons and server-side applications. MSAL currently supports the platforms and frameworks listed in the table below.

| Library | Supported platforms and frameworks |
|--|--|
| [MSAL for Android](https://github.com/AzureAD/microsoft-authentication-library-for-android) | Android |
| [MSAL Angular](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-angular) | Single-page apps with Angular and Angular.js frameworks |
| [MSAL for iOS and macOS](https://github.com/AzureAD/microsoft-authentication-library-for-objc) | iOS and macOS |
| [MSAL Go (Preview)](https://github.com/AzureAD/microsoft-authentication-library-for-go) | Windows, macOS, Linux |
| [MSAL Java](https://github.com/AzureAD/microsoft-authentication-library-for-java) | Windows, macOS, Linux |
| [MSAL.js](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-browser) | JavaScript/TypeScript frameworks such as Vue.js, Ember.js, or Durandal.js |
| [MSAL.NET](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet) | .NET Framework, .NET Core, Xamarin Android, Xamarin iOS, Universal Windows Platform |
| [MSAL Node](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node) | Web apps with Express, desktop apps with Electron, Cross-platform console apps |
| [MSAL Python](https://github.com/AzureAD/microsoft-authentication-library-for-python) | Windows, macOS, Linux |
| [MSAL React](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-react) | Single-page apps with React and React-based libraries (Next.js, Gatsby.js) |

## Authentication flows

Below are some of the different authentication flows provided by Microsoft Authentication Library (MSAL). These flows can be used in a variety of different application scenarios.

Flow | Description 
--- | --- 
Authorization code | Native and web apps securely obtain tokens in the name of the user 
Client credentials | Service applications run without user interaction 
On-behalf-of | The application calls a service/web API, which in turns calls Microsoft Graph 
Implicit | Used in browser-based applications 
Device code | Enables sign-in to a device by using another device that has a browser 
Integrated Windows | Windows computers silently acquire an access token when they are domain joined 
Interactive | Mobile and desktops applications call Microsoft Graph in the name of a user 
Username/password | The application signs in a user by using their username and password 

### Public client, and confidential client applications

Security tokens can be acquired by multiple types of applications. These applications tend to be separated into the following two categories. Each is used with different libraries and objects.

* **Public client applications**: Are apps that run on devices or desktop computers or in a web browser. They're not trusted to safely keep application secrets, so they only access web APIs on behalf of the user. (They support only public client flows.) Public clients can't hold configuration-time secrets, so they don't have client secrets.

* **Confidential client applications**: Are apps that run on servers (web apps, web API apps, or even service/daemon apps). They're considered difficult to access, and for that reason capable of keeping an application secret. Confidential clients can hold configuration-time secrets. Each instance of the client has a distinct configuration (including client ID and client secret).
