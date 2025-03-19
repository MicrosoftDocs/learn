In this module, we learned:

* Code scanning with CodeQL can be customized using the advanced setup workflow file that specifies the location of queries, which languages to analyze, and whether they should be built with autobuild, or manual build steps.
* GitHub supports integration of third party scanning and alerting tools in the code scanning process.
* CodeQL has a CLI that allows you to create and analyze databases offline and then upload the results to GitHub using a SARIF file.

Without using GitHub code scanning with CodeQL, it would be difficult to automate both the scanning of your code, and generating pull requests to fix the vulnerable code. In addition, CodeQL provides an extensive, growing library of queries in multiple languages that help you create more secure code with little engineering effort.

## References

* [GitHub CodeQL](https://codeql.github.com/)
* [GitHub code scanning](https://docs.github.com/en/code-security/code-scanning)

### Resource Links

1. [Publishing and using CodeQL packs](https://docs.github.com/en/code-security/codeql-cli/using-the-advanced-functionality-of-the-codeql-cli/publishing-and-using-codeql-packs)
2. [Using code scanning with your existing CI system](https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/using-code-scanning-with-your-existing-ci-system)
3. [jhutchings1/Create-ActionsPRs](https://github.com/jhutchings1/Create-ActionsPRs)
4. [nickliffen/ghas-enablement](https://github.com/NickLiffen/ghas-enablement)
5. [Creating CodeQL query suites](https://codeql.github.com/docs/codeql-cli/creating-codeql-query-suites/)
6. [Validating SARIF files](https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/sarif-support-for-code-scanning#validating-your-sarif-file)
7. [CodeQL supported languages](https://codeql.github.com/docs/codeql-overview/supported-languages-and-frameworks/)
