This module explained:

* The threat landscape and risks involving unsecure software
* The OWASP Top 10 and its importance
* How you can use the Top 10 as a reference in writing more secure code.

We started by explaining the threat landscape and complexity associated with modern-day application security. Going one by one through the recently updated list OWASP Top 10 equipped us in methods and techniques malicious actors use to compromise an app. More importantly, we learned how we, the authors and maintainers of any size codebase, can improve its security posture.

Regardless of whether you're designing a brand new green-field application or contributing to large-scale open-source project, best security principles apply. Shift security left and conduct security-requirement and design reviews, perform threat modeling, and use automation to scan for vulnerabilities as you write code (with static code analysis tools) and as part of the CI/CD process. Follow compartmentalization best practices like Zero Trust and least-privilege principles.

The developers shouldn't focus on just their own code. Single-codebase monolith applications of the past have given way to microservice architecture. Distributed applications are made up of lots of moving parts, all of which are integral to their operation.

Shift security left. Don't treat security as an afterthought. The sooner you start addressing security considerations, the easier and cheaper it is to implement them. Remember the Zero Trust principles and apply them in your apps in systems.

Security code reviews, automating security checks with SAST, DAST and SCA, and threat modeling can identify most of the OWASP Top 10 items.

## Look out for unverified user input

Finally, security is a journey, not a destination. With the right mindset, you can improve an application's quality and security standpoint before you've written a single line of code.

Try thinking about the design. What files you do include in the project? What choices do you make about libraries you reference in your code? How do you handle security and authorization? Where do you store and build your code? How you deploy the application?

## Learn more

* [ASP.NET Core security topics](/aspnet/core/security)
* [Vulnerability Scanning Tools | OWASP Foundation](https://owasp.org/www-community/Vulnerability_Scanning_Tools)
* [OWASP Secure Coding Practices Quick Reference Guide](https://github.com/OWASP/secure-coding-practices-quick-reference-guide)
* [OWASP Code Review Guide](https://github.com/OWASP/www-project-code-review-guide)

## References

* [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference)
* [Overview of Microsoft Defender for Cloud DevOps security](/azure/defender-for-cloud/defender-for-devops-introduction)
* [Manage access to billing information for Azure](/azure/cost-management-billing/manage/manage-billing-access)
