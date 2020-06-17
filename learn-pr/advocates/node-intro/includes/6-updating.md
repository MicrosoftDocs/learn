
Sooner or later you will want to update to a new version of a library. The reason can be that some function is marked as deprecated or that there's a new feature in a later version of a package you are using. Regardless of which, there are things that's helpful to know when wanting to update. Things that might have consequences to whether your source code still works or not after an update of a package. 

## Semantic versioning

Your package has a version. It should follow something called semantic versioning. Semantic versioning means a version number can be divided up into the following sections:

1. major version, the left most number e.g `1` in `1.0.0`, changing major version means that we can expect breaking changes in the code. A lot of things have changed.
2. minor version, the middle number e.g `2` in `1.2.0`, this usually means features have been added. Your code should still be working. It's generally safe to update minor version.
3. patch version, the right most number e.g `3` in `1.2.3`, this means a fix has been applied that fixes something in the code that should have worked. It should be safe to update patch version.

Below is a table showing different types and what number changes in what position.

|Type              |What happens          |
|------------------|----------------------|
|Major version     | 1.0.0 going to 2.0.0 |
|Minor version     | 1.1.1 going to 1.2.0 |
|Patch version     | 1.0.1 going to 1.0.2 |

### Approach

How do we approach this as Node.js developers? We can communicate to Node.js what behavior we want. We want to think about this in terms of risk. You could reason like this:

- Upgrade major version, I'm ok to update to the latest major version as soon as it's out then I accept the fact that I might need to change code on my end.
- Minor version, I'm ok with a new feature being added. I'm not ok with code that breaks.
- Patch version, the only thing I'm ok with are bug fixes

### Set up approach

We can communicate what approach we want to take for a package. Node.js has a set of symbols that allows us to define how we want our packages to update.

What we do is add different prefixes to our package entry in the `package.json` file. The prefixes you can add are:

- `~` or `1.1.x`, this will update patch version. If you only want the patch version to update you would specify like this `~1.0.0`. What this says is equal or great to in the same range.
- `^` or `1.x.1`, this will update only the minor version. This says equal to or greater in the same range.
- `*` or `x.0.0`, this will update to the highest major version.
- `>` or `<`, larger/less than, `< 3`. Will install the latest major version available e.g `2.1.1`.
- `-`, range `1.0.0 - 1.5.0`, will only install a version in this range, e.g `1.3.1` if that's the highest version on that range.
- `1.0.0-rc.1`, include pre-release versions like `1.0.0-alpha` and `1.0.0-alpha`.
- `^1 <1.4 || > 1.5`, will install the highest minor version in the range `1 - 1.3` or anything larger than `1.5`.

### When to update and how to fix issues

Every time you update or install a package you will get a log response just after install. It will tell you what version it installed and also if there are any vulnerabilities. An example log can look like this:

```bash
+ lodash@1.3.1
added 1 package from 4 contributors and audited 1 package in 0.949s
found 3 vulnerabilities (1 low, 2 high)
  run `npm audit fix` to fix them, or `npm audit` for details
```

Above it's listing vulnerabilities in different severity levels, high and low. If you have any high level vulnerability you should update. To fix this we can run `npm audit` as indicated by above log response. Doing so lists each vulnerability. A response from `npm audit` can look like this:

```bash
# Run  npm install lodash@4.17.15  to resolve 3 vulnerabilities

| Low           | Prototype Pollution              |
|---------------|----------------------------------|
|Package        |lodash                            |
|Dependency of  |lodash                            |
|Path           |lodash                            |
|More info      |https://npmjs.com/advisories/577 |  

and so on..
```

The command `npm audit fix` attempts to fix the problem to a point. It tries to upgrade to a minor version where the problem no longer exist. That may not be enough, it may tell you that you need to run `npm audit fix --force` to fix the problem. Such an action involves a breaking change i.e the major version of your package will be updated.
