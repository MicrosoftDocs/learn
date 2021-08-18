

## Add more tests

1. The code below demonstrates a simple test for inputting two numbers into the `Add` method and asserting a result. Can you create similar tests for the `Subtract`, `Multiply`, and `Divide` methods?

```csharp
[TestMethod]
public void AddTest()
{
    // Arrange
    var calculator = new Calculator();

    // Act
    var actual = calculator.Add(1, 1);

    // Assert
    Assert.AreEqual(2, actual);
}
```

Now that you are accumulating a test suite, let's learn more about managing multiple tests with the Visual Studio Test Explorer.


## Filter to failing tests
. Try filtering to show only failed tests.

## use the groupby
 Try a new grouping by de-selecting the presets and only grouping by Project and Namespace. 

## Debug a test
* Set a breakpoint in one of the tests you have created by clicking in the margin of the code editor.
* Right-click inside of the test in the code editor and select 'Debug Test.' 