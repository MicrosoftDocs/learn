

In this exercise, you'll learn about how to create a thread. You'll do so using C#'s implementation of threads that uses something called a Task. The syntax for creating a Task uses a Lambda expression. In C#, a Lambda expression is a short block of code that accepts parameters and returns a value. It's defined as an anonymous function (function without a name).

You begin by creating a boolean flag called `calculating` to tell you if a thread is already running or not. You then use it in an `if` statement, along with the `gameOver` and `IsMinNextReached`, to determine if it should create a new thread. If no Task is running, you create a Task in the form of a Lambda expression to calculate the new ant generation. Let's get started.

## Implement a boolean flag to start calculation in another thread

The first thing to do is to create the boolean variable called `calculating`.

1. Open the `GameBuffer.cs` file in your `WPF\Game` folder.

1. Add the `calculating` variable to your list of class variables, as shown here.

    ```csharp
    public class GameBuffer
    {
        private IGame initialState;
        private int nGenerations;
        private int minPrevious;
        private int minNext;
        private LinkedList<IGame> buffered = new LinkedList<IGame>();
        public LinkedListNode<IGame> currentNode;
        private bool gameOver;
        private bool calculating;
    
        ...
    }
    ```

1. Add `calculating` to this `if` statement.

    ```csharp
    // before
    if(!gameOver && IsMinNextReached())
    
    // after
    if(!calculating && !gameOver && IsMinNextReached())
    ```

> [!NOTE]
> Be sure to precede your `calculating` variable with an exclamation point (`!`), indicating the `not` condition. You dont want to execute a new Task if there is already a Task running.

## Calculate the new ant generation in another thread

When creating a Thread, you can do so manually, or use the ThreadPool class or, as you're doing here, use Task with the TaskCreationOptions.LongRunning option. You use a Task in a Lambda expression as shown here.

```csharp
_ = Task.Factory.StartNew(() => 
{
    // ... the ahead-of-time calculation code ...
}, TaskCreationOptions.LongRunning);
```

1. Replace the code in the `if(!calculating && !gameOver && IsMinNextReached())` statement with the Lambda expression.

    ```csharp
    if (!calculating && !gameOver && IsMinNextReached())
    {
        _ = Task.Factory.StartNew(() =>
        {

        }, TaskCreationOptions.LongRunning);
    }
    ```

1. Copy the old code into the Lambda expression.

    ```csharp
    if (!calculating && !gameOver && IsMinNextReached())
    {
        _ = Task.Factory.StartNew(() =>
        {
            gameOver = !CalculateNGenerations(nGenerations - minPrevious - minNext);
        }, TaskCreationOptions.LongRunning);
    }
    ```

## Change the value of the calculating flag

Assign `true` to `calculating` immediately after entering the `if` condition. Assign false to `calculating`, when calculation is finished in the computation thread. The `calculating` boolean tells you if you need to create a new Task.

1. Add `calculating = true;` before the Task.

    ```csharp
    if (!calculating && !gameOver && IsMinNextReached())
    {
        calculating = true;
        _ = Task.Factory.StartNew(() =>
        {
            gameOver = !CalculateNGenerations(nGenerations - minPrevious - minNext);
        }, TaskCreationOptions.LongRunning);
    }
    ```

1. Add `calculating = false;` as the last statement inside the Task.

    ```csharp
    if (!calculating && !gameOver && IsMinNextReached())
    {
        calculating = true;
        _ = Task.Factory.StartNew(() =>
        {
            gameOver = !CalculateNGenerations(nGenerations - minPrevious - minNext);
            calculating = false;
        }, TaskCreationOptions.LongRunning);
    }
    ```

## Check your work

Build and run the project. Make sure that the UI doesn't freeze when calculating generations ahead of time. Try calculating multiple generations, passing a different `n` value to the `GameBuffer.MoveNext` call. Doing so lets you "replay" different Ant rules to quickly see the progression over many generations.

1. Select View --> Terminal from the menu.

1. Enter dotnet build and press Enter.

1. Enter dotnet run to run your code.