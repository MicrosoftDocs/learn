Users need to authenticate whenever they're accessing protected resources. In our scenario, the bank requires customers to sign in before they can access information. The bank uses Django as its web app development framework. In this unit, you learn how to sign in users to a Django web app that's registered in an Azure Active Directory (Azure AD) tenant.

## OAuth 2.0 authorization code flow

The OAuth 2.0 authorization code flow includes these steps:

1. When the application needs a user to sign in, or needs an access token to act on the user's behalf, it redirects the user to the Azure AD authorization endpoint for authentication.
1. After a successful sign-in, Azure AD redirects the user back to a specific URL in the app and includes an authorization code that only Azure AD can read.
1. The web app takes the authorization code, which is valid for a short time, and includes it in a request to the Azure AD token endpoint.

Azure AD issues your app with an ID token after the user is signed in. The app uses the header and signature of the ID token to verify the authenticity of the token. The payload contains the information about the user that the client requested.

## Sign-in process

The first step of the sign-in process is to send a request to the `/authorize` endpoint on Azure AD. Azure AD presents the user with a sign-in prompt. If the sign-in attempt is successful, the user's browser is redirected back to this app's `/redirect` endpoint. In our case, the redirect endpoint is `/auth/redirect`.

A successful request to this endpoint contains an authorization code. The web app uses this authorization code to acquire an ID token and an access token from Azure AD. The application is responsible for storing these tokens securely.

## Sign-in to a Django web app

For signing in users to a Django web app, use the `ms-identity-web` MSAL for Python. In the *aad.config.json* file, configure the following endpoints to be used during the authentication flow:

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

Register these URLs as MSAL URLs in the project's *urls.py* file:

```python
    from ms_identity_web.django.msal_views_and_urls import MsalViews
       
    msal_urls = MsalViews(settings.MS_IDENTITY_WEB).url_patterns()

    path(f'{settings.AAD_CONFIG.django.auth_endpoints.prefix}/', include(msal_urls)),
```

This code sets up middleware and hooks up all necessary endpoints for the authentication process into your Django app under a route prefix (`/auth` by default). For example, the `redirect` endpoint is at `/auth/redirect`.

When a user goes to `/auth/sign_in` and completes a sign-in attempt, the resulting identity data is put into the session. This data can be accessed through the request object at `request.identity_context_data`.

When an endpoint is decorated with `@ms_identity_web.login_required`, the application allows requests to the endpoint only from authenticated (signed-in) users. If the user isn't signed in, the app throws a `401: unauthorized` error, and the browser is redirected to the 401 handler.
