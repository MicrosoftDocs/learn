


The following code is one possible solution for the challenge from the previous unit:

```csharp
int fahrenheit = 94;
decimal celsius = (fahrenheit - 32m) * (5m / 9m);
Console.WriteLine("The temperature is " + celsius + " Celsius.");
```

The code above is "*one possible solution*" among many possible solutions. 

For example, the calculation does not have to be performed in a single line: 

```csharp
int fahrenheit = 94;

decimal celsius; // Using decimal type, not int

celsius = fahrenheit;
celsius -= 32;
celsius *= 5;
celsius /= 9;

Console.WriteLine($"The temperature is {celsius} Celsius.");
```

If you were successful, congratulations! Continue to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, maybe you should review the previous units before you continue on.
