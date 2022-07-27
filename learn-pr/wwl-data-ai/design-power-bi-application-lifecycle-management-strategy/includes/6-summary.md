In our initial scenario, we needed to choose a source control solution for collaborating on Power BI reports and datasets, and design a deployment strategy to reduce repetitive tasks and human oversight.

OneDrive and Git provided source control solutions. We can use either solution to collaborate and prevent losing someone's hard work. Within Power BI service, deployment pipelines automatically create development, test, and production workspaces, and track changes across all workspaces. Deployment pipelines reduce administrative overhead and allow your team to focus on developing the reports. Azure DevOps provides source control and can be combined with XMLA endpoints to publish to deployment pipeline workspaces.

As your analytics environment expands, you'll have many opportunities to improve your strategy. Consider these related articles to familiarize yourself more with source control and deployment concepts:

* [Introduction to source control - Microsoft Learn](/learn/modules/introduction-to-source-control/)
* [Connect to Analytics with Power BI Data Connector - Microsoft Docs](/azure/devops/report/powerbi/data-connector-connect)
* [Power BI - CI/CD using Azure DevOps - Power BI Community Blog](https://community.powerbi.com/t5/Community-Blog/PowerBI-CICD-using-Azure-DevOps/ba-p/769244)
