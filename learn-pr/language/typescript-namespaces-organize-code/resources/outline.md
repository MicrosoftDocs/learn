# Title

Organize code using TypeScript namespaces

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
- Installed software:
  - [Git](https://git-scm.com/)
  - [Visual Studio Code](https://code.visualstudio.com)
  - [Node.js](https://nodejs.org/)
  - TypeScript

## Summary

TypeScript provides two ways to organize code - namespaces and modules. This module explains how to organize TypeScript code using namespaces. While both namespaces and modules provide a way to categorize related code in meaningful ways and help you control which code is exposed to the global namespace of your applications, there are some differences between them.

## Learning objectives

Explain the purpose of namespaces.
Implement single-file namespaces.
Implement multi-file namespaces.
Explain the design considerations for using namespaces and modules.

## Chunk your content into subtasks

Identify the subtasks of *Organize code using TypeScript namespaces*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Explain the purpose of namespaces | Organize code using namespaces | Knowledge check | Explain the purpose of namespaces | Yes |
| Implement single-file namespaces | Organize code using namespaces | Exercise | Implement single-file namespaces | Yes |
| Implement multi-file namespaces | Organize code using namespaces | Knowledge check | Implement multi-file namespaces | Yes |
| Explain the design considerations for using namespaces and modules | Determine the difference between namespaces and modules | Knowledge check | Explain the design considerations for using namespaces and modules | Yes |

## Outline the units

1. **Introduction**

    Namespaces are a TypeScript-specific way to organize code, either within a single file or across mutliple files. Organizing code using namespaces can help you group related components together and can also help you solve naming conflicts between components.
    
1. **Introduction to TypeScript namespaces**

    - Explain the relationship between namespaces and the global namespace
    - Identify uses for namespaces

    **Knowledge check**

   - Mutliple choice

1. **Exercise - Organize code using single file namespaces**

    1. Define a namespace
    1. Export a component
    1. Access a component in a namespace
    1. Organize code using nested namespaces
    1. Defining a namespace alias
    1. Compiling a single file namespace

1. **Organize code using multi-file namespaces**

    - Define namespaces in multiple files
    - Define the relationships between namespaces using a reference statement
    - Compile multi-file namespaces

    **Knowledge check**

   - Mutliple choice

1. **Design considerations**

    - Identify the key differences between namespaces and modules
    - Identify scenarios for using namespaces
    - Identify scenarios for using modules

1. **Lab**

    1. Organize code using namespaces in a single TypeScript file
    1. Reorganize the namespaces into multiple TypeScript files.

1. **Summary**

    While namespaces offer some benefit for organizing your TypeScript code, it's important to understand when to use them and when to instead use modules. 

## Notes

- See [TypeScript Handbook: Namespaces](https://www.typescriptlang.org/docs/handbook/namespaces.html) for more information about namespaces.
- See [TypeScript Handbook: Namespaces and Modules](https://www.typescriptlang.org/docs/handbook/namespaces-and-modules.html) to learn more about the differences between namespaces and modules.
