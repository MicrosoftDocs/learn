Azure Database for PostgreSQL supports Azure Active Directory authentication.

> [!NOTE]
> Azure Active Directory authentication is only supported on Azure Database for PostgreSQL single server. It is not currently supported on flexible server.

If you are running Azure Database for PostgreSQL single server, you can configure Azure Active Directory (AD) access and connect with an Azure AD token.

There are two main steps:

1. Create the Azure AD admin user and obtain an access token.
1. Connect using the token.
    :::image type="content" source="../media/post-azure-active-directory-authentication-flow.png" alt-text="Diagram of the Azure A D authentication flow." lightbox="../media/post-azure-active-directory-authentication-flow.png":::

Azure Data Studio is designed to work with Azure AD and will accept an Azure AD Account. This does not require a token.
