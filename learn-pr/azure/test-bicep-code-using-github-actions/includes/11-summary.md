Your website's Bicep deployments sometimes failed because of problems you'd introduced in your Bicep files. You wanted to add quality control to your deployment workflow, to reduce the likelihood of any problems affecting your production website.

In this module, you learned how to add validation and tests to your Bicep deployment workflow. You learned about multi-job workflows, and how to create workflow jobs to lint and validate a Bicep file. Then you learned how to add a preview job to your workflow, which runs the what-if command and asks for human verification before the workflow continues. Finally, you learned about the importance of functional testing, and you added a test to verify that your website meets your security team's requirements after every deployment.

Now, you can be more confident that your automated deployments will succeed and that they won't cause problems for your environments.

## References

- [Shifting left](/devops/develop/shift-left-make-testing-fast-reliable)
- [GitHub Actions jobs](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions#jobs)
  - [needs](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions#jobsjob_idneeds)
  - [if](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions#jobsjob_idif)
  - [outputs](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions#jobsjob_idoutputs)
  - [needs context](https://docs.github.com/actions/learn-github-actions/contexts#needs-context)
- [GitHub Actions expressions](https://docs.github.com/actions/learn-github-actions/expressions)
- [Bicep linter](/azure/azure-resource-manager/bicep/linter)
- [GitHub Actions environments](https://docs.github.com/actions/deployment/using-environments-for-deployment)
  - [Protection rules](https://docs.github.com/actions/deployment/using-environments-for-deployment#environment-protection-rules)
- [Branch protection](https://docs.github.com/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)
- [What-if operation](/azure/azure-resource-manager/templates/deploy-what-if)
- Testing
  - [Pester](https://github.com/pester/Pester)
  - [PSRule for Azure](https://azure.github.io/PSRule.Rules.Azure/)
  - [Software on GitHub-hosted runners](https://docs.github.com/actions/using-github-hosted-runners/about-github-hosted-runners#supported-software)
