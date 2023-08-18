
Release gates give you more control over the start and completion of the deployment pipeline.

They're often set up as pre-deployment and post-deployment conditions.

In many organizations, there are so-called dependency meetings.

It's a planning session where the release schedule of dependent components is discussed.

Think of downtime of a database server or an update of an API.

It takes much time and effort, and the only thing needed is a signal if the release can continue.

Instead of having this meeting, you can create a mechanism where people press a button on a form when the release can't advance.

When the release starts, it checks the state of the gate by calling an API. If the "gate" is open, we can continue. Otherwise, we'll stop the release.

By using scripts and APIs, you can create your release gates instead of manual approval. Or at least extending your manual approval.

Other scenarios for automatic approvals are, for example.

 -  Incident and issues management. Ensure the required status for work items, incidents, and issues. For example, ensure that deployment only occurs if no bugs exist.
 -  Notify users such as legal approval departments, auditors, or IT managers about a deployment by integrating with approval collaboration systems such as Microsoft Teams or Slack and waiting for the approval to complete.
 -  Quality validation. Query metrics from tests on the build artifacts such as pass rate or code coverage and only deploy within required thresholds.
 -  Security scan on artifacts. Ensure security scans such as anti-virus checking, code signing, and policy checking for build artifacts have been completed. A gate might start the scan and wait for it to finish or check for completion.
 -  User experience relative to baseline. Using product telemetry, ensure the user experience hasn't regressed from the baseline state. The experience level before the deployment could be considered a baseline.
 -  Change management. Wait for change management procedures in a system such as ServiceNow complete before the deployment occurs.
 -  Infrastructure health. Execute monitoring and validate the infrastructure against compliance rules after deployment or wait for proper resource use and a positive security report.

In short, approvals and gates give you more control over the start and completion of the deployment pipeline.

They can usually be set up as pre-deployment and post-deployment conditions, including waiting for users to approve or reject deployments manually and checking with other automated systems until specific requirements are verified.

Also, you can configure a manual intervention to pause the deployment pipeline and prompt users to carry out manual tasks, then resume or reject the deployment.

To find out more about Release Approvals and Gates, check these documents.

 -  [Release approvals and gates overview](/azure/devops/pipelines/release/approvals/approvals).
 -  [Release Gates](/azure/devops/pipelines/release/approvals/gates).
