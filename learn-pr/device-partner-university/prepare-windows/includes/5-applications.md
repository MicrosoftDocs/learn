Let’s prepare and validate your applications for use with Windows 11. A few reporting tools will help you understand your app compatibility and guide you in the required updates. Then, you’ll optionally select and test apps in the Proof of Concept (PoC) lab environment.

| Tasks                                           | Deliverables                                                     |
|-------------------------------------------------|------------------------------------------------------------------|
| **Close gaps to achieve app readiness:**            |                                                                  |
| - Run app readiness reports.                     | • List of app compatibility issues                              |
| - Modernize and update apps.                     | • Refreshed app inventory with replaced or updated apps         |
| - [Optional] Select and test critical and important apps in Proof of Concept (lab) environment. | • [Optional] List of apps for PoC                                |
| - Select critical and important applications for regression and pilot testing in a production environment. | • List of apps for regression and pilot testing                 |
| - Remediate failed apps.                         | • A record of all remediated apps                                |
| - Sign off and update procedural documentation.  | • Report results<br>• Procedural documentation of testing, remediation, and results |

## Run app readiness reports

Use Windows update compatibility reports to improve your organization’s application readiness. These include Windows feature update device readiness report and Windows feature update compatibility risks report. Take advantage of these reports to reduce the time and effort it takes to validate applications in your environment. These are Microsoft Intune cloud-based reports. They can provide information on device readiness for a Windows feature update, and the compatibility risks likely to have the greatest effect in your organization.

In the Plan module you might have already used these reports to identify which devices were eligible to receive the Windows 11 update. In this phase you can use the same reports to identify applications that might require remediation.  

At a high level, to get started with Windows update readiness reports, you’ll need to:

