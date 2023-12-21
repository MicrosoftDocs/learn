| :::image type="icon" source="../media/goal.svg"::: Replace repetitive manual tasks with software automation that completes them quicker, with greater consistency and accuracy, and reduces risks. |
| :----------------------------------------------------------------------------------------------------------------------------- |

The workload might have workflows with processes that involve team members doing mundane, repetitive, and time-consuming tasks that don't actually need human intellect. Depending on the frequency, you might spend considerable time on these efforts, investing more time as the workload grows. Also, these processes are often error-prone due to human input.

Through automation, you save time, effort, and money, and you avoid mistakes.

**Example scenario**

Contoso University has developed a web application, currently in production and hosted in Azure, which provides online education services for Contoso's students and faculty.

The technology solution is built on Azure App Service, Azure SQL Database, Azure Active Directory, Azure Key Vault, and Azure DevOps.  

## Automate flows

**Evaluate all workflows against criteria that's at the right level of complexity, effort, frequency, accuracy, timeliness, and lifespan. Automate workflows based on that evaluation and prioritize the workflows with the highest expected returns. Remove redundant workflows or add value to justify human effort.**

By adopting this approach, you can reinvest team capacity in higher value work and increase productivity and consistency.

Building an inventory of workflows ensures that you automate the right tasks. Removing redundant tasks reduces complexity and errors.

*Contoso's challenge*

- Contoso University’s team is looking for ways to improve the operations process by automating manual tasks that are repetitive, time-consuming, error-prone, or low-value. This could free up some of the team's time and resources for more strategic work, improve the quality and reliability of the service, and potentially reduce cost.

*Applying the approach and outcomes*

- To start this effort, the team conducted an inventory of manual operations tasks that could potentially be automated. Next, the team analyzed the list of tasks using the criteria suggested in the recommendation, such as the right level of complexity, effort, frequency, accuracy, timeliness, and lifespan, to determine the top candidates for automation. At the same time, the team also evaluated whether acquiring an automation tool or custom building the automation in-house could be better in the long term.
- As a result of the analysis, they decided to focus on automating activities related to user account management. Managing user accounts (students, faculty, staff) is a common task, which includes creating new accounts upon student registration, resetting passwords, and deleting accounts when individuals leave the university.
- By automating many of the tasks related to user account management, the team has freed up sufficient time to start on other operational excellence improvements that had been delayed previously.

## Design for automation

**Design your workload components to support automation capabilities.**

Avoid the situation where lack of automation in your system design promotes the anti-pattern of repetitive tasks, slows down growth, and starts accumulating technical debt.

*Contoso's challenge*

- The application has a rich and dynamic UI that uses many interactive elements and animations. The development team has never used automated UI testing tools since the application was originally developed and has only relied on manual testing.
- Recently, the team has been working on automating their UI testing, but have been facing many challenges. Some of the UI pages are too dynamic and unpredictable, and there’s no consistent way to identify some of the fields that the test cases need to interact with.

*Applying the approach and outcomes*

- The team has decided to improve their UI implementation to make it more testable and accessible. They will make the improvements incrementally by fixing the pages as they create the test cases.
- As they tackle each page, they make sure that every field has a unique identifier that can be used by the test automation tools. They also follow accessibility guidelines and standards, such as using semantic HTML, proper labels, and keyboard navigation. This makes their UI more user-friendly and easier to test.
- As automated tests are completed, they are incorporated into the test suite that runs during the daily build, resulting in significant reductions in the time it takes to release new builds to production, improvements in product quality, and cost savings during development. 

## Automation should be well-architected

**Treat all automation as a critical dependency of your workload. Adapt to the workload's expected growth. Your automation tooling is an integral part of your workload, and it should adhere to the five Well-Architected Framework pillars.**

Design your automation component to withstand risks, such as security threats. With applied best practices, you can avoid implementation sprawl.

The workload will continue to operate with a high-level guarantee if this dependency is kept functional and safe.

*Contoso's challenge*

- The workload has an environment dedicated to load and performance testing, with a configuration that closely mimics production. To simulate production-like conditions in the environment more closely, a fresh copy of the production database, with all user’s sensitive data anonymized and masked, is loaded into the test environment every Monday, when that environment is reset.
- The database loading script was written by a former developer who didn’t document it well or follow other best practices. The script runs slowly and doesn’t handle errors or failures gracefully.
- Lately, as the production database grows, the script run time has gotten increasingly longer and frequently fails. These delays and failures are impacting the team’s ability to execute the test runs and are causing delays in the development schedule.

*Applying the approach and outcomes*

- The team decides the time has come to rewrite this tool so it can be at par with the standard development practices used to develop the core application codebase. The team will follow industry accepted best development practices, including proper security and adequate error handling.
- Performance is improved and the functionality has been redesigned in such a way that it produces a predictable execution time, regardless of the size of the production dataset.
- By treating the automation with the same rigor as the core application codebase and applying the WAF principles and recommendations, the team has optimized it for reliability, security, performance, costs, and operations.