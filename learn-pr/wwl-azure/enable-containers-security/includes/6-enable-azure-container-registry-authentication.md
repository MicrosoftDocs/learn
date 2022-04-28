There are several ways to authenticate with an Azure container registry, each of which is applicable to one or more registry usage scenarios.

Recommended ways include authenticating to a registry directly via individual login, or your applications and container orchestrators can perform unattended, or "headless," authentication by using an Azure Active Directory (Azure AD) service principal.

## Authentication options

The following table lists available authentication methods and recommended scenarios.

:::row:::
  :::column:::
    **Identity**
  :::column-end:::
  :::column:::
    **Usage scenario**
  :::column-end:::
  :::column:::
    **Details**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure AD identities including user and service principals
  :::column-end:::
  :::column:::
    Unattended push from DevOps, unattended pull to Azure or external services
  :::column-end:::
  :::column:::
    Role-based access control - Reader, Contributor, Owner
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Individual AD Identity
  :::column-end:::
  :::column:::
    Interactive push/pull by developers and testers
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Admin user
  :::column-end:::
  :::column:::
    Interactive push/pull by individual developers and testers
  :::column-end:::
  :::column:::
    By default, disabled.
  :::column-end:::
:::row-end:::


## Individual login with Azure AD

When working with your registry directly, such as pulling images to and pushing images from a development workstation, authenticate by using the az acr login command in the Azure CLI. When you log in with az acr login, the CLI uses the token created when you executed az login to seamlessly authenticate your session with your registry. To complete the authentication flow, Docker must be installed and running in your environment. az acr login uses the Docker client to set an Azure Active Directory token in the docker.config file. Once you've logged in this way, your credentials are cached, and subsequent docker commands in your session do not require a username or password.

## Service principal

If you assign a service principal to your registry, your application or service can use it for headless authentication. Service principals allow role-based access to a registry, and you can assign multiple service principals to a registry. Multiple service principals allow you to define different access for different applications.

The available roles for a container registry include:

 -  AcrPull: pull
 -  AcrPush: pull and push
 -  Owner: pull, push, and assign roles to other users

## Admin account

Each container registry includes an admin user account, which is disabled by default. You can enable the admin user and manage its credentials in the Azure portal, or by using the Azure CLI or other Azure tools. The admin account is provided with two passwords, both of which can be regenerated. Two passwords allow you to maintain connection to the registry by using one password while you regenerate the other. If the admin account is enabled, you can pass the username and either password to the docker login command when prompted for basic authentication to the registry.
