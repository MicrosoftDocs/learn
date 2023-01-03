The objectives of the module were to explain:

* learned about the threat landscape and risks involving unsecure software
* what OWASP Top 10 is and its importance
* how can it be used as a reference in writing more secure code.

We started by explaining the threat landscape and complexity associated with modern day application security. Going one by one through the recently updated list OWASP Top 10 equipped us in methods and techniques used by malicious actors to compromise an app. More importantly we learned how we, the authors and maintainers of any size codebase, can improve it's security posture.

No matter if you are designing a brand new green field application or contributing to large-scale open source project best, security principles apply. Shift security left and conduct security requirement and design reviews, perform threat modeling, use automation to scan for vulnerabilities as you write code (with static code analysis tools) and as part of the CI/CD process. Follow compartmentalization best practices zero trust and least-privilege principles.

:::row:::
    :::column:::
        :::image type="content" source="../media/devops-metrics.png" alt-text="Microsoft Defender for DevOps":::
    :::column-end:::
    :::column:::
        The Microsoft Defender product family can bring best-in-class security features to your product. Defender for DevOps provides unified DevOps security management. The team can gain full visibility into the security posture of pre-production application code, resource configurations across GitHub, Azure DevOps, across multi-cloud and multiple-pipeline environments. You can track threat actor activity and patterns with Microsoft Defender Threat Intelligence. Defender External Attack Surface Management can help discover unmanaged resources that could be potential entry points for an attacker
    :::column-end:::
:::row-end:::

The developers shouldn't only be focusing on just their own code. Single codebase monolith applications of the past give place to microservice architecture. Distributed applications are made up of lots of moving parts, all of which are integral to their operation.

:::row:::
    :::column:::
        Whether with Azure DevOps, GitHub Advanced Security or any other service, remember to
        - Shift security left by automatically finding vulnerabilities early in your development workflows
        - Ensure the security and compliance of your open source components
        - Bring the expertise of top security researchers to your software projects
    :::column-end:::

    :::column:::
        :::image type="content" source="../media/dependency-graph.png" alt-text="GitHub Advanced Security":::
    :::column-end:::
:::row-end:::

Shift left security. Don't treat security as an afterthought. The sooner you start addressing security considerations the easier and cheeper it is to implement them.
Remember the Zero Trust principles and apply them in your apps in systems:

-**Verify explicitly.** Always authenticate and authorize based on all available data points, including user, application and device identity, location etc.

-**User least privilege access.** Limit user, application, and device access with granular permissions, role assignments, just-in-time and just-enough-access (JIT/JEA).

-**Assume breach.** Mentality help minimize the blast radius for breaches and prevent lateral movement. Enable swift replacement and rotation of credentials. Keep sessions, network access, and data encrypted end to end. Build and test durable and repeatable backup and restore processes. Avoid insecure legacy authentication and authorization protocols.

You already broke out of silo-ed approach with bringing developers and operations together with DevOps. It's about time to make security experts and champions part of your team to ensure best security practices.

Security code reviews, automation of security checks with SAST, DAST and SCA, and threat modeling can identify most of the OWASP Top 10 items.

Be on a look out for unverified user input.

Security is a journey, not a destination. With the right mindset, you can improve the quality and security standpoint of an application before you’ve even written a single line of code. Try thinking about the design; what files you include in the project; the choices you make about libraries you use; how you handle security and authorization; where you store and build your code; how you deploy the application.

## Learn more

* [ASP.NET Core security topics.](/aspnet/core/security)
* [Vulnerability Scanning Tools | OWASP Foundation.](https://owasp.org/www-community/Vulnerability_Scanning_Tools)
* [OWASP Secure Coding Practices Quick Reference Guide.](https://owasp.org/www-pdf-archive/OWASP_Code_Review_Guide-V1_1.pdf)
* [OWASP Code Review Guide.](https://owasp.org/www-pdf-archive/OWASP_SCP_Quick_Reference_Guide_v2.pdf)
* [OWASP Zap Scan - GitHub Action.](https://github.com/marketplace/actions/owasp-zap-full-scan)

## References

* [GitHub Advanced Security](/azure/active-directory/users-groups-roles/directory-assign-admin-roles)
* [Azure Defender for DevOps](/azure/defender-for-cloud/defender-for-devops-introduction)
* [Manage access to billing information for Azure](/azure/billing/billing-manage-access)
