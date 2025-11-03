**Open-source licenses** are legal agreements that define how open-source software can be used, modified, and distributed. Every open-source project includes a license that specifies the rights granted to users and any obligations they must fulfill. Understanding licenses is essential for legally and safely implementing open-source software in organizational contexts.

## What open-source licenses define

An **open-source license** is a legal document that accompanies source code and specifies:

### Permissions granted

**Licenses explicitly grant users certain rights:**

- **Use rights:** Permission to use the software for any purpose, including commercial applications.
- **Modification rights:** Permission to modify the source code to suit specific needs, fix bugs, or add features.
- **Distribution rights:** Permission to share the software with others, either in original or modified form.
- **Sublicensing rights:** In some cases, permission to license the software to others under different terms.

Without an explicit license, copyright law prohibits using, modifying, or distributing software. The license provides legal permission for these activities.

### Obligations imposed

**Licenses typically impose requirements on users:**

- **Attribution requirements:** Must preserve copyright notices and license text in distributed copies.
- **Source code disclosure:** Some licenses require providing source code when distributing binaries.
- **License preservation:** Must include the license text with distributed copies.
- **Derivative work licensing:** Some licenses require derivative works to use the same license (copyleft).
- **Patent grants:** Some licenses include explicit patent grants or defensive termination clauses.

### Liability and warranty disclaimers

**Nearly all open-source licenses disclaim liability and warranties:**

- **No warranty:** Software is provided "as is" without warranties of merchantability, fitness for purpose, or non-infringement.
- **No liability:** Authors and copyright holders aren't liable for damages resulting from software use.
- **User risk:** Users accept all risks associated with using the software.

These disclaimers protect open-source developers from legal liability, recognizing that software is typically provided freely without compensation.

## The Open Source Definition

The **Open Source Initiative (OSI)** maintains the authoritative **Open Source Definition** that specifies criteria for licenses to be considered truly open-source:

### Core requirements

