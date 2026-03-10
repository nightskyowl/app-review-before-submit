# App Review Before Submit

AI-native compliance knowledge base for Apple App Store and Google Play review policies.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## What This Is

A structured YAML knowledge base + AI agent skill that lets coding agents review app codebases against current Apple App Store Review Guidelines and Google Play Developer Program Policies **before submission**.

**40 YAML policy files** covering:
- Apple App Store Review Guidelines (sections 1-5)
- Google Play Developer Program Policies (all categories)
- Cross-platform rules (privacy, payments, account deletion, content rating)
- Technical requirements (Info.plist, AndroidManifest, permissions, signing)
- Real-world common rejection patterns for both platforms
- Framework-specific checks for Flutter, React Native, Swift, and Kotlin

## Installation

### Claude Code (Plugin — recommended)

```bash
# Add this repo as a plugin marketplace
/plugin marketplace add nightskyowl/app-review-before-submit

# Install the plugin
/plugin install app-review-before-submit
```
Then in any app project, ask: "Review my app for store compliance before I submit" — Claude will auto-invoke the review-app skill.

### Claude Code (--add-dir)
```bash
# Clone the repo
git clone https://github.com/nightskyowl/app-review-before-submit.git

# Start Claude Code with the knowledge base loaded
claude --add-dir /path/to/app-review-before-submit
```

### Claude Code (Git submodule)
```bash
# Add to your project as a submodule
git submodule add https://github.com/nightskyowl/app-review-before-submit.git .claude/skills/app-review

# The skill auto-discovers from .claude/skills/
```

### Google Antigravity
```bash
# Global skill (available in all projects)
git clone https://github.com/nightskyowl/app-review-before-submit.git ~/.gemini/antigravity/skills/app-review-before-submit

# Or workspace-level
git clone https://github.com/nightskyowl/app-review-before-submit.git .agents/skills/app-review-before-submit
```
Antigravity auto-discovers the skill when you ask about app review, submission compliance, or store rejections.

### Cursor / Copilot / Other Agents
Clone the repo and point your agent to SKILL.md at the root. Any agent with file-read and grep capabilities can execute the 3-phase review against your codebase.
```bash
git clone https://github.com/nightskyowl/app-review-before-submit.git
```
Then ask your agent: "Follow the SKILL.md in app-review-before-submit to review my app for store compliance."

## How It Works
The skill runs a 3-phase review:

1. **Static Analysis** — Scans your codebase for code_signals matching policy risks (grep-able patterns like missing NSCameraUsageDescription, payment APIs without proper integration, UGC without moderation)
2. **Live Verification** — Checks URLs, metadata, and configurations that require external validation
3. **Compliance Report** — Generates a structured report with critical failures, warnings, and recommendations tied to specific rule IDs

## YAML Schema
Every policy file follows a strict schema so AI agents can parse it programmatically:

```yaml
_meta:
  platform: "apple" | "google" | "shared"
  category: "safety"
  source_url: "https://developer.apple.com/app-store/review/guidelines/"
  section_id: "1"
  last_verified: "2026-03-09"
  severity_if_violated: "rejection" | "warning" | "recommendation"

rules:
  - id: "apple-1.1.1"
    title: "Objectionable Content"
    summary: "Plain language description"
    check_criteria:
      - "Does the app contain UGC without moderation?"    # Boolean yes/no
    code_signals:
      - "Search for 'image_picker' imports without moderation API calls"  # Grep-able
    common_violations:
      - "App allows anonymous public posting without a reporting mechanism"
    platform_specific:
      flutter: [...]
      react_native: [...]
    related_rules:
      - "google-restricted-content-1"
```
See CLAUDE.md for the full specification.

## Repository Structure

```
/
├── .claude-plugin/          # Claude Code plugin manifest
│   └── plugin.json
├── skills/                  # Plugin skill directory
│   └── review-app/
│       └── SKILL.md
├── SKILL.md                 # Standalone skill (for non-plugin use)
├── CLAUDE.md                # Project rules & full YAML schema
├── metadata.json            # Machine-readable project metadata
│
├── apple/
│   ├── review-guidelines/   # Sections 1-5
│   ├── technical/           # Info.plist, signing, entitlements, platform-specifics
│   └── common-rejections.yaml
│
├── google/
│   ├── play-policy/         # All policy categories
│   ├── technical/           # Manifest, permissions, data safety, platform-specifics
│   └── common-rejections.yaml
│
├── shared/                  # Cross-platform rules
│   ├── privacy-checklist.yaml
│   ├── payment-rules.yaml
│   ├── content-rating.yaml
│   ├── account-deletion.yaml
│   ├── login-requirements.yaml
│   └── pre-submission-checklist.yaml
│
└── meta/                    # Sources & update tracking
    ├── sources.yaml
    ├── last-updated.yaml
    └── update-instructions.md
```

## Contributing
See CONTRIBUTING.md for how to add rules, report policy changes, and submit common rejection patterns.

## License
MIT
