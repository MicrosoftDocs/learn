Unit 3: Examine common code security issues

Purpose: Provide background on prevalent security vulnerabilities in code, so learners can recognize and understand the significance of the issues they’ll fix. This unit covers the “what and why” of common bugs, complementing the practical fixes they’ll do later.

## Why Focus on Security Issues?

Start with a reality check: the majority of serious bug fix efforts in many software teams revolve around security these days – because a single vulnerability can cost millions (breach, reputation loss, etc.). An expert might share: “In my 20 years, I’ve learned that functional bugs embarrass you; security bugs can ruin you.” Emphasize that even if one isn’t a security engineer, every developer must be security-conscious.

## OWASP Top 10 (brief intro)

Mention that there is an industry-agreed list of top web app risks – the OWASP Top 10[1]. You don’t need to delve deep, but highlight that many issues we discuss fall under those categories. For instance, injection flaws are usually ranked very high (in 2017 OWASP, Injection was #1; in 2021, it’s still in the top 3). This validates that what we cover isn’t hypothetical – it’s literally top-priority stuff in the industry.

## Vulnerability 1 – Injection (SQL & more)

Explain SQL Injection clearly. Perhaps show a tiny code snippet of bad practice vs good (like sql = "WHERE name = '" + userInput + "'" vs using a parameter). Use the example from ShopEasy: an attacker’s input ' OR '1'='1 turning a query into something else[1]. Also mention other types of injection (NoSQL injection, command injection, etc.) to broaden perspective: “Any time you insert untrusted input into a command or query that gets interpreted, you risk injection. The solution pattern is always similar: sanitize or parameterize to separate code from data[1].” Copilot can help by suggesting parameterized queries, which we’ll see. Signpost: “In the lab, you’ll actually implement a fix for SQL injection with Copilot’s help.”

## Vulnerability 2 – Weak/No Encryption of Sensitive Data

Cover things like storing passwords in plaintext (or unsalted hashes) and transmitting or saving data without encryption. Our lab covers password hashing and file encryption:

o	Password Storage: Explain why plaintext is bad (if DB is compromised, all passwords are immediately lost). Even hashing with MD5 or SHA1 is insufficient now – GPUs can brute force them quickly. Introduce the concept of salt and slow hashing (bcrypt, PBKDF2) without too much crypto theory, just: “Salt prevents use of precomputed hash tables, and a slow algorithm means an attacker can only test hundreds, not billions, of guesses per second.” Mention real breaches: “LinkedIn 2012 breach happened with unsalted SHA1; attackers cracked millions of passwords. Companies learned from that – you should never be using fast hashes for passwords.”

o	Data at Rest/Transit: If data contains PII or sensitive info, not encrypting it can lead to exposure. Give an example: “Imagine a laptop with customer data files gets stolen. If those files are plaintext, it’s all out in the open. Encrypting them would at least offer protection.” Similarly, mention encryption in transit (TLS) but focus on at rest for our context. In the lab, we encrypt an output file; in real life, one might also use database encryption, etc.

## Vulnerability 3 – Logging and Error Handling Issues

Logging sensitive data is a subset of data exposure. Share the Twitter example we alluded to: “In 2018, Twitter discovered it had been logging user passwords in plaintext internally – they had to notify hundreds of millions of users to change passwords. It was a costly reminder that even logs must be treated carefully.” So our motto becomes: Never log secrets or personal data in plain form. Also, error handling can leak info: an exception printout might reveal file paths, server config, etc. That’s why we often sanitize error messages in production. An expert might say, “Clients/users should see friendly, minimal errors. Detailed errors go to secure logs for developers. And even those logs shouldn’t have private data.”

## Vulnerability 4 – File Handling Flaws (Path Traversal)

Explain path traversal in more detail. “Path traversal is when an attacker tricks the system into treating a portion of input as filesystem navigation. Those ../ sequences (or on Windows, maybe C:\) can break out of the intended folder sandbox. If I have a file upload feature and I don’t validate filenames, someone could potentially upload a file to ../web.config and overwrite configuration, or download ../../etc/passwd on a Linux server.” Mention that this is commonly missed by devs who assume “no one would think to do that” – but attackers do. The fix is to sanitize and constrain paths (whitelist allowed directories, strip dangerous substrings, etc.). 

## Other Notable Issues

Quickly list a couple of other issues (even if not in lab) just to round out their awareness:

o	Cross-Site Scripting (XSS): injecting scripts into web pages (not relevant to our console apps, but web devs must know it).

o	Hard-coded Secrets: while we removed it from the lab to avoid secret scanning, explain it conceptually: “If you put API keys or passwords in code, anyone with repo access (or a leaked repo) has them. Plus, you can’t rotate them easily. Always externalize secrets to config or vaults.” The learner will cover secret scanning in another module, but a quick mention ties it together.

o	Memory/Resource Leaks or DoS: e.g., reading a huge file into memory (like our tool did) could crash the app – not a security breach, but an availability issue. Many small things can become big if not handled (like not limiting the number of items a user can request – leading to an intended denial of service).

## How to Spot These Issues

Provide some heuristics or patterns:

o	Look for user input usage – every place you handle input is a checkpoint: “Am I trusting this too much?” If you see input fed into system commands, queries, or critical logic, think injection.

o	Look for crypto usage – if you see MD5.Create() or SHA1, that’s a smell. Modern code should be using stronger libs (e.g., SHA256 with salt for integrity, or specialized password hashing). Copilot can actually help flag these; when you asked it why MD5 was an issue, it knew.

o	Look at logging and printing – scan for things like .WriteLine(password) or sensitive fields. Often it’s as easy as grepping for certain keywords like “password”, “secret”, “card” in the code.

o	For file paths – if code opens a file based on input, check if it sanitizes it. Also note functions like Path.Combine vs manual string concat (the latter can be error-prone).

o	Ask tools for help: This is where Copilot and other static analyzers come in. Copilot’s code analysis in Ask mode can identify issues (you experienced that in the lab scenario, asking it about the code). GitHub’s CodeQL or other linters can also flag obvious mistakes. A senior dev would combine personal code reviews with automated checks for best coverage.

## Shift Left on Security

Catching these issues early (during coding or code review) is far better than after deployment. The fact that we’re doing a module on fixing them means something slipped by – ideally, we want to integrate practices to avoid that. Foreshadow that in the next unit (preventing issues) we’ll address this proactive stance.

By the end of Unit 3, the learner should feel more confident in identifying potential security issues and understand why they are critical to fix. In essence, we’ve primed them with the “eyes of an expert” – so when they see such patterns in any code (not just this lab), alarm bells will ring. This theoretical knowledge also reinforces the importance of what they’ll do in the lab: it’s not just to make the error message go away, it’s to protect the application from real threats.

