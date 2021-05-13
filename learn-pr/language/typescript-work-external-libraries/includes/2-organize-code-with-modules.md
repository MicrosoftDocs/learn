**Modules** provide a way to organize and categorize your code, enabling you to group related code together. Also, when code is inside a module, it is pulled from the global scope and into the scope of the module. This can help you avoid naming conflicts between components in the global namespace.

> [!TIP]
> Modules have been a feature of JavaScript since ES6, so they are also supported by TypeScript. Before ES6, earlier versions of TypeScript referred to modules as "external modules".

You can export any declaration (such as a variable, function, class, type alias, or interface) by adding the `export` keyword or import it by using the `import` keyword. Any file containing a top-level `import` or `export` statement is considered a module.

The `export` statement explicitly makes a component in one module available to other modules, while the `import` statement allows you to consume that component from another module. Modules are declarative; the `import` and `export` statements at the file level describe the relationships between them.

:::image type="content" source="../media/modules.png" alt-text="Modules are connected to each other through a series of export and import statements":::
