# Unit 3: Measure Code Performance and Establish Baselines

**Objective:** Learn how to measure code performance, establish a baseline benchmark, and use various techniques/tools to quantify improvements (or regressions).

## Establish a performance baseline

A **performance baseline** is a set of measurements that captures how the code performs before any changes. It's your point of reference. Without it, you can't objectively know if your optimizations helped or possibly made things worse elsewhere. Think of it like a starting weight when trying to diet or bulk up at the gym – you record where you are now to track progress.

**Key aspects to measure in a baseline:**

- **Execution time (latency):** How long does it take to execute a certain operation or process? This can be measured for a small function (for example, it takes 5 milliseconds to sort 10,000 items) or an end-to-end scenario (for example, the service responds to a request in 250 ms).
- **Throughput:** How many operations can be done in a given time? This is relevant for server applications (requests per second), batch processing (records processed per minute), etc.
- **Resource usage:** Memory consumption (working set, allocations, garbage collection frequency), CPU usage (does it peg a core at 100%? for how long?), disk I/O, network I/O, etc., depending on what the code does.
- **Scalability characteristics:** How do the above metrics change as input size grows or as load (concurrent users) increases? You might measure that a function takes 0.1 ms for 100 items and 10 ms for 10,000 items. That indicates how it scales (in this case, roughly linear with number of items). This kind of baseline helps you understand scalability and set goals (maybe you want 100k items to sort in under 200 ms, which might mean you need a more efficient algorithm or parallel sorting).

When establishing a baseline:

1. **Make the environment as consistent as possible.** Run tests on the same machine, under similar conditions (close background programs, use release build, etc.). Performance can vary run-to-run; minimizing noise gives more reliable data.
2. **Use release builds and realistic settings.** Debug builds often run much slower due to extra checks and lack of optimizations. If you're measuring algorithm speed, compile in Release mode with optimizations on. Similarly, if your code is multi-threaded or async, test it in a scenario that resembles production (for example, the same number of threads or same dataset size).
3. **Automate or script the measurement.** You'll likely run the code multiple times. It helps to have a simple benchmark harness or use tools that automate it. For example, for a small function, you might write a loop that calls it, measure time, and compute an average.
4. **Record the numbers.** Keep a note of the baseline metrics (time, memory, etc.). If you have a unit test or log output that prints performance info, save that. For non-trivial cases, using a spreadsheet or simple table to compare "before vs after" is useful.

### Example – Baseline Measurement using Stopwatch

C# provides `System.Diagnostics.Stopwatch` which is handy for timing code segments. Suppose you have a method `ProcessData()` that you suspect is slow:

```csharp
var sw = Stopwatch.StartNew();
ProcessData();
sw.Stop();
Console.WriteLine($"ProcessData() completed in {sw.ElapsedMilliseconds} ms");
```

Run this a few times (or better, loop it and take an average). Imagine it consistently prints ~120 ms. That 120 ms is your baseline for `ProcessData()` under whatever test conditions you used.

### Example – Baseline for memory usage

You can capture memory usage by checking `GC.GetTotalMemory(false)` before and after an operation. For instance:

```csharp
long memoryBefore = GC.GetTotalMemory(forceFullCollection: true);
ProcessData();
long memoryAfter = GC.GetTotalMemory(forceFullCollection: true);
Console.WriteLine($"Memory used by ProcessData(): {memoryAfter - memoryBefore} bytes");
```

If this prints, say, 50,000 bytes, that's how much memory the operation allocated (net). This can be part of your baseline, especially if you worry about memory or GC overhead.

### Contextual baselines

The baseline often isn't a single number. You might have a baseline at a certain scale and then test at a larger scale. For example:

- Sorting 10k items takes 50 ms (baseline at 10k).
- Sorting 100k items takes 800 ms.

This indicates the performance degrades as input grows, which is expected. It also suggests the algorithm might be worse than O(n log n) (because 10x items gave 16x time, but need more data to be sure). This kind of baseline helps you understand scalability and set goals.

## Performance measurement techniques and tools

From simple to sophisticated, here are tools and methods to measure performance:

### Manual timing with Stopwatch

Manually instrumenting code with `Stopwatch` or even `DateTime.UtcNow` differences can give quick insight. This is ad-hoc but very accessible and often sufficient for a first investigation. You can sprinkle timing logs around code sections (for example, log how long a database query took, how long file parsing took, etc.).

### Logging and Counters

This is ad-hoc but very accessible and often sufficient for a first investigation. You can sprinkle timing logs around code sections (for example, log how long a database query took, how long file parsing took, etc.).

### Event logging and counters

Sometimes you can add logs to count operations (for example, "processed X items in Y ms" or "loop ran Z times"). Logging iteration counts or sizes of data can explain performance behavior. For instance, if your log says "Fetched 1000 records from DB" and you expected 100, you know something's off (maybe an N+1 query issue causing extra fetches).

### Built-in profilers in Visual Studio

### Built-in Profilers (Visual Studio Diagnostics)

Visual Studio (Enterprise edition, and to some extent Community) has profiling tools (CPU Usage, Memory Usage, Performance Profiler). You can run your application under the profiler and it will show you, for example, a breakdown of CPU time by function, or a list of objects on the heap and who allocated them.

