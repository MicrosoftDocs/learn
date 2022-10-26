You're at the stage where you need to migrate from your existing solution to Azure. You've done your costing, workload assessment, staff needs, and have most of your plan in place. As you think about the next phase, actually moving your workloads, there are more considerations to keep in mind.

## Workload priority

Since migration may be new territory for you, think about which workloads you can move that would have the least impact to your environment and start with those. Since you've done your architecture assessment, you know how all your workloads interact and their interdependencies. Now you can better evaluate the priority against which you can migrate.

### Dependencies

If you have a workload other workloads depend (say a library to which your code makes infrequent API calls), this might be a good candidate since you get to test your migration strategy on a lower priority library but you also get to test dependencies in your other code.

### Data

Do you have a database or two that contain non-essential lookup tables (perhaps for internal tools)? It may be a good candidate to test your data migration strategy.

### Functions and new workloads

As you look at your architecture, you may have assessed that some code can be broken out and Azure function app. Depending on the importance of this code, spending time at the beginning of your workload migration to move this over may be a good candidate.

## Communication

I may go without saying (pun intended) that "over-communicating" during a large migration will be critical. While there are [resources](/SharePoint/upgrade-and-update/create-a-communication-plan-for-the-upgrade-to-sharepoint-2013) that can help you develop a broad communication plan, some simple rules of thumb here may serve as a reminder.

### Communicate early and often

Change management is difficult even in the best of circumstances. One area of stress for people in an organization isn't knowing what's happening and when. This is true for managers and users and customers. While writing a weekly or bi-weekly email can be a burden, it will save you much larger costs in the end.

### The "Goldilocks" principle

As any physicist will tell you, frequency and volume are two different things. The same is true of communication. If you're following the first rule and you often communicate, you'll want to be careful to be succinct but meaningful. Finding just the right balance between the two takes a bit of work but with practice, it can become second nature.

When you think about *what* to say, your words should give the information people need and not be too padded with things they don't. For example,

"Kasie created function X on Azure as a Function app to replace the BinLib library in BizLogicFunctions.aspx and all dependent code is now calling that function app successfully."

Is much more informational than,

"An Azure function app was created this week and the hope is that by using this new function in the cloud, our application will be easier to maintain, make more sense architecturally, and cost less. As we begin to use this function, we'll know more about how successful it will be."

The latter example may be necessary for a morale email (or an email to a broad audience) but for status, you'll probably want to write more like the former.

### Provide links and summarize data

If you use workflow tracking software like Jira or even an Excel spreadsheet, your status reports should summarize highlights, but point to the actual data so people can explore. And here's a pro-tip to save you time and foster love and admiration: even if you've sent out the link in every status report you've sent, provide it on first mention of the data or tool in all subsequent mails. It makes it easy for people to find the data and will prevent you from having to answer those myriad Teams chat questions, "Where is the link again? I know it's somewhere I just can't find it."

## Management, monitoring, backup, and disaster recovery

Hopefully, your IT department has workflows for your existing solution to manage and monitor the overall solution, perform regular backups and a set of plans for what to do if certain parts of the solution fail. As you move to the cloud, Azure has tools to help in each of these areas so you'll need to make sure your updated plans account for the changes.

You may be able to use your existing tools (for example, Power BI can work against an on-premises database and a cloud database) but a review of each of these areas is in order to ensure your migration includes plans for all of them.
