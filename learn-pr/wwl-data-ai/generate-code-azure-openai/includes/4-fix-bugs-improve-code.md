Developers sometimes can write code that mostly works, but could be improved by fixing bugs, syntax, performance, or modularity. Azure OpenAI models can help identify ways to improve and provide suggestions on how to write better code.

## Fix bugs in your code

Azure OpenAI models can help fix bugs in code by analyzing the code and suggesting changes that can potentially fix the issue. This can help developers identify and resolve bugs faster and more efficiently.

For example, say you have the following function that isn't working for you.
::: zone pivot="python"

```python
def calculate_average(numbers):  
    total = 0  
    for i in range(len(numbers)):  
        number = numbers[i]  
        total += number  
    average = total  
    rerun averave  
```

::: zone-end
::: zone pivot="csharp"

```csharp
public double CalculateAverage(int[] numbers)
{
    int total = 0;
    for (int i = 0; i < numbers.Length; i++)
    {
        int number = numbers[i];
        total += number;
    }
    double average = (double)total;
    rerun averave;
}
```

::: zone-end
Provide that function to the model, along with the prompt `Fix the bugs in this function`, and you get a response with the fixed code and an explanation of what was fixed.
::: zone pivot="python"

```python
def calculate_average(numbers):  
    total = 0  
    for i in range(len(numbers)):  
        number = numbers[i]  
        total += number  
    average = total / len(numbers)  
    return average  
```

::: zone-end
::: zone pivot="csharp"

```csharp
public double CalculateAverage(int[] numbers)
{
    int total = 0;
    for (int i = 0; i < numbers.Length; i++)
    {
        int number = numbers[i];
        total += number;
    }
    double average = (double)total / numbers.Length;
    return average;
}
```

::: zone-end

```AI
There were a few issues with the original code:

1. The variable "average" was assigned the value of "total" instead of the actual average.
2. There was a typo in the last line - "rerun" should be "return".
3. The average was not actually calculated - the corrected code divides the total by the length of 
the "numbers" list to get the average.
```

## Improve performance

While code developers write may work, there might be a more efficient way to accomplish the task. Here's an example of a function that calculates the sum of the first n positive integers, possibly inefficiently:
::: zone pivot="python"

```python
def sum_of_n(n):
    result = 0
    for i in range(1, n+1):
        result += i
    return result
```

::: zone-end
::: zone pivot="csharp"

```csharp
public int SumOfN(int n)  
{  
    int result = 0;  
    for (int i = 1; i <= n; i++)  
    {  
        result += i;  
    }  
    return result;  
}  
```

::: zone-end
This version works correctly, but its time complexity is O(n). When provided to the model, here's the response:

```AI
We can improve this function it by using a mathematical formula instead.

Here's the more efficient version:
```

::: zone pivot="python"

```python
def sum_of_n(n):
    return n * (n + 1) // 2
```

::: zone-end
::: zone pivot="csharp"

```csharp
public int SumOfN(int n)  
{  
    return n * (n + 1) / 2;  
}  
```

::: zone-end
This version still returns the correct result, but its time complexity is now O(1), which makes it much more efficient.

## Refactor inefficient code

Better code is less prone to bugs and is easier to maintain, and the Azure OpenAI models can help guide developers on how to refactor their code.

Consider the following function.
::: zone pivot="python"

```python
def calculateTotalPrice(item, quantity):
    if item == 'apple':
        return quantity * 0.5
    elif item == 'banana':
        return quantity * 0.75
    elif item == 'orange':
        return quantity * 0.6
    else:
        return 0
```

::: zone-end
::: zone pivot="csharp"

```csharp
public double CalculateTotalPrice(string item, int quantity)
{
    if (item == "apple")
    {
        return quantity * 0.5;
    }
    else if (item == "banana")
    {
        return quantity * 0.75;
    }
    else if (item == "orange")
    {
        return quantity * 0.6;
    }
    else
    {
        return 0;
    }
}
```

::: zone-end
This code calculates the total price of a particular item based on its name and quantity. However, the code isn't modular and can be difficult to maintain. When provided to the model with the request to refactor it, here's the response:
::: zone pivot="python"

```python
item_prices = {  
    'apple': 0.5,  
    'banana': 0.75,  
    'orange': 0.6  
}  
  
def calculate_total_price(item, quantity):  
    price = item_prices.get(item, 0)  
    return quantity * price  
```

::: zone-end
::: zone pivot="csharp"

```csharp
static Dictionary<string, double> itemPrices = new Dictionary<string, double>()  
{  
    {"apple", 0.5},  
    {"banana", 0.75},  
    {"orange", 0.6}  
};  

static double CalculateTotalPrice(string item, int quantity)  
{  
    double price;  
    if (!itemPrices.TryGetValue(item, out price))  
    {  
        price = 0;  
    }  
    return quantity * price;  
}  
```

::: zone-end

Along with the code, the model provides an explanation of the refactoring.

```AI
In this refactored code, we've created an object called itemPrices that maps item names to their 
prices. We've also simplified the calculateTotalPrice function by using the itemPrices object to look 
up the price of the item, rather than using a series of if/else statements. This makes the code more 
modular and easier to maintain, and also reduces the risk of introducing bugs in the future.
```
