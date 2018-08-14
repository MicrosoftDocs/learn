## 1. Design consideration
<<max_attempts:1; weight:1.0>>

>> In your distributed application you have a web service that authenticates users. When a user logs on, the web service must communicate with a desktop application that runs on all users' computers to display the status of that user as "Online". True or false: This is an example of a message in a distributed application.<<

() True
(x) False

This is an example of an event in a distributed application. The communication informs the desktop application that the user's status has changed, but does not include the data that initiated the communication. For example, the user's credentials are not included.

---
