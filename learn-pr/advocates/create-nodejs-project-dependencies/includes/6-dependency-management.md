Sooner or later, you'll want to update to a new version of a library. Maybe a function is marked as deprecated. Or maybe there's a new feature in a later version of a package you're using. 

There are some considerations you should take into account before you try to update a library:

- **The type of update**. What type of update is available? Is it a small bug fix? Is it adding a new feature you need? Will it break your code? You can communicate the type of update by using a system called *semantic versioning*. The way the version number of the library is expressed communicates to developers the type of update they're dealing with.
- **Whether the project is configured correctly**. You can configure your Node.js project so that you get only the types of updates you want. You'll only perform an update if a specific type of update is available. We recommend this approach because you don't risk running into surprises.
- **Security problems**. Managing your project dependencies over time involves being aware of problems that might occur. Problems arise as vulnerabilities are detected. Ideally, patches will be released that you can download. The npm tool helps you run an *audit* on your libraries to find out if you have packages that should be updated. It also helps you take the appropriate action to fix a problem.

## Use semantic versioning

There's an industry standard called *semantic versioning*. It's a system adopted by many companies and developers. If you intend to publish packages and push them to the npm registry, you should follow semantic versioning. It's expected. Even if you only download packages from the npm registry, you can expect these packages to follow semantic versioning.

So why is it such a big deal? Changes to a package can introduce risk. Risk like a bug being introduced that could harm your business. Risk that might include the need to rewrite part of your code. Rewriting code takes time and costs money.  

Semantic versioning is how you express the type of change that you or another developer is introducing to a library. Semantic versioning works by ensuring a package has a version number and that the version number is divided into these sections:

- **Major version**: The leftmost number. For example, the 1 in 1.0.0. A change to this number means you can expect breaking changes in the code. You might need to rewrite part of your code.
- **Minor version**: The middle number. For example, the 2 in 1.2.0. A change to this number means features have been added. Your code should still work. It's generally safe to accept the update.
- **Patch version**: The rightmost number. For example, the 3 in 1.2.3. A change to this number means a change has been applied that fixes something in the code that should have worked. It should be safe to accept the update.

This table shows how the version number changes for each version type:

|Type              | What happens               |
|------------------|----------------------------|
|Major version     | 1.0.0 changes to **2**.0.0 |
|Minor version     | 1.2.9 changes to 1.**3**.0 |
|Patch version     | 1.0.7 changes to 1.0.**8** |


## Update a package by using npm

There are two ways to install a package. You can run either the `install` command or the `update` command. At one time, there were differences between these two commands. Now the two commands act more like aliases for each other. A typical command to update a package might be: `npm update <name of package>@<optional argument with version number>`.

The specific action of the update process depends on two conditions:

- **Whether the version argument is specified as part of the command**. If a version argument (the last argument) is specified in the `npm update` command, the specified package version is fetched and installed.
- **The entry in the manifest file**. The entry in the manifest file includes the name of the dependency and a value that expresses a rule pattern for how the dependency is updated. Here's an example: `"<name of dependency>": "1.1.x"`. The npm tool respects the rule pattern and tries to fetch the version of the dependency that matches the rule pattern.

### Update approach

As a Node.js developer, you can communicate to Node.js the update behavior you want. Think about updating in terms of risk. Here are some approaches:

- **Major version**: I'm OK with updating to the latest major version as soon as it's out. I accept the fact that I might need to change code on my end.
- **Minor version**: I'm OK with a new feature being added. I'm not OK with code that breaks.
- **Patch version**: The only updates I'm OK with are bug fixes.

If you're managing a new or smaller Node.js project, you can afford to be loose with how you define the update strategy. By default, you might choose to always update to the latest version. But for complex projects, there's more nuance to consider. In that case, you might not do the update by default. In general, the smaller the dependency you're updating, the fewer dependencies it has and the more likely the update process will be easy.

### Configure the package.json for update

Before you update one or more dependencies, you should configure your manifest file so you get predictable behavior when you run the `npm update <name of dependency>` command. You can communicate the approach you want to take for a package. Node.js has a set of symbols that allows you to define how you want your packages to update.

The process is to add different prefixes to your package entries in the package.json file. There are many things you can configure in addition to major/minor/patch version. You can also express that you want packages within only a certain range or that you want packages that have a certain tag, like `alpha` or `beta`.

Here are some patterns that you can configure for major/minor/patch version:

