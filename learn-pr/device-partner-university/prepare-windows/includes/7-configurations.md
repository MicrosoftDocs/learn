Review deployment-related policies with respect to your security objectives, update compliance deadlines, and device activity. Consider what you need to do for the various settings and policies that currently underpin your organizational environment. It’s important to only apply changes that are necessary and where you can make a clear improvement, particularly regarding the speed of the update process or security. Otherwise, your environment might face issues that will slow down the update process.

| Tasks                                           | Deliverables                                                     |
|-------------------------------------------------|------------------------------------------------------------------|
| **Close gaps to achieve configuration readiness:** |                                                                  |
| - Create and populate your deployment rings.     | • Deployment infrastructure readiness checklist complete and ready to deploy Windows 11 |
| - Create a security baseline.                    | • Security baseline ready to be deployed                         |
| - Update policies and administrative templates.  | • Other device and/or user settings ready to be deployed         |
| - Update network configuration.                  | • Network settings completed                                      |
| - [Optional] Test settings in Proof of Concept (lab) environment. | • [Optional] Report of settings pass/fail                        |
| - Compare configured settings against readiness criteria. | • Identify gaps                                                   |
| - Sign off and update procedural documentation.  | • Procedural documentation of testing, remediation, and results  |

## Create and populate your deployment rings

Using the deployment plan you created in the Plan phase, create any configurations required to implement your deployment rings. How you do this will depend on the deployment management tools that you have chosen.

> [!TIP]
> If you’re looking for a simple distribution of devices to upgrade to Windows 11, [Windows Autopatch](/windows/deployment/windows-autopatch/manage/windows-autopatch-manage-autopatch-groups#create-an-autopatch-group) can automatically and dynamically distribute your devices across a number of defined deployment rings.

For each ring, set criteria to control deferral time or adoption (completion) that should be met before deploying the Windows feature update to the next broader ring of devices.

Create and populate any groups or collections that you’ll use to populate your deployment rings with devices. The actual steps will depend on the deployment infrastructure you selected. For example, if you’re using Windows Autopatch, you’ll add devices to appropriate Microsoft Entra ID device groups and add those groups to Windows Autopatch Groups.

> [!NOTE]
> ***Recommended deliverable***
>
> A report or a checklist specifying how your deployment infrastructure is fully configured and ready to start deploying Windows 11 to your devices. Check: Do you need to get stakeholder approvals?

## Create a security baseline

New versions of Windows often include new features that improve your environment's security. Your security teams will want to make appropriate changes to security-related settings. This is needed to keep customers and their data secure. Your security team will be responsible for ensuring that all baselines match the required guidance.

1. **Review new security settings:** The security team, together with end-user computing, are responsible for validating and deploying new security settings. So they'll review the security settings to understand how they can best be configured to facilitate the update.
2. **Review security baselines for changes:** Security teams will also review all the necessary security baselines to ensure the changes can be implemented and ensure your environment remains compliant.
3. **Implement and validate security settings and baseline changes:** The security teams will implement all of the security settings and baselines, having addressed any potential outstanding issues.

For cloud-native implementation there's no specific baseline file. You'd either use the [downloadable baseline](https://www.microsoft.com/download/details.aspx?id=55319) as a reference and create your own Intune policies, or you'd use the provided [Intune security baselines](/intune/intune-service/protect/security-baseline-settings-mdm-all?pivots=mdm-24h2) and make any required changes.

For on-premises environments you would implement security baselines from Microsoft. You can find them included with [Microsoft's Security Compliance Toolkit](https://www.microsoft.com/download/details.aspx?id=55319), which will also provide you with tools to help manage your security baselines.

Review the required settings that you identified in the Plan module and implement them into your infrastructure, ready to be deployed.

> [!NOTE]
> ***Recommended deliverable***
>
> Work with your security team to configure and document your infrastructure to implement your required security settings. Check: Do you need to get stakeholder approvals?

## Update policies and administrative templates

Review the required settings that you identified in the Plan module and implement them into your infrastructure, ready to be deployed. How you implement this will depend on the deployment tooling and infrastructure that you’ll be using.

For Microsoft Intune, you’ll create and assign one or more [Device Configuration Profiles](/intune/intune-service/configuration/device-profiles) that contain the settings you need. Find settings in both Templates and the Settings Catalog.

> [!NOTE]
> ***Recommended deliverable***
>
> Document the settings that you’ve configured. All settings are configured ready for deployment. Check: Do you need to get stakeholder approvals?

## Update network configuration

Review the required settings that you identified in the Plan module and implement them into your infrastructure.

How you implement this will depend on the network tooling and infrastructure that you’ll be using.

> [!NOTE]
> ***Recommended deliverable***
>
> All required network settings are configured. Check: Do you need to get stakeholder approvals?

## [Optional] Test settings in Proof of Concept (lab) environment

If you’ve chosen to perform a Proof of Concept, you might be able to test and validate some or all of the configuration settings that you’ve just implemented. This can be helpful to check that the settings produce the required behavior. If they are, mark them as passing your readiness criteria.

How much you can test will depend on whether the test devices have connectivity to the infrastructure where your settings have been configured.

> [!NOTE]
> ***Recommended deliverable***
>
> A report of settings that pass or fail the readiness criteria. Check: Do you need to get stakeholder approvals?

## Compare configured settings against readiness criteria

Review the settings that you’ve been able to configure. Are there any gaps or settings that you need to revisit later?

> [!NOTE]
> ***Recommended deliverable***
>
> Document any gaps or settings that aren't yet configured. Check: Do you need to get stakeholder approvals?

## Sign off and update procedural documentation

As you make decisions throughout this stage, document them in an easily shareable format for tracking, reporting, and continuity purposes. Get approvals of these deliverables from all the people identified in your RACI matrix connected to user readiness. Seek help and address any gaps before moving to the deployment phase.

| Tasks                                           | Deliverables                                                     |
|-------------------------------------------------|------------------------------------------------------------------|
| **Close gaps to achieve configuration readiness:** |                                                                  |
| - Create and populate your deployment rings.     | • Deployment infrastructure readiness checklist complete and ready to deploy Windows 11 |
| - Create a security baseline.                    | • Security baseline ready to be deployed                         |
| - Update policies and administrative templates.  | • Other device and/or user settings ready to be deployed         |
| - Update network configuration.                  | • Network settings completed                                      |
| - [Optional] Test settings in Proof of Concept (lab) environment. | • [Optional] Report of settings pass/fail                        |
| - Compare configured settings against readiness criteria. | • Identify gaps                                                   |
| - Sign off and update procedural documentation.  | • Procedural documentation of testing, remediation, and results  |
