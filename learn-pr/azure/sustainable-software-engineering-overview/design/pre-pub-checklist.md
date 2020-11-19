# Pre-publication checklist
1. Metadata
1. Content/Media/assets
1. Index.yml
1. All other yml files
1. Exercises
  
## Metadata
- [x] is the uid set in all yml files?

### Content/Media/assets
- [x] Remove regions from urls
- [ ] Final images/screenshots are present
- [ ] Badge images are present
- [x] Verify Acrolinx score for all content (score > 80)

### Index.yml
- [x] *title* is set
- [x] *description* is set and follows guidelines (doesn't duplicate title)
- [x] *summary* is set and follows guidelines
- [x] *abstract* is set and lists objectives (no periods)
- [x] *prerequisites* are set
- [x] *ms.date* is set to publication date
- [x] *author* and *ms.author* are set
- [x] *ms.prod* is set to **learning-azure**
- [x] *iconUrl* is set and points to a valid svg
- [x] *badge* has *uid* child set to uid
- [x] all units are listed

### All other yml files
- [x] *uid* is set and matches index.yml
- [x] *title* is set
- [x] *description* is set and follows guidelines (doesn't duplicate title)
- [x] *ms.date* is set 
- [x] *author* and *ms.author* are set
- [x] *durationInMinutes are set and IS ACCURATE
- [ ] *interactive* is set to **bash** or **azure-portal** (if exercise)
- [ ] *azureSandbox* is set to true if needed
- [x]  Knowledge checks reviewed for spelling and accuracy

### Exercises
- [ ] All exercise units have *Exercise - * prefix on titles
