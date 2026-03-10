---
name: review-app
description: Review your app codebase against current Apple App Store and Google Play review policies before submission. Use when preparing to submit an app, checking compliance, diagnosing rejections, or auditing store policy adherence.
allowed-tools: Read, Grep, Glob, WebFetch
---

# App Review Compliance Check

Review this app codebase against current Apple App Store Review Guidelines and Google Play Developer Program Policies.

## Knowledge Base Location

All policy rules are in YAML files within this plugin's directory:
- `${CLAUDE_PLUGIN_ROOT}/apple/review-guidelines/` — Apple sections 1-5 (Safety, Performance, Business, Design, Legal)
- `${CLAUDE_PLUGIN_ROOT}/apple/technical/` — Info.plist, entitlements, privacy manifest, app signing, platform-specifics
- `${CLAUDE_PLUGIN_ROOT}/apple/common-rejections.yaml` — Real-world Apple rejection patterns
- `${CLAUDE_PLUGIN_ROOT}/google/play-policy/` — All Google Play policy categories
- `${CLAUDE_PLUGIN_ROOT}/google/technical/` — Manifest, permissions, data safety, API level, platform-specifics
- `${CLAUDE_PLUGIN_ROOT}/google/common-rejections.yaml` — Real-world Google rejection patterns
- `${CLAUDE_PLUGIN_ROOT}/shared/` — Cross-platform: privacy, payments, content rating, account deletion, login, pre-submission checklist

## Phase 1: Static Analysis

1. Identify target platforms from project files:
   - iOS: `*.xcodeproj`, `Podfile`, `Package.swift`, `Info.plist`
   - Android: `build.gradle`, `AndroidManifest.xml`
   - Flutter: `pubspec.yaml` + both platform dirs
   - React Native: `package.json` with `react-native` dep + both platform dirs

2. Load relevant YAML policy files from the knowledge base paths above.

3. Execute every `code_signals` entry against the user's codebase using grep/search.

4. Evaluate every `check_criteria` as pass/fail based on code evidence.

5. Flag any `common_violations` patterns found.

## Phase 2: Live Verification

1. Verify all URLs are live (privacy policy, support URL, terms of service)
2. Check that test/demo accounts are documented in review notes
3. Validate store metadata (title length, no promotional keywords, correct category)
4. Confirm age rating questionnaire answers match app content

## Phase 3: Compliance Report

Generate a structured report:
App Review Compliance Report
Platform(s) detected: [iOS, Android, Flutter, React Native]
Total rules checked: [X] / Passed: [Y] / Failed: [Z] / Needs manual review: [W]
Critical failures (rejection-likely)
[Rule ID] - [Title]
What was found: [Evidence from code]
What needs to change: [Actionable fix]
Warnings
[Rule ID] - [Title]
What was found: [Evidence]
What needs to change: [Mitigation]
Recommendations
[Rule ID] - [Title]
What was found: [Evidence]
What needs to change: [Suggestion]
