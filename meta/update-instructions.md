# Update Instructions

This guide explains how to keep the compliance knowledge base current.

## How to check for policy changes
1. Visit the official source URLs listed in `meta/sources.yaml`.
2. Compare the current online policy with our documented rules.

## How to update a YAML file when a policy changes
1. Locate the correct YAML file for the updated policy.
2. Modify the `rules` array to reflect the new or changed policy.
3. Update the `_meta` section fields: `last_verified` and `last_changed`.

## `last_verified` vs `last_changed`
- **`last_verified`**: The date you checked the source URL, even if the policy hasn't changed.
- **`last_changed`**: The date when the actual policy at the source URL was last updated.

## Staleness detection
Files with a `last_verified` date older than 90 days are considered **stale**. We have processes that automatically flag these for review.

## PR process
- **Never auto-merge** policy changes. Every change requires human review.
- Always include a description of the change and reference the official source URL in your Pull Request.

## Adding a new rule to an existing file
1. Follow the YAML schema outlined in `CLAUDE.md`.
2. Ensure the `id` maps to the official numbering.
3. Add actionable `code_signals` and ensure `check_criteria` are boolean yes/no questions.
4. Update cross-references (`related_rules`) if applicable.

## Adding an entirely new policy file
1. Create the new file in the appropriate directory following our lowercase, hyphen-separated naming convention (e.g., `new-policy.yaml`).
2. Implement the standard `_meta` header and `rules` array structure.
3. Update `meta/last-updated.yaml` with the new file using `null` as the initial verification state, or the current date if you are verifying it immediately.
