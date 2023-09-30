
# `GIT.md`
*- code formatting & more -*

## Commit Message Format
**Format** 
```ts
// <type>(<scope>): <subject>
// 
// <optional-body>
// 
// <optional-footer>
```
**Parameters**
- **required**
  - **type** - being one of [available type values](#available-type-values)
  - **subject** (short description of the change)
- (optional)
  - **scope**
  - **body** - if present a blank line has to precede it
  - **footer** - if present a blank line has to precede it



**Examples**  
> feat(billing): add automatic invoice backups

> fix(billing): add missing parameter to `getInvoice` function

> docs: add `README.md` file



**Available Type Values**
- **`breaking`**: A breaking change forcing semantic-release to create a new major version
- **`build`**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **`ci`**: Changes to our CI configuration files and scripts (examples: GitHub Actions, etc.)
- **`docs`**: Documentation only changes
- **`feat`**: A new feature
- **`fix`**: A bug fix
- **`perf`**: A code change that improves performance
- **`refactor`**: A code change that neither fixes a bug nor adds a feature
- **`test`**: Adding missing tests or correcting existing tests



## TODO
- [ ] add documentation for commit message scope values