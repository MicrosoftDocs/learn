# Sharpen your test writing skills

* You can brush up on different types of tests and more testing concepts in the [Testing concept learning module](../../visual-studio-test-concepts/resources/design-doc.md).
* There are many tools out there to help you write good tests that help make your tests easy to understand, avoid repetition, and help you test any architecture. Let's go over some popular ones and their advantages.

## Fluent Assertions

[Fluent assertions](https://fluentassertions.com/) is a popular set of extension methods provided by the .NET community that can help you clearly identify your assertion methods. It uses more human-readable language making it easier to write and read tests.

```csharp
    using FluentAssertions;

    // Check if a string begins, ends, or contains a particular phrase
    string actual = "ABCDEFGHI";
    actual.Should().StartWith("AB").And.EndWith("HI").And.Contain("EF").And.HaveLength(9);
```

![image](../media/test)

## Data driven tests

[Data driven tests](https://docs.microsoft.com/visualstudio/test/how-to-create-a-data-driven-unit-test) (also known as parameterized testing or DDT) allows you to run the same test method a number of times with a variety of parameters. This allows you to avoid repetition in your code while also checking the same function with a whole set of different data inputs. You can input data in-line as shown in the example below or even connect to a database the get input.

```csharp
[DataTestMethod]
[DataRow(1, 1, 2)]
[DataRow(2, 2, 4)]
[DataRow(3, 3, 6)]
[DataRow(0, 0, 1)] // The test run with this row fails
public void AddDataTests(int x, int y, int expected)
{
    Assert.AreEqual(expected, x + y);
}
```

## Mocking

Sometimes the architecture of your code is not as modular as you may want in order to unit test it well. In order to isolate the parts of your code that you are testing without re-writing it you may want to use a mocking framework. Mocking helps you isolate the code you are trying to test by creating stubs or shims of that code dependencies. This allows the code you are testing to make the required calls to its dependencies without actually testing the dependencies. This helps you focus a unit test down to precisely the behavior you want to test. There are many popular mocking frameworks available including [MOQ](https://github.com/Moq/moq4/wiki/Quickstart) and [Microsoft Fakes](https://docs.microsoft.com/visualstudio/test/isolating-code-under-test-with-microsoft-fakes).

![image](../media/)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->