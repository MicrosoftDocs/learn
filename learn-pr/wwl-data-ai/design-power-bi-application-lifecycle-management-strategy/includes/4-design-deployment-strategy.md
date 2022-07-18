In the previous unit, we discussed how to secure your changes, and now we'll review options for deployment. In large organizations, you may have hundreds of reports and datasets. Applicaton lifecycle management dictates development, test, and then deploy, which will multiply the number of files you have in the environment. This can be an administrative nightmare which is why creating a deployment strategy will reduce time and effort across the company.

## Consider the options

When you create a report through Power BI Desktop, you have a single asset - a .PBIX file. When you publish to Power BI service, you will have a dataset and a report. Then you can create a dashboard from the report. In small organizations, it may be sufficient to accept this published report as a "gold copy" or the "production" copy.

However, enterprises commonly implement application lifecycle management we previously discussed, which sets a precedence to separate for Dev, Test, and Prod. In those situations, you would publish the initial .PBIX file to the Dev workspace, then allow testing in Test, and finally publish to Prod when approved.

> [!NOTE]
> We'll only reference *Dev, Test, and Prod* for our purposes, but recognize your organization may have a different structure.

You can manually create separate workspaces for your specific needs, or you can use the built-in Power BI service deployment pipelines.

## Power BI service deployment pipelines

A Power BI deployment pipeline, simply put, is a separate workspace for each Dev, Test, and Prod. The real value with deployment pipelines is that you can see when there is a discrepancy between the different workspaces.

In the following image, you see the three workspaces for Dev, Test, and Prod with a single dataset and report in each, but you see that there is an additional report in the Dev workspace that is not in Test or Prod. This quickly identifies the disparity, and even allows you to remediate it from the pipeline dashboard.

* *<< insert a graphic for this: >> *

> [!IMPORTANT]
> Power BI deployment pipelines require a Premium or Premium Per User workspace.

## Combining source control and deployment pipeplines 

In the last unit, we discussed source control strategies. Whether your organization uses OneDrive/SharePoint or Git, you can use deployment pipelines. You can:

* Use only deployment pipelines for everything (.PBIX files only)
* Use OneDrive/SharePoint for source control of .PBIX files, then publish final copy to the Dev pipeline, and use deployment pipelines to maintain parity
* Use Git for .BIM files, OneDrive/Sharepoint for .PBIX files, publish final copy to the Dev pipeline, and finally use deployment pipelines

## Power BI service workspace planning

With large organizations, often there are many reports created from shared datasets. Instead of having duplicate datasets across several workspaces, consider creating a single workspace for a dataset, then a separate workspace for the subsequent reports and dashboards.

By separating the datasets, you can grant access to a larger audience to create reports from the dataset, and allow their specific reports to reside in their appropriate report workspaces.

## Continuous Integration/Continuous Deployment

Continuous Integration/Continuous Deployment (CI/CD) is a more recent concept focused on the automation from Dev to Prod. You may have noticed that deployment pipelines are not able to track a .BIM file, only the dataset that is associated with the .PBIX file when published to Power BI service. Therefore it does not fully encapsulate a true CI/CD solution. However, if your organization desires more control, you can use Azure DevOps for Git, then use the Power BI Connector and XMLA endpoint to deploy from the repository to the deployment pipelines.

> [!TIP]
> To implement automated deployment pipelines, review the [Power BI reference documentation](/power-bi/create-reports/deployment-pipelines-automation).
