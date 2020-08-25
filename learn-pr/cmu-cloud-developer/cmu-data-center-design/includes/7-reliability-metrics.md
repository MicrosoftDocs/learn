Sometimes, when you read material that references availability and reliability, you'll see the term _nines_. Five _nines_ or nine _nines_ refers to the number of _nines_ in a percentage of availability. Two _nines_ is 99%, three _nines_ is 99.9%, four is 99.99%, and so on.

## Mean time between failures

You'll also see the phrases _mean time between failures (MTBF)_ and _mean time to failure (MTTF)_ in the specifications for many individual components (for example, hard drives, motherboards, power supplies). These are defined as the average number of hours that component is expected to last and are usually determined by the manufacturer using a sample of parts in more extreme conditions. However, reported failure rates in the field often are higher. For example, hard drives are rated at 1 million hours or more, but their failure rates have been found to be 2 to 10 times higher.<sup>[1][^1]</sup> Google found drive failure rates to be 50% higher on average in their study.<sup>[2][^2]</sup> The failure rate is 1 / MTBF. For example, if the MTBF of a device is 100 hours, then the chances of that device failing in 1 hour is 1 / 100, 0.01, or 1%.

It's important to note that in determining the overall MTBF of a system that has non-redundant components, the MTBF of each individual component is added as a reciprocal. Formally: 

$$ \frac{1}{MTBF_{system}} = \left(\frac{1}{MTBF_{c1}} + \frac{1}{MTBF_{c2}} + \cdots + \frac{1}{MTBF_{cn}} \right) $$

On the other hand, when a system consists of redundant components, failure is required in both components simultaneously to have an overall system failure. The overall MTBF of the system is thus the product of the MTBF of each individual redundant component of the system. Formally:

$$ MTBF_{system} = MTBF_{rc1} \times MTBF_{rc2} \times \cdots \times MTBF_{rcn} $$

One factor that's often overlooked in considering uptime is human error. No matter how much redundancy is designed into the system, even if it is properly implemented and maintained, there is some likelihood of a mistake being made by a person. The result of that eventually leads to a service being unavailable (downtime). Some mistakes can be prevented through policy, specifying standard configurations, good documentation, and change management.

When it comes to large cloud deployments, there is little focus on the hardware resiliency of an individual server. When 10,000 or more servers are working together as part of a single application, the application itself builds in the fault tolerance. In this situation, a single server failure, or even several, will not disrupt the application/service. Small and medium-sized businesses, or even a large enterprise that has legacy applications, cannot afford to author these cloud-style, fully customized applications, so they rely on third-party software, most of which does not respond well to hardware failures. Instead, cloud providers will focus on server hardware that is inexpensive and as energy efficient as possible, removing unneeded parts.
<br>
***

### References

1. _Schroeder, Bianca, and Gibson, Garth A.  (2007). [Disk Failures in the Real World](http://static.usenix.org/events/fast07/tech/schroeder/schroeder_html/index.html): What Does an MTTF of 1,000,000 Hours Mean to You? In Proceedings of the 5th USENIX Conference on File and Storage Technologies_
2. _Eduardo Pinheiro, Weber, Wolf-Dietrich, and Barroso, Luiz André.  (2007). [Failure Trends in a Large Disk Drive Population](http://static.googleusercontent.com/external_content/untrusted_dlcp/research.google.com/en//archive/disk_failures.pdf) In Proceedings of the 5th USENIX Conference on File and Storage Technologies_


[^1]: <http://static.usenix.org/events/fast07/tech/schroeder/schroeder_html/index.html> "Schroeder, Bianca, and Gibson, Garth A. (2007). *Disk Failures in the Real World: What Does an MTTF of 1,000,000 Hours Mean to You?* In Proceedings of the 5th USENIX Conference on File and Storage Technologies"
[^2]: <http://static.googleusercontent.com/external_content/untrusted_dlcp/research.google.com/en//archive/disk_failures.pdf> "Eduardo Pinheiro, Weber, Wolf-Dietrich, and Barroso, Luiz André. (2007). *Failure Trends in a Large Disk Drive Population* In Proceedings of the 5th USENIX Conference on File and Storage Technologies"

***
