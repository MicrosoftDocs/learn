Congratulations! You've completed this Learn module, and you now know how to work with files and directories in .NET.

In this module, you learned how to read files and directories, create files and directories, and write data to files. Your code is going to run in fictional production at the largest fake company on the internet!

A few things to keep in mind from this module:

- `Directory.EnumerateDirectories` and `Directory.EnumerateFiles` accept a parameter that allows you to specify a search condition for names to return, and a parameter to recursively traverse all child directories.
- `System.Environment.SpecialFolder` is an enumeration that allows you to access system-defined folders, such as the desktop or user profile, in a cross-platform manner without having to memorize the exact path for each operating system.
- If you need to parse other file types, check out the packages on nuget.org. For example, you can use the [CsvHelper](https://www.nuget.org/packages/CsvHelper) package for .csv files.
