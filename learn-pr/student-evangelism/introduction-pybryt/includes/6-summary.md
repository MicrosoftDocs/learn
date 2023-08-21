In this module, you learned about [PyBryt](https://microsoft.github.io/pybryt/html/index.html) and how it's a library that makes it possible to autograde programming assignments and provide targeted feedback. Furthermore, you learned how to create an assignment that can be assessed with PyBryt.

PyBryt relies on three important concepts:

* **Reference implementations**. The reference implementation is an example solution that an instructor builds, the solution the student's submission is assessed against. There can be more than one of these implementations in case you want to allow your students to implement a problem in different ways.
* **Student implementations**. The student implementation is the student's submission, processed through PyBryt into a memory footprint.
* **Grading pipeline**. The grading pipeline is the process where everything comes together. This process can be automated, like GitHub Actions, or a notebook in which the grading is orchestrated. The pipeline compares the reference implementations against the student implementations and you end up with a report on how well each student's submission matches with each reference implementation.

To ensure your understanding of the above concepts, you built a scaffold for assessing student solutions for a Fibonacci sequence. The scaffold is capable of providing specific feedback to students on where bugs might occur in their implementations. Students then know how to improve their solution. It gives you as a teacher an understanding of where your students are at in their learning process.

Once you have a library of reference implementations built out, deploying PyBryt as a complete auto-assessment pipeline is a simple task. For example, you can set up GitHub Classroom assignments that use GitHub Actions to run PyBryt when students push to their repositories. This setup provides swift feedback while allowing you to collect the results for grading.

PyBryt is capable of more than what is presented in this module. Besides providing logic for combining annotations, PyBryt can also be integrated with existing autograding pipelines such as [Otter-Grader](https://otter-grader.readthedocs.io/) and can be used for plagiarism detection.

You can learn more about PyBryt in the [PyBryt advanced module](/training/modules/advanced-pybryt/) and its [documentation](https://microsoft.github.io/pybryt/html/index.html), and you can find more examples in the [demos folder](https://github.com/microsoft/pybryt/tree/main/demo) in its GitHub repository.
