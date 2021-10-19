Authorization determines the level of access an authenticated person has within the service that it wants to access.  There are different security techniques that organizations can use to manage authorization.

### Conditional access

As the name implies, conditional access involves access with conditions. One way to think about conditional access is if/then statements. If something is true, you are granted access, but if it is false, you are denied access.

Let’s see how this would work in an IT scenario. Increasingly, people are working from home. Because of this, they might be using their personal computer to access work-related content. With conditional access, an organization may grant an authenticated user access to a confidential system, such as a payroll system, only if that access is made through secure corporate computers located in a headquarters location. If the authenticated user tries to access the payroll system from a personal computer at home, access would be blocked.

### Least privileged access

The concept of least privilege is a concept in which a user is granted the minimum rights that they require. This is a concept that applies in any security-related setting.  

For example, when you board an airplane, you have access to the main cabin area to get to your seat, but no passenger is allowed access to the cockpit. Additionally, if you are traveling with a coach-class ticket, you will only have access to that class of service.  To improve security, each person on the plane only has access to the areas they need access to.

The same concept applies in the context of cybersecurity. Take the example where users have access to a public folder on a network. If they only require the ability to read a file, they should only be given permission to read the file and no more.

A user will almost always notify an administrator if they have insufficient rights to perform their role. A user will almost never notify an administrator if they have excess rights to perform their role. Therefore, there is little risk of being over-cautious when assigning user rights.

By implementing the least privileged access, you will reduce an attacker's actions if a breach occurs.

### Lateral movement

If an attacker gains access to a system, they might use the compromised account to gather more information. This could be used to gain access to other systems or gain elevated access. The attacker can move through the system, gaining access to more resources until their target is reached. Because the attacker will attempt to move between different accounts in an effort to gain access to other systems or elevated access, the final attack is unlikely to come from the initial compromised account.

Think of an office building. Suppose a criminal is able to get past the security of the main reception area. In that case, they can generally move around the rest of the building, accessing different floors and offices. To improve security, it is important to provide added layers of security to protect against intrusion in sensitive areas. For example, many office buildings require a security code to access the floors where the executive team is located, and all offices on those floors are kept locked, allowing access only by employees with a special access card.  Obviously, you don’t want a criminal to access your building, but by assuming a breach might occur and adding additional layers of security to protect against this type of lateral movement, you can limit the damage.

The same concept applies in an IT scenario. You want to start with secure authentication to reduce the chance of an attacker accessing your systems.  But since no system is full-proof, providing added layers of security will help mitigate the chance that an attacker that breaks into your system will be able to access other more sensitive resources through lateral movement.

### Zero trust

Zero trust is a term that is very prevalent in cybersecurity and is a method to mitigate the increasingly common attacks that we now see.

Zero trust is a security model that enables organizations to provide secure access to their resources by teaching us to “never trust, always verify”, and is based on three principles that employ concepts you are already familiar with.

- **Verify explicitly** - With Zero trust, every request is fully authenticated and authorized before any access is granted. Organizations may implement both multi-factor authentication and conditional access to ensure that every access request is verified explicitly.
- **Use least privileged access** – as mentioned earlier in this unit, the concept of least privilege is to only authorize a user with the minimum rights that they require. This limits the damage that a user can do and limits lateral flows.
Assume breach – By assuming that a breach has or will occur, an organization can better plan for additional layers of security to minimize an attacker’s radius for breaches and prevent lateral movement.

By employing a zero trust security model, organizations can better adapt to a modern distributed workplace that provides secure access to resources.
