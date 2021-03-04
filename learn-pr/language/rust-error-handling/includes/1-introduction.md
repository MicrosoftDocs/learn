Error handling is the process of anticipating and working with the possibility of failure.

For example, a program's failure to read a file, followed by its continuing use of that bad input, would clearly produce problematic errors. Your ability to notice and explicitly manage those errors can save the program from various additional pitfalls.

## Learning objectives

In this module, you'll learn how to:
- Use `panic!` to deal with unrecoverable errors.
- Use the `Option` enum when a value is optional or the lack of a value is not an error condition.
- Use the `Result` enum when things could go wrong and a caller might have to deal with the problem.

## Prerequisites

- A Rust development environment
- Familiarity with creating, editing, and executing Rust code by using Cargo
