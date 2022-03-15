A release management (RM) process involves more than just deployment. So, a release pipeline needs more than just steps for application deployment.

There's a whole raft of checks one would prefer to do before releasing a new version of the software through a release pipeline.

To name a few checks to ensure that there are no active critical issues open and being investigated and no known service degradation or performance alerts.

While the deployment process is automated, many of these checks are carried out manually, which forces automated release pipelines to have manual approval steps. No more! Azure Release Pipelines supports Gates.

Gates allow automatic collection of health signals from external services and then promote the release when all the signals are successful at the same time or stop the deployment on timeout.

Typically, gates are connected with incident management, problem management, change management, monitoring, and external approval systems.

Gates provides you with a way to enable progressive exposure and phased deployments.

## Getting started

1.  Open the wanted Team Project in Azure DevOps, navigate to the Queries page under Azure Boards.
    
    :::image type="content" source="../media/queries-page-azure-boards-112d402e.png" alt-text="Queries page.":::
    
2.  Click to create a new Query, add a filter to return work item types of Bug of status New with priority one and severity Critical. Save the query in shared queries as `Untriaged Critical Bugs`.
    
    :::image type="content" source="../media/untriaged-critical-bugs-query-dfe00c44.png" alt-text="Untriaged Critical Bugs.":::
    
3.  In the same team project, navigate to Azure Pipelines. Create an empty release pipeline with one stage. Call it staging.
    
    :::image type="content" source="../media/new-release-pipeline-e19e8e08.png" alt-text="New release pipeline.":::
    
4.  In Staging, add a PowerShell task, set it to inline mode to print "Hello World."
    
    :::image type="content" source="../media/new-release-pipeline-powershell-script-328eb7c6.png" alt-text="New release pipeline with PowerShell script.":::
    

5.  Name the pipeline as rel.software and click save. Create a release and see the release go through successfully.

    :::image type="content" source="../media/succeeded-staging-3bdf4352.png" alt-text="Succeeded staging.":::


## How to do it

1.  Edit the release pipeline, click on pre-deployment condition, and from the right pane, enable gates.
    
    :::image type="content" source="../media/pre-deployment-conditions-9bf2a1cc.png" alt-text="Pre deployment conditions.":::
    
2.  Click on Add to add a new gate, choose `Query Work Item` type Gate.
    
    :::image type="content" source="../media/query-work-item-gate-5f86e642.png" alt-text="Query work items gate.":::
    
3.  From the query work item drop-down, select the shared query 'untriaged critical bugs' created earlier and set the upper threshold to 0. Set the delay between the evaluation period to 1 minute. Expand the evaluation options section and ensure that the time between the evaluation of gates is set to 10 minutes and the Minimum duration for steady results after a successful gates evaluation is configured to 15 minutes.

    :::image type="content" source="../media/query-work-items-evaluation-aaccf104.png" alt-text="Query work items evaluation.":::


4.  Save and queue a release. You'll see that the gate gets evaluated right away.

    :::image type="content" source="../media/staging-processing-gates-79351c53.png" alt-text="Staging processing gates.":::


5.  Before the next evaluation of the gate, create a new work item of type Bug with Priority 1 and severity critical. Wait for the following evaluation of the gate in the release pipeline to complete.

    :::image type="content" source="../media/failed-gate-staging-c69d0812.png" alt-text="Failed gate and staging.":::


6.  Close the bug as fixed. You'll see that after periodic evaluations and a stable period of 15 minutes, the release is completed successfully.

    :::image type="content" source="../media/query-work-items-gate-succeeded-4017bf52.png" alt-text="Query work items gate succeeded.":::


## How it works

1.  When a new release is triggered, the release goes into a state of pre-approvals. At this time, the automated gate is evaluated at the specified interval of 10 minutes. The release will only move into an approval state if the gate passes during steady results, specified as 15 minutes in this case. As presented in the following logs, the gate is failed in the second-validation check as one critical bug of one priority is identified in the new state using the configured work item query.

    :::image type="content" source="../media/query-work-items-log-99f8d5dc.png" alt-text="Query work items log.":::


2.  Detailed logs of the gate checks can be downloaded and inspected along with the release pipeline logs.

## There's more

In this exercise, we looked at the Work Item Query gate. The following other gates are supported out of the box.

The following gates are available by default:

 -  Invoke Azure function: Trigger the execution of an Azure function and ensure successful completion. For more information, see the Azure function task.
 -  Query Azure monitor alerts: Observe the configured Azure monitor alert rules for active alerts. For more information, see the Azure monitor task.
 -  Invoke REST API: Call a REST API and continue if it returns a successful response. For more information, see the HTTP REST API task.
 -  Query Work items: Ensure the number of matching work items returned from a query is within a threshold. For more information, see the Work item query task.
 -  Security and compliance assessment: Assess Azure Policy compliance on resources within the scope of a given subscription and resource group and optionally at a specific resource level. For more information, see Security Compliance and Assessment task.

You can develop your gates using the Azure DevOps API. Check out the gates developed by the community for inspiration [here.](https://www.visualstudiogeeks.com/DevOps/IntegratingServiceNowWithVstsReleaseManagementUsingDeploymentGate)
