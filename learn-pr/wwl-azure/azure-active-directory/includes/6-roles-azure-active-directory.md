
## Categories of Azure AD roles

Azure AD built-in roles differ in where they can be used, which fall into the following **three broad categories**.

1.  **Azure AD-specific roles**: These roles grant permissions to manage resources within Azure AD only. For example, **User Administrator**, **Application Administrator**, and **Groups Administrator** all grant permissions to manage resources that live in Azure AD.
2.  **Service-specific roles**: For major Microsoft 365 services (non-Azure AD), we have built service-specific roles that grant permissions to manage all features within the service. For example, Exchange Administrator, Intune Administrator, SharePoint Administrator, and Teams Administrator roles can manage features with their respective services. Exchange Administrator can manage mailboxes, Intune Administrator can manage device policies, SharePoint Administrator can manage site collections, Teams Administrator can manage call qualities, and so on.
3.  **Cross-service roles**: There are some roles that span services. We have two global roles - Global Administrator and Global Reader. All Microsoft 365 services honor these two roles. Also, there are some security-related roles like Security Administrator and Security Reader that grant access across multiple security services within Microsoft 365. **For example, using Security Administrator roles in Azure AD, you can manage Microsoft 365 Defender portal, Microsoft Defender Advanced Threat Protection, and Microsoft Defender for Cloud Apps**. Similarly, in the Compliance Administrator role, you can manage Compliance-related settings in the Compliance portal, Exchange, and so on.

:::image type="content" source="../media/azure-ad-roles-overlap-diagram-aa1f5a52.png" alt-text="Diagram showing how Azure Active Directory roles overlap.":::


The following table is offered as an aid to understanding these role categories. The categories are named arbitrarily and aren't intended to imply any other capabilities beyond the documented Azure AD role permissions.

:::row:::
  :::column:::
    

### Category


  :::column-end:::
  :::column:::
    

### Role


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure AD-specific roles
  :::column-end:::
  :::column:::
    Application AdministratorApplication DeveloperAuthentication AdministratorBusiness to consumer (B2C) Identity Experience Framework (IEF) Keyset AdministratorBusiness to consumer (B2C) Identity Experience Framework (IEF) Policy AdministratorCloud Application AdministratorCloud Device AdministratorConditional Access AdministratorDevice AdministratorsDirectory ReadersDirectory Synchronization AccountsDirectory WritersExternal ID User Flow AdministratorExternal ID User Flow Attribute AdministratorExternal Identity Provider AdministratorGroups AdministratorGuest InviterHelpdesk AdministratorHybrid Identity AdministratorLicense AdministratorPartner Tier1 SupportPartner Tier2 SupportPassword AdministratorPrivileged Authentication AdministratorPrivileged Role AdministratorReports ReaderUser Administrator
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cross-service roles
  :::column-end:::
  :::column:::
    Global AdministratorCompliance AdministratorCompliance Data AdministratorGlobal ReaderSecurity AdministratorSecurity OperatorSecurity ReaderService Support Administrator
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Service-specific roles
  :::column-end:::
  :::column:::
    Azure DevOps AdministratorAzure Information Protection AdministratorBilling AdministratorCustomer relationship management (CRM) Service AdministratorCustomer Lockbox Access ApproverDesktop Analytics AdministratorExchange Service AdministratorInsights AdministratorInsights Business LeaderIntune Service AdministratorKaizala AdministratorLync Service AdministratorMessage Center Privacy ReaderMessage Center ReaderModern Commerce UserNetwork AdministratorOffice Apps AdministratorPower BI Service AdministratorPower Platform AdministratorPrinter AdministratorPrinter TechnicianSearch AdministratorSearch EditorSharePoint Service AdministratorTeams Communications AdministratorTeams Communications Support EngineerTeams Communications Support SpecialistTeams Devices AdministratorTeams Administrator
  :::column-end:::
:::row-end:::


## 
