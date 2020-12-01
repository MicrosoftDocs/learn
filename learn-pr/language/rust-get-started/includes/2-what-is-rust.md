Rust is an open source systems programming language that helps you write faster, more reliable software. Rust offers control over low-level details (such as memory usage) in combination with high-level ergonomics (such as iteration and interfaces), eliminating the hassle traditionally associated with low-level languages.

Rust's modern, flexible type system and the novel borrow checker ensures your program is free of null pointer dereferences, double frees, dangling pointers, and similar bugs, all at compile time, without runtime overhead.

In multi-threaded code, Rust catches data races at compile time, making concurrency much easier to use.

According to [Stack Overflow's Developer Survey](https://insights.stackoverflow.com/survey?azure-portal=true), Rust has been the most loved language for four years in a row, indicating that many of those who have had the opportunity to use Rust have fallen in love with it.

In short, Rust is the only language that ticks all the boxes:

- **Type safe:** The compiler assures that no operation will be applied to a variable of a wrong type.
- **Memory safe:** Rust pointers _(known as references)_ always refer to valid memory.
- **Data race-free:** Rust's Borrow Checker garantees thread-safety by ensuring that multiple parts of a program can't mutate the same value at the same time.
- **Zero Cost Abstractions:** Rust allows the use of high level concepts, like iteration, interfaces and functional programming, without any performance costs, meaning the abstractions are just as performant as if you had written the underlying code by hand.

- **Minimal runtime:** Rust has a very minimal, no setup required runtime and has no garbage collector in order to manage memory efficiently.

- **Targets bare-metal:** Rust shines at embedded and low-level programming, making it suitable to write an OS kernel or device drivers.
