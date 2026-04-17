::: zone pivot="android"

If you have an Android project, go ahead and open it on Android Studio. If you don't have an Android project, go ahead and create a Hello World project on Android Studio.

## Add MSAL dependencies

1. Open your project in Android Studio or create a new project.
1. Open your application's **build.gradle** and add the following dependencies:

   ```Gradle
   allprojects {
       repositories {
           //Needed for com.microsoft.device.display:display-mask library
           maven {
               url 'https://pkgs.dev.azure.com/MicrosoftDeviceSDK/DuoSDK-Public/_packaging/Duo-SDK-Feed/maven/v1'
               name 'Duo-SDK-Feed'
           }
           mavenCentral()
           google()
       }
   }
   //...
   
   dependencies { 
       implementation 'com.microsoft.identity.client:msal:5.+'
       //...
   }
   ```

1. In Android Studio, select **File** > **Sync Project with Gradle Files**.

## Create a configuration file

You pass the required tenant identifiers, such as the application (client) ID, to the MSAL SDK through a JSON configuration setting.

Use these steps to create configuration file:

1. In Android Studio's project pane, navigate to _app\src\main\res_.
1. Right-click **res** and select **New** > **Directory**. Enter raw as the new directory name and select **OK**.
1. In _app\src\main\res\raw_, create a new JSON file called auth_config_native_auth.json.
1. In the `auth_config_native_auth.json` file, add the following MSAL configurations:

   ```json
   { 
     "client_id": "Enter_the_Application_Id_Here", 
     "authorities": [ 
       { 
         "type": "CIAM", 
         "authority_url": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/Enter_the_Tenant_Subdomain_Here.onmicrosoft.com/" 
       } 
     ], 
     "challenge_types": ["oob"], 
     "logging": { 
       "pii_enabled": false, 
       "log_level": "INFO", 
       "logcat_enabled": true 
     } 
   } 
    //...
   ```

1. Replace the following placeholders with your tenant values that you obtained from the Microsoft Entra admin center:
   - Replace the Enter_the_Application_Id_Here placeholder with the application (client) ID of the app you registered earlier.
   - Replace the Enter_the_Tenant_Subdomain_Here with the directory (tenant) subdomain. For example, if your tenant primary domain is contoso.onmicrosoft.com, use contoso. If you don't have your tenant name, learn how to [read your tenant details](/entra/external-id/customers/how-to-create-customer-tenant-portal).

   The challenge types are a list of values, which the app uses to notify Microsoft Entra about the authentication method that it supports.
      - For sign-up and sign-in flows with email one-time passcode, use ["oob"]
      - For sign-up and sign-in flows with email and password, use ["oob","password"]
      - For self-service password reset (SSPR), use ["oob"]

## Logging configuration

Turn on logging at app creation by creating a logging callback, so the SDK can output logs.

```Kotlin
import com.microsoft.identity.client.Logger

fun initialize(context: Context) {
        Logger.getInstance().setExternalLogger { tag, logLevel, message, containsPII ->
            Logs.append("$tag $logLevel $message")
        }
    }
```

To configure the logger, you need to add a section in the configuration file, `auth_config_native_auth.json`:

```JSON
//...
   { 
     "logging": { 
       "pii_enabled": false, 
       "log_level": "INFO", 
       "logcat_enabled": true 
     } 
   } 
    //...
```

1. **logcat_enabled**: Enables the logging functionality of the library.
1. **pii_enabled**: Specifies whether messages containing personal data, or organizational data are logged. When set to false, logs won't contain personal data. When set to true, the logs might contain personal data.
1. **log_level**: Use it to decide which level of logging to enable. Android supports the following log levels:
      - ERROR
      - WARNING
      - INFO
      - VERBOSE

## Create native authentication MSAL SDK instance

In the `**onCreate()` method**, create an MSAL instance so the app can perform authentication with your tenant through native authentication. The `**createNativeAuthPublicClientApplication()**` method returns an instance called `**authClient**`. Pass the JSON configuration file that you created earlier as a parameter.

```Kotlin
//...
    authClient = PublicClientApplication.createNativeAuthPublicClientApplication( 
        this, 
        R.raw.auth_config_native_auth 
    )
    //...
```

Your code should look something similar to the following snippet:

