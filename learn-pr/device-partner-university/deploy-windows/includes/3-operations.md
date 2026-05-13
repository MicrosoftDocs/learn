In the Plan and Prepare phases, you completed the tasks necessary to get your operations ready to deploy Windows 11. To deploy Windows 11, we recommend the following tasks and deliverables.

| Tasks | Deliverables |
|------|--------------|
| - Implement RACI roles.<br>- [Optional] Review results of Proof of Concept.<br>- Conduct pilot deployment.<br>- Conduct broad deployment.<br>- Sign off and update procedural documentation. | • Updated stakeholder approval tracking system<br>• Completed pilot deployment and test results<br>• Documented stakeholder approvals to advance through deployment rings<br>• Procedural documentation of operations completeness |

## Implement RACI roles

As you begin upgrading your estate to Windows 11, involve all stakeholders identified in your roles and responsibilities and RACI tables. Throughout this phase, use these charts to assign tasks to the appropriate owners and keep others informed. If you’ve implemented a stakeholder approval tracking system, keep it up to date as you progress through deployment.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Your previously prepared RACI tables and roles and responsibilities. If implemented, an updated stakeholder approval tracking system.

## [Optional] Review results of Proof of Concept

If you performed a lab-based Proof of Concept (PoC) in the Prepare phase, review the results of that PoC now. Resolve any critical or important issues you identified that could prevent successful Windows 11 deployment. Alternatively, document any workarounds.

> [!TIP]
>
> ***Recommended deliverable:***
>
> All “showstopper” issues identified in the PoC are resolved or have workarounds.

## Conduct pilot deployment
You’re now ready to deploy Windows 11 to your first set of users and devices in the production environment. During this step, you’ll likely uncover issues, resolve them, and retest in an iterative process.

A pilot deployment typically follows these steps:

