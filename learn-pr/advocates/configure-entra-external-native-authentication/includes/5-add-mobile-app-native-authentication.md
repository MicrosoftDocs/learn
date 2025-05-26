::: zone pivot="android"

## Sign up a user

To sign up a user using the email one-time passcode or username (email) and password, you collect an email from the user, then send an email containing an email one-time passcode to the user. The user enters a valid email one-time passcode to validate their username.

To sign up a user, you need to:

1. Create a user interface (UI) to:

    - Collect an email from the user. Add validation to your inputs to make sure the user enters a valid emails address.
    - Collect a password if you sign up with username (email) and password.
    - Collect an email one-time passcode from the user.
    - If needed, collect user attributes.
    - Resend one-time passcode (recommended).
    - Start sign-up flow.

1. In your app, add a button, whose select event triggers the following code snippet:

    ```Kotlin
    CoroutineScope(Dispatchers.Main).launch {
         val parameters = NativeAuthSignUpParameters(username = email)
         // Assign 'password' param if you sign in with username (email) and password
         // parameters.password = password
         val actionResult: SignUpResult = authClient.signUp(parameters)
    
         if (actionResult is SignUpResult.CodeRequired) {
             val nextState = actionResult.nextState
             val submitCodeActionResult = nextState.submitCode(
                code = code
             )
             if (submitCodeActionResult is SignUpResult.Complete) {
                // Handle sign up success
             }
        }
    }
    ```

- Use the SDK's instance method, `**signUp(parameters)**` to start the sign-up flow.
- To sign up using username (email address) and password, create an instance of `**NativeAuthSignUpParameters**` class and assign your username and password.
- The sign-up parameter, `**username**`, is the email address you collect from the user.
- In most common scenario, the `**signUp(parameters)**` returns a result, `**SignUpResult.CodeRequired**`, which indicates that the SDK expects the app to submit the email one-time passcode sent to the user's emails address.
- The `**SignUpResult.CodeRequired**` object contains a new state reference, which we can retrieve through `**actionResult.nextState**`.
- The new state gives us access to two new methods:
  - `**submitCode()**` submits the email one-time passcode that the app collects from the user.
  - `**resendCode()**` resends the email one-time passcode if the user doesn't receive the code.
  - The `**submitCode()**` returns `**SignUpResult.Complete**`, which indicates that the flow is complete and the user has been signed up.
  - The `**signUp(parameters)**` can also return `**SignUpError**` to denote that an error has occurred.

## Collect user attributes during sign-up

Whether you sign up a user using email one-time passcode or username (email) and password, you can collect user attributes before a user's account is created:

- The `**NativeAuthSignUpParameters**` instance accepts an `attributes` parameter:

    ```Kotlin
    CoroutineScope(Dispatchers.Main).launch {
            val parameters = NativeAuthSignUpParameters(username = email)
            // Assign 'password' param if you sign in with username (email) and password
            // parameters.password = password
            parameters.attributes = userAttributes
            val actionResult: SignUpResult = authClient.signUp(parameters)
            //...
        }
    ```

- The Android SDK provides a utility class `**UserAttribute.Builder**` that you use to create user attributes. For example, to submit _city_ and _country_ user attributes, use the following code snippet to build the `**userAttributes**` variable:

    ```Kotlin
    val userAttributes = UserAttributes.Builder ()
        .country(country) 
        .city(city) 
        .build()
    ```

    The method names in the **UserAttribute.Builder** class are same as the programmable names of the user attributes that they build.

