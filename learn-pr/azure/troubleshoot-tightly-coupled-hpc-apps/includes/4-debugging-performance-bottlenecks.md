If you're running an HPC application on a large number of VMs (more than 16), it's best to start running a smaller problem on fewer VMs. That test will verify that your HPC application is running as expected. 

Don't assume that just because you're running an HPC parallel application, its wall time (elapsed real time) will continue to decrease as you run it on more VMs (with more parallel processes). In fact, many tightly coupled HPC applications can have a longer wall time when you try to run them on other VMs.

The longer wall time can happen for several reasons. For example:

- You might have implemented a parallel algorithm inefficiently.

- The problem size, which is the model size or Number of Degrees of Freedom (NDOF), is not large enough. As your application runs on more parallel processes, the amount of computation by each process is too small. As a result, the total wall time is dominated by the communication time between the parallel processes. The increase in communication time increases your overall wall time.

It's important to know how well your HPC application scales running the problem size in which you're interested. You can then determine what parallel efficiency is acceptable from a performance and cost point of view.

The following parallel speed-up formula measures how well your parallel application performance improves as you add more parallel processes:

$${\text{Parallel speed-up}} = {\dfrac{\text{Wall time (1 process)}}{\text{Wall time (n processes)}}}$$

The following parallel efficiency formula illustrates how efficiently you're using computational resources as you add more processes to improve the parallel applications' performance:

$${\text{Parallel efficiency}} = {\dfrac{\text{Parallel speed-up}}{\text{N processes}}}$$

If you're unsure of the parallel scaling performance for your tightly coupled HPC application, run a scaling study. In other words, run your application on 1, 2, 4, 8, 16, and so on parallel processes. Compute the parallel speed-up and parallel efficiency, and then decide based on these results how many parallel processes you want to use.

Consider disabling any unnecessary services that might have an impact on parallel scaling, like the Azure Linux Agent, before running your jobs. You can then re-enable the services after your jobs have finished. This recommendation is especially true if you're using all available cores and scaling to a large number of VMs.

To stop the Azure Linux Agent, use the following command:

```bash
sudo system stop waagent.service
```

## Performance checks

The following information provides some basic checks to help identify potential performance problems.

### Check that the correct number of processes and threads are running on each VM

An easy way to determine if you're using the correct number of processes and threads on each VM is to get the system load average on each VM with a tool like **uptime**. The number should be roughly equal to the total expected number of processes and threads on each VM. If the recorded load average is lower or higher than the expected total number of processes and threads, that indicates a problem that must be fixed.

You should carefully check your MPI arguments and how you're specifying the number of parallel threads. For example, check your application's command-line arguments, or check the values of environmental variables such as `OMP_NUM_THREADS`.

### Check that the processes and threads are evenly distributed among all NUMA node domains

If you're using the **top** or **htop** tool, you can select the NUMA node domain view by specifying `2` as a command-line parameter. (For example: on HB120_v2, you should see 30 NUMA node domains by using this view.)

The percentage of user utilization should be evenly distributed among all the NUMA domains. If it isn't, check your MPI command-line arguments and environmental variables.

The following image illustrates the output of the Linux **top** tool in NUMA view. In this case, each NUMA is 50 percent utilized.

![Screenshot that shows the NUMA output of the Linux top command.](../media/4-top-numa-expanded.png#lightbox)

### Check the run state of processes and threads

To check the run state of your processes and threads, you should use **top**. Ideally, all processes and threads should be in a running (R) state.

If some or all of your processes and threads are in an uninterruptible sleep (D) or sleep (S) state, investigate the situation to understand the reason. Depending on how your application's algorithm is designed, it might be normal and expected behavior for processes and threads to be in a sleep state. However, it might indicate a resource constraint, like having insufficient I/O performance due to the storage solution that you're using.

The following formula illustrates how efficiently your parallel application is running, if it's waiting for some system resources (such as I/O), and to what extent:

$${\text{Application wait time}} = {\text{Wall time}} - \left( {\dfrac{\text{Total CPU time for all parallel processes}}{\text{Number of parallel processes}}} \right)$$

### Check if the application is I/O bound

Processes and threads spending a significant amount of time in an uninterruptible sleep (D) or sleep (S) state can be an indicator that there's an I/O bottleneck that needs to be investigated. Some HPC applications provide performance profiling as part of their output. These profiles show the percentage of time spent performing I/O and read/write I/O rates, which might also point to an I/O bottleneck.

If you're unsure where your I/O is going, you can use tools like **iostat** to help you. A simple way to verify if you have an I/O issue is to change your storage solution to something that you know is significantly faster than what you've been using, then rerun your HPC application. For example, you can use a fast local NVMe SSD or RAM disk.

After you've made this change, ask yourself the following questions: Do you see any improvement in I/O time? Has the overall wall time improved? If so, by how much?

### Check if the application is network bound

Determine the percentage of the overall wall time that your application spends performing process communication (which is typically MPI communication).

If your application is network bound, verify that you're using the InfiniBand network when running your HPC application. If a hybrid parallel version is available, determine whether that reduces the network communication time.

If you have access to the source code, check to see if there are more efficient ways to implement the communication. For example, use collective operations instead of point-to-point, or try using asynchronous communication instead of synchronous.
