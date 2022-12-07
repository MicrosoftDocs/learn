The objectives of the module was to explain:

* what OWASP as an non-profit organization goals are
* what OWASP Top 10 is
* how can it be used as a reference in writing more secure code.

We started by explaining  the threat landscape and complexity associated with modern day application security. Going one by one through the recently updated list OWASP Top 10 equipped us in methods and techniques used by malicious actors to compromise an app and more importantly how we, as authors and maintainers of any side codebase, can improve it's security posture.

No matter if you are  designing a brand new green field application or contributing to large-scale open source project best security principles apply. Shift security left and conduct security requirement and design reviews, perform threat modeling, use automation to scan for vulnerabilities as you write code (with static code analysis tools) and as part of the CI/CD process. Follow compartmentalization best practices zero trust and least-privilege principles.

:::row:::
    :::column:::
        :::image type="content" source="../media/attack-surface-reduction.jpg" alt-text="Microsoft Defender Threat Intelligence":::
    :::column-end:::
    :::column:::
        Microsoft Defender product family can bring best-in-class security features to your product. Defender for DevOps provides unified DevOps security management giving the team full visibility into the security posture of pre-production application code, resource configurations across GitHub, Azure DevOps, across multi-cloud and multiple-pipeline environments. You can track threat actor activity and patterns with Microsoft Defender Threat Intelligence. Defender External Attack Surface Management can help discover unmanaged resources that could be potential entry points for an attacker
    :::column-end:::
:::row-end:::

The developers should not only be focusing on just their own code. Single codebase monolith applications of the past may giving place to microservices and distributed applications are made up of lots of moving parts, all of which are integral to their operation. Things like open-source libraries, or external services used by developers (hosted source code repositories for example) or services your application is dependent on, like a Azure Key Vault, or the big one of course being identity (authentication and authorization).

:::row:::
    :::column:::
        Weather with Azure DevOps or GitHub Advanced Security remember to
        - Shift security left by automatically finding vulnerabilities early in your development workflows
        - Ensure the security and compliance of your open source components
        - Bring the expertise of top security researchers to your software projects
    :::column-end:::

    :::column:::
        :::image type="content" source="../media/dependency-graph.png" alt-text="GitHub Advanced Security":::
    :::column-end:::
:::row-end:::

Security is a journey, not a destination. With the right mindset, you can improve the quality and security standpoint of an application before you’ve even written a single line of code - by thinking about the design; think about what files you include in the project; the choices you make about libraries you use; how you handle security and authorization; where you store and build your code; how you deploy the application.

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
