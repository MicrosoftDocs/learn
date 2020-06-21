Contratulations! You've completed this Learn Module and you now know quite a lot about how to work with files and directories in Node.js. In this module, you learned how to read files and directories, create files and directories and write data to files. More than that, you've implemented a professional-grade solution for Tailwind Traders and your code is going to run in fictional production at the largest fake company on the internet!

A few things to keep in mind from this module:

1. Always favor the sync methods over the async defaults. Asyncronous code can be powerful because it allows your program to do multiple things at once. It can also be incredibly difficult to debug. Stick with the explicit `sync` methods unless you find yourself with a specific need for an action to be asynchronous.

1. If you need to parse other file types, check out the bounty of packages on npmjs.org. In this module, I mentioned Fixed Width and .csv files. You can use the [papaparse](https://www.npmjs.com/package/papaparse) package for .csv files and the [fixy](https://www.npmjs.com/package/fixy) package for Fixed With.

1. Remember that when you create directories you should check to see if they exist **before** you try and create them. The default behaviour in Node.js is to throw an error when you try and create a directory that already exists.

## Where to go next

?????
