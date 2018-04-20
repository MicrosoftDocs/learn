Did you come up with something like this?

```csharp
int sum = 0;
for (int number = 1; number < 21; number++)
{
    if (number % 3 == 0)
    {
    sum = sum + number;
    }
}
Console.WriteLine($"The sum is {sum}");
```

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).