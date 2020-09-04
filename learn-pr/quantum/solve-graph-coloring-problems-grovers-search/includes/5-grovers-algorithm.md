In the previous units we have introduced the search problem and learned to implement its instances as quantum oracles. 

In this unit we will learn Grover's algorithm for solving search problems.

---

Notes from outline:

Keep the description high-level – we don't want to go into the circuit-level discussion.

Visuals:

1. Circle superposition diagram with "solutions" and "non-solutions" axis, two reflections that sum up to a rotation, a sequence of rotations that bring the state closer to the "solutions" (the latter would be animated)
1. Amplitudes diagram with amplitudes of various states changing during the phases of the algorithm (animated)

---


## Algorithm analysis

Grover's search algorithm has several important properties which are worth calling out explicitly.

### Grover's algorithm is probabilistic

The final measurement will produce a result that solves our problem with high probability, but not with absolute certainty; in most cases there remains a small probability of failure.

We have to deal with this in the same way we're dealing with classical randomized algorithms: check whether the result we got is indeed a solution to our problem, and if it's not, rerun the algorithm from scratch. 
Unfortunately, there is no way to use the result we obtained to improve the chances of success for the next attempt.


### More iterations does not mean better!

For many iterative classical algorithms doing extra iterations slows them down, but doesn't ultimately reduce the success probability of the algorithm. 
Grover's search has a particular "sweet spot" - the number of algorithm iterations that has the highest success probability. 
If our problem has $N$ possible variable assignments, and $M$ of them are solutions to the problem, the optimal number of iterations can be calculated as 

$$R_{opt} \approx \frac{\pi}{4} \sqrt{\frac{N}{M}}$$

Continuing to iterate past that number will start reducing that probability, until we reach nearly-zero success probability on iteration $2R_{opt}$. 
After that the probability will grow again and approach 100% on iteration $3R_{opt}$, and so on.

> TODO: quick circle-visual explanation why this is the case

### But I don't know how many solutions my problem has!

In our case we have a very small and easy to analyze problem, so we can calculate the number of solutions by hand. 
In practical applications you don't usually know how many solutions your problem has before you solve it.

To handle this, you can pick the number of iterations as a random number between $1$ and $R_{opt}$, run the algorithm, and if it doesn't yield an answer, retry with a different number of iterations.

In the next unit, we will see how to implement the algorithm we've just learned in Q#, and run it to solve our graph coloring problem!