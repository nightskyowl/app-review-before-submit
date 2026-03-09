---
name: App Review Compliance Check
description: AI-native compliance knowledge base and review skill for Apple App Store and Google Play developer policies. Scans app codebases against current review guidelines and generates a compliance report before submission.
---

# App Review Compliance Check

This skill executes a pre-submission compliance check for iOS, Android, Flutter, and React Native apps against the latest Apple App Store and Google Play review guidelines.

## Prerequisites

- The agent must have access to the app's source code
- The agent should know the target platform(s): iOS, Android, or both

## Phase 1: Static Analysis

Scan the codebase against policy rules to find compliance issues before submission.

### Steps:
1. Identify target platforms from project files:
   - iOS: Check for `*.xcodeproj`, `Podfile`, `Package.swift`, `Info.plist`
   - Android: Check for `build.gradle`, `AndroidManifest.xml`
   - Flutter: Check for `pubspec.yaml` + both platform dirs
   - React Native: Check for `package.json` with `react-native` dep + both platform dirs

2. For each detected platform, load the relevant YAML policy files from this repo:
   - **Apple**: Load all files in `apple/review-guidelines/` (e.g., `apple/review-guidelines/1-safety.yaml`)
   - **Google**: Load all files in `google/play-policy/` (e.g., `google/play-policy/restricted-content.yaml`)
   - **Shared**: Load all files in `shared/` (e.g., `shared/privacy-checklist.yaml`)

3. Execute every `code_signals` entry against the codebase using grep/search. Example patterns:
   - `grep -r "requestTrackingAuthorization" .` (for Apple ATT checks)
   - `grep -r "ACCESS_FINE_LOCATION" .` (for Android precise location checks)
   - `grep -E "\.requestPayment|\.buyItem" .` (for payment method checks)

4. Evaluate every `check_criteria` as pass/fail based on code evidence.
5. Flag any `common_violations` patterns found (e.g., custom payment links in digital-goods apps).

## Phase 2: Live Verification

Execute checks that require external validation, runtime configurations, or manual inspection.

### Steps:
1. Verify all URLs are live (privacy policy, support URL, terms of service)
2. Check that test/demo accounts are documented in review notes
3. Validate that screenshots match actual app screens
4. Confirm age rating questionnaire answers match app content
5. Verify store metadata (title length, no promotional keywords, correct category)

## Phase 3: Compliance Report

Generate the final output of the review to present to the user.

### Report Format:
Follow this structured markdown format so the developer can easily act on the findings:

# App Review Compliance Report

- **Platform(s) detected:** [e.g., iOS, Android (React Native)]
- **Total rules checked:** [X] / **Passed:** [Y] / **Failed:** [Z] / **Needs manual review:** [W]

### 🚨 Critical failures (rejection-likely)
*(List immediate blockers first)*
- **[Rule ID]** - **[Title]**
  - **What was found:** [Evidence from code/live check]
  - **What needs to change:** [Actionable fix based on `check_criteria`]
  - *(Highlight cross-platform issues if rule is from `shared/`)*

### ⚠️ Warnings
*(List potential issues that might trigger a rejection depending on the reviewer)*
- **[Rule ID]** - **[Title]**
  - **What was found:** [Evidence]
  - **What needs to change:** [Mitigation]

### 💡 Recommendations
*(List best practices or missing optimal configurations)*
- **[Rule ID]** - **[Title]**
  - **What was found:** [Evidence]
  - **What needs to change:** [Suggestion]
