Now that Python 3 is installed, let's write one line of Python code to see it working. This tiny line of code won't win you any awards for software design, but it's the first step all software developers take as they begin their learning journey.

## Using the Python interpreter's interactive mode

In this module, you'll learn that there are two workflows for writing and running Python code:

- Use the Python interpreter's interactive mode to write and run one line of Python code at a time.
- Write Python code in a script file and then use command-line tools to run the contents of the script file.

Interactive mode allows you to experiment with Python without having to perform additional setup, so it's great for learning new things. But it's limited: after you leave interactive mode, your code is gone forever.

> [!NOTE]
> Sometimes interactive mode is referred to as "the REPL", which is an acronym for "read-eval-print loop."  Many programming languages have a REPL that can be used for this same purpose.

> [!IMPORTANT]
> The Python interpretter's interactive mode is different from Visual Studio Code's Python Interactive Window which we'll learn about in another module.

### Step 1 - Launch Python's interactive mode

::: zone pivot="windows"

#### Launch Python's interactive mode in Windows

At the command prompt, type the following line of code and select the <kbd>Enter</kbd> key on your keyboard:

```console
py -3
```
When used in this way, the `py` launcher utility will launch Python in interactive mode.  The optional flag `-3` ensures that you'll be working with Python version 3.

You should now see the following prompt:

```output
>>>
```

The three arrows `>>>` are called a *primary prompt*.  We'll discover a *secondary prompt* later.

The primary prompt is where you can write and execute one line of Python at a time.  Let's try it.

### Step 2 - Write your first line of Python code

After the primary prompt `>>>` type the following Python code, then select the <kbd>Enter</kbd> key on your keyboard:

```python
print('Hello World!')
```
You should see the following output displayed on the next line:

```output
Hello World!
```

If you got an error message instead of the output, retype the code paying close attention to each character and make sure your code looks exactly like the code, above.  Even one tiny punctuation error can cause significant problems when writing code.

In the next module, we'll examine this line of code to learn about Python's syntax.  We'll learn the job that each individual word and punctuation mark performs in our code.

### Step 3 - Exit interactive mode

We're finished working in interactive mode, but we'll use it again throughout this series of modules.  For now, you can exit interactive mode by typing the following command after the primary prompt `>>>` then select the <kbd>Enter</kbd> key on your keyboard:

```python
exit()
```
You should be returned back to your command or bash prompt.

::: zone-end

::: zone pivot="linux"

#### Launch Python's interactive mode in Linux

At the bash prompt, type the following line of code select the <kbd>Enter</kbd> key on your keyboard:

```bash
python3
```

When used in this way, the `python3` utility will launch Python in interactive mode.

You should now see the following prompt:

```output
>>>
```

The three arrows `>>>` are called a *primary prompt*.  We'll discover a *secondary prompt* later.

The primary prompt is where you can write and execute one line of Python at a time.  Let's try it.

### Step 2 - Write your first line of Python code

After the primary prompt `>>>` type the following Python code, then select the <kbd>Enter</kbd> key on your keyboard:

```python
print('Hello World!')
```
You should see the following output displayed on the next line:

```output
Hello World!
```

If you got an error message instead of the output, retype the code paying close attention to each character and make sure your code looks exactly like the code, above.  Even one tiny punctuation error can cause significant problems when writing code.

In the next module, we'll examine this line of code to learn about Python's syntax.  We'll learn the job that each individual word and punctuation mark performs in our code.

### Step 3 - Exit interactive mode

We're finished working in interactive mode, but we'll use it again throughout this series of modules.  For now, you can exit interactive mode by typing the following command after the primary prompt `>>>` then select the <kbd>Enter</kbd> key on your keyboard:

```python
exit()
```
You should be returned back to your command or bash prompt.

::: zone-end

::: zone pivot="macos"

#### Launch Python's interactive mode in macOS

At the bash prompt, type the following line of code and select the <kbd>Return</kbd> key on your keyboard:

```bash
python3
```
When used in this way, the `python3` utility will launch Python in interactive mode.

You should now see the following prompt:

```output
>>>
```
The three arrows `>>>` are called a *primary prompt*.  We'll discover a *secondary prompt* later.

The primary prompt is where you can write and execute one line of Python at a time.  Let's try it.

### Step 2 - Write your first line of Python code

After the primary prompt `>>>` type the following Python code, then select the <kbd>Return</kbd> key on your keyboard:

```python
print('Hello World!')
```
You should see the following output displayed on the next line:

```output
Hello World!
```

If you got an error message instead of the output, retype the code paying close attention to each character and make sure your code looks exactly like the code, above.  Even one tiny punctuation error can cause significant problems when writing code.

In the next module, we'll examine this line of code to learn about Python's syntax.  We'll learn the job that each individual word and punctuation mark performs in our code.

### Step 3 - Exit interactive mode

We're finished working in interactive mode, but we'll use it again throughout this series of modules.  For now, you can exit interactive mode by typing the following command after the primary prompt `>>>` then select the <kbd>Return</kbd> key on your keyboard:

```python
exit()
```
You should be returned back to your command or bash prompt.


::: zone-end


## Recap

The important takeaways from this unit:

- Writing code requires precision.  Even one small mistake can cause an error.
- You can use interactive mode to quickly try writing Python.  Each line will be interpreted and executed immediately.
- To exit interactive mode, use the `exit()` command.
