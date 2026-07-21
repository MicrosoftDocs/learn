::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=9d8ed2bc-f3b0-426a-a73f-30f6ff805b05]

::: zone-end

::: zone pivot="text"

A manual deployment process for database changes is slow and error-prone. Someone writes a script, emails it to the database administrator, and waits for it to be run during a maintenance window. If something goes wrong, rolling back is hard because no one tracked the exact state of the schema before the change. Meanwhile, developers working on different features overwrite each other's changes because there's no structured workflow for database code.

Imagine a team managing an e-commerce application on Azure SQL Database. Three developers are adding features that require schema changes. One adds a new product category table, another modifies the order processing stored procedures, and a third updates the customer lookup views. Without source control, CI/CD pipelines, and automated testing, these changes collide. A hotfix applied directly to production falls out of sync with the development environment. A deployment overwrites the hotfix, causing a production outage during peak hours.

SQL Database Projects and CI/CD pipelines solve these problems by treating database code with the same rigor as application code. You version-control every object, automate builds and deployments, detect when the live database drifts from the project, and test changes before they reach production.

After completing this module, you're able to:

- Create, build, and validate database models by using SQL Database Projects, including SDK-style.
- Configure source control for SQL Database Projects and manage reference data with predeployment and post-deployment scripts.
- Manage branching, pull requests, and conflict resolution for database code.
- Detect schema drift by using schema comparison tools and SqlPackage.
- Implement CI/CD pipelines with GitHub Actions and Azure DevOps, including secrets management and deployment controls.
- Design and implement a testing strategy with unit tests and integration tests.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
