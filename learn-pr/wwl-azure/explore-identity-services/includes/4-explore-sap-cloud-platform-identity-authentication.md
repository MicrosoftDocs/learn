


The SAP Cloud Platform Identity Authentication and Active Directory Federation Services enable you to implement SSO across applications or services that are protected by Azure AD (as an IdP) with SAP applications and services that are protected by SAP Cloud Platform Identity Authentication.

Currently, SAP Cloud Platform Identity Authentication acts as a Proxy Identity Provider to SAP applications. Azure Active Directory in turn acts as the leading Identity Provider in this setup.

The following diagram illustrates this relationship:

:::image type="content" source="../media/overview-of-sap-cloud-platform-identity-authentication-028c559c.png" alt-text="Diagram that illustrates the relationship between Azure Active Directory and S A P Cloud Identity Authentication. S A P Cloud Platform Identity Authentication acts as a Proxy Identity Provider to S A P applications. Azure Active Directory in turn acts as the leading Identity Provider in this setup.":::

With this setup, your SAP Cloud Platform Identity Authentication tenant is configured as a trusted application in Azure Active Directory. All SAP applications and services that you want to protect this way are then configured in the SAP Cloud Platform Identity Authentication management console. Therefore, the authorization for granting access to SAP applications and services needs to take place in SAP Cloud Platform Identity Authentication (as opposed to Azure Active Directory). By configuring SAP Cloud Platform Identity Authentication as an application through the Azure Active Directory Marketplace, you don't need to configure individual claims or SAML assertions.

At the time of authoring this content, only Web SSO has been tested by both parties. The flows that are necessary for App-to-API or API-to-API communication should work but have not been tested yet.
