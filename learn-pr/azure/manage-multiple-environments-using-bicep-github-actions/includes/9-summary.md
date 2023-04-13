Your website's development team wanted to deploy its changes within a non-production environment. The team wanted to remove the risk of its changes accidentally affecting the customers who access the production website.

In this module, you learned how to work with multiple environments in a deployment workflow. You generalized your deployment process into a reusable workflow, and you used the file as a called workflow for both your test and production environments. You also handled the differences between your environments by storing Bicep parameter values in parameter files, inputs, and secrets.

Now that your workflow deploys to multiple environments, you have higher confidence that the changes you make to your Bicep files will deploy successfully to a non-production environment. And will be tested before they progress to your production environment.

## Learn more

- [GitHub Actions environments](https://docs.github.com/actions/deployment/targeting-different-environments/using-environments-for-deployment)
  - [Environment protection rules](https://docs.github.com/actions/deployment/targeting-different-environments/using-environments-for-deployment#environment-protection-rules)
  - [Viewing deployment history](https://docs.github.com/actions/deployment/managing-your-deployments/viewing-deployment-history)
- [Reusing workflows](https://docs.github.com/actions/learn-github-actions/reusing-workflows)
- Conditions
  - [Jobs](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions#jobsjob_idif)
  - [Steps](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions#jobsjob_idstepsif)
- [Expressions](https://docs.github.com/actions/learn-github-actions/expressions)
- [Environment variables](https://docs.github.com/actions/learn-github-actions/environment-variables)
- [Secrets](https://docs.github.com/actions/security-guides/encrypted-secrets)
- [Secret scanning](https://docs.github.com/code-security/secret-scanning/about-secret-scanning)
