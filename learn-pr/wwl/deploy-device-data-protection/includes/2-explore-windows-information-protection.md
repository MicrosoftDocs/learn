
In modern enterprises, the increase in collaboration between both internal and external users and the proliferation of employee-owned devices, known as BYOD, has increased the risk of accidental or malicious data leakage. This risk has grown with the expanded use of mobile apps, cloud-based services, and social media.

Traditionally, enterprises have controlled access to data by assigning credentials to users and configuring permissions and access lists on resources. However, user access control doesn't prevent authorized users from accidentally sharing files or sending data in emails, leading to new protection systems. Also, most technologies based on authentication/authorization for protection are location-dependent, meaning they usually work only while data is in a company-controlled environment.

#### Data loss prevention

Organizations use data loss prevention (DLP) systems to overcome the limitations of systems that are based on authentication and authorization. A DLP system automatically detects and controls data that should be protected and provides a way to protect data despite the location. A DLP system requires:

 -  Rules that identify and categorize data that needs protection.
 -  Software applications such as Microsoft Exchange or Microsoft SharePoint to scan data to see if it matches rules.
 -  A way to define what actions applications must carry out when they find data that matches a rule.

The challenge of a DLP system is that the more rules you create, the more likely workers will feel the system is preventing them from getting work done, and they'll find ways to bypass the system. For example, they might share data by emailing links to an unprotected system instead of attaching files to an email system that contains DLP protection. Despite improvements to DLP in Microsoft SharePoint Online and Microsoft Exchange Online, such as allowing users to override the rules, the experience can be jarring to users and interrupt their natural workflow.

#### Information Rights Management

As we said before, enterprises need to protect data after it leaves the company. To meet this need, systems based on Information Rights Management (IRM) are used to make protection an inherent part of documents. An employee can create a document and then determine the level of protection that should apply to the document, such as preventing unauthorized users from opening the document. In some scenarios, protection can also be applied automatically, based on conditions that the administrator defines.

IRM systems require setting up both client and server environments. The client app that opens a document is responsible for processing protection rules after checking with the server component of the system to check for authorization updates.

Neither IRM nor DLP is sufficient in the scenario where an employee leaves the organization with a personal device or simply decides that they no longer want to allow the organization to manage the personal device. The best-case option, in this case, is to delete organizational data from the personal device. Protection systems implemented in Microsoft 365 platform, allows you to do this. These systems allow you to create rules based on which apps can access organizational data. It also allows you to decide which data those apps can access.

Azure Rights Management (Azure RMS) extends protection for data beyond a user’s device through an IRM system that integrates with WIP, a key part of Azure Information Protection. Intune allows control over user actions with protected data, even outside the organizational environment.

Additionally, apps that can tell the difference between organizational or personal data, known as enlightened apps, allow you to apply WIP rules on organization-owned data only, while leaving personal data intact. This means, for example, that an employee can safely use Microsoft Word on a personal device for both business and personal documents, without fear of losing their personal data when they leave the organization.
