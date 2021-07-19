Consider the details of the types of cyberattacks that the previous unit described.  What are some mitigation strategies and policies to prevent them?

## Use multifactor authentication

Multifactor authentication is the process of using two or more methods to verify identity. The methods include:
- Something you know (such as a PIN or a password)
- Something you have (such as a cell phone or token)
- Something you are (such as biometric physical characteristics)

The Conditional Access Policy of the social media service enables the enforcement of multifactor authentication.

## Browser security

### Securing connections with websites

The data transferred using HTTP is not encrypted and is readable by someone intercepting your communications. Using HTTPS ensures your communications between you and the website are encrypted, even if you’re using a public Wi-Fi network. Most websites have switched to always using HTTPS, but some have not. It’s recommended for you to install the HTTPS Everywhere plug-in for your browser. The plug-in automatically requests a site to switch from insecure HTTP to secure HTTPS.

### A browser allows for private mode

All the most common browsers offer a private browsing mode. For example, on Chrome, it is called an incognito window, and on Microsoft Edge, it is called an InPrivate Window. When you choose this mode, it offers a higher level of privacy. This privacy stems from your browsing history being deleted when you close all windows of the private mode browser. Additionally, private browsing deletes the logging of sites visited and temporary files or cookies stored on your computer. However, it won't hide browsing history from your school, employer, or ISP.

### Certificates checks are critical

A secure browser will check the status of certificates that are set by various websites. They are checked to determine if the certificate is from a valid domain and if it’s expired. Valid website certificates are keys to determine that the website is not pretending to be the requested site. The public certificates come from a Certificate Authority (CA) and the organization installs the certificates on their website. The browser can verify the server identity by checking the certificate store. This certificate check is maintained by the browser vendor.

### Keep your browser updated

Keep your browser and your operating system updated and patched. Security vulnerabilities are typically fixed promptly. Vulnerabilities in the render engine and JavaScript engine, when patched, prevent the running of malicious code. The browser vendor and the end user can help ensure that their browser is up to date.

### Enable Pop-ups blocker by default

Pop-ups are typically small advertising ads that appear without permission. They’re created by JavaScript code embedded in the HTML webpage. These pop-ups can contain links to malicious software that could be downloaded to your computer. On modern browsers, the pop-up blocker is enabled by default. As the browser user, it's recommended to leave the pop-up blocker on. Or, enable it if it's not turned on.

### Consider using a Password Manager

A Password Manager enforces password controls. These controls include storing passwords, enforcement of password changes and length, encrypted forms, checks for multiple uses of the same password, and avoidance of onscreen password displays. The passwords are stored in a secure off-site storage vault. These managers also recommend using two-factor authentication. Using a Password Manager means that you only need to remember your vault master password. The managers have a plug-in for browsers and desktop applications. Passwords changed on one device are automatically accessible from other devices after you enter the master password. An end user can typically makes this choice.

## Defeat social engineering attacks

Currently, the most successful method for protecting our security depends heavily on training individuals. The training needs to be interesting, engaging, up-to-date, and easy to access. Organizations can reinforce learning by using tools such as attack-simulation training in Microsoft Defender for Office 365. The attack simulator training lets administrators run benign cyber attack simulations on your organization to test your security policies and practices. The following example is a fake testing Microsoft notice about “Unusual Sign-in activity." The email directs users to a malicious website and is from a fake Microsoft account. 

:::image type="content" source="../media/4-ms-tech-support-scam.png" alt-text="A fake message supposedly from Microsoft Support using a fictitious email account." border="false":::

Some rules of thumb to help protect yourself and your company from social media hackers.

- Examine all your social network settings. Enable two-factor authentication. Two-factor authentication is the most common form of multifactor authentication.
- Avoid sharing your work email address.
- Know that most companies will never send an email to verify your credentials.
- Hover your pointer or navigate to an email or text link without selecting it to observe the actual URL underneath the words.
- Use cloud-based antivirus (AV) solutions like Microsoft Windows Defender on a Windows 10 device. Windows Defender leverages Azure for faster analysis instead of waiting for traditional AV definitions to be delivered.
- Before you post to social media, think about the information that can be harvested from it.
- Don’t select links in *call-to-action* messages that demand action such as "do this now, or something terrible will happen!" Instead, open a web browser and access that company’s website and your account. If it’s authentic, that message will be there also.
- Keep your operating system and its apps patched and updated.
