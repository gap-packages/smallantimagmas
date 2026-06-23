---
description: Rules for pinning GitHub Actions to full commit SHAs.
applyTo:
  - ".github/workflows/**"
---

# GitHub Actions Pinning

- Always pin actions to a full commit SHA instead of a tag or branch name.
- Use the format `owner/action@<full-sha>` with a comment indicating the resolved version.

## Example

```yaml
# Good
- uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2

# Bad
- uses: actions/checkout@v4
- uses: actions/checkout@main
```
