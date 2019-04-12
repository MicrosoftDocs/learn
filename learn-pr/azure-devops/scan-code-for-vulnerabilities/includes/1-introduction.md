<!-- TODO: Change code coverage format in run-quality-tests to opencover. It's needed for this module. -->

<!-- DUMPING NOTES:

* 1-introduction
* 2-knowledge?
* 3-setup/add key
* 4-scan locally
    * Use dotnet tool
* 5-analyze the results
* 6-scan from pipeline
    * Marketplace ext.
    * Service connection
    * Build tasks
    * Run it.
* 7-Limit testing to PRs only
    * using triggers
* 8-summary

SonarCloud works with many kinds of languages such as Java, C#, C++, JavaScript, and more.

-->

Here we talk about securing the development process.

Perhaps the narrative goes like:

* A team member discovered that some sort of secret data (TBD which kind specifically) was included in the source code.
* The team decides it needs to make their development process more secure.

Resources:

- https://azure.microsoft.com/en-us/blog/managing-azure-secrets-on-github-repositories/
- https://secdevtools.azurewebsites.net/helpcredscan.html