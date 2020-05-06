Now that we have 

## C# Code-behind in Blazor 

Code-behind is a common term for the technique of using a separate code file to that represents all of the logic for a corresponding page, view, or component. Creating a code-behind in Blazor requires a few steps, but thankfully it's supported by the framework so setup is quite simple. To complete our code-behind we'll need to create a class and then link the code-behind to our markup. Once we have the structure in place, we can move over our existing logic.

Creating and Linking a Code-Behind
First we'll need a class file that will represent our code-behind. This is a standard .NET class, however naming is very important. When we create our code-behind file we need to consider both the file name and class name as they can greatly effect our developer experience.

## Blazor markup

### C# in razor using the @code markup

## Event Handling

You can handle client-side script events and route them to functions in your code.


## Blazor binding 



Notifying parent components when state changes
To fix this, we need to tell Blazor that the consuming page wants to use two-way binding. Instead of simply setting the CurrentCounterValue we now tell Blazor to bind (i.e. two-way bind) to the value instead. To use two-way binding on a parameter simply prefix the HTML attribute with the text @bind-. This tells Blazor it should not only push changes to the component, but should also observe the component for any changes and update its own state accordingly.

<MyFirstComponent @bind-CurrentCounterValue=currentCount/>
Note: The @ symbol is needed when assigning code values (rather than constants) to parameters. Previously our mark-up contained CurrentCounterValue=@currentCount, but once we prepend the parameter name with @bind- the @ symbol before currentCount becomes unnecessary.

Running the app now will show the following error in the browser’s console window.

