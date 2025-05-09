::: zone pivot="android"

## Sign in a user

To sign in a user using the one-time passcode, collect the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them in.

To sign in a user using username (email) and password, collect the email and password from the user. If the username and password are valid, the app signs in the user.

To sign in a user, you need to create a user interface (UI) to:

- Collect an email from the user. Add validation to your inputs to make sure the user enters a valid emails address.
- Collect a password if you sign in with username (email) and password.
- Collect an email one-time passcode from the user if you sign in with email one-time passcode.
- Resend one-time passcode (recommended) if you sign in with email one-time passcode.

In your UI, add a button, whose select event starts a sign-in as shown in the following code snippet:

  ```Kotlin
      CoroutineScope(Dispatchers.Main).launch {
           val parameters = NativeAuthSignInParameters(username = email)
           // Assign 'password' param if you sign in with username (email) and password
           // parameters.password = password
           val actionResult: SignInResult = authClient.signIn(parameters)
      
           if (actionResult is SignInResult.CodeRequired) {
               val nextState = actionResult.nextState
               val submitCodeActionResult = nextState.submitCode(
                   code = code
               )
               if (submitCodeActionResult is SignInResult.Complete) {
                   // Handle sign in success
                   val accountState = submitCodeActionResult.resultValue
      
                   val getAccessTokenParameters = NativeAuthGetAccessTokenParameters()
                   val accessTokenResult = accountState.getAccessToken(getAccessTokenParameters)
      
                   if (accessTokenResult is GetAccessTokenResult.Complete) {
                       val accessToken = accessTokenResult.resultValue.accessToken
                       val idToken = accountState.getIdToken()
                   }
               }
           }
       }
      ```

If the user isn't required to submit a passcode, such as where a user signs in with email and password, use the following code snippet:

      ```Kotlin
      CoroutineScope(Dispatchers.Main).launch {
          val parameters = NativeAuthSignInParameters(username = email)
          parameters.password = password
          val actionResult: SignInResult = authClient.signIn(parameters)
      
          if (actionResult is SignInResult.Complete) -> {
              // Handle sign in success
              val accountState = actionResult.resultValue
      
              val getAccessTokenParameters = NativeAuthGetAccessTokenParameters()
              val accessTokenResult = accountState.getAccessToken(getAccessTokenParameters)
      
              if (accessTokenResult is GetAccessTokenResult.Complete) {
                  val accessToken = accessTokenResult.resultValue.accessToken
                  val idToken = accountState.getIdToken()
              }
          }
      }
      ```
  
- To start the sign-in flow, use the SDK's `signIn(parameters)` method.
- An instance of the `NativeAuthSignInParameters` class, containing the `username` that is the email address you collect from the user.
- If the sign-in method is username (email) and password, the method's parameter, `password` is then password you collect from the user.
- In most common scenario, the signIn(parameters) returns a result, `SignInResult.CodeRequired`, which indicates that the SDK expects the app to submit the email one-time passcode sent to the user's emails address.
- The `SignInResult.CodeRequired` object contains a new state reference, which we can retrieve through `actionResult.nextState`.
- The new state gives us access to two new methods:

    - `submitCode()` submits the email one-time passcode that the app collects from the user.
    - `resendCode()` resends the email one-time passcode if the user doesn't receive the code.

## Handle sign-in errors

During sign-in, not all actions succeed. For instance, the user might attempt to sign in with an email address that doesn't exist or submit an invalid code.

### Handle sign-in start errors

To handle errors in the `signIn(parameters)` method, use the following code snippet:

```Kotlin
    val parameters = NativeAuthSignInParameters(username = email)
     // Assign 'password' param if you sign in with username (email) and password
     // parameters.password = password
    val actionResult: SignInResult = authClient.signIn(parameters)

    if (actionResult is SignInResult.CodeRequired) {
    // Next step: submit code
        } else if (actionResult is SignInError) {
    // Handle sign in errors
    when {
         actionResult.isUserNotFound() -> {
             // Handle "user not found" error
         }
         actionResult.isAuthNotSupported() -> {
             // Handle "authentication type not support" error
         }
         actionResult.isInvalidCredentials() -> {
             // Handle specific errors
         }
         else -> {
             // Handle other errors
         }
     }
}
```

