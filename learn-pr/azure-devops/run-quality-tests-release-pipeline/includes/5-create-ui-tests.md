Roberta: I did all the prep work, I just need to come back and set the procedures. I'll follow along with the narrative from the previous module.

* Pull down branch
* Run Selenium tests locally (head vs headless)
* Modify pipeline to run tests on Windows agent
* Push and run through pipeline
* See results

* Fetch branch with starter build config
  * This branch will include an additional .csproj that contains Selenium tests
  * [Reference](https://docs.microsoft.com/azure/devops/pipelines/test/continuous-test-selenium?view=azure-devops)
* Change (or add) deployment stage to **Hosted VS2017**.
* `git commit && git push` - watch it build, deploy, & **run tests** in the pipeline.
* Verify the results in the pipeline.
* Manually promote the build to Preprod.

Amita is impressed and feels a bit excited about writing code to control her web browser. Perhaps Mara shows her some resources (tutorials, reference documentation) so Amita can continue writing tests. Amita can then write and verify additional tests and submit them to GitHub and have them run through the pipeline just like the developers.