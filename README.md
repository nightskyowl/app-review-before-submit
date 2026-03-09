# AI-native compliance knowledge base for Apple App Store and Google Play review policies

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## What This Is
A structured YAML knowledge base + AI agent skill that lets coding agents review app codebases against current Apple App Store Review Guidelines and Google Play Developer Program Policies before submission.

## Who It's For
AI coding agents (Claude Code, Cursor, Copilot, Antigravity, etc.)

## Quick Start
To see how an AI agent uses this repository, read [SKILL.md](SKILL.md) for the 3-phase review skill (static analysis → live verification → compliance report).

## Repository Structure
```
/
├── README.md
├── LICENSE (MIT)
├── CLAUDE.md
├── ANTIGRAVITY.md
├── CONTRIBUTING.md
├── CHANGELOG.md
├── SKILL.md
├── metadata.json
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

## YAML Schema
Every policy document MUST follow the exact schema defined in [CLAUDE.md](CLAUDE.md) so AI agents can parse it seamlessly.

**Example Overview:**
```yaml
_meta:
  platform: "apple"
  category: "safety"
  source_url: "https://developer.apple.com/app-store/review/guidelines/"
  section_id: "1"
  last_verified: "2026-03-09"
  last_changed: "2026-03-09"
  severity_if_violated: "rejection"
  version: "2026-03"

rules:
  - id: "apple-1.1.1"
    title: "Objectionable Content"
    summary: "Apps should not include content that is offensive, insensitive, upsetting, intended to disgust, in exceptionally poor taste, or just plain creepy."
    check_criteria:
      - "Does the app contain user-generated content without moderation?"
    code_signals:
      - "Search for 'image_picker' or 'camera' package imports without corresponding content moderation service integration"
    common_violations:
      - "App allows users to post anonymous public content without a reporting mechanism"
```
Read [CLAUDE.md](CLAUDE.md) for the full specification.

## How to Contribute
View [CONTRIBUTING.md](CONTRIBUTING.md) (coming soon) for details on how to add new rules, common rejection patterns, and keep the knowledge base up-to-date.

## License
MIT

## Repo URL
https://github.com/nightskyowl/app-review-before-submit
