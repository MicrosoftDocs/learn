One of the Quantum Development Kit's greatest strengths is its flexibility across platforms and development environments.
Much of this stems from the multiple ways in which users can run Q# programs.
So far in this learning path, you have been running Q# as a standalone application, where Q# is the only language involved and the program is invoked directly.
Specifically we have considered examples with the command-line interface, but for the sake of completeness note that Q# can also be used directly from [Q# Jupyter Notebooks](https://docs.microsoft.com/quantum/quickstarts/install-jupyter?view=qsharp-preview&tabs=tabid-conda).

While using Q# directly is sufficient for many purposes, there are also many applications which either require, or are drastically simplified by, the use of an additional *host program*.
Written in either Python or a .NET language (e.g. C# or F#), a host program has the ability to invoke Q# programs—which are then run in the same manner as usual—and receive the returned results.
An obvious benefit of host programs is therefore that those results can be easily collected and used in any manner such as plotting, post-processing, or file exporting.

## Useful applications of host programs

The Q# language was developed specifically around the quantum end of quantum computation—that is, around the processes which will be sent to run on quantum devices.
It therefore includes many quantum-specific features, but lacks some abilities which are "standard" to common languages; for example, plotting and the ability to import and export files.
Besides visualization as a useful tool when exploring Q#, some "advanced" workflows and applications of Q# actually *rely* on the use of host programs.
Among these are some uses of the domain-specific libraries which you will see in later units—for example, importing molecular data files for use with the quantum chemistry library, or importing the data and visualizing the classification in with the quantum machine learning library.

Whether it's for curiosity, convenience, or a critical function, the ability to use Q# through host programs is a great skill to have on hand.

Next, we show you how to set up your system to use either a Python or a C# host program, and then get you familiar with the workflow by rolling quantum dice.
