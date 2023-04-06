Publishing an application programming interface (API) is a great way to increase market share, generate revenue, and foster innovation. However, maintaining even one API brings significant challenges such as:

- Onboarding users
- Managing revisions
- Implementing security
- Running analytics

Now imagine that like many of today's leading companies, your organization publishes multiple APIs for different types of users including partners, developers, and employees. These APIs are used in multiple settings, including mobile and web apps, and Internet of Things (IoT) devices.

:::image type="content" source="../media/1-introduction-before.png" alt-text="Multiple APIs connect to multiple servers, where each API maintains its own set of users, security policies, and analytics data." lightbox="../media/1-introduction-before.png":::

How do you reduce the complexity inherent in having numerous APIs? Microsoft Azure API Management acts as a "front door" for all your APIs. Azure API Management manages all your API traffic and offers intuitive portals for managing your APIs and surfacing them to developers. It also provides tools for implementing security, managing revisions, and performing analytics.

:::image type="content" source="../media/1-introduction-after.png" alt-text="Azure API Management acts as a 'front door' for all of an organization's APIs. API calls are then routed to the server where the API is deployed." lightbox="../media/1-introduction-after.png":::

## Example scenario

Suppose you work at a company that operates a food-delivery platform. Your customers use your mobile app or website to browse the menus of multiple restaurants. They then place an order for the food they want, which your company delivers. The backbone of your platform is a large collection of APIs. For example, the APIs that you publish are used by:

- Your mobile app
- Your web app
- Your partner restaurants
- The IoT devices on your delivery vehicles
- Your in-house development team
- Your employees, such as business analysts

Each published API resides on a different server, has its own process for onboarding users, and has its own policies for security, revisions, analytics, and more. You've been tasked to find a way to reduce this complexity. Here you learn how Azure API Management can standardize, centralize, and help secure all the aspects of publishing and maintaining APIs across the full API lifecycle.

## What will we be doing?

Examining Azure API Management to help you decide if it's the correct solution to help reduce your company's API complexity. We'll study these three main components:

- **Gateway**. A single endpoint for all your API calls, which eases the implementation of security, rate limits, caching, and transformations.
- **Administration interface**. A single interface where you import APIs, set policies, create API products, manage users and groups, and run analytics.
- **Developer portal**. A website that brings all your APIs into a single location for developers to read documentation, test APIs, review code samples, get API keys, and run analytics.

We'll also study Azure API Management from the following three user angles:

- **API consumers**. Entities (such as applications) that get value from using an API.
- **API providers**. People who administer and maintain APIs.
- **App developers**. People who build applications that consume APIs.

## What is the main goal?

By the end of this session, you can evaluate whether Azure API Management is the correct solution for keeping your organization's APIs under a single management umbrella.
