The stock reporting service can finish its local reads on time and still keep the dispatcher waiting for a database response. In this unit, you compare timings for the same request at the VM and the database with an independent measurement of network round-trip time. You'll also learn what evidence distinguishes a slow connection from a failed connection or a transfer limited by outbound bandwidth.

A slow database call doesn't tell you that the network is slow. In Application Insights, a dependency timer measures the client operation that was instrumented. Its start and stop points need not be when the request went on the wire and the reply returned. If timing starts at command execution, it excludes time spent acquiring a pooled connection beforehand. If a retry happens inside the timed operation, its time is included.

Compare timings for the same call, not one chart's p95 with another's. Subtracting the two percentiles can pair unrelated requests.

Match the outbound call to the database record for that specific call. If both sides propagate trace context, use the trace ID to find the operation, then match the caller's dependency span ID to the server span's parent ID. This distinguishes repeated calls to the same database within one request. Otherwise, use a request identifier recorded by both sides, if available.

If you can't match a server record, report the caller's elapsed time and the independent network probe result separately. The probe doesn't tell you how long the database spent on this request. Even with a match, check what the database timer covers: query execution alone can exclude time the request spent in a queue.

In this simulated incident, the stock reporting service calls a remote database. Local reads on the VM hosting the service still complete at the healthy rate and latency, with no increase in CPU or memory pressure. Request mix, response size, and database endpoint are unchanged. The first three rows describe one representative traced request from each window. The last row summarizes independent Transmission Control Protocol (TCP) checks from the same VM to the database port.

| Measurement | Healthy, 09:00–09:15 UTC | Incident, 10:00–10:15 UTC |
|---|---:|---:|
| Application wait for a pooled connection | 1 ms | 1 ms |
| Database call, from when the stock reporting service sends the request until it receives the reply | 5 ms | 38 ms |
| Same request at the database, from receipt through reply, including queuing | 3 ms | 3 ms |
| Mean round-trip time for successful TCP checks | 2 ms | 33 ms |

The incident's send-to-reply time was 38 ms. The database handled that call in 3 ms, leaving 35 ms outside the measured server interval. Azure Network Watcher Connection Monitor reported a mean round trip of 33 ms for **separate TCP checks**. Those 33 ms aren't a component of the 35 ms, and neither number measures the network time for this call.

All TCP checks succeeded, but their mean round-trip time rose from 2 ms to 33 ms while database handling stayed at 3 ms. That makes the network path the leading hypothesis, not proof of a faulty hop. Compare the same destination and port from a second application VM: if only the first source slows down, investigate what's different about that source and its path. If round-trip time had stayed flat while database handling rose to 35 ms, the database would be the better place to start.

Two other patterns call for different evidence:

- **Connection failures**: Match the failing request's source, destination name, protocol, and port. Distinguish a name-resolution failure from a connection timeout or refusal. Compare the rates of failed checks and TCP retransmissions with their healthy values for that path. A failed check by itself doesn't prove packet loss.
- **Slow bulk transfers**: Compare outbound traffic from the **sending** VM with the size's published expected network bandwidth. The allocation is shared across its network interfaces and destinations. For example, 6 billion bytes in `Network Out Total` over 60 seconds is 800 megabits/s (`bytes × 8 ÷ seconds` gives bits/s). A sustained plateau near the expected rate while demand grows supports a bandwidth constraint. Low traffic doesn't rule out latency on small, sequential calls.

> [!NOTE]
> A Connection Monitor test can show **Fail** because RTT exceeded its configured threshold even when **Checks Failed Percent** is zero. Compare that metric with **Round-Trip Time (ms)** for the same TCP test and time window. Successful connectivity checks don't tell you whether a SQL query succeeded. Missing observations don't establish zero failed checks.