- The `**signUp(parameters)**` method can return `**SignUpResult.AttributesRequired**` to indicate that the app needs to submit one or more required attributes before Microsoft Entra creates an account. These attributes are configured by the administrator as mandatory in the Microsoft Entra admin center. Microsoft Entra doesn't explicitly request for optional user attributes.
- The `**SignUpResult.AttributesRequired**` result contains a `**requiredAttributes**` parameter. `**requiredAttributes**` is a list of `**RequiredUserAttribute**` objects that contains details about the user attributes that the app needs to submit. To handle `**actionResult is SignUpResult.AttributesRequired**`, use the following code snippet:

    ```Kotlin
    val parameters = NativeAuthSignUpParameters(username = email)
    // Assign 'password' param if you sign in with username (email) and password
    // parameters.password = password
    parameters.attributes = userAttributes
    val actionResult: SignUpResult = authClient.signUp(parameters)
    
    if (actionResult is SignUpResult.AttributesRequired) {
            val requiredAttributes = actionResult.requiredAttributes 
            // Handle "attributes required" result 
            val nextState = actionResult.nextState
            nextState.submitAttributes(
                attributes = moreAttributes
            )
    }
    ```

## Handle sign-up errors

During sign-up, not all actions succeed. For instance, the user might attempt to sign up with an already used email address or submit an invalid email one-time passcode.

## Handle start sign-up error

To handle errors for the `signUp()` method, use the following code snippet:

```Kotlin
val parameters = NativeAuthSignUpParameters(username = email)
 // Assign 'password' param if you sign in with username (email) and password
 // parameters.password = password
val actionResult: SignUpResult = authClient.signUp(parameters)

if (actionResult is SignUpResult.CodeRequired) {
    // Next step: submit code
} else if (actionResult is SignUpError) {
     when {
         actionResult.isUserAlreadyExists() -> {
             // Handle "user already exists" error
         }
         else -> {
             // Handle other errors
         }
     }
}
```

- `signUp(parameters)` can return `SignUpError`.
- `SignUpError` indicates an unsuccessful action result returned by `signUp()` and won't include a reference to the new state.
- If `actionResult is SignUpError`, MSAL Android SDK provides utility methods to enable you to analyze the specific errors further:
  - The method `isUserAlreadyExists()` checks whether the username has already been used to create an account.
  - `isInvalidAttributes()` checks whether one or more attributes that the app submitted failed validation, such as wrong data type. It contains an `invalidAttributes` parameter, which is a list of all attributes that the apps submitted, but failed validation.
  - `isInvalidPassword()` check the password is invalid, such as when the password doesn't meet all password complexity requirements.
  - `isInvalidUsername()` check the username is invalid, such as when the user email is invalid.
  - `isBrowserRequired()` checks the need for a browser (web fallback), to complete authentication flow. This scenario happens when native authentication isn't sufficient to complete the authentication flow. For examples, an admin configures email and password as the authentication method, but the app fails to send _password_ as a challenge type or simply doesn't support it. Use the steps in [Support web fallback in Android app](/entra/identity-platform/tutorial-native-authentication-android-support-web-fallback) to handle scenario when it happens.
  - `isAuthNotSupported()` checks whether the app sends a challenge type that Microsoft Entra doesn't support, that's a challenge type value other than _oob_ or _password_.

Notify the user that the email is already in use or some attributes are invalid by using a friendly message in the app's UI.

- To handle the error of invalid attributes, use the following code snippet:

```Kotlin
      val parameters = NativeAuthSignUpParameters(username = email)
      // Assign 'password' param if you sign in with username (email) and password
      // parameters.password = password
      parameters.attributes = userAttributes
      val actionResult: SignUpResult = authClient.signUp(parameters)
      
      if (actionResult is SignUpError && actionResult.isInvalidAttributes()) {
          val invalidAttributes = actionResult.invalidAttributes
      
          // Handle "invalid attributes" error, this time submit valid attributes
          val parameters = NativeAuthSignUpParameters(username = email)
          // Assign 'password' param if you sign in with username (email) and password
          // parameters.password = password
          parameters.attributes = userAttributes
          authClient.signUp(parameters)
      } 
      //...
      ```

## Handle submit email one-time passcode error