According to the [Open Source Definition](http://opensource.org/osd), open-source licenses must:

**Free redistribution:**

- **No restrictions:** Licenses cannot restrict anyone from selling or giving away the software as part of an aggregate distribution.
- **No royalties:** Licenses cannot require royalties or fees for such sales.

**Source code inclusion:**

- **Availability:** Distributed programs must include source code or provide clear instructions for obtaining it at no cost.
- **Preferred form:** Source code must be in the form preferred for modifications.
- **No obfuscation:** Deliberately obfuscated source code doesn't satisfy the requirement.

**Derived works:**

- **Modifications allowed:** Licenses must permit modifications and derived works.
- **Same terms:** Licenses must allow distribution of modifications under the same terms as the original software.

**Integrity of author's source code:**

- **Patch files:** Licenses may require modifications to be distributed as patch files alongside the original source.
- **Naming:** Licenses may require derived works to use different names or version numbers from the original.

**No discrimination against persons or groups:**

- **Universal access:** Licenses cannot discriminate against any person or group of persons.
- **Equal rights:** Everyone must have the same rights to use the software.

**No discrimination against fields of endeavor:**

- **Any purpose:** Licenses cannot restrict the software from being used in specific fields like business or genetic research.
- **Commercial use:** Licenses cannot prohibit using the software in commercial applications.

**Distribution of license:**

- **Automatic application:** Rights attached to the program must apply to everyone to whom the program is redistributed.
- **No additional licenses:** Users shouldn't need to execute additional licenses to receive these rights.

**License must not be specific to a product:**

- **Standalone rights:** Rights must not depend on the program being part of a particular software distribution.
- **Independent execution:** If extracted from the original distribution, the software must carry the same rights.

**License must not restrict other software:**

- **No contamination:** Licenses cannot impose restrictions on other software distributed together with the licensed software.
- **Aggregation allowed:** Licenses cannot prevent distributing the software alongside software under different licenses.

**License must be technology-neutral:**

- **No interface restrictions:** Licenses cannot require specific technologies or interface styles.
- **Execution method agnostic:** Licenses shouldn't care whether software is executed through clicking icons, command lines, or web interfaces.

### Why these requirements matter

The Open Source Definition ensures licenses provide meaningful freedom:

**Protects user freedom:** Requirements prevent licenses from imposing hidden restrictions that would undermine open-source principles.

**Enables commercial use:** By prohibiting discrimination against fields of endeavor, the definition ensures businesses can build products using open-source software.

**Promotes compatibility:** Requirements limiting how licenses can affect other software reduce compatibility problems.

**Prevents fragmentation:** By requiring reasonable terms, the definition prevents a proliferation of incompatible quasi-open licenses.

## Categories of open-source licenses

While many different open-source licenses exist, they generally fall into two broad categories:

### Permissive licenses

**Permissive licenses** impose minimal requirements on derivative works:

- **Characteristics:** Allow incorporating code into proprietary software without requiring the proprietary software to be open-sourced.
- **Requirements:** Typically only require attribution (preserving copyright notices and license text).
- **Commercial use:** Fully compatible with commercial software development.
- **Examples:** MIT License, Apache License 2.0, BSD Licenses.

Permissive licenses maximize freedom for users, allowing them to create closed-source commercial products incorporating open-source code.

### Copyleft licenses

**Copyleft licenses** require derivative works to use the same license:

- **Characteristics:** Ensure modified versions and derivative works remain open-source.
- **Requirements:** Require distributing source code and using the same license for derivative works.
- **Commercial use:** Can be used in commercial software, but derivative works must be open-sourced.
- **Examples:** GNU General Public License (GPL), GNU Lesser General Public License (LGPL), Mozilla Public License (MPL).

Copyleft licenses prioritize software freedom over user freedom, ensuring open-source software remains open-source even as it evolves.

### Weak copyleft

**Some licenses occupy a middle ground:**

- **Library use allowed:** Allow linking to libraries in proprietary applications without open-sourcing the application.
- **Modification restrictions:** Modifications to the library itself must be open-sourced.
- **Examples:** GNU LGPL, Mozilla Public License.

Weak copyleft licenses balance promoting open-source development with enabling commercial use.

## License selection by projects

Open-source projects choose licenses based on their goals:

**Maximizing adoption:** Projects prioritizing widespread adoption typically choose permissive licenses that don't impose significant obligations on users.

**Ensuring freedom:** Projects prioritizing software freedom choose copyleft licenses that ensure derivative works remain open-source.

**Preventing proprietary forks:** Copyleft licenses prevent companies from creating proprietary versions of open-source software.

**Patent protection:** Projects concerned about patents choose licenses with explicit patent grants (like Apache 2.0) that provide clearer patent rights.

**Compatibility:** Projects might choose licenses compatible with other software they depend on or want to integrate with.

## Multiple licenses

**Some projects use multiple licensing strategies:**

**Dual licensing:** Offer software under both open-source and commercial licenses, letting users choose which terms apply.

**License stacking:** Different components of a project might have different licenses.

**License evolution:** Projects sometimes change licenses over time, though this requires agreement from all contributors.

## The transparency paradox

Source code transparency creates both security benefits and risks:

### Security benefits of transparency

**Public source code enables security improvements:**

- **Many eyes:** Thousands of developers can review code for vulnerabilities, increasing the likelihood of discovery.
- **Faster disclosure:** When vulnerabilities are found, they can be disclosed and patched publicly, informing all users.
- **Community patches:** Security-conscious developers contribute patches to fix vulnerabilities.
- **Audit capability:** Organizations can audit open-source dependencies for security issues, which is impossible with closed-source software.

### Security risks of transparency

**Public source code also assists attackers:**

- **Vulnerability discovery:** Malicious actors can analyze source code to find exploitable vulnerabilities.
- **Exploit development:** Understanding implementation details helps attackers develop exploits.
- **Target identification:** Attackers can identify which applications use vulnerable versions of open-source components.
- **Zero-day exploitation:** Attackers might discover and exploit vulnerabilities before they're publicly disclosed.

### The balance

**Research suggests transparency provides net security benefits:**

**Linus's Law:** "Given enough eyeballs, all bugs are shallow." Open review generally finds and fixes vulnerabilities faster than closed-source development.

**Obscurity isn't security:** Keeping source code secret doesn't prevent vulnerabilities—it just hides them until attackers eventually discover them.

**Responsible disclosure:** The open-source community has developed responsible disclosure practices that balance security with transparency.

**Practical reality:** Most severe security breaches involve closed-source software or misconfiguration, not open-source vulnerabilities, suggesting transparency doesn't inherently reduce security.

Understanding open-source licenses and their categories provides the foundation for evaluating specific licenses. The next unit explores common open-source licenses in detail, helping you understand what terms popular licenses impose and how they differ.
