# Pre-publication checklist

## Content/Media/assets
- [X] Remove regions ("en-US") from URLs that do not require it
- [X] Final images/screenshots are present
- [X] Badge images are present
- [X] Verify Acrolinx score for all content (score > 80)

## Index.yml
- [X] title is set and conforms to standards
- [X] description is set and follows guidelines (doesn't duplicate title)
- [X] summary is set and follows guidelines
- [ ] ~~cardDescription is set if summary is more than 2 sentences~~
- [X] abstract is set and lists objectives (no periods)
- [X] prerequisites are set, or set to "None"
- [X] ms.date is set to the initial publish date
- [X] author is set to the GitHub username of a full-time Microsoft employee
- [X] ms.author is set to the Microsoft alias of a full-time Microsoft employee
- [X] ms.prod is set to "learning-azure"
- [X] iconUrl is set and points to a valid svg
- [X] badge has uid child node and uses module UID + ".badge"
- [X] all units are listed in the proper order

## Unit YAML files
- [X] uid is set and matches index.yml
- [X] title is set and conforms to standards
- [X] ms.date is set to the initial publish date
- [X] author is set to the identical GitHub username of the module
- [X] ms.author is set to the identical Microsoft alias of the module
- [X] durationInMinutes is set to an accurate value
- [ ] ~~interactive is set to bash or powershell (if cloud shell is used)~~
- [ ] ~~azureSandbox is set to true if Sandbox is needed~~
- [ ] ~~Knowledge checks are reviewed for spelling and accuracy~~

## Exercises
- [X] All exercise units have "Exercise -"  prefix on titles
