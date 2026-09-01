Defender for Cloud needs a resource relationship or supported direct integration to protect a server outside Azure. Choose the onboarding model based on the management and protection capabilities you need.

For on-premises servers, choose one of these options:

- **Using Azure Arc-enabled servers** gives you Azure management capabilities and the broadest set of Defender for Servers features available to on-premises machines. Later in this module, you use an Azure portal script to deploy Azure Arc.
- **Direct Microsoft Defender for Endpoint onboarding** protects servers without the Azure Connected Machine agent. It provides Defender for Servers Plan 1 features. With Plan 2 enabled, it also provides Defender Vulnerability Management premium features, but other Plan 2 capabilities require Azure Arc.

This module uses Azure Arc because it provides the management and security integration expected in the AZ-1010 learning path.

For servers in Amazon Web Services (AWS) or Google Cloud, use Defender for Cloud's [AWS connector](/azure/defender-for-cloud/quickstart-onboard-aws) or [Google Cloud connector](/azure/defender-for-cloud/quickstart-onboard-gcp). Configure Azure Arc provisioning if your planned Defender for Servers features require it.
