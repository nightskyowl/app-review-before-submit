git add .
git restore --staged CHANGELOG.md
git commit -F commit_msg.txt
git push origin main
git add CHANGELOG.md
git commit -m "docs: changelog - add v0.1.0-beta release notes"
git push origin main
