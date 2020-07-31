Sooner or later, you'll want to update to a new version of a library. Maybe a function is marked as deprecated. Or maybe there's a new feature in a later version of a package you're using. 

There are some considerations that you should take into account before you try to update a library:

- **The type of update**. What type of update is available? Is it a small bug fix? Is it adding a new feature you need? Will it break your code? You can communicate the type of update by using a system called *semantic versioning*. The way the version number of the library is expressed communicates to developers the type of update they're dealing with.
- **Whether the project is configured correctly**. You can configure your Node.js project so that you get only the types of updates you want. You'll only perform an update if a specific type of update is available. We recommend this approach because you don't risk running into surprises.
- **Security problems**. Managing your project dependencies over time involves being aware of problems that might occur. Problems arise as vulnerabilities are detected, for example. Ideally, patches will be released that you can download. The npm tool helps you run an *audit* on your libraries to find out if you have packages that should be updated. It also helps you take the appropriate action to fix a problem.

## Use semantic versioning

There's an industry standard called *semantic versioning*. It's a system adopted by many companies and developers. If you intend to publish packages and push them to the npm registry, you should follow semantic versioning. It's expected. Even if you only download packages from the npm registry, you can expect these packages to follow semantic versioning.

So why is it such a big deal? Changes to a package can introduce risk. Risk that a bug that could harm your business could be introduced. Risk that you might need to rewrite part of your code. Rewriting code takes time and costs money.  

Semantic versioning is how you express the type of change that you or some other developer is introducing to a library. Semantic versioning works by ensuring a package has a version number and that the version number is divided up into these sections:

- **Major version**. The leftmost number. For example, the 1 in 1.0.0. A change to this number means that you can expect breaking changes in code. You might need to rewrite part of your code.
- **Minor version**. The middle number. For example, the 2 in 1.2.0. A change to this number means that features have been added. Your code should still work. It's generally safe to accept the update.
- **Patch version**. The rightmost number. For example, the 3 in 1.2.3. A change to this number means that a change has been applied that fixes something in the code that should have worked. It should be safe to accept the update.

This table illustrates how the version number changes for each version type:

|Type              | What happens          |
|------------------|----------------------|
|Major version     | 1.0.0 changes to 2.0.0 |
|Minor version     | 1.1.1 changes to 1.2.0 |
|Patch version     | 1.0.1 changes to 1.0.2 |

## Update a package by using npm

There are two ways to install a package. You can use either the `install` command or the `update` command. At one time, there were differences between these two commands, but now they act more like aliases for one another. A typical command to update a package might look like this one: `npm update <name of package>@<optional argument with version number>`.

What happens at this point depends on two things:

- **Whether the version argument is specified as part of the command**. If the version argument (the last argument) is specified, that particular package version is fetched and installed.
- **The entry in the manifest file**. The entry in the manifest file includes the name of the dependency and a value that expresses a rule pattern for how the dependency will be updated. Here's an example: `"<name of dependency>": "1.1.x"`. The npm tool will respect the rule pattern and try to fetch the version of the dependency that matches the rule pattern.

### Update approach

As a Node.js developer, you can communicate to Node.js the update behavior you want. Think about updating in terms of risk. Here are some approaches:

- **Major version**. I'm OK with updating to the latest major version as soon as it's out. I accept the fact that I might need to change code on my end.
- **Minor version**. I'm OK with a new feature being added. I'm not OK with code that breaks.
- **Patch version**. The only updates I'm OK with are bug fixes.

If you're managing a new or smaller Node.js project, you can afford to be loose with how you define the update strategy. For example, you could always update to the latest version. For more complex projects, there's a bit more nuance, but we'll save that for a future module.

In general, the smaller the dependency you're updating, the fewer dependencies it has and the more likely that the update process will be easy.

### Configure the package.json for update

Before you update one or more dependencies, you should configure your manifest file so that you get predictable behavior when you run the `npm update <name of dependency>` command. You can communicate the approach you want to take for a package. Node.js has a set of symbols that allows you to define how you want your packages to update.

The process is to add different prefixes to your package entries in the package.json file. There are many things you can configure in addition to major/minor/patch version. You can also express that you want packages within only a certain range, or that you want packages that have a certain tag, like `alpha` or `beta`.

Here are some patterns that you can configure for major/minor/patch version:

