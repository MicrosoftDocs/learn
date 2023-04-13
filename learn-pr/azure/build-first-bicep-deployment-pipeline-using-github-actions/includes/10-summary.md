Your toy company regularly updates its website, and it was becoming time-consuming for you to manually deploy updated Bicep files. You also were the only person in your company who knew how to deploy the website infrastructure.

In this module, you learned how to use GitHub Actions to create an automated deployment process. You built a workflow that automatically deploys your resources to Azure by using Bicep templates. You also learned how to trigger workflows for every change that's made to your Bicep code, on a set schedule, or both. The process you successfully completed in the exercises can be scaled from a single person to an entire organization.

Thanks to your efforts, anyone on your website team can automatically deploy changes to your Azure environment, and they run through the same process for every change.

## References

- [Microsoft Azure Actions on the GitHub Marketplace](https://github.com/marketplace?type=actions&query=azure&verification=verified_creator)
  - [Azure Login action](https://github.com/marketplace/actions/azure-login)
  - [Azure ARM Deploy action](https://github.com/marketplace/actions/deploy-azure-resource-manager-arm-template#example-on-how-to-use-failonstderr)
  - [Azure CLI action](https://github.com/marketplace/actions/azure-cli-action)
- [Connecting to GitHub with SSH](https://docs.github.com/github/authenticating-to-github/connecting-to-github-with-ssh)
- [Webhook event triggers](https://docs.github.com/actions/reference/events-that-trigger-workflows)
- [Schedule workflows](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows#schedule)
