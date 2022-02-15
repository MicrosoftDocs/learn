An essential feature of an RTOS is determinism. 

## Aspects of determinism

There are several aspects to this concept, but each aspect is built on the assumption that for each possible state and each set of inputs, a unique set of outputs and next state of the system can be, in principle, predicted. This kind of determinism is not unique to an RTOS; it is the basis for virtually all types of computing systems. When we say that an RTOS is deterministic, we are usually referring to temporal determinism. A system exhibits temporal determinism if the time required to process any task is finite and predictable. In particular, we are less concerned with average response time than we are with the worst-case response time. In the latter case, we must have a guarantee on the upper time limit, which is an example of temporal determinism.

## Hardware constraints

An RTOS is typically encapsulated by the hardware it controls, so end users might be  unaware of its presence. Thus, an RTOS is actually a computer system that does not have the outward appearances of a computer system. An RTOS typically interacts with the external world, but it usually has a primitive or nonexistent user interface.

The RTOS field is a hybrid that draws extensively from disciplines such as software engineering, operating systems, and electrical engineering. RTOSes have borrowed liberally from other disciplines and have adapted, refined, and enhanced those concepts and techniques for use in this relatively young field.

## Time constraints

As noted previously, an RTOS typically must operate within specified time constraints. This limitation means that the system must respond to inputs or events within prescribed time limits, and the system as a whole must operate within specified time constraints. Thus, an RTOS must not only produce correct results, but also it must produce them in a timely fashion. The timing of the results is sometimes as important as their correctness.

There are two important subclasses of real-time constraints: hard real-time and soft real-time. Hard real-time refers to highly critical time constraints in which missing even one time deadline is unacceptable, possibly because it would result in catastrophic system failure. Examples of hard real-time systems include air traffic control systems, medical monitoring systems, and missile guidance systems. Soft real-time refers to situations in which meeting the time constraints is desirable, but not critical to the operation of the system. 

ThreadX is a deterministic RTOS.
