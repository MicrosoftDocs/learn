Error handling is the process of handling the possibility of failure.

For example, failing to read a file and then continuing to use that bad input would clearly be
problematic. Noticing and explicitly managing those errors saves the rest of the program from
various pitfalls.

## Learning Objectives

In this module, you will begin to discover various ways to deal with errors in Rust:

- `panic!` for dealing with unrecoverable errors.
- The `Option` enum for when a value is optional or when the lack of a value is not an error condition.
- The `Result` enum when there is a chance that things do go wrong and the caller has to deal with the problem.

## Prerequisites

- You should have your Rust development environment already set up and know how to create, edit, and execute Rust code with Cargo.
