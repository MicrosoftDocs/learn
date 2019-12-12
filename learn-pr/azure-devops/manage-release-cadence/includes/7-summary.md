In this module, you defined a _deployment pattern_ as an automated way to smoothly roll out new application features to your users. A good deployment pattern can help you minimize downtime. It can also enable you to roll out new features progressively to your users.

There are several deployment patterns to choose from. Choosing a deployment pattern depends on your reasons for the deployment as well as your resources. Do you have canary testers in place, or will you employ a dark launch and choose testers that don't know they are testers? If you have a set of testers that progressively increase from a small trusted set to a larger set, then you might use progressive exposure deployment. Perhaps you want to test if one version performs better than another version with A/B testing.

The team chose to implement the *blue-green deployment* pattern. Azure App Service provides *deployment slots*, which are live apps with their own host names. You can swap between two deployment slots, which enables you to promote changes to production instantly. Although the team is not yet ready to release their website to the public, they've proven that they can get new features to their users without incurring downtime.

As a bonus, you also learned how to roll forward an unintended change by reverting a Git commit and then pushing the reverted change through the pipeline.

## How is the team measuring up?

In the _Assess your existing software development process_ module, Mara performed a [value stream mapping exercise](/learn/modules/assess-your-development-process/4-assess-process-efficiency?azure-portal=true) to help the team analyze their current release cycle process.

Recall that the *activity ratio*, or efficiency, is process time divided by total lead time.

$${Activity\ ratio\ =\ }{\dfrac{Process\ time}{Total\ lead\ time}}$$

The Tailspin web team initially determined they were 23% efficient against this metric.

The team first reduced some inefficiencies when they implemented continuous integration (CI). With continuous delivery (CD) in place, they have reduced it even further.

In previous learning paths, the team reduced:

* The time it takes to set up source control for new features from **three days** to **zero days**.

    They did this by moving from centralized source control to Git, a form of distributed source control. With distributed source control, there's no need to wait for files to be unlocked.
* The time it takes to hand off code to Amita, the tester, from **two days** to **zero days**.

    They did this by moving their build process to Azure Pipelines. Azure Pipelines automatically notifies Amita when a build is available, so the developers no longer need to update Amita's spreadsheet.
* The time it takes Amita to test new features from **three days** to **one day**.

    They did this by unit testing their code. By running unit tests each time a change moves through the build pipeline, fewer bugs and regressions reach Amita, which enables her to complete each manual test pass much faster.

The release pipeline that you and the team built in this learning path reduced:

* The time it takes to get the build into the _Test_ stage from **three days** to **one day**

    They did this by using a scheduled trigger to deploy to _Test_ every day at 3:00 AM.
* The time it takes to get the tested build into _Staging_ from **two days** to **zero days**.

    They did this by adding Selenium UI tests, a form of functional testing, to the _Test_ stage. These automated tests are much faster than the manual versions.
* The time it takes to get the approved build from _Staging_ to live from **one day** to **less than one day**.

    They did this by adding manual approval checks to the pipeline. When management signs off, Tim can release the changes from _Staging_ to live.

These changes reduce the total lead time from 22 days to 10 days. Substitute these numbers into the equation and we get:

$${Activity\ ratio\ =\ }{\dfrac{5\ days}{10\ days}}{ = .50}$$

Multiply the result by 100% and you get **50%**.

Although there's always room for improvement, this is a very positive change for the team. Not only do customers receive value more quickly, the Tailspin team now spends less time waiting and more time doing what they enjoy most &mdash; delivering features they know their customers will love.

## Learning path summary

Congratulations. You've completed the final module in the _Deploy applications with Azure DevOps_ learning path. The main focus of this learning path is on deploying applications with Azure Pipelines.

In this learning path, you accomplished a lot, including:

* Building a basic release pipeline that deploys a web application to App Service.
* Expanding your basic release pipeline to a multi-stage pipeline that deploys to various development, test, and staging environments.
* Running both functional and non-functional tests in the pipeline.
* Implementing a blue-green deployment that updates the application with minimal downtime.

You can apply what you've learned to the applications and services that you work on.

## Continue the journey

This learning path focused on deploying applications with Azure Pipelines. Although you can use the Azure portal, the Azure CLI, or Azure PowerShell to provision resources on Azure, how will you scale out your deployments to meet global demand?

In [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines/?azure-portal=true), you'll help the Tailspin team answer this question. There, you learn how _infrastructure as code_ enables you to describe and automatically provision the infrastructure you need for your application.

For more self-paced, hands-on learning around Azure DevOps, also check out [Azure DevOps Labs](https://www.azuredevopslabs.com?azure-portal=true).

## Learn more

Here are some additional resources you can use to learn more about App Service, deployment slots, and rolling back changes:

* [App Service Documentation](https://docs.microsoft.com/azure/app-service?azure-portal=true)
* [Deploy a website to Azure with Azure App Service](https://docs.microsoft.com/learn/paths/deploy-a-website-with-azure-app-service?azure-portal=true)
* [Stage a web app deployment for testing and rollback by using App Service deployment slots](https://docs.microsoft.com/learn/modules/stage-deploy-app-service-deployment-slots?azure-portal=true)
* [Set up staging environments in Azure App Service](https://docs.microsoft.com/azure/app-service/deploy-staging-slots?azure-portal=true)

## Recommendations for using feature flags

Feature flags were one of the release cadence methods the team considered. They decided not to use them, but many people have found them useful, so here's a little more information about them. 

Feature flags, sometime called feature toggles, allow you to change how a system works without making changes to the code. These flags allow you to push new code into trunk and have it deployed, but not necessarily functional. The flags are commonly implemented as the value of variables that control conditional logic.

Imagine that your team is working in the main trunk branch of a bank application and you've decided to have all the work done in the main branch to avoid messy merge operations later. The problem is that you’re making substantial changes to the interest calculations and people depend on that code every day. Worse, the changes will take you some weeks to complete. You can't leave the main code broken for that long.

This situation is a good place for a feature flag. You can change the code so that users who don't have the feature flag set will still keep using the original interest calculation code. Meanwhile, the team members who are working on the new interest calculations and who do have the feature flag set will see the code that's being created.

The other type of feature flag is a release flag. Imagine that, after you complete the work on the interest calculation code, you want to try it out before a general release. You have a group of users who are better at dealing with new code and any possible issues. You’ll let them try the feature first. You change the configuration, so that they also have the feature flag set and can start to test the new code. If problems occur, you can quickly disable the flag.
