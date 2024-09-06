When you run Windows PowerShell commands, you'll sometimes encounter error messages. Large error messages on the screen can be intimidating at first, but they contain information that you can use for troubleshooting. Most of the time, if you review the complete message, it provides a good description of why the error occurred. Errors can occur for reasons such as:

- You made a mistake while entering code.
- You queried an object that doesn't exist.
- You attempted to communicate with a computer that's offline.

When errors occur, they're stored in the `$Error` array. The most recent error is always at index zero. When a new error is generated, it's inserted at `$Error[0]`, and the index of other errors is increased by one. It can be useful to review errors in `$Error` whenever you need to review a previous error message. For example, if you clear the screen, you can use `$Error` to review the most recent error message.

