Congratulations! You've completed this Learn module, and you now know how to work with files and directories in Node.js.

In this module, you learned how to read files and directories, create files and directories, and write data to files. Your code is going to run in fictional production at the largest fake company on the internet!

A few things to keep in mind from this module:

- Always use the `promises` namespace on the built-in modules. You can then use the `async` and `await` operators to make code synchronous without blocking program execution.
- Whenever you are creating a directory, make sure that you wrap it in a `try/catch`. The default behavior in Node.js is to throw an error when you try to create a directory that already exists. If you just want to check if a directory exists or not, you can use the `stat` method. Note that this method does not exist on the `promises` namespace, but on the main `fs` object.
- If you need to parse other file types, check out the packages on npmjs.org. For example, you can use the [papaparse](https://www.npmjs.com/package/papaparse) package for .csv files. You can use the [fixy](https://www.npmjs.com/package/fixy) package for fixed-width files.
