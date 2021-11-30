One of the predominant ways of versioning is the use of semantic versioning.

It isn't a standard but does offer a consistent way of expressing the intent and semantics of a particular version.

It describes a version for its backward compatibility with previous versions.

Semantic versioning uses a three-part version number and an extra-label.

The version has the form of `Major.Minor.Patch` corresponds to the three types of changes covered in the previous section.

Examples of versions using the semantic versioning scheme are `1.0.0` and `3.7.129`. These versions don't have any labels.

For prerelease versions, it's customary to use a label after the regular version number.

A label is a textual suffix separated by a hyphen from the rest of the version number.

The label itself can be any text describing the nature of the prerelease.

Examples of these are `rc1`, `beta27,` and `alpha`, forming version numbers like `1.0.0-rc1` is prerelease for the upcoming `1.0.0` version.

Prereleases are a common way to prepare for the release of the label-less version of the package.

Early adopters can take a dependency on a prerelease version to build using the new package.

In general, it isn't a good idea to use a prerelease version of packages and their components for released software.

It's good to expect the impact of the new components by creating a separate branch in the codebase and using the prerelease version of the package.

Changes are that there will be incompatible changes from a prerelease to the final version.

See also [Semantic Versioning 2.0.0](https://semver.org/).
