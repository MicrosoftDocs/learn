CodeQL code scanning supports many languages by default with an autobuild feature. If your code uses a non-standard build process, however, you may need to customize your workflow with custom build steps.

This unit will describe how to change the languages analyzed by code scanning and how to add custom build steps to a CodeQL code scanning workflow.

## Change the languages that are analyzed

CodeQL code scanning automatically detects code written in the following supported languages: C/C++, C#, Go, Java, JavaScript/TypeScript, Python, and Ruby.

> [!NOTE]
> CodeQL is constantly updating its supported languages and frameworks, for a complete list of available languages, variants, and compilers please see the documentation<sup>[7]</sup>.

The default CodeQL analysis workflow file contains a build matrix called *language* which lists the languages in your repository that are analyzed. CodeQL automatically populates this matrix when you add code scanning to a repository. Using the language matrix optimizes CodeQL to run each analysis in parallel. We recommend that all workflows adopt this configuration due to the performance benefits of parallelizing builds.

If your repository contains code in more than one of the supported languages, you can choose which languages you want to analyze. There are several reasons you might want to prevent a language being analyzed. For example, the project might have dependencies in a different language to the main body of your code, and you might prefer not to see alerts for those dependencies.

If your workflow uses the language matrix, then CodeQL is hardcoded to analyze only the languages in the matrix. To change the languages you want to analyze, edit the value of the matrix variable. You can remove a language to prevent it from being analyzed, or you can add a language that was not present in the repository when code scanning was set up. For example, if the repository initially only contained JavaScript when code scanning was set up, and you later added Python code, you'll need to add `python` to the matrix.

```yml
jobs:
  analyze:
    name: Analyze
    ...
    strategy:
      fail-fast: false
      matrix:
        language: ['javascript', 'python']
```

If your workflow does not contain a matrix called language, then CodeQL is configured to run analysis sequentially. If you don't specify languages in the workflow, CodeQL automatically detects and attempts to analyze any supported languages in the repository. If you want to choose which languages to analyze, without using a matrix, you can use the languages parameter under the `init` action.

```yml
- uses: github/codeql-action/init@v1
  with:
    languages: cpp, csharp, python
```

## Custom build steps for code scanning

For the supported compiled languages, you can use the autobuild action in the CodeQL analysis workflow to build your code. This avoids having to specify explicit build commands for C/C++, C#, and Java. CodeQL also runs a build for Go projects to set up the project. However, in contrast to the other compiled languages, all Go files in the repository are extracted, not just those that are built. You can use custom build commands to skip extracting Go files that the build doesn't touch.

### Add build steps for a compiled language

If the C/C++, C#, or Java code in your repository has a non-standard build process, `autobuild` may fail. You will need to remove the `autobuild` step from the workflow, and manually add build steps.

After removing the `autobuild` step, uncomment the run step and add build commands that are suitable for your repository. The workflow run step runs command-line programs using the operating system's shell. You can modify these commands and add more commands to customize the build process.

```yml
- run: |
  make bootstrap
  make release
```

If your repository contains multiple compiled languages, you can specify language-specific build commands. For example, if your repository contains C/C++, C# and Java, and `autobuild` correctly builds C/C++ and C# but fails to build Java, you could use the following configuration in your workflow after the init step. This specifies build steps for Java while still using `autobuild` for C/C++ and C#:

```yml
- if: matrix.language == 'cpp' || matrix.language == 'csharp'
  name: Autobuild
  uses: github/codeql-action/autobuild@v1

- if: matrix.language == 'java'
  name: Build Java
  run: |
    make bootstrap
    make release
```
