Hundreds of open-source licenses exist, but most open-source software uses a relatively small number of popular licenses. Understanding these common licenses, their terms, and their implications helps organizations make informed decisions about which open-source components they can safely incorporate into their software.

## The license spectrum

Open-source licenses exist on a **spectrum** from highly permissive to strongly copyleft:

:::image type="content" source="../media/2-3-license-spectrum-2ef17187.png" alt-text="Screenshot of License spectrum.":::

### Permissive (attribution) licenses

**On the left side of the spectrum** are permissive licenses that impose minimal restrictions:

- **Characteristics:** Allow using code in proprietary software without requiring the proprietary software to be open-sourced.
- **Primary requirement:** Attribution—preserve copyright notices and license text.
- **Commercial use:** Fully compatible with building and selling proprietary commercial software.
- **Downstream freedom:** Users can choose whether to open-source derivative works.

**Examples:** MIT License, Apache License 2.0, BSD Licenses.

### Copyleft licenses

**On the right side of the spectrum** are copyleft licenses with strong reciprocal requirements:

- **Characteristics:** Require derivative works and combined works to use the same license.
- **Viral nature:** The license "propagates" to software that incorporates or is combined with the licensed code.
- **Source code requirement:** Distribution of binaries requires making source code available.
- **Preservation of freedom:** Ensure software remains open-source as it evolves and is incorporated into other projects.

**Examples:** GNU General Public License (GPL v2 and v3), GNU Affero General Public License (AGPL).

### Weak copyleft licenses

**In the middle of the spectrum** are weak copyleft licenses that balance openness with commercial viability:

- **Characteristics:** Require modifications to the licensed component to be open-sourced but allow incorporating the component into larger proprietary works.
- **Library-friendly:** Designed for libraries that can be used in proprietary applications.
- **File-level or module-level copyleft:** Requirements apply to the licensed component itself, not the entire application.
- **Practical balance:** Enable commercial use while ensuring improvements to the component remain open-source.

**Examples:** GNU Lesser General Public License (LGPL), Mozilla Public License (MPL), Eclipse Public License (EPL).

## Common permissive licenses

### MIT License

The **MIT License** is one of the simplest and most permissive open-source licenses:

**Key terms:**

- **Permissions:** Use, copy, modify, merge, publish, distribute, sublicense, and sell the software.
- **Conditions:** Include the copyright notice and license text in all copies or substantial portions.
- **Limitations:** No warranty, no liability for damages.

**Why projects choose MIT:**

- **Maximum adoption:** Minimal restrictions encourage widespread use.
- **Simple and clear:** Short license text that's easy to understand.
- **Commercial-friendly:** No barriers to incorporating MIT-licensed code in proprietary software.
- **Flexibility:** Users have complete freedom in how they use and distribute the software.

**Popular MIT-licensed projects:** React, Angular, Node.js, jQuery, Rails, .NET Core.

**Implications for organizations:**

- **Safe for commercial use:** Can incorporate MIT-licensed components into proprietary software without restrictions.
- **Attribution required:** Must preserve copyright notices—typically satisfied by including license text in application documentation or About dialogs.
- **No patent grant:** MIT License doesn't explicitly address patents, creating potential ambiguity.

### Apache License 2.0

The **Apache License 2.0** is a permissive license with explicit patent protection:

**Key terms:**

- **Permissions:** Use, reproduce, prepare derivative works, display, perform, sublicense, and distribute.
- **Conditions:** Include copyright notice, license text, and notice of modifications; preserve patent notices; provide attribution.
- **Patent grant:** Explicit grant of patent rights from contributors.
- **Patent retaliation:** Patent grants terminate if licensee initiates patent litigation against contributors.
- **Limitations:** No warranty, no liability, no trademark rights.

**Why projects choose Apache 2.0:**

- **Patent clarity:** Explicit patent grants provide legal certainty.
- **Modification transparency:** Requirement to document modifications promotes transparency.
- **Corporate confidence:** Clear terms and patent protections make corporations comfortable contributing.
- **Compatibility:** Compatible with GPL v3 (but not GPL v2).