To handle errors for the `submitCode()` method, use the following code snippet:

  ```Kotlin
  val submitCodeActionResult = nextState.submitCode(
      code = code
  )
  if (submitCodeActionResult is SignUpResult.Complete) {
      // Sign up flow complete, handle success state.
  } else if (submitCodeActionResult is SubmitCodeError) {
      // Handle errors under SubmitCodeError
       when {
           submitCodeActionResult.isInvalidCode() -> {
               // Handle "code invalid" error
           }
           else -> {
               // Handle other errors
           }
       }
  }
  ```

- `submitCode()` can return `SubmitCodeError`.
- Use the `isInvalidCode()` method to check for the specific error, such as, the submitted code is invalid. In this case, the previous state reference must be used to reperform the action.
- To retrieve a new email one-time passcode, use the following code snippet:

```Kotlin
      val submitCodeActionResult = nextState.submitCode(
          code = code
      )
      if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode()) {
          // Inform the user that the submitted code was incorrect or invalid and ask for a new code to be supplied
          val newCode = retrieveNewCode()
          nextState.submitCode(
              code = newCode
          )
      }
      ```

Make sure you include the import statements. Android Studio should include the import statements for you automatically.

You've completed all the necessary steps to successfully sign up a user into your app. Build and run your application. If all good, you should be able to successfully sign up the user by using email one-time passcode or email and password.

::: zone-end

::: zone pivot="iosmacos"

# Sign up a user

To sign up a user using the email one-time passcode or username (email) and password, you collect an email from the user, then send an email containing an email one-time passcode to the user. The user enters a valid email one-time passcode to validate their username.

To sign up a user, you need to:

  1. Create a user interface (UI) to:

      - Collect an email from the user. Add validation to your inputs to make sure the user enters a valid email address.
      - Collect a password if you sign up with username (email) and password.
      - Collect an email one-time passcode from the user.
      - If needed, collect user attributes.
      - Resend one-time passcode if the user doesn't receive it.
      - Start sign-up flow.

  2. In your app, add a button, whose select event triggers the following code snippet:

      ```Swift
      @IBAction func signUpPressed(_: Any) {
          guard let email = emailTextField.text else {
              resultTextView.text = "Email or password not set"
              return
          }
      
          let parameters = MSALNativeAuthSignUpParameters(username: email)
          nativeAuth.signUp(parameters: parameters, delegate: self)
      }
      ```
      - To sign up a user using **Email one-time-passcode**, we use the library's `**signUp(parameters:delegate)**` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `**SignUpStartDelegate**` protocol. The following line of code initiates the user sign-up process:
    
        ```Swift
        nativeAuth.signUp(parameters: parameters, delegate: self)
        ```
    
        In the `**signUp(parameters:delegate)**` method, we pass a `**MSALNativeAuthSignUpParameters**` instance containing the user's email address from the submission form alongside the delegate (a class that implements the `**SignUpStartDelegate**` protocol).
    
      - To sign up a user using **Email with password**, use the following code snippets:
    
        ```Swift
        @IBAction func signUpPressed(_: Any) {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
               resultTextView.text = "Email or password not set"
               return
            }
        
            let parameters = MSALNativeAuthSignUpParameters(username: email)
            parameters.password = password
            nativeAuth.signUp(parameters: parameters, delegate: self)
        }    
        ```    
    
        We use the library's `**signUp(parameters:delegate)**` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `**SignUpStartDelegate**` protocol. The following line of code initiates the user sign-up process:
    
        ```Swift
        nativeAuth.signUp(parameters: parameters, delegate: self)
        ```
    
        In the `**signUp(parameters:delegate)**` method, we pass a `**MSALNativeAuthSignUpParameters**` instance containing the user's email address and their password alongside the delegate (a class that implements the `**SignUpStartDelegate**` protocol).
    
      - To implement `**SignUpStartDelegate**` protocol as an extension to our class, use:
    
        ```Swift
        extension ViewController: SignUpStartDelegate {
            func onSignUpStartError(error: MSAL.SignUpStartError) {
                resultTextView.text = "Error signing up: \(error.errorDescription ?? "no description")"
            }
        
            func onSignUpCodeRequired(
                newState: MSAL.SignUpCodeRequiredState,
                sentTo: String,
                channelTargetType: MSAL.MSALNativeAuthChannelType,
                codeLength: Int
            ) {
                resultTextView.text = "Verification code sent to \(sentTo)"
            }
        }
        ```

        The call to `**signUp(parameters:delegate)**` results in a call to either `**onSignUpCodeRequired()**` or `**onSignUpStartError()**` delegate methods. The `**onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)**` is called to indicate that a code has been sent to verify the user's email address. Along with some details of where the code has been sent, and how many digits it contains, this delegate method also has a `**newState**` parameter of type `**SignUpCodeRequiredState**`, which gives us access to two new methods:
          - `submitCode(code:delegate)`
          - `resendCode(delegate)`
    
        To submit the code that the user supplied us with, use:
          ```Swift
          newState.submitCode(code: userSuppliedCode, delegate: self)
          ```
      - To implement `SignUpVerifyCodeDelegate` protocol as an extension to our class, use:
    
          ```Swift
          extension ViewController: SignUpVerifyCodeDelegate {
              func onSignUpVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignUpCodeRequiredState?) {
                  resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
              }
          
              func onSignUpCompleted(newState: SignInAfterSignUpState) {
                  resultTextView.text = "Signed up successfully!"
              }
          }
          ```

        The `**submitCode(code:delegate)**` accepts a delegate parameter and we must implement the required methods in the `**SignUpVerifyCodeDelegate**` protocol. In the most common scenario, we receive a call to `**onSignUpCompleted(newState)**` indicating that the user has been signed up and the flow is complete.



