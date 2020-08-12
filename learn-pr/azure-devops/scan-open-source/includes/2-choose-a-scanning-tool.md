In this section, you'll examine a few tools that scan for known vulnerabilities and for license ratings in the open-source components that your application uses.

Let's check in with the team at their weekly meeting and see how things are progressing.

## Weekly meeting

**Andy:** Tim, before we start, how did your meeting go with the security consultant?

**Tim:** I was nervous going into it, but it went really well considering the topic. What impressed him most was how easily we were able to produce such a thorough report. Although our source code is far from clean, we can identify potential security holes and prioritize the order in which we address them. Plus, we can identify issues before the code goes to QA or production.

**Mara:** That's great! So what's the plan?

**Tim:** That's what I wanted to talk about. One other issue came up, and that's around how we use open source. The security consultant found that other teams were using software that was licensed under GPL 3.0.

**Andy:** I've heard of GPL. That stands for General Public License. What's the issue?

**Tim:** Well, it turns out that if you modify certain open-source libraries, even if it's to fix a bug or make a minor enhancement, you might be required to make those changes publicly available. Those changes could include intellectual property we want to protect. There's this big conversation happening with our legal team to identify what's next. I'm worried that this might affect our team as well.

**Amita:** I wasn't aware that this project used much open-source software.

**Andy:** It's indeed surprising how much open-source we use. We use frameworks such as Bootstrap and jQuery to make it easier to work with JavaScript and CSS. In fact, some components include other components that we haven't checked for security vulnerabilities, or haven't checked how they're licensed. We'd better make sure of where we stand before we move forward.

**Amita:** Licenses can be hard to read and interpret. Do we need a lawyer to help?

**Tim:** The legal team wants to meet with us next week. But first they want us to investigate which open-source components we're using and how those components are licensed. Andy, Mara, you're the most familiar with how the code is structured. Would you mind doing some investigation for the team?

**Andy:** Sure, we got this. We'll take a look after this meeting and report back with what we find.

## How can I access security and license ratings in open-source software?

Andy and Mara return to their desks.

**Andy:** I was at a user conference a few months ago where they talked about licenses and security in open-source software. I can bring up the slides from the presentation. Maybe we can identify a tool or process we can use.

Andy and Mara review the slides and investigate further. They find a few options.

### Black Duck

[Black Duck](https://www.blackducksoftware.com?azure-portal=true) by Synopsys scans your open-source dependencies against their own database. They keep that database up-to-date with the latest vulnerabilities and give you timely information on fixes, workarounds, and on the exploits. They cover over 80 programming languages, and get their information from many sources.

### GitLab

[GitLab](https://about.gitlab.com?azure-portal=true) is a CI/CD pipeline tool that enables you to scan the dependencies in code that comes from GitLab repositories. It supports JavaScript, Ruby, Python, PHP, and Java. 

Their [Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=onlyutkarsh.gitlab-integration&azure-portal=true) enables you to add a GitLab repository as a source.

### Sonatype Nexus

[Sonatype Nexus](https://www.sonatype.com/nexus-repository-sonatype?azure-portal=true) scans your dependencies for known vulnerabilities, licenses, and old or unsupported components.

Their [Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=ms-vsts.nexus-build-extension&azure-portal=true) enables you to upload your artifacts to Sonatype Nexus for scanning.
  
### Veracode

[Veracode](https://www.veracode.com?azure-portal=true) is a code scanning tool that integrates with Azure Pipelines to help you find vulnerabilities early in the development process. 

Their [Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=Veracode.veracode-vsts-build-extension&azure-portal=true) stops the build process if there's a severe security risk and gives you guidance on finding and fixing the vulnerability.

### WhiteSource Bolt

[WhiteSource Bolt](https://bolt.whitesourcesoftware.com?azure-portal=true) is a tool for scanning open-source dependencies for vulnerabilities and licensing. It supports more than 200 programming languages and gives guidance on fixing the vulnerabilities. There are reports for vulnerabilities, licensing, and inventory. 

Their [Azure Pipelines extension](https://marketplace.visualstudio.com/items?itemName=whitesource.ws-bolt&azure-portal=true) allows for extensive policy configuration as well as viewing the results from the Azure Pipelines portal.

## Which option should I choose?

Andy and Mara are both in new territory. All the options have something to offer. They decide to start with WhiteSource Bolt, which looks like a good, general-purpose tool. When they have time, they might investigate some of the other tools they've learned about.

Which tool you pick will always come down to your requirements and which option provides the best insights into your use of open source.

