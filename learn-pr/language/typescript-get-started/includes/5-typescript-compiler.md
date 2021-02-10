As you learned earlier, TypeScript is a strict superset of [ECMAScript 2015](https://www.ecma-international.org/ecma-262/6.0/?azure-portal=true) (ECMAScript 6 or ES6). This means that all JavaScript code is also TypeScript code, and a TypeScript program can seamlessly consume JavaScript. In fact, you can convert a JavaScript file to a TypeScript file by simply renaming the extension from **.js** to **.ts**.

However, not all TypeScript code is JavaScript code. This is because TypeScript adds new syntax to JavaScript that makes it easier to read and implements some features, like static typing. While this TypeScript code makes development easier and less error prone, browsers and most other runtimes don't natively support TypeScript. For this reason, TypeScript requires a build step ([transpiler](https://en.wikipedia.org/wiki/Source-to-source_compiler?azure-portal=true)) to transform it to JavaScript for your application to work.

TypeScript code is transformed into JavaScript code using the TypeScript compiler (or a TypeScript-compatible transpiler, like [Babel](https://babeljs.io/?azure-portal=true), [swc](https://swc.rs/docs/installation/?azure-portal=true), or [Sucrase](https://github.com/alangpierce/sucrase?azure-portal=true).) This process removes the TypeScript-specific code (for example, type declarations and interfaces) and generates a clean JavaScript file that you can run from your web pages and is compatible with browsers.

## Compiling a TypeScript file

You run the TypeScript compiler from the command line using the `tsc` command. When you run `tsc` without additional parameters, it compiles all the .ts files in the current folder and generates a .js file for each one.

You can also compile a specific file. For example, to compile a TypeScript file named **utility_functions.ts**, enter **tsc utility_functions.ts**. 

> [!NOTE]
> The **.ts** extension is optional.

If there are no compiler errors, the `tsc` command generates a JavaScript file named **utility_functions.js**.

If the compiler finds errors in the code, it will display them in the command window. Fix the errors in the TypeScript file and rerun the `tsc` command.

## Compiler options

Compiler options allow you to control how the JavaScript will be generated from the source TypeScript. You can either set the options at the command line as you would with many CLIs, or set the options in a JSON file named **tsconfig.json**.

There are numerous options available. You can find a [complete list of compiler options in the documentation](https://www.typescriptlang.org/docs/handbook/compiler-options.html?azure-portal=true). Below are a few of the most common:

- `noImplicitAny`
- `noEmitOnError`
- `target`
- the directory options

There are many compiler options that you can use with the `tsc` command to control the compilation to your preference.

The `--noImplicitAny` option instructs the compiler to raise errors on expressions and declarations with an implied `any` type. For example:

`tsc utility_functions.ts --noImplicitAny`

The `--target` option specifies the ECMAScript target version for the JavaScript file. This example compiles an ECMAScript 6-compliant JavaScript file:

`tsc utility_functions.ts --target "ES2015"`

You'll learn about other compiler options in later modules. See  for the complete list of options.
