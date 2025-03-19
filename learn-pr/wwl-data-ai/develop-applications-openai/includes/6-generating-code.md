One of the capabilities of Azure OpenAI models is to generate code from natural language prompts. Tasks can range from a simple one line command to a full application. The AI models can also edit and update provided code or previous responses to complete the requested task.

The examples in this unit are using `gpt-35-turbo`.

## Write functions

Azure OpenAI models can create functions and apps in several languages by just describing what you want. For example, given the prompt `write a function for binary search in python`, you likely receive a response with the function and an explanation of the code.

```code
Sure, here's an example implementation of binary search algorithm in Python:

def binary_search(array, target):  
    low = 0  
    high = len(array) - 1  
  
    while low <= high:  
        mid = (low + high) // 2  
        if array[mid] == target:  
            return mid  
        elif array[mid] < target:  
            low = mid + 1  
        else:  
            high = mid - 1  
  
    return -1  
 
This function takes in two arguments - an array of integers and a target integer that we want to search
for in the array. The function initializes two pointers - low and high - to the first and last indices
of the array, respectively.

Inside the while loop, the function calculates the middle index using integer division (//). If the 
middle element is equal to the target, the function returns the index of the middle element. If the 
middle element is less than the target, we update the low pointer to mid + 1. Otherwise, we update the 
high pointer to mid - 1. We continue these steps until we find the target or the pointers cross each 
other (i.e., low > high).

If the target is not found in the array, the function returns -1.

Note that the binary search algorithm assumes that the input array is sorted in ascending order. If 
the array is not sorted, the algorithm may not return the correct result.
```

The request can go further than functions, and request a series of functions or an entire app. The response provides a good starting point for the task you're trying to achieve.

## Change coding language

If you have code in one language, but need it in another, Azure OpenAI can translate that for you. For example, say you have this `print_squares` function in Python.

```python
def print_squares(n):  
    for i in range(1, n+1):  
        print(i**2)   
```

If you provide that code, along with the prompt `convert this code to C#`, you likely get something similar to the following function.

```csharp
public void PrintSquares(int n)  
{  
    for (int i = 1; i <= n; i++)  
    {  
        Console.WriteLine(i * i);  
    }  
}  
```

