Instead of running code scanning in GitHub, you can perform analysis elsewhere and then upload the results. Alerts for code scanning that you run externally are displayed in the same way as those you run within GitHub. You can upload Static Analysis Results Interchange Format (SARIF) files generated outside GitHub or with GitHub Actions to see code scanning alerts from third-party tools in your repository.

In this unit, you'll learn how to enable code scanning with third-party tools and how to use and upload SARIF files.

### About SARIF file uploads for code scanning

GitHub creates code-scanning alerts in a repository using information from SARIF files. You can generate SARIF files using many static analysis-security testing tools, including CodeQL. The results must use SARIF version 2.1.0.

You can upload the results using the code-scanning API, the CodeQL CLI, or GitHub Actions. The best upload method will depend on how you generated the SARIF file.

#### Code-scanning API

The code-scanning API lets you retrieve information on code scanning alerts, analyses, databases, and default setup configuration from a repository. Additionally, you can update code-scanning alerts and the default setup configuration. You can use the endpoints to create automated reports for the code-scanning alerts in an organization or upload analysis results generated using offline code-scanning tools.

You can access the GitHub API over HTTPS from `https://api.github.com`. All data is sent and received as JSON. The API uses custom media types to let consumers choose the format of the data they wish to receive. Media types are specific to resources, allowing them to change independently and support formats that other resources don't.

There is one supported custom media type for the code scanning REST API, `application/sarif+json`.

You can use this media type with GET requests sent to the `/analyses/{analysis_id}` endpoint. When you use this media type with this operation, the response includes a subset of the actual data that was uploaded for the specified analysis, rather than the summary of the analysis that's returned when you use the default media type. The response also includes additional data such as the `github/alertNumber` and `github/alertUrl` properties. The data is formatted as SARIF version 2.1.0.

The following is an example cURL command using the API to list the code scanning alerts for an organization:

```
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/ORG/code-scanning/alerts
```

