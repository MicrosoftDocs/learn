When you're standing up Privacy Risk Management for the first time, you don't yet know what a normal baseline of overexposure or transfer volume looks like in your environment. Templates get detection running fast so you can start seeing that baseline. They're the fastest way to turn your definition of risk into working detection.

Priva ships two templates, one for each risk shape:

- **Data overexposure** watches who can reach personal data at rest: SharePoint site permissions, OneDrive share links, and internal permissions that widened at some point and never got tightened. Pick this template when broad access to sensitive content is your primary concern.
- **Data transfers** covers movement instead. It watches for personal data leaving the organization, crossing between geographic regions, or moving between departments. This template fits when the risk you're managing is data crossing a boundary.

Many teams run both when they need coverage for both risk shapes, because each template catches different signals. Both come with defaults tuned to common regulations like HIPAA, and you can accept the defaults or step into the guided wizard to adjust.

## Quick setup with default settings

Follow these steps to quickly create a policy using default template settings:

1. Sign in to the [Priva portal](https://purview.microsoft.com/priva?azure-portal=true).
1. Navigate to the **Privacy Risk Management** solution card and select **Policies**.
1. Select **Create a policy** in the top-right corner to open the policy creation pane.
1. In the box for the template you want (**Data overexposure** or **Data transfers**), select **Create**.

   :::image type="content" source="../media/policy-template-options.png" alt-text="Screenshot showing the policy template options for Privacy Risk Management." lightbox="../media/policy-template-options.png":::

1. In the policy details pane, review the default settings by selecting **View settings**.

   - Adjust settings as needed by selecting **Edit settings**, which takes you into the guided custom setup.
   - To proceed with default settings, enter a descriptive name for the policy, then select **Create policy**.

   :::image type="content" source="../media/create-data-overexposure-from-template.png" alt-text="Screenshot showing the options when creating a Data overexposure policy." lightbox="../media/create-data-overexposure-from-template.png":::

Once created, the policy appears on your **Policies** page.

The policy starts in test mode, so it doesn't generate alerts or notifications yet. When you're ready, open the policy and turn it on.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
