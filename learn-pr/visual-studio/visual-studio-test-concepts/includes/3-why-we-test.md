Testing can be a powerful tool to improve the quality, architecture, and overall health of a code base. In this unit, we discuss some of the ways that testing can have a positive impact in the software industry.

## Validate code changes and quality

Any successful software tends to grow in functionality and behavior. Sometimes it can grow beyond what the creators ever imagined to support more scenarios and customer requests. As functionality grows, it can become more difficult for a single developer to remember all the functionality it contains or keep track of how to preserve that functionality.

Tests not only keep track of the different capabilities of a program, but can also continue to check that the old functionality didn't break as new code is added. A fundamental purpose of testing is validating that code changes don't break existing functionality, and ensuring that newly added code will continue to work as expected even with future changes.

:::image type="content" source="../media/test-quality-cycle.png" alt-text="A circular graphic showing steps. The steps are: add new functionality, test, catch bugs, fix bugs, release, get feedback, and repeat.":::

Tests can help catch bugs before you even check in your code changes. It's a best practice to run tests before major steps in your development cycle. This final check allows you to improve your code quality so your users don't have to report that something broke in your latest update. It's much nicer to catch bugs while you're still developing the code, rather than when you're in the middle of deploying your app or when the app is in production with customers using it! Catching bugs early in the development cycle saves time and money.

## Industry examples

A good example of the power of testing can be found in the C# compiler itself! Millions of developers write code in C# every day. Have you ever wondered how tools can keep adding language features and releasing new language versions without breaking existing code? Tests provide a final set of hundreds of thousands of checks to make sure previous scenarios still work. There's no way one person, or even one team could remember all those scenarios.

It's especially true when you consider that the C# compiler is [open source](https://github.com/dotnet/roslyn), and accepts contributions from a world-wide community of developers. The C# compiler team can accept changes from the community with confidence, in part because of the checks that testing provides. Testing is helpful for individuals and at the team level, allowing you to scale your product and your team as they grow.

## Effects on architecture

Testing can also force some architecture improvement. You can't test small parts of your code if it's structured as one gigantic method. Tests can help you break up all the functions of your code into more modular components. Tests can reduce repetition, improve stability, and even make your code easier to read and navigate.

For example, if you're using the same logic in many places throughout your app and then realize there's a problem with it, you'll have to find and update all the places you used it. Instead, if you use a method, you only need to update it once, because even though that method is called many times throughout your app, you only wrote the logic once in the body of the method.

Testing helps you pause and consider if you're repeating the same logic multiple times and could use a method instead. It provides developers a chance to restructure code for the best reusability and stability going forward.

## Code coverage and code health

Code coverage is a metric that indicates how much of an app's production code is covered by tests. It indicates if tests actually exercise all the product code, including branching logic and method overloads. Code coverage can give a basic idea of what areas need more testing. Visual Studio even has tools that can [highlight what lines are covered by tests](/visualstudio/test/using-code-coverage-to-determine-how-much-code-is-being-tested), and what lines aren't, in your editor.

:::image type="content" source="../media/test-why-code-coverage.png" alt-text="Screenshot of code in the Visual Studio editor showing test coverage via red and blue highlights. Covered code is highlighted in blue and uncovered code is highlighted in red.":::

Tracking the code coverage percentage over time can give you an idea if the new code being added to your repository has tests. If new code isn't being tested, it might be an indication that the repository is building up technical debt. While code coverage is useful, it's *not* an ultimate indication of repo health. It should only be one of many factors used to assess the health of a repo.

Different code coverage engines can calculate coverage differently, and many programs can appear to have low coverage, despite being well tested. For example, heavily testing certain methods that have high use, and ignoring other methods, might actually be the right thing to do for a particular repo. We wouldn't encourage every repo to try to achieve 100 percent code coverage, because that isn't a practical investment for many businesses.

There's much debate about whether or not there's a universal code coverage percentage that repositories should aspire to. For now, we believe the best guidance is to judge on a case-by-case basis, and not arbitrarily hold your team to a number without a deeper discussion.
