You can use Durable Functions to orchestrate a long-running workflow as a set of activities. You can map each step in the process to a function type, and each task to an activity. Having an automated process means you don't have to worry about manually monitoring or escalating a task if it isn't done.

As we continue to think about automating our proposal approval process, we need to consider the cases when a step in the process doesn't complete in time and needs to be escalated. For example: what if we need a manager's approval for a particular size of proposal, but the manager is late with a response?

Escalation steps are useful to the business, as they move a task along when a deadline has been reached. They ensure tasks are completed and not forgotten. An escalation step could involve sending out reminders, or even reassigning a task to someone higher up the managerial hierarchy.

In this unit, you'll design an approval process workflow based on Durable Functions. In the next exercise, you'll apply this knowledge to create an app with Azure Durable Functions.

## Description of the design approval process

Our workflow begins when a project design is submitted for approval. The proposal is assigned as an approval task to a manager. The manager will either approve or reject the proposal. In the real world, this event would probably generate and send a notification to the proposal author to let them know the approve/reject request outcome. In this example, you'll just change the status of the task to either `approved` or `rejected`.

The workflow steps are as follows:

1. A project design is submitted.
2. An approval task is allocated to a manager so they can review the project design proposal.
3. The project design proposal is rejected or approved.
4. An escalation task is allocated if the approval task isn't completed within a pre-defined time limit.

The following image is a visual representation of workflow showing the three functions in our orchestration: the request approval, the process approval and an escalate function.

![Visual representation of workflow showing the three functions in our orchestration.](../media/approval.png)

The following table shows how the workflow steps can be mapped to the function types we use in a Durable Functions workflow.

| Workflow function | Durable Function Type |
|--|--|
| Submitting a project design  proposal for approval | _Client_ Function |
| Assign an Approval task  to relevant member  of staff | _Orchestration_ Function | 
| Approval task | _Activity_ Function |
| Escalation task | _Activity_ Function |

The Orchestration function will manage a rule in the workflow that starts the escalation activity if the approval activity doesn't return within a specified time.

Now that we understand what's needed for our workflow, let's write it in code in the next unit!
