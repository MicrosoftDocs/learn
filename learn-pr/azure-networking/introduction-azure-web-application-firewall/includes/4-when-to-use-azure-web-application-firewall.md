You know what Azure Web Application Firewall is and how it works. Now you need some criteria to help you evaluate whether Azure Web Application Firewall is a suitable choice for your company. To help you decide, let's consider the following scenarios:

- You have web apps that contain sensitive or proprietary data
- You have web apps that require users to sign in
- Your web app developers lack security expertise
- Your web app developers have other priorities
- You have web app development budget constraints
- You have web app development time constraints
- Your web app must be built and deployed quickly
- Your web app launch will be high-profile

As part of your Azure Web Application Firewall evaluation, you know that Contoso fits several of these scenarios. Read the corresponding sections for more details.

## You have web apps that contain sensitive or proprietary data

Some web attackers are motivated only by the challenge of breaking into a system. However, most malicious hackers use injection, protocol attacks, and similar exploits with payoff in mind. That payoff might be any of the following items:

- Customer credit card numbers
- Sensitive personal information, such as driver's license numbers or passport numbers
- Proprietary or secret company data

An attacker might use this data directly. For example, the user could purchase items with a stolen credit card number. More likely, however, the attacker might sell the data in a criminal marketplace or hold the data for ransom.

If your company runs one or more web apps that store sensitive or proprietary data, Azure Web Application Firewall can protect that data from intrusion and exfiltration attempts.

## You have web apps that require users to sign in

Web app attackers are often trying to obtain account usernames and passwords. Having user account credentials is useful to the attacker in the following ways:

- The attacker can access the app as an authorized user.
- The attacker might be able to run scripts or commands with elevated privileges.
- The attacker might be able to access other parts of the network.
- The attacker might be able to use an account's credentials to sign in to other sites and services.

Does your business use web apps that require users to sign in? Azure Web Application Firewall can detect exploits, such as SQL injection and local file inclusion, that attempt to display or steal account credentials.

> [!IMPORTANT]
> Keep in mind that Azure Web Application Firewall is just one aspect of what should be a multi-pronged network security strategy. For sign-in data, that strategy might also include having stringent password requirements and storing passwords in encrypted form.

## Your web app developers lack security expertise

Coding against the full range of potential web app exploits requires significant expertise. This expertise includes having detailed knowledge of the following concepts:

- The general structure of HTTP/HTTPS requests and responses
- Specific HTTP/HTTPS request types, such as GET, POST, and PUT
- URL and UTF encoding
- User agents, query strings, and other variables
- Commands, paths, shells, and similar data for multiple server operating systems
- Front-end web technologies, such as HTML, CSS, and JavaScript
- Server-side web technologies, such as SQL, PHP, and user sessions

What if your company's web-development team lacks knowledge in one or more of these concepts? In that case, your web apps are vulnerable to multiple exploits. By contrast, Azure Web Application Firewall is maintained and updated by a team of Microsoft security experts.

## Your web-app developers have other priorities

It's unlikely your company deploys its web apps for the sole purpose of thwarting exploits such as SQL injection and remote command execution. It's far more likely that your company has some other purpose for its web apps. That purpose might be to sell products, provide services, or promote your business.

Chances are you'd prefer that your web-development team focus on fulfilling these purposes rather than on writing robust app security code. With Azure Web Application Firewall, you let Microsoft manage the security while your team focuses on your business.

## You have web-app development budget constraints

Coding in-house against all the OWASP exploits is an expensive proposition:

- Web developers with the necessary security expertise are relatively rare. These developers can command higher salaries than colleagues who lack such expertise.
- Coding against the full range of web app exploits isn't a one-time-only proposition. As new or modified exploits become known, your team must constantly maintain and update its security code. Your security experts must become permanent members of your web-development team, and permanent line items in your budget.

Azure Web Application Firewall isn't free. However, you might find that it's a more cost-effective solution than hiring a team of full-time web security experts.

## You have web-app development time constraints

Many web-development teams code in-house against all the OWASP exploits. However, most of these teams soon realize that creating and maintaining this code is laborious and time-consuming. If you're trying to meet a tight deadline to launch a new web app, the thousands of person-hours required to protect the app against all the OWASP exploits is a major hurdle,

You can configure an Azure Application Gateway instance or Azure Front Door profile with Azure Web Application Firewall in minutes.

## Your web app must be built and deployed quickly

Many web apps don't require the full development treatment. For example, consider the following two app types:

- **Proof-of-concept**: The app is only meant to prove that some technique, proposal, or design is feasible.
- **Minimum viable product (MVP)**: The app includes only enough features to be usable by early adopters who provide feedback for future versions.

Both proof-of-concept and MVP web apps are meant to be created and deployed quickly. In these cases, it doesn't make sense to hand-code against common exploits. You still want to protect these apps from malicious actors, so it makes sense to place them behind a web application firewall.

## Your web app launch will be high-profile

Is your marketing team strongly promoting a soon-to-be-released web app? Are they posting messages on multiple social media platforms to drum up interest in the app ahead of its release? That's great, but do you know who else might be interested in your app's release? Malicious users who might decide to try to disrupt the app release by launching some common attacks against the app.

To avoid disruption, it might make sense to protect the web app with Azure Web Application Firewall.
