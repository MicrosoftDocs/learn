Now that Python 3 is installed, let's write one line of Python code to see it working. This tiny line of code won't win you any awards for software design, but it's the first step all software developers take as they begin their learning journey.

## Using the Python interpreter's interactive mode

In this module, you'll learn that there are two workflows for writing and running Python code:

- Use the Python interpreter's interactive mode to write and run one line of Python code at a time.
- Write Python code in a script file and then use command-line tools to run the contents of the script file.

Interactive mode allows you to experiment with Python without having to do additional setup, so it's great for learning new things. But it's limited: after you leave interactive mode, your code is gone forever.

> [!NOTE]
> Interactive mode is sometimes referred to as "the REPL," which is an acronym for "read-eval-print loop."  Many programming languages have a REPL that can be used for this same purpose.

> [!IMPORTANT]
> The Python interpreter's interactive mode is different from the Visual Studio Code Python Interactive Window, which you'll learn about in another module.

### Step 1 - Start Python's interactive mode

::: zone pivot="windows"

#### Start Python's interactive mode in Windows

At the command prompt, run the following line of code, and then press <kbd>Enter</kbd>.

```console
py -3
```

When you use it this way, the `py` launcher utility will start Python in interactive mode. The optional flag `-3` ensures that you'll be working with Python version 3.

You should now see the following prompt.

```output
>>>
```

The three arrows (`>>>`) are called a *primary prompt*. We'll describe a *secondary prompt* later.

On the primary prompt, you can write and run one line of Python at a time. Let's try it.

### Step 2 - Write your first line of Python code

After the primary prompt (`>>>`), run the following Python code, and then press <kbd>Enter</kbd>.

```python
print('Hello World!')
```

You should see the following output on the next line.

```output
Hello World!
```

If you see an error message instead of the output, re-enter the code. Pay close attention to each character, and make sure your code looks exactly like the preceding code. Even a punctuation error can cause significant problems when you write code.

In the next module, we'll examine this line of code to help you learn about Python syntax. You'll learn what each individual word and punctuation mark does in the code.

### Step 3 - Close interactive mode

We're done working in interactive mode, but we'll use it again throughout this series of modules. For now, you can close interactive mode by running the following command after the primary prompt (`>>>`), and then pressing <kbd>Enter</kbd>.

```python
exit()
```

You should be returned to your command or Bash prompt.

::: zone-end

::: zone pivot="linux"

#### Start Python's interactive mode in Linux

At the Bash prompt, run the following line of code, and then press <kbd>Enter</kbd>.

```bash
python3
```

When you use it this way, the `python3` utility will start Python in interactive mode.

You should now see this prompt.

```output
>>>
```

The three arrows (`>>>`) are called a *primary prompt*.  We'll describe a *secondary prompt* later.

On the primary prompt, you can write and run one line of Python at a time. Let's try it.

### Step 2 - Write your first line of Python code

After the primary prompt (`>>>`), run the following Python code, and then press <kbd>Enter</kbd>.

```python
print('Hello World!')
```

You should see the following output on the next line.

```output
Hello World!
```

If you see an error message instead of the output, re-enter the code. Pay close attention to each character, and make sure your code looks exactly like the preceding code. Even a punctuation error can cause significant problems when you write code.

In the next module, we'll examine this line of code to help you learn about Python syntax. You'll learn what each individual word and punctuation mark does in the code.

### Step 3 - Close interactive mode

We're done working in interactive mode, but we'll use it again throughout this series of modules. For now, you can close interactive mode by running the following command after the primary prompt (`>>>`), and then pressing <kbd>Enter</kbd>.

```python
exit()
```

You should revert back to your command or Bash prompt.

::: zone-end

::: zone pivot="macos"

#### Start Python's interactive mode in macOS

At a Bash prompt, run the following line of code, and then press <kbd>Return</kbd>.

```bash
python3
```

When you use it this way, the `python3` utility will start Python in interactive mode.

You should now see the following prompt.

```output
>>>
```

The three arrows (`>>>`) are called a *primary prompt*. We'll describe a *secondary prompt* later.

On the primary prompt, you can write and run one line of Python at a time. Let's try it.

### Step 2 - Write your first line of Python code

After the primary prompt (`>>>`), run the following Python code, and then press <kbd>Return</kbd>.

```python
print('Hello World!')
```

You should see the following output on the next line.

```output
Hello World!
```

If you see an error message instead of the output, re-enter the code. Pay close attention to each character, and make sure your code looks exactly like the preceding code. Even a punctuation error can cause significant problems when you write code.

In the next module, we'll examine this line of code to help you learn about Python syntax. You'll learn what each individual word and punctuation mark does in the code.

### Step 3 - Close interactive mode

We're done working in interactive mode, but we'll use it again throughout this series of modules. For now, you can close interactive mode by running the following command after the primary prompt (`>>>`), and pressing <kbd>Return</kbd>.

```python
exit()
```
You should be returned back to your command or Bash prompt.

::: zone-end

## Recap

The important takeaways from this unit:

- Writing code requires precision. Even a small mistake can cause an error.
- You can use interactive mode to quickly try writing Python. Each line will be interpreted and run immediately.
- To close interactive mode, run the `exit()` command.
