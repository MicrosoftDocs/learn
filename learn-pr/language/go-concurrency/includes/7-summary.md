As you've seen, Go's approach to concurrency is different from other programming languages. This approach is captured in the GO slogan: *"Do not communicate by sharing memory; instead, share memory by communicating."* 

That simple sentence changes everything. You've seen that by using goroutines and channels, you can write concurrent programs that run faster and are easy to understand (at least when you've learned why certain things are the way they are in Go).

We've just scratched the surface of concurrency in Go. But at least you've practiced with a few exercises and especially with the challenge. 

We highly recommend that you revisit this module one more time to make sure you understand the basics. Then you can start going deeper. For example, a good resource to check out next is [Concurrency is not Parallelism](https://www.youtube.com/watch?v=oV9rvDllKEg). This talk, with Google's Rob Pike, can help you better understand how concurrency works in Go.

Make sure you understand why you need channels to communicate within goroutines and the difference between unbuffered and buffered channels, especially when using them. For now, we'll leave it here for concurrency and see you in the next module.