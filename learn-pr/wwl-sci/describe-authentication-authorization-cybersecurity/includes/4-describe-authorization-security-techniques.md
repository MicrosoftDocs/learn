When you authenticate a user, you'll need to decide where they can go, and what they're allowed to see and touch. This process is called authorization.

Suppose you want to spend the night in a hotel. The first thing you'll do is go to reception to start the "authentication process".  After the receptionist has verified who you are, you're given a keycard and can go to your room. Think of the keycard as the authorization process. The keycard will only let you open the doors and elevators you're permitted to access, such as for your hotel room.

In cybersecurity terms, authorization determines the level of access an authenticated person has to your data and resources. There are different security techniques that organizations use to manage authorization.

### Conditional access

As the name implies, conditional access involves access with conditions. One way to think about conditional access is with if/then statements. If something is true, you're granted access, but if it's false, you're denied.

Let’s see how this would work in an IT scenario. Increasingly, people are working from home. Because of this, they might be using their personal computer to access work-related content. With conditional access, an organization might grant access for an authenticated user to a confidential system, such as payroll, only if it's made through secure corporate computers located at their headquarters. If the authenticated user tries to access the payroll system from a personal computer at home, they would be blocked.

### Least privileged access

The concept of least privilege is where a user is granted the minimum rights that they require. This concept applies in any security-related setting.  

For example, when you board an airplane, you have access to the main cabin area to get to your seat, but no passenger is allowed in to the cockpit. Also, if you're traveling with a coach-class ticket, you will only have access to that section. To improve security, each person can only access the areas they need to.

The same concept applies in the context of cybersecurity. Take the example where users have access to a public folder on a network. If they only need to read a file, they should be given that specific permission.

A user will almost always notify an administrator if they have insufficient rights to perform their role. However, they will seldom tell an administrator if they have excess rights. So there's little risk of being over cautious when assigning user rights.

By implementing the least privileged access, you will reduce an attacker's actions if a breach occurs.

### Lateral movement

If an attacker gains access to a system, they might use the compromised account to gather more information. This could be used to infiltrate other systems or gain elevated access. The attacker can move through the system, finding more resources until their target is reached. Because the attacker will attempt to move between different sections, the final attack is unlikely to come from the initial compromised account.

Think of an office building where a criminal gets past the security of the main reception area. They can then generally move around the rest of the building, accessing different floors and offices. It's important to provide added layers of security to protect against intrusion in sensitive areas. 

For example, many office buildings require a security code to access the floors where the executive team is located. All offices on those floors are kept locked, allowing access only by employees with a special card.  You clearly don’t want a criminal to access your building at all. But by assuming a breach might occur and adding additional layers of security to protect against this type of lateral movement, you can limit the damage.

The same concept applies in an IT scenario. You start with secure authentication to reduce the chance of an attacker accessing your systems. No system is foolproof but you can provide added layers of security. These measures will help mitigate the chance that an attacker who breaks into your system can access other more sensitive resources through lateral movement.

### Zero Trust

Zero Trust is a term that's prevalent in cybersecurity. It's a method that mitigates the increasingly common attacks that we see today.

Zero Trust is a model that enables organizations to provide secure access to their resources by teaching us to “never trust, always verify”. It's based on three principles that employ concepts you're already familiar with.

- **Verify explicitly** - With Zero Trust, every request is fully authenticated and authorized before any access is granted. Organizations may implement both multifactor authentication and conditional access to ensure that every request is verified explicitly.
- **Use least privileged access** - as mentioned earlier in this unit, the concept of least privilege is to only authorize a user with the minimum rights that they require. This limits the damage that a user can do and limits lateral flows.
- **Assume breach** - By assuming that a breach has or will occur, an organization can better plan for additional layers of security. This minimizes an attacker’s radius for breaches and prevents lateral movement.

By employing a Zero Trust security model, organizations can better adapt to a modern distributed workplace that provides secure access to resources.
