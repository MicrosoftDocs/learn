Testing can be a powerful tool to improve the quality, architecture, and overall health of a code base. You'll find many strong examples of the positive impact of testing across the software industry.

- **Validating code changes and quality**. Software grows over time when changes in requirements lead to more features or altered behavior. To ensure you still have working software with all these changes, you need tests to validate and to maintain quality.
- **Industry examples**. There are many large pieces of software out there like compilers or tools like Visual Studio that run many tests and test scenarios. To ensure reliability, running and maintaining tests is crucial.
- **Testing effects on architecture**. Testing is an important forcing function on architecture. It makes you consider things such as duplication or whether a piece of code can be tested with its current architecture.
- **Code coverage and code health**. Many programs run business critical scenarios. By looking at code coverage, you have a sense of how well parts of your code are covered by testing. You want good coverage on the most important scenarios.

## Validating code changes and quality

Any successful software tends to grow in functionality and behavior. Sometimes it can grow beyond what the first creators ever imagined to support more scenarios and customer requests. As functionality grows, it can become more difficult for a single developer to remember all the functionality it contains or keep track of how to preserve that functionality.

Tests not only keep track of the different capabilities of a program, but tests can also continue to check the old functionality didn't break as new code is added. A fundamental purpose of testing is validating that code changes don't break existing functionality and provide a way of ensuring that newly added code will continue to work as expected even with future changes.

:::image type="content" source="../media/test-quality-cycle.png" alt-text="A circular graphic showing steps. The steps include add new functionality, test, catch bugs, fix bugs, release, get feedback, and repeat.":::

Tests can help catch bugs before you even check in your code changes. It's best practice to run tests before major steps in your development cycle. This final check allows you to improve your code quality so your users don't have to report that something broke in your latest update. It's much nicer to catch bugs while you're still developing the code rather than when you're in the middle of deploying your app or when the app is in production with customers using it! Catching bugs early in the development cycle saves time and money.

## Industry examples

A good example of the power of testing can be found in the C# compiler itself! Millions of developers write code in C# every day. Have you ever wondered how tools can keep adding language features and releasing new language versions without breaking existing code? Tests provide a final set of hundreds of thousands of checks to make sure previous scenarios still work. There is no way one person, or even one team could remember all those scenarios. This is especially true when you consider the C# compiler is [open source](https://github.com/dotnet/roslyn) and accepts contributions from a world-wide community of developers. The C# compiler team can accept changes from the community with confidence, in part, because of the checks that testing provides. Testing is helpful for individuals and at the team-level, allowing you to scale your product and your team as they grow.

## Testing effects on architecture

Testing can also force some architecture improvement. You can't unit test your code if it's structured as one gigantic method. Tests can help you break up all the functions of your code into more modular components. This can reduce repetition, improve stability, and even make your code easier to read and navigate. For example, if you are using the same logic in many places throughout your app and then realize there's a problem with it, you'll have to find and update all the places you used it. Instead, if you use a method, you only need to update it once, because even though that method is called many times throughout your app, you only wrote the logic once in the body of the method. Testing helps you pause and consider if you are repeating the same logic multiple times and could use a method instead. It provides developers a chance to restructure code for the best reusability and stability going forward.

## Code coverage and code health

Code coverage is a metric indicating how much of an app's production code is covered by tests. It indicates if tests actually exercise all the product code, including branching logic, method overloads, and so on. Code coverage can give a basic idea of what areas need more testing. Visual Studio even has tools that can [highlight what lines are covered by tests](/visualstudio/test/using-code-coverage-to-determine-how-much-code-is-being-tested) and what aren't in your editor.

:::image type="content" source="../media/test-why-code-coverage.png" alt-text="Screenshot of code in the Visual Studio editor showing test coverage via red and blue highlights. Covered code is highlighted in blue and uncovered code is highlighted in red.":::

Tracking the code coverage percentage overtime can give you an idea if the new code being added to your repository has tests. If new code isn't being tested, it *may* be an indication the repository is building up technical debt. While code coverage is useful, it's *not* an ultimate indication of repo health. It should only be one of many factors used to assess the health of a repo. Different code coverage engines can calculate coverage differently and many programs may appear to have low coverage, despite being well tested. For example, heavily testing certain methods that have high use, and ignoring others may actually be the right thing to do for a given repo. We wouldn't encourage every repo to try to achieve 100% code coverage because that isn't a practical investment for many businesses. There's much debate if there's a universal code coverage percentage that repositories should aspire too, but we believe for now the best guidance is to judge on a case-by-case basis and not arbitrarily hold your team to a number without a deeper discussion.
