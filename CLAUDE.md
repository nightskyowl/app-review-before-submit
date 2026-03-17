# CLAUDE.md — Project Rules for Contributors & AI Agents

This is `app-review-before-submit`: an open-source, AI-native compliance knowledge base for Apple App Store and Google Play review policies.
**Repo:** https://github.com/nightskyowl/app-review-before-submit
**License:** MIT
**Primary consumers:** AI coding agents (Claude Code, Cursor, Copilot, Antigravity, etc.) and human contributors

---

## What This Repo Is

A structured YAML knowledge base + AI agent skill that lets coding agents review app codebases against current Apple App Store Review Guidelines and Google Play Developer Program Policies before submission. Three components:

1. **Static YAML documents** — every policy rule with `code_signals`, `check_criteria`, `common_violations`, and framework-specific patterns
2. **SKILL.md** — 3-phase review skill (static analysis → live verification → compliance report)
3. **Update mechanism** — staleness detection via `last_verified` timestamps and community PRs

---

## Project Rules

### 1. YAML Schema Is Sacred

Every policy document MUST follow this exact schema. No exceptions. No markdown policy files.

```yaml
_meta:
  platform: "apple" | "google" | "shared"
  category: string                         # e.g., "safety", "privacy", "payments"
  source_url: string                       # Official source URL
  section_id: string                       # Platform's own section numbering
  last_verified: "YYYY-MM-DD"             # When this doc was last checked against source
  last_changed: "YYYY-MM-DD"             # When the actual policy last changed
  severity_if_violated: "rejection" | "warning" | "recommendation"
  version: string                          # e.g., "2026-03"

rules:
  - id: string                             # e.g., "apple-1.1.1" or "google-restricted-content-1"
    title: string
    summary: string                        # Plain language description
    check_criteria:                        # Boolean pass/fail — YES/NO questions only
      - string
    code_signals:                          # Grep-able patterns for AI agents
      - string
    common_violations:                     # Real rejection patterns
      - string
    platform_specific:                     # Only include where meaningful
      flutter:
        - string
      react_native:
        - string
      swift:
        - string
      kotlin:
        - string
    related_rules:                         # Cross-platform references
      - string                             # e.g., "google-privacy-4.1" or "apple-5.1.1"
    notes: string                          # Edge cases, interpretation guidance
```

### 2. Rule IDs Map to Official Numbering
- Apple: apple-{section}.{subsection}.{item} → e.g., apple-1.1.1, apple-2.3
- Google: google-{category}-{number} → e.g., google-restricted-content-1, google-privacy-4.1
- Never invent numbering that doesn't trace back to the official source

### 3. code_signals Must Be Actionable

These are what AI agents will grep for in codebases. They must be specific patterns, not vague descriptions.
Good:
- "Search for 'image_picker' or 'camera' package imports without corresponding content moderation service integration (e.g., no calls to a moderation API)"
- "Check Info.plist for NSCameraUsageDescription key — must exist if app uses camera"
- "Look for 'SKPaymentQueue' or 'StoreKit' imports to detect in-app purchase usage"

Bad:
- "Check if UGC is moderated" (too vague, not grep-able)
- "Make sure payments work correctly" (not a pattern)

### 4. check_criteria Must Be Boolean

Each item is a yes/no question that an AI agent can definitively answer.
Good:
- "Does the app include a privacy policy URL accessible from the app?"
- "Is NSCameraUsageDescription present in Info.plist if camera access is used?"
- "Does the app provide an account deletion mechanism if account creation exists?"

Bad:
- "The app should probably have a privacy policy" (not a question)
- "Privacy policy looks reasonable" (subjective)

### 5. last_verified Must Be Updated

Whenever you verify a document against its source_url, update the last_verified timestamp to today's date — even if the policy hasn't changed. This is how the staleness detection works.

### 6. Cross-References Are Critical

If an Apple rule has a Google equivalent (or vice versa), link them via related_rules. Examples:
- Apple's account deletion requirement ↔ Google's account deletion requirement
- Apple's IAP requirement ↔ Google's billing policy
- Apple's privacy nutrition labels ↔ Google's data safety section

### 7. Framework-Specific Sections Are Optional

Not every rule needs platform_specific entries. Only add them where there's a meaningful framework-specific check, file path, or configuration difference.

### 8. Common Rejections Are Gold