|Pattern                    | Update level                          | 
|---------------------------|---------------------------------------|
|x.0.0 or *&nbsp;(asterisk) | Update to the highest _major_ version.  |
|1.x.1 or ^&nbsp;(insert)   | Update to only the _minor_ version.     |
|1.1.x or ~&nbsp;(tilde)    | Update to the latest _patch_ version.<sup>1</sup>  |

<sup>**1**</sup> You can use the pattern "~1.0.0" to update only the patch version. The pattern causes an update to the value "equal to or greater than in the same range."

## package-lock.json

In addition to the package.json manifest file, you also have the package-lock.json file. This file is generated when you do something that modifies the node_modules directory or anything that changes the dependencies in the package-lock.json file. This file isn't created when you run the `npm init` command. The file is created when you install a package, for example.

The package-lock.json file should be committed to your repository.

One reason to commit this file to your repository is that it guarantees exact installations. Remember how in the package.json file, you define patterns for the types of installations you want, such as patches, minor versions, or major versions. Patterns aren't exact. If you use a `1.x` pattern, you won't know if you installed version 1.4 or 1.5.

You might need to know which version you installed. Consider the scenario where you specify the pattern `1.x`, you're specifically using version 1.2 in your code, and then version 1.4 is released. The new version ends up breaking your code. Someone installing your app will get a non-functioning app at that point. But, if there's a package-lock.json file that states version 1.2 is used, then version 1.2 will be installed. So, who cares about this behavior? People who use your app and continuous integration (CI) tools.

It's important to understand the process, and also which file determines when an installation occurs. It works like this: 
- If the package.json and the package-lock.json files agree on a semantic-rule level, there's no conflict. If the pattern says `1.x` in the package.json file and the package-lock.json file specifies version 1.4 is installed, then version 1.4 will be installed. 
- If the package.json file specifies a pattern like `1.8.x`, then the instructions in the package-lock.json file won't be implemented. Minor version 1.8.0 or later will be installed, or a later *patch* version if one is available.

The package-lock.json file also provides other features. It makes it easy to see what has changed between commits and helps to optimize the installation process.

## Find and update outdated packages

The `npm outdated` command lists outdated packages. This command helps you identify when newer versions of packages are available. Here's a typical output from the command:

```output
Package       Current    Wanted   Latest     Location     Depended by
lodash        1.0.0      1.0.0    4.17.19    lock-test    main-code-file
node-fetch    1.2.0      1.2.0    2.6.0      lock-test    function-code-file
```

The columns in the output include:
- **Package**: The outdated package.
- **Current**: The current installed version of the package.
- **Wanted**: The latest version that matches the semantic pattern you specified in the package.json file.
- **Latest**: The latest version of the package.
- **Location**: The location of the package dependency. The `outdated` command crawls through all installed packages in the various node_modules folders.
- **Depended by**: The package that has the dependency.

The recommended workflow is to run these commands in this order:

1. Run the `npm outdated` command to list all the outdated packages. This command provides information in the **Wanted**, **Latest**, and **Location** columns.
1. Run the `npm update <optional package name>` command to update the installed packages. If you run this command with a package name specified, the command tries to update only the specified package. If you don't specify a package, the command tries to update all the packages in the package.json file.

## Manage security issues

Every time you update or install a package, you get a log response after the installation completes. The response tells you what version was installed and whether there are any vulnerabilities. A log might look like this example:

```output
+ lodash@1.3.1
added 1 package from 4 contributors and audited 1 package in 0.949s
found 3 vulnerabilities (1 low, 2 high)
  run `npm audit fix` to fix them, or `npm audit` for details
```

The log lists vulnerabilities with severity levels of high and low. If you have any high-level vulnerabilities, you should update the package. To fix an issue and apply an update, you can run the `npm audit` command, as indicated in the log response. This command lists each vulnerability. A response from `npm audit` might look like this example:

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

The `npm audit fix` command tries to fix the problem. It tries to upgrade to a minor version where the problem doesn't exist. That action might not be enough. You might be prompted you to run the `npm audit fix --force` command to fix the problem. This action involves a breaking change. That is, the major version of your package will be updated.

A *vulnerability* is a weakness in code that attackers can exploit to commit malicious actions. Attackers can use these weaknesses to gain access to your data and your systems. You should take vulnerabilities seriously.

Vulnerabilities are discovered all the time. They're so common that GitHub has implemented a function that scans repos and automatically creates PRs to suggest you upgrade to a safer version due to a vulnerability. You should run the audit command `npm audit` occasionally. Safety is everyone's job. A large repo provider like GitHub does its part. You can do your part by auditing and fixing vulnerabilities if you find any.
