Add a badge to the repo so others can see its status.

[Reference](https://docs.microsoft.com/en-us/azure/devops/pipelines/get-started-yaml?view=azdevops#add-a-ci-status-badge-to-your-repository)

-----

Notes from spike:

- From Azure DevOps, select **...**, **Status badge**.
- Copy **Sample Markdown** to the clipboard.
- From Cloud Shell, open README.md.
- Below the H1, paste the Markdown code.
- Save the file.
- `git add README.md`
- `git commit -m "Add build badge"`
- `git push origin master`
- Set PR
- Merge it in.
- Review README.md on project home page.
