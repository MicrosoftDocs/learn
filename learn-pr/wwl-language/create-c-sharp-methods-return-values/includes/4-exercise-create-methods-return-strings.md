You may often find that you need to write a method that returns a string. For example, you may want to retrieve a string from a set of data or modify a string in some way. In this exercise, you'll gain some experience working with strings in methods while practicing a common interview question.

### Create a method that returns a string

Suppose you're a candidate in a coding interview. The interviewer asks you to write a method to reverse a string without using `string.Reverse`. Take a moment to think about how you might accomplish this task.

You might have decided that you can reverse a string by iterating from the end of the string. You can use a temporary string to store each letter from end to beginning. Let's get started!

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Enter the following code in the editor:

    ```c#
    string ReverseWord(string word) 
    {
        string result = "";

        return result;
    }
    ```

1. The method needs to iterate through the given word and update the result. To do this, update the `ReverseWord` method with the following code:

    ```c#
    string ReverseWord(string word) 
    {
        string result = "";
        for (int i = word.Length - 1; i >= 0; i--) 
        {
            result += word[i];
        }
        return result;
    }
    ```

    In this code block, you start from the end of the word using `word.Length - 1`. You subtract one from the length since array indices start at zero, and you want to avoid accessing an element out of bounds. Then you add the letter at the current index to the `result` string and move the index backwards. You use `i >= 0` since `i` is updated after the code in the loop is executed, and you want to be sure to include the zeroth index.

### Test your code

When coding, it's important to frequently check your work. Finding and correcting mistakes early in the coding process allows you to spend more time building upon correct code rather than debugging one large program. Checking your work frequently is a skill that coding interviewers value highly as well.

1. Enter a new blank code line. Then create some input text and call your method by entering the following code above the `ReverseWord` method:

    ```c#
    string input = "snake";

    Console.WriteLine(input);
    Console.WriteLine(ReverseWord(input));
    ```

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

1. At the Terminal command prompt, enter **dotnet run**. Compare your output with the following:

    ```
    snake
    ekans
    ```

    If your code displays unexpected results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

### Create a method to reverse words in a sentence

Suppose your interviewer asks you a follow up question. They want you to reverse each word in a given sentence, maintaining the original position of each word. You can assume each word is separated by a space. For example, "string return type" would become "gnirts nruter epyt". Take a moment to think about how you might perform this task. 

If you use the method you wrote in the previous task, you might realize that you can use the method to reverse each word in the string individually. You can create a new sentence and add each word as it's reversed. Let's get started!

1. Create a new blank code line at the end of the current program. Then enter the following code to create a new method:

    ```c#
    string ReverseSentence(string input) 
    {
        string result = "";

        return result;
    }
    ```

1. Next, you can extract the individual words from the string using `string.Split`. Update the `ReverseSentence` method to the following:

    ```c#
    string ReverseSentence(string input) 
    {
        string result = "";
        string[] words = input.Split(" ");

        return result;
    }
    ```

    Now that you have access to each individual word in the sentence, you can use your `ReverseWord` method on each word and store them in `result`.

1. Update the `ReverseSentence` method to the following:

    ```c#
    string ReverseSentence(string input) 
    {
        string result = "";
        string[] words = input.Split(" ");

        foreach(string word in words) 
        {
            result += ReverseWord(word) + " ";
        }

        return result;
    }
    ```

    Notice how you can call the `ReverseWord` method inside of a compound assignment operator. In this code, the return value is captured from `ReverseWord` and added to `result`. Methods with return values can be used anywhere you need them, as long as the data type fits the requirements. 

    In this code, each reversed word is appended to the result with an added space. However, this leaves an extra space at the end of the reversed sentence.

1. You can remove the extra space at the end using `string.Trim`. Update the method to the following code:

    ```c#
    string ReverseSentence(string input) 
    {
        string result = "";
        string[] words = input.Split(" ");

        foreach(string word in words) 
        {
            result += ReverseWord(word) + " ";
        }

        return result.Trim();
    }
    ```

    Take a moment to consider the return result of this method. A method can use other methods throughout its execution and even in the return statement, as long as the data types match.

    Now you're ready to call your method!

1. Update the `input` text and the `Console.WriteLine` statement to the following:

    ```c#
    string input = "there are snakes at the zoo";

    Console.WriteLine(input);
    Console.WriteLine(ReverseSentence(input));
    ```

## Check your work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Compare your code with the following to ensure it's correct:

    ```c#
    string input = "there are snakes at the zoo";

    Console.WriteLine(input);
    Console.WriteLine(ReverseSentence(input));

    string ReverseSentence(string input) 
    {
        string result = "";
        string[] words = input.Split(" ");
        foreach(string word in words) 
        {
            result += ReverseWord(word) + " ";
        }
        return result.Trim();
    }

    string ReverseWord(string word) 
    {
        string result = "";
        for (int i = word.Length - 1; i >= 0; i--) 
        {
            result += word[i];
        }
        return result;
    }
    ```

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that your code produces the following output:

    ```Output
    there are snakes at the zoo
    ereht era sekans ta eht ooz 
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.