- `SignInError` indicates an unsuccessful action result returned by `signIn(parameters)`, so the action result doesn't include a reference to the new state.
- If `actionResult is SignUpError`, the Android SDK provides utility methods to enable you to analyze the specific errors further:
- The method `isUserNotFound()` checks whether the user signs in with a username (email address) that doesn't exist.
- The method `isBrowserRequired()` checks the need for a browser (web fallback), to complete authentication flow. This scenario happens when native authentication isn't sufficient to complete the authentication flow. For examples, an admin configures email and password as the authentication method, but the app fails to send _password_ as a challenge type or simply doesn't support it. Use the steps in [Support web fallback in Android app](/entra/identity-platform/tutorial-native-authentication-android-support-web-fallback) to handle scenario when it happens.
- The method isAuthNotSupported() checks whether the app sends a challenge type that Microsoft Entra doesn't support, that's a challenge type value other than _oob_ and _password_. Learn more about [challenge types](/entra/identity-platform/concept-native-authentication-challenge-types).
- For username (email) and password sign-in, the method isInvalidCredentials() checks whether the combination of username and password is incorrect.

### Handle submit code errors

To handle errors in `submitCode()` method, use the following code snippet:

```Kotlin
val submitCodeActionResult = nextState.submitCode(
    code = code
)
if (submitCodeActionResult is SignInResult.Complete) {
    // Sign in flow complete, handle success state.
} else if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode()) {
    // Handle "invalid code" error
}
```

- The `SubmitCodeError` error indicates an unsuccessful action result returned by `submitCode()` and so the action result doesn't include a reference to the new state.
- The `isInvalidCode()` checks for the specific error. In this case, the previous state reference must be used to reperform the action.

To retrieve the new email one-time passcode, use the following code snippet:

```Kotlin
val submitCodeActionResult = nextState.submitCode(
    code = code
)
if (submitCodeActionResult is SignInError && submitCodeActionResult.isInvalidCode) {
    // Inform the user that the submitted code was incorrect or invalid, then ask them to input a new email one-time passcode
    val newCode = retrieveNewCode()
    nextState.submitCode(
        code = newCode
    )
}
```

Once all the necessary steps to successfully sign in a user on your app are complete, build and run your application. If all good, you should be able to provide an email, receive a code on the email, and use that to successfully sign in user.

## Read ID token claims

Once your app acquires an ID token, you can retrieve the claims associated with the current account. To do so, use the following code snippet.

```Kotlin
val preferredUsername = accountState.getClaims()?.get("preferred_username")
val city = accountState.getClaims()?.get("City")
val givenName = accountState.getClaims()?.get("given_name")
//custom attribute
val loyaltyNumber = accountState.getClaims()?.get("loyaltyNumber")
```

The key you use to access the claim value is the name that you specify when you add the user attribute as a token claim.

## Sign out a user

To sign out a user, you need to remove the account currently stored in the cache.

1. Create your custom user interface (UI) that includes:
   - A sign out button that user select to send a sign out request.

1. To sign out a user, use the following code:

      ```Kotlin
      private fun performSignOut(accountState: AccountState) {
           CoroutineScope(Dispatchers.Main).launch {
               val accountResult = authClient.getCurrentAccount()
               if (accountResult is GetAccountResult.AccountFound) {
                   val signOutResult = accountResult.resultValue.signOut()
                   if (signOutResult is SignOutResult.Complete) {
                       // Show sign out successful UI
                   }
               }
           }
       }
      ```

## Handle sign out errors

Sign out should be error-free. If any errors occur, inspect the error result using the following code snippet:

```Kotlin
val actionResult = accountResult.signOut()
if (actionResult is SignOutResult.Complete) {
    // Show sign out successful UI
} else {
    // Handle errors
}
```

Make sure you include the import statements. Android Studio should include the import statements for you automatically.

Once all the necessary steps to successfully sign out a user on your app are complete, build and run your application. If all good, you should be able to select sign out button to successfully sign out.

::: zone-end

::: zone pivot="iosmacos"

## Sign in user

To sign in a user using the **Email one-time passcode** flow, capture the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them in.

To sign in a user using the **Email with password** flow, capture the email and password. If the username and password are valid, the app signs in the user.

To sign in a user, you need to:

1. Create a user interface (UI) to:

      - Collect an email from the user. Add validation to your inputs to make sure the user enters a valid emails address.
      - Collect a password if you sign in with username (email) and password.
      - Collect an email one-time passcode from the user if you sign in with email one-time passcode.
      - Add a button to let the user resend one-time passcode if you sign in with email one-time passcode.

