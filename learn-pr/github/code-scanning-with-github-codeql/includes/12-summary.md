You're a senior developer responsible for implementing automated code-vulnerability scanning at your company. You need to understand how code scanning with CodeQL works and how to configure it so that you can help your entire organization adopt it.

You did some research on code scanning with CodeQL and found the following:

* Code scanning with CodeQL uses a workflow file that specifies the location of queries, which languages to analyze, and whether they should be built with autobuild, or manual build steps.
* GitHub supports integration of third party scanning and alerting tools in the code scanning process.
* CodeQL has a CLI that allows you to create and analyze databases offline and then upload the results to GitHub using a SARIF file.

Without using GitHub code scanning with CodeQL, it would be very difficult to automate both the scanning of your code, as well as generating pull requests to fix the vulnerable code. In addition, CodeQL provides an extensive, growing library of queries in multiple languages that help you create more secure code with little engineering effort.

Successfully rolling out automated code vulnerability scanning across your organization has made developers more productive and the product at your company more secure.

## References

* [GitHub CodeQL](https://codeql.github.com/)
* [GitHub code scanning](https://docs.github.com/en/code-security/code-scanning)
