As you learned earlier, TypeScript is a strict superset of [ECMAScript 2015](https://www.ecma-international.org/ecma-262/6.0/?azure-portal=true) (ECMAScript 6 or ES6). This means that all JavaScript code is also TypeScript code, and a TypeScript program can seamlessly consume JavaScript. In fact, you can convert a JavaScript file to a TypeScript file by simply renaming the extension from *.js* to *.ts*.

However, not all TypeScript code is JavaScript code. This is because TypeScript adds new syntax to JavaScript, which makes the JavaScript easier to read and implements some features, such static typing. Although the TypeScript code makes development easier and less error prone, browsers and most other runtimes don't natively support TypeScript. For this reason, TypeScript requires a build step ([transpiler](https://en.wikipedia.org/wiki/Source-to-source_compiler?azure-portal=true)) to transform it to JavaScript for your application to work.

You transform TypeScript code into JavaScript code by using the TypeScript compiler, or you can use a TypeScript-compatible transpiler, such as [Babel](https://babeljs.io/?azure-portal=true), [swc](https://swc.rs/docs/installation/?azure-portal=true), or [Sucrase](https://github.com/alangpierce/sucrase?azure-portal=true). This process removes the TypeScript-specific code (for example, type declarations and interfaces). Additionally, it generates a clean JavaScript file that you can run from your web pages, and it's compatible with browsers.

## Compile a TypeScript file

You run the TypeScript compiler at the command prompt by using the `tsc` command. When you run `tsc` without additional parameters, it compiles all the *.ts* files in the current folder and generates a *.js* file for each one.

You can also compile a specific file. For example, to compile a TypeScript file named *utility_functions.ts*, enter `tsc utility_functions.ts`. 

> [!NOTE]
> Entering the *.ts* file extension is optional.

If there are no compiler errors, the `tsc` command generates a JavaScript file named *utility_functions.js*.

If the compiler finds errors in the code, it displays them in the command window. Fix the errors in the TypeScript file, and then rerun the `tsc` command.

## Compiler options

By using compiler options, you can control how the JavaScript is generated from the source TypeScript. You can set the options either at the command prompt, as you would with many command-line interfaces, or in a JSON file named *tsconfig.json*.

Numerous compiler options are available to you. You can find a complete list of options in [the tsc command-line interfaces documentation](https://www.typescriptlang.org/docs/handbook/compiler-options.html?azure-portal=true). Here are a few of the most common options:

- `noImplicitAny`
- `noEmitOnError`
- `target`
- the directory options

To control the compilation, you can use compiler options with the `tsc` command, including:

* The `--noImplicitAny` option instructs the compiler to raise errors on expressions and declarations with an implied `any` type. For example:

  `tsc utility_functions.ts --noImplicitAny`

* The `--target` option specifies the ECMAScript target version for the JavaScript file. This example compiles an ECMAScript 6-compliant JavaScript file:

  `tsc utility_functions.ts --target "ES2015"`

You'll learn about other compiler options in later modules.