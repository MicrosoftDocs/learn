# Pre-publication checklist
1. Metadata
1. Content/Media/assets
1. Index.yml
1. All other yml files
1. Exercises
  
## Metadata
- [X] is the uid set in all yml files?

### Content/Media/assets
- [ X] Remove locale from urls
- [ X] Final images/screenshots are present
- [X] Badge images are present
- [ X] Verify Acrolinx score for all content (score > 80)

### Index.yml
- [X ] *title* is set
- [ X] *description* is set and follows guidelines (doesn't duplicate title)
- [ x] *summary* is set and follows guidelines
- [x] *abstract* is set and lists objectives (no periods)
- [x ] *prerequisites* are set
- [X ] *ms.date* is set to publication date
- [x] *author* and *ms.author* are set
- [ x] *ms.prod* is set to **learning-azure**
- [ x] *iconUrl* is set and points to a valid svg
- [ x] *badge* has *uid* child set to uid
- [ x] all units are listed

### All other yml files
- [X ] *uid* is set and matches index.yml
- [ X] *title* is set
- [X ] *ms.date* is set 
- [X ] *author* and *ms.author* are set
- [ ] *durationInMinutes* is set and IS ACCURATE
- [n/a ] *interactive* is set to **bash** or **azure-portal** (if exercise)
- [n/a ] *azureSandbox* is set to true if needed
- [ n/x]  Knowledge checks reviewed for spelling and accuracy

### Exercises
- [X ] All exercise units have *Exercise - * prefix on titles
