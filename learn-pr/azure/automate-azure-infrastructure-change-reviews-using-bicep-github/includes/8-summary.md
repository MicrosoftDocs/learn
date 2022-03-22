You needed to introduce automated checks to review your team's Bicep changes before they're merged to the main branch of your GitHub repository. In this module, you learned how to add GitHub Actions workflows that are triggered automatically when pull requests are created, synchronized, and closed. You also learned how to make these status checks mandatory by using branch protection rules, to ensure that nobody merges changes into the main branch until the automated checks succeed. Your website needed to be updated to use the Linux operating system, and you used status checks to validate and verify your pull request's changes.

Then, you learned how to create ephemeral environments, which give you the opportunity to review what will be deployed when the changes in a pull request are merged. Ephemeral environments enable contributors to experiment, and to iterate on their changes while seeing a live preview of their work in Azure, without affecting any of your production or non-production environments. When you changed your website to use a container image, you could easily see how the website works with the new configuration while you were still preparing and reviewing your code changes. You also learned how to automatically remove the resources used by your ephemeral environments after a pull request is closed.

Now, you have even more confidence in your Bicep code, and in the Azure infrastructure changes that are merged into your repository's main branch.

## Learn more

- [Microsoft Learn module on environments and reusable workflows](/learn/modules/manage-multiple-environments-using-bicep-github-actions/3-handle-similarities-between-environments-using-reusable-workflows)
- [Microsoft Learn module on branch protection](/learn/modules/review-azure-infrastructure-changes-using-bicep-pull-requests/2-understand-branching)
- [What is the Azure Dev/Test offer?](/azure/devtest/offer/overview-what-is-devtest-offer-visual-studio)
- [Pull request triggers](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows#pull_request)
- [Azure Cost Management budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets)
