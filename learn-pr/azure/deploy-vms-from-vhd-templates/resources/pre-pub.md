# Pre-publication checklist

Content/Media/assets

- [ ] Remove regions ("en-US") from URLs

- [ ] Final images/screenshots are present

- [ ] Badge images are present

- [ ] Verify Acrolinx score for all content (score > 80)

Index.yml

- [ ] Title is set and conforms to standards

- [ ] Description is set and follows guidelines (doesn't duplicate title)

- [ ] Summary is set and follows guidelines

- [ ] cardDescription is set if summary is more than 2 sentences

- [ ] Abstract is set and lists objectives (no periods)

- [ ] Prerequisites are set, or set to "None"

- [ ] ms.date is set to publication date

- [ ] Author and ms.author are set

- [ ] ms.prod is set to "learning-azure"

- [ ] iconUrl is set and points to a valid svg

- [ ] badge has uid child node and uses module UID + ".badge"

- [ ] all units are listed in the proper order

Unit YAML files

- [ ] uid is set and matches index.yml

- [ ] Title is set and conforms to standards

- [ ] ms.date is set to initial publish date

- [ ] Author and ms.author are set

- [ ] durationInMinutes is set to an accurate value

- [ ] interactive is set to bash or powershell (if cloud shell is used)

- [ ] azureSandbox is set to true if Sandbox is needed

- [ ]  Knowledge checks reviewed for spelling and accuracy

- [ ] ROBOTS: NOINDEX is in metadata block

Exercises

- [ ] All exercise units have "Exercise -"  prefix on titles

