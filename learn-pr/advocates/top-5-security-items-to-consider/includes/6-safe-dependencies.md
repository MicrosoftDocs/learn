A large percentage of code present in modern applications is made up of the libraries and dependencies chosen by you: the developer. This is a common practice that saves time and money. However, the downside is that you are now responsible for this code, even though others wrote it, because you used it in your project. If a researcher (or worse, a hacker) discovers a vulnerability in one of these third-party libraries, then the same flaw will likely also be present in your app.

Using components with known vulnerabilities is a huge problem in our industry. It is so problematic that it has made the [OWASP top 10 list](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project) of worst web application vulnerabilities, holding at #9 for several years.

## Track known security vulnerabilities

The problem we have is knowing when an issue is discovered. Keeping our libraries and dependencies updated (#4 in our list!) will of course help, but it's a good idea to keep track of identified vulnerabilities that might impact your application.

> [!IMPORTANT]
> When a system has a known vulnerability, it is much more likely also to have exploits available, code that people can use to attack those systems. If an exploit is made public, it is crucial that any affected systems are updated immediately.

**Mitre** is a non-profit organization that maintains the [Common Vulnerabilities and Exposures list](https://cve.mitre.org). This list is a publicly searchable set of known cybersecurity vulnerabilities in apps, libraries, and frameworks. **If you find a library or component in the CVE database, it has known vulnerabilities**.

Issues are submitted by the security community when a security flaw is found in a product or component. Each published issue is assigned an ID and contains the date discovered, a description of the vulnerability, and references to published workarounds or vendor statements about the issue.

### How to verify if you have known vulnerabilities in your third-party components

You could put a daily task into your phone to check this list, but luckily for us, many tools exist to allow us to verify if our dependencies are vulnerable. You can run these tools against your codebase, or better yet, add them to your CI/CD pipeline to automatically check for issues as part of the development process.

- [OWASP Dependency Check](https://www.owasp.org/index.php/OWASP_Dependency_Check), which has a [Jenkins plugin](https://wiki.jenkins.io/display/JENKINS/OWASP+Dependency-Check+Plugin)
- [OWASP SonarQube](https://github.com/OWASP/sonarqube)
- [Snyk](https://snyk.io), which is free for open-source repositories in GitHub
- [Black Duck](https://www.blackducksoftware.com) which is used by many enterprises
- [RubySec](https://github.com/rubysec/rubysec.com) an advisory database just for Ruby
- [Retire.js](https://github.com/retirejs/retire.js/) a tool for verifying if your JavaScript libraries are out of date; can be used as a plugin for various tools, including [Burp Suite](https://www.portswigger.net)

Some tools made specifically for static code analysis can be used for this as well.

- [Roslyn Security Guard](https://dotnet-security-guard.github.io)
- [Puma Scan](https://pumascan.com)
- [PT Application Inspector](https://www.ptsecurity.com/ww-en/products/ai/)
- [Apache Maven Dependency Plugin](https://maven.apache.org/plugins/maven-dependency-plugin/)
- [Source Clear](https://www.sourceclear.com)
- [Sonatype](https://ossindex.sonatype.org)
- [Node Security Platform](https://nodesecurity.io)
- [WhiteSource](https://www.whitesourcesoftware.com/what-is-whitesource/)
- [Hdiv](https://hdivsecurity.com)
- [And many more...](https://www.owasp.org/index.php/Source_Code_Analysis_Tools)

For more information on the risks involved in using vulnerable components visit the [OWASP page](https://owasp.org/www-project-top-ten/OWASP_Top_Ten_2017/Top_10-2017_A9-Using_Components_with_Known_Vulnerabilities) dedicated to this topic.

## Summary

When you use libraries or other third-party components as part of your application, you are also taking on any risks they may have. The best way to reduce this risk is to ensure that you are only using components that have no known vulnerabilities associated with them.
