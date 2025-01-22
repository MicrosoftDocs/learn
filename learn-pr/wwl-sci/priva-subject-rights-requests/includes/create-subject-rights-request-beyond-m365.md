Managing subject rights requests for data beyond Microsoft 365 enables organizations to address privacy-related requests for personal data stored across diverse platforms, including multicloud environments and on-premises systems. This feature streamlines compliance efforts by automating request workflows and providing visibility into request progress.

## Types of requests

Subject rights requests for data beyond Microsoft 365 support two request types:

- **Export**: Provides an export of a data subject's personal data located in your organization's data landscape.
- **Delete**: Removes all personal data belonging to a data subject from your organization's systems.

These requests can be initiated in two ways:

1. **By the data subject**: An external individual, such as a customer or former employee, submits a request via an online form created by your organization.
2. **Manually by your organization**: A user in your organization creates a request on behalf of the data subject.

## Create a request manually

When a data subject contacts your organization to request an export or deletion of their personal data, you can create a request manually. This process involves selecting a template to define how the request will be fulfilled and entering basic details about the data subject.

### Steps to create a request

1. In the Microsoft Priva portal (preview), navigate to the **Request management** page.
1. Select **New request** to open the request builder.
1. On the **Basic details** page, choose the template that aligns with the request type (export or delete), then select **Next**.
1. On the **Request form** page, provide required details such as the data subject's name and email address.
1. Review the details and select **Submit**. The request is now active and moves into the first stage: **Validating identity**.

## Stages of request progress

Each request progresses through the following stages, shown on the request's details page:

1. **Not started**: The system begins validating the data subject's identity.
1. **Identity validation**: If the request uses a manual validation template, a task is created for the data engineer to verify the identity. Otherwise, validation is assumed to be complete.
1. **Analyzing data**: The system searches the Data Map for matches to classifications or sensitive information types specified in the template.
1. **Working on tasks**: Tasks are assigned to asset owners, who locate, extract, or delete data as required.
1. **Approving tasks**: Tasks are reviewed and approved by the request owner or designated approver.
1. **Ready to respond**: All tasks are complete, and the request is ready for the organization's response to the data subject.

## Tasks and responsibilities

When assets containing relevant data are identified, tasks are created and assigned to asset owners. Asset owners are notified via email and must complete the following steps:

1. On the **Task management** page, select the task and choose **Claim task**. The task status updates to **In progress**.
1. On the task's flyout pane, go to the **Scope** tab to view assets and data subject values in scope.
   - **Export requests**: Locate the data, extract it to a CSV file, and upload the file to the task.
   - **Delete requests**: Locate the data and delete it from the identified assets.
1. Once the required actions are finished, select **Mark as complete**. The task status updates to **Awaiting approval**.

If no relevant data is found, mark the task as **Not applicable**.

## Approving tasks

The request owner or designated approver reviews completed tasks to ensure accuracy and compliance:

1. On the **Tasks** tab of the request's details page, review the uploaded data or task completion details.
1. Approve tasks that meet requirements by selecting **Approve**. Tasks requiring revisions can be marked as **Rejected**, returning them to the task owner for updates.

## Respond to the data subject

After all tasks are approved, the request progresses to the **Ready to respond** stage. The organization must respond to the data subject outside of Priva:

- **Export requests**: Download the export package from the **Packages** tab on the request's details page. Share the .zip file with the data subject.
- **Delete requests**: Notify the data subject that their personal data has been deleted.

## Complete the request

Once the data subject has been notified, mark the request as complete:

1. On the request's details page, select **Mark as complete**.
1. The request status updates to **Complete**. Requests remain in the system for 180 days for record-keeping.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