1. Access the [Microsoft Intune portal](https://intune.microsoft.com/).
2. Enable use of Windows diagnostic data by Intune.
3. Confirm ownership of Windows licenses on Windows data page. *Note that a Global Administrator or Intune Administrator role is required.*
4. Configure devices.

> [!NOTE]
> Windows diagnostic data provides the information for Windows update compatibility reports, so it’s not necessary to install agents. You can use Microsoft Intune or Microsoft Configuration Manager (as appropriate) to deploy diagnostic data settings to the clients you want to report on.

Run the following reports:

- **[Windows feature update device readiness report.](/mem/intune/protect/windows-update-compatibility-reports#use-the-windows-feature-update-device-readiness-report)** Get information about compatibility risks associated with the update, including app and driver issues on a per-device basis.
- **[Windows feature update compatibility risks report.](/intune/intune-service/protect/windows-update-compatibility-reports#use-the-windows-feature-update-compatibility-risks-report)** Get a view of the top compatibility risks across the organization including the number of devices potentially affected.

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. In the admin center, go to **Reports > Windows updates >** select the **Reports** tab > select **Windows Feature Update Compatibility Risks Report** or **Windows Feature Update Device Readiness Report**.
3. Configure settings:
   - Select **Select Target OS** and choose the version of Windows you plan to deploy.
   - Select other optionally settings to refine the report.
   - Select **Generate report**. This process can take several minutes. You're notified when report generation is complete.

Understand the compatibility risks of all assets from asset detail, number of enrolled devices that might be impacted, severity level, and the description of the issue. Note any medium-to-high risk issues, since those might block the upgrade. When available, use the **Guidance** section to mitigate the compatibility risk.

In the Plan phase, you created an inventory of your applications. Using the compatibility report information collected here, together with vendor compatibility statements, you should now have a good picture of the likely compatibility status of your apps. Update your app inventory with the compatibility information.

> [!TIP]
> When an issue could result in a feature update failure or rollback, we might apply safeguard holds to prevent affected devices from installing the update. We remove these protections once a fix is found and verified.

> [!NOTE]
> ***Recommended deliverable***
>
> Download reports of apps with medium-to-high compatibility risk along with the details of the issue and available guidance. Check: Do you need to get stakeholder approvals?

## Modernize and update apps

Now that you have information on app compatibility, review your app inventory and identify any apps that you want or need to update. For in-house developed apps, this might require some development resources. For third-party apps, you might have to obtain a later version from your vendors. In some cases, you might take this opportunity to replace an app with a different one designed for a cloud-native environment.

> [!TIP]
> For apps that have dependencies on certain back-end infrastructure, an updated app would require updated infrastructure to support it. For example, an update to an app that queries a database might require an update to a server hosting that database.

> [!NOTE]
> ***Recommended deliverable***
>
> Refresh your app inventory as you replace or update identified apps and identify any infrastructure dependencies. Check: Do you need to get stakeholder approvals?

## [Optional] Select and test critical and important apps in Proof of Concept (lab) environment

If you have decided to run a Proof of Concept (PoC) lab environment, you might want to test some of your most critical or important business apps to confirm their compatibility with Windows 11 before proceeding to your pilot or broader deployment phases in the production environment.

There are no rules about which apps you should select. You might select commonly used apps, such as Microsoft 365 apps, or concentrate on ones that are critical to running your business.

Consider potential constraints when selecting apps for testing in a lab:

- Remember that apps that require connectivity to back-end infrastructure might not work in a lab.
- Unless you have appropriate access, you might not be able to exercise all the functions of a business app.

Follow these general testing guidelines to assess app functionality on Windows 11:

1. If you haven’t already, install the application, accepting all defaults.
2. Verify that product services are started.
3. Update the application, including both program and definition updates.
4. Test application core functionality (for example, opening and exiting, window maximization, screen snapping, and taskbar pinning).
5. Test application extended features, such as system tray context menu options or pop-up blockers. Note that these are example features a product might contain, not a list of features you should include.

Check out additional [scenario testing instructions](/windows/compatibility/windows-11/testing-guidelines#windows-11-feature-testing) if needed.

> [!NOTE]
> ***Recommended deliverable***
>
> Document testing success results and any troubleshooting for the selected apps. Check: Do you need to get stakeholder approvals?

## Select critical and important applications for regression and pilot testing in a production environment

Regardless of whether you tested apps in a Proof of Concept lab, you'll possibly want to perform further tests in a production environment. Collaborate with people identified in your RACI chart to decide which apps must be tested first (if any). Use this information to select devices or users to include in the early deployment phases for Windows 11.

> [!TIP]
> Most of your apps are already ready for Windows 11 deployment thanks to the 99.7% app compatibility between Windows 11 and Windows 10. Consider how much time and resources you actually should spend on testing applications. Concentrate on business-critical apps or those that are required to satisfy regulatory compliance.

> [!NOTE]
> ***Recommended deliverable***
>
> Create a list of apps for regression and pilot testing in a production environment. Use this to help identify users and devices for early deployment phases. Check: Do you need to get stakeholder approvals?

## Remediate failed apps

During any phase of testing, if you run into compatibility issues that you’re unable to fix or want to ensure that your organization's applications are compatible from day one, App Assure can help.

With enrollment in the [App Assure](/windows/compatibility/app-assure) service, Microsoft will help you remedy any application issues with Windows 11 at no extra cost. It’s included with your purchased plan for Microsoft Entra, Microsoft Intune, Microsoft 365 Apps, and a wide variety of other [eligible plans](/microsoft-365/fasttrack/eligibility).

Check out [Microsoft App Assure](https://fasttrack.microsoft.com/dl/daa) and sign in to submit your request for assistance from a dedicated App Assure Manager. If you experience any issues while submitting your request, contact ACHELP@microsoft.com and a team member will reach out to you.

> [!NOTE]
> ***Recommended deliverable***
>
> A record of all remediated apps or a plan for remediation or replacement. Check: do you need to get stakeholder approvals?

## Sign off and update procedural documentation

Document the success, failure, and remediation of all steps you take to close the app readiness gaps.

As you make decisions throughout this stage, document them in an easily shareable format for tracking, reporting, and continuity purposes. Get approvals of these deliverables from all the people identified in your RACI matrix connected to user readiness. Seek help and address any gaps before moving to the deployment phase.

| Tasks                                           | Deliverables                                                     |
|-------------------------------------------------|------------------------------------------------------------------|
| **Close gaps to achieve app readiness:**            |                                                                  |
| - Run app readiness reports.                     | • List of app compatibility issues                              |
| - Modernize and update apps.                     | • Refreshed app inventory with replaced or updated apps         |
| - [Optional] Select and test critical and important apps in Proof of Concept (lab) environment. | • [Optional] List of apps for PoC                                |
| - Select critical and important applications for regression and pilot testing in a production environment. | • List of apps for regression and pilot testing                 |
| - Remediate failed apps.                         | • A record of all remediated apps                                |
| - Sign off and update procedural documentation.  | • Report results<br>• Procedural documentation of testing, remediation, and results |
