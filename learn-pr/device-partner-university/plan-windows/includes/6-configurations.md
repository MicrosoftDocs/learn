Let’s determine your configuration readiness for Windows 11. Here's what would help you:

| Tasks | Deliverables |
|-------|--------------|
| - Evaluate settings readiness criteria.<br>- Evaluate your security baselines.<br>- Evaluate your policies.<br>- Evaluate your network configuration.<br>- Detail configuration changes needed and identify gaps. | • Configuration readiness criteria<br>• List of required security settings<br>• List of required policy settings<br>• List of required network settings<br>• Configuration gaps and remediation list |

## Evaluate settings readiness criteria

Your settings readiness criteria should include security baseline updates and configuration updates. Start by reviewing the settings you have today with respect to what’s required for Windows 11:

- What Windows 11 settings do I already have?
- What settings do I still need for Windows 11? *This will largely depend on your organizational needs and requirements.*

Determine which settings will be critical to a successful deployment project. Settings requirements might evolve as you progress through the deployment. Use the settings readiness criteria to record this.

> [!NOTE]
>
> Beware of legacy configurations and settings. We recommend reviewing each setting for relevance. This is important in all instances, but especially if you’re in the process of moving to Windows cloud-native management.

> [!NOTE]
> ***Recommended deliverable:***
> 
> Create a configuration readiness criteria.

## Evaluate your security baselines

Security baselines help you ensure that your devices are configured with Microsoft recommended guidance. Security risks and threats are constantly changing, so you should update security baselines to secure your environment. This is necessary for new security features delivered as part of the Windows 11 feature update to be configured accordingly. There are different security baselines that your organization will likely need to implement. Plan to review the following:

- **Microsoft security baselines:** It’s highly recommended that you implement security baselines from Microsoft. You can find them included with Microsoft's [Security Compliance Toolkit](https://www.microsoft.com/download/details.aspx?id=55319), which will also provide you with tools to help manage your security baselines.
- **Industry or region-specific baselines:** Your industry or region might have its own security baselines that you need to adhere to for compliance or regulatory reasons. For example, if Woodgrove is a financial organization, it might have more required security configurations than a retail organization. Check to ensure any new baselines implemented support the version of Windows 11 you're deploying.

> [!NOTE]
>
> Security baselines are applicable to cloud, hybrid, and on-premises environments.

> [!NOTE]
> ***Recommended deliverable:***
>
> Document what should be configured to achieve the desired security settings.

## Evaluate your policies and administrative templates

Review and configure policies that will help your devices take advantage of any new Windows 11 features and ensure that devices are set to apply updates when they're ready.

You'll pull the actual settings together for implementation in the Prepare phase.

Let’s evaluate what the [update experience](/windows/deployment/update/update-policies) should look like for the user:

- What deadlines should updates have to meet compliance?
- What delays are appropriate for device restarts?
- What device activity policies such as Active Hours are in place?

You should also decide if there are new Windows 11 features that you want or need to disable for your organization.

Are there any industry or region-specific regulations that require specific settings?

Are there any old or conflicting policies? If you have a hybrid environment pay particular attention to any old policies that might be applied via Group Policy and cause conflicts. This is a common cause of misconfiguration and unexpected behavior.

> [!TIP]
>
> This is a good opportunity to review all your existing policies and determine their relevance. If possible, plan to create fresh policies with the settings you need rather than reusing old policy configurations.

Microsoft Intune is regularly updated to support new Windows 11 features. However, if you need settings that aren't already available in Intune, it’s possible to import them. Every Windows 11 feature update has a supporting administrative template (ADMX), most of which can be imported into your environment to support new features of the operating system. The ADMX files can be obtained from the Microsoft Download Center, such as the template for [Windows 11 2024 (24H2)](/download/details.aspx?id=106254). Review whether any ADMX-based settings need to be imported into Microsoft Intune for cloud-native management.

> [!NOTE]
>
> If you still rely on Group Policy, we encourage you to plan a migration to cloud management, such as Microsoft Intune.

> [!NOTE]
> ***Recommended deliverable:***
> 
> Document what should be configured to achieve the desired device and/or user settings.

### Evaluate your network configuration

To communicate with deployment infrastructure and cloud services such as Windows Update or Microsoft Intune, devices require connectivity to multiple [Microsoft service endpoints](/windows/deployment/windows-autopatch/prepare/windows-autopatch-configure-network) from the corporate network. Are there any restrictions on your firewall or a proxy that might block required endpoints?

> [!NOTE]
> ***Recommended deliverable:***
> 
> Document any changes that need to be made to network configuration.

### Detail configuration changes needed and identify gaps

Based on your evaluation of security baselines and policies, what changes will you need to implement in the next phase? Will you need to import any policies into Microsoft Intune? Let’s call this your configuration remediation list.

Are there any configuration-related tasks or deliverables that you still need help with as you plan for Windows 11?

> [!NOTE]
> ***Recommended deliverable:***
> 
> Create a configuration remediation list based on anticipated changes needed. Document any remaining steps and a plan to address them between now and the next preparation stage.

| Tasks | Deliverables |
|-------|--------------|
| - Evaluate settings readiness criteria.<br>- Evaluate your security baselines.<br>- Evaluate your policies.<br>- Evaluate your network configuration.<br>- Detail configuration changes needed and identify gaps. | • Configuration readiness criteria<br>• List of required security settings<br>• List of required policy settings<br>• List of required network settings<br>• Configuration gaps and remediation list |
