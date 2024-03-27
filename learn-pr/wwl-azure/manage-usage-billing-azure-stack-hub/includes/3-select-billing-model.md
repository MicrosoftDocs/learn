You can choose either Pay-as-you-use or the Capacity billing model. Pay-as-you-use billing model deployments must be able to report usage through a connection to Azure at least once every 30 days. Therefore, the pay-as-you-use billing model is only available for connected deployments.

### Pay-as-you-use

With the pay-as-you-use billing model, usage is charged to an Azure subscription. You only pay when you use the Azure Stack Hub services. If this is the model you decide on, you'll need an Azure subscription and the account ID associated with that subscription. EA, CSP, and CSP Shared Services subscriptions are supported. Usage reporting is configured during [Azure Stack Hub registration](https://github.com/MicrosoftDocs/azure-stack-docs/blob/main/azure-stack/operator/azure-stack-registration.md).

In most cases, Enterprise customers will use EA subscriptions, and service providers will use CSP or CSP Shared Services subscriptions.

If you're going to use a CSP subscription, review the table below to identify which CSP subscription to use, as the correct approach depends on the exact CSP scenario:

| **Scenario**                                                                                     | **Domain and subscription options**                                                                                                                       |
| ------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| You're a Direct CSP Partner or an Indirect CSP Provider, and you'll operate the Azure Stack Hub. | Use a CSP Shared Services subscription.<br>or<br>Create a Microsoft Entra tenant with a descriptive name in Partner Center.                                     |
| You're an Indirect CSP Reseller, and you'll operate the Azure Stack Hub.                         | Ask your indirect CSP Provider to create a Microsoft Entra tenant for your organization with an Azure CSP subscription associated with it using Partner Center. |

### Capacity-based billing

If you decide to use the capacity billing model, you must purchase an Azure Stack Hub Capacity Plan SKU based on the capacity of your system. You need to know the number of physical cores in your Azure Stack Hub to purchase the correct quantity.

Capacity billing requires an Enterprise Agreement (EA) Azure subscription for registration. The reason is that registration sets up the availability of items in the Marketplace, which requires an Azure subscription. The subscription isn't used for Azure Stack Hub usage.
