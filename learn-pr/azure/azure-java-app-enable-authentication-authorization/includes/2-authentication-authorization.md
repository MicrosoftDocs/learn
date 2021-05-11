<!-- Guidance on writing the opening to a content/conceptual unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

<!-- 

See here for general guidance on content units: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-structure-learning-content?branch=master

-->

You learn that your organization uses Azure Active Directory (Azure AD) as the Identity provider for authentication and authorization. 

In this unit, you'll learn about authentication, authorization and how it is supported in Azure AD.

Azure AD provides authentication and authorization service by supporting modern authentication protocols such as OAuth 2.0 and OpenID Connect in a standards-compliant way. This allows you to use open-source libraries such as Microsoft Authentication Library (MSAL) and other standard-compliant libraries with Azure AD. Here is a brief summary of the distinction between authentication and authorization.

## Authentication

**Authentication** refers to the process of establishing and verifying the identity of the end-user who is accessing an application. 

Azure AD uses the OpenID Connect protocol to handle authentication. OpenID Connect allows applications to obtain basic information about the authenticated user and session.

## Authorization

**Authorization** is the process of ensuring that an authenticated user has the permission to perform some operation or access some data. 

The OAuth 2.0 protocol is used to provide authorization flows for different application in Azure AD.