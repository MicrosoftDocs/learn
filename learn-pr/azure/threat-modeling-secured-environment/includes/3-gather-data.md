To help you navigate the threat modeling process for an application to be used in a secured environment, we created a fictitious company, called Woodgrove Bank.

## Company background

Established in 2018, Woodgrove Bank is an online banking provider that gives customers the ability to conduct financial transactions and bill payments online. 

With no physical locations, Woodgrove relies on an online portal and cross-platform applications for their daily operations.

Customers can choose from free online transfers, high-interest yield savings accounts, and bill payment services. 

Transactions are secured using best-in-class encryption, and customer service is available 24 hours a day, 7 days a week. 

With transparent fees, real-time status updates, and money back guarantee, Woodgrove has what it takes to gain your business.

Woodgrove Bank rolled out alternate identities and PAWs for the two IT administrators to work on their critical assets securely.

## Application background

Fourth Coffee is a standalone, free, and open-source password management client application used to store production resource credentials.

It serves as a local fallback to Azure Key Vault.

The IT admins would like to make sure there are no security issues before installing the application in the secured environment.

## Your task

You were recently brought in by Woodgrove Bank's senior leadership team to:

1. Identify security risks of applications to be used in the secured environment, and
2. Find ways to reduce or eliminate risk.

After talking to the IT admins and researching the application, here's what you found out:

## Meeting notes

|Category|Answers|
|--------|-------|
|![Functionality category.](../media/supporting-icons/functionality-small.png)</br>Functionality|<ul><li>Users can either download the executable online or use the source code to build an installer.</li><li>If needed, the IT admins can easily make changes to a forked copy.</li><li>The IT admins will use the application to store, generate, and manage the credentials for Woodgrove's servers, virtual machines, and online services.</li><li>The application was written by a group of PhD students and became popular in the developer community in recent years.</li><li>Source code is available on GitHub.</li><li>The last contribution from the developer community was about a year ago.</li><li>There are no reports of public vulnerabilities or security scanner results.</li><li>The IT admins plan to use a previous version, which has a simpler interface and limited cloud integration.</li><li>The application doesn't integrate with other services, like web browser plugins and extensions in productivity applications.</li><li>Backup, logging, and monitoring systems don't exist.</li><li>Admin level privileges are not required for basic functions.</li><li>2FA is available but not enforced.</li><li>Authentication happens locally with a username and password combination.</li><li>The password requires at least 16 characters or digits.</li><li>The password requirement allows patterns and previously used passwords.</li><li>There is no password change policy.</li><li>Password file is encrypted using strong encryption.</li><li>There are no regulatory or legal issues with Fourth Coffee.</li><li>No incident response program was found.</li><li>Fourth Coffee does not have a set of security policies or risk program.</li>|
|![Integration category.](../media/supporting-icons/integration-small.png)</br>Integration|<ul><li>There is no evidence the application went through the SDL.</li><li>The application doesn't have open CVEs, critical security issues, or security breaches in the last year</li><li>Data is encrypted at-rest using AES-KDF.</li><li>The data lives in a database file containing all the credentials.</li><li>The database file is stored locally, and can only be opened with the application and the main password.</li><li>There isn't a cloud provider associated with the application.</li><li>The application doesn't have network requirements.</li><li>The database file path cannot be changed by anyone.</li></ul>|