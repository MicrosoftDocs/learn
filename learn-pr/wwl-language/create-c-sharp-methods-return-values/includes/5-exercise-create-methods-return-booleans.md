Methods with Boolean return types can be simple but are useful in consolidating code. Methods that return `bool` values can be called to evaluate data input anywhere, in `if` statements, in variable declarations, and more. In this exercise, you'll gain some experience creating and using Boolean return type methods.

### Create a method that returns a Boolean

Suppose you're a candidate in a coding interview. The interviewer wants you to check if several words are a palindrome. A word is a palindrome if it reads the same backwards and forwards. For example, the word `racecar` is a palindrome. Let's get started!

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Enter the following code into the Editor:

    ```c#
    string[] words = {"racecar" ,"talented", "deified", "tent", "tenet"};

    Console.WriteLine("Is it a palindrome?");
    foreach (string word in words) 
    {
        Console.WriteLine($"{word}: {IsPalindrome(word)}");
    }
    ```

    This code establishes some test cases and references a method named `IsPalindrome`. The words and output of the `IsPalindrome` method are printed in the `Console.WriteLine` statements.

1. Enter a new blank code line and create `bool` method by entering the following code:

    ```c#
    bool IsPalindrome(string word) 
    {
        return true;
    }
    ```

1. Consider how you'd check if a word is a palindrome.

    One way to check is to compare the first and the last letters of the word. If they match, then compare the second and the second-to-last letter of the word. If you reach the middle of the word, then all the letters have been compared and matched. If any letters don't match, the word isn't a palindrome.

1. Update the `IsPalindrome` method with the following code:

    ```c#
    bool IsPalindrome(string word) 
    {
        int start = 0;
        int end = word.Length - 1;

        while (start < end) 
        {
            if (word[start] != word[end]) 
            {
                return false;
            }
            start++;
            end--;
        }

        return true;
    }
    ```

    Notice the variables `start` and `end` to point to the first and last characters in the string. The loop breaks when the middle of the word is met; when `start` and `end` point to the same character or cross over each other. The pointers are moved inwards each time there's a match. If they don't match, the method terminates and returns `false`.

    Now your method successfully checks if a word is a palindrome and returns `true` or `false` accordingly.

## Check your work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that your code produces the following output:

    ```Output
    Is it a palindrome?
    racecar: True
    talented: False
    deified: True
    tent: False
    tenet: True
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.