# Collect user attributes during sign-up

Whether you sign up a user using email one-time passcode or username (email) and password, you can collect user attributes before a user's account is created. The `signUp(parameters:delegate)` method can be called using a `MSALNativeAuthSignUpParameters` which has an attributes property.

  1. To collect user attributes, use the following code snippet:
     
      ```Swift
      let attributes = [
          "country": "United States",
          "city": "Redmond"
      ]
      
      let parameters = MSALNativeAuthSignUpParameters(username: email)
      parameters.password = password
      parameters.attributes = attributes
      nativeAuth.signUp(parameters: parameters, delegate: self)
      ```

      The `**signUp(parameters:delegate)**` results in a call to either `**onSignUpCodeRequired()**` or `**onSignUpStartError()**` delegate methods, or in a call to `**onSignUpAttributesInvalid(attributeNames: [String])**` if it's implemented in the delegate.
  
  1. To implement the `**SignUpStartDelegate**` protocol as an extension to our class, use the following code snippet:
  
      ```Swift
      extension ViewController: SignUpStartDelegate {
          func onSignUpStartError(error: MSAL.SignUpStartError) {
              resultTextView.text = "Error signing up: \(error.errorDescription ?? "no description")"
          }
      
          func onSignUpCodeRequired(
              newState: MSAL.SignUpCodeRequiredState,
              sentTo: String,
              channelTargetType: MSAL.MSALNativeAuthChannelType,
              codeLength: Int
          ) {
              resultTextView.text = "Verification code sent to \(sentTo)"
          }
      
          func onSignUpAttributesInvalid(attributeNames: [String]) {
             resultTextView.text = "Invalid attributes  \(attributeNames)"
          }
      }
      ```
      
      If the attributes are invalid, the method `onSignUpAttributesInvalid(attributeNames: [String])` is called. In this case, we display the list of invalid attributes to the user. Otherwise, the `onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Apart from details such as the recipient of the code, and number of digits of the code, this delegate method has a `newState` parameter of type `SignUpCodeRequiredState`, which gives us access to two new methods:
      - `submitCode(code:delegate)`
      - `resendCode(delegate)`


## User attributes across one or more pages

To spread the attributes across one or more pages, we must set the attributes we intend to collect across different pages as mandatory in the customer identity and access management (CIAM) tenant configuration.

We call `**signUp(parameters:delegate)**` without passing any attributes in the `**MSALNativeAuthSignUpParameters**` instance. The next step will be to call `**newState.submitCode(code: userSuppliedCode, delegate: self)**` to verify user's email.

We implement the `**SignUpVerifyCodeDelegate**` protocol as an extension to our class as before, but this time we must implement the optional method `**onSignUpAttributesRequired(attributes:newState)**` in addition to the required methods:

```Swift
extension ViewController: SignUpVerifyCodeDelegate {
    func onSignUpAttributesRequired(newState: SignUpAttributesRequiredState) {
        resultTextView.text = "Attributes required"
    }

