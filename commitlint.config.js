
/**
 * @type {import('@commitlint/types').UserConfig}
 * 
 * Commit Message Guidelines
 * 
 * All commit message MUST follow https://github.com/angular/angular/blob/master/CONTRIBUTING.md#commit
 * 
 * Format as:
 * 
 * ```
 * <type>(<scope>): <subject>
 * <BLANK LINE>
 * <body>
 * <BLANK LINE>
 * <footer>
 * ```
 * Note: The **&lt;type&gt;** can be found in **./commitlint.config.js** file.
 */
module.exports = {
  rules: {
    'body-leading-blank': [1, 'always'],
    'footer-leading-blank': [1, 'always'],
    'header-max-length': [2, 'always', 72],
    'scope-case': [2, 'always', 'lower-case'],
    'subject-case': [2, 'never', ['sentence-case', 'start-case', 'pascal-case', 'upper-case']],
    'subject-empty': [2, 'never'],
    'subject-full-stop': [2, 'never', '.'],
    'type-case': [2, 'always', 'lower-case'],
    'type-empty': [2, 'never'],
    'type-enum': [2, 'always', [
      'breaking',   // A commit that is tagged with breaking will be used by semantic-release to create a major release.

      'build',      // Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
      'ci',         // Changes to our CI configuration files and scripts (examples: GitHub Actions, etc.)
      'docs',       // Documentation only changes
      'feat',       // A new feature
      'fix',        // A bug fix
      'perf',       // A code change that improves performance
      'refactor',   // A code change that neither fixes a bug nor adds a feature
      'test',       // Adding missing tests or correcting existing tests
    ]],
  },
};