1. Assign a group of users or devices to receive the upgrade.

   1. Use existing group membership to define which users or devices are in scope for the Windows upgrade. Group-based targeting is used by Windows update services to control which devices receive feature updates.
   2. Choose how update deployment will be managed for the targeted devices:
      1. When using Windows Autopatch, devices are organized into Autopatch groups and automatically distributed across deployment rings using a managed rollout cadence.
      1. When managing updates directly with Microsoft Intune, groups are used when assigning Windows Update ring policies to control rollout timing and user experience.
   3. Assign the selected groups to the appropriate update mechanism and verify that the correct users or devices are included before proceeding.

   For guidance and reference, visit:
     - [Windows Autopatch groups overview](/windows/deployment/windows-autopatch/deploy/windows-autopatch-groups-overview#prerequisites)
     - [Learn about groups, group membership, and access (Microsoft Entra)](/entra/fundamentals/concept-learn-about-groups#microsoft-entra-groups-overview)
     - [Configure Windows Update rings policy in Intune](/intune/device-updates/windows/update-rings)
     - [Add groups to organize users and devices for Microsoft Intune](/intune/intune-service/fundamentals/groups-add#add-groups-to-intune)

2. Implement [security baseline updates](/windows/security/operating-system-security/device-management/windows-security-configuration-framework/windows-security-baselines).

   1. Review Microsoft recommended security baselines to understand the purpose, scope, and impact of baseline configurations for Windows devices.
   2. Identify the appropriate Windows security baseline version (for example, [Windows 11 version 25H2](https://techcommunity.microsoft.com/blog/microsoft-security-baselines/windows-11-version-25h2-security-baseline/4456231)) that aligns with the target Windows release and organizational security requirements.
   3. Use Microsoft provided tooling to evaluate, customize, and apply security baseline settings in the environment, testing changes before broad deployment.

   For guidance and reference, visit:
     - [Security baselines guide](/windows/security/operating-system-security/device-management/windows-security-configuration-framework/windows-security-baselines)
     - [Microsoft Security Compliance Toolkit Guide](/windows/security/operating-system-security/device-management/windows-security-configuration-framework/security-compliance-toolkit-10?source=recommendations)

3. Implement policy and administrative template updates.

   1. Review how Windows Update client behavior and policy settings are managed using cloud based configuration mechanisms.
   2. Configure or update feature update policies to control which Windows version devices are eligible to install and remain on.
   3. Assign policy and configuration profiles to the appropriate device groups to ensure settings are applied consistently.
   4. If required for on-premises or hybrid environments, use Group Policy–based enrollment to bring devices under management before applying policy updates.

   For guidance and reference, visit:
      - [Configure Windows Update client policies by using CSPs and MDM](/windows/deployment/update/waas-wufb-csp-mdm)
      - [Configure Windows Feature Update Policies – Microsoft Intune](/intune/device-updates/windows/feature-update-policy)
      - [Assign device profiles in Microsoft Intune](/intune/intune-service/configuration/device-profile-assign)
      - [Enroll a Windows device automatically using Group Policy](/windows/client-management/enroll-a-windows-10-device-automatically-using-group-policy)

4. Implement any other configuration updates.

   1. Review additional Windows Update configuration settings that influence feature update behavior but aren't addressed by update rings, feature update policies, or security baselines.
   2. Identify feature update–specific configuration options that support the organization’s deployment requirements, such as update deferral behavior, user experience controls, or safeguards that affect feature update installation.
   3. Apply or adjust these settings using supported cloud-based policy mechanisms to ensure consistent feature update behavior across managed devices.

   For guidance and reference, visit:
      - [Update Policy CSP](/windows/client-management/mdm/policy-csp-update?context=%2Fwindows%2Fdeployment%2Fcontext%2Fcontext)

5. Deploy the upgrade to devices.
   1. Initiate deployment of the Windows feature update using supported deployment mechanisms rather than creating or reconfiguring update policies.
   2. Enable or allow user initiated installation scenarios where appropriate, so eligible users can install the feature update when ready.
   3. Ensure devices are properly enrolled and managed before deployment, particularly in hybrid or Autopilot based environments.
  
   For guidance and reference, visit:
      - [Deploy feature updates for user initiated installations](/windows/deployment/update/feature-update-user-install)
      - [Enrollment for Microsoft Entra hybrid joined devices – Windows Autopilot](/autopilot/windows-autopilot-hybrid?tabs=general-requirements%2Cupdated-connector%2Cwindows-server-2025#next-steps)

6. Deploy applications to devices.

   1. Identify the Windows application types that need to be deployed, based on organizational requirements and supported app formats.
   2. Add the required applications to Microsoft Intune so they can be managed and delivered centrally.
   3. Assign applications to the appropriate user or device groups to control installation behavior and availability across managed devices.
   4. Monitor application deployment status and address any installation issues as part of the rollout process.
   
   For guidance and reference, visit:
      - [Windows App Deployment by Using Microsoft Intune](/intune/intune-service/apps/apps-windows-10-app-deploy)


7. Test and support the pilot devices.

   1. Review device experience and performance signals to identify issues that might affect pilot users during or after the upgrade.
   2. Monitor deployment progress, success rates, and failures for pilot devices using centralized reporting.
   3. Track Windows feature update status for pilot devices to validate upgrade completion and readiness for broader deployment.

   For guidance and reference, visit:
      - [Scores, Baselines, and Insights in Endpoint Analytics](/intune/endpoint-analytics/scores)
      - [Microsoft Intune Reports](/intune/intune-service/fundamentals/reports)
      - [Windows feature update summary dashboard](/windows/deployment/windows-autopatch/monitor/windows-autopatch-windows-feature-update-summary-dashboard?branch=pr-en-us-11467)

8. Determine broad deployment readiness based on the results of the pilot.

   1. Assess Windows 11 readiness across pilot devices to confirm eligibility, compatibility, and upgrade success.
   2. Review readiness results to identify devices that require remediation, hardware replacement, or exclusion from broader deployment.
   3. Use readiness findings to inform decisions about expanding the deployment to other device groups or proceeding with organization wide rollout.

   For guidance and reference, visit:
      - [Perform a Windows 11 Device Readiness Assessment](/training/modules/windows-11-readiness-assessment/)

By the end of the pilot, you should have a clear understanding of how successful the deployment will be when you broaden it to more devices. You’ll have tested your infrastructure, tooling, connectivity, settings, and business applications.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Document the success of your pilot deployment and your readiness for broad deployment. Document any issues that couldn’t be resolved and inform stakeholders.

## Conduct broad deployment

After successfully completing the pilot, you’re ready to decide when to move on to broader deployment. After each deployment ring, review the data and feedback to determine whether you can proceed to the next ring. Check whether you need stakeholder approval.

There are two strategies for moving deployments from one ring to the next: service-based and project-based.

 - **Service-based (“red button”)**: Assumes the deployment is successful unless proven wrong. Deployment automatically continues through the rings until a problem is discovered. At that point, the IT administrator presses the *red button* to stop further distribution while the issue is reviewed.
 - **Project-based (“green button”)**: Assumes the deployment isn’t successful until it’s validated. After validation is complete for a ring, the IT administrator presses the *green button* to move deployment to the next ring.

How you advance between deployment rings depends on the deployment technology and infrastructure you use. For example, if you’re using Windows Autopatch, you can configure an automatic schedule for [multi-phase feature updates](/windows/deployment/windows-autopatch/manage/windows-autopatch-windows-feature-update-overview#multi-phase-feature-update).

> [!TIP]
>
> ***Recommended deliverable:***
>
> Document stakeholder approvals and deployment decisions.

## Sign off and update procedural documentation

Document your operational decisions and any remaining to-do items as you deploy Windows 11. This documentation helps the team track progress and report on the deployment. Once operational tasks are complete, get the appropriate approvals on these deliverables to support progressing through the deployment rings.

| Tasks | Deliverables |
|------|--------------|
| - Implement RACI roles.<br>- [Optional] Review results of Proof of Concept.<br>- Conduct pilot deployment.<br>- Conduct broad deployment.<br>- Sign off and update procedural documentation. | • Updated stakeholder approval tracking system<br>• Completed pilot deployment and test results<br>• Documented stakeholder approvals to advance through deployment rings<br>• Procedural documentation of operations completeness |
