The SAP Cloud Platform Identity Authentication and Active Directory Federation Services enable you to implement SSO across applications or services that are protected by Microsoft Entra ID (as an IdP) with SAP applications and services that are protected by SAP Cloud Platform Identity Authentication.

Currently, SAP Cloud Platform Identity Authentication acts as a Proxy Identity Provider to SAP applications. Microsoft Entra ID in turn acts as the leading Identity Provider in this setup.

The following diagram illustrates this relationship:

:::image type="content" source="../media/overview-sap-cloud-platform-identity-authentication-028c559c.png" alt-text="Diagram illustrates the relationship between Microsoft Entra ID and S A P Cloud Identity Authentication.":::

With this setup, your SAP Cloud Platform Identity Authentication tenant is configured as a trusted application in Microsoft Entra ID. All SAP applications and services that you want to protect this way are then configured in the SAP Cloud Platform Identity Authentication management console. Therefore, the authorization for granting access to SAP applications and services needs to take place in SAP Cloud Platform Identity Authentication (as opposed to Microsoft Entra ID). By configuring SAP Cloud Platform Identity Authentication as an application through the Microsoft Entra Marketplace, you don't need to configure individual claims or SAML assertions.

At the time of authoring this content, only Web SSO has been tested by both parties. The flows that are necessary for App-to-API or API-to-API communication should work but have not been tested yet.
