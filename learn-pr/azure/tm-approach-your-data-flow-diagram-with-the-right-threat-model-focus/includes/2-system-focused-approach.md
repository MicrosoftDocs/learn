## The importance of a system-focused approach

Authenticating your users with Azure is a good thing. Understanding how that authentication works and interacts with each part of the system is better, and avoids creating unknown post-deployment risk.

After all, the goals of threat modeling are to validate assumptions you previously made, identify potential threats, and reduce risk earlier in the development lifecycle.

### Practical example of a system-focused approach

Let's take the file-sharing application example. In this case, when you look at your data-flow diagram, you might see these flows:

- User requests access to the application
- Authentication flow kicks off
- User shares files with other users

This approach analyzes and secures each element. The elements include the user, web service, authentication service, data store, trust boundary between internet and Azure, and data flow.

> [!NOTE]
> The system-focused approach incorporates a few of the other approaches, but you may want to try them individually to get more granular results.
