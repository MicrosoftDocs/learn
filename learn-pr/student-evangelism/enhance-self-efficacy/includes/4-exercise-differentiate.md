## Reflection

Review the following snippets of code. There are five differences between them. Spend a few minutes trying to spot these differences, and then answer the questions that follow.

### Snippet 1

```
NullPointer

String[] array = new String[1]; array[0] = “hello”; System.out.println(array[0].length());

ArrayIndexOutOfBounds

int[] array = new int[5]; array[0] = 1;

for ( int i = 1; i < array.length; i++ ) array[i] = array[i-1]\*2;
```

### Snippet 2

```NullPointer

String() array = new String[1]; array[1] = “hello”; System.out.println(array[0].length[]);

ArrayIndexOutOfBounds

int[] array = new int[5]; array[1] = 1;

for ( int i = 1; i < array\*length; i++ ) array[i] = array[i-1]\*2;
```

### Questions

- What is your level of self-efficacy in creating and debugging code?

- Imagine doing this task on a much larger scale and under a tight deadline. How would you approach such a situation?

- How do you rate your self-confidence? Is it at a similar level as your self-efficacy in programming and debugging?