In this module, you helped the team to shift left to search for code vulnerabilities and technical debt. They can now find problems early in the development process, which makes it easier to write code that's secure and maintainable. Because the scans are a part of the automated pipeline, they know the results are current. Not only that, but Tim now has an easy way to understand the state of the code for security and quality. 

What happens if you find a vulnerability? You need to investigate it to determine if it's a security issue and a real threat. Some vulnerabilities are reported because one of your dependencies is out of date. This may or may not be a security issue. Address possible vulnerabilities on a case-by-case basis.

Let's check in with the team.

**Tim:** I like what we've done here, but now that we know what the issues are, what do I tell leadership about fixing them?

**Amita:** Right! Do we need to fix all of these issues right away?

**Andy:** Yes, there are some issues to fix. But at least now we know where the issues are. We can discuss and prioritize fixing them based on their severity. We can even start with a few easy ones just to get a feel for the process.

**Mara:** We may never get a completely clean report given that the community will always have new recommendations and some issues are low severity. But getting a handle on things will go a long way to managing our technical debt.

**Tim:** It's great that we're able to identify and fix issues so early in the process. I don't know how I would have found this information on my production systems. I'll take this report to our security consultant. Perhaps we can all work together to identify and fix the most important issues.

Mara smiles. She feels like her efforts around DevOps are starting to pay off.

If you build .NET applications, as an optional exercise you can practice fixing one or more of the errors SonarCloud reported. You can apply the same ideas to your own projects.

A relatively easy bug to fix relates to replacing the bold `<b>` tag with the `<strong>` tag, as you saw earlier.

![Bug details on SonarCloud](../media/3-sonar-scan-bug.png)

See if you can locate this issue in the source code based on the report. After you fix the issue and commit the change to the `master` branch on GitHub, you see the issue disappear the next time the scanner runs.

## Learn more

Thinking about security is part of every phase of your development lifecycle. Microsoft provides a place to go to learn more about security and privacy in all phases of development. We recommend that you check out [Microsoft Security Development Lifecycle](https://www.microsoft.com/securityengineering/sdl/?azure-portal=true).

In this module, you learned about some of the tools and processes you can use to analyze your code. Here's where you can learn more:

* [OWASP](http://www.owasp.org?azure-portal=true)
* [Roslyn analyzers](https://docs.microsoft.com/visualstudio/code-quality/roslyn-analyzers-overview?view=vs-2017#roslyn-analyzers-vs-static-code-analysis&azure-portal=true)
* [Common Weakness Enumeration](https://cwe.mitre.org/index.html?azure-portal=true) (CWE)
* [Common Vulnerabilities and Exposures](https://cve.mitre.org/cve/?azure-portal=true) (CVE)
* [Microsoft Security Development Lifecycle](https://www.microsoft.com/securityengineering/sdl/?azure-portal=true)

Here are some resources that relate to Azure Pipelines features you used in this module:

* [Specify conditions](https://docs.microsoft.com/azure/devops/pipelines/process/conditions?view=azure-devops&tabs=yaml&azure-portal=true) in Azure Pipelines
* [Secret variables](https://docs.microsoft.com/azure/devops/pipelines/process/variables?view=azure-devops&tabs=yaml%2Cbatch#secret-variables&azure-portal=true) in Azure Pipelines