Threat protection for AI workloads in Microsoft Defender for Cloud protects AI workloads on an Azure subscription by providing insights to threats that might affect your generative AI applications.

> [!IMPORTANT] 
>
> Threat protection for AI workloads is currently in preview. See the Supplemental Terms of Use for Microsoft Azure Previews for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

## Prerequisites
- Read the [Overview - AI threat protection](/azure/defender-for-cloud/ai-threat-protection).

- You need a Microsoft Azure subscription. If you don't have an Azure subscription, you can [sign up for a free subscription](https://azure.microsoft.com/pricing/free-trial/).

- [Enable Defender for Cloud on your Azure subscription](/azure/defender-for-cloud/get-started#enable-defender-for-cloud-on-your-azure-subscription).

- We recommend not opting out of prompt-based triggered alerts for [Azure OpenAI content filtering](/azure/ai-services/openai/concepts/content-filter). Opting out and removing that capability can affect Defender for Cloud's ability to monitor and detect such attacks.
  If you're accepted into the limited preview, you can enable threat protection for AI workloads on your Azure subscription.

## Enable threat protection for AI workloads

Enable threat protection for AI workloads.

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  Search for and select Microsoft Defender for Cloud.
3.  In the Defender for Cloud menu, select Environment settings.
4.  Select the relevant Azure subscription.
5.  On the Defender plans page, toggle the AI workloads to On.

## Enable user prompt evidence

With the AI workloads threat protection plan enabled, you can control whether alerts include suspicious segments directly from your user's prompts, or the model responses from your AI applications or resources. Enabling user prompt evidence helps you to triage and classify alerts and your user's intentions.

User prompt evidence consists of prompts and model responses. Both are considered your data. Evidence is available through the Azure portal, Defender portal, and any attached partners integrations.

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  Search for and select Microsoft Defender for Cloud.
3.  In the Defender for Cloud menu, select Environment settings.
4.  Select the relevant Azure subscription.
5.  Locate AI workloads and select Settings.

:::image type="content" source="../media/ai-workloads-defender-cloud-full-settings-monitoring.png" alt-text="Screenshot showing an example of ai workloads full settings.":::

6.  Toggle Enable user prompt evidence to On.

:::image type="content" source="../media/prompt-evidence-status.png" alt-text="Screenshot showing an example of the prompt evidence status settings.":::

7.  Select Continue.
