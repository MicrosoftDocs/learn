One of the capabilities of Azure OpenAI models is to generate code from natural language prompts. Tasks can range from a simple one line command to a full application. The AI models can also edit and update provided code or previous responses to complete the requested task.

## AI models for code generation

Most of the language models available can help with code, with some performing better than others. In the base *GPT-3* family, the standard text model (such as `text-davinci-002`) has a good base understanding of code. *Codex* (such as `code-davinci-002`) has expanded coding capabilities on top of the standard text model.

As new generations of models evolve, the base models drastically improve their performance and understanding of both language and code, which results in not needing specific *Codex* models. This improvement results in just a single model for more recent generations (such as `gpt-35-turbo` and `gpt-4`) that can be used for both natural language and code.

The examples in this module are using `gpt-35-turbo`.

## Write functions

Azure OpenAI models can create functions and apps in several languages by just describing what you want. For example, say you need an implementation of binary search but can't remember how it's done. Given the prompt `write a function for binary search in python`, you likely receive a response with the function and an explanation of the code.

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
