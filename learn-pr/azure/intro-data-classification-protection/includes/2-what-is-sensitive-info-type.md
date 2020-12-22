---
typora-copy-images-to: ./
---

In a perfect world, all your employees understand the importance of information protection and work within your policies. In the real world, it's likely that a busy partner who frequently works with accounting information will inadvertently upload a sensitive document to some cloud repository with incorrect permissions. A week later you realize your enterprise's confidential information was leaked to your competition.

## What is sensitive data?

Before we start learning on how to protect data, we need to identify the data that needs protection. It is very important to understand that not all data need protection, and not all data need the same level of protection. For example, you might need to have very strong protection over your financial data, but at the same time you might not need any protection for some marketing materials. Also, you might need to protect personal data so that only you can access it, while financial data, although very important, might need to be protected in a way that few authorized people can access it.

Having said this, we need to define sensitive data. Although the specific definition of sensitive data might differ for different scenarios, we can generally say that sensitive data is information that needs to be protected from unauthorized access. We usually achieve that protection by implementing appropriate data security and information protection technologies. In some cases, such as when sensitive data are in paper form, you might need physical security also. All technologies and methods for sensitive data protection are used to prevent unauthorized access or data leakage.

Reasons to protect sensitive data can include:

- Personal privacy
- Regulatory requirements
- Intellectual property
- Ethical or legal requirements

For example, from the aspect of GDPR, which primarily protects personal data, following personal data is considered sensitive:

- personal data revealing racial or ethnic origin, political opinions, religious or philosophical beliefs;
- trade-union membership;
- genetic data, biometric data processed solely to identify a human being;
- health-related data;
- data concerning a person’s sex life or sexual orientation.

## How to discover and protect sensitive data?

If you are implementing sensitive data protection in your organization, you need to implement several steps on that path. It is not enough just to choose a technology to protect data. If you don't properly identify sensitive data, protection technology will not help much. Also, if you don't have a consistent processes of classifying data (both sensitive and non-sensitive) you will not be able to efficiently implement protection technology. At the end , but not less important, if you don't monitor your sensitive data through its lifecycle, protection will not be efficient as you will not know if it really works properly. 

Data location is also very important. Today, data can be located everywhere - on mobile devices, on cloud storage services and on your local file server infrastructure. You need to consider all possible locations where sensitive data might reside, as well as network paths which it may transit.

Microsoft's approach to sensitive data protection can be split into the four phases that allow you to protect your data through its full lifecycle, across multiple locations and devices. These phases are:

- Discover your data
- Classify sensitive information
- Protect your data
- Monitor and report on your data

![tutorial-dlp-solution](C:\Users\ddami\OneDrive\Desktop\Azure data residency\Development\M2\tutorial-dlp-solution.png)



When using this approach, you can be sure that all your sensitive data will be discovered, classified, protected and monitored. Later in this module and this course, you will learn about specific technologies that can help you to define and discover sensitive data for your specific scenario, protect the data and monitor data usage.