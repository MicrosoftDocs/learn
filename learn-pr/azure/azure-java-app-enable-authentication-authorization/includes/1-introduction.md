<!-- Introductory text here: motivational scenario and lead-in. See https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master 

For guidance on writing a scenario, see https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-scenarios?branch=master

-->

<!--

Guidance for all content:

 - Ignore the linter warning about how the first line of a unit should be a header. The platform renders the unit title as an H1 at the top. All headers used in content should be H2 or smaller.
 - Links to other content (in Learn, Docs or anywhere else), put them in a section in the final Summary unit called "Learn more" or "Further reading" or something similar. If you need to mention the external resources in the content, indicate to the user that links are located at the end of the module.
- All content, including images, must be original and not copied from Docs or anywhere else.
- Screenshots: see https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master for requirements and guidance.
- Conceptual images and diagrams: Don't spend lots of time creating polished diagrams. Work with the Learn team to submit a conceptual image creation request if new art is needed.
- Video: Work with your contact on the Learn team.
- Zone pivots: See https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-add-zone-pivots?branch=master
- Think carefully about the knowledge prerequisites you declare for your content, and use them to shape the content and keep the scope reasonable. In both conceptual content and exercise steps, don't dwell on things you expect the reader to already know and understand.
- Feel free to use HTML comments like these during authoring. They show up in published content as HTML comments - the platform doesn't render them on the page, but they are present in the pae source, so remove them all before publishing.

Guidance for content and exercise units:

- Most standard content should generally follow a pattern of alternating between "content" units and "exercise" units. See https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-standardmodules?branch=master
- Don't include a summary section in individual units
- Don't include a sentence or section to transition to the next unit. The platform will insert the name of the next unit above the navigation button at the bottom

-->

Organizations build applications to serve various usecases. While most of the application developers are focused on implementing the business logic, there are also requirements to secure the access to the application. The responsibility of identity and access management requires additional expertise and comes with complexity.

Azure Active Directory and the Microsoft Authentication Library (MSAL) simplify this. Azure Active Directory enables you to handle these requirements by providing identity and access management (IAM) as a service. The Microsoft Authentication Library provides convenient APIs for developers to implement the authentication and authorization features in their applications.

## Example scenario

Imagine you are building a portal for employees in your company to access company information and helpful resources to perform their work. You need to ensure that this application is only accessible to users within your organization. You want to build a Java web application that signs in the employees with their work accounts and displays some information from their company profile.

Azure Active Directory enables you to secure your applications by signing in users with their organizational accounts. The Microsoft Authentication Library (MSAL) provides various methods for developers to authenticate users and get authorized access to applications secured by Azure Active Directory.

## What will we be doing?

By the end of this module, you'll be able to:

<!--  Bullet list copied from index.yml -->
- Register a web application with Azure Active Directory
- Sign in users in an Azure Active Directory tenant to a Java web application
- Authorize access to data in a Microsoft API.

## What is the main goal?

The main goal is to learn how to secure your application with Azure Active Directory and use the Microsoft Authentication Library to sign in users and get authorized access to data in a Java web application.
