The system administrators want apps to include some form of logging to help manage application performance in production. Monitoring of these logs can be automated and help your company identify any health issues across its suite of apps.

Logging isn't only useful when an app is in production. It can also be used to help throughout development. Most languages, especially C# and Java, have well-defined severity levels for logging. There have also been attempts to standardize logging from organizations like Apache, who have external libraries **log4net** and **Log4j**.

### Logging Levels
There's a common set of logging levels that languages implement to some degree. Grouping the levels together they are:

- **Trace** or **finest**: This level represents the lowest level of information, used when troubleshooting issues with an application. This level shouldn't be used in production as personal information could be included in the output.
- **Debug**: This level is typically used during active development. These log messages don't have long-term value and don't need to be kept after development.
- **Information**: Can be included to show the health of an app.
- **Warning**: These messages are used to show abnormal and unexpected flows in an app. The execution of the app continues.
- **Error** or **critical**: If an app needs to quit, or restart, because of a failure,  it should write this information to a log. Serious errors that need immediate attention should be raised as **critical**.

Because of the nature of transient errors, the application should log transient error messages at the **warning** level. This level can be monitored, and if the errors keep on happening the team can investigate further.

### Logging information

A good set of questions to ask yourself when writing a log message is who, what, why, where, and when. All these questions, if answered, should help investigate and resolve errors.

- Who was using the app? The error could be related to corrupted user data, so only a few people are seeing it.
- What was the app doing? Help people investigating the error narrow down the search to the state the app is in when it happened.
- Why has an error happened? Log any error codes or other information that can aid in diagnosis.
- Where in the code did the error happen? Related to what was happening, location in the codebase can help in narrowing the investigation of the problem.
- When did it happen? Time-related information can be correlated with information about when other services were down.

Good logging has a defined structure. The structure can allow for future indexing and logistics. For transient errors there are two other useful pieces of information:

- Time to recover from the error
- Number of retries before the issue was resolved

Capturing this information for transient errors can indicate patterns that are happening. Is the error always resolved after the first retry? Is there a timing issue, and the error is resolved after 1 minute? The solution could be to add a wait period to help reduce the chance of the error happening in the first place.

Adding logging to your company's chat app enables performance to be managed in the production environment.