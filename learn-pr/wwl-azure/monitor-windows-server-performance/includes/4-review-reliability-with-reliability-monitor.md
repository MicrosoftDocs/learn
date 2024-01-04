Windows Server installs Reliability Monitor by default. It monitors hardware and software issues that occur during the selected time interval. Based on the number and type of issues, it assigns a number called a stability index that indicates the server's reliability. This index ranges from 1 to 10, where 1 represents the least-stable server state and 10 represents the most stable state. By using the index, you can quickly evaluate a server's reliability.

> [!NOTE]
> Any issue that effects the server has the potential to change the value of the stability index.
## How can you use Reliability Monitor?

Load Reliability Monitor by accessing Control Panel, browsing to Security and Maintenance, and then selecting Maintenance. Reliability Monitor is represented with a View reliability history link. By selecting this link, a Reliability Monitor window displays:

- A reporting history of the stability index values from previous days or weeks. The stability index information about application failures, Windows operating system failures, miscellaneous failures, and warnings are available.

- A reliability details table that has the source of the issue, summary information, the date, and the action taken.

- A group of actions that you can perform, which are represented as links in the console and include:

  - Saving the reliability history to an XML file. Use this option if you want to keep track of older reliability history information.

  - Starting the Problem Reports console. You can use this to monitor issues related to specific applications. For each problem that Reliability Monitor detects, options in the console allow you to get more details about the problem, check online for a solution, or to delete the reported problem information.

  - Checking for a solution for all reported problems. You can use this option if you want Reliability Monitor to connect to the internet to find online information about resolving all the reported problems.

As displayed in the following screenshot, the administrator is reviewing the reliability and problem history for the server. The administrator has selected a specific day a week or so back, and a number of failures are displayed. There is also an informational indicator. The reliability details provide information about the failures and the informational events recorded for the selected day.

![The screenshot depicts Reliability Monitor where an administrator reviews reliability and problem history for the server. Selected are a specific day and displayed are the number of failures for that day. There is also an informational indicator. The reliability details provide information about the failures and the informational events recorded for the selected day.](../media/reliability-monitor.png)

> [!TIP]
> For some events, you can select a View technical details link that enables you to learn more about the recorded event. 
Reliability Monitor enables you to access important reliability information about your server quickly and easily. However, you can also review related information in Event Viewer.

