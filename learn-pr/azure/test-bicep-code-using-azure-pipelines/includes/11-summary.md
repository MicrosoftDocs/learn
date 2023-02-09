Your website's Bicep deployments sometimes failed because of problems you'd introduced in your Bicep files. You wanted to add quality control to your deployment pipeline to reduce the likelihood of any problems affecting your production website.

In this module, you learned how to add validation and tests to your Bicep deployment pipeline. You learned about multistage pipelines, and how to create pipeline stages to lint and validate a Bicep file. Then you learned how to add a preview stage to your pipeline, which runs the what-if command and asks for human verification before the pipeline continues. Finally, you learned about the importance of functional testing, and you added a test to verify that your website meets your security team's requirements after every deployment.

Now, you can be more confident that your automated deployments will succeed and that they won't cause problems for your environments.

## References

- [Shifting left](/devops/develop/shift-left-make-testing-fast-reliable)
- [Stages](/azure/devops/pipelines/process/stages?tabs=yaml)
  - [Conditions](/azure/devops/pipelines/process/stages?tabs=yaml#conditions)
  - [Parallel jobs](/azure/devops/pipelines/licensing/concurrent-jobs)
- [Pipeline artifacts](/azure/devops/pipelines/artifacts/pipeline-artifacts?tabs=yaml)
- [Bicep linter](/azure/azure-resource-manager/bicep/linter)
- [Environments](/azure/devops/pipelines/process/environments)
  - [Deployment jobs](/azure/devops/pipelines/process/deployment-jobs)
- [Pipeline approvals and checks](/azure/devops/pipelines/process/approvals)
- [Branch policies](/azure/devops/repos/git/branch-policies)
- [What-if operation](/azure/azure-resource-manager/templates/deploy-what-if)
- Testing
  - [Pester](https://github.com/pester/Pester)
  - [PSRule for Azure](https://azure.github.io/PSRule.Rules.Azure/)
  - [Software on Microsoft-hosted agents](/azure/devops/pipelines/agents/hosted?&tabs=yaml#software)
  - [Use output variables from tasks](/azure/devops/pipelines/process/variables#use-output-variables-from-tasks)
  - [Deployment jobs - support for output variables](/azure/devops/pipelines/process/deployment-jobs#support-for-output-variables)
  - [Test results](/azure/devops/pipelines/test/review-continuous-test-results-after-build)