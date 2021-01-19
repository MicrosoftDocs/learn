*Modern authentication* is an umbrella term for authentication and authorization methods between a client, such as your laptop or phone, and a server, such as a website or application. At the center of modern authentication is the role of the *identity provider*. An identity provider creates, maintains, and manages identity information while providing authentication, authorization, and auditing services.

With modern authentication, all services, including all authentication services, are provided by a central identity provider. The information that is used to authenticate the user with the server is stored and managed centrally by the identity provider.

With a central identity provider, organizations can establish authentication and authorization policies, monitor user behavior, identify suspicious activities, and reduce malicious attacks.  
Watch this video for more information about modern authentication and how it works with a central identity provider.

Watch this video for more information about modern authentication and how it works with a central identity provider.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4Kdt9 ]

As shown in the video, with modern authentication, the client communicates with the identity provider by providing an identity which can be authenticated. Once the identity (which can be a user or an application)  has been verified, the identity provider issues a *security token* which the client sends to the server. The server validates the security token through its *trust relationship* with the identity provider. By using the security token and the information that is contained within the token, the user or application can gain access to the required resources on the server. In this scenario, the token and the information contained in the token is stored and managed by the identity provider. The centralized identity provider is providing the authentication service.

Microsoft Azure Active Directory is an example of a cloud-based identity provider.  Other examples of identity providers include Twitter, Google, Amazon, LinkedIn, and GitHub.

## Single sign-on

Another fundamental capability of an identity provider and “modern authentication” is the support for single sign-on (SSO). With SSO, the user logs in once and that credential is used to access multiple applications or resources.
When you set up single sign-on to work between multiple identity providers, it is called federation.
