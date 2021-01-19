Some of the most common types of security threats that organizations face today are identity attacks.  Identity attacks are designed to steal the credentials used to validate or authenticate that someone or something is who they claim to be. The result is identity theft.

## Password based attacks

Password based attacks include password spray attacks and brute force attacks. A password spray attack attempts to match a username against a list of weak passwords.

Brute force attacks try many passwords against one or more accounts, sometimes using dictionaries of commonly used passwords.  When a user has assigned a weak password to their account, the hacker will find a match, and gain access to that account.

:::image type="content" source="../media/2-password-spray-attack.png" alt-text="Password spray attack":::

## Phishing

A phishing attack is when a hacker sends an email that appears to come from a reputable source. The email contains a credible story, such as a security breach, instructing the user to sign in and change their password. Instead of going to a legitimate website, the user is directed to the scammer’s website where they enter their username and password. The hacker has now captured the user’s identity, and their password.

Although many phishing scam emails are badly written and easy to identify, when users are busy or tired, they make mistakes and are more easily deceived. As hackers become more sophisticated, their phishing emails become more difficult to identify.

### Spear phishing

A spear phishing scam is a variant on phishing. Hackers build databases of information about users, which can be used to create highly credible emails. The email may appear to come from someone in your organization who is requesting information. Although careful scrutiny might uncover the fraud, users might not read it carefully enough and send the requested information or log in to the web site before they realize the fraud. It is called spear phishing because it is highly targeted.

To protect against all types of identity attacks, robust identity security and monitoring is needed.
Risk detections in Azure AD Identity Protection include any identified suspicious actions related to user accounts.

There are two types of risk: **user risk** and **sign-in risk**. **User risk** represents the probability that a given identity or account is compromised. **Sign-in risk** represents the probability that a given authentication request isn't authorized by the identity owner.
