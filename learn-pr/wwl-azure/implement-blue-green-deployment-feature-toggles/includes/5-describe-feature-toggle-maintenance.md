A feature toggle is just code. And to be more specific, conditional code. It adds complexity to the code and increases the technical debt.

Be aware of that when you write them, and clean up when you don't need them anymore.

While feature flags can be helpful, they can also introduce many issues of their own.

The idea of a toggle is that it's short-lived and only stays in the software when it's necessary to release it to the customers.

You can classify the different types of toggles based on two dimensions as described by Martin Fowler.

He states that you can look at the dimension of how long a toggle should be in your codebase and, on the other side how dynamic the toggle needs to be.

## Planning feature flag lifecycles

:::image type="content" source="../media/switch-position-triggers-flag-64d2ca6d.png" alt-text="Diagram showing a switch in the on position triggers a flag, if this, else that.":::


The most important thing is to remember that you need to remove the toggles from the software.

If you don't do that, they'll become a form of technical debt if you keep them around for too long.

As soon as you introduce a feature flag, you've added to your overall technical debt.

Like other technical debt, they're easy to add, but the longer they're part of your code, the bigger the technical debt becomes because you've added scaffolding logic needed for the branching within the code.

The cyclomatic complexity of your code keeps increasing as you add more feature flags, as the number of possible paths through the code increases.

Using feature flags can make your code less solid and can also add these issues:

 -  The code is harder to test effectively as the number of logical combinations increases.
 -  The code is harder to maintain because it's more complex.
 -  The code might even be less secure.
 -  It can be harder to duplicate problems when they're found.

A plan for managing the lifecycle of feature flags is critical. As soon as you add a flag, you need to plan for when it will be removed.

Feature flags shouldn't be repurposed. There have been high-profile failures because teams decided to reuse an old flag that they thought was no longer part of the code for a new purpose.

## Tooling for release flag management

The amount of effort required to manage feature flags shouldn't be underestimated. It's essential to consider using tooling that tracks:

 -  Which flags exist.
 -  Which flags are enabled in which environments, situations, or target customer categories.
 -  The plan for when the flags will be used in production.
 -  The plan for when the flags will be removed.

Using a feature flag management system lets you get the benefits of feature flags while minimizing the risk of increasing your technical debt too high.

Azure App Configuration offers a Feature Manager. See [Azure App Configuration Feature Manager](/azure/azure-app-configuration/manage-feature-flags).
