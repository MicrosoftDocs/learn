Most of your apps are already ready for Windows 11 deployment thanks to the 99.7% app compatibility between Windows 11 and Windows 10. However, here's what we recommend to evaluate app readiness in your context:

| Tasks | Deliverables |
|-------|--------------|
| - Set criteria for app handling.<br>- Generate your app inventory.<br>- List and assign owners and importance classifications to applications based on business impact.<br>- Identify gaps in app readiness. | • Application decision matrix<br>• App inventory updated with importance classifications<br>• Priority application and owner list, defined by app owners<br>• List of app gaps |

### Set criteria for app handling

Let’s set some criteria for handling the potential 0.3% of apps that might pose a compatibility issue. Even before looking at specific apps, let’s create an application decision matrix on what to do if there’s a problem with different types of apps based on their importance.

First, let’s create app classification based on their business impact. Here’s an example you can adapt to your needs:

| Classification | Description |
|----------------|-------------|
| Critical | These are the organization's most vital applications that handle core business activities and processes. If these applications experience downtime, the business or business unit wouldn't be able to function. |
| Very important | These applications support the productivity of one or two business units. Downtime would affect an entire business unit and have a moderate impact on business productivity. |
| Important | These applications are needed by individual staff members to support their productivity. Downtime would affect individual users but have minimal impact on the business. |
| Not important | There's no impact on the business if these applications experience downtime. |

Generally, the business-critical nucleus of apps is a small number. These might include apps for credit processing and frontline customer service, for example. In contrast, a PDF viewer app might be considered important for productivity but not critical. Similarly, an image processing app could probably wait until after the deployment, deemed not important.

Next, decide what to do during deployment if you face issues with different types of apps. For example, what should you do if a critical app experiences downtime? You might want to pause deployment right away and triage the issue with highest priority or decide to address the issue on the go. On the other end of the importance spectrum are low-usage productivity apps. If one of these stops working for a small number of individual users, you can continue the deployment and plan for troubleshooting afterwards. Consider the following deployment decision options based on your severity assessment of the impact of different types of apps:

- Stop the deployment.
- Stop the deployment for affected devices only.
- Continue the deployment but provide workaround guidance for affected users if possible.
- Continue deployment.

With each decision to stop or continue deployment, plan your triage strategy. How soon should you start addressing each issue? As soon as possible? During the current deployment cycle? By the end of the next deployment cycle? Any deployment cycle?

Documenting these nuances as an application decision matrix is an important part of your app readiness for Windows 11. Here’s an example of what it might look like:

| Classification | Estimated impact of downtime | Deployment decision | Triage priority |
|----------------|------------------------------|---------------------|-----------------|
| Critical | Work stoppage or loss of revenue | Stop the deployment. | Investigate and resolve any identified issues or risks as soon as possible. |
| Very important | Productivity loss for a business unit | Stop the deployment for affected devices only. | Start investigating risks and issues within two business days and fix them during the current deployment cycle. |
| Important | Productivity loss for individual users | Continue the deployment but provide workaround guidance for affected users if possible. | Start investigating risks and issues within 10 business days. You don't have to fix them all within the current deployment cycle; however, all issues must be fixed by the end of the next deployment cycle. |
| Not important | Minimal impact on users | Continue the deployment. | Start investigating risks and issues within 20 business days. You can fix them in the current or any future deployment cycle. |

> [!NOTE]
>
> The specifics can vary for your organization.

> [!NOTE]
> ***Recommended deliverable:***
> 
> Complete the application decision matrix on app readiness for your organization.

### Generate your app inventory

Generate the inventory of all apps across your organization. If your devices are enrolled in Microsoft Intune, you can see all apps installed on corporate devices and all managed applications on personal devices in the [Discovered apps report](/mem/intune/apps/app-discovered-apps).

1. Sign in to the [**Intune admin center**](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Go to **Apps**.
3. In the **Monitor** section, select **Discovered apps**.
4. Download the .csv report file by selecting **Export**.

This report includes the platform, app version, device count, and app publisher for each app in your inventory.

> [!NOTE]
> ***Recommended deliverable:***
> 
> Create an app inventory file that's easy to edit and share with others.

### Assign owners and importance classification to apps

Now that you have a list of apps, use your RACI chart and your application decision matrix to assign owners and importance classification to the different apps.

We’ll continue building on the application decision matrix and app inventory files to track your app handling criteria, app owners, and any gaps. In the next phase, we’ll prepare your apps for Windows 11 deployment with more readiness reports data.

> [!NOTE]
> ***Recommended deliverable:***
> 
> Expand your priority application and owner list, defined by app owners. Update your app inventory list with the app importance classifications identified.

### Identify gaps

Finally, are there any tasks or deliverables you still need help with?

> [!NOTE]
> ***Recommended deliverable:***
> 
> Document gaps in app readiness and handling before deploying Windows 11. Plan to address them between now and the next Prepare stage.

| Tasks | Deliverables |
|-------|--------------|
| - Set criteria for app handling.<br>- Generate your app inventory.<br>- List and assign owners and importance classifications to applications based on business impact.<br>- Identify gaps in app readiness. | • Application decision matrix<br>• App inventory updated with importance classification<br>• Priority application and owner list, defined by app owners<br>• List of app gaps |
