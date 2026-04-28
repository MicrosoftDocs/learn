Choose the best response for each of the questions. Then select **Check your answers**.

## quiz title: Check your knowledge

## Multiple Choice

What is the typical use case for OAuth2SAML Bearer SSO method in SAP RISE?
( ) Web GUI, SAP Enterprise Portal. {{Incorrect. Web GUI and SAP Enterprise Portal are typically used with SPNEGO SSO method, not SAML/OAuth.}}
(x) Microsoft Copilot, Microsoft Power Platform, Microsoft Teams, SAP Fiori, Web GUI, Portal. {{Correct. SAML/OAuth SSO method is typically used with SAP Fiori, Web GUI, Portal, and HANA.}}
( ) SAP GUI. {{Incorrect. SAP GUI is typically used with SNC SSO method, not SAML/OAuth.}}

## Multiple Choice
What is the recommended migration path for SAP Identity Management (SAP IDM) users?
( ) Continue using SAP IDM beyond 2027.{{Incorrect. SAP has announced the retirement of SAP IDM by 2027.}}
(x) Migrate to Microsoft Entra ID Governance. {{Correct. SAP recommends its IDM users to migrate to Microsoft Entra ID Governance.}}
( ) Migrate to SAP Cloud Identity Service. {{Incorrect. While SAP Cloud Identity Service is integrated with Microsoft Entra, it is not the recommended migration path for SAP IDM users.}}

## Multiple Choice
What is the main function of Microsoft Security Copilot in relation to SAP RISE/ECS?
( ) It provides a stand-alone experience for SAP RISE/ECS incidents. {{Incorrect. While it does provide a stand-alone experience, its main function is to empower security and IT professionals to respond to cyber threats.}}
(x) It empowers security and IT professionals to respond to cyber threats, correlate signals across the whole enterprise, and assess risk exposure at the speed and scale of AI. {{Correct. Microsoft Security Copilot's main function is to empower security and IT professionals to respond to cyber threats, correlate signals, and assess risk exposure at the speed and scale of AI.}}
( ) It is an AI-generated summary tool for SAP RISE/ECS incidents. {{Incorrect. Although it does generate AI summaries, its primary role is to aid in responding to cyber threats.}}

## Multiple Choice
What does the Microsoft Sentinel solution for SAP applications enable?
( ) It only works with SAP systems hosted on Azure. {{Incorrect. The solution works with SAP systems hosted on Azure, other clouds, or on-premises infrastructure.}}
(x) It allows monitoring, detection, and response to suspicious activities on SAP systems hosted on Azure, other clouds, RISE, or on-premises infrastructure. {{Correct. The Microsoft Sentinel solution provides comprehensive security capabilities for SAP applications anywhere.}}
( ) It only monitors user activities on SAP RISE/ECS and the SAP business logic layers. {{Incorrect. While it does monitor user activities, it also allows detection and response to suspicious activities, and customization based on needs.}}

## Multiple Choice
What does the SAP LogServ add-on provide for Microsoft Sentinel that the agentless data connector does not?
( ) SAP application-layer audit logs and user activity data. {{Incorrect. Application-layer logs are already provided by the agentless data connector through RFC calls.}}
(x) Infrastructure and SAP HANA database logs from the SAP-managed environment. {{Correct. LogServ extends Sentinel coverage to infrastructure and HANA database logs that are otherwise not accessible to customers under the RISE shared responsibility model.}}
( ) SAP BTP audit logs from the Audit Log Management service. {{Incorrect. SAP BTP audit logs are provided by the separate Microsoft Sentinel solution for SAP BTP, not by LogServ.}}

## Multiple Choice
What is a common first scenario for using prebuilt playbooks for security, orchestration, automation, and response capabilities (SOAR) with Microsoft Sentinel?
(x) SAP user blocking with intervention option from Microsoft Teams. {{Correct. The content mentions SAP user blocking with intervention option from Microsoft Teams as a popular first scenario.}}
( ) Automated email response to detected threats. {{Incorrect. While automated responses are part of SOAR capabilities, the content does not mention email responses as a common first scenario.}}
( ) Automatic system shutdown upon threat detection. {{Incorrect. The content does not mention system shutdowns as a common first scenario for using SOAR capabilities.}}

## Multiple Choice
What is the relationship between Azure Monitoring for SAP solutions and SAP RISE/ECS?
( ) SAP RISE/ECS integrates with Azure Monitoring for SAP solutions to provide enhanced monitoring capabilities. {{Incorrect. SAP RISE/ECS does not support any integration with Azure Monitor for SAP solutions.}}
(x) SAP RISE/ECS is a fully managed service that doesn't support any integration with Azure Monitor for SAP solutions. {{Correct. SAP's own monitoring and reporting is used and provided to the customer as defined by your service description with SAP.}}
( ) Azure Monitoring for SAP solutions is used to monitor SAP RISE/ECS environments. {{Incorrect. Azure Monitoring for SAP isn't intended to be utilized for such managed environment like SAP RISE/ECS.}}