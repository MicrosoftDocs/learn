Microsoft Entra seamless single sign-on (seamless SSO) automatically signs in users from their network-connected corporate desktops. Seamless SSO provides your users with easy access to cloud-based applications without needing any other on-premises components.

Seamless SSO can be combined with either the Password Hash Synchronization or Pass-through Authentication sign-in methods. Seamless SSO is not applicable to Active Directory Federation Services (ADFS).

## Key benefits

- Great user experience
   - Users are automatically signed into both on-premises and cloud-based applications.
   - Users don't have to enter their passwords repeatedly.
- Easy to deploy & administer
   - No additional components needed on-premises to make this work.
   - Works with any method of cloud authentication - Password Hash Synchronization or Pass-through Authentication.
   - Can be rolled out to some or all your users using Group Policy.

## How does sign-in on a web browser with Seamless SSO work?

The sign-in flow on a web browser is as follows:

1. The user tries to access a web application (for example, the Outlook Web App - `https://outlook.office365.com/owa/`) from a domain-joined corporate device inside your corporate network.

2. If the user isn't already signed in, the user is redirected to the Microsoft Entra sign-in page.

3. The user types in their user name into the Microsoft Entra sign-in page.

4. Using JavaScript in the background, Microsoft Entra ID challenges the browser, via a 401 Unauthorized response, to provide a Kerberos ticket.

5. The browser, in turn, requests a ticket from Active Directory for the AZUREADSSOACC computer account (which represents Microsoft Entra ID).

6. Active Directory locates the computer account and returns a Kerberos ticket to the browser encrypted with the computer account's secret.

7. The browser forwards the Kerberos ticket it acquired from Active Directory to Microsoft Entra ID.

8. Microsoft Entra ID decrypts the Kerberos ticket, which includes the identity of the user signed into the corporate device, using the previously shared key.

9. After evaluation, Microsoft Entra ID either returns a token back to the application or asks the user to perform additional proofs, such as multifactor authentication.

10. If the user sign-in is successful, the user is able to access the application.

## How does sign-in on a native client with Seamless SSO work?

The sign-in flow on a native client is as follows:

1. The user tries to access a native application (for example, the Outlook client) from a domain-joined corporate device inside your corporate network.
2. If the user isn't already signed in, the native application retrieves the username of the user from the device's Windows session.
3. The app sends the username to Microsoft Entra ID, and retrieves your tenant's WS-Trust MEX endpoint. This WS-Trust endpoint is used exclusively by the Seamless SSO feature, and isn't a general implementation of the WS-Trust protocol on Microsoft Entra ID.
4. The app then queries the WS-Trust MEX endpoint to see if integrated authentication endpoint is available. The integrated authentication endpoint is used exclusively by the Seamless SSO feature.
5. If step 4 succeeds, a Kerberos challenge is issued.
6. If the app is able to retrieve the Kerberos ticket, it forwards it up to Microsoft Entra integrated authentication endpoint.
7. Microsoft Entra ID decrypts the Kerberos ticket and validates it.
8. Microsoft Entra ID signs the user in, and issues a SAML token to the app.
9. The app then submits the SAML token to Microsoft Entra ID OAuth2 token endpoint.
10. Microsoft Entra ID validates the SAML token and issues an access token, a refresh token for the specified resource, and an ID token to the app.
11. The user gets access to the app's resource.
