In the current and previous units, we've talked about software components from the perspective of packages.

Packages are the formalized ways to distribute software components.

The licensing types and concerns about vulnerabilities extend to the packages, as these contain the components.

## Types of licenses

There are multiple licenses used in open-source, and they're different.

The license spectrum is a chart showing licenses from the developer's perspective and the implications of use for downstream requirements imposed on the overall solution and source code.

:::image type="content" source="../media/2-3-license-spectrum-2ef17187.png" alt-text="Screenshot of License spectrum.":::


On the left side, there are the "attribution" licenses. They're permissive and allow practically every type of use by the software that consumes it. An example is building commercially available software, including the components or source code under this license.

The only restriction is that the original attribution to the authors remains included in the source code or as part of the downstream use of the new software. The right side of the spectrum shows the "copyleft" licenses.

These licenses are considered viral, as the use of the source code and its components, and distribution of the complete software, implies that all source code using it should follow the same license form.

The viral nature is that the use of the software covered under this license type forces you to forward the same license for all work with or on the original software.

The middle of the spectrum shows the "downstream" or "weak copyleft" licenses. It also requires that it must do so under the same license terms when the covered code is distributed.

Unlike the copyleft licenses, it doesn't extend to improvements or additions to the covered code.
