An app that uses the power of cloud-based services, should be able to recover from transient errors. These errors can be network-related, or service-related, but they're all temporary and in time they resolve themselves.

Your company has been developing on-premises desktop applications. The company recently experienced a serious data incident, where a large amount of data was lost. The CTO has been asked to improve the company's entire suite of apps to use microservices and cloud-based data storage. Your team leader has put you in charge of making sure your apps are resilient to transient errors from these services. Your team leader has given you time to examine your team's in-house chat app and see how transient errors affect it.

Discussing the chat app design with your manager, you both agree that a good starting point is to identify all the places the code currently handles transient errors. You plan to group these different approaches into categories, and define a common set of strategies that can be applied across all the companies applications. The existing chat app should be enhanced if it's missing any error handling.

## Learning objectives

In this module, you'll:

- Identify common strategies for handling transient errors.
- Detect transient errors in code.
- Implement a retry policy in your app.
- Monitor transient errors in your app using logging.

## Prerequisites

- Beginner developer knowledge of either C#, Java, or Node.js.