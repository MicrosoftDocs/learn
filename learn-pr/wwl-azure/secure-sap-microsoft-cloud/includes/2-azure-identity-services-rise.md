
This module details integration of Azure identity and security services with an SAP RISE workload. Additionally use of some Azure monitoring services are explained for an SAP RISE landscape.

## Single sign-on for SAP RISE

Single sign-On (SSO) is configured for many SAP environments. With SAP workloads running in ECS/RISE, steps to implement don't differ from a natively run SAP system. The integration steps with Microsoft Entra ID based SSO are available for typical ECS/RISE managed workloads:
- [Tutorial: Microsoft Entra Single sign-on (SSO) integration with SAP NetWeaver](/entra/identity/saas-apps/sap-netweaver-tutorial)
- [Tutorial: Microsoft Entra single sign-on (SSO) integration with SAP Fiori](/entra/identity/saas-apps/sap-fiori-tutorial)
- [Tutorial: Microsoft Entra integration with SAP HANA](/entra/identity/saas-apps/saphana-tutorial)

| SSO method | Identity Provider     | Typical use case                 | Implementation                    |
| :--------- | :-------------------: | :------------------------------- | :-------------------------------- |
| SAML/OAuth | Microsoft Entra ID    | SAP Fiori, Web GUI, Portal, HANA | Configuration by customer         |
| SNC        | Microsoft Entra ID    | SAP GUI                          | Configuration by customer         |
| SPNEGO     | Active Directory (AD) | Web GUI, SAP Enterprise Portal   | Configuration by customer and SAP |

SSO against Active Directory (AD) of your Windows domain for ECS/RISE managed SAP environment, with SAP SSO Secure sign in Client requires AD integration for end user devices. With SAP RISE, any Windows systems aren't integrated with the customer's active directory domain. The domain integration isn't necessary for SSO with AD/Kerberos as the domain security token is read on the client device and exchanged securely with SAP system. Contact SAP if you require any changes to integrate AD based SSO or using third party products other than SAP SSO Secure sign in Client.


For more information about SNC, see [Getting started with SAP SNC for RFC integrations - SAP blog](https://community.sap.com/t5/enterprise-resource-planning-blogs-by-members/getting-started-with-sap-snc-for-rfc-integrations/ba-p/13983462).

> [!NOTE]
> SAP [announced retirement](https://community.sap.com/t5/technology-blogs-by-sap/preparing-for-sap-identity-management-s-end-of-maintenance-in-2027/ba-p/13596101) of SAP Identity Management (SAP IDM) by 2027. [SAP recommends](https://community.sap.com/t5/technology-blogs-by-sap/preparing-for-sap-identity-management-s-end-of-maintenance-in-2027/ba-p/13596101) to customers to migrate to Microsoft Entra.

[Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview) and built-in integrations with SAP Cloud Identity Service are an ideal fit to handle SAP user lifecycle and their authorizations across both eco-systems.

Learn more from this [Microsoft Learn article](/entra/id-governance/scenarios/migrate-from-sap-idm) and the [SAP scenarios hub](https://microsoft.github.io/EntraIDGovernance-Training/SAPScenarios/).