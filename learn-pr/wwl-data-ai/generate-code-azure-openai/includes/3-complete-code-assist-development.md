Azure OpenAI can assist developers in common software development tasks such as writing unit tests, completing partial code, commenting code, and generating documentation. Using AI assistance can enable developers to spend more time on complex programming and problem solving tasks.

## Complete partial code

Azure OpenAI models are capable of generating code based on comments, function names, and partially written code. The more context you can provide the model, the more accurate the response likely is.

For example, when given the following prompt:
::: zone pivot="python"

```prompt
complete the following function  
"""  
# calculate the average of the numbers in an array, but only if they're even  
def 
```

::: zone-end
::: zone pivot="csharp"

```prompt
complete the following function    
"""    
// calculate the average of the numbers in an array, but only if they're even    
public 
```

::: zone-end
The model takes the comments and start of the function definition, and complete it from whatever context it has.
::: zone pivot="python"

```python
# calculate the average of the even numbers in an array  
def calculate_even_average(numbers):  
    total = 0  
    count = 0  
    for number in numbers:  
        if number % 2 == 0:  
            total += number  
            count += 1  
    if count == 0:  
        return 0  # avoid division by zero  
    else:  
        return total / count  
```

::: zone-end
::: zone pivot="csharp"

```csharp
// calculate the average of the even numbers in an array  
public double CalculateEvenAverage(int[] numbers) {  
    int total = 0;  
    int count = 0;  
    foreach (int number in numbers) {  
        if (number % 2 == 0) {  
            total += number;  
            count++;  
        }  
    }  
    if (count == 0) {  
        return 0;  // avoid division by zero  
    } else {  
        return (double) total / count;  
    }  
}
```

::: zone-end
In this case, it was able to discern what we wanted due to a relatively simple and complete comment preceding the start of the function. With more complex functions or tasks, more context is required to get a useful response.

It's important to note that for some languages, like Python, the syntax is clear enough for the model to assume what language is desired. For syntactically similar languages like C# or Java, there's a higher likelihood that the model uses the wrong language. If that is the case, try specifying the language in the prompt or providing more code for context.

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

The response likely also includes a natural language explanation of what that function is doing. In this case, it responded with a recursive implementation of the factorial function. However, the prompt could have also been the start of a Fibonacci function, which illustrates a case where we need more context in the prompt to better indicate what we want from the model.

Tools such as GitHub Copilot utilize OpenAI models to suggest code and function completions in a similar way to the above examples. GitHub Copilot is an excellent example of real-world usage of this functionality that uses built-in prompts and the context of the code you're writing to act as your paired programmer.

## Write unit tests

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

## Add comments and generate documentation

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

Take it one step further, and request documentation for the function it just added comments to.

::: zone pivot="python"

```python
def permutations(lst):  
    """  
    Generates all possible permutations of a given list of integers using recursion.  
  
    Args:  
        lst (list): The list of integers to generate permutations for.  
  
    Returns:  
        list: A list of all possible permutations of the input list.  
    """  
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
/// <summary>  
/// Generates all possible permutations of a given list of integers using recursion.  
/// </summary>  
/// <param name="lst">The list of integers to generate permutations for.</param>  
/// <returns>A list of all possible permutations of the input list.</returns>  ```
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
::: zone-end
