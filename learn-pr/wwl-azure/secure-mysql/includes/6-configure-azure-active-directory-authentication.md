If you are running Azure Database for MySQL single server, you can configure Azure Active Directory access and connect with an Azure AD token. Before configuring Azure Active Directory authentication, you must first create an Azure AD admin user. Each Azure Database for MySQL single server can have only one Azure AD admin user.

> [!NOTE]
> Azure Active Directory authentication is only available for Azure Database for MySQL single server running MySQL 5.7 and newer. Azure Active Directory authentication is not supported in Azure Database for MySQL Flexible Server.

There are two main steps:

1. Create the Azure AD admin user and obtain an access token.
1. Connect using the token.
    :::image type="content" source="../media/azure-active-directory-authentication-flow.png" alt-text="SCreenshot that shows the Azure AD authentication flow." lightbox="../media/azure-active-directory-authentication-flow.png":::
