# Title

Access external libraries from TypeScript

## Role(s)

- student
- developer

## Level

- intermediate

## Product(s)

- TypeScript

## Prerequisites

- Knowledge of TypeScript
- Familiarity with JavaScript
- Familiarity with modules in JavaScript
- Installed software:
  - [Git](https://git-scm.com/)
  - [Visual Studio Code](https://code.visualstudio.com)
  - [Node.js](https://nodejs.org/)
  - TypeScript

## Summary

TypeScript provides two ways to organize you code: Namespaces and modules. While both provide a way to categorize related code in meaningful ways and help you control which code is exposed to the global namespace of your applications, there are some differences between them. This module introduces you to modules in TypeScript (referred to as external modules in previous versions.) 

In addition to modules, you can import other external libraries containing type definitions that you can take advantage of in your code.

## Learning objectives

1. Organize code using modules.
1. Import an external type library.

## Chunk your content into subtasks

Identify the subtasks of *Working with external libraries in TypeScript*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Organize code using modules | Organize code using modules | Exercise | Organize code using modules | No - Combine **Organize coding using modules**, **Exercise: Export and import module components**, and **Exercise: Compile modules** |
| Import an external type library | Import an external type library | Exercise | Import an external type library | Yes |

## Outline the units

1. **Introduction**

    Virtually all JavaScript and TypeScript projects make use of modules and external type libraries. While both JavaScript and TypeScript support these, the implementation details are different. This module explains the difference.

1. **Organize code using modules**

    - Explain what happens when code is contained in a module
    - Explain how the export and import keywords work to define the relationship between modules

    **Knowledge check**

    - Multiple choice

1. **Exercise - Export and import module components**

    1. Export a module component
    1. Import a module component

1. **Exercise - Compile modules**

    1. Compile a module using the --module compiler option
    
1. **Exercise - Access external type libraries**

    1. Install an external type library
    1. Access an external type library from code

1. **Lab**

    1. Export module components
    1. Import module components

1. **Summary**

    This module showed you two ways to use external libraries in your projects: modules and external type libraries. 

## Notes

- See [TypeScript Handbook: Modules](https://www.typescriptlang.org/docs/handbook/modules.html) for more information about exporting and importing modules.
- See [TypeScript Handbook: Module Resolution](https://www.typescriptlang.org/docs/handbook/module-resolution.html) for more information about the process the compiler uses to figure out what a module import refers to.
- See [TypeScript Handbook: Namespaces and Modules](https://www.typescriptlang.org/docs/handbook/namespaces-and-modules.html) to learn more about the differences between namespaces and modules.
- See [Declaration Files](https://www.typescriptlang.org/docs/handbook/declaration-files/introduction.html) for more information on developing your own type definition files. 
- See [DefinitelyTyped](https://definitelytyped.org/) for repository for TypeScript type definitions.
