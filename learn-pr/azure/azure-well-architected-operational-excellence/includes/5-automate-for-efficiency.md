| :::image type="icon" source="../media/goal.svg"::: Replace repetitive manual tasks with software automation to get tasks done faster, more accurately, and with less risk. |
| :----------------------------------------------------------------------------------------------------------------------------- |

The workload might have processes that involve team members doing mundane, repetitive, and time-consuming tasks that don't actually need human intellect. If they happen often, they can take up a lot of time, especially as the workload grows. Plus, manual steps usually mean more chances for mistakes. 

Automating those tasks saves time, reduces effort and costs, and helps avoid errors.

**Example scenario**

Contoso University built a web app that's live in Azure and supports online learning for students and faculty.

It's built on Azure App Service, Azure SQL Database, Microsoft Entra ID, Azure Key Vault, and Azure DevOps.

## Automate flows

**Evaluate all workflows based on complexity, effort, frequency, accuracy, timeliness, and lifespan. Use that information to figure out which workflows are worth automating. Start with the workflows that'll give you the biggest payoff. Remove any workflows that don't serve a good purpose. Or make sure they're actually worth the time that people spend on them.**

By doing this approach, you free up your team to focus on higher-value work, boosting both productivity and consistency.

Keep a list of your workflows to ensure that you automate the right tasks. And remove unnecessary tasks to keep your workload simpler and reduce the chance of mistakes.

*Contoso's challenge*

- Contoso University's team is looking for ways to improve the operations process by automating manual tasks that are repetitive, time-consuming, error-prone, or low-value. Automation could free up some of the team's time and resources for more strategic work, improve the quality and reliability of the service, and potentially reduce cost.

*Applying the approach and outcomes*

- To kick things off, the team pulled together a list of manual tasks that might be good candidates for automation. Then they went through the list by using criteria like how complex the task is, how often it happens, how accurate and timely it needs to be, and how long it'll be around. They figured out which tasks to tackle first. They also looked at whether it made more sense to buy an automation tool or build something custom in-house for the long run.

- After the team goes through the analysis, they decide to focus on automating user account management. It's a common task that includes setting up new accounts when students register, resetting passwords, and removing accounts when someone leaves.
- By automating many of the user account tasks, the team freed up enough time to finally start other operational improvements that had been on hold.

## Design for automation

**Set up your workload components so they're ready for automation from the start.**

If you skip automation when designing your system, you're setting yourself up for repetitive tasks, slower progress, and technology debt down the line.

*Contoso's challenge*

- The app has a rich, interactive UI with several animations and moving parts. Since day one, the development team has been testing everything manually. They haven't used any automated UI testing tools.

- Lately, the team has been trying to automate their UI testing, but it hasn't been smooth. Some of the UI pages are too dynamic and unpredictable, and there's no reliable way to identify some of the fields that the test cases need to interact with.

*Applying the approach and outcomes*

- The team decided to make their UI easier to test and more accessible. They're taking it step by step and fixing up each page as they build out the test cases.

- As they work through each page, the team's making sure every field has a unique identifier so the test automation tools can find them easily. They're also following accessibility best practices, like using proper HTML tags, labels, and making sure all elements work with keyboard navigation. It's making the UI easier to use and test.
- As the automated tests get built, they're added to the daily test suite, so every new build gets checked automatically. These checks help speed up releases to production, improve quality, and reduce development costs.

## Ensure that automation is well-architected

**Treat automation like a key part of your workload. It's not just a nice-to-have feature. Make sure it can scale as your workload grows. And since it's such a core piece, it should follow the same best practices as the rest of your system, like the five pillars of the Well-Architected Framework.**

Build your automation with security and reliability in mind. Following best practices helps you avoid messy, scattered implementations. As long as your automation stays functional and secure, your workload can keep running smoothly.

*Contoso's challenge*

- The workload has a dedicated environment just for load and performance testing that's set up to closely match production. To keep things realistic, every Monday the team resets the environment and loads in a fresh copy of the production database, with all sensitive user data anonymized and masked.

- The database loading script was written by a former developer who didn't document it well or follow other best practices. The script runs slowly and doesn't handle errors or failures gracefully.
- Now that the production database has grown, the script takes even longer and fails more often. That's been holding up test runs and causing delays in the development schedule.

*Applying the approach and outcomes*

- The team decides it's time to give this tool a fresh start so it lines up with standard development practices in the main app. They'll be using reliable, modern development practices, like strong security and smart error handling.

- Performance got a boost, and the functionality was redesigned to make sure it runs with consistent timing no matter how big the production dataset is.
- The team treats the automation with the same level of care as the core application codebase, and follows the Well-Architected Framework principles and recommendations. This approach made their workload more reliable, secure, and efficient across performance, cost, and operations.
