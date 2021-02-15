
Choose the best response for each of the questions below. Then select **Check your answers**.
## quiz title: Check your knowledge

## Multiple Choice

Which of the following is possible when using namespaces but not when using modules?

(x)Compile multiple TypeScript files into a single JavaScript file.{{The `--outFile` compiler option combines mutliple namespace files to a single JavaScript file.}}

()Designate a component as available outside of the scope of the namespace using the `export` keyword.{{Both namespaces and modules use the `export` keyword to designate a component as available outside of the scope of the namespace or module.}}

()Declaring dependencies.{{Namespaces cannot declaire their dependencies.}}

## Multiple Choice

How do you use use a component from one module file in another module file?

(x)Use the `import` keyword.{{To use a component from one module in another module, use the `import` keyword.}}

()Use a `reference` statement.{{A `reference` statement informs TypeScript of the relationship between diffent files that contain namespaces.}}

()Prepend the module name to the component name.{{Once a relationship between namespaces is established, you can refer to the components of the namespace by prepending the namespace name to the component.}}

## Multiple Choice

What is the recommended code-organizing mechanism for new ES6-compliant projects?

(x)Modules.{{Modules are the recommended code-organizing mechanism for ES6-compliant projects because they offer benefits that namespaces do not have.}}

()Namespaces.{{While you can use namespaces or modules in your ES6-compliant projects, namespaces do not offer all the benefits of modules.}}

()It doesn't matter which one you choose.{{There are differences between modules and namespaces that make one preferred over the other for modern applications.}}
