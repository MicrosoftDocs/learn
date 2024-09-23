As a developer at Tailwind Traders, it's important to keep our packages up-to-date. This helps ensure that we're using the latest features and fixes. It also helps us avoid security vulnerabilities. In this unit, you'll learn how to manage dependencies in a Node.js project. You'll learn how to update packages, use semantic versioning, and manage security issues.

## Considerations before updating a package

Before updating a package, consider:

* **Update Type**: Understand if it's a minor fix, a new feature, or a major change that could break your code. Semantic versioning can help identify this.
* **Project Configuration**: Ensure your project is set to receive only desired updates to avoid unexpected changes.
* **Security**: Stay aware of potential vulnerabilities. Use npm's audit feature to identify and update problematic packages.
* **Testing**: Ensure your tests pass after the update. If you don't have tests, consider adding them. Your application may behave differently after an update and the tests validate the _correct_ behavior.

## Semantic versioning to define update behavior

Semantic versioning is a key standard in software development. It's essential for both publishing and using npm packages. It helps manage update risks by indicating the type of changes in a new version. A version number has specific sections to reflect these changes:

| Version Type | Position | Syntax | What Happens | Update Approach |
|--------------|----------|--------|--------------|-----------------|
| **Major**    | 1st      | x.0.0 or * | Changes from 1.0.0 to **2**.0.0 indicate breaking changes. Code adjustments may be necessary. | Comfortable with immediate updates to the latest major version, acknowledging potential code changes. |
| **Minor**    | 2nd      | 1.x.1 or ^ | Changes from 1.2.9 to 1.**3**.0 introduce new features. Existing code should still function. Updates are typically safe. | Open to new features, but not breaking changes. |
| **Patch**    | 3rd      | 1.1.x or ~ | Changes from 1.0.7 to 1.0.**8** mean bug fixes. Updates should be safe. | Accepting of bug fixes. |

For small Node.js projects, you can freely update to the latest versions. But for larger projects, updates need careful thought and aren't always automatic. Generally, updating smaller dependencies, with fewer of their own dependencies, makes the process easier.

Before you update one or more dependencies, you should configure your `package.json` file so you get predictable behavior when you run the `npm update <name of dependency>` command. Node.js uses set of symbols that allows you to define how you want your packages to update.

## Update a package with npm CLI

You can install a package using either the `install` or `update` command in npm. These commands are now mostly interchangeable. To update a package, you typically use: 

* Latest version: `npm update <package name>@latest`.
* Specific version: `npm update <package name>@<optional version number>`. 

The update process depends on two factors:

* **Version Argument**: If a version number is specified in the `npm update` command, npm fetches and installs that specific version.
* **Manifest File Entry**: The `package.json` file contains rules for updating dependencies. For example, `"dependencyName": "1.1.x"` means npm will fetch the version that matches this pattern.


## Understand versioning 

Three files control the versioning of dependencies:

* `package.json`: This file defines the version of the package you want to use. It's the manifest file for your project. It contains the metadata for your project, including the dependencies.
* `package-lock.json`: This file describes the exact tree that was generated, such that subsequent installs are able to generate identical trees, regardless of intermediate dependency updates. This file is intended to be committed into source repositories.
* `shrinkwrap.json`: This file is created by the `npm shrinkwrap` CLI command and is similar to `package-lock.json`. The major difference between the commands is that the package versions specified in `npm-shrinkwrap.json` cannot be overridden by users. In addition, the `npm-shrinkwrap.json` file is compatible with older versions of npm (versions 2-4), whereas `package-lock.json` is compatible with npm version 5 and later. Therefore, you may find `npm-shrinkwrap.json` when maintaining legacy codebases. Most developers will use `package-lock.json` instead of `npm-shrinkwrap.json`. One exception where `npm-shrinkwrap.json` is preferred is for global installs of daemons and command-line tools where developers want to ensure the exact versions of the packages specified are installed.

## Example determination of package version

Consider a scenario where you're using version 1.2 in your code, and then version 1.4 is released, breaking your code. If someone installs your app at this point, they'll get a nonfunctioning app. But, if there's a `package-lock.json` file specifying version 1.2, then that version will be installed.

Here's an example of determining which version of a package is installed:

* If the `package.json` and `package-lock.json` files agree on a version rule, there's no conflict. For example, if `package.json` specifies `1.x` and `package-lock.json` specifies version 1.4, then version 1.4 will be installed.
* If `package.json` specifies a more specific version like `1.8.x`, it overrides the `package-lock.json` file, which states the older version of 1.4. In this case, version 1.8.0 or a later patch version will be installed, if available.

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

## Manage security issues with npm audit

Every time you install or update a package, you get a log response that tells you what version was installed and whether there are any vulnerabilities. The log lists vulnerabilities. If you have any critical or high vulnerabilities, you should update the package. 

An example of a log response is:

```output
+ lodash@1.3.1
added 1 package from 4 contributors and audited 1 package in 0.949s
found 3 vulnerabilities (1 low, 2 high)
  run `npm audit fix` to fix them, or `npm audit` for details
```

To fix an issue and apply an update, you can run the `npm audit` command. This command lists each vulnerability.

The `npm audit fix` command attempts to resolve vulnerabilities by upgrading to a minor version where the issue doesn't exist. However, this might not be available if the fix is actually in the next major version. 

In such cases, you may need to use `npm audit fix --force`, which can introduce breaking changes by updating to the major version. Running this command is a decision you should make carefully. You should be aware of the breaking changes and use `npm update` to update your code including vulnerabilities.

A *vulnerability* is a code flaw that can be exploited by attackers to perform malicious actions, potentially compromising your data and systems. It's crucial to address these vulnerabilities promptly.

Given the frequent discovery of vulnerabilities, GitHub has a feature that scans repositories and automatically creates PRs suggesting upgrades to safer versions. Regularly running `npm audit` is a good practice to identify and fix vulnerabilities, contributing to the overall security of your project.

## Recommended update workflow

The **recommended workflow for updates** is:

1. `npm run test`: Verify your existing tests pass before starting this update process.
1. `npm audit`: to check for vulnerabilities in the current version you're using. The information from `npm audit` may recommend updating to a major version. You should carefully review the breaking changes if any are listed.
1. `npm outdated`: to list all the outdated packages. This command provides information in the **Wanted**, **Latest**, and **Location** columns.
1. Update with `npm update`: 
    * For smaller projects (a few dependencies in the `package.json`: you may try `npm update` to update all dependencies then run your tests. 
    * For larger projects (with many dependencies in the `package.json`: update a single package or package family (such as Next.js and React) then run the tests. 
1. `npm audit`: check there are no critical or high vulnerabilities. If vulnerabilities still exist, use `npm update` with the package name and the major version recommended in `npm audit`. 
1. `npm run test` again. 
1. Check in your `package.json` and `package-lock.json`.