- The CPU profiler typically produces a call tree, where you can see which methods consumed the most CPU time.
- The memory profiler can take snapshots to show how memory usage grows, and what types of objects are taking space.
- Using a profiler is often as simple as clicking "Start Diagnostic" and choosing the kind of profile.

### dotnet CLI Tools

For .NET Core and .NET 5+, Microsoft provides command-line tools like `dotnet-counters`, `dotnet-trace`, `dotnet-dump`, `dotnet-gcdump`.

- `dotnet-counters` can display real-time performance metrics of a running app (GC collections, exceptions, thread pool usage, etc.).
- `dotnet-trace` can collect a trace of an app's execution, which one can analyze to see which methods were running.
- These tools are more advanced, but invaluable for deep dives or production profiling where you can't attach a GUI profiler.

### Microbenchmarking libraries

If you want to compare two implementations of a function (for example, your original vs a proposed optimized version) in a rigorous way, BenchmarkDotNet is a popular library. It will run the functions many times, warm up the JIT, measure very precisely, and give statistics (like mean, standard deviation). This is used for micro-benchmarks (small isolated code paths) with high precision.

### Performance/Load Tests

For larger scenarios (web applications, services), you might write a load test or use a tool (like JMeter, k6, or VS load test) to simulate many requests or large inputs. This can reveal throughput and stability under stress, and help identify bottlenecks that only appear at scale.

### System Monitoring

Keep an eye on overall CPU and memory while your code runs. Sometimes an issue is obvious at the system level: e.g., your app uses 100% CPU on all cores, or memory usage climbs by gigabytes. Tools like Task Manager, or `dotnet-counters`, or PerfMon on Windows can provide this info.

## Benchmark and Baseline Example

Let's illustrate establishing a baseline with an example scenario and measuring improvement:

- **Scenario:** We have a function `ComputePrimesUpTo(N)` that returns all prime numbers up to N. The current implementation is a simple but inefficient trial division algorithm.
- **Baseline measurement:** We write a quick console test to call `ComputePrimesUpTo(1_000_000)` and time it. Suppose it takes 850 milliseconds on average and uses 200 MB of RAM at peak.
- **Identify problem:** 850 ms might be okay, but we wonder if we can do better. We know that algorithmically, a Sieve of Eratosthenes would be much faster and use less CPU, though it might use more memory for the sieve array.
- **Implement optimization:** We implement a Sieve of Eratosthenes version.
- **Measure again:** Now `ComputePrimesUpTo(1_000_000)` takes, say, 120 milliseconds and uses 8 MB of RAM.
- **Compare to baseline:** We drastically reduced time (850 -> 120 ms) at the cost of some memory (which is fine, 8 MB is trivial in this context). Clearly a win.
- **Further steps:** We could push further – maybe 120 ms is already fine for our needs, no further action needed. If we needed even faster, we now know memory isn't an issue, perhaps parallelizing the sieve might get it down to 60 ms. We could try that and measure again.

The key throughout is measurement and comparison. Notice, we also have to ensure **correctness** remains. We should verify that the output (the primes list) is the same between versions. Performance improvements mean nothing if the code breaks functionality.

## Monitor improvements and avoid regressions

Once you have a baseline and you start changing code, adopt a cycle:

1. **Change one thing at a time (if possible):** So you know what caused any improvement or regression.
2. **Run the same test/measurement as baseline:** Use the same procedure and compare metrics directly.
3. **If improvement achieved:** Great, consider if it meets the goal. If you needed a 2x speedup and you got 1.5x, you might iterate further.
4. **If no improvement or worse performance:** Investigate why. It could be your change didn't address the real bottleneck or traded one cost for another.
5. **Check for side effects:** This includes not only correctness but also other aspects of performance. For instance, you optimize CPU but maybe memory usage went up a lot – is that acceptable?

A common technique is writing performance unit tests or benchmarks that run before and after changes to automatically compare. While not every team does this, it's not a bad idea to have a small suite of performance tests (especially for critical paths) that ensure new changes don't drastically slow things down.

## Use GitHub Copilot to assist with measurement

While GitHub Copilot is more about generating or explaining code, it can help even in this stage:

- You can ask GitHub Copilot, *"How can I measure the execution time of a C# method?"* and it might suggest using `Stopwatch` (with example code).
- You might ask, *"What tools can I use to profile a .NET application?"* – GitHub Copilot could list some, reinforcing what we discussed.
- If you're writing a BenchmarkDotNet benchmark class, GitHub Copilot can help generate the boilerplate.

So GitHub Copilot can function as a quick reference to set up your measurement harness correctly.

## Summary

Measuring code performance and establishing baselines is a critical step in the optimization process. By systematically capturing execution time, resource usage, and scalability characteristics, you create a reference point to evaluate the impact of your changes. Utilizing various measurement techniques—from simple timing with `Stopwatch` to advanced profiling tools—enables you to identify bottlenecks accurately. Always ensure that performance improvements do not compromise correctness or introduce new issues. With a disciplined approach to measurement and iteration, you can effectively enhance your code's performance while maintaining its integrity.
