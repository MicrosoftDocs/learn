## Summary

You learned how to measure, profile, and debug Python code:

- **Choose the algorithm carefully.** An O(n) algorithm is far faster than an O(n²) algorithm for large data.
- **Measure before you optimize.** Use `timeit` to compare implementations and to see how time grows with data size.
- **Find the bottleneck.** Use `cProfile` to identify the function that takes the most time, and optimize only where the time saved justifies the added complexity.
- **Debug unexpected results.** Use breakpoints, variable inspection, and stepping in the VS Code debugger to find why code returns the wrong output.

Most code doesn't need extreme optimization. A function that runs once at startup and takes half a second is usually fine. A function that runs in a loop over millions of items needs attention, especially when it's O(n²) and an O(n) approach exists.

When a program is slow, profile it first, and then optimize the function that the profile identifies. After you optimize, measure again and confirm that the results are still correct.