    func onSignUpVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignUpCodeRequiredState?) {
        resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
    }

    func onSignUpCompleted(newState: SignInAfterSignUpState) {
        resultTextView.text = "Signed up successfully!"
    }
}
```

This delegate method has a `newState` parameter of type `SignUpAttributesRequiredState`, which gives us access to a new method:

- `submitAttributes(attributes:delegate)`

To submit the attributes that the user supplied us with, use the following code snippet:

```Swift
let attributes = [
    "country": "United States",
    "city": "Redmond"
]

newState.submitAttributes(attributes: attributes, delegate: self)
```

We'll also implement the `SignUpAttributesRequiredDelegate` protocol as an extension to our class:

```Swift
extension ViewController: SignUpAttributesRequiredDelegate {
    func onSignUpAttributesRequiredError(error: AttributesRequiredError) {
        resultTextView.text = "Error submitting attributes: \(error.errorDescription ?? "no description")"
    }

    func onSignUpAttributesRequired(attributes: [MSALNativeAuthRequiredAttribute], newState: SignUpAttributesRequiredState) {
        resultTextView.text = "Attributes required"
    }

    func onSignUpAttributesInvalid(attributeNames: [String], newState: SignUpAttributesRequiredState) {
        resultTextView.text = "Attributes invalid"
    }

    func onSignUpCompleted(newState: SignInAfterSignUpState) {
        resultTextView.text = "Signed up successfully!"
    }
}
```

When the user doesn't provide all the required attributes, or the attributes are invalid, these delegate methods are called:

- `onSignUpAttributesInvalid`: indicates that one or more attributes that were sent failed input validation. This error contains an attributeNames parameter, which is a list of all attributes that were sent by the developer that failed input validation.
- `onSignUpAttributesRequired`: indicates that the server requires one or more attributes to be sent, before the user account can be created. This happens when one or more attributes is set as mandatory in the tenant configuration. This result contains attributes parameter, which is a list of `MSALNativeAuthRequiredAttribute` objects, which outline details about the user attributes that the API requires.

Both delegate methods contain a new state reference. We use the `newState` parameter to call `submitAttributes(attributes:delegate)` again with the new attributes.

## Handle errors in sign-up

During sign-up, not every action succeeds. For example, the user might try to sign up with an email address that's already in use, or submit an invalid code.

In our earlier implementation of `SignUpStartDelegate` protocol, we simply displayed the error when we handled the `onSignUpStartError(error)` delegate function.

To enhance the user experience by managing the particular error type, use the following code snippet:

```Swift
func onSignUpStartError(error: MSAL.SignUpStartError) {
    if error.isUserAlreadyExists {
        resultTextView.text = "Unable to sign up: User already exists"
    } else if error.isInvalidPassword {
        resultTextView.text = "Unable to sign up: The password is invalid"
    } else if error.isInvalidUsername {
        resultTextView.text = "Unable to sign up: The username is invalid"
    } else {
        resultTextView.text = "Unexpected error signing up: \(error.errorDescription ?? "no description")"
    }
}
```

::: zone-end
