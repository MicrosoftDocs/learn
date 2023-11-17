One of the most difficult problems that faces instructors is designing assignments and providing learners with feedback that guides them toward the solution. This problem is exacerbated in computer science curricula, in which assignments can generate cryptic error messages or give the appearance of success without throwing any errors. The nature of assignments in computer science redoubles the need for targeted instructor feedback and assistance in debugging implementations.

PyBryt is an open-source Python library that aims to help provide specific feedback to students without the need of instructor intervention while the student works through an assignment. PyBryt is an auto-assessment framework that examines a student's solution to a problem to determine its correctness. It also provides targeted messages about specific implementation details by comparing it to one or more reference implementations provided by the instructor. In this way, students can get the same helpful hints and pointers automatically rather than needing to meet with an instructor.

This formulation also has another important benefit: it allows instructors to create more open-form assignments that traditional autograders would allow. Traditional unit test-based autograders rely on students create rigidly structured objects or a specific API in their submission, which limits the students' ability to structure their solutions in unique ways. Often, one of the most time-consuming processes of grading with an autograder is to help students debug why their specific solution didn't pass the autograder tests even though the implementation is nominally correct. With PyBryt's ability to compare student implementations against _multiple_ references, instructors can create assignments with libraries of reference implementations that are robust to the different ways students develop of solving the same problem.

## Scenario: students learn to implement an algorithm

Suppose you wanted students to implement the Fibonacci sequence. There are several different algorithms for generating the sequence, from the trivial recursive solution to a dynamic programming solution to many others. Each of these algorithms has several steps during which bugs easily occur, and you want to design an assignment that helps students complete their implementations by providing feedback as they work through the assignment. A normal autograder only checks that the implementation is correct. And while some unit tests can be written to check for specific common issues, a more general solution is required.

## What are you learning?

In this module, learn about creating reference implementations and walk through the process of creating this Fibonacci assignment using PyBryt. You learn about annotations, the building blocks of reference implementations, and use them to analyze different values in a student's memory footprint. Then, combine annotations into a reference implementation, and examine how combining multiple references allows you to autograde different algorithms for the same problem. Finally, create your own reference implementation for the problem of generating Fibonacci numbers.

## What is the main goal?

By the end of this module, you can annotate solutions to create reference implementations and understand how to combine references into an assignment assessment pipeline.
