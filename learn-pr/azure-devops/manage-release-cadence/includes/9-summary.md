In this module you ...

Great Work! The team now has a way to automate the releases and they can get the new features to the management team for approval quickly. This will save 5 days in the workflow!

(Talk about the end of the Build LP and the SVM. I will make a new whiteboard for the map for here. We can show great improvement with Azure DevOps)

-----------
Adapted from last module in LP2:
 In this module, you set up *Blue Green deployment* to speed up the deployment process for new features.

There are several deployment patterns to choose from. Choosing a deployment pattern depends on your reasons for the deployment as well as your infrastructure.

Andy and Tim have finished their experiment with Blue Green deployment and have shown it to the team. Let's check in to hear their results.

**Tim**: So as you saw, when we have a new feature in staging, management can approve the feature manually in the pipeline and the swap with production happens instantly. This is going to save me a lot of time.

**Amita:** This is great! I can't wait to show Irwin and see what he says.

## How is the team measuring up?

In the _Assess your existing software development process_ module, Mara performed a [value stream mapping exercise](/learn/modules/assess-your-development-process/4-assess-process-efficiency?azure-portal=true) to help the team analyze their current release cycle process.

Recall that the *activity ratio*, or efficiency, is process time divided by total lead time.

$${Activity\ ratio\ =\ }{\dfrac{Process\ time}{Total\ lead\ time}}$$

The Tailspin web team initially determined they were 23% efficient against this metric.

The team has already reduced some inefficiencies when they implemented Continuous Integration (CI). With Continuous Delivery (CD) in place, they have reduced it even further.

In previous learning paths, the team has reduced:

* The time it takes to set up source control for new features from **three days** to **zero days**.

    They did so by moving from centralized source control to Git, a form of distributed source control. With distributed source control, there's no need to wait for files to be unlocked.
* The time it takes to hand off code to Amita, the tester, from **two days** to **zero days**.

    They did this by moving their build process to Azure Pipelines. Azure Pipelines automatically notifies Amita when a build is available, so the developers no longer need to update Amita's spreadsheet.
* The time it takes Amita to test new features from **three days** to **one day**.

    They did this by unit testing their code. By running unit tests each time a change moves through the build pipeline, fewer bugs and regressions reach Amita, which enables her to complete each manual test pass much faster.

Adding this CD pipeline in this learning path reduced:

* TODO: Get he VSM and calculate it all

These changes reduce the total lead time from 22 days to XXX days. Substitute these numbers into the equation and we get:

$${Activity\ ratio\ =\ }{\dfrac{5\ days}{15\ days}}{ = .33}$$   TODO: Rework the equation

Multiply the result by 100% and you get **XX%**.

Although there's always room for improvement, this is a very positive change for the team. Not only do customers receive value more quickly, the Tailspin team now spends less time waiting and more time doing what they enjoy most &mdash; delivering features they know their customers will love.

## Learning path summary

Congratulations. You've completed the final module in the _Deploy applications with Azure DevOps_ learning path. In this learning path, you accomplished a lot, including:

* XYZ
* XYZ
* XYZ
* XYZ

The focus of this learning path is on the workflow of deploying applications, making sure your application environments are secure, and managing a release cadence.

You can automate ... all using Azure Pipelines.

For more self-paced, hands-on learning around Azure DevOps, also check out [Azure DevOps Labs](https://www.azuredevopslabs.com?azure-portal=true).

## Learn more

* XYZ
