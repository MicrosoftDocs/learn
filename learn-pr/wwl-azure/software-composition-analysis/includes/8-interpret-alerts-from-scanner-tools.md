
To correctly interpret the results of scanning tools, you need to be aware of some aspects:

 -  **False positives** It's essential to verify the findings to be real positives in the scan results. The tooling is an automated way to scan and might be misinterpreting specific vulnerabilities. In the triaging of the finding in the scan results, you should be aware that some findings might not be correct. Such results are called `false positives`, established by human interpretation and expertise. One must not declare a result a false positive too quickly. On the other hand, scan results aren't guaranteed to be 100% accurate.
 -  **Security bug bar** Most likely, many security vulnerabilities will be detected—some of these `false positives`, but still many findings. More findings can often be handled or mitigated, given a certain amount of time and money. In such cases, there must be a security bug bar indicating the level of vulnerabilities that must be fixed before the security risks are acceptable enough to take the software into production. The bug bar makes sure that it's clear what must be taken care of and what might be done if time and resources are left.

The results of the tooling scan will be the basis for selecting what work remains to be done before the software is considered stable and done.

By setting a security bug bar in the Definition of Done and specifying the allowed license ratings, one can use the reports from the scans to find the work for the development team.
