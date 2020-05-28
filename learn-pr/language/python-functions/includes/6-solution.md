The following code is one possible solution for the challenge from the previous unit.

First, create a new code file named processor.py in the same working directory.

Then create the following two functions in that file:

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

Now when you run the code in your challenge.py file, you should get the correct output.

This code is merely *one possible solution* because we didn't specify details about the implementation of the functions in the `processor` module. As long as the `process_numbers()` and `process_names()` functions fulfill the requirements in the previous unit, you're successful.

If you're successful, congratulations! Continue to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, you should review the previous units before you continue. All new ideas discussed in later modules depend on you understanding the ideas presented in this module.
