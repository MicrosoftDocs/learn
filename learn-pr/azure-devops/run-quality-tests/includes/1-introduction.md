OK, so far you've connected your app on GitHub to an Azure pipeline. You can push changes, get review feedback, and publish artifacts.

But as you add features to your app, how do you _know_ whether that features works correctly given all inputs? How do you know that it works well with - and doesn't break - other features? How do you know that your code is maintainable and can be easily understood by others?

You _could_ run the app locally and try a few inputs. But that takes time and doesn't cover all cases. Plus, it gets tedious as you add features.

Here, you'll learn how to set up automated testing to help ensure that your latest feature will work, and to help make sure you didn't break anything along the way.

-----

(Before we start - after thinking about this module, [I looked at the documentation](https://docs.microsoft.com/azure/devops/test/index-tp?view=azdevops). They place heavy emphasis on manual & exploratory testing, which I'd like to avoid. The "Continuous testing" link goes to a [very specific anchor](https://docs.microsoft.com/azure/devops/pipelines/languages/dotnet-core?view=azdevops&tabs=yaml#run-your-tests), and "Unit and functional testing" links out to the [Visual Studio 2017 docs](https://docs.microsoft.com/visualstudio/test/unit-test-your-code?view=vs-2017).

Overall, I get lost pretty quickly.

That said, my initial thinking is outlined here. But we should vet that that's a good plan and squares with what we want to tell customers.
)