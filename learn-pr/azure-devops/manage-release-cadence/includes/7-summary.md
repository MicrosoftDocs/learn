In this module, you defined a _deployment pattern_ as an automated way to smoothly roll out new application features to your users. A good deployment pattern can help you minimize downtime. It can also enable you to roll out new features progressively to your users.

You can choose from several deployment patterns. The deployment pattern that you choose depends on your reasons for the deployment as well as your resources. Do you have canary testers in place? Will you employ a dark launch and choose testers who don't know that they are testers? If you have a trusted set of testers that progressively increases from a small set to a larger set, then could choose a progressive-exposure deployment. Or if you want to know if one version performs better than another version, you could choose A/B testing.

The Tailspin team chose to implement the blue-green deployment pattern. They took advantage of deployment slots in Azure App Service. *Deployment slots* are live apps that have their own host names. The team can swap two deployment slots. By swapping, they can promote changes to production instantly. Although the team isn't yet ready to release their website to the public, they've proven that they can get new features to their users without incurring downtime.

As a bonus, in this module you also learned how to roll forward an unintended change by reverting a Git commit and then pushing the reverted change through the pipeline.

## How is the team measuring up?

In the _Assess your existing software development process_ module, Mara did a [value-stream mapping exercise](/learn/modules/assess-your-development-process/4-assess-process-efficiency?azure-portal=true). The exercise helped the team analyze their current release-cycle process.

Recall that the *activity ratio*, or efficiency, is *process time* divided by *total lead time*: 

$${Activity\ ratio\ =\ }{\dfrac{Process\ time}{Total\ lead\ time}}$$

The Tailspin web team initially used this metric to determine that they were 23 percent efficient.

The team first reduced some inefficiencies when they implemented continuous integration (CI). By applying continuous delivery (CD), they have now reduced inefficiencies even further.

In previous learning paths, the team reduced:

* The time it takes to set up source control for new features. The required time went from *three days* to *zero days*.

    The team achieved this improvement by moving from centralized source control to Git, a form of distributed source control. By using distributed source control, they don't need to wait for files to be unlocked.
* The time it takes to deliver code to Amita, the tester. The required time went from *two days* to *zero days*.

    The team achieved this improvement by moving their build process to Azure Pipelines. Azure Pipelines automatically notifies Amita when a build is available. Developers no longer need to update Amita's spreadsheet to notify her.
* The time it takes Amita to test new features. The required time went from *three days* to *one day*.

    The team achieved this improvement by unit-testing their code. They run unit tests each time a change moves through the build pipeline, so fewer bugs and regressions reach Amita. The reduced workload means that Amita can complete each manual test faster.

The release pipeline that you and the team built in this learning path reduced:

* The time it takes to get the build into the _Test_ stage. The required time went from *three days* to *one day*.

    The team achieved this improvement by using a scheduled trigger to deploy to _Test_ every day at 3:00 AM.
* The time it takes to get the tested build into _Staging_. The required time went from *two days* to *zero days*.

    The team achieved this improvement by adding Selenium UI tests, a form of functional testing, to the _Test_ stage. These automated tests are much faster than the manual versions.
* The time it takes to get the approved build from _Staging_ to live. The required time went from *one day* to *less than one day*.

    The team achieved this improvement by adding manual approval checks to the pipeline. When management signs off, Tim can release the changes from _Staging_ to live.

These changes reduce the total lead time from 22 days to 10 days. We substitute these numbers into the equation:

$${Activity\ ratio\ =\ }{\dfrac{5\ days}{10\ days}}{ = 0.50}$$

Multiply the result by 100 percent, and we get a *50 percent* reduction.

Although there's always room for improvement, this change is a win for the team. Not only do customers get value more quickly, the Tailspin team now spends less time waiting and more time doing what they enjoy most: delivering features that they know their customers will love.

## Learning path summary

Congratulations. You've completed the final module in the _Deploy applications with Azure DevOps_ learning path. The main focus of this learning path is deploying applications by using Azure Pipelines.

In this learning path, you accomplished a lot, including:

* Building a basic release pipeline that deploys a web application to App Service.
* Expanding your basic release pipeline to a multistage pipeline that deploys to various development, test, and staging environments.
* Running both functional and nonfunctional tests in the pipeline.
* Implementing a blue-green deployment that updates the application and requires minimal downtime.

You can apply what you've learned to the applications and services that you work on.

## Continue the journey

This learning path focused on deploying applications by using Azure Pipelines. You know that you can use the Azure portal, the Azure CLI, or Azure PowerShell to provision resources on Azure. But how will you scale out your deployments to meet global demand?

In [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines/?azure-portal=true), you'll help the Tailspin team answer this question. There, you learn how to use _infrastructure as code_ to describe and automatically provision the infrastructure that you need for your application.

For more self-paced, hands-on learning related to Azure DevOps, also check out [Azure DevOps Labs](https://www.azuredevopslabs.com?azure-portal=true).

## Learn more

Use these additional resources to learn more about App Service, deployment slots, and rolling back changes:

* [App Service documentation](https://docs.microsoft.com/azure/app-service?azure-portal=true)
* [Deploy a website to Azure by using App Service](https://docs.microsoft.com/learn/paths/deploy-a-website-with-azure-app-service?azure-portal=true)
* [Stage a web app deployment for testing and rollback by using App Service deployment slots](https://docs.microsoft.com/learn/modules/stage-deploy-app-service-deployment-slots?azure-portal=true)
* [Set up staging environments in App Service](https://docs.microsoft.com/azure/app-service/deploy-staging-slots?azure-portal=true)

## Recommendations for using feature flags

Feature flags were one of the release-cadence methods that the team considered. The team decided not to use feature flags, but many people have found them useful. This section provides more information about feature flags. 

*Feature flags*, sometime called *feature toggles*, allow you to change how a system works without changing the code. These flags allow you to push new code into trunk and have the code deployed but not necessarily functional. The flags are commonly implemented as the value of variables that control conditional logic.

Imagine that your team is working in the main trunk branch of a bank application. You decided to do all the work in the main branch to avoid messy merge operations later. But you face a problem. You're substantially changing the interest calculations, and people depend on that code every day. Worse, the changes will take you weeks to complete. You can't leave the main code broken for so long.

In this scenario, a feature flag might be a good solution. You can change the code so that users who don't have the feature flag set can keep using the original interest calculation code. Meanwhile, your team does have the feature flag set, so they can see the code that they're changing.

The other type of feature flag is a release flag. Imagine that after you complete the work on the interest calculation code, you want to try it out before you release it publicly. You have a group of users who are well positioned to deal with new code and any possible issues. You'll let them try the feature first. You change the configuration so that they also have the feature flag set and can test the new code. If problems happen, then you can quickly disable the flag.
