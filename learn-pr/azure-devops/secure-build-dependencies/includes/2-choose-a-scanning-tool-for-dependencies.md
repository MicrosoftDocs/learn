In this part, you'll examine a few tools that can scan for known vulnerabilities and for licence ratings in the open source components your application uses.

Recall that in [Scan code for vulnerabilities in your build pipeline](/learn/modules/scan-code-for-vulnerabilities?azure-portal=true), Tim from the Tailspin web team needed to provide a report to his security consultant that shows what security vulnerabilities were in their code and the potential impact of those vulnerabilities. The team used SonarCloud to perform the scan, which provided Tim with the report he needed.

Let's check in with the team at their weekly meeting and see how things are progressing.

**Andy**: Tim, before we start, how did your meeting go with the security consultant?

**Tim**: I was nervous going into it, but it went really well considering the topic. What impressed him most was how easily we were able to produce such a thorough report. Although our source code is far from clean, we can identify potential security holes and prioritize the order we address them. Plus, we can identify issues ahead of anything going into QA or production.

**Mara**: That's great! So what's the plan?

**Tim**: That's what I wanted to talk about. One other issue came up, and that's around how we use open source. The security consultant found that other teams were using software licensed under GPL 3.0.

**Andy**: I've heard of GPL. That stands for GNU General Public License. What's the issue?

**Tim**: Well, it turns out that if you modify certain open source libraries, even if it's to fix a bug or make a minor enhancement, you may be required to make those changes publicly available. Those changes could include intellectual property we want to protect. There's this big conversation happening with our legal team to identify what's next. I'm worried this might affect our team as well.

**Amita**: I wasn't aware this project used much open source software.

**Andy**: That's correct. Right now, we're not using much. But some components might include other components that we haven't checked for security vulnerabilities or how they're licensed. We'd better be sure here before we move forward.

**Amita**: Licenses can be hard to read and interpret. Do we need a lawyer to help?

**Tim**: The legal team wants to meet with us next week. But first they want us to investigate what open source components we're using and how those components are licensed. Andy, Mara, you're most familiar with how the code is structured. Would you mind doing some investigation for the team?

**Andy**: Sure, we got this. We'll take a look after this meeting and report back with what we find.

## How can I access security and license ratings in open source software?

Andy and Mara return to their desks.

**Andy**: I was at this user conference a few months ago where they talked about licenses and security in open source software. I can bring up the slides from the presentation. Maybe we can identify a tool or process we can use.

Andy and Mara review the slides and investigate further. Here are a few options they found.

:::row:::
  :::column span="1":::
[Black Duck](https://www.blackducksoftware.com?azure-portal=true)
  :::column-end:::
  :::column:::
**Black Duck** by Synopsys scans your open source dependencies against their own database. They keep that database up to date with the latest vulnerabilities and give you timely information on fixes, workarounds, and the exploit itself. They cover over 80 programming languages, and get their information from many sources. Their [Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=black-duck-software.detect-for-tfs&azure-portal=true) enables you to set policies that affect the build and send alerts.
  :::column-end:::
:::row-end:::

:::row:::
  :::column span="1":::
[GitLab](https://about.gitlab.com?azure-portal=true)
  :::column-end:::
  :::column:::
**GitLab** is a CI/CD pipeline tool that enables you to scan the dependencies in your code from GitLab repositories. It supports Javascript, Ruby, Python, PHP, and Java. Their [Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=onlyutkarsh.gitlab-integration&azure-portal=true) enables you to add a GitLab repository as a source.
  :::column-end:::
:::row-end:::

:::row:::
  :::column span="1":::
[Sonatype Nexus](https://www.sonatype.com/nexus-repository-sonatype?azure-portal=true)
  :::column-end:::
  :::column:::
**Sonatype Nexus** scans your dependencies for known vulnerabilities, licenses, and old or unsupported components.
Their [Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=ms-vsts.nexus-build-extension&azure-portal=true) enables you to upload your artifacts to Sonatype Nexus for scanning.
  :::column-end:::
:::row-end:::

:::row:::
  :::column span="1":::
[Veracode](https://www.veracode.com?azure-portal=true)
  :::column-end:::
  :::column:::
**Veracode** is a code scanning tool that integrates with Azure Pipelines to help you find vulnerabilities early in the development process. Their [Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=Veracode.veracode-vsts-build-extension&azure-portal=true) stops the build process if there is a severity security risk and gives you guidance on finding and fixing the vulnerability.
  :::column-end:::
:::row-end:::

:::row:::
  :::column span="1":::
[WhiteSource Bolt](https://bolt.whitesourcesoftware.com?azure-portal=true)
  :::column-end:::
  :::column:::
**WhiteSource Bolt** is a tool for scanning open source dependencies for vulnerabilities and licencing. It supports over 200 programming languages and gives guidance on fixing the vulnerabilities. There are reports for vulnerabilities, licensing, and inventory. Their [Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=whitesource.ws-bolt&azure-portal=true) allows for extensive policy configuration as well as viewing the results from the Azure Pipelines portal.
  :::column-end:::
:::row-end:::

**Mara:** I see **CVE** and **CWE** and other categories and lists that these tools use to report vulnerabilities and weaknesses. I know we talked about these, but can you remind me what they mean?

**Andy:** CVE stands for Common Vulnerabilities and Exposures. CWE stands for Common Weakness Enumeration. While the CWE defines security vulnerabilities in the general sense, the CVE focuses on specific instances in software that's generally available, like a web browser or database.

**Mara:** That makes sense. What is **CVSS**?

**Andy:** CVSS stands for Common Vulnerability
Scoring System. That's the scoring system for the vulnerabilities. Components receive a score from 0&mdash;10 to help us see at a glance how severe a vulnerability is.

## Which option should I choose?

The choice comes down to your requirements and which option provides the best insights into your usage of open source.

You can integrate any of these options with Azure Pipelines. Many of these options provide Marketplace extensions that provide predefined task types that are ready to use in Azure Pipelines.

Andy and Mara decide to try a few options. In the parts that follow, you'll follow how they use WhiteSource Bolt to access package security and license ratings for open source components used in the _Space Game_ web application.