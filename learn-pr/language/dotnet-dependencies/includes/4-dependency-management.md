Sooner or later, you'll want to update to a new version of a library. Maybe a function is marked as deprecated. Or maybe there's a new feature in a later version of a package you're using. 

There are some considerations that you should take into account before you try to update a library:

- **The type of update**. What type of update is available? Is it a small bug fix? Is it adding a new feature you need? Will it break your code? You can communicate the type of update by using a system called *semantic versioning*. The way the version number of the library is expressed communicates to developers the type of update they're dealing with.
- **Whether the project is configured correctly**. You can configure your .NET project so that you get only the types of updates you want. You'll only perform an update if a specific type of update is available. We recommend this approach because you don't risk running into surprises.
- **Security problems**. Managing your project dependencies over time involves being aware of problems that might occur. Problems arise as vulnerabilities are detected, for example. Ideally, patches will be released that you can download. The dotnet tool helps you run an *audit* on your libraries to find out if you have packages that should be updated. It also helps you take the appropriate action to fix a problem.

## Use semantic versioning

There's an industry standard called *semantic versioning*. Semantic versioning is how you express the type of change that you or some other developer is introducing to a library. Semantic versioning works by ensuring a package has a version number and that the version number is divided up into these sections:

- **Major version**. The leftmost number. For example, the 1 in 1.0.0. A change to this number means that you can expect breaking changes in code. You might need to rewrite part of your code.
- **Minor version**. The middle number. For example, the 2 in 1.2.0. A change to this number means that features have been added. Your code should still work. It's generally safe to accept the update.
- **Patch version**. The rightmost number. For example, the 3 in 1.2.3. A change to this number means that a change has been applied that fixes something in the code that should have worked. It should be safe to accept the update.

This table illustrates how the version number changes for each version type:

|Type              | What happens          |
|------------------|----------------------|
|Major version     | 1.0.0 changes to 2.0.0 |
|Minor version     | 1.1.1 changes to 1.2.0 |
|Patch version     | 1.0.1 changes to 1.0.2 |

Ths is a system adopted by many companies and developers. If you intend to publish packages and push them to the NuGet registry, you should follow semantic versioning. It's expected. Even if you only download packages from the NuGet registry, you can expect these packages to follow semantic versioning.

Changes to a package can introduce risk. Risk that a bug that could harm your business could be introduced. Risk that you might need to rewrite part of your code. Rewriting code takes time and costs money.  

### Update approach

As a .NET developer, you can communicate to .NET the update behavior you want. Think about updating in terms of risk. Here are some approaches:

- **Major version**. I'm OK with updating to the latest major version as soon as it's out. I accept the fact that I might need to change code on my end.
- **Minor version**. I'm OK with a new feature being added. I'm not OK with code that breaks.
- **Patch version**. The only updates I'm OK with are bug fixes.

If you're managing a new or smaller .NET project, you can afford to be loose with how you define the update strategy. For example, you could always update to the latest version. For more complex projects, there's a bit more nuance, but we'll save that for a future module.

In general, the smaller the dependency you're updating, the fewer dependencies it has and the more likely that the update process will be easy.

### Configure the project file for update

When adding one or more dependencies, you should think about configuring your project file so that you get predictable behavior when you restore, build, or run your project. You can communicate the approach you want to take for a package. NuGet has the concept of version ranges and floating versions that help to reduce changes to your project file, while keeping up to date with the latest version of a dependency.

Let's first talk about version ranges. This is special notation that is used for specifying specific version ranges that you would like to have resolved.

|Notation  | Applied rule | Description          |
|----------|--------------|----------------------|
|1.0       | x >= 1.0     | Minimum version, inclusive |
|(1.0,)    | x > 1.0      | Minimum version, exclusive |
|[1.0]     | x == 1.0     | Exact version match        |
|(,1.0]    | x ≤ 1.0      | Maximum version, inclusive |
|(,1.0)    | x < 1.0      | Maximum version, exclusive      |
|[1.0,2.0] | 1.0 ≤ x ≤ 2.0| Exact range, inclusive |
|(1.0,2.0) | 1.0 < x < 2.0| Exact range, exclusive |
|[1.0,2.0) | 1.0 ≤ x < 2.0| Mixed inclusive minimum and exclusive maximum version |
|(1.0)     | invalid      | invalid        |

NuGet also supports using a floating version notation, *, for Major, Minor, Patch, and pre-release suffix parts of the number. For example, 6.0.*. This version specification says "use the latest 6.0.x version"; 4.* means "use the latest 4.x version." Using a floating version reduces changes to the project file, while keeping up to date with the latest version of a dependency.

> [!NOTE]
> We recommend installing a specific version instead of using any of the floating notations. That ensures your builds are repeatedable unless you explicitly request an update to a dependency.

When using a floating version, NuGet resolves the highest version of a package that matches the version pattern, for example 6.0.* gets the highest version of a package that starts with 6.0:

:::image source="../media/floating-version.png" alt-text="Screenshot of choosing version 6.0.1 when a floating version 6.0.* is requested":::

Here are some examples that can configure for major/minor/patch version:

```xml
<!-- Accepts any version 6.1 and above. -->
<PackageReference Include="ExamplePackage" Version="6.1" />

<!-- Accepts any 6.x.y version. -->
<PackageReference Include="ExamplePackage" Version="6.*" />
<PackageReference Include="ExamplePackage" Version="[6,7)" />

<!-- Accepts any version above, but not including 4.1.3. Could be
     used to guarantee a dependency with a specific bug fix. -->
<PackageReference Include="ExamplePackage" Version="(4.1.3,)" />

<!-- Accepts any version up below 5.x, which might be used to prevent pulling in a later
     version of a dependency that changed its interface. However, this form is not
     recommended because it can be difficult to determine the lowest version. -->
<PackageReference Include="ExamplePackage" Version="(,5.0)" />

<!-- Accepts any 1.x or 2.x version, but not 0.x or 3.x and higher. -->
<PackageReference Include="ExamplePackage" Version="[1,3)" />

<!-- Accepts 1.3.2 up to 1.4.x, but not 1.5 and higher. -->
<PackageReference Include="ExamplePackage" Version="[1.3.2,1.5)" />
```

## Find and update outdated packages

The `dotnet list package --outdated` command lists outdated packages. This command can help you learn when there are newer versions of packages available. Here's a typical output from the command:

```output
Top-level Package      Requested   Resolved   Latest
> Humanizer            2.7.*       2.7.9      2.8.26
```

Here are the meanings of the names of the columns in the output:

- `Requested`. The version or version range that you have specified.
- `Resolved`. The actual version that has been downloaded for the project that matches the version specified.
- `Latest`. The latest version available for update from NuGet.

The recommended workflow is to run these commands, in this order:

1. Run `dotnet list package`. This command lists all the outdated packages. It provides information in the `Requested`, `Resolved`, and `Latest` columns.
1. Run `dotnet add package <package name>`. If you run this command it will try to update to the latest version, optionally you can pass it `--version=<version number/range>`.
