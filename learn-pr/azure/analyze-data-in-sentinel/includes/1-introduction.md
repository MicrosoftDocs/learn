### Module scenario 

<!-- Marjan I believe we should start with a topic sentence before we have a heading. This is a global issue as all of the files start with a Heading 2. Can you please provide a single topic sentence to start the module?-->

Contoso, Ltd. is a midsize financial services company in London with a branch office in New York City. Contoso uses Microsoft 365, Microsoft Azure Active Directory (Azure AD), Azure AD Identity Protection, Cloud App Security, Microsoft Defender for Identity, Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Endpoint Protection, and Microsoft Azure Information Protection. <!--Marjan, This sentence is a very long list that would be better presented as a bullet list. Do we need to mention all of these items? Moreover, just saying that organization uses all of these items without elaborating what they are used for seems incomplete. We don;t have to add a sentence for each of these items but we should ideally at least state what overall end objective all these products are being used to achieve if we do need to list all of them. Maybe something along the lines of "Contoso uses several Microsoft products and services to implement data security and threat protection for its resources. These include:...Can you please advise?--> Contoso provides threat protection for its Azure-based and on-premises resources by using the paid version of Azure Security Center. The company also monitors and protects other non-Microsoft assets.
<!--LM: For "Endpoint Protection", please indicate System Center or Intune.--> 
<!--Marjan, can you please address Liz's comment too? Thanks-->

Security analysts at Contoso face a huge triage burden. They deal with a high volume of alerts from multiple products. They correlate alerts in the following ways:

- Manually from different project dashboards
- By using a traditional correlation engine

Additionally, the time spent to set up and maintain  the IT infrastructure at Contoso diverts the security operations (SecOps) team away from its security-related tasks. <!--Marjan, I need to check if we are okay to use SecOps as an abbreviation.-->

The IT director believes that using Azure Sentinel Analytics will help the security analysts perform complex investigations faster and improve the efficiency of their security tasks. As Contoso's lead system engineer and Azure administrator, you've been asked to set up analytics rules in Azure Sentinel so that the SecOps team can identify and stop cyber attacks.

In this module, you'll understand the importance of using Azure Sentinel Analytics, create and implement analytics rules from existing templates, create new rules and queries using the wizard, and manage rules with modifications.

By the end of this module, you'll be able to set up analytics rules in Azure Sentinel so that the SecOps team can identify and stop cyber attacks. <!--Marjan I added the last two  paragraphs because we need to list the main units of this module in a prose format as per the template. Please review.-->

## Learning objectives

After completing this module, you'll be able to:

- Explain the importance of using Azure Sentinel Analytics.
- Describe the different types of analytics rules available in Azure Sentinel Analytics.
- Create rules from templates.
- Create new rules and queries by using the wizard. <!-- Marjan, does the wizard have a name? Can we provide it here?>
- Manage rules with modifications.

## Prerequisites

<!-- MArjan, please see the following template instruction. Can you add the software requirements if any?
 In addition to listing the prerequisite knowledge and skills needed for this module, please be sure to list all necessary software requirements needed to complete any of the exercises within this module. -->
To get the best learning experience from this module, you should have knowledge of, and experience with, the following:

- Basic knowledge of Azure services
- Basic knowledge of operational concepts such as monitoring, logging, and alerting

<!-- If you have a BYOS in your module, please include the following Note alert. Replace display text and Pricing Calculator link. -->
> [!NOTE]
> If you choose to perform the exercise in this module, be aware you may incur costs in your Azure subscription. To estimate the cost, refer to [Replace this text with display text](insert URL from DevRel for the pricing calculator estimate here). <!--Marjan, I coped this from the template. Can you please update as needed?-->