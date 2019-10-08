# Pre-publication checklist
1. Metadata
1. Content/Media/assets
1. Index.yml
1. All other yml files
1. Exercises
  
## Metadata
- [X] is the uid set in all yml files?

### Content/Media/assets
- [X] Remove regions from urls
- [X] Final images/screenshots are present
- [X] Badge images are present
- [X] Verify Acrolinx score for all content (score > 80)

### Index.yml
- [X] *title* is set
- [X] *description* is set and follows guidelines (doesn't duplicate title)
- [X] *summary* is set and follows guidelines
- [X] *abstract* is set and lists objectives (no periods)
- [X] *prerequisites* are set
- [X] *ms.date* is set to publication date
- [X] *author* and *ms.author* are set
- [X] *ms.prod* is set to **learning-azure**
- [X] *iconUrl* is set and points to a valid svg
- [X] *badge* has *uid* child set to uid
- [X] all units are listed

### All other yml files
- [X] *uid* is set and matches index.yml
- [X] *title* is set
- [X] *ms.date* is set 
- [X] *author* and *ms.author* are set
- [X] *durationInMinutes* is set and IS ACCURATE
- [X] *interactive* is set to **bash** or **azure-portal** (if exercise)
- [X] *azureSandbox* is set to true if needed
- [X]  Knowledge checks reviewed for spelling and accuracy
- [X] *ROBOTS: NOINDEX*

### Exercises
- [X] All exercise units have *Exercise - * prefix on titles
