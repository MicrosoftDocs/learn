## Important concepts

At a high level, PyBryt is composed of three main components: reference implementations, student implementations, and a grading pipeline.

* A **reference implementation** is an instructor-written solution to a problem. These solutions are created using **annotations**, which assert conditions on the student implementation. You can use reference implementations in concert to allow students various different methods of implementing solutions.
* A **student implementation** is the student submission PyBryt has processed into a **memory footprint**. This footprint contains all of the values that PyBryt observed the student's solution using, and can be compared against reference implementations to validate their solution.
* The **grading pipeline** is the process by which the student implementations are produced and checked against the reference implementations. This component is freeform, the instructor can adapt it to suit their technological needs. These needs can be anything from automation via GitHub Actions to a notebook that runs each submission in sequence using PyBryt's API and spits out a report.

## Building an assignment

The process for building an assignment with PyBryt isn't too complicated:

1. The instructor creates one or more reference implementations for their assignment.
1. The instructor sets up and tests the grading pipeline.
1. Students implement their solutions and submit to the grading pipeline.
1. The instructor runs the grading pipeline and collects the feedback.

![Diagram of a PyBryt workflow.](images/workflow.png)

Now that you know what goes on at a high level, let's dive into to these concepts more in detail and learn how you can implement them using PyBryt.
