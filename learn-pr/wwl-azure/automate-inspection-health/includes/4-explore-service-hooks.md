Service hooks enable automated task execution across external services triggered by Azure DevOps project events, facilitating cross-platform workflow automation, and real-time integration capabilities.

Integration scenarios include work item synchronization with project management platforms (Trello card creation upon work item creation), team communication automation (mobile push notifications for build failures), and custom application event processing.

Service hooks provide efficient event-driven automation for custom applications and services, eliminating the need for polling mechanisms while enabling immediate response to project lifecycle events.

Azure DevOps provides native service hook integration across multiple service categories:

| **Build and release** | **Collaborate** | **Customer support** | **Plan and track** | **Integrate**     |
| --------------------- | --------------- | -------------------- | ------------------ | ----------------- |
| AppVeyor              | Campfire        | UserVoice            | Trello             | Azure Service Bus |
| Bamboo                | Flowdock        | Zendesk              |                    | Azure Storage     |
| Jenkins               | HipChat         |                      |                    | Web Hooks         |
| MyGet                 | Hubot           |                      |                    | Zapier            |
| Slack                 |                 |                      |                    |                   |

Service hook ecosystem continues expanding through marketplace extensions and custom webhook implementations.

To learn more about service hooks and how to use and create them, read [Service Hooks in Azure DevOps](/azure/devops/service-hooks/overview).
