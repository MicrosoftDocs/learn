You'll need to get better insights into your code and solution before you can change your codebase into separate components to prepare for finding dependencies that can be taken out of your system.

It allows you to decompose your system into individual components and dependencies. The goal is to reduce the size of your codebase and system, making it more efficient to build and manageable in the end.

You achieve it by removing specific components of your solution. These are going to be centralized, reused, and maintained independently.

You'll remove those components and externalize them from your solution at the expense of introducing dependencies on other components.

This process of finding and externalizing components is effectively creating dependencies.

It may require some refactoring, such as creating new solution artifacts for code organization or code changes to cater for the unchanged code to take a dependency on an (external) component.

You might need to introduce some code design patterns to isolate and include the componentized code.

Examples of patterns are abstraction by interfaces, dependency injection, and inversion of control.

Decomposing could also mean replacing your implementation of reusable code with an available open-source or commercial component.
