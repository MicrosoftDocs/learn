Being able to find and address issues in a web app is an ongoing and essential task. A best practice for debugging issues is to create a staging instance or deployment model where the stage mirrors the live environment. You can then debug without having to disrupt your customer experience.

This works well in many situations. But in some instances environmental factors play a role in how bugs are expressed. For example, a bug can be related to a secure communication between two or more entities that can be challenging to reproduce in a staging environment. Having the ability to debug a live environment without disrupting the customer experience can help developers track down issues and solve them quicker.

Snapshot Debugger was designed with this scenario in mind. It enables developers to debug live services with almost no interruption to the user's experience. In large deployments, there can be many servers running identical instances of an application. Infrequent issues that occur across these instances can show up only on specific servers. Snapshot Debugger will help you debug situations like these as it works against multiple instances of the application at once regardless of which server it's being executed on.

## How Snapshot Debugger works

**Snappoints**. Snapshot Debugger allows you to create Snappoints. Snappoints work like breakpoints in a typical development environment. With breakpoints however, code execution stops when the breakpoint is hit (thus the name). Snappoints, however, don't stop code execution. When a Snappoint is hit the debugger gathers information about the state (call stack, variables, and object states) of the app at that moment. It then creates a log that you can inspect. Code execution continues as normal so the end user isn't impacted.

You can view debug information for a given Snappoint in Visual Studio. The call stack and locals are all available for inspection. This information can help you uncover problems that show up in real-world situations that can be challenging to recreate in a lab environment.

**Logpoints**. Suppose you're outputting log entries throughout your code. However, for a specific issue you're debugging, you're not getting the necessary log entries to help you debug that particular problem. Logpoints enable you to add more log statements to live code. The statements are temporary and so don't become a part of the running code. But they can help you track relevant events and information in your debugging process.

**Conditions**. Conditional statements you specify apply to both Snappoints and Logpoints to ensure that you only get diagnostics information on interesting requests that might help identify the root cause of the problem. For example, you can have a conditional that checks a variable for a null value. At runtime, you can also want to check for a condition where the variable isn't null to determine if a segment of code is hit under that specific condition. You can add that condition in Snapshot debugger and the debugger will apply the condition to the snapshot or logpoint.

## Difference between snappoints and breakpoints

Snappoints give you information at a moment in time about the state of your code at that point. Unlike a debugger, you can't step through the code to see how variable information changes as code execution progresses. It's possible to place snappoints at various places in your code however so you can see state changes over time.

Also, Snapshot Debugger is designed to minimize the impact on your production environment. If server memory is low, it will refrain from collecting snapshots. Also, once Visual Studio is closed, the snappoints are removed. They don't persist on the running application outside of the Visual Studio monitoring instance.

Snapshot Debugger is designed for specific scenarios that are resilient to lab forensics. It can be a powerful tool in a larger toolbox for finding issues with your application and keep it running at its best.