Notice the model understood the differences between how `for` loops and functions are defined in the different languages (including access modifiers in C#), and changed the code appropriately.

## Understand unknown code

Azure OpenAI models are helpful for understanding code that doesn't make sense, or may be in a language you aren't familiar with. For example, say you were given the following function (in a fictitious coding language!) and didn't know how to understand it.

```code
fn qzplv(n: i32, m: i32) -> i32 {
    if n == 0 {
        return m + 1;
    } else if m == 0 {
        return qzplv(n - 1, 1);
    } else {
        return qzplv(n - 1, qzplv(n, m - 1));
    }
}
```

When provided to the model, along with the prompt `could you explain what this code is doing?`, you get a response similar to the following:

```code
Sure, I'd be happy to explain what this code is doing!

This code is implementing the Ackermann function, which is a well-known mathematical function that 
grows very quickly in terms of computation time as its inputs increase. The function takes two integer 
arguments (n and m) and returns another integer.

Here's how the function works:
- If n is equal to 0, the function returns m + 1.
- If m is equal to 0, the function calls itself recursively with n - 1 and 1 as arguments.
- Otherwise, the function calls itself recursively with n - 1 and the result of calling itself with n 
and m - 1 as arguments.

The function is implemented in a way that is easy to understand and follow, but it has a very high 
computational complexity. In fact, it grows so quickly that it can't be computed for values of n and m 
greater than about 4 or 5.
```

Combining the explanation and translation into a language you're familiar with makes this functionality even more useful.

## Complete code and assist the development process

Azure OpenAI can assist developers in common software development tasks such as writing unit tests, completing partial code, commenting code, and generating documentation. Using AI assistance can enable developers to spend more time on complex programming and problem solving tasks.

Azure OpenAI models are capable of generating code based on comments, function names, and partially written code. The more context you can provide the model, the more accurate the response likely is.

For example, when given the following prompt:

```prompt
complete the following function  
"""  
# calculate the average of the numbers in an array, but only if they're even  
def 
```

The model takes the comments and start of the function definition, and complete it from whatever context it has.

Similar functionality can be seen by providing partial code to the model, without any comments. Take the following prompt for example.
::: zone pivot="python"

```prompt
complete the following code  
"""  
def func1(n)
  if n==0:
```

::: zone-end
::: zone pivot="csharp"

```prompt
complete the following code  
"""  
public int Func1(int n) {  
    if (n == 0) { 
```

::: zone-end
The AI model does its best to complete the function with the most likely completion of the function.
::: zone pivot="python"

```python
def func1(n):  
    if n == 0:  
        return 1  
    else:  
        return n * func1(n-1)  
```

::: zone-end
::: zone pivot="csharp"

```csharp
public int Func1(int n) {  
    if (n == 0) {  
        return 1;  
    } else {  
        return n * Func1(n-1);  
    }  
}
```
::: zone-end

The response likely also includes a natural language explanation of what that function is doing. In this case, it responded with a recursive implementation of the factorial function.

### Write unit tests

Azure OpenAI models can generate unit tests for functions you write to help make your code more robust. Take for example the binary search function.
::: zone pivot="python"

```python
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1
```

::: zone-end
::: zone pivot="csharp"

```csharp
public static int BinarySearch(int[] arr, int target)
{
    int left = 0;
    int right = arr.Length - 1;

    while (left <= right)
    {
        int mid = (left + right) / 2;

        if (arr[mid] == target)
        {
            return mid;
        }
        else if (arr[mid] < target)
        {
            left = mid + 1;
        }
        else
        {
            right = mid - 1;
        }
    }

    return -1;
}
```

::: zone-end

Provide that function along with the prompt `write three unit tests for this function`, and you get a response similar to the following.

::: zone pivot="python"

```python
def test_binary_search():  
    # Test case 1: Target element is in the middle of the array  
    arr1 = [1, 2, 3, 4, 5, 6]  
    target1 = 4  
    assert binary_search(arr1, target1) == 3  
      
    # Test case 2: Target element is at the beginning of the array  
    arr2 = [1, 2, 3, 4, 5, 6]  
    target2 = 1  
    assert binary_search(arr2, target2) == 0  
      
    # Test case 3: Target element is not in the array  
    arr3 = [1, 2, 3, 4, 5, 6]  
    target3 = 7  
    assert binary_search(arr3, target3) == -1
```

::: zone-end
::: zone pivot="csharp"

```csharp
[Test]  
public void TestBinarySearch1()  
{  
    int[] arr = { 1, 2, 3, 4, 5 };  
    int target = 3;  
    int expected = 2;  
    int result = BinarySearch(arr, target);  
    Assert.AreEqual(expected, result);  
}  
  
[Test]  
public void TestBinarySearch2()  
{  
    int[] arr = { 10, 20, 30, 40, 50 };  
    int target = 35;  
    int expected = -1;  
    int result = BinarySearch(arr, target);  
    Assert.AreEqual(expected, result);  
}  
  
[Test]  
public void TestBinarySearch3()  
{  
    int[] arr = { 3, 6, 9, 12, 15 };  
    int target = 6;  
    int expected = 1;  
    int result = BinarySearch(arr, target);  
    Assert.AreEqual(expected, result);  
}  
```
::: zone-end

This functionality is even more useful if you specify the cases you want included in your prompt, which reduces the time it takes for you to write unit tests for your code.

### Add comments and generate documentation

To further improve your code, AI models can add comments and documentation for you. Take the following function as an example, which can be a little hard to understand when first reading it without any code comments.

::: zone pivot="python"

```python
def permutations(lst):  
    if len(lst) == 0:  
        return []  
    elif len(lst) == 1:  
        return [lst]  
    else:  
        result = []  
        for i in range(len(lst)):  
            temp = lst[i]  
            remaining = lst[:i] + lst[i+1:]  
            for p in permutations(remaining):  
                result.append([temp] + p)  
        return result  
```

::: zone-end
::: zone pivot="csharp"

```csharp
public static List<List<int>> Permutations(List<int> lst)  
{  
    if (lst.Count == 0)  
    {  
        return new List<List<int>>();  
    }  
    else if (lst.Count == 1)  
    {  
        return new List<List<int>> { lst };  
    }  
    else  
    {  
        List<List<int>> result = new List<List<int>>();  
        for (int i = 0; i < lst.Count; i++)  
        {  
            int temp = lst[i];  
            List<int> remaining = new List<int>(lst);  
            remaining.RemoveAt(i);  
            foreach (List<int> p in Permutations(remaining))  
            {  
                List<int> permutation = new List<int> { temp };  
                permutation.AddRange(p);  
                result.Add(permutation);  
            }  
        }  
        return result;  
    }  
}  
```
::: zone-end

Provide that function to the model, along with a prompt requesting that it add comments to the code, and you get a response similar to the following.

::: zone pivot="python"

```python
def permutations(lst):  
    # Check if the input list is empty  
    if len(lst) == 0:  
        return []  
    # Check if the input list has only one element  
    elif len(lst) == 1:  
        return [lst]  
    else:  
        # Initialize an empty list to store permutations  
        result = []  
        # Iterate through each element of the input list  
        for i in range(len(lst)):  
            # Remove the current element from the list and store it in a variable  
            temp = lst[i]  
            remaining = lst[:i] + lst[i+1:]  
            # Recursively call the function on the remaining list  
            for p in permutations(remaining):  
                # Append the current element to the beginning of each permutation and add it to the result list  
                result.append([temp] + p)  
        # Return the final list of permutations  
        return result  
```

::: zone-end
::: zone pivot="csharp"

```csharp
public static List<List<int>> Permutations(List<int> lst)  
{  
    // Check if the input list is empty  
    if (lst.Count == 0)  
    {  
        return new List<List<int>>();  
    }  
    // Check if the input list has only one element  
    else if (lst.Count == 1)  
    {  
        return new List<List<int>> { lst };  
    }  
    else  
    {  
        // Initialize an empty list to store permutations  
        List<List<int>> result = new List<List<int>>();  
        // Iterate through each element of the input list  
        for (int i = 0; i < lst.Count; i++)  
        {  
            // Remove the current element from the list and store it in a variable  
            int temp = lst[i];  
            List<int> remaining = new List<int>(lst);  
            remaining.RemoveAt(i);  
            // Recursively call the function on the remaining list  
            foreach (List<int> p in Permutations(remaining))  
            {  
                // Append the current element to the beginning of each permutation and add it to the result list  
                List<int> permutation = new List<int> { temp };  
                permutation.AddRange(p);  
                result.Add(permutation);  
            }  
        }  
        // Return the final list of permutations  
        return result;  
    }  
}  
```
::: zone-end

If you take it one step further, and request documentation, OpenAI will add a description including inputs and outputs.

## Fix bugs and improve your code

Developers sometimes can write code that mostly works, but could be improved by fixing bugs, syntax, performance, or modularity. Azure OpenAI models can help identify ways to improve and provide suggestions on how to write better code.

### Fix bugs in your code

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

### Improve performance

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

### Refactor inefficient code

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
