As a developer at Tailwind Traders, it's important to keep our libraries up-to-date. This helps ensure that we're using the latest features and fixes. It also helps us avoid security vulnerabilities. In this unit, you'll learn how to manage dependencies in a Node.js project. You'll learn how to update packages, use semantic versioning, and manage security issues.

## Considerations before updating a package

Before updating a library, consider:

* **Update Type**: Understand if it's a minor fix, a new feature, or a major change that could break your code. Semantic versioning can help identify this.
* **Project Configuration**: Ensure your project is set to receive only desired updates to avoid unexpected changes.
* **Security**: Stay aware of potential vulnerabilities. Use npm's audit feature to identify and update problematic packages.

## Use semantic versioning to define update behavior

Semantic versioning is a key standard in software development. It's essential for both publishing and using npm packages. It helps manage update risks by indicating the type of changes in a new version. A version number has specific sections to reflect these changes:

|Type              | Syntax position  |     What happens               | Update Approach |
|------------------|------------------|--------------------------------|-----------------|
|Major version     | 1st number       | 1.0.0 changes to **2**.0.0 -  A change here means breaking changes. You might need to adjust your code.| I'm OK with updating to the latest major version as soon as it's out. I accept the fact that I might need to change code on my end. |
|Minor version     | 2nd number       | 1.2.9 changes to 1.**3**.0 - A change here means new features. Your code should still work. Updates are generally safe.| I'm OK with a new feature being added. I'm not OK with code that breaks. |
|Patch version     | 3rd number       | 1.0.7 changes to 1.0.**8** - A change here means bug fixes. Updates should be safe.| I'm OK with bug fixes. |

For small Node.js projects, you can freely update to the latest versions. But for larger projects, updates need careful thought and aren't always automatic. Generally, updating smaller dependencies, with fewer of their own dependencies, makes the process easier.

## Update a package with npm CLI

You can install a package using either the `install` or `update` command in npm. These commands are now mostly interchangeable. To update a package, you typically use: `npm update <package name>@<optional version number>`.

The update process depends on two factors:

* **Version Argument**: If a version number is specified in the `npm update` command, npm fetches and installs that specific version.
* **Manifest File Entry**: The `package.json` file contains rules for updating dependencies. For example, `"dependencyName": "1.1.x"` means npm will fetch the version that matches this pattern.

## Use syntax to indicate update behavior

Before you update one or more dependencies, you should configure your `package.json` file so you get predictable behavior when you run the `npm update <name of dependency>` command. Node.js uses set of symbols that allows you to define how you want your packages to update.

|Pattern                    | Update level                          | 
|---------------------------|---------------------------------------|
|x.0.0 or *&nbsp;(asterisk) | Update to the highest _major_ version.  |
|1.x.1 or ^&nbsp;(insert)   | Update to only the _minor_ version.     |
|1.1.x or ~&nbsp;(tilde)    | Update to the latest _patch_ version.<sup>1</sup>  |

Use the pattern "~1.0.0" to update only the patch version. This pattern causes an update to the value "equal to or greater than in the same range."

## Understand versioning between package.json and package-lock.json

The `package-lock.json` file, created when you install a package, should be committed to your repository. It ensures exact installations, which is crucial for addressing runtime issues or discrepancies between development and production environments. In the `package.json` file, you define patterns for installations, such as patches, minor versions, or major versions. However, these patterns aren't exact. For instance, with a `1.x` pattern, you won't know if you installed version 1.4 or 1.5.

Consider a scenario where you're using version 1.2 in your code, and then version 1.4 is released, breaking your code. If someone installs your app at this point, they'll get a non-functioning app. But, if there's a `package-lock.json` file specifying version 1.2, then that version will be installed.

Here is an example of determining which version of a package is installed:

* If the `package.json` and `package-lock.json` files agree on a version rule, there's no conflict. For example, if `package.json` specifies `1.x` and `package-lock.json` specifies version 1.4, then version 1.4 will be installed.
* If `package.json` specifies a more specific version like `1.8.x`, it overrides the `package-lock.json` file which states the older version of 1.4. In this case, version 1.8.0 or a later patch version will be installed, if available.

## Find and update outdated packages with npm outdated

The `npm outdated` command is used to identify packages that have newer versions available. When run, it provides a list of these outdated packages:

```output
Package       Current    Wanted   Latest     Location     Depended by
lodash        1.0.0      1.0.0    4.17.19    lock-test    main-code-file
node-fetch    1.2.0      1.2.0    2.6.0      lock-test    function-code-file
```

The columns in the output include:

| Column      | Description |
|-------------|-------------|
| Package     | The outdated package. |
| Current     | The current installed version of the package. |
| Wanted      | The latest version that matches the semantic pattern you specified in the `package.json` file. |
| Latest      | The latest version of the package. |
| Location    | The location of the package dependency. The `outdated` command crawls through all installed packages in the various `node_modules` folders. |
| Depended by | The package that has the dependency. |

The **recommended workflow for updates** is:

1. `npm outdated`: to list all the outdated packages. This command provides information in the **Wanted**, **Latest**, and **Location** columns.
1. `npm update <optional package name>`: to update the installed packages. If you run this command with a package name specified, the command tries to update only the specified package. If you don't specify a package, the command tries to update all the packages in the package.json file.

## Manage security issues with npm audit

Every time you install or update a package, you get a log response that tells you what version was installed and whether there are any vulnerabilities. The log lists vulnerabilities with severity levels of high and low. If you have any high-level vulnerabilities, you should update the package. 

An example of a log response is:

```output
+ lodash@1.3.1
added 1 package from 4 contributors and audited 1 package in 0.949s
found 3 vulnerabilities (1 low, 2 high)
  run `npm audit fix` to fix them, or `npm audit` for details
```

To fix an issue and apply an update, you can run the `npm audit` command. This command lists each vulnerability. A response from `npm audit` might look like this example:

```output
# Run  npm install lodash@4.17.15  to resolve 3 vulnerabilities

| Low            | Prototype Pollution               |
|----------------|-----------------------------------|
| Package        | lodash                            |
| Dependency of  | lodash                            |
| Path           | lodash                            |
| More info      | https://npmjs.com/advisories/577  |  

and so on..
```

The `npm audit fix` command attempts to resolve vulnerabilities by upgrading to a minor version where the issue doesn't exist. However, this might not always be sufficient. In such cases, you may need to use `npm audit fix --force`, which can introduce breaking changes by updating the major version of your package.

A *vulnerability* is a code flaw that can be exploited by attackers to perform malicious actions, potentially compromising your data and systems. It's crucial to address these vulnerabilities promptly.

Given the frequent discovery of vulnerabilities, GitHub has a feature that scans repositories and automatically creates PRs suggesting upgrades to safer versions. Regularly running `npm audit` is a good practice to identify and fix vulnerabilities, contributing to the overall security of your project.