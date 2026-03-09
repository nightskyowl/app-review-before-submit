# Contributing to app-review-before-submit

First off, thank you for considering contributing to `app-review-before-submit`! This knowledge base relies on community contributions to stay accurate as app store policies evolve.

## Reporting a Policy Change

If you notice a policy change or a new rule that isn't reflected in our repository:
1. Open a new Issue.
2. Provide the exact source URL where the policy change is documented (e.g., Apple Developer News, Google Play Policy Updates).
3. Briefly describe what changed.

## Submitting a Policy Update PR

To submit a direct update to the policy YAML files:
1. Fork the repository.
2. Edit the relevant YAML file(s).
3. Update the `last_verified` and (if applicable) `last_changed` timestamps in the `_meta` section.
4. Submit a Pull Request with a clear description of the change and the source URL.

## YAML Schema Requirements

Every policy document **must** follow the exact schema defined in [CLAUDE.md](CLAUDE.md). Please do not submit markdown versions of the policy files or alter the YAML schema, as this repository is designed to be consumed programmatically by AI agents.

## How to Add a New Rule vs. Update an Existing Rule

- **Updating an existing rule**: Modify the existing yaml item within the `rules` array. Always ensure that you update `last_verified`. Add any new `common_violations` you have encountered.
- **Adding a new rule**: Append a new rule block to the `rules` array. Make sure the ID maps to the official numbering (e.g., `apple-2.5.1` or `google-privacy-3`), and provide comprehensive `code_signals` and `check_criteria`.

## Quality Checklist for PRs

Before submitting your PR, ensure every modified or added YAML rule meets this checklist:

- [ ] `_meta` section is complete with all required fields
- [ ] `last_verified` is set to the date the content was researched
- [ ] All `rules[].id` values map to official platform numbering
- [ ] Every `check_criteria` item is a boolean yes/no question
- [ ] Every `code_signals` item is a grep-able, actionable pattern
- [ ] `common_violations` contain real-world rejection patterns (not just restated policy)
- [ ] `platform_specific` sections only exist where there's a meaningful difference
- [ ] `related_rules` cross-references point to valid rule IDs
- [ ] No duplicate rules across files
- [ ] YAML is valid (parseable, correct indentation, no syntax errors)

## Commit Message Format

Please follow this commit message format: `type: scope — description`

- **Types**: `setup`, `content`, `fix`, `update`, `docs`, `ci`
- **Scope**: The file or policy area you are modifying
- **Examples**: 
  - `content: apple-safety — add section 1.1 through 1.7`
  - `update: google-privacy — new data collection disclosure requirement`

## Code of Conduct

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms. We adhere to the [Contributor Covenant](https://www.contributor-covenant.org/).
