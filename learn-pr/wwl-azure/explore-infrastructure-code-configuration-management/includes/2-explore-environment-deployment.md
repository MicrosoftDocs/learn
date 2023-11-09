Suppose you've ever received a middle-of-the-night emergency support call because of a crashed server.

In that case, you know the pain of searching through multiple spreadsheets or even your memory—to access the manual steps of setting up a new machine.

Then there's also the difficulty of keeping the development and production environments consistent.

An easier way to remove the possibility of human error when initializing machines is to use Infrastructure as Code.

## Manual deployment versus infrastructure as code

A common analogy for understanding the differences between manual deployment and infrastructure as code is the distinction between owning pets and owning cattle.

When you have pets, you name each one and regard them as individuals; if something terrible happens to one of your pets, you're inclined to care a lot.

If you have a herd of cattle, you might still name them, but you consider their herd.

In infrastructure terms, there might be severe implications with a manual deployment approach if a single machine crashes and you need to replace it (pets).

If you adopt infrastructure as a code approach, you can more easily provision another machine without adversely impacting your entire infrastructure (cattle) if a single machine goes down.

## Implementing infrastructure as code

With infrastructure as code, you capture your environment (or environments) in a text file (script or definition).

Your file might include any networks, servers, and other computing resources.

You can check the script or definition file into version control and then use it as the source for updating existing environments or creating new ones.

For example, you can add a new server by editing the text file and running the release pipeline rather than remoting it into the environment and manually provisioning a new server.

The following table lists the significant differences between manual deployment and infrastructure as code.

| **Manual deployment**                                        | **Infrastructure as code**                       |
| ------------------------------------------------------------ | ------------------------------------------------ |
| Snowflake servers.                                           | A consistent server between environments.        |
| Deployment steps vary by environment.                        | Environments are created or scaled easily.       |
| More verification steps and more elaborate manual processes. | Fully automated creation of environment Updates. |
| Increased documentation to account for differences.          | Transition to immutable infrastructure.          |
| Deployment on weekends to allow time to recover from errors. | Use blue/green deployments.                      |
| Slower release cadence to minimize pain and long weekends.   | Treat servers as cattle, not pets.<br>           |

## Benefits of infrastructure as code

The following list is benefits of infrastructure as code:

 -  Promotes auditing by making it easier to trace what was deployed, when, and how. (In other words, it improves traceability.)
 -  Provides consistent environments from release to release.
 -  Greater consistency across development, test, and production environments.
 -  Automates scale-up and scale-out processes.
 -  Allows configurations to be version-controlled.
 -  Provides code review and unit-testing capabilities to help manage infrastructure changes.
 -  Uses *immutable* service processes, meaning if a change is needed to an environment, a new service is deployed, and the old one was taken down, it isn't updated.
 -  Allows *blue/green* deployments. This release methodology minimizes downtime where two identical environments exist—one is live, and the other isn't. Updates are applied to the server that isn't live. When testing is verified and complete, it's swapped with the different live servers. It becomes the new live environment, and the previous live environment is no longer the live.
 -  Treats infrastructure as a flexible resource that can be provisioned, de-provisioned, and reprovisioned as and when needed.
