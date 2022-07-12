You can verify your code used by Azure Machine Learning to train models automatically with GitHub Actions.

Whenever you create your own machine learning models, you're likely to work with scripts to automate machine learning tasks. 

You may want the scripts to adhere to your organization's quality standards. By enforcing programmatic or stylistic guidelines for your code, it's easier for data scientists to read each other's scripts.

Before moving code to production, you'll also want to check the performance of the scripts to ensure they work as expected. 

Only when you've verified the code quality do you want to use the code in production. You can use GitHub Actions to automatically check the code whenever a pull request is created. 

## Learning objectives

In this module, you'll learn how to:

- Run linters and unit tests with GitHub Actions.
- Integrate code checks with pull requests.
- Troubleshoot errors to improve your code.