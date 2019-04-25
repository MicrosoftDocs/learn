This module is about how to add automated tests to your build pipeline.

As you add a feature to your app, how do you _know_ whether those features work correctly, given all possible inputs? How do you know that the feature works well with &mdash; and doesn't break &mdash; other features? How do you know that your code is maintainable and can be easily understood by others?

You _could_ run the app locally and try a few inputs. But that takes time and doesn't cover all cases. Plus, repeatedly testing existing features gets tedious as you add new features.

In this module, you'll learn how to set up automated testing to help ensure that your latest feature will work, and to help make sure you didn't break anything along the way.

In this module, you will:

* Describe the benefits of automated testing and the kinds of testing you can use
* Run unit tests locally and then in your build pipeline
* Add dashboard widgets to visualize test runs over time
* Perform code coverage testing to see how much of your code is covered by unit tests
* See a test fail in the pipeline and then fix the failure
