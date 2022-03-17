## Introduction

The Producer thread is restricted to putting instances on the counting semaphore (*StorageFacility*) and the Consumer thread is restricted to getting instances from the counting semaphore. It's possible because there's no concept of ownership for counting semaphores. Furthermore, the Producer thread will always succeed in putting an instance on *StorageFacility*. 

The astute reader will ask the question: what if *StorageFacility* is full, that is, it contains 2<sup>31</sup>-1 instances?

The *StorageFacility* is implemented with a counting semaphore, so if this situation occurs, the counting semaphore rolls over to zero. The Consumer thread won't get an instance from *StorageFacility* if the count is zero, but the Consumer will wait indefinitely for an instance to become available.