**Popular Apache 2.0 projects:** Kubernetes, TensorFlow, Android, Spring Framework, Apache Hadoop, Apache Kafka.

**Implications for organizations:**

- **Patent protection:** Explicit patent grant reduces risk of patent litigation from contributors.
- **Modification notice:** Must indicate when files have been modified.
- **Attribution requirements:** Slightly more complex than MIT, requiring preservation of NOTICE files.
- **Defensive termination:** Patent grants terminate if you sue contributors for patent infringement, encouraging peaceful coexistence.

### BSD Licenses (2-Clause and 3-Clause)

The **BSD (Berkeley Software Distribution) Licenses** are permissive licenses similar to MIT:

**BSD 2-Clause (Simplified BSD):**

- **Permissions:** Redistribution and use in source and binary forms, with or without modification.
- **Conditions:** Preserve copyright notice, list of conditions, and disclaimer; retain attribution in documentation for binary distributions.
- **Limitations:** No warranty, no liability.

**BSD 3-Clause (Modified BSD):**

- **Additional condition:** Cannot use the names of copyright holders to endorse derived products without permission.
- **Trademark protection:** Prevents implying endorsement by original authors.

**Popular BSD-licensed projects:** FreeBSD, OpenBSD, parts of macOS and iOS.

**Implications for organizations:**

- **Similar to MIT:** Minimal restrictions, commercial-friendly.
- **Name usage restriction:** 3-Clause BSD prevents using project names for marketing without permission.
- **Well-established:** Long history in academic and commercial software.

## Common copyleft licenses

### GNU General Public License (GPL) v2 and v3

The **GNU General Public License** is the most well-known copyleft license:

**GPL v2 key terms:**

- **Permissions:** Use, modify, and distribute the software.
- **Conditions:** Distribute source code with binaries; derivative works must use GPL v2; preserve copyright notices.
- **Copyleft scope:** Applies to derivative works and combined works that link with GPL'd code.
- **Limitations:** No warranty, no liability.

**GPL v3 enhancements:**

- **Patent protection:** Explicit patent grants similar to Apache 2.0.
- **Tivoization prevention:** Prevents using hardware restrictions to prevent users from running modified software.
- **International compatibility:** Improved legal clarity for international jurisdictions.
- **Apache 2.0 compatibility:** Can combine GPL v3 code with Apache 2.0 code.

**Why projects choose GPL:**

- **Ensuring freedom:** GPL ensures modifications remain open-source, preventing proprietary forks.
- **Community building:** Encourages sharing improvements back to the community.
- **Philosophical alignment:** Aligns with free software philosophy that software should remain free.

**Popular GPL-licensed projects:** Linux kernel (GPL v2), Git (GPL v2), WordPress (GPL v2), GCC (GPL v3), Bash (GPL v3).

**Implications for organizations:**

- **Derivative work requirements:** If you modify GPL'd code or create derivative works, you must open-source them under GPL when distributed.
- **Linking concerns:** Linking proprietary code with GPL'd libraries can trigger copyleft requirements (interpretation varies).
- **Commercial distribution:** Can sell GPL'd software, but must provide source code to customers.
- **SaaS considerations:** GPL v2 and v3 don't require source code disclosure for software-as-a-service unless AGPL is used.

### GNU Affero General Public License (AGPL)

The **AGPL** extends GPL v3 with a network use provision:

**Additional AGPL requirement:**

- **Network copyleft:** If you modify AGPL'd software and users interact with it over a network (SaaS), you must provide source code to those users.
- **Closing the ASP loophole:** Prevents companies from modifying software and offering it as a service without sharing modifications.

**Why projects choose AGPL:**

- **SaaS protection:** Ensures cloud services can't use open-source software without contributing back.
- **Stronger copyleft:** Maximum protection against proprietary use.

**Popular AGPL-licensed projects:** MongoDB (changed from AGPL), RocketChat, Grafana.

**Implications for organizations:**

- **Avoid for SaaS:** Most organizations avoid AGPL-licensed software for service offerings because it requires open-sourcing modifications.
- **Internal use:** Can use internally without triggering requirements if not exposed to users over a network.
- **Risk assessment:** Carefully evaluate whether software qualifies as "interacting over a network."

