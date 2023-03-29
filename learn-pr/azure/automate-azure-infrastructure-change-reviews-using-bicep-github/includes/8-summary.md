It's a good idea to introduce automated checks to review your team's Bicep changes before they're merged to the main branch of your GitHub repository.

In this module, you learned how to add GitHub Actions workflows that are triggered automatically when pull requests are created, updated, and closed.

You also learned how to make your pull request validations checks mandatory by using branch protection rules, a practice that prevents reviewers and others from merging code changes into the main branch until all automated checks are successful. For example, your website needed to be updated to use the Linux operating system, and you were able to use status checks to validate and verify your pull request changes.

You then learned how to create ephemeral environments, which give you the opportunity to review what will be deployed when your pull request changes are merged. By using ephemeral environments, you can experiment and iterate on your code changes without affecting any of your production or non-production environments. When you changed your website to use a container image, you could easily see how the website would work with the new configuration while you were still preparing and reviewing your code changes.

You also learned how to automatically remove the resources used by your ephemeral environments after a pull request is merged and closed.

You should now have even more confidence in both your Bicep code and the Azure infrastructure changes that are merged into your repository's main branch.

## Learn more

- [GitHub Actions pull request trigger](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows#pull_request)
- [What is the Azure Dev/Test offer?](/azure/devtest/offer/overview-what-is-devtest-offer-visual-studio)
- [Microsoft Cost Management budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets)