1. In your UI, add a button, whose select event starts a sign-in as shown in the following code snippet:

   ```Swift
   @IBAction func signInPressed(_: Any) {
       guard let email = emailTextField.text else {
           resultTextView.text = "email not set"
           return
       }
   
       let parameters = MSALNativeAuthSignInParameters(username: email)
       nativeAuth.signIn(parameters: parameters, delegate: self)
   }
   ```

   To sign in a user using **Email one-time passcode** flow, we use the following code snippet:

   ```Swift
   nativeAuth.signIn(parameters: parameters, delegate: self)
   ```

   The `signIn(parameters:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, must implement the `SignInStartDelegate` protocol. We pass an instance of `MSALNativeAuthSignInParameters` which contains the email address that the user provides in the email submission form and pass self as the delegate.

   To sign in a user using **Email with password** flow, we use the following code snippet:

   ```Swift
   let parameters = MSALNativeAuthSignInParameters(username: email)
   parameters.password = password
   nativeAuth.signIn(parameters: parameters, delegate: self)
   ```

   In the `signIn(parameters:delegate)` method, you pass an instance of `MSALNativeAuthSignInParameters` which contains the email address that the user supplied us with and their password, alongside with the delegate object that conforms to the `SignInStartDelegate` protocol. For this example, we pass `self`.

1. To implement `SignInStartDelegate` protocol when you use **Email one-time passcode** flow, use the following code snippet:

   ```Swift
   extension ViewController: SignInStartDelegate {
       func onSignInStartError(error: MSAL.SignInStartError) {
           resultTextView.text = "Error signing in: \(error.errorDescription ?? "no description")"
       }
   
       func onSignInCodeRequired(
           newState: MSAL.SignInCodeRequiredState,
           sentTo: String,
           channelTargetType: MSAL.MSALNativeAuthChannelType,
           codeLength: Int
       ) {
           resultTextView.text = "Verification code sent to \(sentTo)"
       }
   }
   ```

The `signIn(parameters:delegate)` results in a call to delegate methods. In the most common scenario, `onSignInCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Along with some details of where the code has been sent, and how many digits it contains, this delegate method also has a `newState` parameter of type `SignInCodeRequiredState`, which gives us access to the following two new methods:

- `submitCode(code:delegate)`
- `resendCode(delegate)`

Use `submitCode(code:delegate)` to submit the one-time passcode that user supplies in one-time passcode form, use the following code snippet:

   ```Swift
   newState.submitCode(code: userSuppliedCode, delegate: self)
   ```

The `submitCode(code:delegate)` accepts the one-time passcode and delegate parameter. After submitting the code, you must verify the one-time passcode by implementing the `SignInVerifyCodeDelegate` protocol.

To implement `SignInVerifyCodeDelegate` protocol as an extension to your class, use the following code snippet:

```Swift
extension ViewController: SignInVerifyCodeDelegate {
    func onSignInVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignInCodeRequiredState?) {
        resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
    }

    func onSignInCompleted(result: MSALNativeAuthUserAccountResult) {
        resultTextView.text = "Signed in successfully."
        let parameters = MSALNativeAuthGetAccessTokenParameters()
        result.getAccessToken(parameters: parameters, delegate: self)
    }
}
```

In the most common scenario, we receive a call to `onSignInCompleted(result)` indicating that the user has signed in. The result can be used to retrieve the `access token`.

The `getAccessToken(parameters:delegate)` accepts a `MSALNativeAuthGetAccessTokenParameters` instance and a delegate parameter and we must implement the required methods in the `CredentialsDelegate` protocol.

In the most common scenario, we receive a call to `onAccessTokenRetrieveCompleted(result)` indicating that the user obtained an `access token`.

```Swift
extension ViewController: CredentialsDelegate {
    func onAccessTokenRetrieveError(error: MSAL.RetrieveAccessTokenError) {
        resultTextView.text = "Error retrieving access token"
    }

    func onAccessTokenRetrieveCompleted(result: MSALNativeAuthTokenResult) {
        resultTextView.text = "Signed in. Access Token: \(result.accessToken)"
    }
}
```

1. To implement `SignInStartDelegate` protocol when you use **Email with password** flow, use the following code snippet:

