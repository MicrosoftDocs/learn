
How do you measure the quality of your release process? The quality of your release process can't be measured directly because it's a process. What you can measure is how well your process works.

If your release process constantly changes, it might indicate something wrong with the process. If your releases continuously fail, and you regularly must update your release process to make it work, it might also suggest that something is wrong with your release process.

Maybe something is wrong with the schedule on which your release runs, and you notice that your release always fails on a particular day or at a specific time. Or your release always fails after the deployment to another environment. It might be an indication that some things are maybe dependent or related.

You can keep track of your release process quality by creating visualizations about the quality of all the releases following that same release process or release pipeline.

For example, we're adding a dashboard widget that shows you the status of every release.

:::image type="content" source="../media/release-overview-widget-5a358bdd.png" alt-text="Screenshot of a multiple release overview widget.":::


The release also has a quality aspect, but it's tightly related to the quality of the deployment and package deployed. When we want to measure the quality of a release itself, we can do all kinds of checks within the pipeline.

You can execute all different types of tests like integration tests, load tests, or even UI tests while running your pipeline and checking the release's quality.

Using a quality gate is also a perfect way to check the quality of your release. There are many different quality gates. For example, a gate that monitors to check if everything is healthy on your deployment targets, work item gates that verify the quality of your requirements process.

You can add extra security and compliance checks. For example, do we follow the four-eyes principle, or do we have the proper traceability?
