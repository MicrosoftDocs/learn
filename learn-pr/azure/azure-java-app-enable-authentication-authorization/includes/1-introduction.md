Organizations need applications that can recognize users and control access to information. Microsoft Entra ID provides identity and access management services, while the Microsoft Authentication Library for Java (MSAL4J) provides APIs that help Java applications participate in authentication and token acquisition.

This module explains those responsibilities through a company-portal scenario and annotated code samples. All code is illustrative: the fragments show how the components interact, not complete applications to build or run. No Azure subscription, tenant access, credentials, IDE, or installed development environment is required.

## Example scenario

Consider a Java web application that displays information from a signed-in user's company profile. The organization wants the portal's sign-in audience to be accounts in its Microsoft Entra workforce tenant, including guest accounts. The portal also needs permission to read the signed-in user's profile through Microsoft Graph.

The scenario has three distinct concerns: identifying the application, authenticating the user, and obtaining authorized access to an API. An application registration, MSAL4J, and Microsoft Graph each address a different part of that design.

## What you'll learn

In this module, you:

- Explain how an application registration defines a Java web app's identity and sign-in audience.
- Trace an authorization-code sign-in flow through illustrative MSAL4J samples.
- Explain how delegated permissions and access tokens enable Microsoft Graph calls.

## What's the main goal?

The goal is to understand the relationships among app registration, browser sign-in, server-side token acquisition, and API authorization. The examples help distinguish what Microsoft Entra ID, MSAL4J, the application, and the Microsoft Graph SDK do, without requiring a hands-on lab.
