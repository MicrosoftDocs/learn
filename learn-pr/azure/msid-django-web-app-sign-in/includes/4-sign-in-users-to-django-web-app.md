Users need to authenticate whenever they're accessing protected resources. In our scenario, the bank requires the customer to sign in before they're able to access information. The bank uses Django as its web app development framework. In this unit, you'll learn how to sign in users to a Django web app registered in an Azure Active Directory (Azure AD) tenant.

<!-- Pattern for simple chunks (repeat as needed) -->
## OAuth 2.0 authorization code flow

The OAuth 2.0 authorization code flow is common when websites or custom applications use Azure AD as a federated authentication provider. When the application needs a user to sign in, or needs an access token to act on their behalf, it redirects the user over to Azure AD’s authorization endpoint to authenticate. The user signs in using their email and password and in turn Azure AD redirects the user upon a successful sign-in back to a specific URL in the app.

When Azure AD redirects the user back to the web app, it includes an authorization code. The authorization code is an encoded string that only Azure AD can read. The web app takes this authorization code, which is valid for a short time, and includes it in a request to the Azure AD token endpoint.

## ID tokens

Apps can request for an ID token after successful sign-in. Azure AD issues your app with an ID token once the user is signed-in. ID tokens are JSON web tokens (JWT). These ID tokens consist of a header, payload, and signature. The header and signature are used to verify the authenticity of the token, while the payload contains the information about the user requested by your client.

<!-- Pattern for complex chunks (repeat as needed) -->
## Sign-in to a Django web app

When signing in users to a Django web app, we use the [Microsoft identity web Python library](). This library acts a wrapper of the MSAL for Python library and handles much of the required MSAL for Python configurations. In the *aad.config.json* file, we configure the following endpoints to be used during the auth flow.

```json
    "auth_endpoints": {
        "prefix": "auth",
        "sign_in": "sign_in",
        "edit_profile": "edit_profile",
        "redirect": "redirect",
        "sign_out": "sign_out",
        "post_sign_out": "post_sign_out"
    }
```

We register these urls as MSAL urls in the projects *urls.py* file.

```python
    from ms_identity_web.django.msal_views_and_urls import MsalViews
       
    msal_urls = MsalViews(settings.MS_IDENTITY_WEB).url_patterns()

    path(f'{settings.AAD_CONFIG.django.auth_endpoints.prefix}/', include(msal_urls)),
```

This code sets up middleware and hooks up all necessary endpoints for the authentication process into your Django app under a route prefix (*/auth* by default). For example, the redirect endpoint is found at */auth/redirect*.

When a user navigates to */auth/sign_in* and completes a sign-in attempt, the resulting identity data is put into the session. This data can be accessed through the request object at *request.identity_context_data*. When an endpoint is decorated with `@ms_identity_web.login_required`, the application only allows requests to the endpoint from authenticated (signed-in) users. If the user isn't signed-in, a `401: unauthorized` error is thrown, and the browser is redirected to the 401 handler.

## MSAL Python

The Microsoft identity web Python library uses MSAL for Python library under the hood. At a minimum, following parameters need to be provided to the MSAL for Python library:

- The **Client ID** of the app.
- The **Client Credential**, which is a requirement for a Web (Confidential Client) Application.
- The **Azure AD Authority**, which includes the *Tenant ID* of the Azure AD application in this sample's scenario.

The first step of the sign-in process is to send a request to the `/authorize` endpoint on Azure AD. An MSAL for Python `ConfidentialClientApplication` instance is created by *ms_identity_web* as shown:

```python
    client_instance = msal.ConfidentialClientApplication(
        client_id=CLIENT_ID,
        client_credential=CLIENT_CREDENTIAL,
        authority=AUTHORITY,
    )
```

The *client_instance* instance is used to construct a `/authorize` request URL with the appropriate parameters, and the browser is redirected to this URL. The user is presented with a sign-in prompt by Azure AD. If the sign-in attempt is successful, the user's browser is redirected back to this app's `/redirect` endpoint. In our case, the redirect endpoint is `/auth/redirect`. A successful request to this endpoint will contain an authorization code. The *client_instance* is used to exchange this authorization code for an ID Token and Access Token from Azure AD.

```python
token_acquisition_result = client_instance.acquire_token_by_authorization_code(authorization_code, SCOPES)
# this sends the authorization code to Azure AD's `/token` endpoint to request a token.
```

If the request is successful, MSAL for Python validates the signature and nonce of the incoming token. If these checks succeed, it returns the resulting *id_token*, *access_token* and plaintext *id_token_claims* in a dictionary. It's the application's responsibility to store these tokens securely.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->