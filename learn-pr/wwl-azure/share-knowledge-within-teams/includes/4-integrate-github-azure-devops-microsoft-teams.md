The ability to integrate both GitHub and Azure DevOps with Microsoft Teams fosters seamless collaboration and communication across a wide range of DevOps scenarios. Programmers and operational teams benefit from real-time notifications and updates directly within their Teams channels, allowing for immediate visibility into events taking place throughout the entire software development lifecycle. This integration is particularly useful in tracking work item changes, monitoring build and release pipelines, generating alerts triggered by critical deployment issues, as well as facilitating discussions and feedback on code changes. By bringing together DevOps platforms and Teams, organizations can enhance productivity, streamline workflows, and ensure that everyone stays informed and aligned with project goals and objectives.

## Integrating GitHub with Microsoft Teams

The GitHub app for Microsoft Teams allows seamless integration between the two platforms, enabling users to receive notifications and interact with GitHub directly from Teams.

You can install the GitHub app for Microsoft Teams from the Teams app store or directly from GitHub by navigating to the [https://teams.github.com](https://teams.github.com) web page. Following a successful installation, a welcome message will prompt you to use the @github handle to interact with the app. To start, link to your GitHub accounts by entering @github sign-in, which will trigger the GitHub authentication process.

To subscribe to notifications for pull requests and issues in an organization or repository, use the @github subscribe &lt;organization&gt;/&lt;repository&gt; command. Notifications can be customized by subscribing to specific features using @github subscribe owner/repo \[feature\] and unsubscribing from less relevant activities using @github unsubscribe owner/repo \[feature\]. Default features include issues, pull requests, commits, comments, deployments, and releases. It's possible to selectively enable or disable other features, such as reviews, workflows, branches, and discussions.

To further scope notifications, use filtering. Branch filters allow limiting commit notifications to specific branches or patterns of branches. Label filters limit incoming events based on whitelisted labels, such as priority or specific team labels.

You can also organize notifications by using pull request and issue notification cards and threading. Notifications for pull requests and issues are grouped under parent cards as replies, displaying relevant metadata and providing threading for improved collaboration.

Teams conversations frequently result in actionable takeaways and drive decision making. The integration facilitates these activities by supporting issue creation and management. You can create issues with a single click from Teams, accessing the Create an Issue option in the message options menu. The issue creation dialogue automatically populates with message content, allowing selection of labels, assignees, and milestones, and confirming issue creation with a notification card. You can also perform various actions on issues and pull requests, such as closing, reopening, and commenting directly from Teams.

Another integration area targets actions workflow notifications. This allows you to subscribe to GitHub Actions workflow run notifications, with tracking workflow status and approvals available directly from Teams. Notifications provide updates on workflow progress, including job status and completion, with options to rerun workflows and enable debug logs. By default, the focus is on workflows triggered via pull requests on the default branch, but you have the option to customize filtering criteria based on name, event, actor, and branch.

Separate notifications are available for deployments, with users mentioned in notifications requiring attention. Mentions work when logged into GitHub app from Teams, mapping GitHub ID with Teams ID to ensure notifications reach the intended recipients.

GitHub links shared in Microsoft Teams channels automatically display previews with details such as pull requests, issues, discussions, comments, code snippets, repositories, and accounts. Similarly, discussions and their comments can be unfurled automatically in Teams, providing a preview of the discussion content.

You can configure reminders for pending pull requests either in Teams channels or their personal chats. Configuration options include selecting days, times, time zones, teams, repositories, and advanced settings such as ignoring drafts, requiring review requests, and setting minimum age/staleness for pull requests.

## Integrating Azure DevOps with Microsoft Teams

The integration between Azure DevOps with Microsoft Teams offers a convenient collaboration experience across three key areas: Boards, Repos, and Pipelines. With the Microsoft Teams GitHub app, you can manage your projects' progress with Boards, track code changes and collaborate on Repos, and streamline CI/CD workflows with Pipelines, all within the Microsoft Teams environment. This comprehensive integration enhances productivity and communication by providing a unified interface for project management and development activities.

### Azure Boards integration

The Azure Boards app for Microsoft Teams streamlines project management by allowing users to create, monitor, and collaborate on work items directly within their Teams channel.

In order to use the Azure Boards app, ensure that you have at minimum the Contributors privileges in the Azure Boards project and that the app access via OAuth for the Azure DevOps organization is enabled. Once these prerequisites are satisfied, you can add the Azure Boards app to your Teams channel by accessing the App store in Microsoft Teams, installing the app, and using the @azure boards handle to interact with it.

To take advantage of the app's features, link your Azure Boards project to your Teams channel. This involves connecting and authenticating with Azure Boards and using the @azure boards link command in the Teams channel. To unlink using a project from a channel, use the @azure boards unlink command. Next, create subscriptions to monitor work items using the @azure boards subscriptions command. They can select specific area paths and events they're interested in and customize their notifications accordingly. Notifications within the Teams channel are threaded to logically link and reduce related notifications, providing a more organized communication experience.

You can add area paths from your projects to the channel to facilitate work item creation and subscriptions, especially for projects with numerous area paths. To create work items, use either the @azure boards create command or message actions within the Teams channel, which streamlines the process of converting discussions into actionable tasks. The app supports compose extension, allowing you to search for and share work items directly within Teams. You can preview work item URLs shared within the channel.

You can also configure Azure DevOps Services tabs in Microsoft Teams to bring Kanban boards or dashboards directly into your channel. This enhances visibility and accessibility of project-related information.

### Azure Repos integration

The Azure Repos app for Microsoft Teams facilitates monitoring of repositories for users of Microsoft Teams and Azure Repos. This integration simplifies repository management and enhances collaboration among team members.

As with the Azure Boards app, before using the app, ensure they have the necessary permissions at the repository level and that the app access via OAuth for the Azure DevOps organization is enabled. Once these prerequisites are satisfied, you can add the Azure Repos app to your Teams channel by accessing the App store in Microsoft Teams, installing the app, and using the @azure repos handle to interact with it.

After installing the app, connect it to your repos by using the @azure repos sign-in command and specifying the project or repo URL, enabling monitoring of code changes and pull requests. To manage subscriptions to repo-related events, use commands such as @azure repos subscribe and @azure repos subscriptions, allowing customization of notifications based on specific conditions and filters. To remove subscriptions related to repositories, use the @azure repos unsubscribe all \[project url\] command.

The Azure Repos app supports a compose extension, which supports searching for and sharing pull request information within Microsoft Teams. You can preview pull request URLs shared within the channel. This feature enhances visibility and understanding of pull request-related conversations.

As with the Azure Boards app, notifications within the channel are threaded to logically link related notifications and reduce clutter. This provides a more organized communication experience and enhances visibility of pull request-related discussions.

### Azure Pipelines integration

The Azure Pipelines app for Microsoft Teams simplifies pipeline monitoring and management, providing notifications and pipeline management capabilities directly within Teams channels. This integration streamlines the pipeline monitoring process and facilitates efficient collaboration.

As with the other two Azure DevOps related Microsoft Teams apps, before using this one, ensure they have the necessary permissions at the level of the project hosting the pipelines and that the app access via OAuth for the Azure DevOps organization is enabled. Once these prerequisites are satisfied, you can add the Azure Repos app to your Teams channel by accessing the App store in Microsoft Teams, installing the app, and using the @azure pipelines handle to interact with it.

After installing the app, connect it to your pipelines by using the @azure pipelines sign-in command. Next, use the @azure pipelines subscribe command to subscribe either to individual or all pipelines in a project. You can customize pipeline subscriptions to receive notifications for specific events, such as failed builds or deployments to production environments. The Azure Pipelines app supports filters to tailor notifications according to your preferences.

The app supports approving deployments directly from their Teams channel without accessing the Azure Pipelines portal. Notifications with options to approve or reject deployment requests are posted in the channel, facilitating quick decision-making, and enhancing workflow efficiency. Notifications linked to a particular run of a pipeline are logically linked together, providing a clear overview of pipeline activities, and facilitating organized communication within the channel.

The Azure Pipelines app also includes a compose extension, allowing you to search for and share pipeline information directly within Microsoft Teams. When pipeline URLs are shared in Teams, you can preview them to monitor updates on pipeline-related conversations. These previews help keep discussions relevant and provide quick access to pipeline details.
