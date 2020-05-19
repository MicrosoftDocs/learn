## What is the System Focused Approach?

The system-focused approach provides a framework to help analyze the system and how it affects other assets, which include:

|Asset Type|Examples|
|----------|--------|
|Logical|Source code, APIs, and logical security controls|
|Physical|Servers and physical security controls assets|

### Why Is This Important?

Authenticating your users with Azure is a good thing. Understanding how it works and interacts with each part of the system is better and avoids creating unknown risk post-deployment.

After all, the goals of threat modeling are to validate assumptions previously made, identify potential threats, and reduce risk earlier in the development lifecycle.

### What Is a Practical Example For This Approach?

Let's take the file sharing application example. In this case, when you look at your data-flow diagram, you might see these flows:

- User requests access to the application
- Authentication flow kicks off
- User shares files with other users

This approach analyzes and secures each element, such as user, web service, authentication service, data store, trust boundary between internet and Azure, and data-flow.

## What Are the Other Focused Approaches?

There are additional focused approaches you can use for your threat modeling exercise:

|Focused Approach|Definition|
|----------------|----------|
|Attacker|Evaluates attackers, their goals, and motivations. This approach assumes imposed risk and an assumed breach mentality|
|Asset|Evaluates risk for each asset. This approach identifies critical assets based on things like classified data handling and focuses mostly on protecting those assets|

### What Is a Practical Example For These Approaches?

For the attacker focused approach, the main goal is to understand more about the attacker, their motive, means, and entry points. Emphasis is placed across all entry points instead of the whole system.

This approach allows you to focus on critical assets holding highly confidential data for your system. Emphasis is placed on protecting those assets instead of the entire system.

> [!NOTE]
> The system focused approach incorporates a few of the other approaches, but you may want to do try them individually to get more granular results.