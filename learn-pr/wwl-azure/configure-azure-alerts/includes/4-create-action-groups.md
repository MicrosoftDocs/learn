An action group is a collection of notification preferences defined by the owner of an Azure subscription. Azure Monitor and Service Health alerts use action groups to notify users that an alert has been triggered. Various alerts may use the same action group or different action groups depending on the user's requirements.

**Notifications** configure the method in which users will be notified when the action group triggers.

:::image type="content" source="../media/alert-notifications-618b4c6f.png" alt-text="Screenshot of the Notifications tab with the listed below this graphic.":::


 -  **Email Azure Resource Manager role** – Send email to the members of the subscription's role. Email will only be sent to Azure AD user members of the role. Email will not be sent to Azure AD groups or service principals.
 -  **Email/SMS message/Push/Voice** \- Specify any email, SMS, push, or voice actions.

**Actions** configure the method in which actions are performed when the action group triggers.

:::image type="content" source="../media/action-groups-42c1cd23.png" alt-text="Screenshot of the Actions tab with the items listed below this graphic.":::


 -  **Automation runbook** \- An automation runbook is the ability to define, build, orchestrate, manage, and report on workflows that support system and network operational processes. A runbook workflow can potentially interact with all types of infrastructure elements, such as applications, databases, and hardware.
 -  **Azure Function** – Azure functions is a serverless compute service that lets you run event-triggered code without having to explicitly provision or manage infrastructure.
 -  **ITSM** – Connect Azure and a supported IT Service Management (ITSM) product/service. This requires an ITSM Connection.
 -  **Logic App** – Logic apps connect your business-critical apps and services by automating your workflows.
 -  **Webhook** – A webhook is a HTTPS or HTTP endpoint that allows external applications to communicate with your system.
