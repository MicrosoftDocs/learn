There are many reasons you might be interested in starting testing:

- **Educational purposes**: Perhaps your manager, mentor, or professor just asked you to add tests to your code.
- **Improving code quality**: Your company is interested in improving code quality and catching bugs faster.
- **Peer discussion**: Another developer asked what your code coverage is like in a discussion on code quality.
- **Changing requirements**: The behavior of your app is growing quickly, and you need a formal way to capture and check all functionality as your project continues to scale.

This learning module covers why we test, and provides a brief introduction to best practices for testing software. We'll go over different types of testing, starting at the most fundamental level, unit tests. We'll also touch on various schools of thought around testing.

There are lots of testing technologies out there, but no matter your language or software stack, this guidance should help you grasp the basic concepts and help you avoid common pitfalls.

If you want to get started testing right away, see [C# testing in Visual Studio](/learn/modules/visual-studio-test-tools/). You can dive right into writing and running tests. If you prefer to learn with a command-line interface see [Unit testing C# with MSTest and .NET](/dotnet/core/testing/unit-testing-with-mstest).

:::image type="content" source="../media/test-intro-collage.png" alt-text="Collage showing screenshots of test features in Microsoft tools, including Visual Studio and Azure DevOps.":::

## Example scenario

Suppose you're building a website that allows users to shop your products online, and you need to start selling internationally. You've extended the phone numbers in your customer information logic to accept international numbers. You've checked your code with several international numbers, and you think it's ready to push your changes and update your app.

After just a few hours, you've started getting calls from customer service that new numbers in your database have stopped working! It looks like your new behavior caused a bug that broke the way the domestic phone numbers are saved to your database.

You quickly see the mistake. All newly added domestic numbers accidentally have the country code added twice! As you think back, you realize you had changed all new numbers inserted into your database to append country codes, but the domestic function had also been doing that already.

Tests could have helped you catch that change in functionality earlier by making sure the new functionality doesn't regress old functionality.

## What will we be doing?

We'll learn the capabilities of tests, and help you decide when to use different types of tests and different schools of thought:

- **Identify**: what can testing help you achieve?
- **Choose**: what types of tests will help you achieve your goal?
- **Exercise**: what testing schools of thought will your team follow to improve testing habits?

## What is the main goal?

By the end of this module, you'll be able to evaluate how testing can improve your code quality. You'll also be able to describe how different types of testing, the testing pyramid, and different testing schools of thought answer the demands of modern development.
