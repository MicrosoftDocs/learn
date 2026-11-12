AI assistants sometimes generate code that looks correct but calls a function that doesn't exist.

This function call is an example of **incorrect information**: the AI generates content that appears plausible but is incorrect.

### A real example

Prompt: "Write code to delete a file in Python"

AI-generated code:
```python
import os
os.delete_file("myfile.txt")  # Looks reasonable, but delete_file doesn't exist
```

Python's `os` module doesn't have a `delete_file()` function. Running this code raises `AttributeError: module 'os' has no attribute 'delete_file'`.

The AI guessed the function name instead of checking the module's actual contents.

The correct function is `os.remove()`:
```python
import os
os.remove("myfile.txt")  # Correct
```

### Why AI generates incorrect information

AI models predict likely code based on patterns in their training data. A pattern can suggest a function that doesn't exist, or the model can confuse functions with similar names. The model doesn't check the library's actual contents before it generates code.

### How to spot incorrect information

**Use your editor's autocompletion:**

When you start typing a function call, your editor shows you what methods and functions actually exist. If the AI's suggestion doesn't appear in autocompletion, it probably doesn't exist.

Type `os.` in your editor, and it lists names such as `remove`, `makedirs`, and `listdir`. If `delete_file` doesn't appear in that list, the function doesn't exist.

**Check the documentation:**

If you're not sure, look it up. Python's documentation is clear about what functions exist.

**Test the code:**

Running the code helps you find incorrect function names and assumptions. A crash can point to either problem.

### Another example of incorrect information

Prompt: "Split a string into words"

AI-generated code:
```python
text = "hello world python"
words = text.split_into_words()  # Doesn't exist!
```

The correct method is `split()`:
```python
words = text.split()  # Correct
```

### Red flags for incorrect information

- Function names that sound reasonable but slightly off (`delete_file` instead of `remove`)
- Using methods on wrong types (trying to use `.get()` on a list instead of a dictionary)
- Assuming libraries exist when they don't
- Making up parameter names that don't match documentation

### The review checklist

When you review AI code, ask:

- Do these functions actually exist in Python?
- Are the parameters correct?
- Would this code crash if I ran it?
- Can I verify these function calls in my editor or documentation?

Incorrect function names often cause crashes, which makes them easier to catch than errors in code that runs. Verify the code before you use it.