```Swift
extension ViewController: SignInStartDelegate {
    func onSignInStartError(error: MSAL.SignInStartError) {
        resultTextView.text = "Error signing in: \(error.errorDescription ?? "no description")"
    }

    func onSignInCompleted(result: MSAL.MSALNativeAuthUserAccountResult) {
        // User successfully signed in
    }
}
```

In the most common scenario, we receive a call to `onSignInCompleted(result)` indicating that the user has signed in. The result can be used to retrieve the `access token`.

The `getAccessToken(parameters:delegate)` accepts a `MSALNativeAuthGetAccessTokenParameters` instance and a delegate parameter and we must implement the required methods in the `CredentialsDelegate` protocol.

In the most common scenario, we receive a call to `onAccessTokenRetrieveCompleted(result)` indicating that the user obtained an `access token`.

```Swift
extension ViewController: CredentialsDelegate {
    func onAccessTokenRetrieveError(error: MSAL.RetrieveAccessTokenError) {
        resultTextView.text = "Error retrieving access token"
    }

    func onAccessTokenRetrieveCompleted(result: MSALNativeAuthTokenResult) {
        resultTextView.text = "Signed in. Access Token: \(result.accessToken)"
    }
}
```

## Handle sign-in errors

During sign in, not every action succeeds. For example, the user might try to sign in with an email address that doesn't exist, or submit an invalid code.

1. To handle errors in the `signIn(parameters:delegate)` method, use the following code snippet:

      ```Swift
      func onSignInStartError(error: MSAL.SignInStartError) {
          if error.isUserNotFound || error.isInvalidUsername {
              resultTextView.text = "Invalid username"
          } else {
              resultTextView.text = "Error signing in: \(error.errorDescription ?? "no description")"
          }
      }
      ```

1. To handle errors in submitCode() method, use the following code snippet:

      ```Swift
      func onSignInVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignInCodeRequiredState?) {
          if error.isInvalidCode {
              // Inform the user that the submitted code was incorrect and ask for a new code to be supplied
              let userSuppliedCode = retrieveNewCode()
              newState?.submitCode(code: userSuppliedCode, delegate: self)
          } else {
              resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
          }
      }
      ```

      If the user enters an incorrect email verification code, the error handler includes a reference to a `SignInCodeRequiredState` that can be used to submit an updated code. In our earlier implementation of `SignInVerifyCodeDelegate` protocol, we simply displayed the error when we handled the `onSignInVerifyCodeError(error:newState)` delegate function.

## Ingest ID token claims

Once your app acquires an ID token, you can retrieve the claims associated with the current account. To do so, use the following code snippet:

```Swift
func onSignInCompleted(result: MSAL.MSALNativeAuthUserAccountResult) {
   let claims = result.account.accountClaims
   let preferredUsername = claims?["preferred_username"] as? String
}
```

The key you use to access the claim value is the name that you specify when you add the user attribute as a token claim.

## Sign out user

To sign out a user, use the reference to the `MSALNativeAuthUserAccountResult` that you received in the `onSignInCompleted` callback, or use `getNativeAuthUserAccount()` to get any signed in account from the cache and store a reference in the `accountResult` member variable.

1. Configure the keychain group for your project as described [here](/entra/identity-platform/tutorial-mobile-app-ios-swift-prepare-app).
1. Add a new member variable to your `ViewController` class: `var accountResult: MSALNativeAuthUserAccountResult?`.
1. Update `viewDidLoad` to retrieve any cached account by adding this line after `nativeAuth` is initialized successfully: `accountResult = nativeAuth.getNativeAuthUserAccount()`.
1. Update the `signInCompleted` handler to store the account result:

      ```Swift
      func onSignInCompleted(result: MSALNativeAuthUserAccountResult) {
          resultTextView.text = "Signed in successfully"
      
          accountResult = result
      }
      ```

1. Add a Sign Out button and use the following code to sign out user:

      ```Swift
      @IBAction func signOutPressed(_: Any) {
          guard let accountResult = accountResult else {
              print("Not currently signed in")
              return
          }
      
          accountResult.signOut()
      
          self.accountResult = nil
      
          resultTextView.text = "Signed out"
      }
      ```

You have successfully completed all the necessary steps to sign out a user on your app. Build and run your application. If all good, you should be able to select sign out button to successfully sign out.

::: zone-end
