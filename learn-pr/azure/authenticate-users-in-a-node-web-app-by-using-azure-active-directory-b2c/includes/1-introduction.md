
Use Azure Active Directory B2C (Azure AD B2C) to authenticate users into your web application. Azure AD B2C is a scalable customer identiy service, which enables your customers to use their preferred social, enterprise, or local account identities to get single sign-on access to your applications. It takes care of the scaling and safety of the authentication platform, monitoring, and automatically handling threats like denial-of-service, password spray, or brute force attacks.

## Example scenario

Suppose you're the solution architect for an eCommerce organization. Your organization is launching a new Node web app, which enables customers to order groceries online. Your organization requires that the web app authenticates customers for them to make an order, so they can sign up or sign in to the web app using their email or a social account. Because of customer data sensitivity and authentication scaling complexities, your organization doesn't want to manage customer identities from within the Node web app. So, your organization wants to use Azure AD B2C as an identity provider because you can customize the entire user experience with your brand. You want to start by authenticating users to the Node web app by using Azure AD B2C.

<!--TODO: add a visual element-->

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do in this content. This differs from the title and the learning objectives. The title and the learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: "## What will we be doing?"

    Example: "Here, you'll create a business workflow using Azure Logic Apps to automate the processing of tweets:
                * **Launch**: when a new tweet is available
                * **Process**: determine if the sentiment of the tweet is positive or negative
                * **Route**: branch based on the sentiment score"

 -->
## What will we be doing?

In this module you'll:

* Register a web application in Azure AD B2C tenant.

* Create a sign up and sign in user flow and configure an identity provider.

* Create a Node web application.

* Configure  the Node web app to authenticate user by using Azure AD B2C.

* Run and test the Node web application to ensure that user authentication is successful.

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: This is a restatement of the module title into a complete sentence. You have more room here to convey the main goal than in a space-limited title. Make it outcome-focused so it describes the main skill the learner will acquire as a result of this training. In other words, it should answer the question: "what is the key thing the learner will be able to do as a result of consuming this training?"

    Heading: "## What is the main goal?"

    Example: "By the end of this session, you'll be able to create workflows which route and process data using Azure Logic Apps and its built-in connectors."

 -->
## What is the main goal?

By the end of this session, you'll be able to create a Node web application and configure it to authenticate users by using Azure AD B2C.

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->