```Kotlin
class MainActivity : AppCompatActivity() { 
        private lateinit var authClient: INativeAuthPublicClientApplication 
 
        override fun onCreate(savedInstanceState: Bundle?) { 
            super.onCreate(savedInstanceState) 
            setContentView(R.layout.activity_main) 
 
            authClient = PublicClientApplication.createNativeAuthPublicClientApplication( 
                this, 
                R.raw.auth_config_native_auth 
            ) 
            getAccountState() 
        } 
 
        private fun getAccountState() {
            CoroutineScope(Dispatchers.Main).launch {
                val accountResult = authClient.getCurrentAccount()
                when (accountResult) {
                    is GetAccountResult.AccountFound -> {
                        displaySignedInState(accountResult.resultValue)
                    }
                    is GetAccountResult.NoAccountFound -> {
                        displaySignedOutState()
                    }
                }
            }
        } 
 
        private fun displaySignedInState(accountResult: AccountState) { 
            val accountName = accountResult.getAccount().username 
            val textView: TextView = findViewById(R.id.accountText) 
            textView.text = "Cached account found: $accountName" 
        } 
 
        private fun displaySignedOutState() { 
            val textView: TextView = findViewById(R.id.accountText) 
            textView.text = "No cached account found" 
        } 
    }
```

- Retrieve the cached account by using the `**getCurrentAccount(),**` which returns an object, `**accountResult**`.
- If an account is found in persistence, use `**GetAccountResult.AccountFound**` to display a signed-in state.
- Otherwise, use `**GetAccountResult.NoAccountFound**` to display a signed-out state.

Make sure you include the import statements. Android Studio should include the import statements for you automatically.

::: zone-end

::: zone pivot="iosmacos"

If you have an iOS/macOS project, go ahead and open it in Xcode then proceed to the next unit.

### If you don't have an iOS/macOS project

If you don't have an iOS/macOS project, you can create one on Xcode.

## Add the MSAL framework to an iOS/macOS app

1. Open your iOS/macOS project in Xcode.
1. Select **Add Package Dependencies...** from the **File** menu.
1. Enter `**https://github.com/AzureAD/microsoft-authentication-library-for-objc**` as the Package URL and choose **Add Package**.
1. Add a new keychain group to your project **Capabilities**. Use `**com.microsoft.adalcache**` on iOS and `**com.microsoft.identity.universalstorage**` on macOS.

## Create SDK instance

1. Import the MSAL library into your view controller by adding `**import MSAL**` at the top of your `**ViewController**` class.
1. Add a `**nativeAuth**` member variable to your `**ViewController**` class by adding the following code just before the `**viewDidLoad()**` function:

   ```Swift
   var nativeAuth: MSALNativeAuthPublicClientApplication!
   ```

1. Next, add the following code to the `**viewDidLoad()**` function:

   ```Swift
   do {
       nativeAuth = try MSALNativeAuthPublicClientApplication(
           clientId: "Enter_the_Application_Id_Here",
           tenantSubdomain: "Enter_the_Tenant_Subdomain_Here",
           challengeTypes: [.OOB]
       )
   
       print("Initialized Native Auth successfully.")
    } catch {
       print("Unable to initialize MSAL \(error)")
    }
   ```

1. Replace the following values with the values from the Microsoft Entra admin center:

   - Find the `Enter_the_Application_Id_Here` value and replace it with the `**Application (client) ID**` of the app you registered earlier.
   - Find the `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your Directory (tenant) subdomain, learn how to [read your tenant details](/entra/external-id/customers/how-to-create-external-tenant-portal).

1. The challenge types are a list of values, which the app uses to notify Microsoft Entra about the authentication method that it supports.
      - For sign-up and sign-in flows with email one-time passcode, use [.OOB].
      - For sign-up and sign-in flows with email and password, use [.OOB, .password].
      - For self-service password reset (SSPR), use [.OOB].

1. To build, select the **Product** > **Build** in your project's toolbar.

## MSAL Logging configuration

MSAL provides a logging API that you can use to enable and configure logging. To see all debug output from MSAL add the following code at the start of the `**viewDidLoad()**` function:

```Swift
MSALGlobalConfig.loggerConfig.logLevel = .verbose
MSALGlobalConfig.loggerConfig.setLogCallback { logLevel, message, containsPII in
   if !containsPII {
      print("MSAL: \(message ?? "")")
   }
}
```

This outputs all debug logs from MSAL, which can be helpful in diagnosing issues and learning how the native authentication flows work.

::: zone-end
