# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-03-10

### Added
- Claude Code plugin packaging (`.claude-plugin/plugin.json`) for one-command installation
- Plugin skill directory (`skills/review-app/SKILL.md`) with `${CLAUDE_PLUGIN_ROOT}` path references
- Comprehensive installation instructions in README for 5 patterns: plugin marketplace, --add-dir, git submodule, Antigravity, Cursor/Copilot

### Changed
- README rewritten with concrete install commands for all supported agent platforms
- Repository structure in CLAUDE.md updated to include new plugin directories

## [1.0.0] - 2026-03-09

### Added
- Initial release of the app-review-before-submit knowledge base
- Apple App Store Review Guidelines (Sections 1-5) — 5 YAML files
- Google Play Developer Program Policies (9 categories) — 9 YAML files
- Shared cross-platform rules — 6 YAML files
- Technical requirements — 16 YAML files (8 Apple + 8 Google)
- Common rejections — 2 YAML files (Apple + Google)
- SKILL.md — 3-phase AI agent review skill
- metadata.json — skill registration metadata
- Meta files: sources.yaml, last-updated.yaml, update-instructions.md
