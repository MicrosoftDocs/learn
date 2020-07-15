Congratulations! You've completed this Learn Module and you now know quite a lot about how to work with files and directories in Node.js.

In this module, you learned how to read files and directories, create files and directories, and write data to files. Your code is going to run in fictional production at the largest fake company on the internet!

A few things to keep in mind from this module:

- Always use the `promises` namespace on the built-in modules. This allows you to use the `async` and `await` operators to make code synchronous without blocking program execution.
- Remember that when you create directories, you should check to see if they exist **before** you try to create them. The default behavior in Node.js is to throw an error when you try to create a directory that already exists.
- If you need to parse other file types, check out the bounty of packages on npmjs.org. In this module, I mentioned Fixed Width and .csv files. You can use the [papaparse](https://www.npmjs.com/package/papaparse) package for .csv files and the [fixy](https://www.npmjs.com/package/fixy) package for Fixed With.
