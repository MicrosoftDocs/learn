
Choose the best response for each of the questions below. Then select **Check your answers**.
## quiz title: Check your knowledge

## Multiple Choice

What happens when you add code to a namespace?

(x)Declarations are removed from the global namespace.{{Namespaces remove declarations form the global namespace, providing a context for names and helping to reduce naming collisions.}}

()Declarations removed from the global namespace only if the namespace is in a separate file.{{Namespaces don’t have to be in separate files to be removed from the global namespace.}}

()Declarations contribute to "global scope pollution."{{Namespaces help avoid this problem rather than contributing to it.}}

## Multiple Choice

How do you make a component available outside the scope of a namespace?

(x)Add the `export` keyword to the declaration.{{Adding the `export` keyword makes the component available for use outside of the namespace.}}

()Add the `import` keyword to the file that will use the component.{{The `import` keyword can be used to create an alias that describes nested namespaces.}}

()Add a `reference` statement to the file that will use the component.{{A `reference` statement describes the relationship between TypeScript files that contain namespaces and those that will use them.}}

## Multiple Choice

What is the option that tells the TypeScript compiler to output multiple files using and containing namespaces into a single JavaScript file?

(x)`--outfile`{{The `--outfile` option instructs the compiler to output a single JavaScript file.}}

()`--multifile`{{This is not the correct option to use in this situation.}}

()No option is required. The Typescript compiler does this by default.{{By default, the TypeScript compiler produces on JavaScript file for each input file.}}