## Common weak copyleft licenses

### GNU Lesser General Public License (LGPL)

The **LGPL** allows linking to libraries without triggering full GPL requirements:

**Key terms:**

- **Library use:** Can link to LGPL'd libraries from proprietary software without open-sourcing the proprietary application.
- **Library modifications:** Modifications to the LGPL'd library itself must be open-sourced.
- **Dynamic linking:** LGPL explicitly allows dynamic linking with proprietary code.
- **Derivative works:** Complete applications aren't derivative works just because they use LGPL'd libraries.

**Why projects choose LGPL:**

- **Library adoption:** Encourages use in proprietary software while protecting the library itself.
- **Compromise position:** Balances openness with commercial viability.
- **Standard library suitability:** Appropriate for libraries intended as standard components.

**Popular LGPL-licensed projects:** Qt (dual-licensed with commercial option), GTK, GStreamer, many C libraries.

**Implications for organizations:**

- **Can use in proprietary applications:** Safe to use LGPL'd libraries in commercial applications.
- **Must provide library source:** If you modify the LGPL'd library, provide source code for modifications.
- **Static linking complexity:** Static linking might trigger stricter requirements; dynamic linking is safer.

### Mozilla Public License (MPL) 2.0

The **MPL 2.0** provides file-level copyleft:

**Key terms:**

- **File-level copyleft:** Requirements apply only to files originally under MPL.
- **Larger work exemption:** Can combine MPL'd files with proprietary files in the same application.
- **Source code disclosure:** Must provide source code for MPL'd files.
- **Patent grant:** Includes explicit patent grant and defensive termination.
- **GPL compatibility:** MPL 2.0 is compatible with GPL.

**Why projects choose MPL 2.0:**

- **Balance:** Stronger than permissive licenses, more flexible than GPL.
- **Commercial use:** Enables commercial use while protecting the open-source component.
- **File tracking:** File-level copyleft makes compliance easier to track.

**Popular MPL-licensed projects:** Firefox, Thunderbird, LibreOffice.

**Implications for organizations:**

- **Can mix with proprietary code:** Easier integration with proprietary software than GPL.
- **File-level tracking:** Must maintain clear boundaries between MPL'd files and proprietary files.
- **Modifications shared:** Changes to MPL'd files must be shared, but additions in separate files don't.

## License compatibility

**Different licenses have different compatibility rules:**

### Compatible combinations

- **MIT + Apache 2.0:** Compatible—can combine in same project.
- **MIT + GPL v3:** Compatible—can incorporate MIT-licensed code into GPL v3 projects.
- **Apache 2.0 + GPL v3:** Compatible—GPL v3 can incorporate Apache 2.0 code.
- **LGPL + GPL:** Compatible—can upgrade LGPL to GPL.

### Incompatible combinations

- **GPL v2 + Apache 2.0:** Incompatible—cannot combine in same work.
- **GPL + Proprietary:** Incompatible—GPL requires derivative works to be GPL'd.
- **Different copyleft licenses:** Generally incompatible—cannot usually combine GPL, AGPL, and LGPL code with different copyleft licenses in ways that satisfy both.

### Compatibility considerations

**When selecting dependencies:**

- **License inventory:** Know licenses for all dependencies.
- **Compatibility checking:** Verify that licenses of different components are compatible.
- **Legal review:** Complex cases require legal expertise to evaluate compatibility.

## Dual licensing strategies

**Some projects offer multiple licensing options:**

### Open-source + Commercial

- **Strategy:** Offer under GPL (copyleft) or commercial license.
- **Rationale:** Companies wanting to incorporate in proprietary software purchase commercial license; open-source community uses GPL version.
- **Examples:** Qt, MySQL, MongoDB (changed approach).

### Multiple open-source licenses

- **Strategy:** Allow users to choose from multiple compatible licenses.
- **Rationale:** Maximize compatibility with different projects.
- **Examples:** Some libraries offer Apache 2.0 or MIT licensing options.

Understanding common open-source licenses, their terms, and their compatibility helps organizations make informed decisions about which open-source components to use and how to structure their software to maintain license compliance. The next unit explores license implications and ratings that help evaluate risks and make decisions.
