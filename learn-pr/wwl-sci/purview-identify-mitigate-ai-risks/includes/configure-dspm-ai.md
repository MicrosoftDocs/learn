Microsoft Purview Data Security Posture Management (DSPM) for AI helps organizations secure AI interactions, track AI-generated content, and enforce compliance policies. To use DSPM for AI effectively, organizations need to configure key settings, enable monitoring, and apply security controls.

## Prerequisites

Before configuring DSPM for AI, check that your environment meets these requirements:

- **[Check permissions](/purview/ai-microsoft-purview-permissions)**: Your account needs appropriate permissions in Microsoft Entra or Microsoft Purview, such as Compliance Administrator or a related role with compliance management permissions.
- **[Verify Microsoft Purview Audit is enabled](/purview/audit-log-enable-disable?tabs=microsoft-purview-portal#verify-the-auditing-status-for-your-organization)**: Auditing is on by default for new tenants, but it's a good idea to verify.
- **[Assign Copilot Licenses](/copilot/microsoft-365/microsoft-365-copilot-enable-users#assign-licenses)**: Users should be assigned Microsoft 365 Copilot licenses for activity tracking.
- **[Onboard Devices to Microsoft Purview](/purview/device-onboarding-overview)**: Devices need to be onboarded to Microsoft Purview to track AI interactions.
- **[Install the Microsoft Purview Browser Extension](/purview/insider-risk-management-browser-support#configure-browser-signal-detection-for-microsoft-edge)**: The Microsoft Purview browser extension is required to monitor third-party AI site visits.

## Steps to configure DSPM for AI

After completing the prerequisites, configure DSPM for AI in Microsoft Purview. This process includes enabling built-in policies, running data assessments, and verifying that AI-related security controls are in place.

1. Access DSPM for AI

   - Sign in to the Microsoft Purview portal.
   - Navigate to Solutions > DSPM for AI.

1. Review the Get Started Section

   - From the Overview page, review Get Started for initial actions.
   - Confirm that Audit Logging is enabled.
   - Enable Extend Insights for Data Discovery to track AI-generated content.
   - Activate One-Click Policies to apply built-in security controls.
1. Activate Preconfigured Policies

   - Go to Policies in the Microsoft Purview portal.
   - Review available AI security policies.
   - Enable recommended policies to detect sensitive data exposure and AI activity.
   - If needed, edit the policy scope before activation to apply policies only to specific users or groups instead of the entire organization.
   - Allow up to 24 hours for policies to take effect.

   Once activated, policies begin tracking AI interactions based on configured rules. Results appear in DSPM reports and Activity Explorer after data processing. If a policy is deleted, it remains visible with a PendingDeletion status until fully removed.

1. Run Data Assessments

   - DSPM for AI automatically runs weekly assessments on the top 100 SharePoint sites used by Copilot.
   - To create a custom assessment:
      - Go to Data Assessments (Preview) in Microsoft Purview.
      - Select Create Assessment and choose users and data sources to scan.
      - Run the assessment and allow up to 48 hours for results to appear.
