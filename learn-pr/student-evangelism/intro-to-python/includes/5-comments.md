Most programming languages support including comments in source code. Comments do not change what the code does when it runs; they're ingored by the compiler or interpreter. Instead they're used to explain how the code works or why it was written. Comments are a great way to document complicated code and to include TODOs reminding you to come back and do something later — for example, "make sure this code works with empty strings."

Python supports comments using the pound sign (or hash) followed by the text of the comment:

```python
# I am a comment...
```

Comments always extend to the end of the line and are always one-line only. For multiline comments, place a pound sign at the start of each line. A comment may appear at the start of a line or following whitespace or code, but not within a string - in that case it's just a literal pound sign in text.

```python
# I am a comment...
x = 1   # the rest of the line is a comment
        # ... and this is a 3rd comment
text = "# But this isn't a comment because it's a string literal and in quotes."

# This is a comment
# that crosses multiple lines
```

Some programmers avoid comments in favor of writing "self-documenting code," which is easy to understand as a result of descriptive variable and function names. There is nothing wrong with self-documenting code, but never hesitate to use comments in an effort to be as explicit as possible about your thoughts and intentions. The purpose of a block of code may be clear to you if you wrote it 10 minutes ago. But a year from now, a well-placed comment may be as helpful to you as it is to other programmers who are seeing your code for the first time.