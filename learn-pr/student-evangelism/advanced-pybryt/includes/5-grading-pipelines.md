In this unit, we discuss how to build a grading pipeline around assessing submissions with PyBryt.

## Output formats

Depending on your grading and feedback pipelines, PyBryt's results can be turned into various forms of output. The first and most obvious is the [`pybryt.ReferenceResult`](https://microsoft.github.io/pybryt/html/api_reference.html#pybryt.reference.ReferenceResult) object returned by PyBryt whenever a student implementation is checked against a reference. These objects can be pickled to files for further processing, and can also be used to generate feedback reports with [`pybryt.generate_report`](https://microsoft.github.io/pybryt/html/api_reference.html#pybryt.reference.generate_report). Finally, these reference results can be converted into a JSON-friendly dictionary format using the [`to_dict`](https://microsoft.github.io/pybryt/html/api_reference.html#pybryt.reference.ReferenceResult.to_dict) method if you want to use some post-processing script to customize the reports.

## Running locally

The first and simplest approach is to run PyBryt on each submission locally. In this pipeline, the instructor collects the submissions and downloads them onto their machine. They then use PyBryt to generate a student implementation from each submission and run them against the references. The following script demonstrates this approach:

```python
import glob
import pathlib
import pybryt

student_impls = []
submissions = glob.glob("submissions/*.ipynb")
for subm in submissions:
    student_impls.append(pybryt.StudentImplementation(subm))

refs = []
ref_paths = glob.glob("refs/*.pkl")
for ref_path in ref_paths:
    refs.append(pybryt.ReferenceImplementation.load(ref_path))

for student_impl, subm in zip(student_impls, submissions):
    results = student_impl.run(refs)
    for res in results:
        res_path = f"results/{pathlib.Path(subm).stem}_{res.reference.name}.pkl"
        res.dump(res_path)
```

The previous script generates each student implementation from a submission notebook in the `submissions` directory. It then loads the pickled reference implementations from the `refs` directory, and then runs each student implementation against each reference, storing the results in the `results` directory for further processing.

For multiple runs, you may want to pickle the student implementation objects, since generating them can take some time:

```python
for student_impl, subm in zip(student_impls, submissions):
    impl_path = f"student-implementations/{pathlib.Path(subm).stem}.pkl"
    student_impl.dump(impl_path)
```

Then all you'd need to do in the first script is load from the pickled student implementations instead of generating them from the notebooks.

You can find more examples of this style of grading pipeline in the [demos folder of PyBryt's GitHub repo](https://github.com/microsoft/pybryt/tree/main/demo).

## Running via automation

PyBryt can also be run through automation on student repos like continuous integration. This method has the benefit of providing students near-immediate feedback whenever they push to their repo, and also allows instructors to collect the student implementations or results from the latest run without needing to rerun each submission. 

It's possible to run PyBryt on any CI platform, although PyBryt has an [Action](https://github.com/microsoft/pybryt-action) that you can use with GitHub Actions. Regardless of how you run PyBryt, the import step is collecting the results and putting them in a place where the instructor can access them. In many contexts, this step is accomplished by committing those files to the repo. Then, to generate finalized grades, download the feedback from each repo and run it through your grading script. Or, download the student implementations and run them against another set of references.