- `~` or `1.1.x`. This instruction will update to the latest patch version. If you want only the patch version to update, specify `~1.0.0`. This instruction says "equal to or greater than in the same range."
- `^` or `1.x.1`. This instruction will update to only the minor version.
- `*` or `x.0.0`. This instruction will update to the highest major version.

## package-lock.json

In addition to the package.json manifest file, you also have the package-lock.json file. The latter is generated when you do something that modifies the node_modules directory or anything that changes the dependencies in package.json. So it won't be created when you run `npm init`, but it will be created when you install a package, for example.

This file should be committed to your repository. 

One reason to commit this file to your repository is that it guarantees exact installations. Remember how in package.json you define patterns for the types of installations you want, like patches, minor versions, or major versions? Patterns aren't exact. You won't know if you installed, for example, version 1.4 or 1.5 if you're using a `1.x` pattern. 

And you might need to know which version you installed. Imagine you specify `1.x`. You're using version 1.2, and a 1.4 version is released. The new version ends up breaking your code. Someone installing your app will get a non-functioning app at that point. But, if there's a `package-lock.json` file stating 1.2 was used, 1.2 will be installed. So, who cares about this behavior? People who use your app and CI (continuous integration) tools.

It's important to understand the process and which file determines when an installation occurs. 

It works like this: 
- If the package.json and the package-lock.json agree on a semantic-rule level, there's no conflict. For example, if the pattern says `1.x` in package.json and package-lock.json specifies that version 1.4 is installed, 1.4 will be installed. 
- But if the package.json specifies, for example, `1.8.x`, package-lock.json won't be obeyed. Version 1.8.0 or later will be installed, or a higher patch version if one is available.

The package-lock.json file also provides other features. For example, it makes it easy to see what has changed between commits and helps to optimize the installation process.

## Find and update outdated packages

The `npm outdated` command lists outdated packages. This command can help you learn when there are newer versions of packages available. Here's a typical output from the command:

```output
Package     Current  Wanted   Latest  Location
lodash        1.0.0   1.0.0  4.17.19  lock-test
node-fetch    1.2.0   1.2.0    2.6.0  lock-test
```

Here are the meanings of the names of the columns in the output:

- `Wanted`. The latest version that matches the semantic pattern you specified in the package.json file.
- `Latest`. The latest version of the package.
- `Location`. Where the dependency was found. The `outdated` command crawls through all installed packages in node_modules.

The recommended workflow is to run these commands, in this order:

1. Run `npm outdated`. This command lists all the outdated packages. It provides information in the `Wanted`, `Latest`, and `Location` columns.
1. Run `npm update <optional package name>`. If you run this command with a package name specified, the command will try to update only the specified package. If you don't specify a package, the command will try to update all the packages in package.json.

## Managing security issues

Every time you update or install a package, you'll get a log response just after the installation. The response tells you what version was installed and whether there are any vulnerabilities. A log might look like this example:

```output
+ lodash@1.3.1
added 1 package from 4 contributors and audited 1 package in 0.949s
found 3 vulnerabilities (1 low, 2 high)
  run `npm audit fix` to fix them, or `npm audit` for details
```

The preceding log lists vulnerabilities with severity levels of high and low. If you have any high-level vulnerabilities, you should update the package. To fix an issue and apply an update, you can run `npm audit`, as indicated in the preceding log response. Doing so lists each vulnerability. A response from `npm audit` might look like this example:

```bash
# Run  npm install lodash@4.17.15  to resolve 3 vulnerabilities

| Low            | Prototype Pollution               |
|----------------|-----------------------------------|
| Package        | lodash                            |
| Dependency of  | lodash                            |
| Path           | lodash                            |
| More info      | https://npmjs.com/advisories/577  |  

and so on..
```

The `npm audit fix` command tries to fix the problem. It tries to upgrade to a minor version for which the problem doesn't exist. That action might not be enough. The command might prompt you to run `npm audit fix --force` to fix the problem. This action involves a breaking change. That is, the major version of your package will be updated.

A *vulnerability* is a weakness in code that attackers can exploit to commit malicious actions. Attackers can use these weaknesses to gain access to your data and your systems. You should take vulnerabilities seriously.

Vulnerabilities are discovered all the time. They're so common that GitHub has implemented a function that scans repos and automatically creates PRs suggesting that you upgrade to a safer version if it finds a vulnerability. You should run the audit command `npm audit` occasionally. Safety is everyone's job. A large repo provider like GitHub does its part. You can do your part by auditing and fixing vulnerabilities if you find any.
