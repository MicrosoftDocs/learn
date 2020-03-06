The following code is one possible solution for the challenge from the previous unit.

First, you should create a new code file in the same working directory named `processor.py`.

Then, in that file, you should create the following two functions:

```python
def process_numbers(unprocessed_list):
    
    processed_list = []
    if isinstance(unprocessed_list, list) == False:
        return processed_list
    
    for item in unprocessed_list:
        if isinstance(item, int):
            processed_list.append(item)
        elif isinstance(item, str):
            if item.isnumeric():
                converted_item = int(item)
                processed_list.append(converted_item)
    
    processed_list.sort()
    return processed_list


def process_names(unprocessed_list):
    
    processed_list = []

    if isinstance(unprocessed_list, list) == False:
        return processed_list
    
    for item in unprocessed_list:
        if isinstance(item, str):
            if item.isnumeric() == False:
                processed_list.append(item)
    
    processed_list.sort()
    return processed_list
```

Now, when you run the code in your `challenge.py` file, you should get the desired output.

This code is merely "*one possible solution*" because we didn't specify details about the implementation of the functions in the `processor` module.  As long as the `process_numbers()` and `process_names()` functions fulfill the requirements in the previous unit, then you were successful!

If you were successful, congratulations!  Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, maybe you should review the previous units before you continue on.  All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.
