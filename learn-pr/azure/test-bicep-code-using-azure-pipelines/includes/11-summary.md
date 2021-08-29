Your website's Bicep deployments sometimes failed because of problems you'd introduced in your Bicep files. You wanted to add testing to your deployment pipeline, to reduce the likelihood of any issues impacting your production website.

In this module, you learned how to add validation and tests to your Bicep deployment pipeline. You learned how to lint and validate a Bicep file in the first stage of a multistage pipeline. Then you learned how to add a preview stage to your pipeline, which runs the what-if command and asks for human verification before the pipeline continues. Finally, you learned about the importance of functional testing, and you added a test to verify your website is accessible after each deployment.

Now, you can be more confident that your automated deployments will succeed and that they won't cause issues for your environments.

## References

- [Stages](/azure/devops/pipelines/process/stages?tabs=yaml)
- [Environments](/azure/devops/pipelines/process/environments)
- [Deployment jobs](/azure/devops/pipelines/process/deployment-jobs)
- Approvals and policies:
  - [Pipeline approvals](/azure/devops/pipelines/process/approvals)
  - [Branch policies](/azure/devops/repos/git/branch-policies)
- Testing
  - [Pester](https://github.com/pester/Pester)
  - [Use output variables from tasks](/azure/devops/pipelines/process/variables#use-output-variables-from-tasks)
  - [Deployment jobs - support for output variables](/azure/devops/pipelines/process/deployment-jobs#support-for-output-variables)
  - [Test results](/azure/devops/pipelines/test/review-continuous-test-results-after-build)