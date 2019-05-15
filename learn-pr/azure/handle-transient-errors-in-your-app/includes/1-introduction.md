When building an app that uses the power of cloud-based services, it should be able to recover from any transient errors. These errors can be network-related, or service-related, but they are all temporary and in time will resolve themselves.

Your company has been developing on-premise desktop applications. The company recently experienced a serious data incident, where a large amount of data was lost. The CTO has been asked to improve the company's entire suite of apps to use microservices and cloud-based data storage. Your team leader has put you in charge of making sure your apps are resilient to transient errors from these services. Your team leader has given you time to examine your team's in-house chat app and see how it is impacted by transient errors.

Discussing the chat app design with your manager, you both agree that a good starting point is to identify all the places the code currently handles transient errors. You'll group these different approaches into categories, and define a common set of strategies that can be applied across all the companies applications. The existing chat app should be enhanced if it's missing any error handling.

## Learning objectives

In this module, you will:

- Identify common strategies for handling transient errors
- Detect transient errors in code
- Implement a retry policy in your app
- Monitor transient errors in your app using logging

## Prerequisites

- Beginner developer knowledge of either C#, Java, or Node.js