Prioritize adding real rejection patterns sourced from developer forums, Stack Overflow, and blog posts. These are more valuable than restated policy text because they tell you what actually triggers enforcement.

### 9. Never Auto-Merge Policy Updates

All policy changes require human review before merging, even if detected by automated tools. Open a PR, describe the change, reference the source.

---

## Repo Structure

```text
/
├── README.md
├── LICENSE (MIT)
├── CLAUDE.md (this file)
├── CONTRIBUTING.md
├── CHANGELOG.md
├── SKILL.md
├── metadata.json
│
├── .claude-plugin/
│   └── plugin.json
│
├── skills/
│   └── review-app/
│       └── SKILL.md
│
├── meta/
│   ├── sources.yaml
│   ├── last-updated.yaml
│   └── update-instructions.md
│
├── apple/
│   ├── review-guidelines/
│   │   ├── 1-safety.yaml
│   │   ├── 2-performance.yaml
│   │   ├── 3-business.yaml
│   │   ├── 4-design.yaml
│   │   └── 5-legal.yaml
│   ├── technical/
│   │   ├── app-signing.yaml
│   │   ├── entitlements.yaml
│   │   ├── info-plist-requirements.yaml
│   │   ├── privacy-manifest.yaml
│   │   ├── app-store-connect-metadata.yaml
│   │   └── platform-specifics/
│   │       ├── flutter-ios.yaml
│   │       ├── react-native-ios.yaml
│   │       └── swift-native.yaml
│   └── common-rejections.yaml
│
├── google/
│   ├── play-policy/
│   │   ├── restricted-content.yaml
│   │   ├── intellectual-property.yaml
│   │   ├── privacy-deception-device-abuse.yaml
│   │   ├── monetization-ads.yaml
│   │   ├── store-listing-promotion.yaml
│   │   ├── spam-minimum-functionality.yaml
│   │   ├── malware-mups.yaml
│   │   ├── families-policy.yaml
│   │   └── sdk-requirements.yaml
│   ├── technical/
│   │   ├── target-api-level.yaml
│   │   ├── permissions-declarations.yaml
│   │   ├── data-safety-section.yaml
│   │   ├── app-signing.yaml
│   │   ├── android-manifest-requirements.yaml
│   │   └── platform-specifics/
│   │       ├── flutter-android.yaml
│   │       ├── react-native-android.yaml
│   │       └── kotlin-native.yaml
│   └── common-rejections.yaml
│
└── shared/
    ├── privacy-checklist.yaml
    ├── payment-rules.yaml
    ├── content-rating.yaml
    ├── account-deletion.yaml
    ├── login-requirements.yaml
    └── pre-submission-checklist.yaml
```

---

## Coding Standards

- YAML files: 2-space indentation, no tabs, UTF-8 encoding
- Strings in YAML: Use double quotes for strings containing special characters; plain strings otherwise
- Line length: Keep YAML lines under 120 characters where possible; use YAML block scalars (| or >) for long text
- File naming: lowercase, hyphen-separated (e.g., privacy-deception-device-abuse.yaml)
- Markdown files: Standard GitHub-flavored markdown
- Commit messages: type: scope — description format
  - Types: setup, content, fix, update, docs, ci
  - Examples: content: apple-safety — add section 1.1 through 1.7, update: google-privacy — new data collection disclosure requirement

---

## Key Source URLs

- Apple App Store Review Guidelines: https://developer.apple.com/app-store/review/guidelines/
- Google Play Developer Program Policies: https://play.google/developer-content-policy/
- Apple Developer Documentation: https://developer.apple.com/documentation/
- Android Developer Documentation: https://developer.android.com/docs
- Google Play Console Help: https://support.google.com/googleplay/android-developer/

---

## Quality Checklist

Use this checklist when adding or reviewing any YAML file:

- `_meta` section is complete with all required fields
- `last_verified` is set to the date the content was verified against source
- All `rules[].id` values map to official platform numbering
- Every `check_criteria` item is a boolean yes/no question
- Every `code_signals` item is a grep-able, actionable pattern
- `common_violations` contain real-world rejection patterns (not just restated policy)
- `platform_specific` sections only exist where there's a meaningful difference
- `related_rules` cross-references point to valid rule IDs
- No duplicate rules across files
- YAML is valid (parseable, correct indentation, no syntax errors)