Review the [GitHub REST API docs](https://docs.github.com/rest/reference/code-scanning) for more information about the using the code scanning API. 

#### CodeQL CLI

The CodeQL CLI is a standalone product that you can use to analyze code. Its main purpose is to generate a database representation of a codebase, a CodeQL database. Once the database is ready, you can query it interactively, or run a suite of queries to generate a set of results in SARIF format and upload the results to GitHub.com. The CodeQL CLI is free to use on public repositories that are maintained on GitHub.com, and available to use on private repositories that are owned by customers with an Advanced Security license. Download the CodeQL bundle from https://github.com/github/codeql-action/releases.

The bundle contains:

- CodeQL CLI product
- A compatible version of the queries and libraries from https://github.com/github/codeql
- Precompiled versions of all the queries included in the bundle

You should always use the CodeQL bundle, because this ensures compatibility and also gives much better performance than a separate download of the CodeQL CLI and checkout of the CodeQL queries.

#### Code-scanning analysis with GitHub Actions
  
To use GitHub Actions to upload a third-party SARIF file to a repository, you'll need a GitHub Actions workflow. A GitHub Actions workflow is an automated process, made up of one or more jobs, configured as a `.yml` file. Workflows are stored in the `.github/workflows` directory for your repository.

Your workflow uses the `upload-sarif` action, which is part of the `github/codeql-action` repository. This workflow includes input parameters that you can use to configure the upload.

The main input parameter is `sarif-file`, which configures the file or directory of SARIF files to be uploaded. The directory or file path is relative to the root of the repository.

The `upload-sarif` action can be configured to run when the `push` and `scheduled` event occurs.

This example outlines the elements of the `upload-sarif` action yml file:

```
name: 'Code Scanning : Upload SARIF'
description: 'Upload the analysis results'
author: 'GitHub'
inputs:
  sarif_file:
    description: |
      The SARIF file or directory of SARIF files to be uploaded to GitHub code scanning.
      See https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/
      uploading-a-sarif-file-to-github#uploading-a-code-scanning-analysis-with-github-actions
      for information on the maximum number of results and maximum file size supported by code scanning.
    required: false
    default: '../results'
  checkout_path:
    description: "The path at which the analyzed repository was checked out. 
    Used to relativize any absolute paths in the uploaded SARIF file."
    required: false
    default: ${{ github.workspace }}
  token:
    default: ${{ github.token }}
  matrix:
    default: ${{ toJson(matrix) }}
  category:
    description: String used by Code Scanning for matching the analyses
    required: false
  wait-for-processing:
    description: If true, the Action will wait for the uploaded SARIF to be processed before completing.
    required: true
    default: "false"
runs:
  using: 'node12'
  main: '../lib/upload-sarif-action.js' 
```

Each time the results of a new code scan are uploaded, the results are processed and alerts are added to the repository. GitHub uses properties in the SARIF file to display alerts. For example, to prevent duplicate alerts for the same problem, code scanning uses fingerprints to match results across various runs so they only appear once in the latest run for the selected branch. SARIF files created by the CodeQL analysis workflow include this fingerprint data in the `partialFingerprints` field. If you upload a SARIF file using the `upload-sarif` action and this data is missing, GitHub attempts to populate the `partialFingerprints` field from the source files.

If your SARIF file doesn't include `partialFingerprints`, the `upload-sarif` action will calculate the `partialFingerprints` field for you and attempt to prevent duplicate alerts. GitHub can only create `partialFingerprints` when the repository contains both the SARIF file and the source code used in the static analysis.

SARIF upload supports a maximum of 5000 results per upload. Any results over this limit are ignored. If a tool generates too many results, you should update the configuration to focus on results for the most important rules or queries.

For each upload, SARIF upload supports a maximum size of 10 MB for the gzip-compressed SARIF file. Any uploads over this limit will be rejected. If your SARIF file is too large because it contains too many results, you should update the configuration to focus on results for the most important rules or queries.

#### Upload SARIF files generated outside your repository

You can also create a new workflow that uploads SARIF files after you commit them to your repository. This is useful when the SARIF file is generated as an artifact outside of your repository.

In the following example, the workflow runs anytime commits are pushed to the repository. The action uses the `partialFingerprints` property to determine if changes have occurred.

In addition to running when commits are pushed, the workflow is scheduled to run once per week. This workflow uploads the `results.sarif` file located in the root of the repository. You could also modify this workflow to upload a directory of SARIF files. For example, you could place all SARIF files in a directory in the root of your repository called `sarif-output` and set the action's input parameter `sarif_file` to `sarif-output`.

  ```
  name: "Upload SARIF"
  
  // Run workflow each time code is pushed to your repository and on a schedule. 
  //The scheduled workflow runs every Thursday at 15:45 UTC.
  
  on:
    push:
    schedule:
      - cron: '45 15 * * 4'

  jobs:
    build:
      runs-on: ubuntu-latest
      permissions:
        security-events: write
    steps:
      # This step checks out a copy of your repository.
      - name: Checkout repository
        uses: actions/checkout@v2
      - name: Upload SARIF file
        uses: github/codeql-action/upload-sarif@v1
        with:
          # Path to SARIF file relative to the root of the repository
          sarif_file: results.sarif 
  ```

#### Upload SARIF files generated as part of a CI workflow

If you generate your third-party SARIF file as part of a continuous integration (CI) workflow, you can add the `upload-sarif` action as a step after running your CI tests. If you don't already have a CI workflow, you can create one using a starter workflow in the [https://github.com/actions/starter-workflows](https://github.com/actions/starter-workflows) repository.

In this example, the workflow runs anytime commits are pushed to the repository. The action uses the `partialFingerprints` property to determine if changes have occurred. In addition to running when commits are pushed, the workflow is scheduled to run once per week.

This example shows the ESLint static analysis tool as a step in a workflow. The `Run ESLint` step runs the ESLint tool and outputs the `results.sarif` file. The workflow then uploads the `results.sarif` file to GitHub using the `upload-sarif` action.

      ```
      name: "ESLint analysis"

    // Run workflow each time code is pushed to your repository and on a schedule.
    // The scheduled workflow runs every Wednesday at 15:45 UTC.
    on:
      push:
      schedule:
        - cron: '45 15 * * 3'

    jobs:
      build:
        runs-on: ubuntu-latest
        permissions:
          security-events: write
        steps:
          - uses: actions/checkout@v2
          - name: Run npm install
            run: npm install
          // Runs the ESlint code analysis
          - name: Run ESLint
            // eslint exits 1 if it finds anything to report
            run: node_modules/.bin/eslint build docs lib script spec-main -f node_modules/@microsoft/eslint-formatter-sarif/sarif.js -o results.sarif || true
          // Uploads results.sarif to GitHub repository using the upload-sarif action
          - uses: github/codeql-action/upload-sarif@v1
            with:
              // Path to SARIF file relative to the root of the repository
              sarif_file: results.sarif
      ```

