There are several ways to identify the dependencies in your codebase.

These include scanning your code for patterns and reuse and analyzing how the solution is composed of individual modules and components.

 -  **Duplicate code** When certain pieces of code appear in several places, it's a good indication that this code can be reused. Keep in mind that code duplication isn't necessarily a bad practice. However, if the code can be made available properly, it does have benefits over copying code and must manage that. The first step to isolate these pieces of duplicate code is to centralize them in the codebase and componentize them in the appropriate way for the type of code.
 -  **High cohesion and low coupling** A second approach is to find code that might define components in your solution. You'll look for code elements that have high cohesion and low coupling with other parts of code. It could be a specific object model with business logic or code related to its responsibility, such as a set of helper or utility codes or perhaps a basis for other code to be built upon.
 -  **Individual lifecycle** Related to high cohesion, you can look for parts of the code that have a similar lifecycle and can be deployed and released individually. If such code can be maintained by a team separate from the codebase that it's currently in, it's an indication that it could be a component outside of the solution.
 -  **Stable parts** Some parts of your codebase might have a slow rate of change. That code is stable and isn't altered often. You can check your code repository to find the code with a low change frequency.
 -  **Independent code and components** Whenever code and components are independent and unrelated to other parts of the system, they can be isolated to a separate component and dependency.

You can use different kinds of tools to assist you in scanning and examining your codebase.

These range from tools that scan for duplicate code and draw solution dependency graphs to tools that compute metrics for coupling and cohesion.
