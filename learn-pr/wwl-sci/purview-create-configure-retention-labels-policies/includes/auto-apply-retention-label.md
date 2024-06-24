Managing the lifecycle of your organization's content is crucial for meeting legal and regulatory requirements and for reducing risks. Automating the application of retention labels simplifies this process by organizing how content is kept or deleted based on specific rules. This ensures that important information is protected as long as needed and properly discarded when it's no longer necessary.

## What is automatic retention?

Automatic retention involves the application of predefined labels to content within an organization's digital environment. This method doesn't require manual intervention from end users, as the system identifies and labels content based on specified conditions such as sensitivity, keywords, or data type.

### Benefits of auto-labeling

- **Reduced need for user training**: Simplifies the process since users don't need to understand or remember how to apply labels.
- **Accuracy and consistency**: Ensures content is consistently classified according to organizational policies.
- **Focus on core responsibilities**: Allows users to concentrate on their primary tasks without being sidetracked by compliance requirements.

## What is simulation mode?

Simulation mode is a powerful feature in the setup of automatic retention policies. It allows you to test and refine your policies under controlled conditions before fully applying them across your organization. This mode operates similarly to the WhatIf parameter in PowerShell, offering a preview of how the policy would affect your content without making any permanent changes.

### Benefits of simulation mode

- **Testing before implementation**: You can see the potential effects of a retention policy without altering actual data.
- **Iterative refinement**: Based on simulation results, you can fine-tune the policy to ensure it meets your specific needs before going live.
- **Gradual expansion**: Start with a limited scope, like a single SharePoint site, and systematically broaden to more sites and data types, adjusting the policy as you scale up.

### How simulation mode works

1. **Policy configuration**: Begin by setting up your auto-labeling retention policy tailored to specific conditions such as sensitive information or particular keywords.
1. **Run simulation**: Execute the policy in simulation mode and wait for the analysis to complete.
1. **Review results**: Examine the simulated impacts, adjusting the policy parameters if the outcomes don't align with your expectations.
1. **Iterative testing**: Re-run the simulation with revised settings until you achieve the desired configuration.
1. **Deployment**: Once satisfied, activate the policy to start auto-applying retention labels across your organization.

### Considerations

Simulation mode is optional but beneficial, allowing you to test retention policies without impacting actual data. It's important to remember that content and conditions evolve, so policies might need updates over time. There are also limits on the number of simulations and the volume of data they can handle, which could affect larger organizations or complex environments. This mode enables a controlled, step-by-step approach to refining and deploying retention policies effectively.

## Before you begin

Before you begin setting up auto-apply retention label policies, ensure you meet the following prerequisites to successfully create and manage these policies:

- **Permissions**: Ensure you have the necessary permissions within the **Compliance Administrator** role group to create and manage retention labels. Alternative roles include **Retention Management** for active management and **View-Only Retention Management** for read-only access.
- **Auditing**: Make sure auditing for Microsoft 365 is enabled. Auditing needs to be on to run policies in simulation mode effectively.
- **Retention labels**: Ensure that the retention labels you plan on using are already created. This is important since these labels will be applied by the policy to the content meeting your specified conditions.

## Steps to implement automatic retention labels

The process to set up and use automatic retention involves several steps, each designed to ensure that the labels are applied accurately and effectively.

1. Navigate to **Auto-apply a label** in either the Microsoft Purview portal or Microsoft Purview compliance portal:

   - **Microsoft Purview portal**: [Sign in to the Microsoft Purview portal](https://purview.microsoft.com/)

      - If you're using records management: **Records management** > **Label policies** > **Auto-apply a label**.
      - If you're using data lifecycle management: **Data Lifecycle Management** > **Policies** > **Label policies** > **Auto-apply a label**.

   - **Microsoft Purview compliance portal**: [Sign in to the Microsoft Purview compliance portal](https://compliance.microsoft.com/) > **Solutions** > **Records management** > **File plan**.