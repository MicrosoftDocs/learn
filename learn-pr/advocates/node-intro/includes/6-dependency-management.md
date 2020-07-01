Sooner or later you will want to update to a new version of a library. The reason can be that some function is marked as deprecated or that there's a new feature in a later version of a package you are using. 

There are considerations that should be taken into account prior to attempt to update a library, namely:

- **The type of update**, what type of update is available, is it a small bug fix? Is it adding a new feature I need or will it break my code? A way to communicate what type of update that takes place is by adhering to a system called Semantic versioning. Based on how the version number of the library is expressed it communicates to a developer what type of update they are dealing with.
- **Is my project configured correctly**, you can configure your Node.js project in a way so that you only get the types of updates you want. That means you will only perform an update if a specific type of update is available. It's a recommended approach as you don't risk running into surprises.
- **Mitigate issues**, part of managing your project dependencies over time means being aware of that issues might occur. Issues arise as vulnerabilities are detected for example. Hopefully patches will be released that you can download. The NPM executable helps you run an *audit* on your libraries to find out if you have packages that should be updated and the executable also helps you with the appropriate action to fix the issue.

## Semantic versioning

There's an industry standard called semantic versioning. It's a system  adopted by numerous companies and developers. If you mean to publish packages and push them to the NPM registry you should definitely follow semantic versioning as this is expected. Even if you only download packages from the NPN registry you can expect these packages to follow semantic versioning.

So why is it such a big deal? Changes to a package is about introducing risk, risk that a bug is introduced, that can harm your business. A risk that you as a consumer needs to rewrite part of your code, fixing that takes time and time is money.  

Semantic versioning is how you express what type of change you or some other developer is introducing to a library. How semantic versioning works is by ensuring a package has a version number and that the version number is divided up into the following sections:

- **major version**, the leftmost number e.g `1` in `1.0.0`, changing major version means that we can expect breaking changes in the code. Many things have changed.
- **minor version**, the middle number e.g `2` in `1.2.0`, means features have been added. Your code should still be working. It's generally safe to update minor version.
- **patch version**, the rightmost number e.g `3` in `1.2.3`, means a fix has been applied that fixes something in the code that should have worked. It should be safe to update patch version.

Below is a table showing different types and what number changes in what position.

|Type              | What happens          |
|------------------|----------------------|
|Major version     | 1.0.0 going to 2.0.0 |
|Minor version     | 1.1.1 going to 1.2.0 |
|Patch version     | 1.0.1 going to 1.0.2 |

## Updating a package

There are two ways to install a package, you can either use the `install` command or the `update` command. Historically there used to be differences between the two commands but now they act more like aliases for one another. A typical command to update could therefore look like so `npm update <name of dependency>@<optional argument with version number>`.

What happens at this point is depends on two things:

- **The version argument is specified**, if the version argument (the last argument) is specified that particular package version will be fetched and installed.
- **There is an entry in the manifest file**, the entry in the manifest file consist of the name of the dependency plus a value expressing a rule pattern for how this dependency will be updated. Here's how it can look `"<name of dependency>": "1.1.x"`. NPM will respect the rule pattern and try to fetch the version of the dependency that matches the rule system.

### Update approach

How do we approach updating as Node.js developers? We can communicate to Node.js what behavior we want. We want to think about updating in terms of risk. You could reason like this:

- **Upgrade major version**, I'm ok to update to the latest major version as soon as it's out then I accept the fact that I might need to change code on my end.
- **Minor version**, I'm ok with a new feature being added. I'm not ok with code that breaks.
- **Patch version**, the only thing I'm ok with are bug fixes.

If you are in a completely new or smaller Node.js project you can afford to be quite loose with how you define the update strategy and for example allow to always update to the latest and greatest version. For more complex projects there is a bit more nuance but we'll save that for a future module.

As a general guidance though, the smaller the dependency you are trying to update is the fewer dependencies it has in turn and the more likely it is that the update process is going to be easy.

### Configure the `package.json` for update

Before you go on an update one or many dependencies you want to configure your manifest file in a way so that it's predictable what will happen if you run the `npm update <name of dependency>` command. You can communicate what approach you want to take for a package. Node.js has a set of symbols that allows us to define how we want our packages to update.

What we do is add different prefixes to our package entries in the `package.json` file. There's a lot of things you an configure for apart from major/minor/patch version. It's also possible to express that you want packages within a certain range only or that you want a package with a certain tag like `alpha` or `beta` for example.

Here are some patterns to configure for major/minor/patch version:

- `~` or `1.1.x`, this instruction will update to the latest patch version. If you only want the patch version to update, you would specify like this `~1.0.0`. What this instruction says is equal or great to in the same range.
- `^` or `1.x.1`, this instruction will update only the minor version.
- `*` or `x.0.0`, this instruction will update to the highest major version.

## Managing issues

Every time you update or install a package you will get a log response just after install. It will tell you what version it installed and also if there are any vulnerabilities. An example log can look like this:

```bash
+ lodash@1.3.1
added 1 package from 4 contributors and audited 1 package in 0.949s
found 3 vulnerabilities (1 low, 2 high)
  run `npm audit fix` to fix them, or `npm audit` for details
```

Above its listing vulnerabilities in different severity levels, high, and low. If you have any high-level vulnerability, you should update. To fix an issue and apply an update, you can run `npm audit` as indicated by above log response. Doing so lists each vulnerability. A response from `npm audit` can look like this:

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

The command `npm audit fix` attempts to fix the problem to a point. It tries to upgrade to a minor version where the problem no longer exists. That action may not be enough, it may tell you that you need to run `npm audit fix --force` to fix the problem. Such an action involves a breaking change i.e the major version of your package will be updated.

So what is a vulnerability? A Vulnerability is a weakness in the code that can be exploited to do malicious things. An attacker can use this weakness to gain access to your data and your systems. You should take a vulnerability seriously for that reason.

Vulnerabilities are discovered all the time. It's so common that GitHub spent time to implement a function that scans repos and automatically creates a PR on your repo with a suggestion to upgrade to a more safe version, if it finds vulnerability. You do best to run the audit command `npm audit` now and then. Safety is everyone's job. A large repo provider like GitHub does their part, you can do your part by auditing and fix the vulnerabilities if you discover any.
