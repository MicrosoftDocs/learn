

Security analysts spend a significant amount of time on data discovery, collection, and parsing, instead of focusing on what actually helps their organization defend themselves--deriving insights about the actors through analysis and correlation.

Microsoft Defender Threat Intelligence (Defender TI) helps streamline security analyst triage, incident response, threat hunting, and vulnerability management workflows. Defender TI aggregates and enriches critical threat information in an easy-to-use interface.

From Defender TI’s Threat Intelligence Home Page, analysts can quickly scan new featured articles and begin their intelligence gathering, triage, incident response, and hunting efforts by performing a keyword, artifact or Common Vulnerabilities and Exposure ID (CVE-ID) search.

The featured article section of the Defender TI Threat Intelligence Home Page shows you the featured Microsoft content.

:::image type="content" source="../media/defender-ti-home-page-inline.png" lightbox="../media/defender-ti-home-page-expanded.png" alt-text="A screenshot of the home page for Microsoft Defender Threat Intelligence.":::

### Defender TI articles

Articles are narratives by Microsoft that provide insight into threat actors, tooling, attacks, and vulnerabilities. Defender TI articles aren't blog posts about threat intelligence; while they summarize different threats, they also link to actionable content and key indicators of compromise to help users take action.  

The description section of the article contains information about the attack or attacker profiled. The public indicators section of the screen shows the previously published indicators related to the article. The links in the public indicators take one to the underlying Defender TI data or relevant external sources. The Defender TI indicators section covers the indicators that Defender TI’s research team has found and added to the articles.

:::image type="content" source="../media/defender-ti-article-inline.png" lightbox="../media/defender-ti-article-expanded.png" alt-text="A screenshot of a Defender TI article showing the tabs for description, public indicators, and Defender TI indicators.":::

### Vulnerability articles

Defender TI offers CVE-ID searches to help users identify critical information about the CVE. CVE-ID searches result in Vulnerability Articles.

Vulnerability Articles provide key context behind CVEs of interest. Each article contains a description of the CVE, a list of affected components, tailored mitigation procedures and strategies, related intelligence articles, references in Deep & Dark Web chatter, and other key observations.

Vulnerability Articles also include a Defender TI Priority Score and severity indicator (high, medium, low). The Defender TI Priority Score is a unique algorithm that reflects the priority of a CVE based on the Common Vulnerability Scoring System (CVSS) score, exploits, chatter, and linkage to malware. Furthermore, the Defender TI Priority Score evaluates the recency of these components so users can understand which CVEs should be remediated first.

:::image type="content" source="../media/defender-ti-vulnerability-article-inline.png" lightbox="../media/defender-ti-vulnerability-article-expanded.png" alt-text="A screenshot of a Defender TI vulnerability article showing the CVE-ID, priority score, and description.":::

### Data sets

Microsoft centralizes numerous data sets into a single platform, Defender TI, making it easier for Microsoft’s community and customers to conduct infrastructure analysis. Microsoft’s primary focus is to provide as much data as possible about Internet infrastructure to support a variety of security use cases.

Microsoft collects, analyzes, and indexes internet data to assist users in detecting and responding to threats, prioritizing incidents, and proactively identifying the infrastructure of adversaries that are targeting organizations.

This internet data is categorized into two distinct groups: traditional and advanced. Traditional data sets include Resolutions, WHOIS, SSL Certificates, Subdomains, DNS, Reverse DNS, and Services. Advanced data sets include Trackers, Components, Host Pairs, and Cookies. Trackers, Components, Host Pairs, and Cookies data sets are collected from observing the Document Object Model (DOM) of web pages crawled.

:::image type="content" source="../media/defender-ti-data-v2-inline.png" lightbox="../media/defender-ti-data-v2-expanded.png" alt-text="A screenshot of an excerpt from a Defender TI article showing a reputation score, analyst insight, and tabs for traditional and advanced internet data.":::

#### Reputation scoring and analyst insights

Defender TI provides proprietary reputation scores for any Host, Domain, or IP Address. Whether validating the reputation of a known or unknown entity, this score helps users quickly understand any detected ties to malicious or suspicious infrastructure.

Analyst insights distill Microsoft’s vast data set into a handful of observations that simplify the investigation and make it more approachable to analysts of all levels. Insights are meant to be small facts or observations about a domain or IP address and provide Defender TI users with the ability to make an assessment about the artifact queried and improve a user's ability to determine if an indicator being investigated is malicious, suspicious, or benign.
